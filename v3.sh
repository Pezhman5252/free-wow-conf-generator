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
    if [[ ! -f "$PREFIX/bin/warpendpoint" ]]; then
        echo "Downloading warpendpoint program"
        if [[ -n $cpu ]]; then
            curl -L -o warpendpoint -# --retry 2 https://raw.githubusercontent.com/Ptechgithub/warp/main/endip/$cpu
            cp warpendpoint $PREFIX/bin
            chmod +x $PREFIX/bin/warpendpoint
        fi
    fi
}

endipv4(){
	n=0
	iplist=100
	while true
	do
		temp[$n]=$(echo 162.159.192.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 162.159.193.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 162.159.195.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.96.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.97.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.98.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo 188.114.99.$(($RANDOM%256)))
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
	done
	while true
	do
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.192.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.193.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 162.159.195.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.96.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.97.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.98.$(($RANDOM%256)))
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo 188.114.99.$(($RANDOM%256)))
			n=$[$n+1]
		fi
	done
}

endipv6(){
	n=0
	iplist=100
	while true
	do
		temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
		temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
		n=$[$n+1]
		if [ $n -ge $iplist ]
		then
			break
		fi
	done
	while true
	do
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo [2606:4700:d0::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
			n=$[$n+1]
		fi
		if [ $(echo ${temp[@]} | sed -e 's/ /\n/g' | sort -u | wc -l) -ge $iplist ]
		then
			break
		else
			temp[$n]=$(echo [2606:4700:d1::$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2))):$(printf '%x\n' $(($RANDOM*2+$RANDOM%2)))])
			n=$[$n+1]
		fi
	done
}

freeCloudflareAccount(){
	output=$(curl -sL "https://api.zeroteam.top/warp?format=sing-box" | grep -Eo --color=never '"2606:4700:[0-9a-f:]+/128"|"private_key":"[0-9a-zA-Z\/+]+="|"reserved":\[[0-9]+(,[0-9]+){2}\]')
	publicKey=$(echo "$output" | grep -oP '("2606:4700:[0-9a-f:]+/128")' | tr -d '"')
	privateKey=$(echo "$output" | grep -oP '("private_key":"[0-9a-zA-Z\/+]+=")' | cut -d':' -f2 | tr -d '"')
	reserved=$(echo "$output" | grep -oP '(\[[0-9]+(,[0-9]+){2}\])' | tr -d '"' | sed 's/"reserved"://')
}

