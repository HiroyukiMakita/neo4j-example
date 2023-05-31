# チュートリアル（[Tutorial - Cypher Manual](https://neo4j.com/docs/cypher-manual/current/introduction/cypher_tutorial/#_note_on_clause_composition)）で Cypher を試す


Neo4j ブラウザ（http://localhost:7474/browser/） の以下コマンドでガイドを動かせる

```
$ :play write code
```

## データモデルの作成

<div style="{background-color: #FFFFFF;}">
    <image src="https://neo4j.com/docs/cypher-manual/current/_images/introduction_schema.svg"></image>
</div>

## 各ノードは以下のようにプロパティを持つとする。

- `Person`ノード
  - `name`(文字列)
  - `born`(整数)
- `Movie`ノード
  - `title` (文字列)
  - `released`(整数)
  - `tagline`(文字列)

データモデルには以下の関係タイプも含まれており、そのうち 2 つの関係タイプはプロパティを持つ

- `ACTED_IN`
  - `roles`(文字列)
- `DIRECTED`
- `PRODUCED`
- `WROTE`
- `REVIEWED`
  - `summary`(文字列)
  - `rating`(浮動小数点数)

## ## プロパティグラフデータベースの作成

## ノードの検索

## ## **条項構成上の注意**

## ## **接続されているノードの検索**

## ## **パスの検索**

## ## **推奨事項の検索**

## ## **グラフを削除する**
