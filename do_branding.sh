#!/bin/bash

if [ -z "$SUBMODULES_HOME" ]; then

  echo "ERROR: SUBMODULES_HOME not available"
  exit 1
fi

if [ -z "$1" ]; then

    echo "ERROR: Path to the launcher icon resource is mandatory"
    exit 1
fi

LAUNCHER_ASSET="$1"

if ! test "$LAUNCHER_ASSET"; then

    echo "ERROR: Not found '$LAUNCHER_ASSET'"
    exit 1
fi

echo "Branding icon asset path: '$LAUNCHER_ASSET'"

SCRIPT_GET_PROGRAM="$SUBMODULES_HOME/Software-Toolkit/Utils/Sys/Programs/get_program.sh"
SCRIPT_GET_CODE_PATHS="$SUBMODULES_HOME/Software-Toolkit/Utils/VSCode/get_paths.sh"

if ! test -e "$SCRIPT_GET_PROGRAM"; then

  echo "ERROR: Script not found '$SCRIPT_GET_PROGRAM'"
  exit 1
fi

if ! test -e "$SCRIPT_GET_CODE_PATHS"; then

  echo "ERROR: Script not found '$SCRIPT_GET_CODE_PATHS'"
  exit 1
fi

# shellcheck disable=SC1090
. "$SCRIPT_GET_CODE_PATHS"

# VSCode branding support:
#
if bash "$SCRIPT_GET_PROGRAM" code >/dev/null 2>&1; then

    GET_VSCODE_PATHS

    if [ -z "$CODE_DIR" ]; then

        echo "ERROR: the 'CODE_DIR' variable is not set"
        exit 1
    fi

    PATH_LAUNCHER_ICON="resources/app/resources/linux"
    CODE_LAUNCHER_ICON_PATH="$CODE_DIR/$PATH_LAUNCHER_ICON"

    if ! test -e "$CODE_LAUNCHER_ICON_PATH"; then

        echo "ERROR: Path does not exist"
        exit 1
    fi

    ICON="$CODE_LAUNCHER_ICON_PATH/code.png"

    if test -e "$ICON"; then

        echo "VSCode icon path: '$ICON'"
    fi

    echo "Branding '$LAUNCHER_ASSET' -> '$ICON'"

    if ! rm -f "$ICON"; then

      echo "ERROR: Could not remove '$ICON'"
      exit 1
    fi

    if cp "$LAUNCHER_ASSET" "$ICON"; then

      echo "Branding completed"
    fi
fi