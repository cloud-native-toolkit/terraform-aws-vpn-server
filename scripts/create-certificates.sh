#!/usr/bin/env bash
# This script generates certificate for client vpn
PATH=$BIN_DIR:$PATH

echo "Cloning easy-rsa"
rm -rf easy-rsa
curl -L -o EasyRSA-3.0.8.tgz https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.8/EasyRSA-3.0.8.tgz
tar zxvf EasyRSA-3.0.8.tgz
cd EasyRSA-3.0.8
#pwd
#ls -la


echo "Creating PKI and CA"
export EASYRSA_BATCH=1
./easyrsa init-pki
./easyrsa build-ca nopass
if [ ! -f "pki/ca.crt" ]
then
    echo "pki/ca.crt could not be found."
    exit 1
fi


echo "Generating VPN server certificate"
./easyrsa build-server-full server.vpn.aws.com nopass

if [ ! -f "pki/issued/server.vpn.aws.com.crt" ]
then
    echo "pki/issued/server.vpn.aws.com.crt could not be found."
    exit 1
fi

if [ ! -f "pki/private/server.vpn.aws.com.key" ]
then
    echo "pki/private/server.vpn.aws.com.key could not be found."
    exit 1
fi


echo "Generating VPN client certificate"
./easyrsa build-client-full client1.vpn.aws.com nopass

if [ ! -f "pki/issued/client1.vpn.aws.com.crt" ]
then
    echo "pki/issued/client1.vpn.aws.com.crt could not be found."
    exit 1
fi

if [ ! -f "pki/private/client1.vpn.aws.com.key" ]
then
    echo "pki/private/client1.vpn.aws.com.key could not be found."
    exit 1
fi

pwd
cd ..
rm -rf certificates
mkdir certificates
mv EasyRSA-3.0.8/pki/* certificates

# pwd
# ls -lRa certificates

echo "vpn:" > output.yaml
echo "  ca: \"$(pwd)/certificates/ca.crt\"" >> output.yaml
echo "  server-cert: \"$(pwd)/certificates/issued/server.vpn.aws.com.crt\"" >> output.yaml
echo "  server-key: \"$(pwd)/certificates/private/server.vpn.aws.com.key\"" >> output.yaml
echo "  client-cert: \"$(pwd)/certificates/issued/client1.vpn.aws.com.crt\"" >> output.yaml
echo "  client-key: \"$(pwd)/certificates/private/client1.vpn.aws.com.key\"" >> output.yaml

echo "Complete:"
cat output.yaml

rm -rf EasyRSA-*