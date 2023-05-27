#!/bin/bash

################################################################################
# 処理概要:      Tableau DesktopのATRトークンの状態をSlackチャンネルに通知する
# 使用方法:      sudo sh check-atr-token.sh
# 作者:          Phil (Taichi Ibi)
# 作成日時:      2023-05-26
# TODO:        
# - インストールされているTableauのversionを取得する
################################################################################

cd '/Applications/Tableau Desktop 2023.1.app/Contents/MacOS'
HOSTNAME=`hostname`
ATR=`./atrdiag | sed -n "3, 8p"`
MESSAGE=$HOSTNAME"\n"$ATR
MESSAGE=$(echo "$MESSAGE" | tr -s '\n')
echo "$MESSAGE"
PAYLOAD="payload={\"text\": \"$MESSAGE\"}"
curl -XPOST --data-urlencode "${PAYLOAD}" "$1" > /dev/null