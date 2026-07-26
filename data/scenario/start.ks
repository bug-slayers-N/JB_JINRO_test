[_tb_system_call storage=system/_start.ks]

*start

[glink  color="btn_05_red"  storage="role.ks"  size="20"  text="・&nbsp;　ゲーム開始&nbsp;　・"  x="100"  y="100"  width=""  height=""  _clickable_img=""  autopos="true"  ]
[glink  color="btn_05_white"  storage="start.ks"  size="20"  text="・プロローグを見る・"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  target="*prologue"  ]
[s  ]
*prologue

[tb_show_message_window  ]
[chara_show  name="suo"  time="1000"  wait="true"  storage="chara/6/suo_normal.png"  width="320"  height="720"  ]
[tb_start_text mode=1 ]
#周防
「VIPの皆様、大変長らくお待たせいたしました」[p]
「より臨場感の高い、ギャンブラー視点でギャンブルを観戦したいという声にお応えしてご用意いたしましたエキシビション」[p]

[_tb_end_text]

[chara_mod  name="suo"  time="300"  cross="false"  storage="chara/6/suo_egao.png"  ]
[tb_start_text mode=1 ]
「ジャンケット人狼ゲームの開幕にございます」[p]
[_tb_end_text]

[chara_mod  name="suo"  time="300"  cross="false"  storage="chara/6/suo_normal.png"  ]
[tb_start_text mode=1 ]
「勿論、今回小間使いなのはギャンブラーの方にございます。選んだギャンブラーに指示を出し、人狼ゲームを攻略し、勝利に導いてくださいませ」[p]

[_tb_end_text]

[chara_mod  name="suo"  time="300"  cross="false"  storage="chara/6/suo_egao.png"  ]
[tb_start_text mode=1 ]
「おっと、意図的に敗北させても全く問題はございません」[p]

[_tb_end_text]

[chara_mod  name="suo"  time="300"  cross="false"  storage="chara/6/suo_normal.png"  ]
[tb_start_text mode=1 ]
「また役職やゲームの流れは遊ぶ度にランダムに展開されます」[p]
[_tb_end_text]

[chara_mod  name="suo"  time="300"  cross="false"  storage="chara/6/suo_egao.png"  ]
[tb_start_text mode=1 ]
「思うがままに我が銀行が誇るギャンブラー達の戦いを間近でごゆっくり楽しんでくださいませ」[p]
[_tb_end_text]

[mask  time="500"  effect="fadeIn"  color="0x000000"  ]
[mask_off  time="500"  effect="fadeOut"  ]
[chara_mod  name="suo"  time="300"  cross="false"  storage="chara/6/suo_normal.png"  ]
[tb_start_text mode=1 ]
#周防
「ここからはメタ発言になることをご了承くださいませ」[p]
「右上の三本線のメニューボタンよりフルスクリーンモードが使えます」[p]
「本作をスマートフォンで遊ばれる場合は、横持ちのフルスクリーンモードを推奨しておりますのでご活用ください」[p]
「それでは肝心のゲームの内容の説明に移らせていただきます」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[bg  time="1000"  method="crossfade"  storage="BG_selectChara.png"  ]
[tb_start_text mode=1 ]
#周防
「まずはじめに、主人公としてプレイしたいギャンブラーをお選びください」[p]
「選んだギャンブラーで難易度が前後します。初回は真経津、推理が苦手な方は叶、高難易度で遊びたい方には獅子神がおすすめです」[p]
「平常心が高い程嘘がバレにくく、観察力が高い程嘘を見破りやすく、ゆさぶり力が高い程疑う時に相手の平常心を大きく減らします」[p]
「キャラクターは随時追加されていきますので、製作者のXをご確認ください」[p]
[_tb_end_text]

