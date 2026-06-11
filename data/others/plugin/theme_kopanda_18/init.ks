;--------------------------------------------------------------------------------
; ティラノスクリプト テーマプラグイン theme_kopanda_18
; 作者:こ・ぱんだ
; https://kopacurve.blog.fc2.com/
;--------------------------------------------------------------------------------

[iscript]

mp.font_color    = mp.font_color    || "0xCCCCCC";
mp.name_color    = mp.name_color    || "0xEEEEEE";
mp.frame_opacity = mp.frame_opacity || "255";
mp.font_color2   = mp.font_color2   || "0xCCCCCC";
mp.glyph         = mp.glyph         || "off";

if(TG.config.alreadyReadTextColor != "default") {
	TG.config.alreadyReadTextColor = mp.font_color2;
}

[endscript]

; 名前部分のメッセージレイヤ削除
[free name="chara_name_area" layer="message0"]

; メッセージウィンドウの設定
[position layer="message0" width="1280" height="240" top="482" left="0"]
[position layer="message0" frame="../others/plugin/theme_kopanda_18/image/frame_message.png" margint="80" marginl="160" marginr="140" opacity="&mp.frame_opacity" page="fore"]

; 名前枠の設定
[ptext name="chara_name_area" layer="message0" color="&mp.name_color" shadow="0x911d22" size="26" x="160" y="515" width="400"]
[chara_config ptext="chara_name_area"]

; デフォルトのフォントカラー指定
[font color="&mp.font_color"]
[deffont color="&mp.font_color"]

; クリック待ちグリフの設定（on設定時のみ有効）
[if exp="mp.glyph == 'on'"]
[glyph line="../../../data/others/plugin/theme_kopanda_18/image/system/nextpage.png"]
[endif]

;=================================================================================

; 機能ボタンを表示するマクロ

;=================================================================================

; 機能ボタンを表示したいシーンで[add_theme_button]と記述してください（消去は[clearfix]タグ）
[macro name="add_theme_button"]

; 歯車ボタン（メニューボタン）非表示
[hidemenubutton]

; クイックセーブ
[button name="role_button" role="quicksave" graphic="../others/plugin/theme_kopanda_18/image/button/qsave.png" enterimg="../others/plugin/theme_kopanda_18/image/button/qsave2.png" x="652" y="685"]

; クイックロード
[button name="role_button" role="quickload" graphic="../others/plugin/theme_kopanda_18/image/button/qload.png" enterimg="../others/plugin/theme_kopanda_18/image/button/qload2.png" x="744" y="685"]

; オート
[button name="role_button" role="auto" graphic="../others/plugin/theme_kopanda_18/image/button/auto.png" enterimg="../others/plugin/theme_kopanda_18/image/button/auto2.png" x="840" y="685"]

; スキップ
[button name="role_button" role="skip" graphic="../others/plugin/theme_kopanda_18/image/button/skip.png" enterimg="../others/plugin/theme_kopanda_18/image/button/skip2.png" x="916" y="685"]

; バックログ
[button name="role_button" role="backlog" graphic="../others/plugin/theme_kopanda_18/image/button/log.png" enterimg="../others/plugin/theme_kopanda_18/image/button/log2.png" x="992" y="685"]

; スクリーン
[button name="role_button" role="fullscreen" graphic="../others/plugin/theme_kopanda_18/image/button/screen.png" enterimg="../others/plugin/theme_kopanda_18/image/button/screen2.png" x="1088" y="685"]

; 非表示
[button name="role_button" role="window" graphic="../others/plugin/theme_kopanda_18/image/button/close.png" enterimg="../others/plugin/theme_kopanda_18/image/button/close2.png" x="1176" y="685"]

; メニュー
[button name="role_button" role="menu" graphic="../others/plugin/theme_kopanda_18/image/button/menu.png" enterimg="../others/plugin/theme_kopanda_18/image/button/menu2.png" x="1168" y="32"]


[endmacro]


;=================================================================================

; システムで利用するHTML,CSSの設定

;=================================================================================
; セーブ画面
[sysview type="save" storage="./data/others/plugin/theme_kopanda_18/html/save.html"]

; ロード画面
[sysview type="load" storage="./data/others/plugin/theme_kopanda_18/html/load.html"]

; バックログ画面
[sysview type="backlog" storage="./data/others/plugin/theme_kopanda_18/html/backlog.html"]

; メニュー画面
[sysview type="menu" storage="./data/others/plugin/theme_kopanda_18/html/menu.html"]

; CSS
[loadcss file="./data/others/plugin/theme_kopanda_18/ts18.css"]

; メニュー画面からコンフィグを呼び出すための設定ファイル
[loadjs storage="plugin/theme_kopanda_18/setting.js"]

;=================================================================================

; テストメッセージ出力プラグインの読み込み

;=================================================================================
[loadjs storage="plugin/theme_kopanda_18/testMessagePlus/gMessageTester.js"]
[loadcss file="./data/others/plugin/theme_kopanda_18/testMessagePlus/style.css"]

[macro name="test_message_start"]
[eval exp="gMessageTester.create()"]
[endmacro]

[macro name="test_message_end"]
[eval exp="gMessageTester.destroy()"]
[endmacro]

[macro name="test_message_reset"]
[eval exp="gMessageTester.currentTextNumber=0;gMessageTester.next(true)"]
[endmacro]


[return]
