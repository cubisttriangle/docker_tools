# Docker environment for working with the Raspberry Pi Pico

The docker container can be built using `build.sh` and it can be run using `run.sh`. This container mounts `/mnt/pico` to the same location inside the container, so the pico actually needs to be mounted at this location first. See the following sections for how to mount the device.

## Manually mounting the pico

This is info is documented in section 3.2 of 'Getting started with Raspberry Pi Pico'.

You may notice that your pico doesn't show up `/dev/tty*`, however `dmesg` shows it getting mounted as a mass storage device. Mounting the pico will allow you load uf2 binaries by copying them to the mount point. Note: the pico only shows up as a USB serial device if the program is compiled with it enabled.

To mount the pico, find the pico device partition:
> `lsblk -f`

On my system, I see an entry like this:
>`-sdi1      vfat   FAT16 RPI-RP2         000A-2F41

If you don't see a simlar entry, you might need to change the boot mode by holding down BOOTSEL on the pico and plugging it in.

Now create a mount point and mount the pico:

> `sudo mkdir /mnt/pico`
> 
> `sudo mount -o gid=users,fmask=113,dmask=002 /dev/sdi1 /mnt/pico`

## Auto-mounting the pico with udev

Create the mount point: `sudo mkdir /mnt/pico`

Add the following rule to a new file in `/etc/udev/rules.d`:
> `ACTION=="add", SUBSYSTEMS=="usb", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", RUN+="/usr/bin/logger --tag rpi-pico-mount Mounting what seems to be a Raspberry Pi Pico", RUN+="/usr/bin/systemd-mount --no-block --collect -o gid=users,fmask=113,dmask=002 $devnode /mnt/pico"`

Then reload udev with: `sudo udevadm control --reload`

On the next plug event (while `BOOTSEL` is depressed), the pico should get mounted to: `/mnt/pico`

To debug, watch the system log with: `journalctl -f`

## Building for your board
The pico-sdk supports many [board layouts](https://github.com/raspberrypi/pico-sdk/tree/master/src/boards/include/boards). If you're not using the Raspberry Pi Pico, you may need to export the `PICO_BOARD` environment variable before running cmake and including the `pico-sdk`. For example, if you are using the Sparkfun Pro Micro RP2040 board, do `export PICO_BOARD="sparkfun_promicro"`. This lets the `pico-sdk` know you want to use the board definitions supplie in [sparkfun_promicro.h](https://github.com/raspberrypi/pico-sdk/blob/master/src/boards/include/boards/sparkfun_promicro.h).

## Loading a program
After mounting the pico, you can load a new program by copying:

> `sudo cp blink.uf2 /mnt/pico`
> 
> `sudo sync`

Once the pico restarts, you should see that your program is running.
