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

[chara_mod  name="yamabuki"  time="300"  cross="false"  storage="chara/8/yamabuki_aseri.png"  ]
[return  ]
*show_ki

[chara_mod  name="yamabuki"  time="300"  cross="false"  storage="chara/8/yamabuki_normal.png"  ]
[return  ]
*show_do

[jump  storage="yamabuki.ks"  target="*show_normal2"  cond="f.calm_low==1"  ]
[chara_mod  name="yamabuki"  time="300"  cross="false"  storage="chara/8/yamabuki_aseri.png"  ]
[return  ]
*show_ai

[return  ]
*show_jinro

[chara_mod  name="yamabuki"  time="300"  cross="false"  storage="chara/8/yamabuki_normal.png"  ]
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
「はぁ？人狼ゲームゥ？なんでそんなもん参加しねぇーといけないんだ？」[p]
「え、相棒もいんの？」[p]
「あ～、それなら行くか」[p]
[_tb_end_text]

[call  storage="yamabuki.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
「まぁ、暇つぶしにはなんだろ」[p]
[_tb_end_text]

[return  ]
*debate01

[call  storage="yamabuki.ks"  target="*debate_Top"  ]
[jump  storage="yamabuki.ks"  target="*first"  cond="f.turn!=0"  ]
[tb_start_text mode=1 ]
#山吹
「議論ターンはじまってんぞ」[p]
[_tb_end_text]

*first

[tb_start_text mode=1 ]
#山吹
「あんたはどうすんだ？」[p]
[_tb_end_text]

[return  ]
*debate_Top

[iscript]
f.calm_low=parseFloat(String(f.calm).split(',')[6])<23?1:0;
[endscript]

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
「証拠も無しに疑うなんてひでーな。まるで悪人だ」[p]
[_tb_end_text]

[return  ]
*shiro

[call  storage="yamabuki.ks"  target="*show2"  ]
[call  storage="yamabuki.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#山吹
「もっとそう言ってくれてもいいんだぜ」[p]
[_tb_end_text]

[return  ]
*doubt

[tb_start_text mode=1 ]
「誰を疑うんだ？」[p]
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
「[emb exp="f.name"]が怪し～んだよな」[p]
[_tb_end_tyrano_code]

[call  storage="yamabuki.ks"  target="*push"  cond="f.win=='d1'"  ]
[call  storage="yamabuki.ks"  target="*push2"  cond="f.win=='d2'"  ]
[call  storage="yamabuki.ks"  target="*push3"  cond="f.win=='d3'"  ]
[jump  storage="doubt.ks"  target="*show"  ]
*push

[tb_start_text mode=1 ]
「ま、刑事の勘ってヤツ？」[p]
[_tb_end_text]

[return  ]
*push2

[tb_start_text mode=1 ]
「お前が嘘つきだってもうバレってから。刑事の取り調べ舐めんなよ」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*push3

[call  storage="yamabuki.ks"  target="*show_ki"  ]
[tb_start_tyrano_code]
「[emb exp="f.name"]は人狼、それ以外にありえねぇーんだよ」[p]
「悪人は黙ってボコられてな」[p]
[_tb_end_tyrano_code]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*liar

[call  storage="yamabuki.ks"  target="*show"  ]
[call  storage="yamabuki.ks"  target="*show_jinro"  ]
[tb_start_tyrano_code]
#山吹
(あ～、[emb exp="f.name"]は嘘つきだな)[p]
[_tb_end_tyrano_code]

[return  ]
*cover

[tb_start_text mode=1 ]
「誰なら信じれんだ？」[p]
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
「[emb exp="f.name"]は限りなくシロだと思うぜ～」[p]
[_tb_end_tyrano_code]

[jump  storage="cover.ks"  target="*show"  ]
*vote

[mask_off  time="500"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
#山吹
「投票の時間だ」[p]
「誰に投票する？」[p]
[_tb_end_text]

[jump  storage="vote.ks"  target="*player_vote"  ]
*death

[call  storage="yamabuki.ks"  target="*show"  ]
[call  storage="yamabuki.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#山吹
「ざけんな！そのニヤけ面のまま帰れると思うなよ！」[p]
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
「俺が[emb exp="f.display09"]だぜ」[p]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[emb exp="f.name"]は[emb exp="f.name2"]、だ。よく覚えとけよ。[p]
[_tb_end_tyrano_code]

[return  ]
*CO_day1

[tb_start_text mode=1 ]
#山吹
「霊媒師はオレだけど、結果は明日のお楽しみだな」[p]
[_tb_end_text]

[return  ]
*CO2

[call  storage="yamabuki.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#山吹
「あ？」[p]
[_tb_end_text]

[return  ]
*CO3

[call  storage="yamabuki.ks"  target="*show"  ]
[call  storage="yamabuki.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#山吹
「この中に悪い奴がいんのか、楽しくなってきたな」[p]
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
「[emb exp="f.display09"]はとっと名乗り出ろよ」[p]
[_tb_end_tyrano_code]

[return  ]
*s_human

[call  storage="yamabuki.ks"  target="*show2"  ]
[call  storage="yamabuki.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#山吹
「村人だと宣言しろ、それで俺と相棒は見抜ける」[p]
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
「ぎゃーぎゃーうるせぇよ、[emb exp="f.name"]」[p]
「隠し事があるヤツは、いつもうるせぇーんだ」[p]
[_tb_end_tyrano_code]

[return  ]
*push_act

[call  storage="yamabuki.ks"  target="*show2"  ]
[tb_start_tyrano_code]
#山吹
「ちげーだろ、[emb exp="f.name2"]」[p]
「少し黙っとけ」[p]
[_tb_end_tyrano_code]

[jump  storage="observe.ks"  target="*observe"  ]
*jinro_win

[call  storage="yamabuki.ks"  target="*show2"  ]
[call  storage="yamabuki.ks"  target="*show_jinro"  ]
[tb_start_text mode=1 ]
#山吹
「ざんねぇーん！ヒーローは嘘つかないと思ったか？」[p]
「悪い奴をボコれるなら、何やってもいいんだよ」[p]
[_tb_end_text]

[return  ]
*human_win

[call  storage="yamabuki.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#山吹
「正義は勝つ！村人陣営の勝利だ」[p]
[_tb_end_text]

[return  ]
*win

[call  storage="yamabuki.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#山吹
「ヒーローが勝つのは当然だろォ？」[p]
「もっと賞賛してくれていいんだぜ？」[p]
「それじゃ、エンタメショーはこれで終わりだ」[p]
「あばよ」[p]
[_tb_end_text]

[return  ]
*win2

[call  storage="yamabuki.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#山吹
「ヒーローが勝つのは当然だろォ？」[p]
「もっと賞賛してくれていいんだぜ？」[p]
[_tb_end_text]

[mask  time="200"  effect="fadeIn"  color="0x000000"  ]
[call  storage="yamabuki.ks"  target="*show_jinro2"  ]
[mask_off  time="200"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
「ま、お前も悪くなかったぜ。いつでもこっち来いよ」[p]
[_tb_end_text]

[return  ]
*lose

[call  storage="yamabuki.ks"  target="*show"  ]
[call  storage="yamabuki.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#山吹
「チッ、負けかよ」[p]
「遊びだっつっても気分悪ィわ」[p]
「あ～あ、帰りに犯罪者でもぶん殴ってすっきりすっか」[p]
「じゃあな」[p]
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
「オレの話も聞けよ」[p]
[_tb_end_text]

[jump  storage="yamabuki.ks"  target="*doubt3"  cond="f.jump=='doubt'"  ]
[jump  storage="yamabuki.ks"  target="*cover3"  ]
