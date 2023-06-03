# アクティブ化を最大にする ATR トークン期間を短縮するには
> 参考ページ: [ログインベースのライセンス管理](https://help.tableau.com/current/server/ja-jp/license_lblm.htm)

1. 使用されなくなる Tableau Desktop コンピューターで管理者としてコマンド プロンプトを開きます。

2. 次のコマンドを使用し、Tableau バイナリ (\bin) ディレクトリに移動します。
> 2023.1の部分はTableauのversionを確認して適宜書き換えてください。
```bash
cd '/Applications/Tableau Desktop 2023.1.app/Contents/MacOS'
```

3. 次のコマンドを実行して、期間を 4 時間に設定します (秒単位で 14400)。
```bash
sudo ./atrdiag -setDuration 14400
```

4. 次のコマンドを使用して、前の ATR トークンを削除します。
```bash
./atrdiag -deleteAllATRs
```

5. 次に、既存の ATR トークンを上書きします。Tableau Desktop を開きます。Tableau は、「ライセンスが変更されました」というメッセージを表示します。[終了] をクリックして、Tableau Desktop をもう一度開きます。

6. 登録ダイアログ ボックスで、[アクティブ化] をクリックしてから、既存のトークンを上書きする ログインベースのライセンス管理 を使用して Tableau Server 経由で Tableau Desktop をもう一度アクティブ化します。

7. Tableau Desktop を閉じて ATR 期間が経過するまで待機し (4 時間など)、ATR トークンの有効期限が切れてユーザー シートが解放されるようにします。ATR 期間が経過するまで Tableau Desktop は開かないでください。ATR 期間が経過したことを確認してください。ATR トークンの TTL End には、将来の日付と時刻が表示されます (たとえば、今から 4 時間後)。

8. ATR トークンの有効期限が切れたら、新しいコンピューターで Tableau Server に正常にサインインできます。