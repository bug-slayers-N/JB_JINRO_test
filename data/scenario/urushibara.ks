[_tb_system_call storage=system/_urushibara.ks]

*name_change

[jump  storage="urushibara.ks"  target="*name_change_end"  cond="f.name!='牙頭'"  ]
[tb_eval  exp="f.name='ガッちゃん'"  name="name"  cmd="="  op="t"  val="ガッちゃん"  val_2="undefined"  ]
*name_change_end

[return  ]
*show

[iscript]
f.calm_low=parseFloat(String(f.calm).split(',')[8])<28?1:0;
[endscript]

[chara_hide_all  time="500"  wait="true"  ]
[chara_show  name="urushibara"  time="1000"  wait="true"  storage="chara/10/urushibara_normal.png"  width="320"  height="720"  ]
[return  ]
*show2

[iscript]
f.calm_low=parseFloat(String(f.calm).split(',')[8])<28?1:0;
[endscript]

[chara_show  name="urushibara"  time="1000"  wait="true"  storage="chara/10/urushibara_normal.png"  width="320"  height="720"  ]
[return  ]
*show_normal

[jump  storage="urushibara.ks"  target="*show_normal2"  cond="f.calm_low==1"  ]
[chara_mod  name="urushibara"  time="300"  cross="false"  storage="chara/10/urushibara_normal.png"  ]
[return  ]
*show_normal2

[chara_mod  name="urushibara"  time="300"  cross="false"  storage="chara/10/urushibara_aseri.png"  ]
[return  ]
*show_ki

[chara_mod  name="urushibara"  time="300"  cross="false"  storage="chara/10/urushibara_normal.png"  ]
[return  ]
*show_do

[jump  storage="urushibara.ks"  target="*show_normal2"  cond="f.calm_low==1"  ]
[chara_mod  name="urushibara"  time="300"  cross="false"  storage="chara/10/urushibara_aseri.png"  ]
[return  ]
*show_ai

[return  ]
*show_jinro

[chara_mod  name="urushibara"  time="300"  cross="false"  storage="chara/10/urushibara_normal.png"  ]
[return  ]
*show_jinro2

[chara_hide_all  time="0"  wait="true"  ]
[chara_show  name="urushibara"  time="1000"  wait="true"  storage="chara/10/urushibara_insane2.png"  width="400"  height="900"  left="430"  top="-40"  reflect="false"  ]
[return  ]
*day01_01

