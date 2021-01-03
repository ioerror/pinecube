#!/bin/bash

# We want to enable WireGuard by default
MODULES=$(grep 'wireguard' /etc/modules);
if [ $? == 1 ]; then
  cat << 'EOF' >> /etc/modules
wireguard
EOF
fi

if [ ! -d /etc/wireguard ]; then
  mkdir -p /etc/wireguard;
fi

umask 077
if [ ! -e /etc/wireguard/wg0.priv ]; then
  wg genkey > /etc/wireguard/wg0.priv;
fi
if [ ! -e /etc/wireguard/wg0.pub ]; then
  wg pubkey < /etc/wireguard/wg0.priv > /etc/wireguard/wg0.pub;
fi

# This fwmark configuration allows for using only the IP address of the machine
# as both an endpoint and the inner IP address; the wg0 interface does not need
# an additional IP address. Both ends must use a similar fwmark and table
# stanza; using an identical PostUp/Postdown will allow two machines to
# communicate directly over WireGuard where the only traffic routed to the
# peer's endpoint IP is protected by WireGuard.
PRIVATE_KEY=$(cat /etc/wireguard/wg0.priv)
cat << EOF > /etc/wireguard/wg0.conf
[Interface]
PrivateKey = ${PRIVATE_KEY}
ListenPort = 51820
FwMark = 556
Table = 667
PostUp = ip -4 rule add not fwmark 556 table 667 pref 667;ip -6 rule add not fwmark 556 table 667 pref 667;
PostDown = ip -4 rule delete table 667;ip -6 rule delete table 667;

#[Peer]
#PublicKey = <peer public key>
#AllowedIPs = <peer IP/32>
#Endpoint = <peer IP:PORT>
EOF

chmod -R 660 /etc/wireguard;