freeCloudflareAccount2(){
	output=$(curl -sL "https://api.zeroteam.top/warp?format=sing-box" | grep -Eo --color=never '"2606:4700:[0-9a-f:]+/128"|"private_key":"[0-9a-zA-Z\/+]+="|"reserved":\[[0-9]+(,[0-9]+){2}\]')
	publicKey2=$(echo "$output" | grep -oP '("2606:4700:[0-9a-f:]+/128")' | tr -d '"')
	privateKey2=$(echo "$output" | grep -oP '("private_key":"[0-9a-zA-Z\/+]+=")' | cut -d':' -f2 | tr -d '"')
	reserved2=$(echo "$output" | grep -oP '(\[[0-9]+(,[0-9]+){2}\])' | tr -d '"' | sed 's/"reserved"://')
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


template='#profile-title: base64:UGV6aG1hbiB8IFdBUlA=
{"log": {"disabled": false,"level": "fatal","timestamp": true},"experimental": {"clash_api": {"external_controller": "0.0.0.0:9090","external_ui": "yacd","external_ui_download_url": "https:\/\/github.com\/MetaCubeX\/Yacd-meta\/archive\/gh-pages.zip","external_ui_download_detour": "direct","secret": "","default_mode": "rule"}},"dns": {"servers": [{"address": "tcp:\/\/185.228.168.9","address_resolver": "dns-direct","strategy": "ipv4_only","tag": "dns-remote"},{"address": "tcp:\/\/185.228.168.9","address_resolver": "dns-local","detour": "direct","strategy": "ipv4_only","tag": "dns-direct"},{"address": "local","detour": "direct","tag": "dns-local"},{"address": "rcode:\/\/success","tag": "dns-block"}],"rules": [{"domain_suffix": [".ir"],"server": "dns-direct"},{"outbound": "direct","server": "dns-direct","rewrite_ttl": 20},{"outbound": "any","server": "dns-direct","rewrite_ttl": 20}],"reverse_mapping": true,"strategy": "ipv4_only","independent_cache": true},"inbounds": [{"listen": "0.0.0.0","listen_port": 6450,"override_address": "8.8.8.8","override_port": 53,"tag": "dns-in","type": "direct"},{"type": "tun","tag": "tun-in","domain_strategy": "","interface_name": "tun0","inet4_address": "172.19.0.1\/30","mtu": 9000,"auto_route": true,"strict_route": true,"stack": "system","endpoint_independent_nat": true,"sniff": true,"sniff_override_destination": false},{"domain_strategy": "","listen": "0.0.0.0","listen_port": 2080,"sniff": true,"sniff_override_destination": false,"tag": "mixed-in","type": "mixed"}],"outbounds": [{"tag": "proxy","type": "selector","outbounds": ["URL-TEST","Warp-IR","Warp-EU"]},{"tag": "URL-TEST","type": "urltest","outbounds": ["Warp-IR"],"url": "https:\/\/www.gstatic.com\/generate_204","interval": "3m","tolerance": 50},{"tag": "direct","type": "direct"},{"tag": "bypass","type": "block"},{"tag": "dns-out","type": "dns"},{"type": "wireguard","tag": "Warp-IR","server": "'$Endip_v4_ip'","server_port": '$Endip_v4_port',"local_address": ["172.16.0.2/32","'$publicKey'"],"private_key": "'$privateKey'","peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=","reserved":'$reserved',"mtu": 1280,"fake_packets": "5-10"},{"type": "wireguard","tag": "Warp-EU","detour": "Warp-IR","server": "'$Endip_v4_ip'","server_port": '$Endip_v4_port',"local_address": ["172.16.0.2/32","'$publicKey2'"],"private_key": "'$privateKey2'","peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=","reserved": '$reserved2',"mtu": 1280,"fake_packets": "5-10"}],"route": {"auto_detect_interface": true,"override_android_vpn": true,"final": "proxy","geoip": {"download_url": "https:\/\/github.com\/MiSaturo\/sing-box-geoip-ir\/releases\/latest\/download\/geoip.db","download_detour": "direct"},"geosite": {"download_url": "https:\/\/github.com\/MasterKia\/iran-hosted-domains\/releases\/latest\/download\/iran-geosite.db","download_detour": "direct"},"rules": [{"outbound": "dns-out","port": [53]},{"inbound": ["dns-in"],"outbound": "dns-out"},{"domain_suffix": [".ir"],"outbound": "bypass"},{"geoip": ["ir"],"outbound": "bypass"},{"geosite": ["ir"],"outbound": "direct"},{"geosite": ["other"],"outbound": "direct"},{"geosite": ["ads"],"outbound": "block"},{"ip_cidr": ["224.0.0.0\/3","ff00::\/8"],"outbound": "block","source_ip_cidr": ["224.0.0.0\/3","ff00::\/8"]}]}}


'
	# echo "$template"
 	# Print the template in green
  	echo -e "${green}$template${rest}"


    rm warpendpoint >/dev/null 2>&1
    rm -rf ip.txt
	rm -rf result.csv
    exit
}


cfwarpIP
endipv4
endipresult
Endip_v4
























