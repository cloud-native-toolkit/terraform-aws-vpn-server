#!/usr/bin/env bash
# This script generates ovpn profile for client vpn
vpn_endpoint_id=${VPN_ID}

tput setaf 2; echo ">> generate vpn client config file ..."; tput setaf 9
aws ec2 export-client-vpn-client-configuration \
    --client-vpn-endpoint-id $vpn_endpoint_id --region ${REGION}  \
    --output text > ${VPN_SERVER}.ovpn
sed -i~ "s/^remote /remote client1./"  ${VPN_SERVER}.ovpn
echo "<cert>"                      >>  ${VPN_SERVER}.ovpn
cat /Users/fahim/Desktop/Project/terraform-aws-vpn-server/test/stages/certificates/issued/client1.vpn.ibm.com.crt  >>  ${VPN_SERVER}.ovpn
echo "</cert>"                     >>  ${VPN_SERVER}.ovpn
echo "<key>"                       >>  ${VPN_SERVER}.ovpn
cat /Users/fahim/Desktop/Project/terraform-aws-vpn-server/test/stages/certificates/private/client1.vpn.ibm.com.key >>  ${VPN_SERVER}.ovpn
echo "</key>"                      >>  ${VPN_SERVER}.ovpn

echo "Your OpenVPN client profile has been created, with certificates added, and is available at $(pwd)/${VPN_SERVER}.ovpn"