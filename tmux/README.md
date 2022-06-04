# Tmux

## Requirements

- [tpm](https://github.com/tmux-plugins/tpm)

## Support Italic Text

1. Create temporary file `terminfo` with following content:

```txt
 xterm-256color-italic|xterm with 256 colors and italic,
     sitm=\E[3m, ritm=\E[23m,
     use=xterm-256color,
```

2. Create a new entry in the `TERMINFO` database

```txt
tic terminfo
```

3. Delete the temporary file
