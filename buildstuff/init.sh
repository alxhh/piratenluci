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

#get basic repos
#git clone git://nbd.name/packages.git
git clone git://github.com/alxhh/piratenluci.git||exit

mkdir $timestamp
for arch in $archs;
do
	git clone git://nbd.name/8.09.git||exit
	ln -s ../../dl 8.09/dl||exit
#	echo src-link packages $PWD/packages>8.09/feeds.conf
	echo src-link luci $PWD/piratenluci>8.09/feeds.conf||exit
	cd 8.09
	./scripts/feeds update||exit
	./scripts/feeds install -a -p luci||exit
	cp ../piratenluci/buildstuff/$arch/build.config .config||exit
	cp -R ../piratenluci/patches .||exit
	cp ../piratenluci/buildstuff/$arch/series patches/series||exit
	quilt push -a||exit
	cd ..
	cp -Rv piratenluci/files 8.09||exit
	config_arch=`( . 8.09/.config; echo $CONFIG_ARCH;)`
	echo src/gz freifunk http://firmware.piratenfreifunk.de/piratenfreifunk/$timestamp/$arch/packages/$config_arch>>8.09/files/etc/opkg.conf
# update host
	mkdir 8.09/files/etc/uci-defaults||exit
	echo uci set freifunk.upgrade.repository=http://firmware.piratenfreifunk.de/piratenfreifunk/latest>8.09/files/etc/uci-defaults/piratenupdate
	echo uci commit freifunk >>8.09/files/etc/uci-defaults/piratenupdate
	mv 8.09 $timestamp/$arch||exit
done
