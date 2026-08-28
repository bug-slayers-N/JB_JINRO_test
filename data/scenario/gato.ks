[_tb_system_call storage=system/_gato.ks]

*show

[iscript]
f.calm_low=parseFloat(String(f.calm).split(',')[7])<25?1:0;
[endscript]

[chara_hide_all  time="500"  wait="true"  ]
[chara_show  name="gato"  time="1000"  wait="true"  storage="chara/9/gato_normal.png"  width="320"  height="720"  ]
[return  ]
*show2

[iscript]
f.calm_low=parseFloat(String(f.calm).split(',')[7])<25?1:0;
[endscript]

[chara_show  name="gato"  time="1000"  wait="true"  storage="chara/9/gato_normal.png"  width="320"  height="720"  ]
[return  ]
*show_normal

[jump  storage="gato.ks"  target="*show_normal2"  cond="f.calm_low==1"  ]
[chara_mod  name="gato"  time="300"  cross="false"  storage="chara/9/gato_normal.png"  ]
[return  ]
*show_normal2

[chara_mod  name="gato"  time="300"  cross="false"  storage="chara/9/gato_normal2.png"  ]
[return  ]
*show_ki

[chara_mod  name="gato"  time="300"  cross="false"  storage="chara/9/gato_ki.png"  ]
[return  ]
*show_do

[jump  storage="gato.ks"  target="*show_normal2"  cond="f.calm_low==1"  ]
[chara_mod  name="gato"  time="300"  cross="false"  storage="chara/9/gato_do.png"  ]
[return  ]
*show_ai

[return  ]
*show_jinro

[chara_mod  name="gato"  time="300"  cross="false"  storage="chara/9/gato_insane.png"  ]
[return  ]
*show_jinro2

[chara_hide_all  time="0"  wait="true"  ]
[chara_show  name="gato"  time="1000"  wait="true"  storage="chara/9/gato_insane2.png"  width="400"  height="900"  left="430"  top="-40"  reflect="false"  ]
[return  ]
*day01_01

