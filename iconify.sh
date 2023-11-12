#!/bin/bash

HERE=$(PWD)

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