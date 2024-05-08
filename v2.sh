#!/bin/bash

#colors
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
rest='\033[0m'

case "$(uname -m)" in
	x86_64 | x64 | amd64 )
	    cpu=amd64
	;;
	i386 | i686 )
        cpu=386
	;;
	armv8 | armv8l | arm64 | aarch64 )
        cpu=arm64
	;;
	armv7l )
        cpu=arm
	;;
	* )
	echo "The current architecture is $(uname -m), not supported"
	exit
	;;
esac

cfwarpIP() {
}

endipv4(){
}

endipv6(){
}

freeCloudflareAccount(){
}
freeCloudflareAccount2(){
}

endipresult() {
    echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u > ip.txt
    ulimit -n 102400
    chmod +x warpendpoint >/dev/null 2>&1
    if command -v warpendpoint &>/dev/null; then
        warpendpoint
   else
        ./warpendpoint
    fi
    
    clear
    Endip_v4=$(cat result.csv | grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+" | head -n 1)
	Endip_v4_ip="${Endip_v4%:*}"
	Endip_v4_port="${Endip_v4##*:}"
    
	freeCloudflareAccount
	freeCloudflareAccount2

	template='{
	"route": {
		"geoip": {
		"path": "geo-assets\\sagernet-sing-geoip-geoip.db"
		},
		"geosite": {
		"path": "geo-assets\\sagernet-sing-geosite-geosite.db"
		},
		"rules": [
		{
			"inbound": "dns-in",
			"outbound": "dns-out"
		},
		{
			"port": 53,
			"outbound": "dns-out"
		},
		{
			"clash_mode": "Direct",
			"outbound": "direct"
		},
		{
			"clash_mode": "Global",
			"outbound": "select"
		}
		],
		"auto_detect_interface": true,
		"override_android_vpn": true
	},
	"outbounds": [
		{
		"type": "selector",
		"tag": "select",
		"outbounds": [
			"auto",
			"IP->Iran, Yotube:Geekmeek",
			"IP->Main, Yotube:Geekmeek"
		],
		"default": "auto"
		},
		{
		"type": "urltest",
		"tag": "auto",
		"outbounds": [
			"IP->Iran, Yotube:Geekmeek",
			"IP->Main, Yotube:Geekmeek"
		],
		"url": "http://cp.cloudflare.com/",
		"interval": "10m0s"
		},
		{
		"type": "wireguard",
		"tag": "IP->Iran, Yotube:Geekmeek",
		"local_address": [
			"172.16.0.2/32",
			"'$publicKey'"
		],
		"private_key": "'$privateKey'",
		"server": "'$Endip_v4_ip'",
		"server_port": '$Endip_v4_port',
		"peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
		"reserved": '$reserved',
		"mtu": 1280,
		"fake_packets": "5-10"
		},
		{
		"type": "wireguard",
		"tag": "IP->Main, Yotube:Geekmeek",
		"detour": "IP->Iran, Yotube:Geekmeek",
		"local_address": [
			"172.16.0.2/32",
			"'$publicKey2'"
		],
		"private_key": "'$privateKey2'",
		"server": "'$Endip_v4_ip'",
		"server_port": '$Endip_v4_port',
		"peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
		"reserved": '$reserved2',
		"mtu": 1280,
		"fake_packets": "5-10"
		},
		{
		"type": "dns",
		"tag": "dns-out"
		},
		{
		"type": "direct",
		"tag": "direct"
		},
		{
		"type": "direct",
		"tag": "bypass"
		},
		{
		"type": "block",
		"tag": "block"
		}
	]  
	}'

	echo "$template"

    rm warpendpoint >/dev/null 2>&1
    rm -rf ip.txt
	rm -rf result.csv
    exit
}


cfwarpIP
endipv4
endipresult
Endip_v4
