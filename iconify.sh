#!/bin/bash

HERE=$(pwd)

RECIPE="$HERE/Recipes/Iconic/launcher_parameters.sh"

if [ -n "$1" ]; then

    RECIPE="$1"
fi

if ! test -e "$RECIPE"; then

    echo "ERROR: Iconic recipe not found '$RECIPE'"
    exit 1
fi

# shellcheck disable=SC1090
. "$RECIPE"

if [ -z "$BIN" ]; then

    echo "ERROR: 'BIN' variable not set"
    exit 1
fi

if ! test -e "$BIN"; then

    echo "ERROR: 'BIN' path is not valid '$BIN'"
    exit 1
fi

if [ -z "$LAUNCHER" ]; then

    echo "ERROR: 'LAUNCHER' variable not set"
    exit 1
fi

if ! test -e "$LAUNCHER"; then

    echo "ERROR: 'LAUNCHER' path is not valid '$BIN'"
    exit 1
fi

echo "Iconify: Icon='$LAUNCHER', Executable='$BIN'"