[call  storage="urushibara.ks"  target="*show"  ]
[call  storage="urushibara.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#漆原
「うん？人狼ゲームのお誘いだって？」[p]
「僕は遠慮しておくかな…」[p]
「え、がっちゃんも来るの？それを先に言って欲しかったよ」[p]
「それなら勿論行くよ」[p]
[_tb_end_text]

[return  ]
*debate01

[call  storage="urushibara.ks"  target="*debate_Top"  ]
[jump  storage="urushibara.ks"  target="*first"  cond="f.turn!=0"  ]
[tb_start_text mode=1 ]
#漆原
「昼の議論ターンがはじまったね」[p]
[_tb_end_text]

*first

[tb_start_text mode=1 ]
#漆原
「どうしようか？」[p]
[_tb_end_text]

[return  ]
*debate_Top

[iscript]
f.calm_low=parseFloat(String(f.calm).split(',')[8])<28?1:0;
[endscript]

[chara_show  name="urushibara"  time="1000"  wait="true"  storage="chara/10/urushibara_normal.png"  width="320"  height="720"  left="700"  top=""  reflect="false"  ]
[call  storage="urushibara.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#漆原
[_tb_end_text]

[return  ]
*kuro

[call  storage="urushibara.ks"  target="*show2"  ]
[call  storage="urushibara.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#漆原
「それはあくまで憶測だろう？きちんと根拠を提示してほしいな」[p]
[_tb_end_text]

[return  ]
*shiro

[call  storage="urushibara.ks"  target="*show2"  ]
[call  storage="urushibara.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#漆原
「ありがとう。でも僕は感情だけでは判断しないからね」[p]
[_tb_end_text]

[return  ]
*doubt

[tb_start_text mode=1 ]
「誰が怪しいだろうか？」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*doubt"  ]
*doubt2

[jump  storage="urushibara.ks"  target="*add"  cond="f.display08=='add'"  ]
[call  storage="urushibara.ks"  target="*show"  ]
*doubt3

[call  storage="urushibara.ks"  target="*show_normal"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[call  storage="urushibara.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#漆原
「私的な意見だけど、僕は[emb exp="f.name"]が怪しいなって考えてるよ」[p]
[_tb_end_tyrano_code]

[call  storage="urushibara.ks"  target="*push"  cond="f.win=='d1'"  ]
[call  storage="urushibara.ks"  target="*push2"  cond="f.win=='d2'"  ]
[call  storage="urushibara.ks"  target="*push3"  cond="f.win=='d3'"  ]
[jump  storage="doubt.ks"  target="*show"  ]
*push

[tb_start_text mode=1 ]
「申し訳ないけど、私的な直感かな。でも証拠は今から集めればいい」[p]
[_tb_end_text]

[return  ]
*push2

[tb_start_text mode=1 ]
「嘘つきである証拠までは集まってるよ。狂人か人狼か、みんなの意見が聞きたいな」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*push3

[call  storage="urushibara.ks"  target="*show_ki"  ]
[tb_start_tyrano_code]
「人狼である証拠が完全に集まったね」[p]
「もう判決はみんなわかってると思うよ」[p]
[_tb_end_tyrano_code]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*liar

[call  storage="urushibara.ks"  target="*show"  ]
[call  storage="urushibara.ks"  target="*show_jinro"  ]
[call  storage="urushibara.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#漆原
(あぁ、[emb exp="f.name"]は嘘つきみたいだ)[p]
[_tb_end_tyrano_code]

[return  ]
*cover

[tb_start_text mode=1 ]
「誰を信じる？」[p]
[_tb_end_text]

[jump  storage="cover.ks"  target="*cover"  ]
*cover2

[jump  storage="urushibara.ks"  target="*add"  cond="f.display08=='add'"  ]
[chara_hide_all  time="0"  wait="true"  ]
[call  storage="urushibara.ks"  target="*show"  ]
*cover3

[call  storage="urushibara.ks"  target="*show_normal"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[call  storage="urushibara.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#漆原
「僕は[emb exp="f.name"]はシロの可能性が高いとみてるよ」[p]
[_tb_end_tyrano_code]

[jump  storage="cover.ks"  target="*show"  ]
*vote

[mask_off  time="500"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
#漆原
「投票の時間だね」[p]
「誰に投票する？」[p]
[_tb_end_text]

[jump  storage="vote.ks"  target="*player_vote"  ]
*death

[call  storage="urushibara.ks"  target="*show"  ]
[call  storage="urushibara.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#漆原
「はぁ、まぁこれもくじびきだから仕方ない。味方は是非頑張って欲しいね」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[jump  storage="system.ks"  target="*death"  ]
*CO

[call  storage="urushibara.ks"  target="*show2"  ]
[call  storage="urushibara.ks"  target="*CO2"  cond="f.role2=='co'"  ]
[call  storage="urushibara.ks"  target="*show_ki"  ]
[jump  storage="urushibara.ks"  target="*CO_day1"  cond="f.jump=='day1'"  ]
[call  storage="urushibara.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#漆原
「僕が[emb exp="f.display09"]みたい」[p]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[emb exp="f.name"]は[emb exp="f.name2"]らしいね。[p]
[_tb_end_tyrano_code]

[return  ]
*CO_day1

[tb_start_text mode=1 ]
#漆原
「霊媒師は僕だけど、結果は明日になるまでわからないね」[p]
[_tb_end_text]

[return  ]
*CO2

[call  storage="urushibara.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#漆原
「ちょっといいかな？」[p]
[_tb_end_text]

[return  ]
*CO3

[call  storage="urushibara.ks"  target="*show"  ]
[call  storage="urushibara.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#漆原
「この中に嘘つきがいるのは確実だね」[p]
[_tb_end_text]

[return  ]
*vsCO

[tb_start_text mode=1 ]
#漆原
「対抗しようか？」[p]
[_tb_end_text]

[return  ]
*pCO

[call  storage="urushibara.ks"  target="*show2"  ]
[call  storage="urushibara.ks"  target="*show_normal"  ]
[tb_start_tyrano_code]
#漆原
「[emb exp="f.display09"]は名乗り出てくれたら嬉しいな」[p]
[_tb_end_tyrano_code]

[return  ]
*s_human

[call  storage="urushibara.ks"  target="*show2"  ]
[call  storage="urushibara.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#漆原
「一度全員が村人だって言ってみるのもいいかもしれないね」[p]
[_tb_end_text]

[return  ]
*human

[call  storage="urushibara.ks"  target="*show"  ]
[call  storage="urushibara.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#漆原
「うん、村人だよ」[p]
[_tb_end_text]

[jump  storage="say_human.ks"  target="*say_human_reply"  ]
*noisy

[call  storage="urushibara.ks"  target="*show2"  ]
[call  storage="urushibara.ks"  target="*show_ai"  ]
[call  storage="urushibara.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#漆原
「[emb exp="f.name"]、少しうるさいんじゃないかな？」[p]
「そういうのは逆に怪しまれるよ」[p]
[_tb_end_tyrano_code]

[return  ]
*push_act

[call  storage="urushibara.ks"  target="*show2"  ]
[call  storage="urushibara.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#漆原
「[emb exp="f.name2"]、それは違うんじゃないかな？」[p]
「もう少し様子を見た方がいいと思うよ」[p]
[_tb_end_tyrano_code]

[jump  storage="observe.ks"  target="*observe"  ]
*jinro_win

[call  storage="urushibara.ks"  target="*show2"  ]
[call  storage="urushibara.ks"  target="*show_jinro"  ]
[tb_start_text mode=1 ]
#漆原
「ごめんね、僕達が嘘つきだよ」[p]
「たまにはこういうのも悪くないね」[p]
[_tb_end_text]

[return  ]
*human_win

[call  storage="urushibara.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#漆原
「うん、村人陣営の勝利だ。僕がついているんだからね」[p]
[_tb_end_text]

[return  ]
*win

[call  storage="urushibara.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#漆原
「言論で戦うゲームなら、やっぱり得意かも」[p]
「村人陣営なら本職に近いし、人狼なら守りに入ればかたい」[p]
「最も、攻めを担当してくれる誰かがいてくれるのも大きいけどね」[p]
「ギャンブルは辞めたけど、こういう遊びならまた来ようかな」[p]
「それでは、お暇するね」[p]
[_tb_end_text]

[return  ]
*win2

[call  storage="urushibara.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#漆原
「言論で戦うゲームなら、やっぱり得意かも」[p]
「村人陣営なら本職に近いし、人狼なら守りに入ればかたい」[p]
「最も、攻めを担当してくれる誰かがいてくれるのも大きいけどね」[p]
[_tb_end_text]

[mask  time="200"  effect="fadeIn"  color="0x000000"  ]
[call  storage="urushibara.ks"  target="*show_jinro2"  ]
[mask_off  time="200"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
「あなたも、いい相方と一緒なら活躍出来そうだったよ」[p]
[_tb_end_text]

[return  ]
*lose

[call  storage="urushibara.ks"  target="*show"  ]
[call  storage="urushibara.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#漆原
「負け、か」[p]
「ゲームだとしても言論で負けるのは悔しいな」[p]
「まぁ僕が選べないことも多かったし、くじびきに過度に入れ込むのはよくないね」[p]
「それでは、お暇するね」[p]
[_tb_end_text]

[return  ]
*stop

[call  storage="urushibara.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#漆原
「確認なんだけど、声をかける側は人間宣言しないんだね？」[p]
[_tb_end_text]

[return  ]
*stop2

[call  storage="urushibara.ks"  target="*show2"  ]
[call  storage="urushibara.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#漆原
「反論の自由はあるけど、みんなの心証はどうだろうね」[p]
[_tb_end_text]

[return  ]
*add

[call  storage="urushibara.ks"  target="*show2"  ]
[call  storage="urushibara.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#漆原
「僕からも意見を挟もうかな」[p]
[_tb_end_text]

[jump  storage="urushibara.ks"  target="*doubt3"  cond="f.jump=='doubt'"  ]
[jump  storage="urushibara.ks"  target="*cover3"  ]
