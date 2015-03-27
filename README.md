# Charmbox

Charmbox is an extension of the [jujubox](https://registry.hub.docker.com/u/whitmo/jujubox/)
container which adds tools for development, testing, and review of Juju Charms.


## Usage

If you already have Docker installed (see below), the container can be run
directly from Docker Hub:

    sudo docker run --rm -ti johnsca/charmbox

Once inside the container, you can use quickstart to set up Juju and
bundletester to test a charm:

    $ubuntu@ab3d:~/$ juju quickstart
    $ubuntu@ab3d:~/$ bundletester -t cs:trusty/ubuntu

Note that local provider is not currently available within the container,
but it is possible to use an existing local provider with Charmbox (see below).


### Using an Existing Juju With Charmbox

If you already have Juju configured, you can use your existing Juju,
including any environments, with a few extra arguments to the run command:

    sudo docker run --rm -ti --net=host -v $HOME/.juju:/home/ubuntu/.juju johnsca/charmbox

Note that if you are using local provider, you will need to bootstrap from
outside the container, but all subsequent operations will work normally within
the container:

    juju switch local
    juju bootstrap
    sudo docker run --rm --net=host -v $HOME/.juju:/home/ubuntu/.juju -ti charmbox
    $ubuntu@ab3d:~/$ bundletester -t lp:~user/charms/trusty/foo/branch
    $ubuntu@ab3d:~/$ exit
    juju destroy-environment local

If you have an existing local repository, you can also mount that:

    sudo docker run --rm -ti -v $JUJU_REPOSITORY/trusty:/home/ubuntu/trusty johnsca/charmbox


## Building from Source

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
and boot2docker. This is relatively easy for users of brew:

    brew install cask
    brew cask install virtualbox
    brew install docker
    brew install boot2docker

    boot2docker init
    boot2docker up

When boot2docker finishes, it will prompt you to export Docker
environment variables. With that done, you're ready to use docker.
You do not need to run the docker commands using sudo because
boot2docker runs as root.

    docker run  -ti whitmo/jujubox
