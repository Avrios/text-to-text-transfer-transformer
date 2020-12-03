#!/usr/bin/env bash
set -e

echo "Releasing a new version of T5"
echo "#############################"

echo "Before publishing a new release, you need to update the version in t5/version.py."
echo "Make sure the version does not yet exist in our repository. Otherwise the release will fail."
read -p "Press <Enter> to continue" < /dev/tty

echo "Cleanup dist folder"
rm -rf dist

echo "Login to AWS Artifact"
aws codeartifact login --tool pip --repository avrios-pypi --domain avrios --domain-owner 821747761766 --profile avr-test

echo "Build and deploy library"

python setup.py sdist bdist_wheel
#twine upload -r testpypi dist/*
twine upload dist/*

echo "Done"
