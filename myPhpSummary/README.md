# PHP まとめ

## 目次
- [PHPの記述場所](#php-の記述場所)
- [基本](#基本)
- [POST・GETの受け取り](#post・get-の受け取り)
- [クラス](#クラス)
- [インポート](#インポート)

## PHP の記述場所

HTML 中に、`<?php  ?>`ではさんで記述

```php
<h1>
    私の名前は<?php echo "slime830" ?>です。
</h1>
```

## 基本

- 変数宣言
```php
$variable = 1;
```
`$変数名`で宣言

- 配列
```php
$languages = array("PHP","Python","JavaScript");
```

- 連想配列
```php
$user = array(
    "id"      => "001",
    "name"    => "slime830"
);
echo $user["id"]; // "001"
```

Python でいうdict ですね


- 条件分岐
```php
if(statement1){ // 条件1 
    // 処理1
}elseif(statement2){ // 条件2
    // 処理2
}else{
    // 処理3
}
```

- 繰り返し
```php
for($i = 1 ; $i <= 100; $i++){
    // 100回行う処理
}
$j = 0;
while($j <= 100){
    // 100回行う処理
    $j++;
}
```

- 要素の繰り返し
```php
$items = array("item1","item2","item3"); // 普通の配列
foreach($items as $item){
    echo $item;
}

$userInfos = array(
    "id"      => "001",
    "name"    => "slime830"
); // 連想配列
foreach($userInfos as $key => $value){
    echo $key;   // "id" や "name"が入る
    echo $value; // "001" や "slime830"が入る
}
```

- HTML要素の繰り返し・条件による表示
```php
<?php if($name == "slime830"):?>
    <p>私の名前はslime830です<\p>
<?php endif ?>
```
同様に、`for`や`while`なども、`endfor` `enfwhile` で囲むことでできる。

- 文字列の連結
```php
$str1 = "hoge";
$str2 = "fuga";
echo str1.str2; // "hogefuga"
```

- 関数宣言
```php
function fn(){
    return 1;
}
```

## POST・GET の受け取り

- フォームのデータの受け取り

```php
$_POST[name]
```
`name` は、HTMLのname属性

- クエリ情報の受け取り
```php
$_GET[name]
```
`name` は、クエリのキー

## クラス

- クラス宣言
めんどくさいので、いっぺんに

```php
Class Hoge{
    private $hogeValue; // private はアクセス修飾子。publicやprotected もある
    private static $hogeStaticValue = 0; // クラスプロパティ;

    public function __construct($hogeValue){    // コンストラクタは __construct()で作る
        $this->hogeValue = $hogeValue;          // $インスタンス->変数で、そのインスタンスの変数を参照
                                                // $this->変数　で自インスタンスが持つプロパティにアクセス
    }

    public function hogeFunction(){
        echo self::$hogeStaticValue; // クラスプロパティを参照するときは、self::プロパティ名
        return 0;
    }
}
```

- 子クラスの宣言
```php
Class Fuga extends Hoge{
    private $fugaValue;

    public function __construct(){ // コンストラクタのオーバライド
        parent::__construct(1);    // parent:: で親クラスのコンストラクタ等を参照
        $fugaValue = 1;
    }
}
```

## インポート

- インポート
```php
require_once("./hoge.php");
```