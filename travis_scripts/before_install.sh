#!/bin/bash

# 1. We need latest pip to work with --only-binary option
echo "Update pip to latest version"
pip install -U pip

# 2. Install necessary python packages
echo "Install necessart python packages"
pip install -U pytest pep8 wheel pytest-forked
pip install -U protobuf tqdm
pip install -U numpy scipy --only-binary numpy,scipy
# Right now we cannot use 1.1.0 version of Pandas
# because it introduces bug with series indexing using tuples:
# https://github.com/pandas-dev/pandas/issues/35534
pip install -U 'pandas<1.1.0' --only-binary pandas

# 3. Install boost
echo "Install boost components"
sudo apt-get update
sudo apt-get install libboost-all-dev

# 4. Configure ccache
# code from https://github.com/urho3d/Urho3D/blob/master/.travis.yml
echo "Configure ccache"
export PATH=$(whereis -b ccache |grep -o '\S*lib\S*'):${PATH}
export CC=gcc-${GCC_VER} CXX=g++-${GCC_VER}
for compiler in gcc g++; do
    ln -s $(which ccache) $HOME/$compiler-$GCC_VER;
done
export PATH=$HOME:$PATH
