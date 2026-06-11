[_tb_system_call storage=system/_sisigami.ks]

*show

[chara_hide_all  time="500"  wait="true"  ]
[chara_show  name="sisigami"  time="1000"  wait="true"  storage="chara/2/shishigami_normal.png"  width="320"  height="720"  ]
[return  ]
*show2

[chara_show  name="sisigami"  time="1000"  wait="true"  storage="chara/2/shishigami_normal.png"  width="320"  height="720"  ]
[return  ]
*show_normal

[jump  storage="sisigami.ks"  target="*show_normal2"  cond="f.sisigami_calm<20"  ]
[chara_mod  name="sisigami"  time="300"  cross="false"  storage="chara/2/shishigami_normal.png"  ]
[return  ]
*show_normal2

[chara_mod  name="sisigami"  time="300"  cross="false"  storage="chara/2/shishigami_normal_2.png"  ]
[return  ]
*show_ki

[chara_mod  name="sisigami"  time="300"  cross="false"  storage="chara/2/shishigami_ki.png"  ]
[return  ]
*show_ai

[jump  storage="sisigami.ks"  target="*show_normal2"  cond="f.sisigami_calm<20"  ]
[chara_mod  name="sisigami"  time="300"  cross="false"  storage="chara/2/shishigami_aseri.png"  ]
[return  ]
*show_gimon

[chara_mod  name="sisigami"  time="300"  cross="false"  storage="chara/2/shishigami_gimon.png"  ]
[return  ]
*show_jinro

[chara_mod  name="sisigami"  time="300"  cross="false"  storage="chara/2/shishigami_insane.png"  ]
[return  ]
*show_jinro2

[chara_hide_all  time="0"  wait="true"  ]
[chara_show  name="sisigami"  time="1000"  wait="true"  storage="chara/2/shishigami_insane2.png"  width="400"  height="900"  left="430"  top="-40"  reflect="false"  ]
[return  ]
*day01_01

