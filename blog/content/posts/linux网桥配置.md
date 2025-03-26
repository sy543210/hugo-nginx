---
title: linux通过网桥将多网口主机当交换机
date: 2024-09-12
draft: false
series: 
tags:
  - linux
  - network
---
在 Arch Linux 中将多网口主机配置为交换机可以通过创建一个网桥来实现

### 步骤 1：安装必要的工具

确保系统上已安装 `bridge-utils`，通常情况下它默认包含在 Arch Linux 中。如果没有，可以使用以下命令安装它：

```bash
sudo pacman -S bridge-utils
```

### 步骤 2：创建网桥

1. **编辑网络配置文件**：在 Arch Linux 中，可以使用 `systemd` 的网络配置方法或 `netctl`。这里我们将使用 `systemd-networkd`。
   - 创建网桥配置文件，例如 `/etc/systemd/network/10-br0.netdev`：

   ```init
   [NetDev]
   Name=br0
   Kind=bridge
   ```
   
2. **添加物理接口到网桥**：例如，假设有两个接口：`eth0` 和 `eth1`。需要分别为这些接口创建配置文件，例如：
   - `/etc/systemd/network/20-eth0.network`：
   ```init
   [Match]
   Name=eth0

   [Network]
   Bridge=br0
   ```
   - `/etc/systemd/network/20-eth1.network`：
   ```init
   [Match]
   Name=eth1

   [Network]
   Bridge=br0
   ```

3. **配置网桥的IP地址**：如果网桥需要获取一个静态IP地址，可以创建另一个配置文件，例如 `/etc/systemd/network/30-br0.network`：
   ```init
   [Match]
   Name=br0

   [Network]
   Address=192.168.1.100/24  # 请根据的网络环境调整
   Gateway=192.168.1.1
   DNS=8.8.8.8
   ```

   如果想要使用 DHCP，可以设置：
   ```init
   [Match]
   Name=br0

   [Network]
   DHCP=yes
   ```

### 步骤 3：启用并启动 `systemd-networkd`

1. 启用 `systemd-networkd` 服务：
   ```bash
   sudo systemctl enable systemd-networkd
   sudo systemctl start systemd-networkd
   ```

2. 启用和启动 `systemd-resolved` 服务（如果使用 DNS）：
   ```bash
   sudo systemctl enable systemd-resolved
   sudo systemctl start systemd-resolved
   ```

### 步骤 4：检查配置

使用以下命令检查网桥和接口的状态，验证配置是否正确：

```bash
ip addr show
brctl show
```

### 步骤 5：连接和测试

- 将需要通过网桥通讯的设备接入 `eth0` 和 `eth1`，并确保设备能够正常工作。
- 验证另一台计算机是否能够从连接到 `eth0` 或 `eth1` 的接口获取到 IP 地址，确保流量可以正常通过网桥。
- 注意检查iptables确保br0的流量没有被拦截，如docker会有一条默认的规则导致[无法正常访问](https://superuser.com/questions/1675374/why-doesnt-my-bridge-transfer-dhcp-broadcast-packets)，可能将下面规则添加到`/etc/iptables/iptalbes.rules`

	>-A FORWARD -i br0 -j ACCEPT  
	
	然后启动iptables.service
	```shell
	sudo systemctl enable --now iptables.service
	```