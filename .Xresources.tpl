!! Font stuff

! initial DPI filled by .xinitrc
Xft.dpi:        INITIAL_DPI_HERE
Xft.antialias:  true
Xft.lcdfilter:  lcddefault
Xft.hinting:    true
Xft.hintstyle:  hintslight
Xft.autohint:   false
Xft.rgba:       rgb




!! URxvt stuff

! do not scroll with output
URxvt*scrollTtyOutput: false

! scroll in relation to buffer (with mouse scroll or Shift+Page Up)
URxvt*scrollWithBuffer: true

! scroll back to the bottom on keypress
URxvt*scrollTtyKeypress: true

! allow scrolling within pagers
URxvt.secondaryScreen: 1
URxvt.secondaryScroll: 0

! styling
URxvt.urgentOnBell: true
URxvt.cursorBlink: true
URxvt.transparent: false ! not using fake transparency, see background for the "real" one
URxvt.depth: 32
URxvt.scrollBar: false
URxvt.saveLines: 65536
URxvt.mouseWheelScrollPage: true
URxvt.borderless: true
URxvt.internalBorder: 10
URxvt.geometry: 120x40

! font
URxvt.letterSpace:      -1
URxvt.font:             xft:Hack-Regular:size=13,xft:Symbola
URxvt.boldFont:         xft:Hack-Bold:size=13:weight=bold,xft:Symbola
URxvt.italicFont:       xft:Hack-Italic:size=13:slant=italic,xft:Symbola
URxvt.boldItalicFont:   xft:Hack-Bold-Italic:size=13:weight=bold:slant=italic,xft:Symbola




! colors

! Base16 PhD
! Scheme: Hennig Hasemann (http://leetless.de/vim.html)

#define base00 #061229
#define base01 #2a3448
#define base02 #4d5666
#define base03 #717885
#define base04 #9a99a3
#define base05 #b8bbc2
#define base06 #dbdde0
#define base07 #ffffff
#define base08 #d07346
#define base09 #f0a000
#define base0A #fbd461
#define base0B #99bf52
#define base0C #72b9bf
#define base0D #5299bf
#define base0E #9989cc
#define base0F #b08060

*.foreground:   base07
*.background:   [89]#000000
*.cursorColor:  base07

*.color0:       base00
*.color1:       base08
*.color2:       base0B
*.color3:       base0A
*.color4:       base0D
*.color5:       base0E
*.color6:       base0C
*.color7:       base05

*.color8:       base03
*.color9:       base08
*.color10:      base0B
*.color11:      base0A
*.color12:      base0D
*.color13:      base0E
*.color14:      base0C
*.color15:      base07

! Note: colors beyond 15 might not be loaded (e.g., xterm, urxvt),
! use 'shell' template to set these if necessary
*.color16:      base09
*.color17:      base0F
*.color18:      base01
*.color19:      base02
*.color20:      base04
*.color21:      base06