#!/bin/bash

createVideoFromImageAndAudio()  {
    imageFile=$1
    audioFile=$2
    title=$3

    ffmpeg -y -i "$imageFile" -i "$audioFile" -vcodec libx264 -tune stillimage -acodec aac "$title.mp4"
}