[bg  time="1000"  method="crossfade"  storage="BG_tutorial_1.png"  ]
[tb_start_text mode=1 ]
#周防
「次に人狼における役職をお選びください」[p]
「《人狼》は毎晩1人人間を襲撃し、現在生存している人狼の数≧村人の数になることを目指します。また嘘がつけます」[p]
「《狂人》は人間でありながら《人狼》に味方し、人狼勝利時に同時に勝利します。こちらも嘘がつけます」[p]
「《占い師》はゲーム開始時と毎晩、占いにより1人の人間か？人狼か？の情報を得ます。人狼を全て処刑で勝利です」[p]
「《村人》は特殊な能力は持ちません。人狼を全て処刑で勝利です」[p]
[_tb_end_text]

[bg  time="1000"  method="crossfade"  storage="SS.png"  ]
[tb_start_text mode=1 ]
「キャラと役職が決まれば、ゲームが開始します」[p]
「こちらがメイン画面です。画面左のコマンドボタンでゲームは進みます」[p]
「《疑う》、シンプルに対象を疑います。対象の平常心を減らします。対象からの好感度も減らします」[p]
「《かばう》、対象をかばいます。対象の平常心を回復させます。対象からの好感度も上がります」[p]
「《様子を見る》、プレイヤー以外のキャラが行動します。プレイヤーの行動数が多過ぎても少なすぎても悪いことが起こるようです」[p]
「《強く疑う》プレイヤーのみにある一度限りのコマンドです。通常より大ダメージを与える疑うを行います。特に大きなダメージを与えるには理由が必要なようです」[p]
「《COする》《偽COする》、該当役職のみ活性化するコマンドです。自分は占い師だと宣言し、占い結果を報告します。それが偽だとしても」[p]
「《COを求める》、役職持ちにCOを要求します。答えてくれるかは本人次第です」[p]
「《人間と言え》、人間宣言させ、人狼と狂人の平常心を減らします。カウンターにより中止する・されることがあります。カウンターしたキャラとされたキャラの平常心が下がります。全体で一回のみのコマンドです」[p]
[_tb_end_text]

[bg  time="1000"  method="crossfade"  storage="BG_selectChara_noText_260429kari.png"  ]
[tb_start_text mode=1 ]
「1日目は10ターン、2日目以降は5ターンを経過すると投票フェーズに入ります」[p]
「対象キャラに投票して、処刑されるキャラを決めましょう」[p]
「人狼が処刑されるとゲーム終了し、村人陣営の勝利となります」[p]
「人狼が生き残っている限り、二日目に移行します」[p]
「人狼は投票後、襲撃フェーズをはさみ、任意の対象を襲撃して死亡させます」[p]
「勝利条件を達成するまでこれを繰り返します」[p]
[_tb_end_text]

[bg  time="1000"  method="crossfade"  storage="93853245_p0.png"  ]
[chara_show  name="suo"  time="1000"  wait="true"  storage="chara/6/suo_normal.png"  width="320"  height="720"  ]
[tb_start_text mode=1 ]
「正直、習うより慣れろというゲームです」[p]
「細かいゲーム仕様はおまけページ内のよくありそうなQ＆Aにまとめてあります」[p]
「真占い師の潜伏行動等、人狼慣れされてる方程必読でございます」[p]
「また特定条件で勝利を収めるとおまけページのおまけストーリーが解放されるそうです」[p]
「お時間のあるVIPの方は是非に挑戦してみてください」[p]

[_tb_end_text]

[chara_mod  name="suo"  time="300"  cross="false"  storage="chara/6/suo_egao.png"  ]
[tb_start_text mode=1 ]
「それではゲーム説明を終了し、ゲームを開始させていただきます」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[glink  color="btn_05_red"  storage="tutorial.ks"  size="20"  text="練習試合で動きを確認する"  target="*init"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[glink  color="btn_05_white"  storage="role.ks"  size="20"  text="早速ゲームを開始する"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[s  ]
[jump  storage="role.ks"  target=""  ]
