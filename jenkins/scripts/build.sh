#!/usr/bin/env bash

# scp target/${NAME}-${VERSION}.jar ${REMOTE_USER}@${REMOTE_SERVER}:/home/ubuntu
set -x
scp -o StrictHostKeyChecking=no target/*.jar ubuntu@18.141.186.62:/home/ubuntu

# scp target/${NAME}-${VERSION}.jar
# ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_SERVER}:/home/ubuntu
