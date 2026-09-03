[_tb_system_call storage=system/_shigure.ks]

*show

[iscript]
f.calm_low=parseFloat(String(f.calm).split(',')[5])<28?1:0;
[endscript]

[chara_hide_all  time="500"  wait="true"  ]
[chara_show  name="shigure"  time="1000"  wait="true"  storage="chara/7/shigure_normal.png"  width="320"  height="720"  ]
[return  ]
*show2

[iscript]
f.calm_low=parseFloat(String(f.calm).split(',')[5])<28?1:0;
[endscript]

[chara_show  name="shigure"  time="1000"  wait="true"  storage="chara/7/shigure_normal.png"  width="320"  height="720"  ]
[return  ]
*show_normal

[jump  storage="shigure.ks"  target="*show_normal2"  cond="f.calm_low==1"  ]
[chara_mod  name="shigure"  time="300"  cross="false"  storage="chara/7/shigure_normal.png"  ]
[return  ]
*show_normal2

[chara_mod  name="shigure"  time="300"  cross="false"  storage="chara/7/shigure_aseri.png"  ]
[return  ]
*show_ki

[chara_mod  name="shigure"  time="300"  cross="false"  storage="chara/7/shigure_normal.png"  ]
[return  ]
*show_do

[jump  storage="shigure.ks"  target="*show_normal2"  cond="f.calm_low==1"  ]
[chara_mod  name="shigure"  time="300"  cross="false"  storage="chara/7/shigure_aseri.png"  ]
[return  ]
*show_ai

[return  ]
*show_jinro

[chara_mod  name="shigure"  time="300"  cross="false"  storage="chara/7/shigure_normal.png"  ]
[return  ]
*show_jinro2

[chara_hide_all  time="0"  wait="true"  ]
[chara_show  name="shigure"  time="1000"  wait="true"  storage="chara/7/shigure_insane2.png"  width="400"  height="900"  left="430"  top="-40"  reflect="false"  ]
[return  ]
*day01_01

