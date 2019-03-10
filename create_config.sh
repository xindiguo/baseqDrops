#! /bin/bash

echo "[Drops]" > config_drop.ini
echo "samtools = /usr/app/samtools" >> config_drop.ini
echo "star = /usr/app/star" >> config_drop.ini
echo "whitelistDir = /usr/app/baseqDrops/whitelist" >> config_drop.ini
echo "cellrange_ref_$1 = $2" >> config_drop.ini
