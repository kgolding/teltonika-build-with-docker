# RUT Firmware building using docker

## Setting up (you only need do this the once)

Download this repo:

`git clone github.com/kgolding/teltonika-build-with-docker`

Change into the new directory:

`cd teltonika-build-with-docker`

Download the Teltonika firmware source from https://wiki.teltonika-networks.com/view/Software_Development_Kit
currently RUT9XX_R_00.06.07.4

`wget https://wiki.teltonika-networks.com/gpl/RUT9XX_R_GPL_00.06.07.4.tar.gz`

Create a directory for the source files:

`mkdir src`

Uncompress the source into `src`:

`tar -xvzf RUT9XX_R_GPL_00.06.07.4.tar.gz -C src`

Build the docker image:

`docker build -t rutbuilder .`

You now have a local `rutbuilder` docker image that can build Teltonika firmware.

## Building the firmware

To run the docker container and open a terminal inside the container, with your `src` directory availble
inside the container as /home/build/src

`docker run --rm -it -v $(pwd)/src:/home/build/src rutbuilder`

Once in the container run `make` to build firmware for uploading via RUT web interface `src/bin/ar71xx/tltFws/RUT9XX_R_GPL_00.06.07.4_WEBUI.bin`

The docker image also includes the `nano` file editor and `mc` file manager.

See https://wiki.teltonika-networks.com/view/RUT_Software_Development_Kit_instructions