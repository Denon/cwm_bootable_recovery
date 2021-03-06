#!/sbin/sh

#
#
# mount filesystem

BB="busybox"
MOUNT="busybox mount"
UMOUNT="busybox umount -f"

$BB date >>/tmp/mount_fs.txt
exec >>/tmp/mount_fs.txt 2>&1

$UMOUNT /system
$UMOUNT /data
if $BB [ ! -d /.secondrom ] ; then
$BB mkdir -p /.secondrom
fi

BLOCKDEVICE=mmcblk1p1

########## initial preparation of dualboot recovery ##############################################
if [ "$1" == "initial" ] ; then

if ! $BB grep -q /.secondrom /proc/mounts ; then
        $MOUNT -t ext4 -o rw /dev/block/$BLOCKDEVICE /.secondrom
   fi
$BB mkdir -p /.secondrom/data/media
   $UMOUNT /data/media
   if ! $BB grep -q /data/media /proc/mounts ; then
        $BB mkdir -p /data/media
        $MOUNT -r /.secondrom/data/media /data/media
   fi

elif [ "$1" == "boot_primary" ] ; then
   $MOUNT -t ext4 -o rw /dev/block/$BLOCKDEVICE /.secondrom
   $BB echo 0 > /.secondrom/.secondaryboot

elif [ "$1" == "boot_secondary" ] ; then
   $MOUNT -t ext4 -o rw /dev/block/$BLOCKDEVICE /.secondrom
   $BB echo 1 > /.secondrom/.secondaryboot

else
        echo "missing paramter"
        exit 1
fi

exit 0
