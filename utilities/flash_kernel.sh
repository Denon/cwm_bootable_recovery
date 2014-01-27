#!/sbin/sh
#
#
#

MOUNTPOINT=$1
if [ -f "$MOUNTPOINT"dualboot/boot.img ] ; then
	cp -f "$MOUNTPOINT"dualboot/boot.img /dev/block/mmcblk0p20 || exit 1
   fi
else
exit 1
fi

exit 0
