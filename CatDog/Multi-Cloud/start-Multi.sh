#!/bin/bash

# AWS VM 생성 과정
./aws-create-resource.sh
sleep 10
# GCP VM 생성 과정
./gcp-create-resource.sh
