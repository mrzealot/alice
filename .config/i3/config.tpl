# Modifiers 
set $c Control
set $s Shift
set $a Mod1
set $g Mod4

# Outputs (filled in by .xinitrc)
set $in INTERNAL_DISPLAY
set $ex EXTERNAL_DISPLAY

# Font (required setting)
font pango:monospace 8

# Styling
default_border none
default_floating_border none
set $border_width 3
set_from_resource $bcolor color1 #f02020

# Color override for border flashing
# class                 border  backgr. text    indicator child_border
client.focused          #000000 #000000 #000000 $bcolor   $bcolor
client.focused_inactive #000000 #000000 #000000 #000000   #000000
client.unfocused        #000000 #000000 #000000 #000000   #000000
client.urgent           #000000 #000000 #000000 #000000   #000000
client.placeholder      #000000 #000000 #000000 #000000   #000000

# Bottom bar
# mode = hide for now as a training wheel, will set to "invisible" later
bar {
        mode invisible
        status_command i3status
}

# Use Mouse+$a to drag floating windows to their wanted position
floating_modifier $a




# Check focus
bindsym $g+g exec i3-msg border pixel $border_width
bindsym --release $g+g exec i3-msg border pixel 0

# Change focus (with border flash)
bindsym $g+Left  exec i3-msg border pixel $border_width; focus left
bindsym $g+Down  exec i3-msg border pixel $border_width; focus down
bindsym $g+Up    exec i3-msg border pixel $border_width; focus up
bindsym $g+Right exec i3-msg border pixel $border_width; focus right
bindsym --release $g+Left  exec i3-msg border pixel 0
bindsym --release $g+Down  exec i3-msg border pixel 0
bindsym --release $g+Up    exec i3-msg border pixel 0
bindsym --release $g+Right exec i3-msg border pixel 0

# Move focused window
bindsym $g+$s+Left  exec i3-msg border pixel $border_width; move left
bindsym $g+$s+Down  exec i3-msg border pixel $border_width; move down
bindsym $g+$s+Up    exec i3-msg border pixel $border_width; move up
bindsym $g+$s+Right exec i3-msg border pixel $border_width; move right
bindsym --release $g+$s+Left  exec i3-msg border pixel 0
bindsym --release $g+$s+Down  exec i3-msg border pixel 0
bindsym --release $g+$s+Up    exec i3-msg border pixel 0
bindsym --release $g+$s+Right exec i3-msg border pixel 0

# Resize focused window
bindsym $g+$c+Left resize shrink width 10 px or 10 ppt
bindsym $g+$c+Down resize grow height 10 px or 10 ppt
bindsym $g+$c+Up resize shrink height 10 px or 10 ppt
bindsym $g+$c+Right resize grow width 10 px or 10 ppt




# Enter fullscreen mode
bindsym $g+f fullscreen toggle

# Split in horizontal/vertical orientation
# These are "around" the fullscreen toggle
# for easier remembering, consider:
# horizontal = W for "water level"
bindsym $g+w split h

# and vertical = P for "portrait"
bindsym $g+p split v




# Attach workspaces to outputs
workspace 1 output $ex 
workspace 2 output $ex 
workspace 3 output $ex 
workspace 4 output $ex 
workspace 5 output $ex 
workspace 6 output $ex 
workspace 7 output $ex 
workspace 8 output $ex 
workspace 9 output $in

# Switch to workspace
bindsym $g+n workspace 1
bindsym $g+e workspace 2
bindsym $g+i workspace 3
bindsym $g+o workspace 4
bindsym $g+l workspace 5
bindsym $g+u workspace 6
bindsym $g+y workspace 7
bindsym $g+aacute workspace 8
bindsym $g+h workspace 9

# Move focused container to workspace
bindsym $g+$c+n move container to workspace 1
bindsym $g+$c+e move container to workspace 2
bindsym $g+$c+i move container to workspace 3
bindsym $g+$c+o move container to workspace 4
bindsym $g+$c+l move container to workspace 5
bindsym $g+$c+u move container to workspace 6
bindsym $g+$c+y move container to workspace 7
bindsym $g+$c+aacute move container to workspace 8
bindsym $g+$c+h move container to workspace 9





# Kill focused window
bindsym $g+k kill

# Lock screen
set $lock_command i3lock -u -t -i ~/.wallpapers/lock.png
bindsym $g+eacute exec $lock_command




