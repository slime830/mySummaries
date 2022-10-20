- [JSP](./jsp.md)
- [Action](./action.md)
- [Form](./form.md)

# ドメイン定義

## 軽い目次

[定義方法概要](#定義方法概要)
[各アノテーション](#各アノテーション)

## 定義方法概要

```java
@SystemChar(charsetDef = "半角数字")
@Digits(fraction = 0,integer = 12)
private String id
```

これで`id`というドメインができる。

アノテーションで、制約を追加していく

## 各アノテーション

- `@SystemChar`

  ```java
  @SystemChar(charsetDef = "指定する文字種名")
  ```

  charsetDef で指定した文字種であることを精査する

  charsetDef の名前を、どっからとってきてるのかは、現状わかってない

- `@Digits`

  ```java
  @Digits(integer = 3,fraction=4)
  ```

  数字であることを精査する。

  上記の例では、整数部が 3 桁、小数部が 4 桁の数を表す。デフォルトでは fraction = 0

- `@Length`

  ```java
  @Length(min = 3 , max = 10)
  ```

  3~10 の文字列
