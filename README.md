# neo4j-example

## ## [Neo4j](https://neo4j.com/docs/getting-started/)

### ### 環境構築

ローカルにて、Docker で環境を構築します。  
また、`make` コマンド（ [GNU Make](https://www.gnu.org/software/make/)）を使用できる必要があります。

```
$ cd docker
$ make
```

上記コマンドを実行後、以下の URL で Neo4j ブラウザにアクセスできます。

[Neo4j ブラウザ（http://localhost:7474/）](http://localhost:7474/)

また、以下のコマンドで [Cypher Shell](https://neo4j.com/docs/operations-manual/current/tools/cypher-shell/) CLI にログインできます。

```
$ make exec-cypher
```
#### #### [サイファーシェル - 操作マニュアル](https://neo4j.com/docs/operations-manual/current/tools/cypher-shell/#cypher-shell-commands)

```
利用可能なコマンド:
  :begin トランザクションをオープンします
  :commit 現在開いているトランザクションをコミットします
  :connect データベースに接続します
  :disconnect データベースから切断します
  :exit ロガーを終了します
  :help このヘルプ メッセージを表示します
  :history ステートメント履歴
  :impersonate ユーザーになりすます
  :param クエリパラメータを設定、リスト、またはクリアします
  :rollback 現在開いているトランザクションをロールバックします
  :source ファイルから Cypher ステートメントを実行します
  :use アクティブなデータベースを設定します
```

## ## コミットメッセージのルール

Nuxt や React でも採用されている [Conventional Commits](https://www.conventionalcommits.org/ja/v1.0.0/) を採用しています。

参考：[Conventional Commits - コミットメッセージ仕様](https://zenn.dev/sumiren/articles/418f593dbbf601#%E4%BE%8B1.-nuxt)

また、[commitlint](https://commitlint.js.org/#/) というツールを使用して、Conventional Commits に従っているかチェックするようにしてみました。  
チェックされるタイミング

- [GitHub Actions](https://github.co.jp/features/actions) を使用してプルリクエスト時にチェック
- [🐶 husky](https://typicode.github.io/husky/) を使用してコミット前にチェック

参考：[GitHub Actions で Conventional Commits を満たしているかチェックする - Carpe Diem](https://christina04.hatenablog.com/entry/commitlint-on-github-actions)  
参考：[commitlint というコミットメッセージのリンターを導入してみた（前編：husky を使ってコミット前にリントする）](https://zenn.dev/kalubi/articles/27fa889c338cdf)

### ### 以下の流れで作成しました。

```
# package.json を作成
$ yarn init

# commitlint と husky を追加
$ yarn add -D @commitlint/cli @commitlint/config-conventional husky

# commitlint の config ファイルを追加
$ echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js

# プルリクエスト時に commitlint を実行するように GitHub Actions で設定
$ mkdir -p .github/workflows && touch .github/workflows/commitlint.yml

# Node のバージョンを Volta で固定
$ volta install node
$ volta install yarn
$ volta pin node
$ volta pin yarn

# husky の Git フックを有効にする
$ yarn husky install

# コミット前に commitlint を実行するように husky の Git フックを追加
$ yarn husky add .husky/commit-msg  'yarn commitlint --edit ${1}'
```
