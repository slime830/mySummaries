- [JSP カスタムタグ](./jsp.md)
- [Action](./action.md)
- [Domain](./domain.md)

# Nablarch Form 記述

## 軽い目次

- [単項目精査](#単項目精査)
- [項目間精査](#項目間精査)

## 単項目精査

- 必須入力チェック

```java
@Required
private String hoge;
```

- ドメイン指定

```java
@Domain("name")
private String hogeName;
```

## 項目間精査

```java
@AssertTrue(message = "errorMessage")
public boolean isOK(){
    return true;
}
```

`AssertFalse`でもよい。その際は`true`が return されるとエラー
