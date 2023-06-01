#!/bin/bash

################################################################################
# 処理概要:      Tableau DesktopのATRトークンの状態をSlackチャンネルに通知する
# コマンド:      curl -sf https://raw.githubusercontent.com/Taichi-Ibi/tableau-account-management/main/scr/check-atr.sh | sh -s {TABLEAU_VERSION} {WEBHOOK_URL}
# 作者:          Phil (Taichi Ibi)
# 作成日時:      2023-05-26
################################################################################

HOSTNAME=`hostname` # PC名を取得
if [ $# = 0 ]; then
    exit 1 # 引数がなかったらversion特定できないので終了
else
    ATR=`"/Applications/Tableau Desktop "$1".app/Contents/MacOS/atrdiag" | grep -m 2 TTL`
    MESSAGE=$HOSTNAME"\n"$ATR
    MESSAGE=$(echo "$MESSAGE" | tr -s '\n')
    echo "$MESSAGE" # ATRトークンの期限を出力
fi
if [ $# = 1 ]; then
    exit 0
else # WEBHOOK_URLが指定された場合
    PAYLOAD="payload={\"text\": \"$MESSAGE\"}"
    curl -XPOST --data-urlencode "${PAYLOAD}" "$2" > /dev/null # slackに通知
    exit 0
fi