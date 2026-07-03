#!/bin/bash

# 进入目录
cd /opt/btc-hunter

echo "[1/3] 正在停止旧进程，请稍候..."
# 强力停止所有相关进程
pkill -9 btc-hunter
pkill -9 -f monitor.py

# 重要：给系统 3 秒钟时间彻底释放端口和资源
sleep 3

echo "[2/3] 启动 Rust 引擎..."
nohup ./target/release/btc-hunter > /dev/null 2>&1 &

echo "[3/3] 启动 Web 监控..."
# 使用 nohup 启动，并强制不挂断
nohup python3 -u monitor.py > monitor.log 2>&1 &

# 再次等待一下确认状态
sleep 2

echo "--------------------------------------"
ps -ef | grep -E "btc-hunter|monitor.py" | grep -v grep
echo "--------------------------------------"
echo "✅ 如果上方显示两个进程，说明启动成功！"
echo "🌐 访问地址: http://66.154.110.5:39105"