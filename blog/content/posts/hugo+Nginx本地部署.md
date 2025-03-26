---
title: hugo+Nginx本地部署
date: 2024-08-29
draft: false
series:
  - linux学习
tags:
  - linux
  - hugo
---
最近想把之前写的markdown笔记部署起来搭个博客，主要有下面两方面考虑：
- 便于多端访问：之前都用smb共享，但在移动端体验一般。
- 便于格式的统一

考虑到之后可能会将之些笔记部署的云上或github上，为了方便迁移，选择静态博客生成工具[hugo](https://gohugo.io/).大多数教程的部署方案都是使用github action，但考虑到github正常访问速度等问题，故pass。

由于手头有一台闲置的笔记本，目前用来当一个简单的服务器用，像一些smb，alist，ql等乱七八糟的内容都挂在上面。现在想把博客也挂上去，主要在局域网内访问，在外面需要的话也可以用内网穿透服务临时用一下。
## 需求

1. 移植性好，以便日后可能的平台迁移(静态生成工具移植都方便)
2. 尽量降低对markdown编写侵入，编写完后自动化构建
3. 可以在不同应用编辑Markdown文档(主要是图片路径问题)
## 方案

自动化构建思路主要就两种：
- hugo server + nginx反向代理
- inotifywait + 脚本

最开始本想通过直接通过第一种来实现。但后来发现有些应用(obsidian，还[无法关闭](https://forum.obsidian.md/t/disable-auto-save-or-change-frequency/14230/35))在写markdown的时候会自动保存文档，而且频率相当高。这就导致用hugo server后需要经常性的编译写好的文档，对性能影响较大，没办法就只能用inotifywait写脚本监听文件变化了。

流程如下：
1. 创建一个文件deploy.md，用于inofitywait监控
2. 当编写完markdown后，能过修改文件deploy.md触发事件
3. inotiywait收到事件后执行脚本编译，并将编译后的文件同步到nginx

### 具体过程

使用[inofitywait](https://man.archlinux.org/man/inotifywait.1)先安装`inotify-tools`包：
>sudo pacman -S inotify-tools

对于文件deploy.md，并没有啥要求。之所有选择md文件，主要是由于大部分markdown软件默认只显示md文件。inofitywait选择监控close_write事件，当想要发布内容时只需要随便改动一下文件保存即可。

> 推荐放一个复选框`- [ ] trigger`

监测deploy.md事件脚本(deployer.sh)：
```shell
#!/bin/bash
flagPath="/path/to/you/deploy.md"   # 参考：${HOME}/share/hugo/deploy.md
deployerPath="/path/to/your/hugo/site"   # 参考：${HOME}/projects/hugo/blog
nginxPath="/path/to/your/nginx/html/"  # 参考: ${HOME}/projects/docker/nginx/html/
sleepTime=10    # 触发构建后10s之后才能再次构建
while true; do
        file=$(inotifywait -qe 'close_write' $flagPath | if read file; then
                echo $file
        fi)       # 监听close_write事件，即以可写模式打开后关闭触发
        hugo --quiet --cleanDestinationDir -s $deployerPath && rsync --delete -a "${deployerPath}/public/" $nginxPath # 编译并将public同步到nginx的html下
        if [ $? -eq 0 ]; then
                echo "Successfully deployed $deployerPath to $nginxPath
        fi
        sleep $sleepTime
done
```
systemd单元文件blog-deployer.service
> 注意替换<>中内容
```
[Unit]
Description=Deployer blog to nginx after md file changed
After=network-online.target

[Service]
Type=simple
User=<you>
Group=<yourgourp>
ExecStart=</path/to/you>/deployer.sh
Restart=on-failure
StandardOutput=syslog
StandardError=syslog

[Install]
WantedBy=multi-user.target
```
启动服务
```shell
sudo ln -s ${PWD}/blog-deployer.service /usr/lib/systemd/system/blog-deployer.service
sudo systemctl daemon-reload && sudo systemctl enable --now blog-deployer
```

### 关于hugo的图片路径问题

markdown的图片管理一直是一个麻烦的问题。如果将放本地，如果想迁移文件或发表到其它平台时也需要将文档内图片一起带上，这种情况放云上通过链接访问毫无疑问是一个更好的选择。但这也意味着需要一笔费用来购买对应的服务或服务器，而且在没网络的情况下图片是无法加载的，对我来说放在本地就可以了。

放本地会遇到的问题就是hugo图片路径和markdown对不上的问题。这时候一个解决文案就是能过hugo的[联合文件系统](https://gohugo.io/getting-started/directory-structure/#union-file-system)

只需要将下面的内容放到hugo的config.yaml中
> 我的obsidian文件夹在\${HOME}/share/hugo，yaml文件在\${HOME}/projects/hugo/blog/config.yaml

```yaml
module:
  mounts:
    - source: content
      target: content
    - source: /home/yysog/share/typora/hugo/content
      target: content
    - source: static
      target: static
    - source: /home/yysog/share/typora/hugo/img
      target: static/img
```
并使用相对路径下访问图片，在obsidian中可以打开**基于当前笔记的相对路径**(typora也有类似设置)
![](../../img/posts/hugo+Nginx本地部署-20240831165521953.webp)

然后下载插件**Custom Attachment Location**，并设置如下 
![](../../img/posts/hugo+Nginx本地部署-20240831174507362.webp)

我的obsidian仓库结构如下：
![](../../img/posts/hugo+Nginx本地部署-20240831174334130.webp)


md文件放在content下，图像会自动放在img下。之后要迁移只需找到对应文件名开头的图片进行复制就行，这样无论是在markdown软件还是博客中打开，图片都能正确加载。