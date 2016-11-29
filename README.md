# Charm Box

Charm box is a container project that provides a [Juju](https://jujucharms.com)
[Charm](https://jujucharms.com/docs/stable/charms) development environment. The
charmbox container includes tools for building, testing, and reviewing Juju
Charms.

Juju is an open source, universal model for applications. Juju allows you to 
deploy, configure, manage, maintain, and scale cloud services quickly and 
efficiently on public clouds, as well as on physical servers.

This container comes with the basic tools you need to get started with Juju and
Charms. It includes [charm-tools](https://github.com/juju/charm-tools) to 
build charms and [bundletester](https://github.com/juju-solutions/bundletester)
to test charms.

This container is built on top of the
[jujubox](https://github.com/juju-solutions/jujubox) container, adding tools
and functionality. Refer to the jujubox project for more information about the 
options to run that container and the volumes available.

To use this container you need to install Docker, download charmbox, and run
charmbox. 

# Install Docker

## Linux
Install Docker using the package manager for your Linux distribution, or
[get.docker.com](https://get.docker.com/). We recommend Docker version 1.6 or
greater.

## Mac OS X

There are several ways to 
[install Docker on Mac OS X](https://docs.docker.com/engine/installation/mac/). 
Consult the latest documentation on
[Getting Started with Docker for Mac](https://docs.docker.com/docker-for-mac/).

# Download charmbox

The easiest way to use charmbox is to simply pull the container from the
[Docker hub](https://registry.hub.docker.com/u/jujusolutions/charmbox/).

```
docker pull jujusolutions/charmbox
```

If you want to see the code you can download the charmbox project from 
[github](https://github.com/juju-solutions/charmbox) and build it from source.

```
git clone https://github.com/juju-solutions/charmbox.git && cd charmbox
docker build -t jujusolutions/charmbox ./
```

# Run charmbox

There are several different ways to run charmbox depending on what you are 
trying to accomplish. 

## Running charmbox to build Charms

The main use case for charm box is to build charms from layers and interfaces.
By using charmbox you do not need to install and configure the tools.

As with jujubox you should volume mount (-v) `$JUJU_DATA` directory from the 
host to the charmbox container so you preserve the Juju information between 
runs. The output from a charm build will be in `/home/ubuntu/charms/` so mount
the `$JUJU_REPOSITORY` directory to preserve the built artifacts. To have 
access to the layers and interfaces, mount the `$LAYER_PATH` and 
`$INTERFACE_PATH` from the host to the charmbox container. Remember the
charmbox file system is reset after you exit the container.

```
docker run --rm -it \
  -v $JUJU_DATA:/home/ubuntu/.local/share/juju \
  -v $JUJU_REPOSITORY:/home/ubuntu/charms \
  -v $LAYER_PATH:/home/ubuntu/charms/layers \
  -v $INTERFACE_PATH:/home/ubuntu/charms/interfaces \
  jujusolutions/charmbox
```

## Running charmbox to test Charms

Another use case for charmbox is to use the test tools included. In this case
you may need to mount the charm or bundle directory and run the `bundletester`
tool. You can map the current workign directory into charmbox for testing
a bundle or charm.

```
docker run --rm -it \
  -v $JUJU_DATA:/home/ubuntu/.local/share/juju \
  -v $JUJU_REPOSITORY:/home/ubuntu/charms \
  -v $PWD:/home/ubuntu/pwd \
  jujusolutions/charmbox
```

See the Environment Variables 
[reference](https://jujucharms.com/docs/2.0/reference-environment-variables)
for more details on `$JUJU_DATA`, `$JUJU_REPOSITORY`, `$LAYER_PATH` and 
`$INTERFACE_PATH` .

## charmbox and the LXD provider

At this time you can not run charmbox on the LXD provider inside of Docker
because of some nested container issues.  If you want to use the LXD provider
install Juju and LXD on the host system.

# More information

For more information about what you can do in charmbox check out the 
[Juju documenation](https://jujucharms.com/docs).

If you find any bugs please create an issue in the 
[jujubox github repository](https://github.com/juju-solutions/charmbox/issues).
