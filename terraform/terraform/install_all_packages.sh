#!/bin/bash
set -e

echo "Updating system..."
yum update -y

echo "Installing Core OS Dependencies..."
yum install -y \
glibc \
libaio \
compat-libstdc++ \
unzip \
tar \
wget \
curl \
gcc \
make \
ksh \
uuidd

echo "Installing SAP Runtime Libraries..."
yum install -y \
xorg-x11-xauth \
xorg-x11-utils \
gtk2 \
libXtst \
libXext \
libXi \
libXrender \
motif

echo "Installing Java..."
yum install -y java-1.8.0-openjdk

echo "Installing Web Server Components..."
yum install -y httpd apr apr-util

echo "Installing Storage Tools..."
yum install -y nfs-utils cifs-utils lvm2

echo "Installing System Utilities..."
yum install -y net-tools bind-utils chrony sudo

echo "Installing Monitoring Agents..."
yum install -y amazon-cloudwatch-agent awscli

echo "Installing Security Packages..."
yum install -y openssh-clients openssl ca-certificates audit

echo "Creating SAP Directory..."
mkdir -p /opt/sapbi
cd /opt/sapbi

echo "Downloading SAP BI Installer..."
# aws s3 cp s3://your-bucket/SAPBI_4.3.zip .

echo "Extracting Installer..."
# unzip SAPBI_4.3.zip

echo "Running Silent Installation..."
# ./setup.sh --silent --responseFile /tmp/response.ini

echo "Cleaning logs before AMI..."
rm -rf /tmp/*
history -c

echo "Installation Completed Successfully”
