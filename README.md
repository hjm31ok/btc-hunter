# BTC-Hunter V6.0 (Professional Edition)

基于 Rust 编写的高性能比特币私钥碰撞器与全协议监控系统。
![alt text](https://img.shields.io/badge/Language-Rust-orange.svg)

![alt text](https://img.shields.io/badge/Platform-Linux-blue.svg)

![alt text](https://img.shields.io/badge/License-MIT-green.svg)

## 项目简介
BTC-Hunter 是一款专为安全研究和密码学分析设计的极致工具。它利用 Rust 语言的内存安全和高并发特性，结合 libsecp256k1 指令级加速，实现了对比特币全协议地址（Legacy, P2SH, SegWit）的毫秒级扫描比对。

# 核心特性
极致性能：在 3 核 VPS 上实测扫描速度达 70,000+ keys/s（等同于每秒 210,000+ 次地址匹配）。
全协议覆盖：一次性生成并检测 3 种主流格式：
Legacy (P2PKH): 1... (支持压缩与非压缩公钥)
Nested SegWit (P2SH): 3...
Native SegWit (Bech32): bc1q...

## 工业级架构：
Rust 计算引擎：负责高强度的椭圆曲线点乘与哈希运算。
二进制加速：所有目标地址在内存中以 20 字节 Hash160 格式存储，实现零拷贝比对。
Web 监控面板：内置 Python 异步 Web 服务器，通过浏览器实时监控扫描状态。
高可用性：支持 systemd 服务化挂载，实现服务器重启自启与崩溃自愈。

## 技术架构
```
[私钥生成] -> [secp256k1] -> [Hash160计算] -> [二进制HashSet搜索]

                                   |
                             [status.json] <--- 每秒更新

                                   |
                             [Python Web Server] <--- 端口 39105

                                   |
                             [HTML5 Dashboard] <--- 远程监控
```

## 快速开始
### 1. 环境准备
```
# 安装 Rust 编译器
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# 加载环境变量
source $HOME/.cargo/env

# 验证安装
rustc --version

# 安装 Python 依赖
pip3 install python-dotenv

# 最好安装依赖库
pip3 install coincurve base58 bech32 python-dotenv
```

### 2. 编译与配置
```
安装
git clone https://github.com/hjm31ok/btc-hunter.git
cd btc-hunter

编译
cargo build --release

### 创建 .env 配置文件
nano .env
```
在 .env 中填入：
```
THREAD_COUNT=4
BATCH_SIZE=100000
ADDR_FILE=address.txt

运行
./target/release/btc-hunter
```

### 3. 部署自启服务
为了保证 24/7 不间断运行，请将项目下的 .service 文件部署至系统：
```
cp *.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable --now btc-hunter
systemctl enable --now btc-monitor
```

## 命令行：
启动：
```
systemctl start btc-hunter
或者
systemctl start btc-monitor
```
强力清空所有旧残留：
```
pkill -9 btc-hunter
或者
pkill -9 python3
```
停止：
```
# 停止碰撞引擎
systemctl stop btc-hunter

# 停止网页监控
systemctl stop btc-monitor
```
查看运行状况：
```
systemctl status btc-hunter
```

## 实时监控
部署完成后，你可以通过浏览器访问：http://你的服务器IP:39105

## 仪表盘显示内容：

目标地址总数：已加载的唯一 Hash160 计数。

运行时间：系统累计不间断运行时间。

累计尝试：已扫描的私钥总数。

实时速度：每秒扫描的私钥数量。

命中记录：发现有余额私钥时的即时提醒。


# 免责声明 (Disclaimer)

法律用途：本项目仅供密码学安全研究、教育学习及找回个人丢失私钥使用。禁止用于任何非法侵入、盗取他人资产的行为。

概率科学：比特币私钥空间为 2的256，通过随机碰撞撞中特定有余额地址的概率在数学上极其微小。

责任限制：开发者不对因使用本项目导致的任何硬件损耗、法律风险或财产损失负责。

# 开源协议
本项目基于 MIT License 协议开源。

# 贡献与支持
如果你发现任何 Bug 或有优化建议，欢迎提交 Pull Request。如果你觉得这个工具有趣，请给一个 Star 🌟！
