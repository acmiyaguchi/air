#!/bin/sh

upower -i /org/freedesktop/UPower/devices/battery_rn5t618_battery | \
    grep -E 'state|percent' | \
    awk '{print $2}' | \
    tac | \
    tr '\n' ' '

