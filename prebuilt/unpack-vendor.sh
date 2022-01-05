#!/bin/bash
ROOT=$(dirname "$(readlink -f "$0")")
echo "Joining the fragments..."
cat $ROOT/fragments/vendor.a* > $ROOT/vendor.img.xz
echo "Unpacking..."
unxz $ROOT/vendor.img.xz
echo "Done!"
