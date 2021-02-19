# README
ポートフォリオ１作目です。
アプリ名：Divers log

このアプリケーションはスキューバダイビングのログブックとSNSの要素を組み合わせたものです。ダイビングをした後に残すログをオンライン化して、他人と共有することができます。

![2021-02-15 11 26 14](https://user-images.githubusercontent.com/68857615/107899146-da115c80-6f80-11eb-8c7c-1606c933d36e.png)

![2021-02-15 11 35 33](https://user-images.githubusercontent.com/68857615/107899605-10031080-6f82-11eb-80fd-5a98c58a21fa.png)

Railsチュートリアルで学んだ知識をおさらいしつつ新しい機能をつけました。

開発環境はvagrant
OSはubuntu18.04を使用しています

# 主な機能
・ユーザー登録・ログイン機能
・管理ユーザー機能
・ログ詳細表示機能
・ログ投稿機能
・ログ編集機能
・公開ログタイムライン機能
・Google map apiとgeocoder による地図表示機能
    ログの投稿時と詳細ページにて潜水地をgoogle mapで表示します
・画像ファイルのアップロード機能(carrierwaveを使用)
・ページネーション機能(kaminariを使用)
・ログの公開/非公開指定機能
・ゲストログイン機能

# 主な使用技術
ruby          2.6.3
rails         6.0.3
rspec-rails   4.0.1
bootstrap     4.5.2
puma          4.3.4
webpacker     4.0.7
bootsnap      1.4.5
kaminari      1.2.1
geocoder      1.6.4
carrierwave   2.1.0
sqlite3       1.4.1 (開発環境)

# テスト
RSpec
・modelスペック
・requestスペック
・systemスペック