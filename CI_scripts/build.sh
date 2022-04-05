#!/bin/bash

# Source Configs
source $CONFIG

# A Function to Send Posts to Telegram
# telegram_message() {
# 	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
# 	-d chat_id="${TG_CHAT_ID}" \
# 	-d parse_mode="HTML" \
# 	-d text="$1"
# }

# Change to the Source Directry
cd $SYNC_PATH

# Set-up ccache
if [ -z "$CCACHE_SIZE" ]; then
    ccache -M 10G
else
    ccache -M ${CCACHE_SIZE}
fi

# Empty the VTS Makefile
# if [ -f frameworks/base/core/xsd/vts/Android.mk ]; then
#     rm -rf frameworks/base/core/xsd/vts/Android.mk && touch frameworks/base/core/xsd/vts/Android.mk
# fi

# Send the Telegram Message

# echo -e \
# "
# 🤖 TWRP Recovery CI

# ✔️ The Build has been Triggered!

# 📱 Device: "${DEVICE}"
# 🖥 Build System: "${FOX_BRANCH}"
# 🌲 Logs: <a href=\"https://cirrus-ci.com/build/${CIRRUS_BUILD_ID}\">Here</a>
# " > tg.html

# TG_TEXT=$(< tg.html)

# telegram_message "${TG_TEXT}"
# echo " "

# Prepare the Build Environment
source build/envsetup.sh

# export some Basic Vars
export ALLOW_MISSING_DEPENDENCIES=true

# lunch the target
if [ "$TWRP_BRANCH" = "twrp-11" ]; then
    lunch twrp_${DEVICE}-eng || { echo "ERROR: Failed to lunch the target!" && exit 1; }
else
    lunch omni_${DEVICE}-eng || { echo "ERROR: Failed to lunch the target!" && exit 1; }
fi

# lunch the target
if [ "$FOX_BRANCH" = "fox_11.0" ]; then
    lunch twrp_${DEVICE}-eng || { echo "ERROR: Failed to lunch the target!" && exit 1; }
else
    lunch omni_${DEVICE}-eng || { echo "ERROR: Failed to lunch the target!" && exit 1; }
fi

# Build the Code
if [ -z "$J_VAL" ]; then
    mka -j$(nproc --all) $TARGET || { echo "ERROR: Failed to Build TWRP!" && exit 1; }
elif [ "$J_VAL"="0" ]; then
    mka $TARGET || { echo "ERROR: Failed to Build TWRP!" && exit 1; }
else
    mka -j${J_VAL} $TARGET || { echo "ERROR: Failed to Build TWRP!" && exit 1; }
fi

# Exit
exit 0