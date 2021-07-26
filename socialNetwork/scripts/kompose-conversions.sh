#!/bin/bash

K8S_ROOT_DIR=$(realpath ../kubernetes)

mkdir -p $K8S_ROOT_DIR
cd $K8S_ROOT_DIR

rm -f *.yaml

kompose convert -f ../docker-compose.yml --volumes hostPath

