[_tb_system_call storage=system/_tendo.ks]

*tendo_namechange

[iscript]
if(f.name==="叶")f.name="黎明";
[endscript]

[return  ]
*show

[chara_hide_all  time="500"  wait="true"  ]
[chara_show  name="tendo"  time="1000"  wait="true"  storage="chara/5/tendo_normal.png"  width="320"  height="720"  ]
[return  ]
*show2

[chara_show  name="tendo"  time="1000"  wait="true"  storage="chara/5/tendo_normal.png"  width="320"  height="720"  ]
[return  ]
*show_normal

[jump  storage="tendo.ks"  target="*show_normal2"  cond="f.tendo_calm<30"  ]
[chara_mod  name="tendo"  time="300"  cross="false"  storage="chara/5/tendo_normal.png"  ]
[return  ]
*show_normal2

[chara_mod  name="tendo"  time="300"  cross="false"  storage="chara/5/tendo_normal_2.png"  ]
[return  ]
*show_ki

[chara_mod  name="tendo"  time="300"  cross="false"  storage="chara/5/tendo_ki.png"  ]
[return  ]
*show_do

[jump  storage="tendo.ks"  target="*show_normal2"  cond="f.tendo_calm<30"  ]
[chara_mod  name="tendo"  time="300"  cross="false"  storage="chara/5/tendo_do.png"  ]
[return  ]
*show_ai

[chara_mod  name="tendo"  time="300"  cross="false"  storage="chara/5/tendo_ai.png"  ]
[return  ]
*show_jinro

[chara_mod  name="tendo"  time="300"  cross="false"  storage="chara/5/tendo_insane.png"  ]
[return  ]
*show_jinro2

[chara_hide_all  time="0"  wait="true"  ]
[chara_show  name="tendo"  time="1000"  wait="true"  storage="chara/5/tendo_insane2.png"  width="400"  height="900"  left="430"  top="-40"  reflect="false"  ]
[return  ]
*day01_01

