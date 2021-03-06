# fodman

![main-page](gallary/00%20main%20page.png)

A GUI client for podman and podman remote client.

> currently fodman is in beta test.

## Getting Started

### install dependency, podman

#### windows

`winget install podman`

#### macos

`brew install podman`

#### arch

`yay -S podman`

#### others

see the document: [link](https://podman.io/getting-started/installation)

### install fodman

visit [release page](https://github.com/snowmerak/fodman/releases) and download zip file compatible with your system.

#### windows

unzip the zip file and run the executable file named fodman.

#### macos

unzip the zip file to application folder.

#### linux

1. unzip the zip file to `$HOME/fodman/bin`.
   1. add `$HOME/fodman/bin` to path variable. and run `fodman` on your terminal app.
   2. or run `fodman` in terminal, and click the `create desktop entry` button.

## Features

### machines

1. support: 
   1. initialize a machine
   2. machine list
   3. select machine
   4. remove machine
2. will add:

### containers

1. support: 
   1. create container
   2. container list
   3. container start, stop, remove
   4. container pause, unpause
   5. container commands
2. will add:

### images

1. support: 
   1. local image list
   2. remove image
   3. search Image form remote registry
2. will add:
   1. push image to remote registry

### volume

1. support:
   1. create volume
   2. remove volume
2. will add:
   1. graph view

### network

1. support:
   1. create network
   2. network list and remove
2. will add:
   1. graph view

## galary

[link](https://github.com/snowmerak/fodman/blob/main/galaray/readme.md)
