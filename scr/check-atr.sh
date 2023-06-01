#!/bin/bash

################################################################################
# 処理概要:      Tableau DesktopのATRトークンの状態をSlackチャンネルに通知する
# コマンド:      curl -sf https://raw.githubusercontent.com/Taichi-Ibi/tableau-account-management/main/scr/check-atr.sh | sh -s {WEBHOOK_URL} {TABLEAU_VERSION}
# 作者:          Phil (Taichi Ibi)
# 作成日時:      2023-05-26
################################################################################

HOSTNAME=`hostname`
ATR=`"/Applications/Tableau Desktop "$2".app/Contents/MacOS/atrdiag" | sed -n "3, 8p"`
MESSAGE=$HOSTNAME"\n"$ATR
MESSAGE=$(echo "$MESSAGE" | tr -s '\n')
echo "$MESSAGE"
PAYLOAD="payload={\"text\": \"$MESSAGE\"}"
curl -XPOST --data-urlencode "${PAYLOAD}" "$1" > /dev/null