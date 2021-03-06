#!/bin/bash

set -e
set -x

for kind in vosk-server vosk-server-atom ru en de cn en-atom fr-atom ru-atom vosk-server-grpc-en; do
    docker build --squash --file Dockerfile.kaldi-${kind} --tag alphacep/kaldi-${kind}:latest .
done

for kind in vosk-server vosk-server-atom ru en de cn en-atom fr-atom ru-atom vosk-server-grpc-en; do
    docker push alphacep/kaldi-${kind}:latest
done
