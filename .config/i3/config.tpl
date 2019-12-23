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

# Bottom bar
# mode = hide for now as a training wheel, will set to "invisible" later
bar {
        mode hide
        status_command i3status
}

# Use Mouse+$a to drag floating windows to their wanted position
floating_modifier $a




# Change focus
bindsym $g+Left focus left
bindsym $g+Down focus down
bindsym $g+Up focus up
bindsym $g+Right focus right

# Move focused window
bindsym $g+$s+Left move left
bindsym $g+$s+Down move down
bindsym $g+$s+Up move up
bindsym $g+$s+Right move right

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
        # R for reboot
        bindsym r exec --no-startup-id $power_command -r, mode "default"

        # X for restarting X
        # (which automatically happens when exiting i3 because of the auto login conf)
        bindsym x exec --no-startup-id $power_command -x, mode "default"

        # S for shutdown
        bindsym s exec --no-startup-id $power_command -s, mode "default"

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}
bindsym $g+q mode "power"




# Audio controls
set $volume_command ~/.config/i3/volume.sh
bindsym XF86AudioRaiseVolume exec --no-startup-id $volume_command 5%+
bindsym XF86AudioLowerVolume exec --no-startup-id $volume_command 5%-
bindsym XF86AudioMute exec --no-startup-id $volume_command toggle

# Screen brightness controls
set $brightness_command ~/.config/i3/brightness.sh
bindsym XF86MonBrightnessUp exec $brightness_command -A 5 # increase
bindsym XF86MonBrightnessDown exec $brightness_command -U 5 # decrease

# Disabling built-in keyboard/touchpad
bindsym $g+d exec ~/.config/i3/keyboard.sh

# Muting the mic
bindsym XF86AudioMicMute exec ~/.config/i3/mic.sh

# Time popup
bindsym $g+m exec --no-startup-id ~/.config/i3/time.sh




# Background stuff

# Compositor for flicker-free transitions
exec --no-startup-id compton -b

# Notification daemon
exec --no-startup-id dunst -config ~/.dunstrc




# Program-specific settings

# Browser
# No specific confinement, but automatically started on workspace 1
bindsym $g+b exec brave-browser
exec --no-startup-id i3-msg 'workspace 1; exec brave-browser'

# Editor
assign [class="Code"] 2
# Can't start by default for some reason without messing up keybindings...
# So I just bind it and open when needed
bindsym $g+c exec code

# Terminal
exec --no-startup-id i3-msg 'workspace 3; exec gnome-terminal; workspace 1'
bindsym $g+space exec i3-sensible-terminal

# Control Center
assign [instance="alice_cc_udd"] 9
bindsym $g+z exec --no-startup-id ~/.config/i3/cc.sh
exec --no-startup-id ~/.config/i3/cc.sh

# File Manager
bindsym $g+Return exec nautilus

# Quick Status Popup
# TODO




# Done, lock for initial "login"
exec $lock_command