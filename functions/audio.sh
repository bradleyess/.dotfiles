#!/bin/bash

exifGetTitleFromTags() {
    echo exiftool -j "$1" | jq -r '.[].Album'
}

exifGetArtistFromTags() {
    echo exiftool -j "$1" | jq -r '.[].Artist'
}

exifGetAlbumFromTags() {
    echo exiftool -j "$1" | jq -r '.[].Album'
}

buildTitleArtistAlbumObject() {
    exiftool -j "$1" | jq -r '.[] | { title: .Title, artist: .Artist, album: .Album }'
}

getArtworkFromDiscogs() {
    [ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
    artist=$(cat $input | jq -r '.artist')
    album=$(cat $input | jq -r '.album')

    curl "$(
        curl --request GET \
            --url "https://api.discogs.com/database/search?artist=$artist&release_title=$album" \
            --header 'authorization: Discogs key=sOKrXQKkYUVXszuBShNN, secret=iOMqutIPnXhncAHaQnLcLKeNYSdajPBc' |
            jq -r '.results[0].cover_image'
    )" >cover.jpg
}

convertToAiff() {
    file="$1"
    destination="$2"

    xld -o "$HOME/$destination" $file -f aif
}
