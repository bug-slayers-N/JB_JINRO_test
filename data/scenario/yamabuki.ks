[_tb_system_call storage=system/_yamabuki.ks]

*show

[iscript]
f.calm_low=parseFloat(String(f.calm).split(',')[6])<23?1:0;
[endscript]

[chara_hide_all  time="500"  wait="true"  ]
[chara_show  name="yamabuki"  time="1000"  wait="true"  storage="chara/8/yamabuki_normal.png"  width="320"  height="720"  ]
[return  ]
*show2

[iscript]
f.calm_low=parseFloat(String(f.calm).split(',')[6])<23?1:0;
[endscript]

[chara_show  name="yamabuki"  time="1000"  wait="true"  storage="chara/8/yamabuki_normal.png"  width="320"  height="720"  ]
[return  ]
*show_normal

[jump  storage="yamabuki.ks"  target="*show_normal2"  cond="f.calm_low==1"  ]
[chara_mod  name="yamabuki"  time="300"  cross="false"  storage="chara/8/yamabuki_normal.png"  ]
[return  ]
*show_normal2

[chara_mod  name="yamabuki"  time="300"  cross="false"  storage="chara/8/yamabuki_normal_2.png"  ]
[return  ]
*show_ki

[chara_mod  name="yamabuki"  time="300"  cross="false"  storage="chara/8/yamabuki_ki.png"  ]
[return  ]
*show_do

[jump  storage="yamabuki.ks"  target="*show_normal2"  cond="f.calm_low==1"  ]
[chara_mod  name="yamabuki"  time="300"  cross="false"  storage="chara/8/yamabuki_do.png"  ]
[return  ]
*show_ai

[return  ]
*show_jinro

[chara_mod  name="yamabuki"  time="300"  cross="false"  storage="chara/8/yamabuki_insane.png"  ]
[return  ]
*show_jinro2

[chara_hide_all  time="0"  wait="true"  ]
[chara_show  name="yamabuki"  time="1000"  wait="true"  storage="chara/8/yamabuki_insane2.png"  width="400"  height="900"  left="430"  top="-40"  reflect="false"  ]
[return  ]
*day01_01

