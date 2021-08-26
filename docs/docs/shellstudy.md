# Shell学习记录

谨记录学习笔记

## shell

首先，在```.sh```中确定需要的执行shell。

```bash
#!/bin/bash
```
## 常用命令

### find

```bash
find <directory> <options> <name>
```

### echo, cat

echo非标准输入，不支持内联重定向。
>ps: 内联重定向
>```bash
>command << EOF
>```

## 实用技巧

### 后台

```bash
sleep <time>
```

### 协程

### 管道

```bash
command1 options | command2 options
```