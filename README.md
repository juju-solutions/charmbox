# Charmbox

Charmbox is an extension of the [jujubox](https://registry.hub.docker.com/u/whitmo/jujubox/)
container which adds tools for development, testing, and review of Juju Charms.


## Usage


### Juju Inside Docker

If you already have Docker installed (see below), and you don't want to install
Juju on your host machine, the container can be run directly from Docker Hub:

    sudo docker run --rm -ti jujusolutions/charmbox

Once inside the container, you can use quickstart to set up Juju with any provider
except local, and use bundletester to test a charm:

    $ubuntu@ab3d:~/$ juju quickstart
    $ubuntu@ab3d:~/$ bundletester -t cs:trusty/ubuntu

Note that local provider is not currently available within the container,
but it is possible to use an existing local provider with Charmbox (see below).


### Using Charmbox with Existing Juju

If you already have Juju configured, you can use your existing Juju installation,
including any environments, with a few extra arguments to the run command:

    sudo docker run --rm -ti --net=host -v $HOME/.juju:/home/ubuntu/.juju jujusolutions/charmbox


### Using Charmbox with Existing Juju and Local Provider

If you wish to use local provider, you will need to bootstrap from **outside**
the container, but all subsequent operations will work normally within the
container:

    juju switch local
    juju bootstrap
    sudo docker run --rm --net=host -v $HOME/.juju:/home/ubuntu/.juju -ti charmbox

Once inside the container, you can use bundletester to test a charm:

    $ubuntu@ab3d:~/$ bundletester -t lp:~user/charms/trusty/foo/branch
    $ubuntu@ab3d:~/$ exit

Once you are done with the container, make sure you destroy the local provider that
you bootstrapped:

    juju destroy-environment local


### Using Charmbox with Charms on your Host Machine

If you have charms already checked out on your host machine, you can mount the
Juju repository subdirectory:

    sudo docker run --rm -ti -v $JUJU_REPOSITORY/trusty:/home/ubuntu/trusty jujusolutions/charmbox

At this time, you cannot directly mount `$JUJU_REPOSITORY` inside
the container because it would overwrite `/home/ubuntu`.  Thus, it is
recommended that you mount the `trusty` or `precise` subdirectories.

### Mounting CWD into charmbox for testing

You can map the current working directory into charmbox for testing a single
charm:

    sudo docker run --rm -ti -v $(pwd):/home/ubuntu/trusty/{charm} jujusolutions/charmbox


## Building Charmbox from Source

    git clone https://github.com/juju-solutions/charmbox.git && cd charmbox
    sudo docker build -t charmbox .
    sudo docker run --rm -ti charmbox


## Installing Docker

### Linux

Install Docker using the package manager for your distro, or
[get.docker.com](https://get.docker.com/).

Docker >= 1.4.1 recommended.

### OS X

Docker does not run natively in OS X, so we'll need to use VirtualBox
and docker-machine. This is relatively easy for users of brew:

    brew install cask
    brew cask install virtualbox
    brew install docker
    brew install docker-machine

    docker-machine create -d virtualbox default
    docker-machine start default && eval $(docker-machine env default)

When docker-machine finishes, it will prompt you to export Docker
environment variables. With that done, you're ready to use docker.

    docker run  -ti jujusolutions/charmbox