[call  storage="tendo.ks"  target="*show"  ]
[call  storage="tendo.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#天堂
「神が小間使いだと？」[p]

[_tb_end_text]

[call  storage="tendo.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
「…哀れな」[p]
「神を指先で扱えるなど傲った精神、救うべくもない」[p]
「まぁ、よい」[p]
[_tb_end_text]

[call  storage="tendo.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
「その無知蒙昧さを画面越しで痛感するがいい」[p]
「さて、会場に向かうとするか」[p]
[_tb_end_text]

[return  ]
*debate01

[call  storage="tendo.ks"  target="*debate_Top"  ]
[call  storage="uranai.ks"  target="*game_start"  cond="f.role==3"  ]
[jump  storage="tendo.ks"  target="*first"  cond="f.turn!=0"  ]
[tb_start_text mode=1 ]
#天堂
「昼の議論ターンだ」[p]
[_tb_end_text]

*first

[tb_start_text mode=1 ]
#天堂
「どうする？」[p]
[_tb_end_text]

[return  ]
*debate_Top

[chara_show  name="tendo"  time="1000"  wait="true"  storage="chara/5/tendo_normal.png"  width="320"  height="720"  left="700"  top=""  reflect="false"  ]
[tb_start_text mode=1 ]
#天堂
[_tb_end_text]

[return  ]
*kuro

[call  storage="tendo.ks"  target="*show2"  ]
[call  storage="tendo.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#天堂
「神を疑うとはバチあたりめ」[p]
[_tb_end_text]

[return  ]
*shiro

[call  storage="tendo.ks"  target="*show2"  ]
[call  storage="tendo.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#天堂
「当然だ。そのまま神を信じるといい」[p]
[_tb_end_text]

[return  ]
*doubt

[tb_start_text mode=1 ]
「誰を疑うか」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*doubt"  ]
*doubt2

[call  storage="tendo.ks"  target="*show"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[call  storage="tendo.ks"  target="*tendo_namechange"  ]
[tb_start_tyrano_code]
#天堂
「[emb exp="f.name"]が怪しく見える」[p]
[_tb_end_tyrano_code]

[call  storage="tendo.ks"  target="*push"  cond="f.win=='d1'"  ]
[call  storage="tendo.ks"  target="*push2"  cond="f.win=='d2'"  ]
[call  storage="tendo.ks"  target="*push3"  cond="f.win=='d3'"  ]
[jump  storage="doubt.ks"  target="*show"  ]
*push

[tb_start_text mode=1 ]
「直感とは一種の神の声である。無視すべきではない」[p]
[_tb_end_text]

[return  ]
*push2

[tb_start_text mode=1 ]
「神の前では咎人の吐く嘘など、業火の如くはっきり見える」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*push3

[call  storage="tendo.ks"  target="*show_ki"  ]
[tb_start_tyrano_code]
「[emb exp="f.name"]は人狼である、揺るぎはない」[p]
「断罪は目の前だ、懺悔をするなら今が最後だ」[p]
[_tb_end_tyrano_code]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*liar

[call  storage="tendo.ks"  target="*tendo_namechange"  ]
[call  storage="tendo.ks"  target="*show"  ]
[call  storage="tendo.ks"  target="*show_jinro"  ]
[tb_start_tyrano_code]
#天堂
([emb exp="f.name"]は咎人のようだ)[p]
[_tb_end_tyrano_code]

[return  ]
*cover

[tb_start_text mode=1 ]
「誰なら信じれるか？神の目には明白だがな」[p]
[_tb_end_text]

[jump  storage="cover.ks"  target="*cover"  ]
*cover2

[call  storage="tendo.ks"  target="*show"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[call  storage="tendo.ks"  target="*tendo_namechange"  ]
[tb_start_tyrano_code]
#天堂
「[emb exp="f.name"]は恐らく善人であろう」[p]
[_tb_end_tyrano_code]

[jump  storage="cover.ks"  target="*show"  ]
*vote

[mask_off  time="500"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
#天堂
「投票の時間だな」[p]
「誰に投票するか決まってるのか？」[p]
[_tb_end_text]

[jump  storage="vote.ks"  target="*player_vote"  ]
*death

[call  storage="tendo.ks"  target="*show"  ]
[call  storage="tendo.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#天堂
「救えない、全く」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[jump  storage="system.ks"  target="*death"  ]
*CO

[call  storage="tendo.ks"  target="*show2"  ]
[call  storage="tendo.ks"  target="*CO2"  cond="f.role2=='co'"  ]
[call  storage="tendo.ks"  target="*tendo_namechange"  ]
[tb_start_text mode=1 ]
#天堂
「私が占い師だ。神託を受けよ、人の子よ」[p]
[_tb_end_text]

[tb_start_tyrano_code]
[emb exp="f.name"]は[emb exp="f.name2"]だ。[p]
[_tb_end_tyrano_code]

[return  ]
*CO2

[tb_start_text mode=1 ]
#天堂
「待つがいい」[p]
[_tb_end_text]

[return  ]
*CO3

[call  storage="tendo.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#天堂
「この中に嘘つきがいる。すぐに救ってやろう」[p]
[_tb_end_text]

[return  ]
*vsCO

[tb_start_text mode=1 ]
#天堂
「対抗するか？」[p]
[_tb_end_text]

[return  ]
*pCO

[call  storage="tendo.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#天堂
「どうせ最後には神に許しを乞うのだ。懺悔は早い方がいい。名乗りをあげよ」[p]
[_tb_end_text]

[return  ]
*s_human

[call  storage="tendo.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#天堂
「村人陣営だと言うがいい。神の目にはウソがはっきりと映るのだから」[p]
[_tb_end_text]

[return  ]
*human

[call  storage="tendo.ks"  target="*show"  ]
[call  storage="tendo.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#天堂
「神は当然村人陣営に味方をしている」[p]
[_tb_end_text]

[return  ]
*noisy

[call  storage="tendo.ks"  target="*show2"  ]
[call  storage="tendo.ks"  target="*tendo_namechange"  ]
[tb_start_tyrano_code]
#天堂
「[emb exp="f.name"]、少し口をつぐめ」[p]
「隠し事を持つ咎人はいつも多弁だ」[p]
[_tb_end_tyrano_code]

[return  ]
*push_act

[call  storage="tendo.ks"  target="*show2"  ]
[tb_start_tyrano_code]
#天堂
「[emb exp="f.name2"]、それは誤りだ」[p]
「でしゃばったな」[p]
[_tb_end_tyrano_code]

[jump  storage="observe.ks"  target="*observe"  ]
*jinro_win

[call  storage="tendo.ks"  target="*show2"  ]
[call  storage="tendo.ks"  target="*show_jinro"  ]
[tb_start_text mode=1 ]
#天堂
「神は嘘をつかないとでも思ったか？」[p]
「神は全能だ、ゲームで咎人を装うことも出来る」[p]
[_tb_end_text]

[return  ]
*human_win

[call  storage="tendo.ks"  target="*show2"  ]
[call  storage="tendo.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#天堂
「善人が勝つのは当然の摂理だ。神がついているのだからな」[p]
[_tb_end_text]

[return  ]
*win

[call  storage="tendo.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#天堂
「神様ごっこは楽しかったか？お前がどんな意思を持とうが、神は勝利する」[p]
「自分が勝たせたと驕らないように」[p]
「人の子は自分だけの力で生きているのではない。謙虚に生きよ、それではな」[p]
[_tb_end_text]

[return  ]
*win2

[call  storage="tendo.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#天堂
「神様ごっこは楽しかったか？お前がどんな意思を持とうが、神は勝利する」[p]
「自分が勝たせたと驕らないように」[p]
[_tb_end_text]

[mask  time="200"  effect="fadeIn"  color="0x000000"  ]
[call  storage="tendo.ks"  target="*show_jinro2"  ]
[mask_off  time="200"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
「ただし、あなたの人心掌握術は神が保証してやろう。精々励むといい」[p]
[_tb_end_text]

[return  ]
*lose

[call  storage="tendo.ks"  target="*show"  ]
[call  storage="tendo.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#天堂
「負けだ」[p]
「私はさして問題ない。神を指先で扱おうとした咎人への罰であるからな」[p]
「自分は他人を使う人間であるという驕りは捨てるがいい、わかったか？」[p]
「それではな」[p]
[_tb_end_text]

[return  ]
*stop

[call  storage="tendo.ks"  target="*show2"  ]
[call  storage="tendo.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#天堂
「人の子は人の子であろう、今更宣言させる意味もない」[p]
[_tb_end_text]

[return  ]
*stop2

[call  storage="tendo.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#天堂
「神に反抗するその姿勢こそ、咎人と言える」[p]
[_tb_end_text]

[return  ]
