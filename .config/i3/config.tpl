# Basic 
set $c Control
set $s Shift
set $a Mod1
set $g Mod4

# Outputs
set $in INTERNAL_DISPLAY
set $ex EXTERNAL_DISPLAY

# Font (required setting)
font pango:monospace 8

# Styling
default_border none

# Use Mouse+$a to drag floating windows to their wanted position
floating_modifier $a

# start a terminal
bindsym $g+space exec i3-sensible-terminal

# kill focused window
bindsym $g+w kill

# start dmenu (a program launcher)
bindsym $g+d exec dmenu_run
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $g+d exec --no-startup-id i3-dmenu-desktop


# change focus
bindsym $g+Left focus left
bindsym $g+Down focus down
bindsym $g+Up focus up
bindsym $g+Right focus right

# move focused window
bindsym $g+Shift+Left move left
bindsym $g+Shift+Down move down
bindsym $g+Shift+Up move up
bindsym $g+Shift+Right move right

# split in horizontal orientation
bindsym $g+h split h

# split in vertical orientation
bindsym $g+v split v

# enter fullscreen mode for the focused container
bindsym $g+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $g+s layout stacking
#bindsym $g+w layout tabbed
#bindsym $g+e layout toggle split

# toggle tiling / floating
bindsym $g+Shift+Tab floating toggle

# change focus between tiling / floating windows
bindsym $g+Tab focus mode_toggle

# focus the parent container
bindsym $g+a focus parent

# focus the child container
#bindsym $g+d focus child


workspace 1 output $ex 
workspace 2 output $ex 
workspace 3 output $ex 
workspace 4 output $ex 
workspace 5 output $ex 
workspace 6 output $ex 
workspace 7 output $ex 
workspace 8 output $ex 
workspace 9 output $in

# switch to workspace
bindsym $g+n workspace 1
bindsym $g+e workspace 2
bindsym $g+i workspace 3
bindsym $g+o workspace 4
bindsym $g+l workspace 5
bindsym $g+u workspace 6
bindsym $g+y workspace 7
bindsym $g+aacute workspace 8
bindsym $g+m workspace 9

# move focused container to workspace
bindsym $g+$s+n move container to workspace 1
bindsym $g+$s+e move container to workspace 2
bindsym $g+$s+i move container to workspace 3
bindsym $g+$s+o move container to workspace 4
bindsym $g+$s+l move container to workspace 5
bindsym $g+$s+u move container to workspace 6
bindsym $g+$s+y move container to workspace 7
bindsym $g+$s+aacute move container to workspace 8
bindsym $g+$s+m move container to workspace 9

# reload the configuration file
bindsym $g+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $g+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $g+Shift+q exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym eacute resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym $g+r mode "resize"

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
        status_command i3status
}

# Pulse Audio controls
bindsym XF86AudioRaiseVolume exec --no-startup-id amixer -D pulse sset Master 5%+
bindsym XF86AudioLowerVolume exec --no-startup-id amixer -D pulse sset Master 5%-
bindsym XF86AudioMute exec --no-startup-id amixer -D pulse sset Master toggle

# Sreen brightness controls
bindsym XF86MonBrightnessUp exec sudo light -A 5 # increase screen brightness
bindsym XF86MonBrightnessDown exec sudo light -U 5 # decrease screen brightness


# Auto open basic programs

# Control Center
assign [instance="alice_cc_udd"] 9
exec ~/.config/i3/dpi.sh high
exec brave-browser --user-data-dir=/home/zealot/.alice_cc_udd
exec ~/.config/i3/dpi.sh auto

# Browser
assign [class="Brave-browser"] 1
exec brave-browser

# Editor
assign [class="Code"] 2
exec code

# Terminal
exec --no-startup-id i3-msg 'workspace 3; exec gnome-terminal; workspace 1'