# ==========
#
# ==========

terraformValidate() {
    docker run --rm -v $(pwd):/terraform_validate terraform_validate "$@";
}

showLargestFilesInGit(){
    git rev-list --objects --all \
    | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
    | grep -vF "$(git ls-tree -r HEAD | awk '{print $3}')" \
    | sed -n 's/^blob //p' \
    | awk '$2 >= 2^20' \
    | sort --numeric-sort --key=2 \
    | cut -c 1-12,41- \
    | gnumfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}

findAndReplace(){
  # Usage :
  # find = $1
  # replace = $2
  ag -0 -l $1 | xargs -0 gsed -ri.bak -e "s/$1/$2/g"
}

touchie(){
    mkdir -p "${$*%/*}"
    touch "$*"
}

mergeCommitFeature() {
  mergeTo = $1;
  mergeFrom = $2;
  commitMessage = $3;

  git checkout $1 && git merge $2 && git add . && git commit -m "$3" && git push && git checkout $2;
}


# Generate S3 Bucket Policy
# Usage : s3Policy($bucketname)
s3Policy() {
  bucket=$1;
  touch "$bucket"-policy.json
  echo "{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket",
                "s3:DeleteObject",
                "s3:Put*",
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": [
                "arn:aws:s3:::$bucket",
                "arn:aws:s3:::$bucket/*"
            ]
        }
    ]
  }" > "$bucket"-policy.json;
  pbcopy < "$bucket"-policy.json;
  rm "$bucket"-policy.json;
}


# WPSCAN
WPScanLog() {
  # Usage - WPScanLog($DOMAINNAME.COM)
  now="$(date +%m-%d-%Y)";
  domain=$1;
  # Create the domain directory
  mkdir ~/wp-scan-logs/$domain && directory=~/wp-scan-logs/$domain;
  cd $directory && touch log-$now.txt && destination=$directory/log-$now.txt;
  docker run -it --rm -v $destination:/wpscan/output.txt wpscanteam/wpscan -f --update --follow-redirection -e p u -r --no-banner --batch -u $1 --log /wpscan/output.txt
}

# ---------------
# FILE MANAGEMENT
# ---------------

# TODO - Make a to kebabcase any input name.
# kebabCase() {
#   # Make all uppercase lowercase.
#   sed -e 's/\([A-Z]\)/-\L\1/g' -e 's/^-//'  <<< "$1"
# }

removeFromName() {
    #Usage : removeFromName $substring $filetype
    rename 's/$1//' *$1*.$2
}

# -------------
# WEB
# -------------

# whois a domain or a URL
whois() {
  local domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
  if [ -z $domain ] ; then
    domain=$1
  fi
  echo "Getting whois record for: $domain …"
  /usr/bin/whois -h whois.internic.net $domain | sed '/NOTICE:/q'
}

# -------------
# GIT
# -------------

searchLogs() {
  git log --all --grep='$1'
}


