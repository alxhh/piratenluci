#!/bin/bash
#archs="brcm-2.4"
#archs="atheros"
archs="brcm-2.4 atheros x86"
echo $archs>ARCHS.txt
# dirs
mkdir dl
# timestamp

timestamp=`date "+%F_%H-%M"`
echo $timestamp >timestamp
date +"%Y/%m/%d %H:%M">VERSION.txt||exit
repoluci=~/dev/openwrt/piratenluci/
#get basic repos
git clone git://nbd.name/packages.git||exit
#git clone git://github.com/alxhh/piratenluci.git||exit
git clone $repoluci||exit

mkdir $timestamp
for arch in $archs;
do
	echo ----------------------------------------------------------------------------------------------
	echo doing ARCH $arch
	echo ----------------------------------------------------------------------------------------------
	git clone git://nbd.name/8.09.git||exit
	ln -s ../../dl 8.09/dl||exit
	echo src-link luci $PWD/piratenluci>8.09/feeds.conf||exit
	echo src-link packages $PWD/packages>>8.09/feeds.conf
	cd 8.09
	./scripts/feeds update||exit
	./scripts/feeds install -a -p luci||exit
	cp ../piratenluci/buildstuff/$arch/build.config .config||exit
	cp -R ../piratenluci/patches .||exit
	cp ../piratenluci/buildstuff/$arch/series patches/series||exit
	echo ----------------------------------------------------------------------------------------------
	echo next quilt in $PWD
	echo ----------------------------------------------------------------------------------------------
	quilt push -a||exit
	cp -Rv ../piratenluci/files .||exit
	echo Based on svn revision: `./scripts/getver.sh`>> files/etc/banner||exit
	echo Built `cat ../VERSION.txt` on `hostname`>> files/etc/banner||exit
	cd ..
	config_arch=`( . 8.09/.config; echo $CONFIG_ARCH;)`
	echo src/gz freifunk http://firmware.piratenfreifunk.de/piratenfreifunk/$timestamp/$arch/packages/$config_arch>>8.09/files/etc/opkg.conf||exit
	echo src/gz packages http://downloads.openwrt.org/kamikaze/8.09/$arch/packages>>8.09/files/etc/opkg.conf||exit
# update host
	mkdir 8.09/files/etc/uci-defaults||exit
	echo uci set freifunk.upgrade.repository=http://firmware.piratenfreifunk.de/piratenfreifunk/latest>8.09/files/etc/uci-defaults/piratenupdate
	echo uci commit freifunk >>8.09/files/etc/uci-defaults/piratenupdate
	mv 8.09 $timestamp/$arch||exit
done
