# Alice

## System Prep

- Install a fresh Ubuntu in "Minimal" mode with the following partitions:
    - `boot` (~1GB)
    - `swap` (~size of RAM)
    - `root` (~50GB)
    - `home` (rest)

- Allow the sudo group to `sudo` without a password
    - `sudo visudo`
    - modify corresponding line: `%sudo ALL=(ALL) NOPASSWD: ALL`

- Install basic dependencies:
    - `sudo apt install curl git`

- Initialize dotfiles (from [this guide](https://www.atlassian.com/git/tutorials/dotfiles)):

    ```
    cd
    git clone --bare https://github.com/mrzealot/alice .alice
    alias config='/usr/bin/git --git-dir=$HOME/.alice/ --work-tree=$HOME'
    mkdir -p .config-backup
    config checkout
    if [ $? = 0 ]; then
        echo "Checked out config.";
    else
        echo "Backing up pre-existing dot files.";
        config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
    fi;
    config checkout
    config config status.showUntrackedFiles no
    ```

- Setup WM-related stuff:
    - `sudo apt install i3 i3lock feh`
    - a separate package to control backlight:

        ```bash
        curl https://github.com/haikarainen/light/releases/download/v1.2/light_1.2_amd64.deb --output /tmp/light.deb
        sudo dpkg -i /tmp/light.deb
        ```

    - disable graphical login manager: `sudo systemctl set-default multi-user.target` 
        - (reversible with `sudo systemctl set-default graphical.target`)

    - add an auto login script:

        ```bash
        sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
        sudo cp .config/i3/autologin.conf /etc/systemd/system/getty@tty1.service.d/override.conf
        ```

    - set i3 as the default WM: `sudo update-alternatives --install /usr/bin/x-session-manager x-session-manager /usr/bin/i3 60`
