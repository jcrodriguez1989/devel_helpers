#!/bin/bash
# usage: ./install_multiple_R.sh R-file.tar.gz
# it will install the R interpreter in the folder:
#   * ~/opt/R-devel/R-devel-version  if it was a devel R version
#   * ~/opt/R-release/R-version      if it was a release R version
# then in the PATH you should have R-version or R-devel-version

# wget https://cloud.r-project.org/src/base/R-3/R-3.5.3.tar.gz; # release
# wget https://stat.ethz.ch/R/daily/R-devel.tar.gz;             # devel
# wget https://stat.ethz.ch/R/daily/R-devel_2019-03-19.tar.gz;  # old devel

IN_FILE=$1;
VERSION=$(basename -- "$IN_FILE");
VERSION="${VERSION%.*}";
VERSION="${VERSION%.*}";
UNZ_FOLD=$VERSION;

# get REL and VERSION depending on the file name
if [[ $IN_FILE == *"R-devel"* ]]; then
  REL='R-devel';
  UNZ_FOLD=$REL;
  if [[ $VERSION == "R-devel" ]]; then
    VERSION=$VERSION"-"$(date +%Y-%m-%d);
  fi
else
  REL='R-release';
fi

echo "Going to install "$REL" , version: "$VERSION" .";

tar -xf $IN_FILE;
cd $UNZ_FOLD;
mkdir -p $HOME/opt/$REL;
./configure --prefix=$HOME/opt/$REL/$VERSION --enable-R-shlib --with-cairo=yes;
make;
make install;

# create links so its in the path
ln -s $HOME/opt/$REL/$VERSION/bin/R $HOME/.local/bin/$VERSION;
ln -s $HOME/opt/$REL/$VERSION/bin/Rscript $HOME/.local/bin/"Rscript_"$VERSION;

# save new libraries in current version path
echo ".libPaths('$HOME/opt/$REL/$VERSION/lib/R/library/')" > $HOME/opt/$REL/$VERSION/.Rprofile
$HOME/.local/bin/$VERSION;
