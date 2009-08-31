#!/bin/bash
#for bla in 200*; do (cd $bla; make;); done
archs=`cat ARCHS.txt`
timestamp=`cat timestamp`
for bla in $archs; do (cd $timestamp/$bla; make V=99;) ||exit ;done

