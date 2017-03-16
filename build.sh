#!/bin/sh
set -ex

IMAGE_NAME=codeclimate/codeclimate-rustfmt
mkdir -p build
docker build --tag ${IMAGE_NAME}-build --file Build.dockerfile .
docker run --rm --volume "${PWD}/build:/build" ${IMAGE_NAME}-build cp target/debug/rustfmt /build/
docker build -t "${IMAGE_NAME}".
