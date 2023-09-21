#!/bin/bash
ignore="Makefile README.md manifest_*.json build.sh"

function lint {
    echo "=> Linting Firefox extension"
    mv manifest_firefox.json manifest.json
    web-ext lint --self-hosted --ignore-files=$ignore
    firefox_exit_code=$?
    mv manifest.json manifest_firefox.json
    echo "=> Linting Chromium extension"
    mv manifest_chromium.json manifest.json
    web-ext lint --self-hosted --ignore-files=$ignore
    chromium_exit_code=$?
    mv manifest.json manifest_chromium.json
    if [ $firefox_exit_code -eq 0 ] && [ $chromium_exit_code -eq 0 ]; then
        echo "=> Successfully linted Firefox and Chromium extensions"
    else
        if [ $firefox_exit_code -ne 0 ]; then
            echo "=> Errors occurred while linting Firefox extension"
        fi
        if [ $chromium_exit_code -ne 0 ]; then
            echo "=> Errors occurred while linting Chromium extension"
        fi
    fi
}

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
    lint)
        lint
        ;;
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
        echo "Usage: $0 {firefox|chromium|all|clean|lint}"
        exit 1
esac

exit 0
