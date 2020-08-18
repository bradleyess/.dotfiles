#!/bin/bash

createVideoFromImageAndAudio()  {
    imageFile=$1
    audioFile=$2
    title=$3

    ffmpeg -loop 1 -i "$imageFile" -i "$audioFile" -c:v libx264 -c:a aac -shortest "$title.mp4"
}