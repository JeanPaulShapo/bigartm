#!/bin/bash


if [[ $TRAVIS_PYTHON_VERSION == 2* ]]; then
    ./codestyle_checks.sh;
fi
CMAKE_OPTIONS=""
mkdir build
pushd build && cmake ${CMAKE_OPTIONS} .. && make -j2 && file ./bin/bigartm && popd
pushd python && python setup.py install && popd
