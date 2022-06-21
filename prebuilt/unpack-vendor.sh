#!/bin/bash
ROOT=$(dirname "$(readlink -f "$0")")
echo "Unpacking..."
if [ ! -f $ROOT/vendor.img ]; then
    7z e $ROOT/fragments/vendor.img.7z.001 -o"$ROOT" -y
fi
echo "Done!"

