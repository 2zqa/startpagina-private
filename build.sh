#!/bin/bash
ignore="Makefile README.md manifest_*.json"

function firefox {
    echo "=> Preparing to build Firefox extension"
    mv manifest_firefox.json manifest.json
    if web-ext build --ignore-files=$ignore --filename="{name}-{version}-firefox.xpi"; then
        echo "=> Successfully built Firefox extension"
    else
        echo "=> Errors occurred while building Firefox extension"
    fi
    mv manifest.json manifest_firefox.json
}

function chromium {
    echo "=> Preparing to build Chromium extension"
    mv manifest_chromium.json manifest.json
    if web-ext build --ignore-files=$ignore --filename="{name}-{version}-chromium.zip"; then
        echo "=> Successfully built Chromium extension"
    else
        echo "=> Errors occurred while building Chromium extension"
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
        rm -rf web-ext-artifacts/
        ;;
    *)
        echo "Usage: $0 {firefox|chromium|all|clean}"
        exit 1
esac

exit 0
