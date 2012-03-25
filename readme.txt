Last.fmのAPIが何気に充実していたので何か作ってみたいと思ったのと、
iPhoneアプリの作り方を勉強したかったので、

（１）Last.fmのAPIを使ってアーティスト名を検索
（２）検索結果をテーブルビューに表示する
（３）テーブルビューのセルをタップするとLast.fmから取得したイベント一覧を表示する
（４）iOS5のTwitter APIを使ってTwitterに投稿する

という簡単なデモアプリを作ってみました。
XCodeのテンプレート「Master-Detail Application」をベースに作ってます。

■動作確認環境
・iPhone4（iOS5.01）
※iOS5以上でないとビルドできません。

■その他
JSONのパースには、SBJsonというライブラリを使用しました。
直感的に使えて分かりやすくて便利です。
https://github.com/stig/json-framework/
