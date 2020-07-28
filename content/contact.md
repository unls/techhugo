---
title: 'お問い合わせ'
date: 2018-02-22T17:01:34+07:00
layout: contact
menu: 'main'
---

お問い合わせの際は、以下のフォームに記入してください。

<form name="contact" method="post" netlify>
    <div class="cp_iptxt">
        <input type="text" placeholder="お名前" name="name" required>
    </div>
    <div class="cp_iptxt">
        <input type="text" placeholder="メールアドレス" name="mail" required>
    </div>
    <div class="cp_iptxt">
        <input type="text" placeholder="題名" name="title" required>
    </div>
    <div class="cp_iptxt">
        <textarea rows="5" cols="30" placeholder="メッセージ" name="message" required></textarea>
    </div>
    <input type="submit" value="送信" class="button">
</form>