function toggle {
    STATE=$(nmcli radio wifi)
    if [[ $STATE == 'enabled' ]]; then nmcli radio wifi off
    else nmcli radio wifi on; fi
}

STRENGTH=`nmcli -f IN-USE,SIGNAL,SSID device wifi | awk '/^\*/{if (NR!=1) {print $2}}'`
# echo $STRENGTH

function icon {
    if     [[ $STRENGTH -ge 80 ]]; then echo '󰤨'
    elif   [[ $STRENGTH -ge 60 ]]; then echo '󰤥'
    elif   [[ $STRENGTH -ge 40 ]]; then echo '󰤢'
    elif   [[ $STRENGTH -ge 20 ]]; then echo '󰤟'
    else echo '󰤭'
    fi
}

function get {
    echo "{
    \"state\": \"$`nmcli radio wifi`\", 
    \"icon\": \"$(icon)\"
}"
}

if [[ $1 == 'get' ]]; then get; fi
if [[ $1 == 'toggle' ]]; then toggle; fi
