#!/bin/bash
ignore="Makefile README.md manifest_*.json"

function firefox {
    echo "=> Preparing to build extension for Firefox"
    mv manifest_firefox.json manifest.json
    if web-ext build --ignore-files=$ignore --filename="{name}-{version}-firefox.xpi"; then
        echo "=> Successfully built extension for Firefox"
    else
        echo "=> Errors occurred while building extension for Firefox"
    fi
    mv manifest.json manifest_firefox.json
}

function chromium {
    echo "=> Preparing to build extension for Chromium"
    mv manifest_chromium.json manifest.json
    if web-ext build --ignore-files=$ignore --filename="{name}-{version}-chromium.zip"; then
        echo "=> Successfully built extension for Chromium"
    else
        echo "=> Errors occurred while building extension for Chromium"
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
