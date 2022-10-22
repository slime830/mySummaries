# Node.js (Express) まとめ

## 目次
- [各種インストール](#各種インストール)
- [ウェブアプリのフォルダ構造](#ウェブアプリのフォルダ構造)
- [CSSの適用](#cssの適用)
- [サーバの起動](#サーバの起動)
- [ルーティング](#ルーティング)
- [画面遷移](#画面遷移)
- [EJSの記述方法](#ejsの記述方法)
- [EJSのフォームの値を受け取り](#ejsのフォームの値を受け取り)
- [SQLによるデータベースの利用](#sqlによるデータベース利用mysql)

## 各種インストール
Ubuntu(WSL)でのインストール方法です。

[nodejs_install.sh](./nodejs_install.sh)に纏めときました。

- Node.js のインストール
```bash
sudo apt update
sudo apt install nodejs
```
`sudo`は環境によってはいらないかもしれません？

- npm のインストール
```bash
sudo apt install npm
```

- express のインストール
```bash
npm install express
```

- ejs のインストール
```bash
npm install ejs
```

- mysql のインストール
```bash
npm install mysql
```

## ウェブアプリのフォルダ構造
```
app
├── app.js
├── public
│   └── style.css
└── views
    └── hoge.ejs
```
- `app`は任意のアプリ名
- `app`直下に沢山の`js`ファイルを配置
- `public`には、CSSや画像を配置
- `views`には、`ejs`（後述、HTML的な）を配置

## CSSの適用
1. `public`のインポート
```javascript
app.use(express.static("public"));
```

2. EJSでCSSのインポート
```html
<link rel="stylesheet" href="/style.css">
```
`public`直下をルートとしてパスを書く

## サーバの起動
```js
const express = require("express");
const app = express();
// 中略
app.listen(portNum);
```

`portNum`はサーバを起動するポート番号

## ルーティング
- GET
```javascript
app.get("/hoge",(req, res)=>{
    //　ほげほげ
});
```
`/hoge`にアクセスされたときに、行う処理を書ける

`req`はリクエスト、`res`はレスポンスを表す。詳しくは後述

- POST
```javascript
app.post("/hoge",(req, res)=>{
    // ほげほげ
})
```

## 画面遷移

- 指定したEJSを画面に表示させる  
```javascript
res.render("hoge.ejs");
```
中に書くのは、ファイル名

- EJSに値を渡して表示する。
```javascript
res.render("hoge.ejs",{key: value})
```
- リダイレクト
```javascript
res.redirect("/hoge");
```
中に書くのは、パス名

## EJSの記述方法
EJS とは、文中にJavaScriptを組みこめるHTML

例
```html
<body>
    <% const author = "slime830" %>
    <p>
        私の名前は<%=author %>です。
    </p>
</body>
```

`<% %>`の間は普通にJSが書ける。

`<%= %>`の間の出力を、HTMLにして出力する。

## EJSのフォームの値を受け取り
```javascript
    // フォームの値を受け取る為の定型文
    app.use(express.urlencoded({extended:false}));

    // 中略

    app.post("/hoge",(req, res)=>{
        console.log(req.body.value); // req.body.名前で参照
    });
```

## SQLによるデータベース利用（MySQL）
- `SELECT`
```javascript
const mysql = require("mysql"); 
const connection = mysql.createConnection({
    host : "hogehost",
    user : "slime830",
    password : "password"
});
// 中略

connection.query(
    "SELECT * from users",// 実行するクエリ
    (error,results) => {  // 実行後の処理
        // resultsにクエリの実行結果が入る
        console.log(results); 
    }
);
```
- `UPDATE`や`INSERT`など
```javascript
// 中略

connection.query(
    "INSERT INTO users(name,gender) VALUES = (?,?)",
    [name,gender],// ? に入れる値を左から順に配列で
    (error,results)=>{
        //クエリ実行後の処理
    }
);
```