#!/bin/bash

HERE=$(pwd)

if [ -n "$1" ]; then

    RECIPE="$1"
fi

RECIPE="$HERE/Recipes/Iconic/launcher_parameters.sh"

if ! test -e "$RECIPE"; then

    echo "ERROR: Iconic recipe not found '$RECIPE'"
    exit 1
fi

# shellcheck disable=SC1090
. "$RECIPE"

if [ -z "$VERSION" ]; then

    echo "ERROR: 'VERSION' variable not set"
    exit 1
fi

if [ -z "$NAME" ]; then

    echo "ERROR: 'NAME' variable not set"
    exit 1
fi

if [ -z "$DESCRIPTION" ]; then

    echo "ERROR: 'DESCRIPTION' variable not set"
    exit 1
fi

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

if [ -z "$DESKTOP_FILE_NAME" ]; then

    echo "ERROR: 'DESKTOP_FILE_NAME' variable not set"
    exit 1
fi

echo "Iconify: Name='$NAME', Version='$VERSION' Icon='$LAUNCHER'"
echo "Iconify: Executable='$BIN', Description='$DESCRIPTION', File='$DESKTOP_FILE_NAME'"

CONTENT=$(cat << EOF
[Desktop Entry]
Name=$NAME $VERSION
Exec="$BIN"
Version=$VERSION
Type=Application
Categories=Development;IDE;
Terminal=true
Icon=$LAUNCHER
Comment=$DESCRIPTION
StartupNotify=true
EOF
)

if [ -n "$2" ]; then

    DIR_DESTINATION="$2"

else

    DIR_HOME=$(eval echo ~"$USER")
    DIR_DESTINATION="$DIR_HOME/.local/share/applications"
fi

if ! test -e "$DIR_DESTINATION"; then

    echo "ERROR: The destination directory does not exist '$DIR_DESTINATION'"
    exit 1
fi

FILE_DESTINATION="$DIR_DESTINATION/$DESKTOP_FILE_NAME"

if echo "$CONTENT" > "$FILE_DESTINATION"; then

    echo "The desktop launcher entry file written: '$FILE_DESTINATION'"

else

    echo "ERROR: The desktop launcher entry file not written '$FILE_DESTINATION'"
    exit 1
fi