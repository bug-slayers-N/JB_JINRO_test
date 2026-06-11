[_tb_system_call storage=system/_mafutsu.ks]

*show

[chara_hide_all  time="0"  wait="true"  ]
[chara_show  name="mafutsu"  time="1000"  wait="true"  storage="chara/1/mafutsu_normal.png"  width="320"  height="720"  top="0"  ]
[return  ]
*show2

[chara_show  name="mafutsu"  time="1000"  wait="true"  storage="chara/1/mafutsu_normal.png"  width="320"  height="720"  ]
[return  ]
*show_normal

[jump  storage="mafutsu.ks"  target="*show_normal2"  cond="f.mafutsu_calm<25"  ]
[chara_mod  name="mafutsu"  time="300"  cross="false"  storage="chara/1/mafutsu_normal.png"  ]
[return  ]
*show_normal2

[chara_mod  name="mafutsu"  time="300"  cross="false"  storage="chara/1/mafutsu_normal_2.png"  ]
[return  ]
*show_raku

[chara_mod  name="mafutsu"  time="300"  cross="false"  storage="chara/1/mafutsu_raku.png"  ]
[return  ]
*show_do

[return  ]
*show_ai

[jump  storage="mafutsu.ks"  target="*show_normal2"  cond="f.mafutsu_calm<25"  ]
[chara_mod  name="mafutsu"  time="300"  cross="false"  storage="chara/1/mafutsu_ai.png"  ]
[return  ]
*show_jinro

[chara_mod  name="mafutsu"  time="300"  cross="false"  storage="chara/1/mafutsu_insane.png"  ]
[return  ]
*show_jinro2

[chara_hide_all  time="0"  wait="true"  ]
[chara_show  name="mafutsu"  time="1000"  wait="true"  storage="chara/1/mafutsu_insane2.png"  width="400"  height="900"  left="430"  top="-40"  reflect="false"  ]
[return  ]
*day01_01

