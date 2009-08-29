#!/bin/bash
#archs="brcm-2.4"
archs="atheros"
#archs="atheros brcm-2.4 x86"
echo $archs>ARCHS.txt
# dirs
mkdir dl
# timestamp

timestamp=`date "+%F_%H-%M"`
echo $timestamp >timestamp
date +"%Y/%m/%d %H:%M">VERSION.txt

#get basic repos
#git clone git://nbd.name/packages.git
git clone git://github.com/alxhh/piratenluci.git

mkdir $timestamp
for arch in $archs;
do
	git clone git://nbd.name/8.09.git
	ln -s ../../dl 8.09/dl
#	echo src-link packages $PWD/packages>8.09/feeds.conf
	echo src-link luci $PWD/piratenluci>8.09/feeds.conf
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
# update host
	mkdir 8.09/files/etc/uci-defaults
	echo uci set freifunk.upgrade.repository=http://houston.dd19.de/~alx/piraten/latest>8.09/files/etc/uci-defaults/piratenupdate
	echo uci commit freifunk >>8.09/files/etc/uci-defaults/piratenupdate
	mv 8.09 $timestamp/$arch
done
