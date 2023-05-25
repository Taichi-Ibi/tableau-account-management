#!/bin/bash

################################################################################
# 処理概要:      Tableau Desktopのアカウントが4時間後に解放されるようにATRトークンを設定する
# 使用方法:      sudo sh set-atr-token.sh
# 作者:          Phil (Taichi Ibi)
# 作成日時:      2023-05-26
# TODO:        
# - Tableauが起動していればメッセージを出力し、プログラムを終了する
# - Tableauのファイル名を変数化する
# - インストールされているTableauのversionを取得する
################################################################################

cd '/Applications/Tableau Desktop 2023.1.app/Contents/MacOS'
./atrdiag -setDuration 14400
./atrdiag -deleteAllATRs
open -a "Tableau Desktop 2023.1.app"