## Partitioning

Whenever I install linux, I try to at the least have a root partition and a home partition. I tend to set aside 30-50Gb for my root depending on how often I will use the computer. 

## Home Directory

![My home directory](/Images/organize-1.png)

People say its important to minimize dotfiles in your home directory, I personally Don't mind this as long as I don't have a large amount of unused ones.
I do have one thing I always do for folders (I also try to prevent having files in my home) in my home directory

## xdg-user-dirs

I personally find capital names of files super annoying as I have to cd to them a lot.
But by default folders like Documents, Downloads, Pictures etc. have capitalized names.
An easy way to fix this is to use `xdg-user-dirs`, you can make a file named `user-dirs.dirs` in `~/.config/`, just make sure that you make folders for the dirs beforehand. I currently use the settings:

```bash
XDG_DESKTOP_DIR="$HOME/gam"
XDG_DOCUMENTS_DIR="$HOME/doc"
XDG_DOWNLOAD_DIR="$HOME/dwn"
XDG_MUSIC_DIR="$HOME/snd"
XDG_PICTURES_DIR="$HOME/pix"
XDG_PUBLICSHARE_DIR="$HOME/"
XDG_TEMPLATES_DIR="$HOME/"
XDG_VIDEOS_DIR="$HOME/"
```

## Documents Directory

![My doc directory](/Images/organize-2.png)

My docuents directory contains not only docuents but also my repositories. I keep my repositories in the `rep` folder under a path with the website theyre origin exists in.
I keep the markdown source for all my documents in `src` and it compiles to `pdf`.

## Pictures Directory

![My pix directory](/Images/organize-3.png)

I try to keep my pictures sorted by what they are but often times I just dump random pictures into msc. I also use [bwp](https://github.com/budlabs/bwp) to manage my wallpapers, so I dont have to.

## Automatic File Sorting

I have a script I wrote in python that I use to keep my files sorted, you can see the source [here](https://gist.github.com/bob16795/96cd14f12d7988d5f725f973ebb6ec59), but really I would reccomend writing your own.
Its a fun project to learn a new language or just to spend time on.
