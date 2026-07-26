[_tb_system_call storage=system/_omake.ks]

*omake_top

[cm  ]
[bg  time="500"  method="fadeIn"  storage="credits.png"  ]
[mask_off  time="1000"  effect="fadeOut"  ]
[glink  color="btn_05_red"  storage="omake.ks"  size="20"  text="おまけストーリー"  target="*story"  x="100"  y="100"  width=""  height=""  _clickable_img=""  autopos="true"  ]
[glink  color="btn_05_purple"  storage="omake.ks"  size="20"  target="*QA"  text="よくありそうなQ＆A"  x="100"  y="100"  width=""  height=""  _clickable_img=""  autopos="true"  ]
[glink  color="btn_05_lime"  storage="omake.ks"  size="20"  autopos="true"  text="クレジット"  x="100"  y="100"  width=""  height=""  _clickable_img=""  target="*credit"  ]
[glink  color="btn_05_white"  storage="title_screen.ks"  size="20"  text="タイトルに戻る"  autopos="true"  target=""  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[s  ]
*credit

[bg  time="1000"  method="fadeIn"  storage="BG_credits_260524.png"  ]
[glink  color="btn_01_purple"  storage="omake.ks"  size="20"  text="おまけ画面に戻る"  target="*omake_top"  x="1020"  y="542"  width=""  height=""  _clickable_img=""  ]
[s  ]
*QA

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#システム
Q.うるさいの条件は何？何か悪いこと起こってる？[p]
A.プレイヤーによるコマンド率が50％を越えると"うるさい"されます。2日目以降は時期を問わず2回まで発言可能です。うるさいされるとプレイヤーの平常心が下がります。[p]
Q.強く疑うで突っ込まれないためには？[p]
A.一番目の選択肢は突っ込まれません。二番目は嘘つきが確定していない状態で使うと突っ込まれます。三番目は人狼を見つけていないと突っ込まれます、正直占い師じゃないと使いどころないです。[p]
Q.占い報告って後出し側が調整してる？先にCOした占い師が信頼できる？[p]
A.そういった仕様は一切実装されていません。COの順番は推理に殆ど意味ない要素とお考えください。[p]
Q.占い師2人の黒出しが被ったら人狼確定では？突っ込みされたんだけど？[p]
A.一部のキャラは真占い師でも潜伏する場合があります。つまり占い師二人が黒出ししてもそれは人狼＆狂人の場合があるので人狼確定判定にはなりません。[p]
Q.〇〇な挙動は人狼の定石ではない。人狼としておかしいところがある。[p]
A.Githubの公開リポジトリなので是非フォークしてください。プルリクエスト待ってます！[p]
Q.バグを見つけた。[p]
A.メニューよりタイトルに戻るで緊急回避してください。出来れば報告してくれるとウレシイ…[p]
Q.コラボとか募集してる？ゲーム制作に興味ある。[p]
A.してます！詳しくはらきのXのプロフにあるリトリンから！ゲ制経験不問ですが同人誌等の締切を守った実績が必須です。[p]
Q.これ作ったヤツ、正気？[p]
A.正気な訳ありません。ゲームが面白かったら、正気に戻さないようにプレイ報告して欲しいです！配信はわかりやすいところに非公式ってかいたらOKです。[p]
[_tb_end_text]

[tb_hide_message_window  ]
[jump  storage="omake.ks"  target="*omake_top"  ]
*story

[bg  time="1000"  method="crossfade"  storage="omake_story.png"  ]
[jump  storage="omake.ks"  target="*ma_s01"  cond="sf.ma_s01!=1"  ]
[glink  color="rosy"  storage="omake_story.ks"  size="20"  text="ストーリー01"  target="*s01"  x="55"  y="415"  width=""  height=""  _clickable_img=""  ]
*ma_s01

[jump  storage="omake.ks"  target="*ma_s02"  cond="sf.ma_s02!=1"  ]
[glink  color="rosy"  storage="omake_story.ks"  size="20"  text="ストーリー02"  target="*s02"  x="55"  y="480"  width=""  height=""  _clickable_img=""  ]
*ma_s02

[jump  storage="omake.ks"  target="*ma_s03"  cond="sf.ma_s03!=1"  ]
[glink  color="rosy"  storage="omake_story.ks"  size="20"  text="ストーリー03"  target="*s03"  x="55"  y="550"  width=""  height=""  _clickable_img=""  ]
*ma_s03

[jump  storage="omake.ks"  target="*si_s01"  cond="sf.si_s01!=1"  ]
[glink  color="orange"  storage="omake_story.ks"  size="20"  text="ストーリー04"  target="*s04"  x="295"  y="415"  width=""  height=""  _clickable_img=""  ]
*si_s01

[jump  storage="omake.ks"  target="*si_s02"  cond="sf.si_s02!=1"  ]
[glink  color="orange"  storage="omake_story.ks"  size="20"  text="ストーリー05"  target="*s05"  x="295"  y="480"  width=""  height=""  _clickable_img=""  ]
*si_s02

[jump  storage="omake.ks"  target="*si_s03"  cond="sf.si_s03!=1"  ]
[glink  color="orange"  storage="omake_story.ks"  size="20"  text="ストーリー06"  target="*s06"  x="295"  y="550"  width=""  height=""  _clickable_img=""  ]
*si_s03

[jump  storage="omake.ks"  target="*mu_s01"  cond="sf.mu_s01!=1"  ]
[glink  color="blue"  storage="omake_story.ks"  size="20"  text="ストーリー07"  target="*s07"  x="540"  y="415"  width=""  height=""  _clickable_img=""  ]
*mu_s01

[jump  storage="omake.ks"  target="*mu_s02"  cond="sf.mu_s02!=1"  ]
[glink  color="blue"  storage="omake_story.ks"  size="20"  text="ストーリー08"  target="*s08"  x="540"  y="480"  width=""  height=""  _clickable_img=""  ]
*mu_s02

[jump  storage="omake.ks"  target="*mu_s03"  cond="sf.mu_s03!=1"  ]
[glink  color="blue"  storage="omake_story.ks"  size="20"  text="ストーリー09"  target="*s09"  x="540"  y="550"  width=""  height=""  _clickable_img=""  ]
*mu_s03

[jump  storage="omake.ks"  target="*ka_s01"  cond="sf.ka_s01!=1"  ]
[glink  color="red"  storage="omake_story.ks"  size="20"  text="ストーリー10"  target="*s10"  x="785"  y="416"  width=""  height=""  _clickable_img=""  ]
*ka_s01

[jump  storage="omake.ks"  target="*ka_s02"  cond="sf.ka_s02!=1"  ]
[glink  color="red"  storage="omake_story.ks"  size="20"  text="ストーリー11"  target="*s11"  x="785"  y="480"  width=""  height=""  _clickable_img=""  ]
*ka_s02

[jump  storage="omake.ks"  target="*ka_s03"  cond="sf.ka_s03!=1"  ]
[glink  color="red"  storage="omake_story.ks"  size="20"  text="ストーリー12"  target="*s12"  x="785"  y="550"  width=""  height=""  _clickable_img=""  ]
*ka_s03

[jump  storage="omake.ks"  target="*te_s01"  cond="sf.te_s01!=1"  ]
[glink  color="gray"  storage="omake_story.ks"  size="20"  text="ストーリー13"  target="*s13"  x="1030"  y="416"  width=""  height=""  _clickable_img=""  ]
*te_s01

[jump  storage="omake.ks"  target="*te_s02"  cond="sf.te_s02!=1"  ]
[glink  color="gray"  storage="omake_story.ks"  size="20"  text="ストーリー14"  target="*s14"  x="1030"  y="480"  width=""  height=""  _clickable_img=""  ]
*te_s02

[jump  storage="omake.ks"  target="*te_s03"  cond="sf.te_s03!=1"  ]
[glink  color="gray"  storage="omake_story.ks"  size="20"  text="ストーリー15"  target="*s15"  x="1030"  y="550"  width=""  height=""  _clickable_img=""  ]
*te_s03

[glink  color="btn_01_red"  storage="omake.ks"  size="20"  text="おまけに戻る"  target="*omake_top"  x="1105"  y="30"  width=""  height=""  _clickable_img=""  ]
[s  ]
*story_start

[bg  time="1000"  method="crossfade"  storage="93853245_p0.png"  ]
[tb_show_message_window  ]
[return  ]
*story_end

[chara_hide_all  time="1000"  wait="true"  ]
[tb_hide_message_window  ]
[jump  storage="omake.ks"  target="*story"  ]
