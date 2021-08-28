# Arch折腾向导

谨记录个人折腾过程中值得记录的事，建议常看[ArchWiki](https://wiki.archlinux.org)&nbsp;&nbsp;[ArchWiki（中文）](https://wiki.archlinux.org/title/Main_page_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))（注： 中文翻译部分落后，建议跟英文对照）。

## 安装

具体以**Wiki**为主，建议安装前先看**Wiki**的**Install Guide**，可参考[ArchLinuxlTutorial](https://archlinuxstudio.github.io/ArchLinuxTutorial/)，本文仅作补充。

### 制作liveCD
    
可以在Root手机上安装**DriveDroid**，该软件能在手机上创建启动盘，以备不时之需。

### 禁用reflector（建议）

防止联网自动测速**源**，减少```/etc/pacman.d/mirrorlist```里的可用源
>方法: ```systemctl disable --now reflector.service```

### 分区可用cfdisk，分区类型可用LVM（建议）

cfdisk操作方便友好，LVM方便后期需要时调整分区大小（注：建议在liveCD中操作），建议安装前查看Wiki中各方式优缺点，根据**需要**选择。

### iwd无法上网

无线链接后仍无法ping成功，可执行```dhcpcd```，会自动分配IP地址。

### Archlinuxcn(AUR)与32位库

liveCD中： 
>```pacstrap```时，加上base-devel  （注： 安装AUR包时需要）

chroot时： 
    
修改```/etc/pacman.conf```
    
>开启32位支持： 去掉\[multilib\]一节中两行的注释
>
>开启Archlinuxcn： 在文档结尾处加入
>
>```
>[archlinuxcn]
>Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
>```
>
>保存后执行```pacman -Syyu```来刷新
>
>最后安装```archlinuxcn-keyring yay```
    
Enjoy ```yay``` ! **yay**使用请看ArchWiki。



## 使用

### 剩余空间不符的问题

系统会为Root账户保留默认5%的磁盘空间，对现在的大容量硬盘来说是很大的浪费，所以比如我1T的就给了他1%。

如下情况建议修改：

* 非常大 (例如 >50 G)
* 不被系统文件使用

> 具体操作： tune2fs -m 1.0 /dev/sdXY
>
> 注： 
>   * 1.0就是1%
>   * sdXY就是你分区时的磁盘

### 编译优化

长时间编译时，注意CPU温度。

以下操作均修改```/etc/makepkg.conf```。
    

* 舍弃通用性，针对本机自动优化

    默认生成的包在其他Arch上也能安装，我们可以设置其只根据自己机器配置优化

    >GCC 可以进行 CPU 自动检测，可以在编译时自动选择本地机器支持的优化。要使用它，删除所有 -march 和 -mtune，然后添加 -march=native
    >
    >例如： 
    >CFLAGS="-march=native -O2 -pipe -fstack-protector-strong -fno-plt"

* 减少编译时间

    一杯奶茶，悠闲快乐。

    * 并行编译
        
        默认单核，我们可以多核同时编译。

        >例如： 
        >
        >#-- Make Flags: change this for DistCC/SMP systems
        >
        >MAKEFLAGS="-j6"

    * 使用内存文件系统进行编译

        默认会在硬盘上生成中间文件，我们可以把它放到内存里，又快又减少SSD的磨损（注： 内存会老化，一般不会按次数磨损）。

        >例如： 
        >
        >#-- Specify a directory for package building.
        >
        >BUILDDIR=/tmp/makepkg

    * 缓存编译结果以供下次复用（建议）

        我觉得一般编译第三方内核时才需要。

        **ccache**可以将编译结果缓存起来供下次编译使用，减少编译时间。 

        >安装： sudo pacman -S ccache
        >
        >修改： BUILDENV=(!distcc color ***!***ccache check !sign) 去掉ccache前的!

### 后门检测

**chkrookit**, **clamav**, **rkhunter**等。

注： chkrookit会用到系统命令，可能被骗过检测，但也有解决办法。**各工具具体操作见其官网**。

### 实用软件

**onlyoffice** 高度兼容MS Office

**varaya** 傻瓜式全局代理

**gvim** 图形化vim，支持复制到系统剪切板（注： 建议用sudoedit代替sudo vim，修改sudoeit的默认编辑器请看ArchWiki）

**tlpui-git** 笔记本省电，默认配置就能用

## 结语

来Arch传火吧！奥利给！



