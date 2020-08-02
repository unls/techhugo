---
title: "Raspberry piで検温機構を作るまで #2"
date: 2020-08-02T08:23:19+09:00
image: "images/team/default.png"
draft: true
weight: 100
description: "Lチカのソースコードを紐解いていきます"
---





1つ目の記事の続きになります。

https://www.tclb.cf/blog/raspberry_1/

## 今回の目的

- Lチカをやる
- ソースコードを紐解いて応用できるようにする
- 回路図を理解する
- ライブラリについても知る

こんなことをします

![](/images/raspberry/15.gif)



## GPIOピン

電源の供給をしたり制御信号を出したりできます。具体的なピンの配置は以下のとおりです。配置が覚えづらいのでどこかに画像をおいておいたほうが良いと思います。

![](/images/raspberry/9.png) [^1]

また、ラズパイのGPIOの状態は以下のコマンドで確認できます。

```bash
gpio readall
```

![](/images/raspberry/10.png)

実行すると以下のような表が出力されます。

- BCM: GPIOの番号
- wPi: Wiring PiというライブラリでのGPIOの番号
- Name: 端子名称
- Mode: In or Out（入力か出力か）
- V: 端子に掛かっている電圧
- Physical: 端子番号（上から1~40まで振られている）

また、このコマンドだと見やすく表示されます。

```bash
pinout
```

![](/images/raspberry/11.png)

## GPIOをPythonで制御する

制御するためのライブラリはいくつかありますが、一番有名な**Rpi.GPIO**というものを使います。

以下のサイトでは**pigpio**というライブラリを使用しています。pigpioというライブラリは難しい上級者向けですが、細かい調整が可能になっているので慣れてきたらこれに移行してみるのも良いかもしれません。

https://karaage.hatenadiary.jp/entry/2017/02/10/073000

rpi.GPIOはGitHubで管理されておらず、SOURCEFORGEというところに保存されているので探すのに少し手間が掛かります。

### 余談　回路図を作成する

この**fritzing**というソフトがとても使いやすいです。

aptで入れようとするとバグで全然動かないのでソースから入れましょう。

https://fritzing.org/

```bash
cd /usr/share/fritzing/
sudo git clone https://github.com/fritzing/fritzing-parts.git
sudo mv fritzing-parts/ parts
```



## Lチカ

初めて回路図を作ったので拙いですが…最もシンプルな回路です。

入力端子→LED→抵抗→終（？）

![](/images/raspberry/13.png)

![](/images/raspberry/12.png)

ただ接続しただけでLEDが点くこともありますが、点かないこともあります。Pythonで制御してみましょう。

![](/images/raspberry/13.jpg)

## Rpi.GPIOで制御してみる

早速コードを貼ります。

```python
import RPi.GPIO as GPIO
import time

# GPIOピンの場所
LED_PIN = 17
# 間隔
INTERVAL = 0.5


def setup():
    GPIO.setwarnings(False)
    # BCMの番号で指定することを宣言
    GPIO.setmode(GPIO.BCM)
    # 15pinを出力に設定
    GPIO.setup(LED_PIN, GPIO.OUT, initial=GPIO.LOW)


def main():
    while True:
        """
        HIGH(3.3V)
        LOW(0.0V)
        """
        GPIO.output(LED_PIN, GPIO.HIGH)
        time.sleep(INTERVAL)

        GPIO.output(LED_PIN, GPIO.LOW)
        time.sleep(INTERVAL)


# 終わり
def destroy():
    # LED消灯
    GPIO.output(LED_PIN, GPIO.LOW)
    # 後始末（忘れない）
    GPIO.cleanup()


if __name__ == '__main__':
    setup()
    try:
        main()
    except KeyboardInterrupt:
        destroy()

```

このコードはある一定時間ごとに点灯と消灯を繰り返すコードです。適宜コメントを記載したので読んでもらえたら大体理解できると思います。

実行してみると↓↓↓

![](/images/raspberry/15.gif)

main関数をいじることで光らせ方を変えることができますし、 LEDを増やすことも可能です。

例えば……

![](/images/raspberry/14.gif)

このように流れるような光らせ方もできます。右から三番目のが光っていないのは気にせず……





## 参考文献

https://jellyware.jp/kurage/raspi/led_chikachika.html

https://osoyoo.com/2017/06/23/python-light-led/

https://mamerium.com/raspberry-pi-rpi-gpio-basic/