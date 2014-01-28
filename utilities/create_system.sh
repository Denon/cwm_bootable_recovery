#!/sbin/sh

BB="busybox"
FILESYSTEM=$1

BLOCKDEVICE=mmcblk1p1

if ! $BB grep -q /dev/block/$BLOCKDEVICE /proc/mounts ; then
        $mke2fs -t ext4 /dev/block/$BLOCKDEVICE
   fi

if ! $BB grep -q /.secondrom /proc/mounts ; then
        $MOUNT -t ext4 -o rw /dev/block/$BLOCKDEVICE /.secondrom
   fi

if ! $BB grep -q /data/media /proc/mounts ; then
        $BB mkdir -p /data/media
        $MOUNT -t ext4 -r /.secondrom/data/media /data/media
   fi

$BB mkdir -p /.secondrom/data
$BB mkdir -p /.secondrom/data/media
system=/.secondrom/system.img

if $BB [ ! -f $system ] ; then
        echo "no system.img found: creating it now..."
        # create a file 1.5Gb
        $BB dd if=/dev/zero of=$system bs=1024 count=1572864 || exit 2
        # create ext4 filesystem
        $BB mke2fs -F -T ext4 $system || exit 2
else
        echo "system.img found: nothing to do!"
        exit 1
fi

exit 0
