#!/bin/bash
clear
awkscript='
{
	letters="ATCG01bioinformatics"
	lines=$1
	random_col=$3
	c=$4
	letter=substr(letters,c,1)
	cols[random_col]=0;
	for (col in cols) {
		line=cols[col];
		cols[col]=cols[col]+1;
		printf "\033[%s;%sH\033[2;32m%s", line, col, letter;
		printf "\033[%s;%sH\033[1;37m%s\033[0;0H", cols[col], col, letter;
		if (cols[col] >= lines) {
			cols[col]=0;
		}
	}
}
'

while true; do
	s=`seq 15 30 | shuf | head -1`
	for i in `seq 1 $s`; do
		echo -n " "
	done
	name=`cat 18.bioinformatics.txt | shuf | head -1`
	wishes=`cat wishes.txt | shuf | head -1`
	echo -n -e "\033[44m $name \033[0m"
	echo -e "\033[42;5m ******$wishes****** \033[0m"
	cat art.txt | while read line; do
		echo | awk '{printf "\t\t\t\t\t"}'
		echo -e "\033[41m$line\033[0m"
	done
	sleep 1s

	time=0
	lines=$(tput lines)
	cols=$(tput cols)
	while [ $time -lt 60 ]; do
		echo $lines $cols $(( $RANDOM % $cols )) $(( $RANDOM % 72 ))
		time=$(($time+1))
		sleep 0.05
	done | awk "$awkscript"
	echo -e "\033[0m"
	clear
done


# https://www.cnblogs.com/l5gw/p/6654610.html
# echo -e "\033[背景;字体颜色m 字符串\033[0m"
# eg : echo -e "\033[30m 黑色字 \033[0m"
 
# 字体颜色(30-37)
# ------------------

# 背景颜色(40-47)
# ------------------

# 特色功能
# ------------------
# \33[0m 关闭所有属性
# \33[1m 设置高亮度
# \33[4m 下划线
# \33[5m 闪烁
# \33[7m 反显
# \33[8m 消隐
# \33[30m — \33[37m 设置前景色
# \33[40m — \33[47m 设置背景色
# \33[nA 光标上移n行
# \33[nB 光标下移n行
# \33[nC 光标右移n行
# \33[nD 光标左移n行
# \33[y;xH设置光标位置
# \33[2J 清屏
# \33[K 清除从光标到行尾的内容
# \33[s 保存光标位置
# \33[u 恢复光标位置
# \33[?25l 隐藏光标
# \33[?25h 显示光标