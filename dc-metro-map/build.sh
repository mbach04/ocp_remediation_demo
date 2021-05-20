#!/bin/bash


# grab last 5 of the commit id
COMMIT=$(git rev-parse HEAD | grep -o '.....$')

# build the container tagging it with the commit id
podman build -t dc-metro-map:$COMMIT -f Dockerfile .

# tag for push to quay.io
podman tag dc-metro-map:$COMMIT quay.io/mbach/dc-metro-map:$COMMIT

# push
podman push quay.io/mbach/dc-metro-map:$COMMIT
