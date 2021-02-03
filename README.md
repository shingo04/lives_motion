# README

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
| bmr          | integer | null: false |
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
| spine    | references | null: false, foreign_key: true |

### Associations
- belongs_to :user

## tweetsテーブル

| columns | type       | options                        |
| ------- | ---------- | ------------------------------ |
| title   | string     | null: false                    |
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
