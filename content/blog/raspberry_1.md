---
title: "Raspberry piで検温機構を作るまで #1"
date: 2020-08-01T17:19:39+09:00
image: "img/thumbnail/rasp1.png"
draft: false
weight: 100
description: "Raspberry piの概要と開発環境の作り方を紹介します"
---





この記事では、技術科部がRaspberry piを用いて電子工作等の練習をしている様子をお伝えしながら技術の紹介を行っていこうと思います。

この記事はRaspberry piの事始めから開発環境のセットアップを中心にかかれています。

## 技術科部の目標

検温ができるような仕組みを整えたいと考えております。具体的には人が集まるようなところの入り口に設置して接触せずに検温が手軽にできるような技術を開発をしようとしています。

## Raspberry piとは

とても小さなコンピュータです。巷では略して「ラズパイ」と呼ばれています。

一つ6000円程度で数年前まであった一般の学校のパソコンの性能があるすぐれものです。

技術科部ではRaspberry pi 3 model B+を使用しています。手のひらサイズです。

![](/img/raspberry/6.jpg)

### できること

- スマートスピーカー
- ロボット
- サーバー

etc.

普通のパソコンとは違って電子部品を組み込むことができます。これがラズパイの大きな特徴です。

## 実際に動かしてみる

まず最初から動かすときにはこのような記事を読むことをオススメします。

https://qiita.com/Higemal/items/c817b96c3806f23b35f6

### Raspberry piについて確認する

![](/img/raspberry/7.png)

上から

1. カーネル情報
2. OS情報
3. CPU温度
4. CPU動作電圧
5. CPU情報

5つ目の実行からわかるようにこのモデルは4コアあります。

### 任意のパソコンからラズパイにアクセスする

SSHという技術を使います。簡単に説明すると離れたところから安全に端末をネット経由で接続＆操作するための手段です。似たものにリモートデスクトップがありますが、それよりも通信量が少なく、ラグも小さくなるので使いようによってはより便利になることがあります。

具体的にSSH接続をすることで以下のような恩恵が受けられます。

- ラズパイ自体、電源供給だけのケーブルで動くようになる
- 電力供給が足りているかの心配が減る（特にモニタをラズパイから給電していると）
- 開発が楽

必要な手順は以下のとおりです。

1. 固定IPアドレスの設定
2. SSH接続の許可
3. 接続



接続するホスト側はUbuntu 18.04 LTSです。windowsだと必要な手順が違うことがあります。

### 固定IPアドレスの設定

設定ファイルにアドレスを追記します。

```bash
vim /etc/dhcpcd.conf
```

無線の場合はwlan0、有線の場合はeth0を使います。xの部分は自由に決めてください。

一般的なものだと https://blog.ko31.com/201803/raspi-ssh-setup/ この記事にある 192.168.1.1と192.168.1.10を使うそうです。

```bash
interface wlan0
static ip_address=192.xxx.x.xx/24
static routers=192.xxx.x.x
static domain_name_servers=192.xxx.x.x
```

### SSH接続の許可

raspberry piの設定からやる方法もあります。許可したら再起動しましょう。

```bash
sudo systemctl enable ssh
sudo systemctl start ssh
```



### 接続

これだけで接続できます。基本的にraspberry piはユーザー名はpiでIPアドレスは上に設定した ip_adress= のところを打ちます。

初回だとyesかnoかで問われたり、パスワードの入力が必要だったりしますが必要な作業をすると

```bash
ssh pi@192.xxx.x.xx
```



接続例

```bash
(base) ubuntu@ubuntu-desktop:~$ ssh pi@192.168.1.10
pi@192.168.1.10's password: 
Linux raspberrypi 4.19.118-v7+ #1311 SMP Mon Apr 27 14:21:24 BST 2020 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Sat Aug  1 14:56:36 2020
pi@raspberrypi:~ $
```



### 余談　PyCharmからラズパイにSSH接続して開発する

できるととても便利になります。

必要なもの

- PyCharm Pro
- Raspberry pi
- 気力

#### PyCharmでSSHインタプリタを設定する

File/Settingsで環境設定に入る

![](/img/raspberry/1.png)

Project: hogehoge/Python Interpreterに入る

![](/img/raspberry/2.png)

ユーザーネームとipアドレスを入れる

![](/img/raspberry/3.png)

パスワードを入れる

![](/img/raspberry/4.png)

接続先（raspberry pi）のpythonのインタプリタと接続先の作業ディレクトリを設定する。

![](/img/raspberry/5.png)

という手順を踏めば簡単にできます。

#### コードを書いてデプロイする

Tools/Deployment/Upload to pi&#64;192.xxx.x.xx

を押しましょう。逆にダウンロードも可能です。

接続先のディレクトリにファイルを送信して同期させます。これをせずに実行をするとファイルが無いとエラーを吐かれます。

#### 実行する

普通に実行ボタンを押すとリモート先で実行した結果がコンソールに表示されます。

下はちょうど今実行していたプログラムの様子です。右側にuploadのログ、左側には実行時のログが残されています。上の方にsshと書いてあるように接続先のファイルが接続先の環境で実行されていることがわかります。（つまり実機はただコードを書いて実行を要求するだけ）

![](/img/raspberry/8.png)

### 仮想環境は作るべきか

一般的には後々後悔しないために作ることが勧められています。ただ、ラズパイという小さな機構なので重くなるようであればそのままやるのもありだと思います。（何度でもOSは吹っ飛ばせるので）

venvとcondaが有名です。筆者は実機でanacondaを使用しているのでcondaの導入を考えています。今は動作テストなので仮想環境は作っておりませんが、そろそろ仮想環境を使って開発環境を整える予定です。

最近は [Berry Conda](https://github.com/jjhelmus/berryconda) が有名になってきました。Berry CondaはRaspberry pi用に作られたcondaディストリビューションらしいです。

## おわりに

今回の記事はSSH接続がメインになってしまいましたが、次回からは実際に手を動かして電子工作をやっていきます。



## 参考文献

https://blog.ko31.com/201803/raspi-ssh-setup/

https://pleiades.io/help/pycharm/configuring-remote-interpreters-via-ssh.html

https://www.bnote.net/raspberry_pi/info_cmd.html

