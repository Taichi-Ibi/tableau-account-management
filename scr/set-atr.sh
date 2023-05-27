#!/bin/bash

################################################################################
# 処理概要:      Tableau DesktopのATRトークンの有効期間を設定する
# 使用方法:      sudo sh set-atr-token.sh
# 作者:          Phil (Taichi Ibi)
# 作成日時:      2023-05-26
# TODO:        
# - インストールされているTableauのversionを取得する
################################################################################

# ユーザーに期間を尋ねる
echo "ATRトークンの設定期間を入力してください（例: 6h, 3d, 2w）"
read duration
len=${#duration}

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
cd '/Applications/Tableau Desktop 2023.1.app/Contents/MacOS'
./atrdiag -setDuration $seconds
./atrdiag -deleteAllATRs
open -a "Tableau Desktop 2023.1.app"