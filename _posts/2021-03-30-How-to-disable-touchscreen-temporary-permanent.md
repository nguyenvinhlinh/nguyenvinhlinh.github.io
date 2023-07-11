---
layout: post
title: "How to disable touchscreen temporary/permanent?"
date: 2021-03-30 21:52:44 +0700
tags:
- Linux
- Tweak
categories: Linux
---

# How to disable touchscreen temporarily?
- Determine touchscreen device ID using following command `xinput`. It will give a list of all available input device.

```text
⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
⎜   ↳ SynPS/2 Synaptics TouchPad              	id=11	[slave  pointer  (2)]
⎜   ↳ Logitech G304                           	id=17	[slave  pointer  (2)]
⎜   ↳ Touchscreen                           	id=30	[slave  pointer  (2)]    # <-------- remember the ID [30]
⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
    ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
    ↳ Power Button                            	id=6	[slave  keyboard (3)]
    ↳ Video Bus                               	id=7	[slave  keyboard (3)]
    ↳ Power Button                            	id=8	[slave  keyboard (3)]
    ↳ HP Truevision HD: HP Truevision         	id=9	[slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard            	id=10	[slave  keyboard (3)]
    ↳ HP Wireless hotkeys                     	id=12	[slave  keyboard (3)]
    ↳ HP WMI hotkeys                          	id=13	[slave  keyboard (3)]
    ↳ SINO WEALTH USB KEYBOARD System Control 	id=14	[slave  keyboard (3)]
    ↳ SINO WEALTH USB KEYBOARD Consumer Control	id=15	[slave  keyboard (3)]
    ↳ SINO WEALTH USB KEYBOARD                	id=16	[slave  keyboard (3)]
    ↳ Logitech G304                           	id=18	[slave  keyboard (3)]
```

- Disable the input device using this command `xinput disable 30`. `30` is the device ID.

# How to disable touchscreen permanently?
- Go to the following file `/usr/share/X11/xorg.conf.d/10-evdev.conf`
- Find a config section contained `touchscreen` config, for example:

```conf
Section "InputClass"
        Identifier "evdev touchscreen catchall" # <-------- Look at this Identifier
        MatchIsTouchscreen "on"
        MatchDevicePath "/dev/input/event*"
        Driver "evdev"
        Option "Ignore" "on"  # <-------- Add this config to ignore the touchscreen input.
EndSection
```

- Add `Option "Ignore" "on"` to ignore touchscreen input.
