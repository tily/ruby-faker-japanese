Faker-Japanese
==============

概要
----

日本語ユーザに関する偽の情報をランダムに生成するためのライブラリ

使い方
------

### 名前の生成

 * フルネーム

        20.times do
          name = Faker::Japanese::Name.name
          puts "#{name} (#{name.yomi})"
        end

 * 苗字と名前

        20.times do
          first_name = Faker::Japanese::Name.first_name
          last_name = Faker::Japanese::Name.last_name
          puts "姓：#{last_name}\t名：#{first_name}"
        end

### 住所の生成

(まだ実装されていません。)

要件
----

 * faker
 * naist-jdic-utf8 (ソースからインストールする場合のみ)


インストール
------------

### gem からインストール

        gem install faker-japanese

### ソースからインストール

        rake generate
        rake install

問題
----

 * 典型的ではない氏名がたまに生成される (「マッカーサー」「茶魔」等)
 * 本家 Faker に比べてデータの量が多すぎる

ライセンス
----------

### naist-jdic-utf8 のライセンス

LISENCE.naist-jdic-utf8 に明記してあります。
何か問題があれば tily05@gmail.com までご連絡ください。

### このライブラリのライセンス

ライセンスのことよくがよく分かっていないのであとで書きます。

