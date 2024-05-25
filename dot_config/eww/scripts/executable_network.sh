function toggle {
    STATE=$(nmcli radio wifi)
    if [[ $STATE == 'enabled' ]]; then nmcli radio wifi off
    else nmcli radio wifi on; fi
}

STRENGTH=`nmcli -f IN-USE,SIGNAL,SSID device wifi | awk '/^\*/{if (NR!=1) {print $2}}'`
SSID=`nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d\: -f2`
STATE=`nmcli radio wifi`
# echo $STRENGTH

function icon {
    if     [[ $STRENGTH -ge 75 ]]; then echo '󰤨'
    elif   [[ $STRENGTH -ge 50 ]]; then echo '󰤥'
    elif   [[ $STRENGTH -ge 25 ]]; then echo '󰤢'
    elif   [[ $STRENGTH -ge 1 ]]; then echo '󰤟'
    else echo '󰤭'
    fi
}

function get {
    echo "{
    \"ssid\": \"$SSID\",
    \"state\": \"$STATE\", 
    \"icon\": \"$(icon)\"
}"
}

if [[ $1 == 'get' ]]; then get; fi
if [[ $1 == 'toggle' ]]; then toggle; fi
