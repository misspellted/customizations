#! /bin/bash

# This script needs to be run with elevated privileges.
if [[ "$(id -u)" -eq 0 ]]; then

    # This script depends on the symlink located at /usr/bin/firefox.
    USR_BIN_FIREFOX="/usr/bin/firefox"

    # If it exists, it will deploy the policies.json file to a distribution
    # directory in the directory to which the /usr/bin/firefox symlink points.
    if [[ -e $USR_BIN_FIREFOX ]]; then

        # Get the path to the firefox.sh script.
        echo "Locating the home of Firefox..."
        FIREFOX_SCRIPT=$(readlink -f $USR_BIN_FIREFOX)
        FIREFOX_HOME=$(dirname $FIREFOX_SCRIPT)

        echo "Firefox located at $FIREFOX_HOME."
        echo "Creating 'distribution' directory (if needed)..."

        FIREFOX_DISTRIBUTION="$FIREFOX_HOME/distribution"

        if [[ ! -e $FIREFOX_DISTRIBUTION ]]; then
            mkdir $FIREFOX_DISTRIBUTION
        fi

        echo "Deploying policies.json to $FIREFOX_DISTRIBUTION..."

        cp "policies.json" $FIREFOX_DISTRIBUTION

        FIREFOX_DISTRIBUTION_POLICIES="$FIREFOX_DISTRIBUTION/policies.json"

        if [[ -e $FIREFOX_DISTRIBUTION_POLICIES ]]; then
            echo "Successfully deployed policies.json to $FIREFOX_DISTRIBUTION."
        else
            echo "Failed to deploy policies.json to $FIREFOX_DISTRIBUTION."
        fi

    fi

else

    echo "This script needs elevated privileges to copy the policies.json file."

fi
