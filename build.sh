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

wget $buildroot_url && tar xzf $buildroot_tar && rm $buildroot_tar
cd ./buildroot-2019.02.2

make BR2_EXTERNAL=../kubos-linux-build ${board}_defconfig || make BR2_EXTERNAL=../kubos-linux-build ${board}_defconfig


echo "Starting Build"

if [ -z ${KUBOS_BUILD_CPUS+x} ]; then
  make -j ${KUBOS_BUILD_CPUS}
else
  make
fi

# move build output into source/output for inclusion in CI artifacts
output_dir="../kubos-linux-build/output"
mkdir -p ${output_dir}
mv output/images/kubos-linux.tar.gz ${output_dir}
mv output/images/aux-sd.tar.gz ${output_dir}
mv output/images/kpack.its ${output_dir}
cd ${output_dir}
BINARIES_DIR=../../buildroot-2019.02.2/output/images/ ../tools/kubos-package.sh -t ${KUBOS_BOARD} -b 1.5 -v kubos