[call  storage="mafutsu.ks"  target="*show"  ]
[call  storage="mafutsu.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#真経津
「エキシビションマッチって聞いてきたのに」[p]
「VIPの人と協力して普通の人狼ゲームかぁ…予想外」[p]
「ボクはVIPの人にアドバイス出来るだけで、ゲームの決定権はVIPの人なんだ」[p]
「うーん…」[p]
[_tb_end_text]

[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_text mode=1 ]
「まぁでも、みんなと遊べるなら十分楽しいかもね」[p]
「あ！もうみんな集まってる！」[p]
「早く会場に向かおう」[p]
[_tb_end_text]

[return  ]
*debate01

[call  storage="mafutsu.ks"  target="*debate_Top"  ]
[call  storage="uranai.ks"  target="*game_start"  cond="f.role==3"  ]
[jump  storage="mafutsu.ks"  target="*first"  cond="f.turn!=0"  ]
[tb_start_text mode=1 ]
#真経津
「昼の議論ターンだよ！」[p]
[_tb_end_text]

*first

[tb_start_text mode=1 ]
#真経津
「どうしよっか？」[p]
「わからない時は様子見が安牌かも」[p]
[_tb_end_text]

[return  ]
*debate_Top

[chara_show  name="mafutsu"  time="1000"  wait="true"  storage="chara/1/mafutsu_normal.png"  width="320"  height="720"  left="700"  top=""  reflect="false"  ]
[call  storage="mafutsu.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#真経津
[_tb_end_text]

[return  ]
*kuro

[call  storage="mafutsu.ks"  target="*show2"  ]
[call  storage="mafutsu.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#真経津
「ええ～！ボク！？」[p]
[_tb_end_text]

[return  ]
*shiro

[call  storage="mafutsu.ks"  target="*show2"  ]
[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_text mode=1 ]
#真経津
「ありがと～、素直に喜んでおくよ」[p]
[_tb_end_text]

[return  ]
*doubt

[tb_start_text mode=1 ]
「誰を疑おっか」[p]
「疑うと相手を動揺させられるけど、相手からボクへの好感度は下がるよ！」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*doubt"  ]
*doubt2

[call  storage="mafutsu.ks"  target="*show"  ]
[call  storage="mafutsu.ks"  target="*show_normal"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
「ボク、[emb exp="f.name"]さんが怪しいと思うな～」[p]
[_tb_end_tyrano_code]

[call  storage="mafutsu.ks"  target="*push"  cond="f.win=='d1'"  ]
[call  storage="mafutsu.ks"  target="*push2"  cond="f.win=='d2'"  ]
[call  storage="mafutsu.ks"  target="*push3"  cond="f.win=='d3'"  ]
[jump  storage="doubt.ks"  target="*show"  ]
*push

[tb_start_text mode=1 ]
「直感だけどね」[p]
[_tb_end_text]

[return  ]
*push2

[tb_start_text mode=1 ]
「声のトーン違くない？みんなもうちょっとよく見てみてよ」[p]
[_tb_end_text]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*push3

[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_tyrano_code]
「[emb exp="f.name"]さんは人狼、これはもう覆しようがない事実なんだ」[p]
「鏡の中に君を助ける答えはないよ」[p]
[_tb_end_tyrano_code]

[jump  storage="doubt.ks"  target="*push_act"  cond="f.result==1"  ]
[return  ]
*liar

[call  storage="mafutsu.ks"  target="*show"  ]
[call  storage="mafutsu.ks"  target="*show_jinro"  ]
[tb_start_tyrano_code]
#真経津
(ボクわかっちゃった、[emb exp="f.name"]さんは嘘つきだ)[p]
[_tb_end_tyrano_code]

[return  ]
*cover

[tb_start_text mode=1 ]
「誰なら信じれそう？」[p]
「かばうとかばわれた人の平常心とかばわれた人からボクへの好感度があがるよ。ただしボクの平常心が低いと逆効果になることもあるよ」[p]
[_tb_end_text]

[jump  storage="cover.ks"  target="*cover"  ]
*cover2

[call  storage="mafutsu.ks"  target="*show"  ]
[call  storage="mafutsu.ks"  target="*show_raku"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[tb_start_tyrano_code]
#真経津
「[emb exp="f.name"]さんは大丈夫なんじゃない？」[p]
[_tb_end_tyrano_code]

[jump  storage="cover.ks"  target="*show"  ]
*vote

[mask_off  time="500"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
#真経津
「あ、もう投票の時間だ」[p]
「誰に投票する？」[p]
[_tb_end_text]

[jump  storage="vote.ks"  target="*player_vote"  ]
*death

[tb_eval  exp="f.mafutsu_calm=100"  name="mafutsu_calm"  cmd="="  op="t"  val="100"  val_2="undefined"  ]
[call  storage="mafutsu.ks"  target="*show"  ]
[call  storage="mafutsu.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#真経津
「もう遊ぶのおしまいか～！残念」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[jump  storage="system.ks"  target="*death"  ]
*CO

[call  storage="mafutsu.ks"  target="*show2"  ]
[call  storage="mafutsu.ks"  target="*CO2"  cond="f.role2=='co'"  ]
[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_text mode=1 ]
#真経津
「はいはーい！ボクが占い師！」[p]
[_tb_end_text]

[tb_start_tyrano_code]
[emb exp="f.name"]さんを占ったよ！結果は[emb exp="f.name2"]！[p]
[_tb_end_tyrano_code]

[return  ]
*CO2

[call  storage="mafutsu.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#真経津
「ちょっと待ってよ！」[p]
[_tb_end_text]

[return  ]
*CO3

[call  storage="mafutsu.ks"  target="*show"  ]
[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_text mode=1 ]
#真経津
「誰が嘘つきなんだろうね？」[p]
[_tb_end_text]

[return  ]
*vsCO

[tb_start_text mode=1 ]
#真経津
対抗COする？[p]
[_tb_end_text]

[jump  storage="CO.ks"  target="*vsCO_back"  ]
*pCO

[call  storage="mafutsu.ks"  target="*show2"  ]
[call  storage="mafutsu.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#真経津
「そういえば占い師って誰なの～？」[p]
[_tb_end_text]

[chara_hide_all  time="0"  wait="true"  ]
[return  ]
*s_human

[call  storage="mafutsu.ks"  target="*show2"  ]
[call  storage="mafutsu.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#真経津
「ねぇねぇ、みんな自分は村人陣営ですって言ってみて！」[p]
[_tb_end_text]

[return  ]
*human

[call  storage="mafutsu.ks"  target="*show2"  ]
[call  storage="mafutsu.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#真経津
「もちろんボクは村人！」[p]
[_tb_end_text]

[return  ]
*noisy

[call  storage="mafutsu.ks"  target="*show2"  ]
[call  storage="mafutsu.ks"  target="*show_ai"  ]
[tb_start_tyrano_code]
#真経津
「[emb exp="f.name"]さん、ちょっとうるさいよ」[p]
「みんなを上手く誘導したいの？あやしいなぁ」[p]
[_tb_end_tyrano_code]

[return  ]
*push_act

[call  storage="mafutsu.ks"  target="*show2"  ]
[tb_start_tyrano_code]
#真経津
「[emb exp="f.name2"]さん、それは違うんじゃないかな？」[p]
「すべっちゃってるよ～」[p]
[_tb_end_tyrano_code]

[jump  storage="observe.ks"  target="*observe"  ]
*jinro_win

[call  storage="mafutsu.ks"  target="*show2"  ]
[call  storage="mafutsu.ks"  target="*show_jinro"  ]
[tb_start_text mode=1 ]
#真経津
「じゃーん、ボク達が嘘つきだよ！」[p]
「だまされた？」[p]
[_tb_end_text]

[return  ]
*human_win

[call  storage="mafutsu.ks"  target="*show2"  ]
[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_text mode=1 ]
#真経津
「ボク達人間の勝ち！村は平和になりました～！」[p]
[_tb_end_text]

[return  ]
*win

[call  storage="mafutsu.ks"  target="*show"  ]
[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_text mode=1 ]
#真経津
「VIPの人もおつかれ～！勝ててよかったね」[p]
「それとも、負けるところが見たかったのかな？」[p]
「なんでもいいや、それじゃ、またね」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[return  ]
*win2

[call  storage="mafutsu.ks"  target="*show"  ]
[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_text mode=1 ]
#真経津
「VIPの人もおつかれ～！勝ててよかったね」[p]
「それとも、負けるところが見たかったのかな？」[p]
「なんでもいいや」[p]
[_tb_end_text]

[mask  time="200"  effect="fadeIn"  color="0x000000"  ]
[call  storage="mafutsu.ks"  target="*show_jinro2"  ]
[mask_off  time="200"  effect="fadeOut"  ]
[tb_start_text mode=1 ]
「楽しいゲームだったよ、次は賭場で会いたいね」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[return  ]
*lose

[call  storage="mafutsu.ks"  target="*show"  ]
[call  storage="mafutsu.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#真経津
「負けちゃったね…」[p]
「みんな強いもんね！だからボクの友達なんだ」[p]

[_tb_end_text]

[call  storage="mafutsu.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
「それとも、もしかしてわざとなのかな？」[p]
「なんでもいいや、それじゃ、またね」[p]
[_tb_end_text]

[return  ]
*stop

[call  storage="mafutsu.ks"  target="*show2"  cond=""  ]
[tb_start_text mode=1 ]
#真経津
「案外そういうこと言う人が怪しかったりするよね～」[p]
[_tb_end_text]

[return  ]
*stop2

[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_text mode=1 ]
#真経津
「むしろ言わされると困っちゃうから止めたっても考えられるよね」[p]
[_tb_end_text]

[return  ]