[call  storage="yamabuki.ks"  target="*show"  ]
[call  storage="yamabuki.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#山吹
「VIP共の小間使いとしてゲームに参加しろと？」[p]
「マヌケに巻き込まれて敗北するくらいなら、この試合は降りさせてもらう」[p]
「…」[p]
[_tb_end_text]

[call  storage="yamabuki.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
「…なんだ、対戦相手は獅子神達なのか」[p]
「それなら問題ない、私が勝つ」[p]
[_tb_end_text]

[call  storage="yamabuki.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
「なんせ、マヌケを導くのはこの私が1番上手いのだからな」[p]
「とっとと会場に向かおう」[p]
[_tb_end_text]

[return  ]
*debate01

[call  storage="yamabuki.ks"  target="*debate_Top"  ]
[jump  storage="yamabuki.ks"  target="*first"  cond="f.turn!=0"  ]
[tb_start_text mode=1 ]
#山吹
「昼の議論ターンの開始だ」[p]
[_tb_end_text]

*first

[tb_start_text mode=1 ]
#山吹
「さて、どうする？」[p]
[_tb_end_text]

[return  ]
*debate_Top

[chara_show  name="yamabuki"  time="1000"  wait="true"  storage="chara/8/yamabuki_normal.png"  width="320"  height="720"  left="700"  top=""  reflect="false"  ]
[call  storage="yamabuki.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#山吹
[_tb_end_text]

[return  ]
*kuro

[call  storage="yamabuki.ks"  target="*show2"  ]
[call  storage="yamabuki.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#山吹
「なにを根拠に疑うというか。まぬけめ」[p]
[_tb_end_text]

[return  ]
*shiro

[call  storage="yamabuki.ks"  target="*show2"  ]
[call  storage="yamabuki.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#山吹
「悪くない判断だ、あなたが人間だとしても人狼だとしても」[p]
[_tb_end_text]

[return  ]
*doubt

[tb_start_text mode=1 ]
「誰を疑う？」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*doubt"  ]
*doubt2

[jump  storage="yamabuki.ks"  target="*add"  cond="f.display08=='add'"  ]
[call  storage="yamabuki.ks"  target="*show"  ]
*doubt3

[call  storage="yamabuki.ks"  target="*show_normal"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#山吹
「[emb exp="f.name"]が怪しい」[p]
[_tb_end_tyrano_code]

[call  storage="yamabuki.ks"  target="*push"  cond="f.win=='d1'"  ]
[call  storage="yamabuki.ks"  target="*push2"  cond="f.win=='d2'"  ]
[call  storage="yamabuki.ks"  target="*push3"  cond="f.win=='d3'"  ]
[jump  storage="doubt.ks"  target="*show"  ]
*push

[tb_start_text mode=1 ]
「論理ではまだ証明は出来ない、勘の段階だ」[p]
[_tb_end_text]

[return  ]
*push2

[tb_start_text mode=1 ]
「瞳孔の開き、脈拍、見るべきところはいくらでもある。嘘つきだだ」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*push3

[call  storage="yamabuki.ks"  target="*show_ki"  ]
[tb_start_tyrano_code]
「[emb exp="f.name"]は人狼、論理的に考えてそうだ」[p]
「ここからどう覆すというのだ？」[p]
[_tb_end_tyrano_code]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*liar

[call  storage="yamabuki.ks"  target="*show"  ]
[call  storage="yamabuki.ks"  target="*show_jinro"  ]
[tb_start_tyrano_code]
#山吹
(間違いない、[emb exp="f.name"]は嘘をついている)[p]
[_tb_end_tyrano_code]

[return  ]
*cover

[tb_start_text mode=1 ]
「誰なら信じれるか？」[p]
[_tb_end_text]

[jump  storage="cover.ks"  target="*cover"  ]
*cover2

[jump  storage="yamabuki.ks"  target="*add"  cond="f.display08=='add'"  ]
[chara_hide_all  time="0"  wait="true"  ]
[call  storage="yamabuki.ks"  target="*show"  ]
*cover3

[call  storage="yamabuki.ks"  target="*show_normal"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#山吹
「[emb exp="f.name"]は人間である可能性が高い」[p]
[_tb_end_tyrano_code]

[jump  storage="cover.ks"  target="*show"  ]
*vote

[mask_off  time="500"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
#山吹
「投票の時間か」[p]
「誰に投票する？」[p]
[_tb_end_text]

[jump  storage="vote.ks"  target="*player_vote"  ]
*death

[call  storage="yamabuki.ks"  target="*show"  ]
[call  storage="yamabuki.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#山吹
「私だと？まったく、とんだマヌケ共め」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[jump  storage="system.ks"  target="*death"  ]
*CO

[call  storage="yamabuki.ks"  target="*show2"  ]
[call  storage="yamabuki.ks"  target="*CO2"  cond="f.role2=='co'"  ]
[call  storage="yamabuki.ks"  target="*show_ki"  ]
[jump  storage="yamabuki.ks"  target="*CO_day1"  cond="f.jump=='day1'"  ]
[tb_start_tyrano_code]
#山吹
「言っておく、私が[emb exp="f.display09"]だ」[p]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[emb exp="f.name"]を占った。結果は[emb exp="f.name2"]だ。[p]
[_tb_end_tyrano_code]

[return  ]
*CO_day1

[tb_start_text mode=1 ]
#山吹
「霊媒師は自分だけど、結果は明日のお楽しみ」[p]
[_tb_end_text]

[return  ]
*CO2

[call  storage="yamabuki.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#山吹
「待て」[p]
[_tb_end_text]

[return  ]
*CO3

[call  storage="yamabuki.ks"  target="*show"  ]
[call  storage="yamabuki.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#山吹
「この中に嘘つきがいる、という訳だ」[p]
[_tb_end_text]

[return  ]
*vsCO

[tb_start_text mode=1 ]
#山吹
「対抗するか？」[p]
[_tb_end_text]

[return  ]
*pCO

[call  storage="yamabuki.ks"  target="*show2"  ]
[call  storage="yamabuki.ks"  target="*show_normal"  ]
[tb_start_tyrano_code]
#山吹
「[emb exp="f.display09"]は名乗り出るべきではないか？」[p]
[_tb_end_tyrano_code]

[return  ]
*s_human

[call  storage="yamabuki.ks"  target="*show2"  ]
[call  storage="yamabuki.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#山吹
「情報に乏しい今、一度全員が村人だと宣言したらどうか？」[p]
[_tb_end_text]

[return  ]
*human

[call  storage="yamabuki.ks"  target="*show"  ]
[call  storage="yamabuki.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#山吹
「村人だぜ」[p]
[_tb_end_text]

[jump  storage="say_human.ks"  target="*say_human_reply"  ]
*noisy

[call  storage="yamabuki.ks"  target="*show2"  ]
[call  storage="yamabuki.ks"  target="*show_ai"  ]
[tb_start_tyrano_code]
#山吹
「[emb exp="f.name"]、さすがに騒々しすぎる」[p]
「何か必死に誘導したいのか？かえって怪しいが」[p]
[_tb_end_tyrano_code]

[return  ]
*push_act

[call  storage="yamabuki.ks"  target="*show2"  ]
[tb_start_tyrano_code]
#山吹
「[emb exp="f.name2"]、それは違う」[p]
「少し黙った方がいいのでは？」[p]
[_tb_end_tyrano_code]

[jump  storage="observe.ks"  target="*observe"  ]
*jinro_win

[call  storage="yamabuki.ks"  target="*show2"  ]
[call  storage="yamabuki.ks"  target="*show_jinro"  ]
[tb_start_text mode=1 ]
#山吹
「マヌケめ、私達が嘘つきだ」[p]
「手軽なゲームだろうと私が強い」[p]
[_tb_end_text]

[return  ]
*human_win

[call  storage="yamabuki.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#山吹
「当然、村人陣営の勝利だ」[p]
[_tb_end_text]

[return  ]
*win

[call  storage="yamabuki.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#山吹
「当然の勝利だ」[p]
「ふんっ、マヌケにしてはまだマシな方だったということだな」[p]
「私は帰らせてもらう」[p]
[_tb_end_text]

[return  ]
*win2

[call  storage="yamabuki.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#山吹
「当然の勝利だ」[p]
「ふんっ、マヌケにしてはまだマシな方だったということだな」[p]

[_tb_end_text]

[mask  time="200"  effect="fadeIn"  color="0x000000"  ]
[call  storage="yamabuki.ks"  target="*show_jinro2"  ]
[mask_off  time="200"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
「否、あなたは自分の可能性に気が付いていないのかも知れないな」[p]
[_tb_end_text]

[return  ]
*lose

[call  storage="yamabuki.ks"  target="*show"  ]
[call  storage="yamabuki.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#山吹
「負けたか」[p]
「仕方あるまい、私には決定権がなかったのだ」[p]
「どれだけの名医でも、言うことの聞かない患者に出来ることはない」[p]
「私は帰らせてもらう」[p]
[_tb_end_text]

[return  ]
*stop

[call  storage="yamabuki.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#山吹
「あ？おめーは宣言しねぇのかよ」[p]
[_tb_end_text]

[return  ]
*stop2

[call  storage="yamabuki.ks"  target="*show2"  ]
[call  storage="yamabuki.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#山吹
「お前だけが楯突いたって忘れんなよ」[p]
[_tb_end_text]

[return  ]
*add

[call  storage="yamabuki.ks"  target="*show2"  ]
[call  storage="yamabuki.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#山吹
「私からも一言いいか」[p]
[_tb_end_text]

[jump  storage="yamabuki.ks"  target="*doubt3"  cond="f.jump=='doubt'"  ]
[jump  storage="yamabuki.ks"  target="*cover3"  ]
