# Working with Docker

## Install docker

Normally, it's best to get the [latest software](https://hub.docker.com/search?q=&type=edition&offering=community&operating_system=linux) from the docker website, but since this I'm running ArchLinux, I'll trust the package manager.

    sudo pacman -Su docker

## Load docker service

### Show all service units (enabled and disabled) on the system

    sudo systemctl list-unit-files

You should be able to find the `docker.service`

### Start docker service for the current session

    sudo systemctl start docker.service
    
### Check the status of the docker service

    sudo systemctl status docker.service

### Start docker service automatically for all sessions

    sudo systemctl enable docker.service

## Configure docker to run without needing sudo

The remaining steps will assume this step was taken, otherwise you'll need to prefix all the docker commands with `sudo`.

Make sure the `docker` group exists

    cat /etc/groups | grep docker

Add your user to the docker group

    sudo usermod -aG docker $USER

Enable group by logging out and logging back in, or reload your user in a shell

    su - $USER

Verify your user's groups

    id

## Download or update an image

    docker pull archlinux

### Show a list of images you've downloaded (also shows size)

    docker images
    
### Show information about a particular image

    docker inspect archlinux

## Cleanup

### Remove a docker image

    docker images rmi archlinux

### After testing a build, there maybe left over stuff - get rid of it

    docker image prune

