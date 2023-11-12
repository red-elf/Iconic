#!/bin/bash

HERE=$(pwd)
DIR_HOME=$(eval echo ~"$USER")
DIR_DESKTOP="$DIR_HOME/Desktop"

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

COMMAND="$BIN"

CONTENT=$(cat << EOF
[Desktop Entry]
Name=$NAME $VERSION
Exec=$COMMAND
Terminal=true
Version=$VERSION
Type=Application
Categories=Development;IDE;
Icon=$LAUNCHER
Comment=$DESCRIPTION
EOF
)

if [ -n "$2" ]; then

    DIR_DESTINATION="$2"

else

    DIR_DESTINATION="$DIR_HOME/.local/share/applications"
fi

if ! test -e "$DIR_DESTINATION"; then

    echo "ERROR: The destination directory does not exist '$DIR_DESTINATION'"
    exit 1
fi

FILE_DESTINATION="$DIR_DESTINATION/$DESKTOP_FILE_NAME"

if echo "$CONTENT" > "$FILE_DESTINATION"; then

    echo "The desktop launcher entry file written: '$FILE_DESTINATION'" && \
        echo "$CONTENT"

    if [ -n "$DESKTOP_ICON" ] && [ "$DESKTOP_ICON" = true ]; then

        FILE_DESKTOP_SHORTCUT="$DIR_DESKTOP/$DESKTOP_FILE_NAME"

        if test -e "$FILE_DESKTOP_SHORTCUT"; then

            if ! rm -f "$FILE_DESKTOP_SHORTCUT"; then

                echo "ERROR: Could not remove existing desktop shortcut file '$FILE_DESKTOP_SHORTCUT'"
                exit 1
            fi
        fi

        if test -e "$DIR_DESKTOP"; then

            if cp "$FILE_DESTINATION" "$FILE_DESKTOP_SHORTCUT"; then

                echo "Dekstop shortcut created: '$FILE_DESKTOP_SHORTCUT'"

            else

                echo "ERROR: Dekstop shortcut was not created: '$FILE_DESKTOP_SHORTCUT'"
                exit 1
            fi
        fi
    fi

else

    echo "ERROR: The desktop launcher entry file not written '$FILE_DESTINATION'"
    exit 1
fi