#!/bin/bash

################################################################################
# 処理概要:      Tableau DesktopのATRトークンの有効期間を設定する
# コマンド:      curl -sf https://raw.githubusercontent.com/Taichi-Ibi/tableau-account-management/main/scr/set-atr.sh | sh -s {duration} {TABLEAU_VERSION}
# 使用方法:      ATRトークンの設定期間を入力してください（例: 6h, 3d, 2w）
# 作者:          Phil (Taichi Ibi)
# 作成日時:      2023-05-26
# TODO:        
################################################################################

# ユーザーに期間を尋ねる
duration=$1
len=${#duration}
echo $len

if [[ $len -eq 0 || $len -eq 1 ]] ; then
    # 文字数が1文字以下だったら最小値を設定
    seconds=14400
else
    # 2文字以上の場合は単位を判別して秒数に変換する
    unit="${duration: -1}"
    seconds=${duration/%?/}
    seconds=$(($seconds * 60 * 60))
    if [[ $unit == "h" ]] ; then
        :
    elif [[ $unit == "d" ]] ; then
        seconds=$(($seconds * 24))
    elif [[ $unit == "w" ]] ; then
        seconds=$(($seconds * 24 * 7))
    else
        seconds=14400
    fi
fi

echo "ATRトークンを${seconds}秒に設定します。"
"/Applications/Tableau Desktop "$2".app/Contents/MacOS/atrdiag" -setDuration $seconds
"/Applications/Tableau Desktop "$2".app/Contents/MacOS/atrdiag" -deleteAllATRs
open -a "Tableau Desktop $2.app"