# fodman

A GUI client for podman and podman remote client.

> currently fodman is in alpha test.

## Getting Started

### install podman

#### windows

`winget podman`

#### macos

`brew install podman`

#### arch

`yay -S podman`

#### others

see the document: [link](https://podman.io/getting-started/installation)

### install fodman

I recommend to compile fodman from source code.
Now, fodman is in testing.  
I cannot compile daily.  
sorry.

---

visit [release page](https://github.com/snowmerak/fodman/releases) and download zip file compatible with your system.

#### windows

unzip the zip file and run the executable file named fodman.

#### macos

1. unzip the zip file to `$HOME`.
2. add `$HOME/fodman.app/Contents/MacOS` to path variable.
3. run `fodman` on your terminal app.

I'm so sorry for the sandbox of macos app. I cannot disable sandbox for this app.  
I will make a installation script for macos app.

#### linux

1. unzip the zip file to `$HOME/fodman/bin`.
2. add `$HOME/fodman/bin` to path variable.
3. run `fodman` on your terminal app.

I will add a option create desktop entry for linux.

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

