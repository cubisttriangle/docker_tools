#!/bin/bash

# Convenience script that runs the image and mounts the current directory into the container.
# The directory you would want to mount is probably the directory where your code resides.
#
# $@ - command + args to run (default: /bin/bash)

instance_name="rpi-pico-dev"
usb_device="/dev/ttyUSB0"
image="ubunut-rpi-pico-env"
dir="/code"
cmd=${@:-/bin/bash}

docker run --name $instance_name -it --rm --net=host \
    --device=$usb_device \
    -w $dir \
    -v $PWD:$dir:delegated \
    $image \
    $cmd
