#!/usr/bin/env bash

PERCENT=`cat /sys/class/power_supply/BAT0/capacity`
STATE=`cat /sys/class/power_supply/BAT0/status`

function icon() {
    if   [[ $STATE == 'Charging' ]]; then echo '󰂄'
    elif [[ $PERCENT -ge 95 ]]; then echo '󰁹'
    elif [[ $PERCENT -ge 90 ]]; then echo '󰂁'
    elif [[ $PERCENT -ge 80 ]]; then echo '󰂁'
    elif [[ $PERCENT -ge 70 ]]; then echo '󰂁'
    elif [[ $PERCENT -ge 60 ]]; then echo '󰂀'
    elif [[ $PERCENT -ge 40 ]]; then echo '󰁿'
    elif [[ $PERCENT -ge 30 ]]; then echo '󰁾'
    elif [[ $PERCENT -ge 20 ]]; then echo '󰁼'
    elif [[ $PERCENT -ge 10 ]]; then echo '󰁻'
    elif [[ $PERCENT -ge 1  ]]; then echo '󰁺'
    else echo ''
    fi
}

function percent() {
    echo $PERCENT
}

function state() {
    echo $STATE
}

function get {
echo "{\"percent\": $PERCENT, 
    \"state\": \"$STATE\", 
    \"icon\": \"$(icon)\"
}"
}

if [[ $1 == 'get' ]]; then get; fi
