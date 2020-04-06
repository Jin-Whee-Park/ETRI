#!/bin/sh

IMAGE_NAME=best888810/tensorflow:1.0
Image_Directory=/root/tensorflow/cat_dog/data/classify

docker run -d -v $Image_Directory:/app/data/classify -p 5000:5000 $IMAGE_NAME
