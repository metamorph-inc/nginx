#!/bin/bash -x

set -e

# sudo add-apt-repository ppa:nginx/mainline

CODENAME=`lsb_release -cs`
cat <<EOF | sudo tee /etc/apt/sources.list.d/nginx-development.list
deb http://ppa.launchpad.net/nginx/development/ubuntu $CODENAME main
deb-src http://ppa.launchpad.net/nginx/development/ubuntu $CODENAME main
EOF
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 00A6F0A3C300EE8C
apt-get update

apt-get source nginx
apt-get build-dep -y nginx

git clone https://github.com/evanmiller/mod_zip.git mod_zip
export MOD_ZIP_DIR="$(pwd)"/mod_zip
cd nginx-1.* && patch -p1 <../mod_zip.patch && dpkg-buildpackage -b

mkdir -p /debs
cp ../*.deb /debs/

# dpkg --install nginx-common_*.deb
# dpkg --install nginx-full_*.deb