# List git branches on the local machine sorted by recent updates, adding a star to remote tracking branches
branches() {
  RED="\e[91m";
  for branch in $(git branch | sed s/^..//); do
    time_ago=$(git log -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $branch --);
    # Add a red star to mark branches that are tracking something upstream
    tracks_upstream=$(if [ "$(git rev-parse $branch@{upstream} 2>/dev/null)" ]; then printf "$RED★"; fi);
    printf "%-53s - %s %s\n" $time_ago $branch $tracks_upstream;
  done | sort;
}

# ----------------------------
# VIDEO/AUDIO/IMAGE CONVERSION
# ----------------------------

# Reduce size of video whilst retaining quality
shrinkVideo() {
  # Usage : shrinkVideo ($FILETOSHRINK, $MAXWIDTH, $OUTPUTNAME)
  ffmpeg -i "$1" -s "$2" -b:v 512k -vcodec libx264 -acodec copy "$3"
}

# Resize Image
resizeImage() {
  # Usage : optimiseImage ($FILETOSHRINK, $QUALITY[1-100], $MAXWIDTH)
  convert "$1" -strip -quality 100 -resize ${2:-100%} "$1".jpeg
}

# Reduce size of video whilst retaining quality
optimiseImage() {
  # Usage : optimiseImage ($FILETOSHRINK, $QUALITY[1-100], $MAXWIDTH)
  convert "$1" -strip -quality $2 -resize ${3:-100%} "$1".jpeg
}

optimiseImages() {
  setopt -s nullglob
  for IMAGE in *.[Jj][Pp][Gg] *.[Jj][Pp][Ee][Gg] *.[Pp][Nn][Gg];
    do convert "$IMAGE"  -strip -quality 100 -resize $1\> resized-"$IMAGE";
  done
}


cropAllFromCenter() {
  # Usage : cropAllFromCenter ($QUALITY[1-100], $MAXWIDTH)
  setopt -s nullglob
  for X in *.[Jj][Pp][Gg] *.[Jj][Pp][Ee][Gg] *.[Pp][Nn][Gg];
    do convert $X -resize "$1x$2^" -gravity Center -crop "$1x$2+0+0" $X
  done
}

# -----------------------
# IMAGEMAGICK
# -----------------------

# Crop image from center
cropFromCenter() {
  convert $1 -resize "$2x$3^" -gravity Center -crop "$2x$3+0+0" $1
}

# Split an image into perfect halves horizontally
halveImage() {
    convert $1 -crop 50%x100% +repage $1_horizontal_%d.jpg
    }

# Split an image into quadrants
quadImage() {
    convert $1 -crop 25%x25% +repage $1_%d.jpg
}

# Rotate an Image
# Usage rotateImage $OG, $DESTINATION $ROTATEDEGREES
rotateImage() {
    convert -rotate $3 $1 $2
}

trimVideo(){
    # Usage trimVideo $FILENAME $LENGTH
    mencoder -ss $2 -oac pcm -ovc copy $1 -o TRIM$1
}



# turn that video into webm.
# brew reinstall ffmpeg --with-libvpx
webmify () {
  ffmpeg -i "$1" -vcodec libvpx -acodec libvorbis -isync -copyts -aq 80 -threads 3 -qmax 30 -y "$2" "$1.webm"
}

# Convert Audio file to video file with image as visual.
# Usage : audioToVideo($image, $audio, $outputname NOTE: Do not provide extension)
audioToVideo(){
	(ffmpeg -loop 1 -i $1 -i $2 -c:v libx264 -preset ultrafast -crf 0 -b:a 384k -shortest $3.mp4)
}

# Convert Video file to audio file.
# Usage : videoToAudio($video, $audio)
videoToAudio(){
  (ffmpeg -i $1 -f mp3 -ab 256000 -vn $2)
}

makeFLAC() {
  (xld -ce -o . $1 -f flac)
}

makeMP3() {
    (xld -ce -o . $1 -f mp3)
}

makeAIFF() {
  for filename in *.flac
    do (ffmpeg -i ${filename} ${filename%.aiff})
  done;
}

makeFLAC() {
  for f in *.aiff; do ffmpeg -i "$f" "${f%.aiff}.flac"; done
}

# makeMP3() {
#   mkdir mp3;
#   for filename in ./*.{aif,aiff,wav,flac}
#     do
#       xld -c -e -o mp3/$filename -f mp3
#     done
# }

# makeMP3() {
#   shopt -s nullglob
#   shopt -s nocaseglob
#   for filename in .**/*.{aif,aiff,wav,flac}
# do
#     (xld -ce -o . $1 -f mp3)
# done
#   shopt -u nocaseglob
#   shopt -u nullglob
# }


# ------------
# KINDLE STUFF
# ------------

#TODO - Make a single for converting PDF or EPUB to MOBI
# then send to Kindle.

makeEpub(){
  (ebook-convert $1 $2.epub)
}


emailToKindle ()
 {
    echo 'y' | mutt -s 'New eBook' money_137@kindle.com money_4dce02@kindle.com money_b84a40@kindle.com -a $1;
    echo 'Sent to Kindle.'
 }


## -----------------------------
# COMPOSER
## -----------------------------
# Usage : freshRequire $PACKAGE $DOMAIN.COM $ENVIRONMENT
freshRequire() {
  composer remove $1;
  composer clear-cache; rm -rf ~/.composer/cache;

  composer require $1;

  git add . ; git commit -m "fresh installation of $1"; git push;

  ansible "web:&production" -m command -a "composer clear-cache" -u web
  ansible-playbook deploy.yml -e env=$3 -e site=$2 -e 'project_copy_folders=[]'
}

# List only files of a particular extension
# Usage : e.g lsext js or lsext php
lsext()
{
  find . -type f -iname '*.'${1}'' -exec ls -l {} \; ;
}

# Find shorthand
f() {
  find . -name "$1" 2>&1 | grep -v 'Permission denied'
}

convertJSONToElasticSearch() {
    INDEX=$1;
    TYPE=$2;

    for FILE in ./*.json
    do
        cat $FILE | jq -c '.[] | {"index": {"_index": "entrants", "_type": "entrant", "_id": .id}}, .' > $FILE.es.json
    done
}

bulkImportToElasticSearch() {
    URL=$1; USERNAME=$2; PASSWORD=$3;

    for FILE in ./*.json
    do
        curl -s --silent --output /dev/null -H "Content-Type: application/x-ndjson" --user bradley:MIDnight323mji! -XPOST $URL --data-binary @$FILE;
        sleep 3;
    done
}

addIpToLinktreeStaffFirewall() {
    IP_ADDRESS=$1;
    aws waf-regional update-ip-set --region us-west-2 --ip-set-id a08c1f19-7bb4-4a98-86de-b4ee9821a8b8 --change-token $(aws waf-regional get-change-token --region us-west-2 | jq .ChangeToken | cut -d '"' -f2) --updates Action="INSERT",IPSetDescriptor="{Type=\"IPV4\",Value=\"$IP_ADDRESS/32\"}"
}
