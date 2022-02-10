#! /usr/bin/env bash

set -eo pipefail

echo "This script will wipe the existing R installation at /opt/R-devel."
read -p "Are you sure you wish to continue?"
if [ "$REPLY" != "yes" ]; then
   exit
fi

# https://stackoverflow.com/questions/42655177/how-can-i-delete-a-file-only-if-it-exists#42655267
rm -rf R-devel

curl https://stat.ethz.ch/R/daily/R-devel.tar.gz > R-devel.tar.gz
tar -xf R-devel.tar.gz
cd R-devel
rm -rf /opt/R-devel/
make clean
./configure --prefix=/opt/R-devel/ --enable-R-shlib
make -j 5
make install
cd ..

echo "R-devel should now be installed!"
