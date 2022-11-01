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

    - `sudo apt install i3 i3lock feh compton rofi redshift playerctl tty-clock at xbacklight`

    - adjust X11 to be able to control backlight:

        ```bash
        sudo cp .config/i3/xorg.conf.tpl /etc/X11/xorg.conf
        ```

    - disable graphical login manager: `sudo systemctl set-default multi-user.target` 
        - (reversible with `sudo systemctl set-default graphical.target`)

    - add an auto login script:

        ```bash
        sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
        sudo cp .config/i3/autologin.conf /etc/systemd/system/getty@tty1.service.d/autologin.conf
        ```

    - set i3 as the default WM: `sudo update-alternatives --install /usr/bin/x-session-manager x-session-manager /usr/bin/i3 60`

    - rename user folders:

        ```bash
        mv Asztal .desktop
        mv Letöltések .downloads
        mv Sablonok .templates
        mv Nyilvános .public
        mv Dokumentumok .documents
        mv Zenék .music
        mv Képek .pictures
        mv Videók .videos
        ```

- Setup terminal and shell

    - `sudo apt install zsh rxvt-unicode`

    - install Oh-my-zsh! by `sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

    - install external plugins:

        ```bash
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        ```

- Setup browser

    - install according to [this doc](https://brave.com/linux/)

- Setup editor

    - `sudo snap install --classic code`

    - set as the default editor through the alternatives system, too (xdg mime type associations are handled already through `.config/mimeapps.list`):

        ```bash
        sudo update-alternatives --install /usr/bin/editor editor /snap/bin/code 60
        sudo update-alternatives --install /usr/bin/gnome-text-editor gnome-text-editor /snap/bin/code 60
        ```

    - install extensions (needs `zsh`)

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