[call  storage="gato.ks"  target="*show"  ]
[call  storage="gato.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#牙頭
「もうギャンブルは辞めたんだよ。伊月ともそう約束した」[p]
「……ただのパーティーゲーム？」[p]
「は、たまには息抜きも悪くはねぇか」[p]
「勿論、伊月もいんだろ？」[p]
[_tb_end_text]

[return  ]
*debate01

[call  storage="gato.ks"  target="*debate_Top"  ]
[jump  storage="gato.ks"  target="*first"  cond="f.turn!=0"  ]
[tb_start_text mode=1 ]
#牙頭
「昼の議論ターンだな」[p]
[_tb_end_text]

*first

[tb_start_text mode=1 ]
#牙頭
「どうすんだ？」[p]
[_tb_end_text]

[return  ]
*debate_Top

[chara_show  name="gato"  time="1000"  wait="true"  storage="chara/9/gato_normal.png"  width="320"  height="720"  left="700"  top=""  reflect="false"  ]
[call  storage="gato.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#牙頭
[_tb_end_text]

[return  ]
*kuro

[call  storage="gato.ks"  target="*show2"  ]
[call  storage="gato.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#牙頭
「こういうやっかみを受けるのは慣れてんだよ」[p]
[_tb_end_text]

[return  ]
*shiro

[call  storage="gato.ks"  target="*show2"  ]
[call  storage="gato.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#牙頭
「媚びてもオレの考えは変わらないぜ」[p]
[_tb_end_text]

[return  ]
*doubt

[tb_start_text mode=1 ]
「誰が怪しい？」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*doubt"  ]
*doubt2

[jump  storage="gato.ks"  target="*add"  cond="f.display08=='add'"  ]
[call  storage="gato.ks"  target="*show"  ]
*doubt3

[call  storage="gato.ks"  target="*show_normal"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#牙頭
「オレは[emb exp="f.name"]が怪しいって思ってっから」[p]
[_tb_end_tyrano_code]

[call  storage="gato.ks"  target="*push"  cond="f.win=='d1'"  ]
[call  storage="gato.ks"  target="*push2"  cond="f.win=='d2'"  ]
[call  storage="gato.ks"  target="*push3"  cond="f.win=='d3'"  ]
[jump  storage="doubt.ks"  target="*show"  ]
*push

[tb_start_text mode=1 ]
「ま、勘なんだけどよ。オレの勘は外れねぇ」[p]
[_tb_end_text]

[return  ]
*push2

[tb_start_text mode=1 ]
「嘘ついてんのはわかってんだよ。問題は人狼か狂人か」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*push3

[call  storage="gato.ks"  target="*show_ki"  ]
[tb_start_tyrano_code]
「[emb exp="f.name"]は人狼で決まりだ」[p]
「負け犬程ゴチャゴチャうるせぇ」[p]
[_tb_end_tyrano_code]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*liar

[call  storage="gato.ks"  target="*show"  ]
[call  storage="gato.ks"  target="*show_jinro"  ]
[tb_start_tyrano_code]
#牙頭
([emb exp="f.name"]は嘘をついてんな)[p]
[_tb_end_tyrano_code]

[return  ]
*cover

[tb_start_text mode=1 ]
「誰をシロだと思ってる？」[p]
[_tb_end_text]

[jump  storage="cover.ks"  target="*cover"  ]
*cover2

[jump  storage="gato.ks"  target="*add"  cond="f.display08=='add'"  ]
[chara_hide_all  time="0"  wait="true"  ]
[call  storage="gato.ks"  target="*show"  ]
*cover3

[call  storage="gato.ks"  target="*show_normal"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#牙頭
「オレは[emb exp="f.name"]は人間だと思ってる、お前らがどう思おうとな」[p]
[_tb_end_tyrano_code]

[jump  storage="cover.ks"  target="*show"  ]
*vote

[mask_off  time="500"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
#牙頭
「投票の時間か」[p]
「誰に投票するんだ？」[p]
[_tb_end_text]

[jump  storage="vote.ks"  target="*player_vote"  ]
*death

[call  storage="gato.ks"  target="*show"  ]
[call  storage="gato.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#牙頭
「オレを処刑したところで、オレの陣営の勝ちは変わんねぇよ」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[jump  storage="system.ks"  target="*death"  ]
*CO

[call  storage="gato.ks"  target="*show2"  ]
[call  storage="gato.ks"  target="*CO2"  cond="f.role2=='co'"  ]
[call  storage="gato.ks"  target="*show_ki"  ]
[jump  storage="gato.ks"  target="*CO_day1"  cond="f.jump=='day1'"  ]
[tb_start_tyrano_code]
#牙頭
「オレが[emb exp="f.display09"]だ」[p]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[emb exp="f.name"]は[emb exp="f.name2"]だったぜ。[p]
[_tb_end_tyrano_code]

[return  ]
*CO_day1

[tb_start_text mode=1 ]
#牙頭
「霊媒師は自分だけど、結果は明日のお楽しみ」[p]
[_tb_end_text]

[return  ]
*CO2

[call  storage="gato.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#牙頭
「待て」[p]
[_tb_end_text]

[return  ]
*CO3

[call  storage="gato.ks"  target="*show"  ]
[call  storage="gato.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#牙頭
「この中に嘘つきがいる、という訳だ」[p]
[_tb_end_text]

[return  ]
*vsCO

[tb_start_text mode=1 ]
#牙頭
「対抗するか？」[p]
[_tb_end_text]

[return  ]
*pCO

[call  storage="gato.ks"  target="*show2"  ]
[call  storage="gato.ks"  target="*show_normal"  ]
[tb_start_tyrano_code]
#牙頭
「[emb exp="f.display09"]は名乗り出るべきではないか？」[p]
[_tb_end_tyrano_code]

[return  ]
*s_human

[call  storage="gato.ks"  target="*show2"  ]
[call  storage="gato.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#牙頭
「情報に乏しい今、一度全員が村人だと宣言したらどうか？」[p]
[_tb_end_text]

[return  ]
*human

[call  storage="gato.ks"  target="*show"  ]
[call  storage="gato.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#牙頭
「村人に決まってんだろ」[p]
[_tb_end_text]

[jump  storage="say_human.ks"  target="*say_human_reply"  ]
*noisy

[call  storage="gato.ks"  target="*show2"  ]
[call  storage="gato.ks"  target="*show_ai"  ]
[tb_start_tyrano_code]
#牙頭
「[emb exp="f.name"]、さすがに騒々しすぎる」[p]
「何か必死に誘導したいのか？かえって怪しいが」[p]
[_tb_end_tyrano_code]

[return  ]
*push_act

[call  storage="gato.ks"  target="*show2"  ]
[tb_start_tyrano_code]
#牙頭
「[emb exp="f.name2"]、それは違う」[p]
「少し黙った方がいいのでは？」[p]
[_tb_end_tyrano_code]

[jump  storage="observe.ks"  target="*observe"  ]
*jinro_win

[call  storage="gato.ks"  target="*show2"  ]
[call  storage="gato.ks"  target="*show_jinro"  ]
[tb_start_text mode=1 ]
#牙頭
「マヌケめ、私達が嘘つきだ」[p]
「手軽なゲームだろうと私が強い」[p]
[_tb_end_text]

[return  ]
*human_win

[call  storage="gato.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#牙頭
「当然、村人陣営の勝利だ」[p]
[_tb_end_text]

[return  ]
*win

[call  storage="gato.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#牙頭
「当然の勝利だ」[p]
「ふんっ、マヌケにしてはまだマシな方だったということだな」[p]
「私は帰らせてもらう」[p]
[_tb_end_text]

[return  ]
*win2

[call  storage="gato.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#牙頭
「当然の勝利だ」[p]
「ふんっ、マヌケにしてはまだマシな方だったということだな」[p]

[_tb_end_text]

[mask  time="200"  effect="fadeIn"  color="0x000000"  ]
[call  storage="gato.ks"  target="*show_jinro2"  ]
[mask_off  time="200"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
「否、あなたは自分の可能性に気が付いていないのかも知れないな」[p]
[_tb_end_text]

[return  ]
*lose

[call  storage="gato.ks"  target="*show"  ]
[call  storage="gato.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#牙頭
「負けたか」[p]
「仕方あるまい、私には決定権がなかったのだ」[p]
「どれだけの名医でも、言うことの聞かない患者に出来ることはない」[p]
「私は帰らせてもらう」[p]
[_tb_end_text]

[return  ]
*stop

[call  storage="gato.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#牙頭
「おかしいよなァ。おめーは村人だって言ってない」[p]
[_tb_end_text]

[return  ]
*stop2

[call  storage="gato.ks"  target="*show2"  ]
[call  storage="gato.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#牙頭
「厄介クレーマーはどっちかってんなら、見てる奴らが決めるだろ」[p]
[_tb_end_text]

[return  ]
*add

[call  storage="gato.ks"  target="*show2"  ]
[call  storage="gato.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#牙頭
「オレもいいか？」[p]
[_tb_end_text]

[jump  storage="gato.ks"  target="*doubt3"  cond="f.jump=='doubt'"  ]
[jump  storage="gato.ks"  target="*cover3"  ]
