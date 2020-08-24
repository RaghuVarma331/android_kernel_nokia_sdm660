#!/bin/bash

echo "------------------------------------------------------"
echo "Kernel Source For Nokia 6.1 Plus"
echo "Lets Compile kernel with Clang. sit Back & Have A coffee "
echo "------------------------------------------------------"

password=
pathtoclang=/root/clang
pathtogcc=/root/aarch64-linux-android-4.9
path=/root

cd
mkdir black_caps
git clone https://github.com/RaghuVarma331/aarch64-linux-android-4.9.git -b master --depth=1 aarch64-linux-android-4.9
git clone https://github.com/RaghuVarma331/clang.git -b android-10.0 --depth=1 clang
cd kernel
clear
make O=out ARCH=arm64 SAT-perf_defconfig
PATH=$pathtoclang/bin:$pathtogcc/bin:${PATH} \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android-
cp -r out/arch/arm64/boot/Image.gz-dtb $path/kernel/DRG_sprout
cd DRG_sprout
zip -r Black_caps-10.0-CLANG-FIH-SDM660-2018-$(date +"%Y%m%d").zip META-INF patch tools Image.gz-dtb anykernel.sh
cp -r Black_caps-10.0-CLANG-FIH-SDM660-2018-$(date +"%Y%m%d").zip $path/black_caps
cd
cd $path
cd black_caps
echo Sending build to sourceforge..
sshpass -p $password rsync -avP -e ssh Black_caps**.zip raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/Black_Caps-Edition



echo "--------------------------------------------"
echo "All Right now flash at your own risk"
echo "Flashable Zip located in black_caps Folder"
echo "Good Bye ..!! @ RaghuVarma "
echo "--------------------------------------------"