# Power management
set $power_command ~/.config/i3/power.sh
mode "power" {
        # D for display reconfig
        bindsym d exec --no-startup-id ~/.config/i3/display.sh reset, mode "default"

        # N for notification restart (as it sometimes just decides to die)
        bindsym n exec --no-startup-id killall dunst && dunst -config ~/.dunstrc, mode "default"

        # R for reboot
        bindsym r exec --no-startup-id $power_command -r, mode "default"

        # X for restarting X
        # (which automatically happens when exiting i3 because of the auto login conf)
        bindsym x exec --no-startup-id $power_command -x, mode "default"

        # S for shutdown
        bindsym s exec --no-startup-id $power_command -s, mode "default"

        # back to normal: Enter or Escape
        bindsym Return mode "default"; exec --no-startup-id ~/.config/i3/mode.sh
        bindsym Escape mode "default"; exec --no-startup-id ~/.config/i3/mode.sh
}
bindsym $g+q mode "power"; exec --no-startup-id ~/.config/i3/mode.sh power




# Audio output selection
set $audio_command ~/.config/i3/audio.sh
mode "audio" {
        # I for internal
        bindsym i exec --no-startup-id $audio_command -i, mode "default"

        # E for external (HDMI)
        bindsym e exec --no-startup-id $audio_command -e, mode "default"

        # S for soundbar (Bluetooth)
        bindsym s exec --no-startup-id $audio_command -s, mode "default"

        # B for earbuds (Bluetooth)
        bindsym b exec --no-startup-id $audio_command -b, mode "default"

        # back to normal: Enter or Escape
        bindsym Return mode "default"; exec --no-startup-id ~/.config/i3/mode.sh
        bindsym Escape mode "default"; exec --no-startup-id ~/.config/i3/mode.sh
}
bindsym $g+a mode "audio"; exec --no-startup-id ~/.config/i3/mode.sh audio




# Volume controls
set $volume_command ~/.config/i3/volume.sh
bindsym XF86AudioRaiseVolume exec --no-startup-id $volume_command 5%+
bindsym $s+XF86AudioRaiseVolume exec --no-startup-id $volume_command 1%+
bindsym XF86AudioLowerVolume exec --no-startup-id $volume_command 5%-
bindsym $s+XF86AudioLowerVolume exec --no-startup-id $volume_command 1%-
bindsym XF86AudioMute exec --no-startup-id $volume_command toggle

# Media controls
set $media_command ~/.config/i3/media.sh
bindsym XF86AudioPlay exec --no-startup-id $media_command play-pause
bindsym XF86AudioPause exec --no-startup-id $media_command play-pause
bindsym XF86AudioNext exec --no-startup-id $media_command next
bindsym XF86AudioPrev exec --no-startup-id $media_command previous

# Screen brightness controls
set $brightness_command ~/.config/i3/brightness.sh
bindsym XF86MonBrightnessUp exec $brightness_command -A 5
bindsym $s+XF86MonBrightnessUp exec $brightness_command -A 1
bindsym XF86MonBrightnessDown exec $brightness_command -U 5
bindsym $s+XF86MonBrightnessDown exec $brightness_command -U 1

# Disabling built-in keyboard/touchpad
bindsym $g+d exec ~/.config/i3/keyboard.sh

# Muting the mic
bindsym XF86AudioMicMute exec ~/.config/i3/mic.sh

# Time popup
bindsym $g+m exec --no-startup-id ~/.config/i3/time.sh

# Screenshots
bindsym --release Print exec --no-startup-id maim -s | xclip -selection clipboard -t image/png
bindsym --release $c+Print exec --no-startup-id maim -s ~/.screenshots/$(date "+%F--%H-%M-%S").png



# Background stuff

# Compositor for flicker-free transitions
exec --no-startup-id compton -b

# Notification daemon
exec --no-startup-id dunst -config ~/.dunstrc

# Speed up keyboard bluetooth, if we can
exec --no-startup-id "source ~/.zaliases && btspeed"

# Automatically adjust screen color temperature
exec --no-startup-id redshift -c ~/.config/redshift/redshift.conf




# Program-specific settings

# Browser
# Confinement based on UDD to differentiate from CC
# Can still be moved afterwards if needed
assign [instance="alice_main_udd"] 1
bindsym $g+b exec brave-browser --user-data-dir=$HOME/.alice_main_udd
exec brave-browser --user-data-dir=$HOME/.alice_main_udd

# Editor
assign [class="Code"] 2
# Can't start by default for some reason without messing up keybindings...
# So I just bind it and open when needed
bindsym $g+c exec code

# Terminal
exec --no-startup-id i3-msg 'workspace 3; exec urxvt; workspace 1'
bindsym $g+space exec urxvt

# Control Center
assign [instance="alice_cc_udd"] 9
bindsym $g+z exec --no-startup-id ~/.config/i3/cc.sh
exec --no-startup-id ~/.config/i3/cc.sh

# File Manager
bindsym $g+Return exec nautilus

# Launcher
bindsym $g+Tab exec rofi -show combi




# Done, lock for initial "login"
exec $lock_command