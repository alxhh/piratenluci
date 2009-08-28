#!/bin/sh

buildroot="$1"
mode="$2"

owrt_revision=$(LC_ALL=C svn info $buildroot | sed -ne 's/^Revision: //p')

luci_svnurl=$(sed -ne's#.*[ 	]\(.*luci.subsignal.org/luci/.*/.*/[^ 	]*\).*#\1#p' $buildroot/feeds.conf)
luci_version=$(echo $luci_svnurl | sed -ne's#.*luci.subsignal.org/luci/\(.*\)/\(.*\)/contrib.*#\1 \2#p')
luci_revision=$(LC_ALL=C svn info $luci_svnurl | sed -ne 's/^Revision: //p')

case "${luci_version%% *}" in
	tags)		luci_distro="Release ${luci_version##*[ -]} (r$luci_revision)";;
	branches)	luci_distro="Branch ${luci_version##*[ -]} (r$luci_revision)";;
	*)		luci_distro="Trunk (r$luci_revision)";;
esac

if [ "${mode:-banner}" = "banner" ]; then

cat <<EOF
  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 Freifunk Kamikaze ---------------------------------
  * OpenWrt Kamikaze 8.09.1 (r$owrt_revision)
  * LuCI $luci_distro
  * Freifunk Snapshot: $(date +"%Y/%m/%d %H:%M") ($(hostname))
 ---------------------------------------------------
EOF

elif [ "$mode" = "version" ]; then

echo "OpenWrt r$owrt_revision / LuCI r$luci_revision"

else

cat <<EOF
Freifunk Snapshot
Built $(date +"%Y/%m/%d %H:%M") on $(hostname)
OpenWrt 8.09.1 (r$owrt_revision)
LuCI $luci_distro
EOF

fi
