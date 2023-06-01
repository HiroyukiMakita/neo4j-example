# # 主な Cypher の使い方をざっくり

参考：[Cypher のノード(Node)の基本を理解する - Qiita](https://qiita.com/makopo/items/d0585e4e52985fcaf66a)  
　　　古い情報だけどノードの使い方の基礎が細かく書かれてるので参考になる  
参考：[Cypher のリレーションシップ(Relationship)の基本を理解する - Qiita](https://qiita.com/makopo/items/76ae5be981c90c06877e)  
　　　古い情報だけどリレーションシップの使い方の ry  
参考：[Cypher ならできる！SQL には難しいこと 10 選（前編） #neo4j #cypher #sql - クリエーションライン株式会社](https://www.creationline.com/lab/51530)

- 公式の Cypher のリファレンス  
  [Cypher Cheat Sheet - Neo4j Community Edition](https://neo4j.com/docs/cypher-cheat-sheet/5/neo4j-community/)

- [命名規則と推奨事項 - Cypher Manual](https://neo4j.com/docs/cypher-manual/5/syntax/naming/#_naming_rules)

### ● 【値と型】

- 構造型
  - Node  
    ID、ラベル、プロパティのマップを含む
  - Relationship  
    ID、タイプ、プロパティのマップ、開始ノード ID、および終了ノード ID が含まれる
  - Path  
    ノードとリレーションシップの交互シーケンス
- 複合型
  - List  
    同種または異種の順序付けられた（構造型、複合型、プロパティ型の）コレクション
  - Map  
    ( Key、Value ) ペアの順序なしコレクション  
    Key はリテラルで、Value は任意の構造型、複合型、プロパティ型を持てる
- プロパティ型（[プロパティ型の詳細 - Cypher Manual](https://neo4j.com/docs/cypher-manual/5/values-and-types/property-structural-composite/#_property_type_details)）

  - Boolean
  - Date
  - DateTime
  - Duration
  - Float
  - Integer
  - LocalDateTime
  - LocalTime
  - Point
  - String
  - Time

### ● 【ノード】

すべてのノード（エンティティ）は括弧で囲まれている  
また、括弧の中にノードの種類や追加の属性などを入れることができます。

最小限のノード作成  
id だけのノードが作成される

```
CREATE ()                                  // 最小限の id だけのノード作成
CREATE({name:'Taro'})                      // name というプロパティが 'Taro' のノード作成
CREATE({name:'Taro', age:33})              // カンマ区切りで name と age というプロパティを設定したノード作成
CREATE(:Person {name:'Taro', age:33})      // Person というラベルも設定したノード作成
CREATE(:Person:Boss {name:'Taro',age:33})  // 複数のラベルも設定できる
```

以下のように、例えば n のような識別子を設定することで、作成したノードが n に入り、  
作成後、すぐに返却することができる。

```
CREATE (n:Test {name: 'test'})
RETURN ID(n), n.name
```

id が 1 の場合、以下のクエリで取得できた

```
MATCH (n)
WHERE id(n) = 1
RETURN n
```

### 【リレーションシップ】

ダッシュ記号を 2 つ連ねてリレーションシップを表す。  
または、2 本のダッシュと大なり記号を組み合わせて矢印にしたり、角括弧を使って追加の情報を挿入できる。

```
--                          // 無向関係
-->                         // 左から右の有向関係
-[:RATED]->                 // 左から右の有向関係に RATED というタイプをつける
-[:RATED {stars:5}]->       // 左から右の有向関係に RATED というタイプ、status というプロパティに 5 を設定
-[:AAA|BBB]->               // 検索の際に複数のタイプを一度に検索できる
```

```
MATCH (a:....)            // ノードを任意の条件で検索し、aとする
MATCH (b:....)            // ノードを任意の条件で検索し、bとする
CREATE (a)-[:AAA]->(b)    // a から b へ AAA というタイプを設定したリレーションシップを作成
```

```
CREATE (a)-[:AAA{name:'bbb'}]->(b)  // ノードと同じように、タイプやプロパティを設定可能
CREATE (a)-[r:AAA]->(b)             // 識別子 r で参照できる様になる
```

### ● 検索

すべてのノードを取得

```
MATCH n=()
RETURN n
```

すべてのノードの関数を取得できた

```
MATCH n=()
RETURN COUNT(n)
```

無向のリレーションシップをすべて取得  
※ 無向関係の取得では、左から右の無向関係、右から左の無向関係の同じパスが 2 回検索結果に含まれる。

```
MATCH r=()--()
RETURN r
```

有向のリレーションシップをすべて取得

```
MATCH r=()-->()
RETURN r
```

始端終端ノードを限定して検索

```
(a)--()    // 両方向
()--(a)    // 上とまったく同じ結果
(a)-->()   // aから他へのパス
(a)<--()   // 他からaへのパス
```

タイプやプロパティで絞り込む

```
()-[:AAA]->()           // タイプが AAA のリレーションシップ
()-[{name:'bbb’}]->()   // name プロパティが bbb のリレーションシップ
()-[:AAA|BBB]->()       // AAA または BBB のリレーションシップ
```

間にノードが 1 つ挟まっている（2 ホップという）パスを検索

```
({title: 'The Matrix'})--()--({title: 'Cloud Atlas'})
({title: 'The Matrix'})-[:DIRECTED]-()-[:DIRECTED]-({title: 'Cloud Atlas'}) // 複数ホップでも絞り込み可能
```

省略記法

```
(a)-[*2]-(b)                        // (a)--()--(b)
(a)-[*3..4]-(b)                     // (a)--()--()--(b)または(a)--()--()--()--(b)
(a)-[*3..]-(b)                      // (a)--()--()--(b)以上のホップ数
(a)-[*..3]-(b)                      // (a)--()--()--(b)以下のホップ数
(a)-[*]-(b)                         // ホップ数無制限
(a)-[*0..]-(b)                      // ホップ数無制限 (a)のみというパスも含む

()-[r:TYPE*3..4{key:'value'}]-()　  // すべてのホップで同じ条件で良い場合、省略記法でもタイプやプロパティで絞り込める
```