[call  storage="sisigami.ks"  target="*show"  ]
[call  storage="sisigami.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#獅子神
「VIPと協力して人狼ゲーム？カラス銀行は経営難か？」[p]
「オレはあくまでVIPの傀儡としてしか戦えないってふざけてんのかよ」[p]
「対戦相手は真経津達！？」[p]

[_tb_end_text]

[call  storage="sisigami.ks"  target="*show_gimon"  ]
[tb_start_text mode=1 ]
「…」[p]
[_tb_end_text]

[call  storage="sisigami.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
「アイツらにも後ろにVIPがついてるならオレがアイツらに勝てる絶好のチャンスってワケか」[p]
「とっとと会場に向かうぞ」[p]
[_tb_end_text]

[return  ]
*debate01

[call  storage="sisigami.ks"  target="*debate_Top"  ]
[call  storage="uranai.ks"  target="*game_start"  cond="f.role==3"  ]
[jump  storage="sisigami.ks"  target="*first"  cond="f.turn!=0"  ]
[tb_start_text mode=1 ]
#獅子神
「昼の議論のターンだな」[p]
[_tb_end_text]

*first

[tb_start_text mode=1 ]
#獅子神
「どうする？」[p]
[_tb_end_text]

[return  ]
*debate_Top

[chara_show  name="sisigami"  time="1000"  wait="true"  storage="chara/2/shishigami_normal.png"  width="320"  height="720"  left="700"  top=""  reflect="false"  ]
[call  storage="sisigami.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#獅子神
[_tb_end_text]

[return  ]
*kuro

[call  storage="sisigami.ks"  target="*show2"  ]
[call  storage="sisigami.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#獅子神
「は？オレのどこが怪しいってんだよ」[p]
[_tb_end_text]

[return  ]
*shiro

[call  storage="sisigami.ks"  target="*show2"  ]
[call  storage="sisigami.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#獅子神
「目的はわかんねぇが、あんがとな」[p]
[_tb_end_text]

[return  ]
*doubt

[tb_start_text mode=1 ]
「誰が怪しい？」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*doubt"  ]
*doubt2

[call  storage="sisigami.ks"  target="*show"  ]
[call  storage="sisigami.ks"  target="*show_normal"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#獅子神
「[emb exp="f.name"]が怪しいんだよなぁ」[p]
[_tb_end_tyrano_code]

[call  storage="sisigami.ks"  target="*push"  cond="f.win=='d1'"  ]
[call  storage="sisigami.ks"  target="*push2"  cond="f.win=='d2'"  ]
[call  storage="sisigami.ks"  target="*push3"  cond="f.win=='d3'"  ]
[jump  storage="doubt.ks"  target="*show"  ]
*push

[tb_start_text mode=1 ]
「正直、勘なんだがな」[p]
[_tb_end_text]

[return  ]
*push2

[tb_start_text mode=1 ]
「オレが見ても怪しいんだぞ？オメーらならわかんだろ」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*push3

[call  storage="sisigami.ks"  target="*show_ki"  ]
[tb_start_tyrano_code]
「[emb exp="f.name"]は人狼で間違いねぇ」[p]
「それは[emb exp="f.name"]も、オメーらもよくわかってるはずだ」[p]
[_tb_end_tyrano_code]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*liar

[call  storage="sisigami.ks"  target="*show"  ]
[call  storage="sisigami.ks"  target="*show_jinro"  ]
[tb_start_tyrano_code]
#獅子神
(間違いねぇ、[emb exp="f.name"]は嘘つきだ)[p]
[_tb_end_tyrano_code]

[return  ]
*cover

[tb_start_text mode=1 ]
「誰なら信じれる？」[p]
[_tb_end_text]

[jump  storage="cover.ks"  target="*cover"  ]
*cover2

[chara_hide_all  time="0"  wait="true"  ]
[call  storage="sisigami.ks"  target="*show"  ]
[call  storage="sisigami.ks"  target="*show_gimon"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#獅子神
「わかんねぇけど、[emb exp="f.name"]は大丈夫そうな気がするんだよな」[p]
[_tb_end_tyrano_code]

[jump  storage="cover.ks"  target="*show"  ]
*vote

[mask_off  time="500"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
#獅子神
「投票の時間か」[p]
「誰に投票すんだ？」[p]
[_tb_end_text]

[jump  storage="vote.ks"  target="*player_vote"  ]
*death

[tb_eval  exp="f.sisigami_calm=80"  name="sisigami_calm"  cmd="="  op="t"  val="80"  val_2="undefined"  ]
[call  storage="sisigami.ks"  target="*show"  ]
[call  storage="sisigami.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#獅子神
「オレかよ！？」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[jump  storage="system.ks"  target="*death"  ]
*CO

[call  storage="sisigami.ks"  target="*show2"  ]
[call  storage="sisigami.ks"  target="*CO2"  cond="f.role2=='co'"  ]
[call  storage="sisigami.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#獅子神
「あー、オレが占い師なんだわ」[p]
[_tb_end_text]

[tb_start_tyrano_code]
[emb exp="f.name"]を占った。結果は[emb exp="f.name2"]だ。[p]
[_tb_end_tyrano_code]

[return  ]
*CO2

[call  storage="sisigami.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#獅子神
「待てよ」[p]
[_tb_end_text]

[return  ]
*CO3

[call  storage="sisigami.ks"  target="*show"  ]
[call  storage="sisigami.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#獅子神
「少なくとも誰かが嘘つきってか」[p]
[_tb_end_text]

[return  ]
*vsCO

[tb_start_text mode=1 ]
#獅子神
「対抗すっか？」[p]
[_tb_end_text]

[return  ]
*pCO

[call  storage="sisigami.ks"  target="*show2"  ]
[call  storage="sisigami.ks"  target="*show_gimon"  ]
[tb_start_text mode=1 ]
#獅子神
「占い師が出てくれると助かるんだけどよ」[p]
[_tb_end_text]

[return  ]
*s_human

[call  storage="sisigami.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#獅子神
「手っ取り早くよ、自分は村人だって言ってみてくれねぇか？」[p]
[_tb_end_text]

[return  ]
*human

[call  storage="sisigami.ks"  target="*show"  ]
[call  storage="sisigami.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#獅子神
「あ？勿論、村人だよ」[p]
[_tb_end_text]

[return  ]
*noisy

[call  storage="sisigami.ks"  target="*show2"  ]
[call  storage="sisigami.ks"  target="*show_ki"  ]
[tb_start_tyrano_code]
#獅子神
「[emb exp="f.name"]、うるさくねぇか？」[p]
「こういう奴が怪しいんだよなぁ？」[p]
[_tb_end_tyrano_code]

[return  ]
*push_act

[call  storage="sisigami.ks"  target="*show2"  ]
[tb_start_tyrano_code]
#獅子神
「[emb exp="f.name2"]、それは違うくねぇか？」[p]
「無理があると思うぜ」[p]
[_tb_end_tyrano_code]

[jump  storage="observe.ks"  target="*observe"  ]
*jinro_win

[call  storage="sisigami.ks"  target="*show2"  ]
[call  storage="sisigami.ks"  target="*show_jinro"  ]
[tb_start_text mode=1 ]
#獅子神
「オレ達が嘘つきだ！残念だったな」[p]
「オメーらに一泡ふかせてやったぜ」[p]
[_tb_end_text]

[return  ]
*human_win

[call  storage="sisigami.ks"  target="*show2"  ]
[call  storage="sisigami.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#獅子神
「おっし、村人陣営の勝利だ。やったな」[p]
[_tb_end_text]

[return  ]
*win

[call  storage="sisigami.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#獅子神
「無事に勝ってやったぜ、見てたか？」[p]
「アイツらの後ろにもVIPがいたってのもあるがな」[p]
「オレ1人でもアイツらに勝ってやるから、そん時の試合も見に来いよ。じゃあな」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[return  ]
*win2

[call  storage="sisigami.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#獅子神
「無事に勝ってやったぜ、見てたか？」[p]
「アイツらの後ろにもVIPがいたってのもあるがな」[p]
[_tb_end_text]

[mask  time="200"  effect="fadeIn"  color="0x000000"  ]
[call  storage="sisigami.ks"  target="*show_jinro2"  ]
[mask_off  time="200"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
「それとも案外、あんたのおかげかもな」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[return  ]
*lose

[call  storage="sisigami.ks"  target="*show"  ]
[call  storage="sisigami.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#獅子神
「負けた、か」[p]
「やっぱりツェーな、あいつら」[p]
「今度こそリベンジしてやるから、また見に来いよ。じゃあな」[p]
[_tb_end_text]

[return  ]
*stop

[call  storage="sisigami.ks"  target="*show2"  ]
[call  storage="sisigami.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#獅子神
「他人に人間宣言を要求される前に自分で言おうって算段か？」[p]
[_tb_end_text]

[return  ]
*stop2

[call  storage="sisigami.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#獅子神
「止めたオメーだって怪しいことを忘れんなよ」[p]
[_tb_end_text]

[return  ]
