#!/bin/bash

VOLUME="$(pwd)"
NAME='mongodb'
PORT='28000'
VERSION='latest'

while getopts c:v:n:p:version option
do
case "${option}" in
c) COMMAND=${OPTARG};;
v)
if [ -n ${OPTARG} ]; then
    VOLUME=${OPTARG}
fi
;;
n)
if [ -n "${OPTARG}" ]; then
    NAME=${OPTARG}
fi
;;
p)
if [ -n "${OPTARG}" ]; then
    PORT=${OPTARG}
fi
;;
version)
if [ -n "${OPTARG}" ]; then
    VERSION=${OPTARG}
fi
;;
esac
done

echo "COMMAND=$COMMAND | NAME=$NAME | VOLUME=$VOLUME | PORT=$PORT | VERSION=$VERSION"


if [ -z "$COMMAND" ]; then
    echo "Invalid command line argument. Check arguments following after -s"
    exit 1
fi

if [ "$COMMAND" = "go" ]; then
    echo "docker run -it -p ${PORT}:27017 -v ${VOLUME}:/etc/mongo --name ${NAME} mongo:${VERSION} mongo"
    docker run -it -p ${PORT}:27017 -v ${VOLUME}:/etc/mongo --name ${NAME} mongo:${VERSION}
fi

if [ "$COMMAND" = "god" ]; then
    echo "docker run -d -p ${PORT}:27017 -v ${VOLUME}:/etc/mongo --name ${NAME} mongo:${VERSION} mongo"
    docker run -d -p ${PORT}:27017 -v ${VOLUME}:/etc/mongo --name ${NAME} mongo:${VERSION}
fi

if [ "$COMMAND" = "rm" ]; then
    docker stop ${NAME}
    docker rm ${NAME}
fi

echo '...'