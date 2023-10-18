# xxh-plugin-zsh-advanced_p10k

## Using

1. Install xxh -> <https://github.com/xxh/xxh>

2. Configure `$home/.config/xxh/config.xxhc`:

    ```yaml
    hosts:
    ".*":                 # for all hosts
        +s: zsh                 # use zsh shell
        +RI:                    # reinstall xxh packages
        - xxh-shell-zsh
        - xxh-plugin-zsh-advanced_p10k+git+https://github.com/nilune/xxh-plugin-zsh-advanced_p10k
        #+I:                    # install xxh packages (if not installed)
        #  - xxh-shell-zsh
        #  - xxh-plugin-zsh-advanced_p10k+git+https://github.com/nilune/xxh-plugin-zsh-advanced_p10k
        +e:                     # set simple environment variables
        - plugins="git copyfile copypath dirhistory sudo z zsh-autosuggestions fast-syntax-highlighting fzf-zsh-plugin"
        - history_size="20"
        #+hhh: "~"              # set /home/user as home directory
        +hhh: "~/.xxh"          # set /home/user/.xxh as home directory
        +if:                    # force install xxh every time
    ```

3. Connect to host:

    ```bash
    xxh $HOSTNAME
    ```

---

Also it is possible to use with current configuration (but not recommended):

```bash
source xxh.zsh $HOSTNAME
```

## Develop

1. Clone to local directory and `cd` to this directory. It is required for using plugin by argument `xxh-plugin-zsh-advanced_p10k+path+.`

2. You can use or not use xxh config file (`$home/.config/xxh/config.xxhc`). If you do not using it, then use variables:
   - `+s zsh`
   - `+RI xxh-plugin-zsh-advanced_p10k+path+.`
   - `+if`

3. Connect to host, for example:

    ```bash
    xxh $HOSTNAME
    ```

    or

    ```bash
    xxh $HOSTNAME +s zsh +RI xxh-plugin-zsh-zshrc+path+. +if
    ```

4. Sometimes you should remove `.xxh` folder on target host:

    ```bash
    ssh $HOSTNAME
    rm -rf .xxh
    ```
