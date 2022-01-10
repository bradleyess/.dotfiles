#!/bin/bash

createVideoFromImageAndAudio() {
    imageFile=$1
    audioFile=$2
    title=$3
    ffmpeg -loop 1 -i "$imageFile" -i "$audioFile" -c:v libx264 -c:a aac -shortest "$title.mp4"
}

convertAacAndImageToVideo() {
    imageFile=$1
    audioFile=$2
    title=$(echo "$audioFile" | cut -f 1 -d '.' -f 2)

    ffmpeg -nostdin -loop 1 -framerate 1 \
        -i "$imageFile" \
        -i "$audioFile" \
        -c:v libx264 -crf 0 \
        -c:a copy -shortest \
        "$title.mp4"
}

convertAllM4aToVideo() {
    for i in *.m4a; do
        [ -f "$i" ] || break
        convertAacAndImageToVideo artwork.png "$i"
    done
}

createVideoFromImageAndAudioMap() {
    imageFile=$1

    for i in *.wav; do
        [ -f "$i" ] || break
        name=$(echo "$i" | cut -f 1 -d '.')
        ffmpeg -loop 1 -i "$imageFile" -i "$i" -c:v libx264 -c:a aac -shortest "$name.mp4"
    done
}

uploadVideoToYouTube() {
    title=$1
    description="$2" # Pass description in from .txt file
    tags="$3"        # Pass tags as comma seperated string
    videoFilePath=$4
    playlistName=$5

    clientSecretsPath=$6

    youtube-upload \
        --title="$title" \
        --description="$description" \
        --category="Music" \
        --tags="$tags" \
        --default-language="en" \
        --default-audio-language="en" \
        --playlist="$playlistName" \
        --privacy="private" \
        --client-secrets "$clientSecretsPath" \
        "$videoFilePath"
}

uploadVideoToYouTubeMap() {
    description="$1"
    tags="$2"
    playlistName="$3"
    clientSecretsPath="$4"

    for i in *.mp4; do
        [ -f "$i" ] || break
        name=$(echo "$i" | cut -f 1 -d '.')
        uploadVideoToYouTube "$name" "$description" "$tags" "$i" "$playlistName" "$clientSecretsPath"
    done
}
