#!/bin/bash
# usage: ./install_multiple_python.sh Python-file.tar.xz
# it will install the Python interpreter in the folder:
#   * ~/usr/local/bin/pythonversion

# wget https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz;

IN_FILE=$1;
VERSION=$(basename -- "$IN_FILE")
VERSION="${VERSION%.*}"
VERSION="${VERSION%.*}"

echo "Going to install version: "$VERSION" .";

tar -xf $IN_FILE;

cd $VERSION;
rm -fr ~/opt/Python/
./configure --enable-shared --prefix=$HOME/opt/Python/$VERSION LDFLAGS=-Wl,-rpath=$HOME/opt/Python/$VERSION/lib
# uncomment if its for cluster
# ./configure --enable-shared --enable-optimizations --prefix=$HOME/opt/Python/$VERSION LDFLAGS=-Wl,-rpath=$HOME/opt/Python/$VERSION/lib
make;
make install;
