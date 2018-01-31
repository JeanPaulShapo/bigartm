#!/bin/bash

if [[ $BUILD_PYTHON == ON && $TRAVIS_PYTHON_VERSION == 2* ]]; then
    ./codestyle_checks.sh;
fi

mkdir build

pushd build
cmake -DBUILD_BIGARTM_CLI=$BUILD_BIGARTM_CLI -DBUILD_INTERNAL_PYTHON_API=$BUILD_PYTHON ..
make -j2
[[ $BUILD_BIGARTM_CLI == ON ]] && file ./bin/bigartm
popd

if [[ $BUILD_PYTHON == ON ]]; then
    pushd python
    python setup.py install
    popd
fi
