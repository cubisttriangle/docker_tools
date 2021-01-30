#!/bin/bash

# Convenience script that runs the esp-env image and mounts the current directory into the container.
# The directory you would want to mount is probably the directory where your code resides.
# Whatever port the esp resides on can be set to 'esp_device', then you can flash from the container.
#
# $@ - command + args to run (default: /bin/bash)

instance_name="esp-dev"
esp_device="/dev/ttyUSB0"
image="esp-env"
dir="/code"
cmd=${@:-/bin/bash}

docker run --name $instance_name -it --rm --net=host \
    --device=$esp_device \
    -w $dir \
    -v $PWD:$dir:delegated \
    $image \
    $cmd
