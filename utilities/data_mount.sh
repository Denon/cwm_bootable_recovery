#!/sbin/sh

BB="busybox"
FILESYSTEM=$1


BLOCKDEVICE=mmcblk1p1

if ! $BB grep -q /.secondrom /proc/mounts ; then
mount -t ext4 /dev/block/$BLOCKDEVICE /.secondrom || exit 1
fi

if ! $BB grep -q /data /proc/mounts ; then
if $BB grep -q secondary /etc/.firstrundone; then # secondary
        mkdir -p /.secondrom/data/media
        mkdir -p /data
        mount -r /.secondrom/data /data
        
   if ! $BB grep -q /data/media /proc/mounts ; then
        mkdir -p /data/media
        mount -r /.secondrom/data/media /data/media
        fi

 elif $BB grep -q primary /etc/.firstrundone; then # primary
        mkdir -p /data
        mount -t ext4 /dev/block/mmcblk0p25 /data || exit 1
   fi
fi


exit 0
