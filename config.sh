#!/bin/bash

# Device
export TWRP_MANIFEST="https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git"
export TWRP_BRANCH="twrp-12.1"
export DT_LINK="https://github.com/0xNoob-bash/c -b 12"

export DEVICE="fleur"
export OEM="xiaomi"
export TARGET="bootimage"

export OUTPUT="*.img"

# Kernel Source
# Uncomment the next line if you want to clone a kernel source.
#export KERNEL_SOURCE="https://gitlab.com/OrangeFox/kernel/mojito.git"
#export PLATFORM="sm6150" # Leave it commented if you want to clone the kernel to kernel/$OEM/$DEVICE

# Not Recommended to Change
export SYNC_PATH="$HOME/work" # Full (absolute) path.
export USE_CCACHE=1
export CCACHE_SIZE="50G"
export CCACHE_DIR="$HOME/work/.ccache"
export J_VAL=16

if [ ! -z "$PLATFORM" ]; then
    export KERNEL_PATH="kernel/$OEM/$PLATFORM"
else
    export KERNEL_PATH="kernel/$OEM/$DEVICE"
fi
export DT_PATH="device/$OEM/$DEVICE"
