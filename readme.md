# Alice

The Alice project is my continuously evolving set of dotfiles for a completely customized, (mostly) keyboard-driven linux experience.
It stands for **A**dvanced **L**inux **I**nterface for **C**ontrol & **E**fficiency.

- Is it a really forced acronym made up after the fact? Yes.
- Is it really called Alice because of my infatuation with the children's tale? Yes.
- Is it accurate and fitting, though? Also yes.

## System Prep

- Install a fresh Ubuntu in "Minimal" mode

    - allocate the following partitions:
        - `boot` (~1GB)
        - `swap` (~size of RAM)
        - `root` (~50GB)
        - `home` (rest)

    - allow the sudo group to `sudo` without a password
        - `sudo visudo`
        - modify the corresponding line: `%sudo ALL=(ALL) NOPASSWD: ALL`

    - install basic dependencies: `sudo apt install curl git nodejs npm vim htop maim bluez x11-xserver-utils xclip baobab unrar`

    - upgrade node

        ```bash
        sudo npm install -g n
        sudo n latest
        ```

- Initialize dotfiles (inspired by [this guide](https://www.atlassian.com/git/tutorials/dotfiles)):

    - clone repo
    
        ```bash
        cd
        git clone --bare git@github.com:mrzealot/alice.git .alice
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

    - ignore untracked files: `alice config status.showUntrackedFiles no`

    - make all tracked scripts executable: `alice ls-tree -r master --name-only | grep .sh$ | xargs chmod +x`

- Setup WM-related stuff:

    - dedicated i3 repo for fresher versions

        ```bash
        curl https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2019.02.01_all.deb --output /tmp/keyring.deb
        sudo dpkg -i /tmp/keyring.deb
        echo "deb https://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee -a /etc/apt/sources.list.d/sur5r-i3.list
        sudo apt update
        ```

    - `sudo apt install i3 i3lock feh compton rofi redshift playerctl tty-clock at`

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

    - install `dunst` for custom notifications

        ```bash
        sudo apt install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev
        mkdir -p .builds/dunst
        git clone https://github.com/dunst-project/dunst.git .builds/dunst
        cd .builds/dunst
        make
        sudo make install
        make dunstify
        sudo install -Dm755 dunstify /usr/local/bin/dunstify
        cd
        ```

- Setup terminal and shell

    - `sudo apt install zsh rxvt-unicode`

    - install Oh-my-zsh! by `sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

    - install external plugins:

        ```bash
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        ```

- Setup browser

    - install according to [this doc](https://brave-browser.readthedocs.io/en/latest/installing-brave.html)

- Setup editor

    - `sudo snap install --classic code`

    - set as the default editor:

        ```bash
        sudo update-alternatives --install /usr/bin/editor editor /snap/bin/code 60
        sudo update-alternatives --install /usr/bin/gnome-text-editor gnome-text-editor /snap/bin/code 60
        ```

    - install extensions

        ```bash
        code_exts=(
            Asuka.insertnumbers
            ban.spellright
            James-Yu.latex-workshop
            jsynowiec.vscode-insertdatestring
            kirozen.wordcounter
            mhutchie.git-graph
            ms-python.python
            earshinov.permute-lines
        )
        for ext in $code_exts; code --install-extension $ext
        ```

    - set up correct spell check by giving `spellright` the system `hunspell` dictionaries: `ln -s /usr/share/hunspell ~/.config/Code/Dictionaries`

- Setup my own bins

    - coin

        ```bash
        git clone git@github.com:mrzealot/coin.git .coin
        cd .coin && npm install && sudo npm link; cd
        ```

    - whip

        ```bash
        git clone git@github.com:mrzealot/whip.git .whip
        cd .whip && npm install && sudo npm link; cd
        ```

- Setup media/office stuff

    - `sudo apt install transmission vlc kolourpaint gimp inkscape audacity libreoffice calibre filezilla librecad ffmpeg handbrake youtube-dl`

    - setup `scdl` SoundCloud downloader by `pip3 install git+https://github.com/flyingrub/scdl`
        - example command: `scdl -l https://soundcloud.com/mrzealot -f --path .music/soundcloud -c --onlymp3 --debug`