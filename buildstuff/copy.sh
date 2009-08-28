#!/bin/bash
timestamp=`cat timestamp`
archs=`cat ARCHS.txt`
TARGET=/home/alx/public_html/piraten
rm -Rf $TARGET/$timestamp
rm -Rf $TARGET/latest
mkdir $TARGET/$timestamp
for bla in $archs;
do
	cp -vR $timestamp/$bla/bin $TARGET/$timestamp/$bla;
	cp -v VERSION.txt $TARGET/$timestamp/$bla;
done
ln -s $timestamp $TARGET/latest
