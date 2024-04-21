# Container image for asahi-krun

## Build

    buildah build -f Dockerfile -t asahi-krun .

## Create

    buildah unshare
    krunvm create --cpus 6 --mem 6144 --name asahi-krun asahi-krun

## Run

    buildah unshare
    krunvm start asahi-krun

## Run as root user

    buildah unshare
    krunvm start asahi-krun entrypoint.sh -- bash

## Run command as steam user

    buildah unshare -- krunvm start asahi-krun entrypoint.sh -- entrypoint-user.sh glmark2 -b terrain:duration=20 --annotate
