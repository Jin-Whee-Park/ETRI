#!/bin/sh

IMAGE_NAME=best888810/motion:1.0
VIDEO_DIRECTORY=/root/CatDog/sender/videos

mkdir -p $VIDEO_DIRECTORY
docker run -d --device=/dev/video0:/dev/video0 -v $VIDEO_DIRECTORY:/mnt/motion -p 8081:8081 $IMAGE_NAME
