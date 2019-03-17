#! /bin/bash

echo "[Drops]" > config_drop.ini
echo "samtools = samtools" >> config_drop.ini
echo "star = STAR" >> config_drop.ini
echo "whitelistDir = /usr/app/baseqDrops/whitelist" >> config_drop.ini
echo "cellranger_ref_$1 = $2" >> config_drop.ini
