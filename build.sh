#!/bin/bash
BUILDDIR=${2:-web-ext-artifacts}
name=startpagina
ignore="Makefile README.md manifest_*.json"

function firefox {
    echo "=> Preparing to build $name for Firefox"
    mv manifest_firefox.json manifest.json
    if web-ext build --ignore-files=$ignore --artifacts-dir=$BUILDDIR --filename="$name-{version}-firefox.zip"; then
        echo "=> Successfully built $name for Firefox"
    else
        echo "=> Errors occurred while building $name for Firefox"
    fi
    mv manifest.json manifest_firefox.json
}

function chromium {
    echo "=> Preparing to build $name for Chromium"
    mv manifest_chromium.json manifest.json
    if web-ext build --ignore-files=$ignore --artifacts-dir=$BUILDDIR --filename="$name-{version}-chromium.zip"; then
        echo "=> Successfully built $name for Chromium"
    else
        echo "=> Errors occurred while building $name for Chromium"
    fi
    mv manifest.json manifest_chromium.json
}

function all {
    firefox
    chromium
}

case "$1" in
    firefox)
        firefox
        ;;
    chromium)
        chromium
        ;;
    all)
        all
        ;;
    clean)
        rm -rf $BUILDDIR/
        ;;
    *)
        echo "Usage: $0 {firefox|chromium|all|clean} [BUILDDIR]"
        exit 1
esac

exit 0
