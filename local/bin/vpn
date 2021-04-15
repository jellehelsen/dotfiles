#!/usr/bin/env bash

function selectvpn {
    vpns=$(nmcli -t c show $1 | awk -F: '/vpn/{ printf("%s:", $1)}')
    echo $vpns
    # echo ${vpns::${#vpns}}
    vpn=$(echo $vpns | rofi -dmenu -i -sep ':' -p 'Select VPN')
}

action=$(echo Connect:Disconnect | rofi -dmenu -i -sep : -p Action? )

case $action in
    Connect )
	selectvpn
	nmcli c up "$vpn"
        ;;
    Disconnect )
	selectvpn "--active"
	nmcli c down "$vpn"
        ;;
    
esac