#  	template='#profile-title: base64:VFZDIHwgV0FSUCA=
# #profile-update-interval: 1
# #subscription-userinfo: upload=0; download=0; total=10737418240000000; expire=2546249531
# #support-url: https: //t.me/v2raycollector
# #profile-web-page-url: https: //github.com/yebekhe/TelegramV2rayCollector
# {
#   "log": {
#     "disabled": false,
#     "level": "fatal",
#     "timestamp": true
#   },
#   "experimental": {
#     "clash_api": {
#       "external_controller": "0.0.0.0:9090",
#       "external_ui": "yacd",
#       "external_ui_download_url": "https:\/\/github.com\/MetaCubeX\/Yacd-meta\/archive\/gh-pages.zip",
#       "external_ui_download_detour": "direct",
#       "secret": "",
#       "default_mode": "rule"
#     }
#   },
#   "dns": {
#     "servers": [
#       {
#         "address": "tcp:\/\/185.228.168.9",
#         "address_resolver": "dns-direct",
#         "strategy": "ipv4_only",
#         "tag": "dns-remote"
#       },
#       {
#         "address": "tcp:\/\/185.228.168.9",
#         "address_resolver": "dns-local",
#         "detour": "direct",
#         "strategy": "ipv4_only",
#         "tag": "dns-direct"
#       },
#       {
#         "address": "local",
#         "detour": "direct",
#         "tag": "dns-local"
#       },
#       {
#         "address": "rcode:\/\/success",
#         "tag": "dns-block"
#       }
#     ],
#     "rules": [
#       {
#         "domain_suffix": [
#           ".ir"
#         ],
#         "server": "dns-direct"
#       },
#       {
#         "outbound": "direct",
#         "server": "dns-direct",
#         "rewrite_ttl": 20
#       },
#       {
#         "outbound": "any",
#         "server": "dns-direct",
#         "rewrite_ttl": 20
#       }
#     ],
#     "reverse_mapping": true,
#     "strategy": "ipv4_only",
#     "independent_cache": true
#   },
#   "inbounds": [
#     {
#       "listen": "0.0.0.0",
#       "listen_port": 6450,
#       "override_address": "8.8.8.8",
#       "override_port": 53,
#       "tag": "dns-in",
#       "type": "direct"
#     },
#     {
#       "type": "tun",
#       "tag": "tun-in",
#       "domain_strategy": "",
#       "interface_name": "tun0",
#       "inet4_address": "172.19.0.1\/30",
#       "mtu": 9000,
#       "auto_route": true,
#       "strict_route": true,
#       "stack": "system",
#       "endpoint_independent_nat": true,
#       "sniff": true,
#       "sniff_override_destination": false
#     },
#     {
#       "domain_strategy": "",
#       "listen": "0.0.0.0",
#       "listen_port": 2080,
#       "sniff": true,
#       "sniff_override_destination": false,
#       "tag": "mixed-in",
#       "type": "mixed"
#     }
#   ],
#   "outbounds": [
#     {
#       "tag": "proxy",
#       "type": "selector",
#       "outbounds": [
#         "URL-TEST",
#         "Warp-IR",
#         "Warp-EU"
#       ]
#     },
#     {
#       "tag": "URL-TEST",
#       "type": "urltest",
#       "outbounds": [
#         "Warp-IR"
#       ],
#       "url": "https:\/\/www.gstatic.com\/generate_204",
#       "interval": "3m",
#       "tolerance": 50
#     },
#     {
#       "tag": "direct",
#       "type": "direct"
#     },
#     {
#       "tag": "bypass",
#       "type": "block"
#     },
#     {
#       "tag": "dns-out",
#       "type": "dns"
#     },
#     {
#       "type": "wireguard",
#       "tag": "Warp-IR",
#       "server": "162.159.195.49",
#       "server_port": 928,
#       "local_address": [
#         "172.16.0.2/32",
#         "2606:4700:110:8065:b393:f0e:175b:1177/128"
#       ],
#       "private_key": "0EqXimhtAdkhMoGahAEESZeTBX/C9O5OJJ5Mpan+wE8=",
#       "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
#       "reserved": [
#         165,
#         238,
#         221
#       ],
#       "mtu": 1280,
#       "fake_packets": "5-10"
#     },
#     {
#       "type": "wireguard",
#       "tag": "Warp-EU",
#       "detour": "Warp-IR",
#       "server": "162.159.195.49",
#       "server_port": 928,
#       "local_address": [
#         "172.16.0.2/32",
#         "2606:4700:110:809b:ca5b:d285:c7e9:81f9/128"
#       ],
#       "private_key": "OOE+PDROEi83MOAGxt9Cz3deKcFhSn7sdXBksukIPWI=",
#       "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
#       "reserved": [
#         18,
#         4,
#         252
#       ],
#       "mtu": 1280,
#       "fake_packets": "5-10"
#     }
#   ],
#   "route": {
#     "auto_detect_interface": true,
#     "override_android_vpn": true,
#     "final": "proxy",
#     "geoip": {
#       "download_url": "https:\/\/github.com\/MiSaturo\/sing-box-geoip-ir\/releases\/latest\/download\/geoip.db",
#       "download_detour": "direct"
#     },
#     "geosite": {
#       "download_url": "https:\/\/github.com\/MasterKia\/iran-hosted-domains\/releases\/latest\/download\/iran-geosite.db",
#       "download_detour": "direct"
#     },
#     "rules": [
#       {
#         "outbound": "dns-out",
#         "port": [
#           53
#         ]
#       },
#       {
#         "inbound": [
#           "dns-in"
#         ],
#         "outbound": "dns-out"
#       },
#       {
#         "domain_suffix": [
#           ".ir"
#         ],
#         "outbound": "bypass"
#       },
#       {
#         "geoip": [
#           "ir"
#         ],
#         "outbound": "bypass"
#       },
#       {
#         "geosite": [
#           "ir"
#         ],
#         "outbound": "direct"
#       },
#       {
#         "geosite": [
#           "other"
#         ],
#         "outbound": "direct"
#       },
#       {
#         "geosite": [
#           "ads"
#         ],
#         "outbound": "block"
#       },
#       {
#         "ip_cidr": [
#           "224.0.0.0\/3",
#           "ff00::\/8"
#         ],
#         "outbound": "block",
#         "source_ip_cidr": [
#           "224.0.0.0\/3",
#           "ff00::\/8"
#         ]
#       }
#     ]
#   }
# }'
