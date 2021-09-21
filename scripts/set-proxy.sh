#!/bin/bash

# Author Danny
# Version GIT: 2021-09-21 19:27

# set-proxy.sh 
# Set the proxy based on the environment variable http_proxy
# 
# Compatible with: git, yum, pip

echo -e "Starting ${0}"
echo -e "\e[32mConfiguring proxy server...\e[0m"

# Detection software
hash git 2>/dev/null ; git=$?

# Fallback for uppercase variable
if [ -n "${HTTP_PROXY}" ]
then
    export http_proxy=${HTTP_PROXY}
fi

# Setting or removing proxy server
if [ -n "${http_proxy}" ]
then
    echo "Setting proxy server: ${http_proxy}"
    export https_proxy=${http_proxy}
    hash git 2>/dev/null && git config --global http.proxy ${http_proxy}
    hash git 2>/dev/null && git config --global https.proxy ${http_proxy}
    test "/etc/yum.conf" && echo -e "[main]\nproxy=${http_proxy}" >> "/etc/yum.conf"
else
    echo "Setting empty proxy server"
    export https_proxy=
    hash git 2>/dev/null && git config --global --unset http.proxy
    hash git 2>/dev/null && git config --global --unset https.proxy 
    test "/etc/yum.conf" &&  sed '/^proxy=/d' /etc/yum.conf > /etc/yum.conf
fi

echo -e "\e[32mDone\e[0m"
