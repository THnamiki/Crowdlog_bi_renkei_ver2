# 始め方

## 開発用フォルダ作成

```
mkdir cloudfunctions_test
cd cloudfunctions_test
```

## ローカルリポジトリ作成

```
git init
```

## ソースコード取得
clone

- sshを使用する場合（[設定方法]()）https://cloud.google.com/source-repositories/docs/authentication?authuser=0#ssh

```
git clone ssh://[first_name].[last_name]@tbwahakuhodo.co.jp@source.developers.google.com:2022/p/th-all/r/cloudfunctions_test
```

- CloudSDKを使用する場合([CloudSDKインストール方法](https://cloud.google.com/sdk?authuser=0))：奈良本はこちらは使ったことありません。

```
gcloud source repos clone cloudfunctions_test --project=th-all
```

ディレクトリ名変更

```
mv cloudfunctions_test backend
```

[秘匿ファイル](https://drive.google.com/drive/folders/16A9MDRNp_oprd-kIZo6FjDu7i6p7jS5J)をディレクトリ構成を変更せずにbackendディレクトリ直下に配置

- .secret/th-all-3d9764a8e71b.json
- .env

pull

```
cd backend
git pull origin main
```


## コンテナ起動

上位階層に移動
```
cd ..
```

docker-compose.yml作成
```
echo 'version: "3.8"
services:
  app:
    build: ./backend
    command: >
      sh -c "pnpm i &&
      pnpm start"
    volumes:
      - type: bind
        source: ./backend
        target: /backend
    working_dir: /backend
    ports:
      - 8880:8080
    tty: true
volumes:
  node_modules_backend:' >> docker-compose.yml
```

コンテナ起動
```
docker compose up -d
```

## API実行確認
標準出力にデータ出力されることを確認
```
curl -X GET http://localhost:8880
```
curl http://localhost:8880


# CloudFunctionsに本番デプロイ（仮）
※ とっても面倒なので、のちのち簡単にデプロイする手順を考えます

```
// コンテナを起動していない場合、ココから
docker compose up -d
// コンテナに入っていない場合、ココから
docker compose exec app ash
// コンテナに入っている場合、ココから
pnpm build
...TBD
```
--よく使うコマンド--
docker compose down　//ダウン
docker compose up -d　//コンテナ起動
docker compose exec app ash　//コンテナの中に入る
pnpm build　//ビルド
pnpm start　//スタート
docker compose ps　//起動しているコンテナの情報を見る。
docker compose ps -a　//起動していないコンテナも含めてコンテナの情報を見る。
docker compose logs app　//ログを見る
docker compose build --no-cache //キャッシュを使わないでビルドする

【git】---------------------------
(言葉の意味)
・ワーキングツリー[working tree]：最新のファイルの状態
・インデックス[index]（ステージ[stage]）：コミットするためのファイルの状態
・ローカルリポジトリ[local repository]：ファイルの変更履歴を記録（手元で管理）
・ヘッド[HEAD]：最新のコミットの状態
・リモートリポジトリ[remote repository]：ファイルの変更履歴を記録（みんなで共有）

git status　 gitしていないファイルを確認
git add --all  ステージングエリアへアップする
git commit -m "メッセージ"
git push --all google   コミットしたファイルをリモートリポジトリへアップする
git push origin dev  devへコミットいsたファイルをリモートリポジトリへアップする
ls -la  現在のディレクトリからファイルを表示
git branch -av  リモートを含むブランチの一覧情報を表示
git config -l(--list)  設定されているすべての値を表示する  
-----
git fetch  リモートの「master」ブランチ → ローカルの「origin/master」ブランチへ持ってくる
git merge  ローカルの「origin/master」ブランチ → ローカルの「master」ブランチへ持ってくる
git pull   fetch、mergeを同時に行う
（以上、以下サイト参照 https://qiita.com/wann/items/688bc17460a457104d7d） 
-----
git reset --hard   全部取り消し
git reset --mixed  commitとaddの取り消し
git reset --soft   commitのみ取り消し
git reset HEAD     インデックスの変更（addした内容）のみ元に戻す
git log   コミットの履歴を見る
git reflog   これまでHEADが辿ってきた履歴を見る
git remote add [名前] [URL]   新しいリモートリポジトリを追加
git init   リポジトリを新規に作成(「. git」という リポジトリを構成するディレクトリが作成される）
git checkout <ブランチ名>  ブランチの切り替えを行う
git checkout -b <新しいブランチ名> 　指定したブランチが存在しなければ新しくブランチを作り、そのブランチへの切り替えを行う
---------------------------