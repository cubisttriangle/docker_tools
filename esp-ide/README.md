# ESP-32 development environment

## Build the environment

    docker build -t esp-env .

## Run a container, mounting your code

First go into the directory where you esp project code is:

    cd /my/code/dir

Get the path to the esp serial device, for example `/dev/ttyUSB0`. To access the device, you'll need to give yourself permission to user the device (usually by adding your user to a group like 'dialout' or 'uucp').

Now, run a container instance that mounts the current directory:

    docker run --name esp-dev -it --rm --net=host --device=/dev/ttyUSB0 -w /code -v $PWD:/code:delegated esp-env

You should now be in a shell of the container. Your current directory should be your code dir, mounted in the container. This allows you to easily develop your code using whatever IDE you like, but build with the container environment.

## If you haven't already, configure your project

This first thing to do with any project is to set the target. Once you're in your container, run the following commands (assuming using ESP32):

    idf.py set-target esp32
    idf.py menuconfig

## Build and flash your project!

    idf.py build
    idf.py -p /dev/ttyUSB0 flash
