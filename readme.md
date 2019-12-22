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

- Initialize dotfiles (inspired by [this guide](https://www.atlassian.com/git/tutorials/dotfiles)):

    - clone repo
    
        ```bash
        cd
        git clone --bare https://github.com/mrzealot/alice .alice
        alias alice='/usr/bin/git --git-dir=$HOME/.alice/ --work-tree=$HOME'
        ```

    - checkout contents to home dir

        ```bash
        mkdir -p .config-backup
        alice checkout
        if [[ $? != 0 ]]; then
            echo "Checked out alice config.";
        else
            echo "Backing up pre-existing dot files.";
            alice checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
        fi;
        alice checkout
        ```

    - ignore untraced files: `alice config status.showUntrackedFiles no`

    - make all tracked scripts executable: `alice ls-tree -r master --name-only | grep .sh$ | xargs chmod +x`

- Setup WM-related stuff:
    - dedicated i3 repo for fresher versions

        ```bash
        curl https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2019.02.01_all.deb --output /tmp/keyring.deb
        sudo dpkg -i /tmp/keyring.deb
        echo "deb https://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee -a /etc/apt/sources.list.d/sur5r-i3.list
        sudo apt update
        ```

    - `sudo apt install i3 i3lock feh compton`
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