[call  storage="shigure.ks"  target="*show"  ]
[call  storage="shigure.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#時雨
「え、人狼ゲームですか？また何故に？」[p]
「……」[p]

[_tb_end_text]

[call  storage="shigure.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
「失敬、VIPの皆様との余興なのですね」[p]
「それに千晴君も一緒とのことで」[p]
[_tb_end_text]

[call  storage="shigure.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
「またぞろ何をしでかすかわかりませんし」[p]
[_tb_end_text]

[call  storage="shigure.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
「ちゃんと見ててあげませんとね」[p]
[_tb_end_text]

[return  ]
*debate01

[call  storage="shigure.ks"  target="*debate_Top"  ]
[jump  storage="shigure.ks"  target="*first"  cond="f.turn!=0"  ]
[tb_start_text mode=1 ]
#時雨
「昼の議論ターンらしいですよ」[p]
[_tb_end_text]

*first

[tb_start_text mode=1 ]
#時雨
「さて、どうします？」[p]
[_tb_end_text]

[return  ]
*debate_Top

[iscript]
f.calm_low=parseFloat(String(f.calm).split(',')[5])<28?1:0;
[endscript]

[chara_show  name="shigure"  time="1000"  wait="true"  storage="chara/6/shigure_normal.png"  width="320"  height="720"  left="700"  top=""  reflect="false"  ]
[call  storage="shigure.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#時雨
[_tb_end_text]

[return  ]
*kuro

[call  storage="shigure.ks"  target="*show2"  ]
[call  storage="shigure.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#時雨
「証拠もないのに、冤罪はよくありませんねぇ」[p]
[_tb_end_text]

[return  ]
*shiro

[call  storage="shigure.ks"  target="*show2"  ]
[call  storage="shigure.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#時雨
「我々になびいておくのは、いい判断ですよ」[p]
[_tb_end_text]

[return  ]
*doubt

[tb_start_text mode=1 ]
「誰を疑います？」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*doubt"  ]
*doubt2

[jump  storage="shigure.ks"  target="*add"  cond="f.display08=='add'"  ]
[call  storage="shigure.ks"  target="*show"  ]
*doubt3

[call  storage="shigure.ks"  target="*show_normal"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#時雨
「私は、[emb exp="f.name"]が怪しいと睨んでいます」[p]
[_tb_end_tyrano_code]

[call  storage="shigure.ks"  target="*push"  cond="f.win=='d1'"  ]
[call  storage="shigure.ks"  target="*push2"  cond="f.win=='d2'"  ]
[call  storage="shigure.ks"  target="*push3"  cond="f.win=='d3'"  ]
[jump  storage="doubt.ks"  target="*show"  ]
*push

[tb_start_text mode=1 ]
「刑事の勘ってヤツですかね。案外当たるんですよ」[p]
[_tb_end_text]

[return  ]
*push2

[tb_start_text mode=1 ]
「長年刑事をやっていれば、嘘つきくらいやすやすとわかるんですよ」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*push3

[call  storage="shigure.ks"  target="*show_ki"  ]
[tb_start_tyrano_code]
「[emb exp="f.name"]は人狼です。証拠は全て揃っています」[p]
「大人しくお縄につきましょうねぇ！」[p]
[_tb_end_tyrano_code]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*liar

[call  storage="shigure.ks"  target="*show"  ]
[call  storage="shigure.ks"  target="*show_jinro"  ]
[tb_start_tyrano_code]
#時雨
(あらら、[emb exp="f.name"]は嘘をついているみたいですね)[p]
[_tb_end_tyrano_code]

[return  ]
*cover

[tb_start_text mode=1 ]
「誰を味方につけておきます？」[p]
[_tb_end_text]

[jump  storage="cover.ks"  target="*cover"  ]
*cover2

[jump  storage="shigure.ks"  target="*add"  cond="f.display08=='add'"  ]
[chara_hide_all  time="0"  wait="true"  ]
[call  storage="shigure.ks"  target="*show"  ]
*cover3

[call  storage="shigure.ks"  target="*show_normal"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#時雨
「今のところ[emb exp="f.name"]は人間である可能性が高いでしょう」[p]
[_tb_end_tyrano_code]

[jump  storage="cover.ks"  target="*show"  ]
*vote

[mask_off  time="500"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
#時雨
「投票の時間のようです」[p]
「誰に投票しますか？」[p]
[_tb_end_text]

[jump  storage="vote.ks"  target="*player_vote"  ]
*death

[call  storage="shigure.ks"  target="*show"  ]
[call  storage="shigure.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#時雨
「警察に縄をかけるなんて、次は取調室で会いましょうね」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[jump  storage="system.ks"  target="*death"  ]
*CO

[call  storage="shigure.ks"  target="*show2"  ]
[call  storage="shigure.ks"  target="*CO2"  cond="f.role2=='co'"  ]
[call  storage="shigure.ks"  target="*show_ki"  ]
[jump  storage="shigure.ks"  target="*CO_day1"  cond="f.jump=='day1'"  ]
[tb_start_tyrano_code]
#時雨
「おっとすいません、私が[emb exp="f.display09"]です」[p]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[emb exp="f.name"]は[emb exp="f.name2"]なようです。[p]
[_tb_end_tyrano_code]

[return  ]
*CO_day1

[tb_start_text mode=1 ]
#時雨
「霊媒師は私ですけど、結果は明日のお楽しみですね」[p]
[_tb_end_text]

[return  ]
*CO2

[call  storage="shigure.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#時雨
「待ってください」[p]
[_tb_end_text]

[return  ]
*CO3

[call  storage="shigure.ks"  target="*show"  ]
[call  storage="shigure.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#時雨
「この中に嘘つきがいますねぇ」[p]
[_tb_end_text]

[return  ]
*vsCO

[tb_start_text mode=1 ]
#時雨
「対抗します？」[p]
[_tb_end_text]

[return  ]
*pCO

[call  storage="shigure.ks"  target="*show2"  ]
[call  storage="shigure.ks"  target="*show_normal"  ]
[tb_start_tyrano_code]
#時雨
「[emb exp="f.display09"]は素直に名乗りでた方がいいですよ」[p]
[_tb_end_tyrano_code]

[return  ]
*s_human

[call  storage="shigure.ks"  target="*show2"  ]
[call  storage="shigure.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#時雨
「人間だと言ってみてください。それで見分けます」[p]
[_tb_end_text]

[return  ]
*human

[call  storage="shigure.ks"  target="*show"  ]
[call  storage="shigure.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#時雨
「当然、村人ですが」[p]
[_tb_end_text]

[jump  storage="say_human.ks"  target="*say_human_reply"  ]
*noisy

[call  storage="shigure.ks"  target="*show2"  ]
[call  storage="shigure.ks"  target="*show_ai"  ]
[tb_start_tyrano_code]
#時雨
「[emb exp="f.name"]、騒々しいですよ」[p]
「嘘つき程、多弁になったりしますけどね」[p]
[_tb_end_tyrano_code]

[return  ]
*push_act

[call  storage="shigure.ks"  target="*show2"  ]
[tb_start_tyrano_code]
#時雨
「[emb exp="f.name2"]、それはおかしいのでは？」[p]
「少し黙ってください」[p]
[_tb_end_tyrano_code]

[jump  storage="observe.ks"  target="*observe"  ]
*jinro_win

[call  storage="shigure.ks"  target="*show2"  ]
[call  storage="shigure.ks"  target="*show_jinro"  ]
[tb_start_text mode=1 ]
#時雨
「私達が嘘つきでした。気付いていましたか？」[p]
「嘘つきの癖を知ってるからこそ、逆に隠すことも出来るんですよ」[p]
[_tb_end_text]

[return  ]
*human_win

[call  storage="shigure.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#時雨
「村人陣営の勝利、と。まぁ私達がいるんですから当然ですよね」[p]
[_tb_end_text]

[return  ]
*win

[call  storage="shigure.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#時雨
「さてさて、お楽しみいただけましたかね？」[p]
「私は千晴君がまたぞろやらかさないか冷や冷やしてましたが」[p]
「まぁ、全て杞憂に終わったんですけどね」[p]
「それでは、お暇させてもらいます」[p]
[_tb_end_text]

[return  ]
*win2

[call  storage="shigure.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#時雨
「さてさて、お楽しみいただけましたかね？」[p]
「私は千晴君がまたぞろやらかさないか冷や冷やしてましたが」[p]

[_tb_end_text]

[mask  time="200"  effect="fadeIn"  color="0x000000"  ]
[call  storage="shigure.ks"  target="*show_jinro2"  ]
[mask_off  time="200"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
「むしろあなたの才能にヒヤッとさせられましたよ」[p]
[_tb_end_text]

[return  ]
*lose

[call  storage="shigure.ks"  target="*show"  ]
[call  storage="shigure.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#時雨
「負けてしまいました。申し訳ございません」[p]
「さすがに暴れ馬をコントロールするのは、千晴君1人で精いっぱいみたいです」[p]
「ふふ、これ以上昇進したくないものですね」[p]
「それでは」[p]
[_tb_end_text]

[return  ]
*stop

[call  storage="shigure.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#時雨
「声掛け側は人間と言わないのでしょう？怪しいですねぇ」[p]
[_tb_end_text]

[return  ]
*stop2

[call  storage="shigure.ks"  target="*show2"  ]
[call  storage="shigure.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#時雨
「止めた方がよっぽど怪しいって思いません？」[p]
[_tb_end_text]

[return  ]
*add

[call  storage="shigure.ks"  target="*show2"  ]
[call  storage="shigure.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#時雨
「私からも一言よろしいですか」[p]
[_tb_end_text]

[jump  storage="shigure.ks"  target="*doubt3"  cond="f.jump=='doubt'"  ]
[jump  storage="shigure.ks"  target="*cover3"  ]
