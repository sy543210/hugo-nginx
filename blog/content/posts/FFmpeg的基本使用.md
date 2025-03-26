---
title: FFmpeg的基本使用
date: 2024-10-11
draft: false
series: []
tags:
  - tools
---
[文档](https://ffmpeg.org/ffmpeg.html)

# FFmpeg
## 介绍

ffmpeg 是一款通用的媒体转换器。它能读取各种输入（包括实时抓取/录制设备），并将其过滤和转码为大量输出格式。

## 转码程序工作图

![](../../img/posts/image-20240519170946267.png)
- muxer：即多路复用器，主要用于将音频流、视频流、字幕流等不同的数据流进行混合，生成一个包含所有信息的单一数据流。如mp4等格式
- demuxer：对视频进行解封装
## 工具
- ffmpeg：主程序
- ffplay：简单的音视频查看工具
- ffprobe：查看音视频信息工具
## 示例
1. 查看文件信息：`ffmpeg -i demo.mp4`或`ffprobe demo.mp4`，添加`-hide_banner`可以隐藏版本，配置参数等信息
2. 转换文件格式：`ffmpeg -i demo.mp4 demo.mov`
3. 获取一张视频截图：`ffmpeg -i demo.mp4 -ss 00:00:01 -f image2 -vframes 1 out.jpg`
4. 视频添加水印：`ffmpeg -i demo.mp4 -i logo.png -filter_complex "overlay=x:y out.mp4"
5. 视频去除水印：`ffmpeg -i demo.mp4 -vf "delogo=x=xxx:y=xxx:w=xxx:h=xxx:show=0" -c:a copy out.mp4`
6. 更改视频分辨率：`ffmpeg -i demo.mp4 -vf scale=-1:720`
7. 删除视频中的音频：`ffmpeg -i demo.mp4 -an out.mp4`
8. 视频转gif图：`ffmpeg -i demo.mp4 -ss 00:00:30 -t3 -vf "fps=24,scale=600:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" test.gif`
## 参考
[知乎：FFMPEG详解(完整版）](https://zhuanlan.zhihu.com/p/673522888)
[B站：FFmpeg 速成教学](https://www.bilibili.com/video/BV1bu4y1n78A/)
[视频转gif图](https://blog.csdn.net/qq284489030/article/details/134683655)