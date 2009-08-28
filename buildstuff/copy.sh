#!/bin/bash
timestamp=`cat timestamp`
for bla in $timestamp-*;
do
	cp -vR $bla/bin /home/alx/public_html/piraten/$bla;
	cp -v VERSION.txt /home/alx/public_html/piraten/$bla;
done
