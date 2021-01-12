#!/bin/bash

set -e -o pipefail

buildroot_tar="buildroot-2019.02.2.tar.gz"
buildroot_url="https://buildroot.uclibc.org/downloads/$buildroot_tar"

board="$KUBOS_BOARD"

latest_tag=`git tag --sort=-creatordate | head -n 1`
sed -i "s/0.0.0/$latest_tag/g" common/linux-kubos.config

echo "Building $latest_tag for Board: $board"

cd .. #cd out of the kubos-linux-build directory

echo "Getting Buildroot"

if [ ! -d "${buildroot_tar%.tar.gz}" ]
then
  wget $buildroot_url && tar xzf $buildroot_tar && rm $buildroot_tar
fi

cd "${buildroot_tar%.tar.gz}"

make BR2_EXTERNAL=../kubos-linux-build ${board}_defconfig

echo "Removing old toolchains"

rm /usr/bin/*_toolchain -R

echo "Starting Build"

if [ -z ${KUBOS_BUILD_CPUS+x} ]
then
  make -j ${KUBOS_BUILD_CPUS}
else
  make
fi