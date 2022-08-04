#!/usr/bin/env bash
# This script generates ovpn profile for client vpn
vpn_endpoint_id=${VPN_ID}
echo "generate vpn client config file ..."
aws ec2 export-client-vpn-client-configuration \
    --client-vpn-endpoint-id $vpn_endpoint_id --region ${REGION}  \
    --output text > ${VPN_SERVER}.ovpn
sed -i~ "s/^remote /remote client1./"  ${VPN_SERVER}.ovpn
echo "<cert>"                      >>  ${VPN_SERVER}.ovpn
cat ./certificates/issued/client1.vpn.aws.com.crt  >>  ${VPN_SERVER}.ovpn
echo "</cert>"                     >>  ${VPN_SERVER}.ovpn
echo "<key>"                       >>  ${VPN_SERVER}.ovpn
cat ./certificates/private/client1.vpn.aws.com.key >>  ${VPN_SERVER}.ovpn
echo "</key>"                      >>  ${VPN_SERVER}.ovpn
echo "Your OpenVPN client profile has been created, with certificates added, and is available at $(pwd)/${VPN_SERVER}.ovpn"

echo "generate nameserver file ..."
aws ec2 describe-client-vpn-endpoints  --client-vpn-endpoint-id $vpn_endpoint_id --region ${REGION} --output text | grep DNSSERVERS | awk  '{print $2}' >  nameserver