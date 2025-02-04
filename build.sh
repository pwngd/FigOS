#!/bin/bash
WORK_DIR="./"
SRC_DIR="$WORK_DIR/src"
BUILD_DIR="$WORK_DIR/build"
INCLUDE_DIR="$WORK_DIR/include"
CC="$HOME/build-i686-elf/linux/output/bin/i686-elf-gcc"
AS="$HOME/build-i686-elf/linux/output/bin/i686-elf-as"
$AS $SRC_DIR/boot.s -o $BUILD_DIR/boot.o
$CC -c $SRC_DIR/kernel.c -o $BUILD_DIR/kernel.o -nostdlib -I$INCLUDE_DIR -ffreestanding -O2 -Wall -Wextra