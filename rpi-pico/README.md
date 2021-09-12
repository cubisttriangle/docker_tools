# Docker environment for working with the Raspbery Pi Pico

The docker container can be built using `build.sh` and it can be run using `run.sh`.

## Mounting the pico

This is info is documented in section 3.2 of 'Getting started with Raspberry Pi Pico'.

You may notice that your pico doesn't show up `/dev/tty*`, however `dmesg` shows it getting mounted as a mass storage device. Mounting the pico will allow you load uf2 binaries by copying them to the mount point.

To mount the pico, find the pico device partition:
> `lsblk -f`

On my system, I see an entry like this:
>`-sdi1      vfat   FAT16 RPI-RP2         000A-2F41

If you don't see a simlar entry, you might need to change the boot mode by holding down BOOTSEL on the pico and plugging it in.

Now create a mount point and mount the pico:

> `sudo mkdir /mnt/pico`
> 
> `sudo mount -o uid=1000 /dev/sdi1 /mnt/pico`

## Loading a program
After mounting the pico, you can load a new program by copying:

> `sudo cp blink.uf2 /mnt/pico`
> `sudo sync`

Once the pico restarts, you should see that your program is running.
