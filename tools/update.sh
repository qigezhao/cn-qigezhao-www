#!/bin/bash
# install

GROUP_NAME="cn_qigezhao"
PROC_NAME="www"

APP_NAME="cn-qigezhao-www"
REPO_DIR="/repo/$APP_NAME"
WWW_DIR="/www/$APP_NAME"

GIT_URL="https://gitee.com/qigezhao_cn/cn-qigezhao-www.git"


echo "Updating $APP_NAME:"
mkdir -p $REPO_DIR
cd $REPO_DIR
git clone $GIT_URL
cd $APP_NAME
mkdir -p $WWW_DIR
cd $WWW_DIR
cp -rf www/* $WWW_DIR
