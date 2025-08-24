# X.Shot
A simple [scrot](https://github.com/resurrecting-open-source-projects/scrot)
wrapper written in Bash, for easily taking screenshots on minimal
environments.

## Usage
```
$ [/path/to/]xshot.sh <output type> <selection type>
```

The output type can be:
- your clipboard (`clipboard`), by piping the output to your clipboard
  manager (xclip by default)
- a file. See section below.

The selection type can be:
- a specific area
- your current active window
- your current screen

## How It Works
The arguments supplied to scrot are stored in separate variables located at
the very beginning of the script:
- `$SCROTARGS`: shooting options. By default, this tells scrot to: freeze,
  include mouse pointer, save at maximum quality and not compress the output
  file.
  See scrot's manpage for more information.
- `$FN_FORMAT`: to where and how scrot will save the output file. By default,
  it saves at the user's `Pictures/Screenshots/` directory, with the format
  `Screenshot_YYYY-MM-DD@HH:MM:SS[ AM/PM].png`.
  Ditto.
- `$CLIP_OPTS`: how scrot will save your file to the clipboard. By default,
  it uses xclip, and stores it as a PNG.
