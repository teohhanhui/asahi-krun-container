# Container image for asahi-krun

## Build

    buildah build -f Dockerfile -t quay.io/teohhanhui/asahi-krun .

## Create

    buildah unshare
    krunvm create --cpus 6 --mem 6144 --name asahi-krun quay.io/teohhanhui/asahi-krun

## Run

    buildah unshare
    krunvm start asahi-krun
