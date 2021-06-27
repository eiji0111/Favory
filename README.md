![favory_logo01](https://user-images.githubusercontent.com/78339908/123537890-d8e10f00-d76c-11eb-99cb-f5c1d64d2658.jpg)

# 🌸 Favory ファボリー 自衛官×マッチングアプリ

「**Favoryファボリー**」とは、  
お気に入り（**favorite**） と ミリタリー（**military**）  
とを組み合わせた造語です。  

「**Favory**」を使えば、全国の素敵な現役自衛官と繋がり、出会うことができます。  
コロナ禍で出会いが少ない今だからこそ、本気であなたの理想の人を見つけてみませんか？

※基本的には男女、現役自衛官問わず、誰でも登録できるようになっていますが  
サイト内で自衛官認証制度を設けています。

### 🌸 サイトテーマ
現役自衛官と出会えるマッチングアプリ

### 🌸 テーマを選んだ理由
元自衛官として勤務していた際、自衛隊は男性勤務者の割合が多く、  
独身自衛官は自衛隊内の寮で生活することを義務付けられているため、  
自衛官は出会いの場が極端に少ないと感じていました。  
また、現在のコロナ禍で、男女が交流を深める機会もより一層少なくなってきていることを踏まえ、  
インターネットを使って簡単に、理想の人と出会えるアプリケーションがあれば便利だと考え制作に至りました。

### 🌸 ターゲットユーザ
- 現役自衛官（男性自衛官・女性）  
- 自衛官と出会いたい女性  
- 自衛官に興味のある方
- 20代、30代中心

### 🌸 主な利用シーン
- そろそろ良い人を見つけて結婚したい。  
- 結婚願望はあるが、出会いがない。  
- 安定した職についている人と出会いたい。  

いつでもどこでもスマホひとつで理想の相手を見つけることができます  

## ✏️ 設計書

### ✏️ データベース設計
[ER図](https://app.diagrams.net/#G17lrPNh_ySsC62XzYZTGhL7RXcrM7htlh)

[テーブル定義書](https://docs.google.com/spreadsheets/d/1GrihIfWc5oyqZkKEze6m6W_cvzH2DAX1/edit#gid=1739957604)

### ✏️ 詳細設計
[アプリケーション詳細設計書](https://docs.google.com/spreadsheets/d/1P9pCN-uQozIHk6WfIcSBDYDVEJx3eQmFeilxlpnXswQ/edit#gid=0)

## 使用技術
- Ruby 2.6.3
- Ruby on Rails 5.2.6
- MySQL 5.7.22
- Nginx
- Puma
- AWS
  - VPC
  - EC2
  - RDS
  - Route53

## アプリ機能
- deviseを用いたユーザー認証機能(会員・管理者)
- 検索・ソート機能(Ransack)
- フォロー機能(ajax)
- コメント機能(ajax)
- DM機能
- 通知機能
- お問い合わせ機能
  - メール送信(Action Mailer)
- 無限スクロール(jscroll)
- 画像アップロード機能(refile)
- 画像整列(Masonry)

## ⚙ 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
