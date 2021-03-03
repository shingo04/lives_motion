# README

## 🌐 App URL

### **http://18.181.126.31/

## 💬 Usage

`% git clone https://github.com/shingo04/lives_motion.git`

## アプリ名
# Lives Motion

## アプリ概要
ランニングや腹筋などのトレーニングを記録することのできるアプリです。
さらにツイート機能があり、トレーニングの方法や記録を共有することができます。

## 制作背景
運動のモチベーションを保つことが難しいひとや、トレーニングの記録をつけたい人が使うことを想定しています。
日々のトレーニングの記録をつけて、努力したことを数値で可視化したり、ツイート機能で繋がりを作ることでモチベーションを向上させていくことが目的です。

## 工夫したポイント
### **https://gyazo.com/5d9c9ef95cb47d54803ba9baac912fde
トレーニングをして時間を入力すると、その場で計算を表示するようにしました。

## 開発環境
Ruby / Ruby on Rails / MySQL / GitHub / AWS / Visual Studio Code /

## 今後実装したい機能
気になったユーザーのフォローすることができる機能を実装したいと思っています。

# テーブル設計

## usersテーブル

| columns      | type    | options     |
| ------------ | ------- | ----------- |
| email        | string  | null: false |
| password     | integer | null: false |
| nickname     | string  | null: false |
| age          | integer | null: false |
| height       | integer | null: false |
| weight       | integer | null: false |
| introduction | text    |             |

### Associations
- has_many :motions
- has_many :tweets
- has_many :comments

## motionsテーブル

| columns  | type       | options                        |
| -------- | ---------- | ------------------------------ |
| run      | integer    |                                |
| abs      | integer    |                                |
| squat    | integer    |                                |
| push_ups | integer    |                                |
| spine    | integer    |                                |
| total    | integer    | null: false                    |
| user     | references | null: false, foreign_key: true |

### Associations
- belongs_to :user

## tweetsテーブル

| columns | type       | options                        |
| ------- | ---------- | ------------------------------ |
| content | integer    | null: false                    |
| user    | references | null: false, foreign_key: true |


### Associations
- belongs_to :user
- has_many   :comments

## commentsテーブル

| columns | type       | options                        |
| ------- | ---------- | ------------------------------ |
| comment | string     | null: false                    |
| user    | references | null: false, foreign_key: true |
| tweet   | references | null: false, foreign_key: true |

### Associations
- belongs_to :user
- belongs_to :tweet
