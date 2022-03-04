#!/bin/sh

MAJOR=1
DATE=$(date +"%y.%-U")

if [ ! $(git tag -l v${MAJOR}.${DATE}.*) ]; then
    echo "Creating initial tag"
    git tag v${MAJOR}.${DATE}.1
else
    echo "Checking if this commit already has a tag"
    if [ ! $(git describe --tags --exact-match $(git log -1 --format="%H")) ]; then
        TAG=$(git describe --tags --exact-match $(git log -1 --format="%H"))

        MINOR=$(($(echo $TAG | cut -d. -f4)+1))
        git tag v${MAJOR}.${DATE}.${MINOR}
    else
        echo "Already found a tag for this version, not tagging"
        exit 1
    fi
fi
