[_tb_system_call storage=system/_kano.ks]

*kano_namechange

[iscript]
var nameMap={"真経津":"晨君","獅子神":"敬一君","村雨":"礼二君","天堂":"ユミピコ"};
if(nameMap[f.name]!==undefined)f.name=nameMap[f.name];
[endscript]

[return  ]
*show

[chara_hide_all  time="500"  wait="true"  ]
[chara_show  name="kano"  time="1000"  wait="true"  storage="chara/4/kano_normal.png"  width="320"  height="720"  ]
[return  ]
*show2

[chara_show  name="kano"  time="1000"  wait="true"  storage="chara/4/kano_normal.png"  width="320"  height="720"  ]
[return  ]
*show_normal

[jump  storage="kano.ks"  target="*show_normal2"  cond="f.kano_calm<25"  ]
[chara_mod  name="kano"  time="300"  cross="false"  storage="chara/4/kano_normal.png"  ]
[return  ]
*show_normal2

[chara_mod  name="kano"  time="300"  cross="false"  storage="chara/4/kano_normal_2.png"  ]
[return  ]
*show_ki

[chara_mod  name="kano"  time="300"  cross="false"  storage="chara/4/kano_ki.png"  ]
[return  ]
*show_do

[jump  storage="kano.ks"  target="*show_normal2"  cond="f.kano_calm<25"  ]
[chara_mod  name="kano"  time="300"  cross="false"  storage="chara/4/kano_do.png"  ]
[return  ]
*show_ai

[return  ]
*show_jinro

[chara_mod  name="kano"  time="300"  cross="false"  storage="chara/4/kano_insane.png"  ]
[return  ]
*show_jinro2

[chara_hide_all  time="0"  wait="true"  ]
[chara_show  name="kano"  time="1000"  wait="true"  storage="chara/4/kano_insane2.png"  width="400"  height="900"  left="430"  top="-40"  reflect="false"  ]
[return  ]
*day01_01

