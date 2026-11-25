#!/bin/bash

# Dừng ngay lập tức nếu có bất kỳ lệnh nào gặp lỗi
set -e

echo "=== 1. Cập nhật hệ thống ==="
sudo apt-get update && sudo apt-get upgrade -y

echo "=== 2. Cài đặt các gói phần mềm bắt buộc (OpenJDK 17, Git, Curl) ==="
sudo apt-get install -y openjdk-17-jdk git curl

echo "=== 3. Kiểm tra và tạo nhóm 'quickbite' ==="
if ! getent group quickbite > /dev/null 2>&1; then
    echo "Nhóm 'quickbite' chưa tồn tại. Đang tạo nhóm..."
    sudo groupadd -r quickbite
else
    echo "Nhóm 'quickbite' đã tồn tại. Bỏ qua bước tạo nhóm."
fi

echo "=== 4. Kiểm tra và tạo system user 'quickbite' ==="
if ! id -u quickbite > /dev/null 2>&1; then
    echo "User 'quickbite' chưa tồn tại. Đang tạo system user..."
    # -r: tạo system user (không tự động tạo thư mục home)
    # -g quickbite: gán vào nhóm chính là quickbite
    # -s /bin/false: khóa quyền đăng nhập trực tiếp (no login shell)
    sudo useradd -r -g quickbite -s /bin/false quickbite
else
    echo "User 'quickbite' đã tồn tại. Bỏ qua bước tạo user."
fi

echo "=== Hoàn tất thiết lập môi trường ban đầu cho QuickBite! ==="
