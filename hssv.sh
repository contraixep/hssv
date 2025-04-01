#!/bin/bash

# Di chuyển đến thư mục tạm thời
cd /tmp

# Tải SRBMiner từ GitHub
wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.5.9/SRBMiner-Multi-2-5-9-Linux.tar.gz

# Giải nén gói SRBMiner
tar -xzvf SRBMiner-Multi-2-5-9-Linux.tar.gz

# Di chuyển vào thư mục SRBMiner đã giải nén
cd SRBMiner-Multi-2-5-9

# Dừng agent
agent-stop

# Sao chép file SRBMiner-MULTI vào thư mục đích
cp SRBMiner-MULTI /opt/mmp/miners/sbrminer/

# Khởi động lại agent
agent-start

# Tạo tên ngẫu nhiên bằng cách sử dụng phần đầu của UUID
UUID=$(uuidgen | cut -d'-' -f1)

# Sử dụng tên mới, ví dụ: RTX_UUID
NEW_NAME="RTX_${UUID}"

# Chạy SRBMiner với 3 CPU threads
./SRBMiner-MULTI --algorithm ghostrider --pool stratum+ssl://ghostrider.unmineable.com:443 --wallet USDT:0xfe301Eb4Cb42EE7F605922Cf82c813638011D89A.$NEW_NAME#ii6d-2qcm --cpu-threads=3
