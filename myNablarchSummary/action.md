- [JSP カスタムタグ](./jsp.md)
- [Form](./form.md)
- [Domain](./domain.md)

# Nablarch Action 記述

## 軽い目次

- [画面遷移](#画面遷移)
- [精査実行](#精査実行)
- [二重サブミット防止](#二重サブミット防止)
- [リクエストスコープ](#リクエストスコープ)
- [セッション](#セッション)
- [DB アクセス](#db-アクセス)
- [ページング](#ページング)
- [SQL ファイル](#sql-ファイル)
- [DTO](#dto)
- [エラー遷移](#エラー遷移)

## 画面遷移

- ページの呼び出し

```java
return new HttpResponce("hoge/hogehoge.jsp");
```

引数は、遷移先の JSP のパス

- フォワード

```java
return new HttpResponce("forward://hoge");
```

`forward://（呼び出しメソッド名）`

例の場合`hoge`メソッドが呼び出される

- リダイレクト

```java
return new HttpResponce("redirect://hoge");
```

forward と同様

## 精査実行

form に記述した精査を実行する。各メソッドの頭でアノテーション

```java
@InjectForm(form = HogeForm.class,prefix = "hogeForm")
```

- 精査エラー処理
  精査エラーがおきると`ApplicationException`が発生する。この例外が発生した時の遷移先を設定する。（`ApplicationException`限定ではない）

  ```java
  @OnError(type = ApplicationException.class, path = "forward://hoge")
  ```

  `path`は`HttpResponce()`の要領

## 二重サブミット防止

```java
@OnDoubleSubmission(path="hoge.jsp")
```

## リクエストスコープ

- 値を set

```java
context.setRequestScopedVar("hoge",obj);
```

`setRequestScopeVar(登録名,登録オブジェクト)`

- 値を get

```java
context.getRequestScopedVar("hoge");
```

`getRequestScopeVar(登録名)`

# セッション

- 値を set

```java
SessionUtil.put(context,sessionKey,value);
// sessionKeyは、マッピングするstring
// value は追加するオブジェクト
```

`sessionKey`は String オブジェクト。Map みたいなイメージで、登録したり保存したりできる

- 値を get

```java
SessionUtil.get(context,sessionKey);
```

`sessionKey`は String オブジェクト。Map みたいなイメージで、登録したり保存したりできる

- セッションを削除

```java
SessionUtil.delete(context,sessionKey);
```

`sessionKey`: String オブジェクト。Map みたいなイメージで、登録したり保存したりできる

## DB アクセス

`UniversalDao`を使う

SQL ファイルについての書き方については[こっち](#Sqlファイル)

また、Dto については[こっち](#Dto)

DB アクセスと SQL ファイルの例では、`Member`というエンティティをとってくるっていうテイでいこうと思います。

- 全てのエンティティを取得

  ```java
  UniversalDao.findAll(Member.class);
  ```

  Member のエンティティを全てとってくる（Nablarch が MEMBER テーブルから全部取ってくる SQL を自動生成して取ってくる）

- SQL ファイルを使ってエンティティのリストを取得

  ```java
  UniversalDao.findAllBySqlFile(Item.class,"FIND_BY_MEMBER_ID",new Object[]{Integer.parseInt(memberId)});
  ```

  `FIND_BY_MEMBER_ID`という SQL-ID で定義された SQL メソッドを実行し、
  結果を List で取得。

  第三引数を`Object[]`にしたのは、現状正直よくわかってない。そもそも{ }を使っているけど、これって文法的に何故間違ってないかもわかってない。わかってないだらけですね・・・・

  memberId は String の想定で、parseInt()してます。DB 側のデータ型が varchar2 とかなら、必要ないです。

  - データベースに存在しているか判定する

  ```java
  UniversalDao.exsits(Item.class,"FIND_BY_MEMBER_ID",new Object[]{Integer.parseInt(memberId)});
  ```

  存在していたら、`true`を返す

  - レコードを追加する。

  ```java
  UniversalDao.insert(member);
  ```

  `DuplicateStatementException`が投げられる可能性がある。

  - レコードを更新する。

  ```java
  UniversalDao.update(member);
  ```

  `NoDataException`が投げられる可能性がある。

## ページング

- 1 ページあたりの件数と、表示するページ数を指定してページングする。

  ```java
  List<Hoge> hogeList = UniversalDao.page(pageNum).per(perNum).findAllBySqlFile(Hoge.class,"FIND_ALL");
  ```

  - `pageNum`: 表示するページ数(long)
  - `perNum` : 1 ページ当たりの表示件数(long)

- Pagination の取得
  ```java
  Pagination pagination = hogeList.getPagination();
  ```
- 総ページ数の取得

  ```java
  pagination.getPageCount();
  ```

- 次ページの存在確認
  ```java
  pagination.hasNextPage()
  ```
- 次ページ番号取得

  ```java
  pagination.getNextPageNumber();
  ```

- 前ページ存在確認

  ```java
  pagination.hasPrevPage()
  ```

- 前ページ番号取得

  ```java
  pagination.getPrevPageNumber();
  ```

後ろ 4 つは、どっちかというと[JSP](./jsp.md)側で使うかも。纏め方下手でスイマセン。

## SQL ファイル

- ファイルの作成場所

`resources`内に作成。場所は`java`内のエンティティファイルと同様の場所に格納

以下例

```sql
FIND_BY_MEMBER_ID=
    SELECT
        *
    FROM
        MEMBER
    WHERE
        MEMBER_ID = :memberId
```

## DTO

DTO（Data Transfer Object）

複数テーブルから取ってくる（INNER JOIN とかする）場合のように、
エンティティだけでは表現できない場合に使う

DTO クラスを`java`内に作成し、対応する SQL ファイルを`resources`内に作成する。

## エラー遷移

- ApplicationException にエラーメッセージを持たせる。

```java
Message message = MessageUtil.createMessage(MessageLevel.ERROR,"hoge.hogehoge.hogeMessage");
throw new ApplicationException(message);
```

- `ApplicationException`以外のページに遷移する。

```java
throw new HttpErrorResponse("WEB-INF/hoge/hogehoge/hoge.jsp");
```

- `HttpErrorResponse`の先でエラーメッセージを表示させる。

```java
Message message = MessageUtil.createMessage(MessageLevel.ERROR,"hoge.hogehoge.hogeMessage");
WebUtil.notifyMessages(ctx,message);
throw new HttpErrorResponse("WEB-INF/hoge/hogehoge/hoge.jsp");
```
