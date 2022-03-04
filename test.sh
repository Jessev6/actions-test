#!/bin/sh

MAJOR=1
DATE=$(date +"%y.%-U")

echo "Latest tag:"

if git tag --sort=creatordate -l "v${MAJOR}.${DATE}.*" | tail -1; then
    echo
    echo "Tags for current commit:"
    if git describe --tags --exact-match $(git log -1 --format="%H"); then
        echo
        echo "ERROR: Existing tags for current commit, not tagging"
        exit 1

    else
        TAG=$(git tag --sort=creatordate -l "v${MAJOR}.${DATE}.*" | tail -1)
        MINOR=$(($(echo $TAG | cut -d. -f4)+1))

        echo
        echo "Tagging with v${MAJOR}.${DATE}.${MINOR}"
        git tag v${MAJOR}.${DATE}.${MINOR}
    fi
else
    echo "Creating initial tag"
    git tag v${MAJOR}.${DATE}.1
fi
