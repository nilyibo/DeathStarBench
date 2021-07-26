#!/bin/bash

REGISTRY=registry.k8s.local
PROJECT=dsb
TAG=xenial

COMPONENTS=(
    "media-frontend/xenial"
    "openresty-thrift/xenial"
    "thrift-microservice-deps/cpp"
)

SERVICE="social-network-microservices"

set -e

cd "$(dirname $0)/.."
CWD="$(pwd)"

BUILT_IMAGES=()

for component in ${COMPONENTS[@]}; do
    subdir=$(echo $component | cut -f 2 -d '/')
    component=$(echo $component | cut -f 1 -d '/')
    echo >&2 "Building docker image for component $component ..."
    cd docker/$component
    IMAGE_NAME="$REGISTRY"/"$PROJECT"/"$component":"$TAG"
    docker build -t "$IMAGE_NAME" -f $subdir/Dockerfile .
    BUILT_IMAGES+=($IMAGE_NAME)
    cd "$CWD"
done

# "xenial" tag was not used for the top-level service
TAG=latest
echo >&2 "Building docker image for service $SERVICE ..."
IMAGE_NAME="$REGISTRY"/"$PROJECT"/"$SERVICE"
docker build -t $IMAGE_NAME -f Dockerfile .
BUILT_IMAGES+=($IMAGE_NAME)

echo >&2 "Pushing newly built images ..."
for built_image in ${BUILT_IMAGES[@]}; do
    docker push $built_image
done