[call  storage="kano.ks"  target="*show"  ]
[call  storage="kano.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#叶
「観てんだろ？オマエ」[p]
「オレをゲームのキャラみたいに扱おうなんざ、いい度胸してんじゃん」[p]
「…」[p]

[_tb_end_text]

[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
「ま、いいよ」[p]
「晨君達の普段見れないような顔が観測出来そうだからな」[p]
[_tb_end_text]

[call  storage="kano.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
「精々そこでオレだけを観測してろ」[p]
「じゃあな、晨君達に会ってくるわ」[p]
[_tb_end_text]

[return  ]
*debate01

[call  storage="kano.ks"  target="*debate_Top"  ]
[call  storage="uranai.ks"  target="*game_start"  cond="f.role==3"  ]
[jump  storage="kano.ks"  target="*first"  cond="f.turn!=0"  ]
[tb_start_text mode=1 ]
#叶
「昼の議論ターンだぞ！」[p]
[_tb_end_text]

*first

[tb_start_text mode=1 ]
#叶
「どうすんだ？」[p]
[_tb_end_text]

[return  ]
*debate_Top

[chara_show  name="kano"  time="1000"  wait="true"  storage="chara/4/kano_normal.png"  width="320"  height="720"  left="700"  top=""  reflect="false"  ]
[call  storage="kano.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#叶
[_tb_end_text]

[return  ]
*kuro

[call  storage="kano.ks"  target="*show2"  ]
[call  storage="kano.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#叶
「オレを疑うとか観る目ないんじゃない？？？」[p]
[_tb_end_text]

[return  ]
*shiro

[call  storage="kano.ks"  target="*show2"  ]
[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#叶
「お！よく見てるな！１黎明ポイントゲットだ」[p]
[_tb_end_text]

[return  ]
*doubt

[tb_start_text mode=1 ]
「誰を疑うんだ？」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*doubt"  ]
*doubt2

[call  storage="kano.ks"  target="*show"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[call  storage="kano.ks"  target="*kano_namechange"  ]
[tb_start_tyrano_code]
#叶
「[emb exp="f.name"]が怪しいんだよなぁ」[p]
[_tb_end_tyrano_code]

[call  storage="kano.ks"  target="*push"  cond="f.win=='d1'"  ]
[call  storage="kano.ks"  target="*push2"  cond="f.win=='d2'"  ]
[call  storage="kano.ks"  target="*push3"  cond="f.win=='d3'"  ]
[jump  storage="doubt.ks"  target="*show"  ]
*push

[tb_start_text mode=1 ]
「ま、根拠はないんだがな。観測者の勘ってヤツだ」[p]
[_tb_end_text]

[return  ]
*push2

[tb_start_text mode=1 ]
「よく観測してみろよ、ボロ出すからさ」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*push3

[call  storage="kano.ks"  target="*show_ki"  ]
[call  storage="kano.ks"  target="*kano_namechange"  ]
[tb_start_tyrano_code]
「[emb exp="f.name"]は人狼、もうバレてんだよ」[p]
「で、これからどうするんだ？」[p]
[_tb_end_tyrano_code]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*liar

[call  storage="kano.ks"  target="*kano_namechange"  ]
[call  storage="kano.ks"  target="*show"  ]
[call  storage="kano.ks"  target="*show_jinro"  ]
[tb_start_tyrano_code]
#叶
(あ～あ、[emb exp="f.name"]は嘘つきだな)[p]
[_tb_end_tyrano_code]

[jump  storage="tutorial.ks"  target="*text2"  cond="f.tutorial==1"  ]
[return  ]
*cover

[tb_start_text mode=1 ]
「誰を信じるんだ？」[p]

[_tb_end_text]

[jump  storage="cover.ks"  target="*cover"  ]
*cover2

[call  storage="kano.ks"  target="*show"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[call  storage="kano.ks"  target="*kano_namechange"  ]
[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_tyrano_code]
#叶
「[emb exp="f.name"]は嘘つきじゃなさそうだ」[p]
[_tb_end_tyrano_code]

[jump  storage="cover.ks"  target="*show"  ]
*vote

[mask_off  time="500"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
#叶
「おっと、投票の時間だ」[p]
「誰に投票するんだ？」[p]
[_tb_end_text]

[jump  storage="vote.ks"  target="*player_vote"  ]
*death

[tb_eval  exp="f.kano_calm=100"  name="kano_calm"  cmd="="  op="t"  val="100"  val_2="undefined"  ]
[call  storage="kano.ks"  target="*show"  ]
[call  storage="kano.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#叶
「つまんね～！オレと遊んだ方が絶対楽しいって」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[jump  storage="system.ks"  target="*death"  ]
*CO

[call  storage="kano.ks"  target="*show2"  ]
[call  storage="kano.ks"  target="*CO2"  cond="f.role2=='co'"  ]
[call  storage="kano.ks"  target="*show_ki"  ]
[call  storage="kano.ks"  target="*kano_namechange"  ]
[tb_start_text mode=1 ]
#叶
「じゃーん！オレが占い師！」[p]
[_tb_end_text]

[tb_start_tyrano_code]
[emb exp="f.name"]を占ったぞ！結果は[emb exp="f.name2"]！[p]
[_tb_end_tyrano_code]

[return  ]
*CO2

[call  storage="kano.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#叶
「スト――ップ！」[p]
[_tb_end_text]

[return  ]
*CO3

[call  storage="kano.ks"  target="*show"  ]
[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#叶
「さぁて、誰が嘘つきだろうな」[p]
[_tb_end_text]

[return  ]
*vsCO

[tb_start_text mode=1 ]
#叶
「対抗しとく？」[p]
[_tb_end_text]

[return  ]
*pCO

[call  storage="kano.ks"  target="*show2"  ]
[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#叶
「占い師が名乗り出た方が面白くない？」[p]
[_tb_end_text]

[return  ]
*s_human

[call  storage="kano.ks"  target="*show2"  ]
[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#叶
「村人って言ってみてくれよ、それで嘘つきを探すからさ！」[p]
[_tb_end_text]

[return  ]
*human

[call  storage="kano.ks"  target="*show"  ]
[call  storage="kano.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#叶
「村人に決まってんじゃーん」[p]
[_tb_end_text]

[return  ]
*noisy

[call  storage="kano.ks"  target="*show2"  ]
[call  storage="kano.ks"  target="*show_ai"  ]
[call  storage="kano.ks"  target="*kano_namechange"  ]
[tb_start_tyrano_code]
#叶
「[emb exp="f.name"]、何オレより目立ってんだ？」[p]
「なんか目的があるとしか思えないよな」[p]
[_tb_end_tyrano_code]

[return  ]
*push_act

[call  storage="kano.ks"  target="*show2"  ]
[iscript]
var nameMap={"真経津":"晨君","獅子神":"敬一君","村雨":"礼二君","天堂":"ユミピコ"};
if(nameMap[f.name2]!==undefined) f.name2=nameMap[f.name2];
[endscript]

[tb_start_tyrano_code]
#叶
「[emb exp="f.name2"]、それはないんじゃね」[p]
「すべってんぞ～」[p]
[_tb_end_tyrano_code]

[jump  storage="observe.ks"  target="*observe"  ]
*jinro_win

[call  storage="kano.ks"  target="*show2"  ]
[call  storage="kano.ks"  target="*show_jinro"  ]
[tb_start_text mode=1 ]
#叶
「ざんねーん、オレ達が嘘つきでした！」[p]
「オマエらの観測眼もまだまだだな」[p]
[_tb_end_text]

[return  ]
*human_win

[call  storage="kano.ks"  target="*show2"  ]
[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#叶
「オレ達の勝利！悪い狼は退治してやったぞ！」[p]
[_tb_end_text]

[return  ]
*win

[call  storage="kano.ks"  target="*show"  ]
[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#叶
「オレが勝つとこ、きちんと観測してたか？」[p]
「特等席で見られて良かったな」[p]

[_tb_end_text]

[call  storage="kano.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
「だが、指図を受けんのは二度とゴメンだ。晨君達がいなかったら即帰ってたぞ。じゃあな」[p]
[_tb_end_text]

[return  ]
*win2

[call  storage="kano.ks"  target="*show"  ]
[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#叶
「オレが勝つとこ、きちんと観測してたか？」[p]
「特等席で見られて良かったな」[p]

[_tb_end_text]

[mask  time="200"  effect="fadeIn"  color="0x000000"  ]
[call  storage="kano.ks"  target="*show_jinro2"  ]
[mask_off  time="200"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
「オマエ、案外魅せるよね。次は賭場でもっと語り合おうな」[p]
[_tb_end_text]

[return  ]
*lose

[call  storage="kano.ks"  target="*show"  ]
[call  storage="kano.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#叶
「つまんねー、オマエのせいで負けたじゃん」[p]
「あ？オレが負けるところ観測したくてやってたのか？」[p]
「オマエ、悪趣味すぎ」[p]
「つきあってらんねぇーよ、二度とオレの世界に入ってくんな」[p]
[_tb_end_text]

[return  ]
*stop

[call  storage="kano.ks"  target="*show2"  ]
[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#叶
「そういうこと言う奴がむしろ怪しくない？」[p]
[_tb_end_text]

[return  ]
*stop2

[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#叶
「ふ～ん、人間って言ったら何か不都合があったんだな？」[p]
[_tb_end_text]

[return  ]
