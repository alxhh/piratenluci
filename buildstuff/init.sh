#!/bin/bash
#archs="brcm-2.4"
archs="atheros brcm-2.4 x86"
# dirs
mkdir dl
# timestamp

timestamp=`date "+%F_%H-%M"`
echo $timestamp >timestamp

#get basic repos
git clone git://nbd.name/packages.git
git clone git://github.com/alxhh/piratenluci.git

for arch in $archs;
do
	git clone git://nbd.name/8.09.git
	ln -s ../dl 8.09/dl
#	echo src-link packages $PWD/packages>8.09/feeds.conf
	echo src-link luci $PWD/piratenluci>>8.09/feeds.conf
	cd 8.09
	ln -s ../piratenluci/patches .
	quilt push -a
	cp -Rv ../piratenluci/files .
	./scripts/feeds update
	./scripts/feeds install -a -p luci
	cd ..
	cp piratenluci/buildstuff/$arch/build.config 8.09/.config
	config_arch=`( . 8.09/.config; echo $CONFIG_ARCH;)`
	echo src/gz freifunk http://dev.dd19.de/~alx/piraten/$timestamp/$arch/packages/$config_arch>>8.09/files/etc/opkg.conf
	mv 8.09 $arch
done
