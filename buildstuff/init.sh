#!/bin/bash
archs="atheros"
#archs="atheros brcm-2.4 x86"
# dirs
mkdir dl

#get basic repos
git clone git://nbd.name/packages.git
git clone git://github.com/alxhh/piratenluci.git

for arch in $archs;
do
	git clone git://nbd.name/8.09.git
	ln -s ../dl 8.09/dl
	echo src-link packages $PWD/packages>8.09/feeds.conf
	echo src-link luci $PWD/piratenluci>>8.09/feeds.conf
	cd 8.09
	ln -s ../piratenluci/patches .
	quilt push -a
	ln -s ../piratenluci/files .
	./scripts/feeds update
	./scripts/feeds install -a -p luci
	cd ..
	cp piratenluci/buildstuff/$arch/build.config 8.09/.config
	mv 8.09 $arch
done
