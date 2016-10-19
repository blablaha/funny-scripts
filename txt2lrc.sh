#!/bin/bash
#########################################################################
# Author: (zhangjunhui@domob.cn)
# Created Time: 2016-10-19 14:18:16
# File Name: txt2lrc.sh
# Description: maxOs 10.12
#########################################################################

if [ $# != 1 ];then
	echo "Usage: $0 <mp3> <txt> <output-lrc>"
	exit 1
fi

MP3=$1
LRC=$2

T='00:00:00'
begin=`date +"%s"`

function tag(){
	base=$1
	cur=`date +"%s"`
	sec=$[ $cur-$base ]
	h=$[ $sec/3600 ]
	m=$[ $sec/60 ]
	s=$[ $sec%60 ]
	T=`printf "%02d:%02d:%02d" $h $m $s`
}

# print lrc

cat $LRC

#sleep 2
sleep 2

#play music
afplay "$MP3" &

#read lines
OLD_IFS=$IFS
IFS=$'\n'
rm -f $3
for line in `cat $LRC`
do
	# print line
	echo '>>' $line
	read -d " "
	tag $begin
	L='['$T']'$line
	echo $L
	echo $L >> $3
done
IFS=$OLD_IFS


# vim: set noexpandtab ts=4 sts=4 sw=4 :
