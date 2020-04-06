#!/bin/sh

IMAGE_NAME=best888810/sender:fromdocker
VIDEO_DIRECTORY=/root/CatDog/sender/videos
docker run -d -v $VIDEO_DIRECTORY:/sender/videos --net=host $IMAGE_NAME  
#python sender.py
