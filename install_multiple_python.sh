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
./configure --enable-shared;
mkdir -p $HOME/usr/local;
make altinstall prefix=$HOME/usr/local exec-prefix=$HOME/usr/local

# cd $HOME/usr/local/bin;
# ln -s python3.3 python3
# echo "export PATH=\$HOME/usr/local/bin:\$PATH" >> ~/.bashrc

# $HOME/usr/local/bin/$VERSION;
