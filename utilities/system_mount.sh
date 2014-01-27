BB="busybox"
FILESYSTEM=$1
BLOCKDEVICE=mmcblk0p25


if $BB [ "$FILESYSTEM" == "secondary" ]; then
$BB mkdir -p /.secondrom
$BB mount -t ext4 /dev/block/$BLOCKDEVICE /.secondrom
$BB mount -t ext4 -o rw /.secondrom/media/.secondrom/system.img /system
elif $BB [ "$FILESYSTEM" == "primary" ] ; then
if $BB [ ! -d /sys/dev/block/179:22 ] ; then
        $BB mount -t ext4 -o rw /dev/block/mmcblk0p22 /system
   fi
fi
