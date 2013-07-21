# Vimino

is a Vim plugin for Ino command-line toolkit. That allows you to build/clean
a [Ino][ino] project([see quickstart](http://inotool.org/quickstart)) and upload firmware to your Arduino directly from Vim.

> Current version is for Mac OS X only, Linux version will be soon as possible. 

## Installation

Prerequisity (not necessary if you want to configure everything by hand) is a
`Pathogen` plugin fo Vim. If you have one, everything you need to install
the plugin is:

```
cd ~/.vim/bundle
git clone https://github.com/rrada/vimino.git
```

and start using it.

## Usage

You must have to open a sketch in the current buffer. If no one is opened,
warn message is displayed.

```
<Leader> command is by default a '\' key
```

`<Leader>ic` - Clean previously builded directory.

`<Leader>ib` - Build a firmware from the current project.

`<Leader>iu` - Upload firmware to your Arduino

`<Leader>is` - Open a serial port in `picocom`(default, see plugin configuration) or `screen`.


## Plugin Configuration
There are some configuration options to change a behavior of the plugin.
All of them goes to `~/.vimrc` or global `/etc/vim/vimrc` file.

The default key mapping can be turned off by this:
```
let vimino_map_keys = 0
```

If you want to use a `screen` instead of a `picocom`, which is default:
```
let vimino_serial_screen_prefered = 1
```

## Requirements

You must have the [Arduino][arduino] IDE and [Ino][ino] command-line toolkit installed.

[arduino]: http://arduino.cc/en/Main/Software
[ino]: http://inotool.org/

### Optional
Install a [Picocom][picocom] terminal emulation program, which is primarily used by [Ino][ino]

[picocom]: http://code.google.com/p/picocom/
