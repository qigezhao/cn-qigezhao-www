#!/bin/bash
# install

GROUP_NAME="cn_qigezhao"
PROC_NAME="www"

APP_NAME="cn-qigezhao-www"
REPO_DIR="/repo/$APP_NAME"
WWW_DIR="/www/$APP_NAME"

GIT_URL="https://gitee.com/qigezhao_cn/cn-qigezhao-www.git"


echo "Installing $APP_NAME:"
cd /tmp


echo "- updating yum..."
yum update -y


echo "- installing nginx..."
yum install -y nginx


echo "- installing supervisor..."
yum install -y supervisor
echo_supervisord_conf > supervisord.conf
echo "[includes]" >> supervisord.conf
echo "files = /etc/supervisord.d/*.ini" >> supervisord.conf
mv /etc/supervisord.conf /etc/supervisord.conf.bak
mv supervisord.conf /etc/


echo "installing python3..."
yum install -y python3


echo "installing git..."
yum install -y git


echo "installing $APP_NAME..."
mkdir -p $REPO_DIR
cd $REPO_DIR
git clone $GIT_URL
cd $APP_NAME
mkdir -p $WWW_DIR
cd $WWW_DIR
cp -rf www/* $WWW_DIR


echo "copying configuration files of $APP_NAME..."
cd $WWW_DIR
cp -rf files/nginx.conf /etc/nginx/nginx.conf
cp -rf files/supervisor_$APP_NAME.ini /etc/supervisord.d/


echo
echo "----------------------------------------------------------------"
echo "[$APP_NAME] is configured and ready to start"
echo
echo "> supervisord"
echo "> supervisorctl status"
echo "> supervisorctl reload"
echo "> supervisorctl restart $GROUP_NAME:$PROC_NAME"
echo
echo "> nginx"
echo "> nginx -t"
echo "> nginx -s reload"
