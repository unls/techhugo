---
title: "ブログページを作る"
date: 2020-08-01
image: "img/thumbnail/crblog.jpg"
draft: true
weight: 100
author: "wamo"
---

技術科部のサイトはHugoというサイトジェネレータで作られています。

Hugoで使用しているテーマは[Hugo Serif](https://github.com/jugglerx/hugo-serif-theme)というものです。

このテーマ、本来だったらブログのページはないのですが、どうしても欲しかったので強引に付けました。

なおこの記事はHTML/CSSがわからないとちょっとわかりづらいかも。

## 解説

まずはテーマフォルダのレイアウト内teamフォルダをblogに改名。

![](/img/crblog/1.png)

その後list.htmlとsummary.htmlを見た目を確認しつつ変更してきます。
このテーマはBootstrapの一部のクラスが使えるようになっているので、それらを使いつつ大きさを調整していい感じにしました。  
Descriptionは面倒だったのでmarkdown側に入れました。

![](/img/crblog/2.png)

もちろんHTMLだけを反映させるだけでは特になんともならないので、次にCSSをいじります。  
テーマフォルダのasssets/scss/pages/の中のteamフォルダをblogに改名します。  
中身の_team-summary.scssを_blog-summary.scssに改名するのを忘れずに。  

![](/img/crblog/3.png)

あとは適当にいじくっていきます。  
single側を変える必要がほぼないので、listを変更するようのCSSを書いていきます。  
実際のCSSは[ここ](https://github.com/unls/techhugo/blob/master/themes/hugo-serif-theme/assets/scss/pages/blog/_blog-summary.scss)にあるので、よかったら参考にしてみてください。

## OGP

せっかくブログがあるのだから、OGPを設定しよう。  
ということで、OGPとTwitterカードを設定します。  

[https://amezou.com/posts/2020/03/10/twitter-card/](https://amezou.com/posts/2020/03/10/twitter-card/)

コードは上のサイトのを借りました。
本当だったら新しくpartialsにhtmlファイルを作り、そこからインポートした方が早かったのですが、そこまで考えてませんでした。

## 最後に

このサイトは元のテーマから大分変更したので、どこが違うかを探してみてください。

元のテーマのデモサイト：
[https://themes.gohugo.io/theme/hugo-serif-theme/](https://themes.gohugo.io/theme/hugo-serif-theme/)





