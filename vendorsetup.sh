#!/bin/bash
# Use a reliable method to get what shell we're on
SHELLCHK=$(ps -p $$ | grep 00 | sed 's/.* //g')
if [[ "${SHELLCHK}" == "bash" ]]; then
    # Variable setting method specific to bash
    DT_ROOT=$(dirname "${BASH_SOURCE[0]}")
else
    DT_ROOT=$(dirname "$0")
fi
echo "including $DT_ROOT/prebuilt/unpack-vendor.sh"
bash $DT_ROOT/prebuilt/unpack-vendor.sh > /dev/null 2>&1
