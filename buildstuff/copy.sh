#!/bin/bash
timestamp=`cat timestamp`||exit
archs=`cat ARCHS.txt`
TARGET=/home/alx/public_html/piraten
rm -Rf $TARGET/$timestamp
rm -Rf $TARGET/latest
mkdir $TARGET/$timestamp||exit
for bla in $archs;
do
	cp -vR $timestamp/$bla/bin $TARGET/$timestamp/$bla||exit
	cp -v VERSION.txt $TARGET/$timestamp/$bla||exit
done
ln -s $timestamp $TARGET/latest||exit
rsync -v -r -l -S  --delete  --stats     /home/alx/public_html/piraten /srv/rsync
rsync -v -r -l -S  --delete  --stats     /home/alx/public_html/piraten alx@houston.dd19.de:public_html
