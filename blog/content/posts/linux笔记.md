---
title: linux笔记
date: 2024-09-01
draft: false
series: 
tags:
  - linux
tocopen: false
---
# linux笔记

[Linux 教程 | 菜鸟教程 (runoob.com)](https://www.runoob.com/linux/linux-tutorial.html)

## 1. 字符/图形界面

### 1. 字符/图形界面的切换

计算机启动后默认进入图形界面登陆，若在进入字符界面，在图形登录界面使用Ctrl+Alt+F3;
若需从字符界面返回图形界面，使用Ctrl+Alt+F1

### 2. 查看/修改默认登陆界面

1. 查看默认登陆界面：`systemctl get-default`
2. 修改默认登陆界面：`sudo systemctl set-default [登陆状态]`
	
	登陆状态： 
   * `graphical.target` 表示图形界面
   * `multi-user.target` 表示字符界面

### 3. 字符界面关闭和重启(需要root权限)

#### 1. [shutdown](https://www.runoob.com/linux/linux-comm-shutdown.html)

* 命令格式：`shutdown [选项] [时间] [警告信息]`
    
    最常用： `$ sudo shutdown(一分钟后关机)`
  
  | 选项  | 选项含义               |
  |:---:|:------------------:|
  | -k  | 并不会关机，只发出警告信息给所有用户 |
  | -r  | 重新启动系统             |
  | -h  | 关闭系统               |
  | -c  | 取消运行shutdown       |
  
    例：
  
  * 发出关机警告信息，并不会关机：`$sudo shutdown -k`
  * 立即关机：`$sudo shutdown –h now`
  * 45分钟后关闭计算机：`$sudo shutdown –h +45`
  * 重启计算机并发出警告：`$sudo shutdown –r now "system will be reboot now."`
  * 定时在1点38分重启计算机：`$sudo shutdown –r 01:38`

#### 2. [halt](https://www.runoob.com/linux/linux-comm-halt.html)

* 命令格式：`halt [选项]`
    
    最常用：`$ sudo halt`
  
  | 选项  | 选项含义                           |
  |:---:|:------------------------------:|
  | -w  | 并不会关机，将关机信息写入到/var/log/wtmp文件中 |
  | -d  | 关闭系统，不把记录写到/var/log/wtmp日志文件中  |
  | -f  | 不调用shutdown而强制关闭系统             |

#### 3. [reboot](https://www.runoob.com/linux/linux-comm-reboot.html)

* 命令格式：`reboot [选项]`
    
    最常用： `$ sudo reboot`
  
  | 选项  | 选项含义                               |
  |:---:|:----------------------------------:|
  | -w  | 并不会真正重启系统，将重启信息写入到/var/log/wtmp文件中 |
  | -d  | 重启系统，不把记录写到/var/log/wtmp日志文件中      |
  | -f  | 不调用shutdown而强制重启系统                 |

## 2. 字符界面下的命令

### 1. 命令排列

* ";"  

	命令1; 命令2 
	不管命令1是否出错，都会执行命令2


* "&&"  

	命令1 && 命令2 
	只有当命令1  正确运行完毕后，才执行命令2

* "||"  

	命令1 || 命令2 
	命令1 正确运行，不执行命令2；命令1运行错误，执行命令2


### 2. 命令替换

* "$()"

    命令1 $(命令2)。如：kill $(pidof less)
* "\` \`"

    命令1 \`命令2\`。 如：kill \`pidof less\`

### 3. 命令别名

* 创建别名：alias [别名] = [需要定义别名的命令]

* 取消别名：unalias [别名]
  
    注：如果命令中有空格的话，就需要使用双引号（比如在命令与选项之间就有空格）
    例： 
    设置别名： 
    `alias work="cd /home/user01/program/cplus"`
    取消别名： 
    `unalias work`

## 3. 字符界面下的软件管理

### 1. dpkg(Debian Package):最早是Deb包管理工具

用法：dpkg [选项] 参数

| 选项  | 含义                         |
|:---:|:--------------------------:|
| -i  | 安装软件(install)              |
| -R  | 安装一个目录下面所有的软件包(Regressive) |
| -r  | 删除软件包，但保存其配置信息(remove)     |
| -L  | 查看软件安装文件所在位置(Location)     |

### 2. apt-get

| 命令                 | 含义      |
|:------------------ |:------- |
| apt-get install    | 安装包     |
| apt-get reinstall  | 重新安装包   |
| apt-get -f install | 修复安装    |
| apt-get remove     | 删除包     |
| apt-get autoremove | 删除包及其依赖 |
| apt-get upgrade    | 更新已安装的包 |

## 4. 目录和文件

### 1. 更改工作目录：`cd [目录]`

cd(change directory)命令的特殊用法：

* `cd ..`    转到当前目录的上层目录
  * `cd ~`     转到当前用户的家目录
  * `cd ../../`    转到当前目录的上上层目录

### 2. 显示当前工作目录：`pwd`

### 3. [目录与文件查看](https://www.runoob.com/linux/linux-comm-ls.html): `ls`

命令语法：ls [选项] [目录|文件]\(默认为当前目录)

| 选项  | 含义                    |
|:---:|:---------------------:|
| -l  | 以长格式形式显示              |
| -a  | 显示所有文件或目录，包括隐藏文件      |
| -i  | 显示文件索引信息，也就是文件的inode号 |
| -d  | 只列出目录                 |

### 4. 目录与文件创建：`mkdir(目录)、touch(空文件)、cat(创建并写入)`

* `mkdir [选项] [目录]`

	创建一个目录，常用选项:
	>-m    指定所有用户对新建目录的权限 
	-p    可以强制创建多层目录
  
	例：
  
	>创建一个目录： `$ mkdir a`  
	创建多人目录：`$ mkdir a b c d`  
	创建目录时指定目录权限：`$ mkdir -m 777 a`  
	强制创建目录：`$ mkdir -p a/b/c`

* `touch [选项] [文件]`

	创建一个空文件

* `cat > file`

	从键盘写入，按Ctrl + c退出，直接 `cat file`可以查看文件内容

### 5. [目录与文件复制](https://www.runoob.com/linux/linux-comm-cp.html)：`cp [选项] [源文件|目录] [目标文件|目录]`

注：源文件/目录可以为多个文件/目录

常用选项：
>`-r`：递归复制

例：
>复制文件file1到/tmp中并重命名为file2：`$ cp file1 /tmp/file2` 
>复制目录/tmp到目录/tmp/hadoop下：`$ cp –r /tmp /home/hadoop`

### 6. [目录与文件移动](https://www.runoob.com/linux/linux-comm-mv.html)：`mv [选项] [源文件|目录] [目标文件|目录]`

例：

>将文件file1重命名为file2: `$ mv file1 file2` 
将/tmp目录下的pic重命名为pic2: `$ mv /tmp/pic /tmp/pic2` 
将/tmp目录下的目录pic移动到/usr/local/share/pic：`$ mv /tmp/pic /usr/local/share/pic`

### 7. [目录与文件删除](https://www.runoob.com/linux/linux-comm-rm.html)：`rm [选项] [文件|目录]、rmdir 目录名`

* `rm [选项] [文件|目录]`

    常用选项：
	>`-r`: 递归删除，可以删除目录下的文件或目录 
	`-f`: 删除文件时不提醒而强制删除

* `rmdir 目录名`

    注：只能删除空目录，若删除目录及其父目录使用`rmdir -p a/b`将先删除b目录，再删除a目录，前提是为空目录

## 5. 文件或目录的权限

### 1. 文件的保护方式

* 用户分类：文件拥有者(user)、同组用户(group)、其他用户(others)
* 三种权限：读(r)、写(w)、执行(x)

### 2. 查看文件的权限：`ls -l [文件名]`

### 3.文件或目录的权限设定：`chmod [who] [+|-|=] [mode] 文件|目录` or `chmod 数值 文件|目录`

* 字符设定法：

    语法：`chmod [who] [+|-|=] [mode] 文件|目录名` 
    说明： 
    `[who]`：可以是下面字符中的一个或它们的组合：
	
  * `u(user)`: 表示“用户”，即文件或目录的所有者
  * `g(group)`: 表示“同组用户”
  * `o(others)`: 表示“其他用户”
  * `a(all)`: 表示“所有用户”
  
  `[+|-|=]`：`'+'`表示添加某个权限；`'-'`表示取消某个权限；`'='`表示赋予给定权限 
	[mode]：r(可读)、w(可写)、x(可执行) 
例：
	
  * 所有用户增加执行权限：`$ chmod a+x test1`
  * 文件属主(u)和同组用户(g)增加写(w)权限，其他用户(o)删除写(w)、执行权限(x)： 
`$ chmod ug+w, o-wx test2`  
  **注：中间用逗号隔开**
  * 把文件执行权限改为`rwxrw-rw-`：`$ chmod u=rwx,g=rw,o=rw test4`

* 数值设定法： 
    语法：`chmod 数值 文件|目录名` 
    数值：`rwx`(二进制) 
    例：
    
   * 属主(u)读写(rw)权限，同组用户(g)和其他用户(o)读(r)权限：`$ chmod 644 aaa`
   * 属主(u)读写执行(rwx)权限，同组用户(g)读执行(rx)权限，其他用户(o)没有权限：`$ chmod 750 bbb`

## 6. 内容显示：`cat、more、less、head、tail`

### 1. cat：一次打印文件内容

语法：`cat [选项] 文件名` 
选项： 
>-n 显示出行号  
-A 显示文件中所有字符，包括隐藏字符(换行符、制表符)

### 2. more: 分页显示文件内容

* 语法：`more 文件名` 
    注：
  * 读完文件再显示
  * 按空格向下翻页
  * ctrl+f向下翻页
  * ctrl+b向上翻页
  * 按q键退出所查看的文件

### 3. less：边读边显示，启动快，其余与more基本相同

### 4. head：查看文件头几行数据

语法：head [-n number] file 
>-n: 后面接数字，代表显示文件几行，不给定参数表示默认输出前10行

例： 
>查看文件前15行：`$ head -n 15 test`

### 5. tail：查看文件末尾数据(用法写head类似)

## 7. 通配符与管道命令

### 1. 通配符

* 通配符：用符号来匹配一个或多个字符

| 符号      | 功能                                    |
| ------- | ------------------------------------- |
| ?       | 代表任何单一字符                              |
| *       | 代表任何字符串                               |
| [字符组合]  | 在中括号中的字符都符合，譬如：[a-z]代表任意**一个**小写字母    |
| [!字符组合] | 不在中括号中的字符都符合，譬如：[!0-9]代表任意**一个**非数字字符 |

### 2. 管道

* 管道：用符号"|"来标识。用于连接两个命令，将前一个命令的输出结果作为后一个命令的输入 
    命令语法：[命令1]|[命令2]|[命令3] 
    例：
  * 查看/etc目录下的文件，并将结果分页显示：`$ ls /etc | more`
  * 查看系统中已安装软件中软件名包含字符'a'的所有软件，并分页显示：`$ dpkg -l | grep a|more`

## 8. 数据流重定向
### 1. 数据流

* 数据流是一组有顺序的、有起点和终点的字节集合

* 数据流类别分为三种：标准输入(stdin)，标准输出(stdout)和标准错误输出(stderr)
  
  | 设备文件        | 说明   | 文件描述符 |
  | ----------- | ---- | ----- |
  | /dev/stdin  | 标准输入 | 0     |
  | /dev/stdout | 标准输出 | 1     |
  | /dev/stderr | 标准错误 | 2     |

### 2. 数据流重定向
[参考](https://blog.csdn.net/bluishglc/article/details/132716571)


#### 1. 输出重定向

| 类型          | 符号                        | 作用                                     |
| ----------- | ------------------------- | -------------------------------------- |
| 标准输出/错误重定向  | 命令[2]>文件                  | 以**覆盖**的方式，把命令的正确/错<br />误输出结果输出到指定的文件 |
| 标准输出/错误重定向  | 命令 [2]>>文件                | 以**追加**的方式，把命令的正确/错误<br />输出结果输出到指定的文件 |
| 正确和错误输出同时保存 | 命令>文件 2>&1<br /> 命令 &>文件  | 以**覆盖**的文式，把正确和错误结果<br />输出到同一个文件      |
| 正确和错误输出同时保存 | 命令>>文件 2>&1<br />命令 &>>文件 | 以**追加**的方式，把正确和错误结<br />果输出到同一个文件      |

例：

* 查看计算机网上信息并将结果输出到文件right中：`$ ifconfig >> right`
* 命令运行正确时重定向到right，出错时重定向到error：`$ ls -l /etca >right 2>error`
* 将ls命令运行结果重定向到right_error中(追加)：`$ ls -l /etc &>>right_error`

#### 2. 输入重定向

* wc：`$ wc [选项] [文件名]`
    选项：
  
  * -l: 统计行数
  
  * -w: 统计单词数
  
  * -c: 统计字节数
    
    例：
  
  * 统计文件test的行数、单词数及字节数：`$ wc < test`

## 9. 文本处理

### 1. 文本排序：`sort [选项] 文件名`

* 命令格式：`sort [选项] 文件名` 
    功能：对文件中的文本默认按字典序从小到大进行排序，并将结果显示出来 
    选项：
  
  * -n: 按数值大小排序
  
  * -u: 对排序后相同的行只保留一行
  
  * -r: 按逆序输出排序结果
  
  * -d: 按字典顺序排序
  
  * -f: 忽略字母大小写
    
    例：
  
  * 对文件file1以倒序形式排序并显示在屏幕上：
      `$ sort -r file1` / `$ cat file1 sort -r `
  
  * 对文件file1排序并删掉重复的行：`$ sort -u file1`
  
  * 对数值文件file2按数值从小到大进行排序：`$ sort -n file2`

### 2. 文本去重：`uniq [选项] 文件名`

* 命令格式：`uniq [选项] 文件名` 
    功能：使用uniq命令可以将**排序后**文件内的重复行数据从输出文件中删除(源文件内容不会变) 
    选项：
  
  * -d: 只显示重复行
  
  * -u: 只显示不重复的行
    
    例：
  
  * 使用uniq命令对文件file1去重后输出：`$ sort file1 | uniq`
  
  * 查看文件file1中重复的数据内容：`$ sort file1 | uniq -d`
  
  * 查看文件file1中不重复的数据内容：`$ sort file1 | uniq -u`

### 3. 文本查找：`grep [选项] [字符串] 文件名`

* 命令格式：`grep [选项] [字符串] 文件名` 
    功能：查找文件里符合条件的字符串行 
    选项：
  
  * -c: 只显示匹配的行数
  
  * -i: 忽略字母大小写
  
  * -n: 输出时加行号
  
  * -v: 反转查找
    
    例：
  
  * 在/etc/adduser.conf文件中，查找含有adduser字符的行：
      `$ grep adduer /etc/adduer.conf`
  
  * 在adduser.conf文件中，查找不含'#'的行并列出行号：
      `$ grep -vn "#" /etc/adduser.conf`

### 4. 文本剪切：`cut -f List -d Character 文件`

* 命令格式：`cut -f list -d Character 文件`
    功能：从文件每行中选出指定的字节、字符或字段
  
  * -f: 获取被定界符隔开后指定的字段列表，**从1开始**(field)
  
  * -d: 指定分隔字符(delimiter)
    
    例：
  
  * 将PATH变量值取出，使用cut命令找出第五个路径：
      `$ echo $PATH | cut -d ':' -f 5`
  
  * 显示文件/etc/passwd中的用户登录名和用户名全称字段：
      `cut -f 1,5 -d : /etc/passwd`
  
  * 获取export命令输出信息的第12-20字符以后的内容：
      `$ export | cut -c 12-20`

### 5. 文本比较：`diff [选项] 文件1 文件2`

* 命令格式：`diff [选项] 文件1 文件2`
    选项：
  * -c: 以context模式显示比较的结果，相对normal
  * -y: 以并列的方式显示文件的异同之处
  * -W: 与选项-y一起使用，指定列宽

## 10. 文件查找

### 1. [find](https://www.runoob.com/linux/linux-comm-find.html)

* 命令格式：`find 目录 寻找条件操作`
    功能：在目录结构中搜索文件，并执行指定的操作
    寻找条件通常为：
  
  * 文件名称
  
  * 文件属性
  
  * 时间
    
    例：
  
  * 在/etc目录下，寻找以.conf结尾的文件：`$ find /etc -name *.conf`
  
  * 在当前目录下，查找属于user01用户的文件和目录：`$ find . -user user01`
  
  * 查找当前目录及其子目录下所有最近2天内更新过的文件：`$ find . -ctime  -20`

### 2. [locate](https://www.runoob.com/linux/linux-comm-locate.html)

* 命令格式：`locate -n N 文件名`
    功能：从例行工作(crontab)程序创建的数据库中查找文件
    选项：
  
    * -n: 显示查找结果的个数
  
    例：
  
  * 查找文件passwd所在位置：`$ locate passwd`
  
  * 查找文件passed所在位置(显示前三个)：`$ locate passwd`
    
    注：
    对于刚建立的文件，使用locate可以查找不到，因为后台数据库一天更新一次，若想立即搜索到，必须使用root权限运行`updatedb`命令更新数据库

### 3. [whereis](https://www.runoob.com/linux/linux-comm-whereis.html)

* 命令格式：`whereis [可选项] 要查找的字符串`
    功能：查找指定文件、命令和手册页的位置
    选项：
  
  * -b: 只查找二进制文件
  
  * -m: 只查找说明文件
  
  * -s: 只查找源代码文件
    
    例：
  
  * 查找mkdir命令的所有信息：`$ whereis mkdir`
  
  * 查看mkdir命令的手册信息：`$ whereis -m mkdir`

## 11. 压缩备份

### 1. [gzip](https://www.runoob.com/linux/linux-comm-gzip.html)

* 命令格式：`gzip [选项] 压缩/解压的文件名`
    功能：对文件进行压缩和解压缩。压缩后，会自动在文件名后加上.gz扩展名，默认不保留原文件
    选项：
  
  * -c: 将输出写到标准输出上，并保留原文件
  
  * -d: 将压缩文件解压
  
  * -r: 递归式地查找指定目录并压缩、解压缩
    
    例：
  
  * 用gzip命令将/home/lisi目录下的文件压缩：`$ gzip /home/lisi/*`
  
  * 用命令将/home/lisi目录下所有的.gz文件解压缩：`$ gzip -d /home/lisi/*` or `$ gunzip /home/lisi/*`

### 2. [bzip2](https://www.runoob.com/linux/linux-comm-bzip2.html)

* 命令格式：`bzip2 [选项] 文件名`
    功能：对目录和文件进行压缩或解压缩，压缩文件默认扩展名为bz2
    选项：
  
  * -d: 解压缩选项
  
  * -v: 显示压缩或解压缩过程
  
  * -f: 当文件重名时，进行覆盖
    
    例：
  
  * 使用bzip2命令压缩/home/lisi/目录下的文件：`$ bzip2 /home/lisi/*`
  
  * 使用bzip2命令解压缩/hmoe/list/目录下的文件：
      `$ bzip2 -d /home/lisi/*`

### 3. [tar](https://www.runoob.com/linux/linux-comm-tar.html)

* 命令格式：`tar [选项] 文件/目录名`
    功能：将多个文件或目录打包成一个文件
    选项：
  
  * -z: 用gzip命令进行压缩或解压缩
  
  * -j: 通过bzip2进行压缩/解压缩
  
  * -C: 指定解压缩目录
  
  * -c: 创建新的备份文件，备份目录或文件时必选项
  
  * -f: 对普通文件进行操作。这个选项通常是必选的
  
  * -r: 向备份档文件追加文件
  
  * -x: 从备份档文件中解压文件
  
  * -t: 列出备份文档中所含的文件
  
  * -v: 列出处理过程中的详细信息
    
    例：
  
  * 把/boot 目录下文件和子目录打包，打包文件名为usr.tar:
      `$ tar -cvf usr.tar /boot`
  
  * 把/boot目录下的文件和子目录打包，并用gzip算法进行压缩，文件名为usr.tar.gz:
      `$ tar -zcvf usr.tar.gz /boot`
  
  * 把usr.tar.gz这个打包文件还原并解压缩：
      ` $ tar -zxvf usr.tar.gz`
  
  * 将usr.tar.bz2这个打包文件解压缩到/tmp
      `$ tar -jxvf usr.tar.bz2 -C /tmp`
  
  * 查看usr.tar备份文件的内容，并显示在显示器上
      `$ tar -tvf usr.tar`
  
  * 将文件/root/abc/d添加到usr.tar包里面去
      `$ tar -rvf usr.tar /root/abc/d`

## 12. vi/vim编辑器(看[文档](https://www.runoob.com/linux/linux-vim.html))

### 1. vi/vim的三种模式

* 命令模式
* 插入模式
* 底线模式

[转换图](http://www.yysog.xyz:8180/2022/05/25/6e7236733da94.png)

### 2. vi/vim的使用：[vi/vim键盘图](http://www.yysog.xyz:8180/2022/05/25/91cab7cf54015.gif) [vim命令速查](http://www.yysog.xyz:8180/2022/05/25/611fd438445fa.png)

#### 1. 进入vi编辑器

1. 编辑一个文件
    `vim file`

2. 编辑多个文件
   
    `vim file1 file2`
   
   | 命令   | 说明      |
   | ---- | ------- |
   | :n   | 编辑下一个文件 |
   | :N   | 编辑上一个文件 |
   | :rew | 编辑第一个文件 |

#### 2. 退出vi/vim

1. 文件不存盘退出：`:q!`或`:q`
    注：!表示强制，下同
2. 文件存盘退出：`:wq!`或`:wq`
3. 文件另存为：`:w otherfile`
4. 部分文件另存：`:1,7 w otherfile`
5. 向文件中追加：`10,12 w >> otherfile`

#### 3. 移动光标

1. 上下左右单步移动：`h(←), j(↓), k(↑), l(→)`

2. 上下左右多步移动：`n方向`
    如：向上移动3行：`3k`

3. 逐单词移动
   
   | 操作  | 说明            |
   | --- | ------------- |
   | w   | 将光标移动到下一个单词开头 |
   | b   | 将光标向前移动一个单词   |
   | e   | 将光标移动到单词的词尾   |
   
    注：操作前也可以加数字表示多步操作。如：移动到后面的第3个单词开头：`3w`

4. 在某一行内移动
   
   | 操作       | 说明                    | 示例                  |
   | -------- | --------------------- | ------------------- |
   | f+任意字母键  | 将光标移到文本中下一个所指定的字母     | `fy`： 在行内向后查找并移到到y处 |
   | 任意数字键+\| | 将光标移到数字键指定的字符位置(以1开头) | `13                 |
   | $        | 将光标移动到当前行的行末          | `$`: 移到到行末          |
   | ^        | 将光标移到当前行的行首           | `^`: 移到到行首          |

5. 在不同行上移动
   
   | 操作    | 说明                            |
   | ----- | ----------------------------- |
   | 数字+G  | 将光标移动到数字对应行的行首，只输入G则移到到文件最后一行 |
   | :任意数字 | 将光标移到数字对应行的行首                 |
   | :$    | 将光标移到文件最后一行行首                 |
   | -     | 将光标向上移动一行，与k相同                |
   | +     | 将光标向下移动一行，与j相同                |

6. 在屏幕上移动
   
   | 操作  | 说明            |
   | --- | ------------- |
   | M   | 将光标移动至当前屏幕中间  |
   | L   | 将光标移动至当前屏幕最下方 |
   | H   | 将光标移到至当前屏幕最上方 |

7. 回到初始位置：`''`

8. 调整显示文本
   
   | 操作     | 说明           |
   | ------ | ------------ |
   | Ctrl+D | 向下移动半屏文本内容   |
   | Ctrl+U | 向上移动半屏文本内容   |
   | Ctrl+F | 显示文件下一屏的文本内容 |
   | Ctrl+B | 显示文件上一屏的文本内容 |

#### 4. 文本添加(进入插入模式)

| 操作  | 说明                        |
| --- | ------------------------- |
| i/I | 在光标当前位置左侧/行首插入文本          |
| a/A | 在光标当前位置右侧/行末插入文本          |
| o/O | 在光标当前位置下方/上方插入文本(会创建新的一行) |

#### 5. 文本查找与替换

1. 查找
   
   | 操作   | 说明            |
   | ---- | ------------- |
   | /str | 向下查找字符串str    |
   | ?str | 向上查找字符串str    |
   | n    | 在前两个的基础上查找下一个 |
   | N    | 在前两个的基础上查找上一个 |

2. 替换([查看键盘图](http://w -sog.xyz:8180/2022/05/25/91cab7cf54015.gif))
   
   | 操作                   | 说明                                |
   | -------------------- | --------------------------------- |
   | r                    | 对光标所在字符替换                         |
   | R                    | 对光标所在字符之后替换，直到按下Esc键结束            |
   | cw                   | 删除光标后的单词，并进入插入模式                  |
   | cc/S/C               | 删除当前行，并进入插入模式，详情查看键盘图             |
   | :s/word1/word2       | 将全文word1替换成word2                  |
   | cf(ch)               | c和f的组合，光标所在字符向后查找至ch删除之间内容并进入插入模式 |
   | :1,$ s/word1/word2   | 将全文每行**第一个**word1替换成word2         |
   | :1,$ s/word1/word2/g | 将全文所有word1替换成word2                |

#### 6. 文本复制、剪切和粘贴

| 操作                | 说明                             |
| ----------------- | ------------------------------ |
| yl                | 复制光标所在字符，前面可接数字表多个             |
| x/dl              | 剪切光标所在字符，前面可接数字表多个　　注：X剪切前一个字符 |
| yw/dw             | 复制/剪切光标后的一个单词，前面可加数字表多个        |
| yy/dd             | 复制/剪切光标所在行，前面可加数字表向后多行         |
| :2 copy/move 15   | 复制/剪切第二行内容到第十五行之后              |
| :1,6 copy/move 15 | 复制/剪切第一行到第六行内容到第十五行之后          |
| p                 | 粘贴到光标下一行                       |
| P                 | 粘贴到光标上一行                       |

#### 7. 重复与撤销

| 操作  | 说明           |
| --- | ------------ |
| .   | 重复执行上一条指令    |
| u   | 撤销上一个操作      |
| U   | 撤销在当前行上的所有修改 |

#### 8. 更改vim编辑器设置

| 操作                       | 说明                |
| ------------------------ | ----------------- |
| :set [no]nu/number       | [不]显示行号           |
| :set [no]ai/autoindent   | [不]设置自动缩进         |
| :set showmode/noshowmode | 显示/关闭当前编辑状态       |
| :set [no]ic/ignorecase   | 搜索时[不]忽略大小写       |
| :set list/nolist         | 显示/隐藏特殊字符         |
| :set [no]sm/showmath     | [不]开启特殊字符匹配，如括号   |
| :set wm/wrapmargin=n     | 设置输入长文本距离右边界多少时换行 |
| :set all                 | 查看所有设置值           |

**编辑器的默认配置文件：在当前用户主目录(~)下创建一个.vimrc文件进行配置**
**neovim 使用sudo保存文件：`:w !sed '1i password' | sudo -S tee % >/dev/null`**

## 13. Shell编程([教程](https://www.runoob.com/linux/linux-shell.html),[shell字符串](https://blog.csdn.net/dongwuming/article/details/50605911))

### 1. Shell变量

#### 1. 变量类别

* **本地变量(局部变量)**：也称为用户自定义变量，是在当前shell环境，当前进程内有效的变量，一般在脚本或命令中定义
* **环境变量**：相当于全局变量，也称为**系统变量**。它与本地变量的差别在于它可以用于所有用户进程，和windows系统的环境变量类似
* **预定义变量**：也称**shell变量**，相当于C语言中主函数变量，执行脚本程序时就被认定且不再改变

#### 2. 常见预定义变量

| 特殊变量名  | 说明                                    |
|:------ | ------------------------------------- |
| $#     | 存储shell程序中命令行参数的个数                    |
| $?     | 存储shell中上一个程序执行的返回值(0表示命令执行成功，非0表示出错) |
| $[1-n] | 存储第[1-n]个命令行参数                        |
| $0     | 存储shell程序自己的名称                        |
| $*     | 存储shell脚本的所有参数(不包括$0)                 |
| $$     | 存储shell脚本的进程号(pid)                    |

#### 3. [read命令](https://www.runoob.com/linux/linux-comm-read.html)

语法：

```shell
read [-ers] [-a aname] [-d delim] [-i text] [-n nchars] [-N nchars] [-p prompt] [-t timeout] [-u fd] [name ...]
```

* -a 后跟一个变量，该变量会被认为是个数组，然后给其赋值，默认是以空格为分割符。
* -d 后面跟一个标志符，其实只有其后的第一个字符有用，作为结束的标志。
* -p 后面跟提示信息，即在输入前打印提示信息。
* -e 在输入的时候可以使用命令补全功能。
* -n 后跟一个数字，定义输入文本的长度，很实用。
* -r 屏蔽\，如果没有该选项，则\作为一个转义字符，有的话 \就是个正常的字符了。
* -s 安静模式，在输入字符时不再屏幕上显示，例如login时输入密码。
* -t 后面跟秒数，定义输入字符的等待时间。
* -u 后面跟fd，从文件描述符中读入，该文件描述符可以是exec新开启的。

### 2. 选择结构

#### 1. 条件判断式：`test`

1. 文件存在性测试：
   
   | 参数  | 说明                           |
   | --- | ---------------------------- |
   | -e  | 文件是否存在                       |
   | -f  | 文件是否存在且为文件(file)             |
   | -d  | 文件是否存在且为目录(directory)        |
   | -b  | 文件是否存在且为一个block device文件     |
   | -c  | 文件是否存在且为一个character device文件 |
   | -S  | 文件是否存在且为一个Socket文件           |
   | -p  | 文件是否存在且为一个FIFO(pipe)文件       |
   | -L  | 文件是否存在且为一个链接文件               |
   
    例：`test -e file`
   
    >若当前目录下存在文件file，返回值为真，否则为假

2. 文件的权限测试：
   
   | 参数  | 说明                           |
   | --- | ---------------------------- |
   | -r  | 检测该文件是否存在且具有**可读**的权限        |
   | -w  | 检测文件是否存在且具有**可写**的权限         |
   | -x  | 检测文件是否存在且具有**可运行**的权限        |
   | -u  | 检测文件是否存在且具有**SUID**的属性       |
   | -g  | 检测文件是否存在且具有**SGID**的属性       |
   | -k  | 检测文件是右存在且具有**Sticky bit**的属性 |
   | -s  | 检测文件是否存在且为**非空白文件**          |
   
    例：`test -r file`
   
        若当前目录下文件file可读，返回值为真，否则为假

3. 文件的新旧测试：
   
   | 参数  | 说明                        |
   | --- | ------------------------- |
   | -nt | 判断两个文件到底哪一个文件要新           |
   | -ot | 判断两个文件哪个文件要旧              |
   | -ef | 判断两个文件是否为同一文件， 可用于判断硬链接文件 |

4. 数值大小测试：
   
   | 参数  | 说明                                  |
   | --- | ----------------------------------- |
   | -eq | 测试两数值是否相等(equal)                    |
   | -ne | 测试两数值是否不等(not equal)                |
   | -gt | 测试前一个数值n1是否大于后一个数值n2(greater than)  |
   | -lt | 测试n1是否小于n2(less than)               |
   | -ge | 测试n1是否大于等于n2(greater than or equal) |
   | -le | 测试n1是否小于等于n2(less than or equal)    |
   
    例：`test n1 -eq n2`
    若数值n1与n2相等，返回值为真，否则为假

5. 字符串测试
   
   | 参数  | 说明                             |
   | --- | ------------------------------ |
   | -z  | 用于测试字符串长度是否为0，若字符串为空，则返回true   |
   | -n  | 用于测试字符串长度是否为非0，若字符串为非空，则返回true |
   | =   | 用于判断两个字符串是否相等，苦相等则返回true       |
   | !=  | 用于判断两个字符串是否不相等，若不相等，则返回true    |
   
    例：
   
   * `test -z string`: 测试string是否为空
   * `test str1 = str2`: 测试str1与str2是否相等
       **注：' = '与 ' != '两边要加空格**

6. 多重条件判定
   
   | 参数  | 说明                     |
   | --- | ---------------------- |
   | -a  | 两种情况同时成立时才回传true(and)  |
   | -o  | 两种情况任何一个成立就可回传true(or) |
   | !   | 状态取反                   |
   
    例：
   
   * `test -r file -a -x file`: 表示file同时具有r与x权限时才回传true
   * `test ! -x file`: 表示file不具有x权限时，回传true

综合例：
使用者输入一个文件名，程序判断：

* 这个文件是否存在，左路不存在则给予一个**Filename does not exist**的信息，并中断程序
* 若这个文件存在，则判断它是文件还是目录，结果输出**Filename is regular file**或**Filename is directory**
* 判断当前用户对这个设施或目录所拥有的权限，并输出权限信息

程序：

```shell
:<<!
让使用者输入文件名，并且判断使用者是否真的有输入字符串
!
echo -e "Please input a filename, I will check the filename's type and permission. \n\n"
read -p "Input a filename : " filename
test -z $filename && echo "You MUST input a filename." && exit 0
# 判断文件是否存在？若不存在则显示信息并结束脚本
test ! -e $filename && echo "The filename '$filename' DO NOT exist" && exit 0
# 开始判断文件类型与属性
test -f $filename && filetype="regulare file"
test -d $filename && filetype="directory"
test -r $filename && perm="readable"
test -w $filename && perm="$perm writable"
test -x $filename && perm="$perm executable"
# 开始输入
echo "The filename: $filename is a $filetype"
echo "And the permissions are : $perm"
```

#### 2. 条件判断符：[]

说明：

* 能实现和test命令一样的功能
* 为了与通配符区分，各元素间均有空格

例：
`[ 1 -eq 2 ]`: 判断1与2是否相等(**注意[,]与内容间有空格**)

#### 3. if-else

用法：

```shell
if [ 条件判断式1 ]; then        # 可以把then写在下一行，就不用写;
    语句1
elif  [ 条件判断式2 ]; then
    语句2
else
    语句3
fi
```

例：

```shell
num1=100    # 等号两边不能有空格
num2=100
if [ $num1 -eq $num2 ]
then
    echo '两个数相等！'
else
  echo '两个数不相等！'
fi
```

#### 4. case

```shell
case  <变量>  in
       <字符串1> )  {<命令清单1>};;    
           ...
    <字符串n> )  {<命令清单n>};;
    *)    {其他命令};;
esac
```

例：写一个shell脚本命名为capital，要求运行程序时输入国家名字，程序能输出这个国家的首都

```shell
#!/bin/bash
case $1 in
  China)   echo Beijing;;    # 注意是两个;相当于break
  USA)      echo Washington;;
  British)  echo London;;
  Russia)   echo Moskow;;
  *)echo Out of my knowledge;; 
esac
```

### 3. 循环结构

#### 1. for循环语句

* 语法一：
  
  ```shell
  for((变量赋值;条件判断;变量迭代))
  do
      语句块
  done
  ```
  
    注意：for语句中一定要以do开始及以done结尾
    例：编写一个for循环，输入0-4共5个数值
  
  ```shell
  #!/bin/bash
  #第一行表示用bash执行
  for((i=0;i<5;i++))
  do
  echo $i, is a number
  done
  ```

* 语法二
  
  ```shell
  for var in item1 itme2 ... itemN
  do
      语句块
  done
  ```
  
    例1：编写一个for循环，变量的取值列表为：dog cat lion tiger，输出结果
  
  ```shell
  #!/bin/bash
  for animal in dog  cat  lion tiger
  do
      echo “There are ${animal}s.”
  done
  ```
  
    例2：
  
  ```shell
  #!/bin/bash
  list="beijing tianjing shanghai guangzhou"
  list=$list"  xizang"
  for  scenery  in  $list
  do 
      echo “Have you visited $scenery?”
  done
  :<<!
  输出：
  Have you visited beijing?
  Have you visited tianjing?
  Have you visited shanghai?
  Have you visited guangzhou?
  Have you visited xizang?
  !
  ```
  
    注：若列表对象中有空格，可以用""包含

#### 2. while循环语句

语法：

```shell
while [条件判断式]
do
    语句块
done
```

注：当条件判断式成立时，执行循环，while后面没有:
例：
当用户输入break或者BREAK才结束程序执行，否则就一直告知用户输入字符串，并将用户输入字符串输出

```shell
#!/bin/bash
while [ "$yn" != “break" -a "$yn" != “BREAK" ]
do
    read -p “Please input a string :  (break/Break to stop) " yn
    echo You input a string : $yn
done
echo "OK! you interrupt the program."
```

## 14. 文档编辑

### 1. [sed命令](https://www.runoob.com/linux/linux-comm-sed.html)(其它[教程](https://www.cnblogs.com/heziliang/p/15121513.html))

[sed命令](https://www.runoob.com/linux/linux-comm-sed.html)(其它[教程](https://www.cnblogs.com/heziliang/p/15121513.html))
特点：

* 从文件中读入一行数据并把它保存在临时缓冲区中
* 处理临时缓冲区的内容，并将处理结果发送到显示器上
* 逐行处理文件所有内容直到最后一行

语法：

```shell
sed [-hnV][-e<script>][-f<script文件>][文本文件]
```

* 选项
  
  | 选项           | 说明                              |
  | ------------ | ------------------------------- |
  | -n           | 仅显示script处理后的结果                 |
  | -e\<script\> | 以选项中指定的script来处理输入的文本文件(**默认**) |
  | -f<script文件> | 以选项中指定的script**文件**来处理输入的文本文件   |
  | -r/-E        | sed使用扩展正则表达式                    |
  | -i           | 直接修改文档读取的内容，不在屏幕上输出             |

* script
  
  * 地址定位：
      例：
    
    * 将第三行的A替换为you：`sed '3s/A/you/g' file`
    * 将奇数行的A替换为you：`sed '1~2 s/A/you/g' file`
    * 将第1行(含)和第2行(含)之间的A替换为you：`sed '1,2s/A/you/g' file`
    * 将第1行和之后4行之间的A替换为you：`sed '1,+4s/A/you/g' file`
    * 将文件的A替换为you：`sed 's/A/you/g' file`
    * 和正则表达式搭配使用，将行首为#号的行中A替换为you：`sed '/^#/ s/A/you/g' file`
  
  * 编辑命令：
    
    | 选项  | 说明                      |
    | --- | ----------------------- |
    | a   | 在指定行后面追加文本；支持使用\n实现多行追加 |
    | i   | 在指定行前面插入文本              |
    | d   | 删除匹配的行                  |
    | s   | 替换字符串                   |
    | c   | 替换匹配行                   |
    
      例：
    
    * 在文件file中第一行后加两行：`sed '1a aa\naa' file`
    * 删除第一行：`sed '1d' file`
    * 将第一行的A替换为you：`sed '1s/A/you/g' file` 
    * 将第一行替换为hello,world: `sed '1c hello,world' file`
    * 将每一行后面加上.mp4并为每一行两端添加单引号：`sed "s/$/.mp4/;s/.*/'&'/" file`
  
  * 正则表达式说明
      sed中使用正则表达式使用**//**包涵，其中上例中`sed '3s/A/you/g' file`中`A`与`you`就是正则表达式，即先在匹配的行中找到'A'然后用'you'替换，例如：
    
      ​    将第三行的A后面加上一个B：`sed '3s/A/&B/g' file`或`sed '3s/\(A\)/\1B/g' file`
    
      说明
    
    * 其中对于'&'代表匹配结果，'1'代表匹配结果的第一个分组；
    * 对于第二种写法，若不想对特殊符号转义'\\'可以使用'-r'选项，然后改写为：
        `sed -r '3s/(A)/\1B/g' file`

### 2. [awk命令](https://www.runoob.com/linux/linux-comm-awk.html)

* 命令语法：
    `awk 'BEGIN{ commands } pattern{ commands } END{ commands }' file`

* awk命令运行过程
  
  * 通过关键字BEGIN执行BEGIN后花括号{}后的内容

* pattern部分匹配成功后，依次对该行执行pattern后花括号后的内容，循环读取文件直到文件结束。
  
  * 开始 END 块执行，END 块可以输出最终结果。

* 选项
  
  | 选项           | 说明                                  |
  | ------------ | ----------------------------------- |
  | -f file      | 从脚本文件中读取awk命令                       |
  | -v var=value | 赋值一个用户定义变量                          |
  | -F fs        | 指定输入文件分隔符(改变变量FS的值)，fs是一个字符串或者正则表达式 |

* 内建变量
  
  | 变量          | 说明                              |
  | ----------- | ------------------------------- |
  | $n          | 当前记录的第n个字段，字段间由FS分隔             |
  | $0          | 完整的输入记录                         |
  | ARGC        | 命令行参数的数目                        |
  | ARGIND      | 命令行中当前文件的位置(从0开始算)              |
  | ARGV        | 包含命令行参数的数组                      |
  | CONVFMT     | 数字转换格式(默认值为%.6g)ENVIRON环境变量关联数组 |
  | ERRNO       | 最后一个系统错误的描述                     |
  | FIELDWIDTHS | 字段宽度列表(用空格键分隔)                  |
  | FILENAME    | 当前文件名                           |
  | FNR         | 各文件分别计数的行号                      |
  | FS          | 字段分隔符(默认是任何空格)                  |
  | IGNORECASE  | 如果为真，则进行忽略大小写的匹配                |
  | NF          | 一条记录的字段的数目                      |
  | NR          | 已经读出的记录数，就是行号，从1开始              |
  | OFMT        | 数字的输出格式(默认值是%.6g)               |
  | OFS         | 输出字段分隔符，默认值与输入字段分隔符一致。          |
  | ORS         | 输出记录分隔符(默认值是一个换行符)              |
  | RLENGTH     | 由match函数所匹配的字符串的长度              |
  | RS          | 记录分隔符(默认是一个换行符)                 |
  | RSTART      | 由match函数所匹配的字符串的第一个位置           |
  | SUBSEP      | 数组下标分隔符(默认值是/034)               |

* 例：
    Mike Harrington:[510] 548-1278:250:100:175
    Christian Dobbins:[408] 538-2358:155:90:2
    01Susan Dalsass:[206] 654-6279:250:60:50
    Archie McNichol:[206] 548-1348:250:100:175
    Jody Savage:[206] 548-1278:15:188:150
    Guy Quigley:[916] 343-6410:250:100:175
    Dan Savage:[406] 298-7744:450:300:275
    Nancy McNeil:[206] 548-1278:250:80:75
    John Goldenrod:[916] 348-4278:250:100:175
    Chet Main:[510] 548-5258:50:95:135
    Tom Savage:[408] 926-3456:250:168:200
    Elizabeth Stachelin:[916] 440-1763:175:75:300
  
  * 显示所有电话号码：`awk -F: '{print $2}' awk_exercise`
  * 显示Susan的姓名和电话号码：`awk -F[:\ ] '$1=="Susan"{print $1,$2":"$3,$4}' awk_exercise                                                    `
  * 显示Mike的总捐款：`awk -F[:\ ] '$1=="Mike"{print $5+$6+$7}' awk_exercise`
  * 显示Savage的全名和电话号码：`awk -F: '$1~/Savage/{print $1":"$2}' awk_exercise`

## 15. [shell快捷键](https://www.cnblogs.com/vwei/p/15858145.html)

### 编辑命令

- Ctrl + a ：移到命令行首
- Ctrl + e ：移到命令行尾
- Ctrl + f ：按字符前移（右向）
- Ctrl + b ：按字符后移（左向）
- Alt + f ：按单词前移（右向）
- Alt + b ：按单词后移（左向）
- Ctrl + xx：在命令行首和光标之间移动
- Ctrl + u ：从光标处删除至命令行首
- Ctrl + k ：从光标处删除至命令行尾
- Ctrl + w ：从光标处删除至字首
- Alt + d ：从光标处删除至字尾
- Ctrl + d ：删除光标处的字符
- Ctrl + h ：删除光标前的字符
- Ctrl + y ：粘贴至光标后
- Alt + c ：从光标处更改为首字母大写的单词
- Alt + u ：从光标处更改为全部大写的单词
- Alt + l ：从光标处更改为全部小写的单词
- Ctrl + t ：交换光标处和之前的字符
- Alt + t ：交换光标处和之前的单词
- Alt + Backspace：与 Ctrl + w ~~相同~~类似，分隔符有些差别

### 重新执行命令

- Ctrl + r：逆向搜索命令历史
- Ctrl + g：从历史搜索模式退出
- Ctrl + p：历史中的上一条命令
- Ctrl + n：历史中的下一条命令
- Alt + .：使用上一条命令的最后一个参数

### 控制命令

- Ctrl + l：清屏
- Ctrl + o：执行当前命令，并选择上一条命令
- Ctrl + s：阻止屏幕输出
- Ctrl + q：允许屏幕输出
- Ctrl + c：终止命令
- Ctrl + z：挂起命令

### Bang (!) 命令

- !!：执行上一条命令
- !blah：执行最近的以 blah 开头的命令，如 !ls
- !blah:p：仅打印输出，而不执行
- !$：上一条命令的最后一个参数，与 Alt + . 相同
- !$:p：打印输出 !$ 的内容
- !*：上一条命令的所有参数
- !*:p：打印输出 !* 的内容
- ^blah：删除上一条命令中的 blah
- ^blah^foo：将上一条命令中的 blah 替换为 foo
- ^blah^foo^：将上一条命令中所有的 blah 都替换为 foo
