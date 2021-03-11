#!/usr/bin/env bash
set -eo pipefail

execute_test () {
    if [ -d "${1}" ]; then
        (
        cd "${1}"
        # Get the exercise name from the directory
        EXERCISE_NAME=$(echo "$1" | tr '-' '_')
        
        echo "Running tests for ${EXERCISE_NAME}";

        # Copy the examples with the correct name for the exercise
        if [ -e "./.meta/example.zig" ]; then
            mv ./.meta/example.zig "${EXERCISE_NAME}".zig
            # No building required, just test it.
            zig test test_${EXERCISE_NAME}.zig
            printf '\n'
        else
            printf '%s\n' \
                "${EXERCISE_NAME} missing contents, skipping test..."
        fi
        )
    fi
}

# Move to the root directory of the repo so you can run this script from anywhere
SCRIPT_DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
cd "${SCRIPT_DIR}"/..

# Clear up any previous run
if [ -d build ]; then
    rm -rf build
fi

if [ -d "exercises/practice" ]; then
    cp -r exercises/practice build
    cd build/
else
    printf '%s\n' "The exercises/practice folder is missing..."
    printf '%s\n' "Nothing wrong with that, just means there's nothing to test."
    exit 0
fi

# Allow specifying which tests to run as arguments
if [ $# -gt 0 ]; then
    for exercise in "$@"; do
        # Check if the file exists
        if [ -e $exercise ]; then
            execute_test "$exercise"
        fi
    done
else
    for exercise in *; do
        # Check if the file exists
        if [ -e $exercise ]; then
            execute_test "$exercise"
        fi
    done
fi

# Clean up duplicate exercises
cd ..
if [ -d build ]; then
    rm -rf build
fi
