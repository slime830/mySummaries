- [Action](./action.md)
- [Form](./form.md)
- [Domain](./domain.md)

# JSP

## 軽い目次

- [tablib 宣言](#tablib-宣言)
- [キャッシュの防止](#キャッシュの防止)
- [画面に値を出力](#画面に値を出力)
- [入力フォーム](#入力フォーム)
  - [フォームの作成](#フォームの作成)
  - [キーボード入力](#キーボード入力)
  - [DB から取ってきた値で選択](#dbから取ってきたリクエストスコープから取ってきた値で選択)
  - [コード値で選択](#コード値で選択)
  - [ボタン](#ボタン)
- [エラー表示](#エラー表示)
- [入力画面から確認画面を自動生成](#入力画面から確認画面を自動生成)

## tablib 宣言

```jsp
<%@ taglib prefix="n" uri="http://tis.co.jp/nablarch" %>
```

## キャッシュの防止

`<head>`内で記述する

```jsp
<n:noCache />
```

## スタイルシート設定

`<head>`内で記述する

```jsp
<n:link rel="stylesheet" href="/css/hogeStyle.css" />
```

`webapp`をルートとして、パスを通す

## 画面に値を出力

- リクエストスコープの値を出力する。

  ```jsp
  <n:write name="hogeForm.hoge" />
  ```

  - `name` : リクエストスコープから取ってくる名前

- コード値を出力する。

  ```jsp
  <n:code name="hogeForm.codeValue" codeId="HOGE_CODE" pattern="PATTERN_HOGE" />
  ```

  - `name` :コード値が入っている、リクエストスコープの値。`codeId`や`pattern`で特定したコードパターンにおける、コード値に対応する Value を表示する。
  - `codeId` :コード ID
  - `pattern` :許容される値のパターン

- メッセージを出力する。

  ```jsp
  <n:message messageId="hogeMssgId" />
  ```

  - `messageId` :メッセージ ID

## 入力フォーム

### フォームの作成

- form タグ

  ```jsp
  <n:form useToken="true">
  </n:form>
  ```

  `useToken=true`を指定すると、トークンを発行し楽観的ロックが可能となる。

### キーボード入力

- テキストボックス  
   `<n:form>`の中で記述する

  ```jsp
  <n:text name = "hogeForm.hoge" />
  ```

  - `name` : リクエストスコープ に渡す名前、html と同じ

- パスワード入力欄

  ```jsp
  <n:password name="hogeForm.password" />
  ```

  - `name` : リクエストスコープ に渡す名前、html と同じ

### DB から取ってきた（リクエストスコープから取ってきた）値で選択

- チェックボックス  
  `<n:form>`の中で記述する

  ```jsp
  <n:checkbox name="hogeForm.hogeName"
              label="hogeLabel"
              value="hogeValue"
              offValue="hogeValue2"
              offLabel="hogehoge"
  />
  ```

  - `name` : リクエストスコープ に渡す名前
  - `label` : ラベル
  - `value` : プログラム上で`label`にあたる処理値
  - `offValue` : チェックされてない時の`value`
  - `offLabel` : チェックされてない時の`label`

- プルダウン  
   `<n:form>`の中で記述する

  ```jsp
  <n:select name="hogeForm.hoge"
            listName="hogeList"
            elementLabelProperty="hogeLabel"
            elementValueProperty="hogeValue"
            elementLabelPattern="$LABEL$"
            withNoneOption="true"
            noneOptionLabel="hogehogeLabel"
  />
  ```

  - `name` : リクエストスコープ に渡す名前
  - `listName` : リクエストスコープ からとってくるリスト名
  - `elementLabelProperty` :リストに入っているオブジェクトのラベル名
  - `elementValueProperty` :リストに入っているオブジェクトのバリュー名
  - `elementLabelPattern` :プルダウンに表示する値、`$LABEL$`or`$VALUE$`
  - `withNoneOption` : 選択されてない時のデフォルト値を設定するか？ `true` or `false`
  - `noneOptioinLabel` : 選択されてない時の表示

- ラジオボタン  
   `<n:form>`の中で記述する

  ```jsp
   <n:radioButtons  name="hogeForm.hoge"
                    listName="hogeList"
                    elementLabelProperty="hogeLabel"
                    elementValueProperty="hogeValue"
                    elementLabelPattern="$LABEL$"
    />
  ```

  - `name` : リクエストスコープ に渡す名前
  - `listName` : リクエストスコープ からとってくるリスト名
  - `elementLabelProperty` :リストに入っているオブジェクトのラベル名
  - `elementValueProperty` :リストに入っているオブジェクトのバリュー名
  - `elementLabelPattern` :表示する値、`$LABEL$`or`$VALUE$`

### コード値で選択

- コードラジオボタン  
   `<n:form>`の中で記述する

  ```jsp
   <n:codeRadioButtons  name="hogeForm.hoge"
                        codeID="HOGE_CODE"
                        pattern="hogePattern"
                        labelPattern="hogeLabelPattern"
    />
  ```

  - `name` : リクエストスコープ に渡す名前
  - `codeId` :コード ID
  - `pattern` :許容される値のパターン
  - `labelPattern` : 表示する値。 デフォルトは`$NAME$`。その他にも`$VALUE$`や`$SHORTNAME`などがある。

- コードチェックボックス
  `<n:form>`の中で記述する

  ```jsp
  <n:codeCheckbox name="hogeForm.hoge"
                  codeId="HOGE_CODE"
                  labelPattern="hogeLabelPattern"
  />
  ```

  - `name` : リクエストスコープ に渡す名前
  - `codeId` :コード ID
  - `labelPattern` : 表示する値。 デフォルトは`$NAME$`。その他にも`$VALUE$`や`$SHORTNAME`などがある。

### ボタン

- ボタン
  `<n:form>`の中で記述する

```jsp
<n:submit type="submit" uri="hoge" value="ほげほげボタン" allowDoubleSubmission="false" />
```

`allowDoubleSubmission="false"`を追加すると、サーバサイドでの二重サブミット防止処理が可能となる。

## エラー表示

- 単項目・項目間精査エラー表示

  ```jsp
  <n:error name="hogeForm.hoge" />
  ```

- その他精査エラー表示
  ```jsp
  <n:errors filter="global" />
  ```

## 入力画面から確認画面を自動生成

- ページの生成

  ```jsp
  <n:confirmationPage path="./inputPage.jsp">
  ```

  `inputPage.jsp`から、自動的に確認画面を生成する。

- 入力ページのみに表示する

  ```jsp
  <n:forInputPage>
    入力ページにのみ表示する内容
  </n:forInputPage>
  ```

- 確認ページのみに表示する

  ```jsp
  <n:forConfirmationPage>
    確認ページ呑みに表示する内容
  </n:forConfirmationPage>
  ```
