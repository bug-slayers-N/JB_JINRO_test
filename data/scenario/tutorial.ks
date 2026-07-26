[_tb_system_call storage=system/_tutorial.ks]

[tb_show_message_window  ]
*init

[iscript]
// 役職
f.character = "10,9,1,16,15";
f.player = 4;
f.role = 16;
// 進行
f.day = 1;
f.turn = 6;
f.win = 0;
f.player_death = 0;
f.say_human = 0;
f.action = 0;
f.tutorial = 1;
// 平常心
f.calm = "100,80,-30,100,130";
// like
f.like = "10,0,0,0,30,0,0,0,30,0,0,0,10,0,0,0,10,0,0,0";
// liar
f.liar = "1,1,5,5,0,0,5,5,0,1,5,5,0,1,0,5,0,1,0,5";
// alive
f.alive = "1,1,1,1,1";
// CO：真経津・獅子神・村雨がCO済み
f.co = "1,1,1,0,0";
// claim：真経津→獅子神を人間、獅子神→天堂を人狼、村雨→叶を人間
f.claim = "2,0,5,1,4,0,0,0,0,0";
f.claim2 = "0,0,0,0,0,0,0,0,0,0";
// seer_result：真経津が獅子神を人間と占った
f.seer_result1 = "2,0";
f.seer_result2 = "0,0";
// 投票関連
f.votes = "0,0,0,0,0";
f.revote = 0;
f.display01 = "";
f.display02 = "";
f.display03 = "";
f.display04 = "";
f.display05 = "";
f.calm_low = 0;
[endscript]

[bg  time="1000"  method="crossfade"  storage="93853245_p0.png"  ]
[chara_show  name="suo"  time="1000"  wait="true"  storage="chara/6/suo_egao.png"  width="320"  height="720"  ]
[tb_start_text mode=1 ]
#周防
「実際にゲームを開始する前の様子確認」[p]
「いわゆる八百長試合でございます」[p]
「見破りを得意としているキャラで環境を整えておりますので、勝利の流れをご確認ください」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[call  storage="debate.ks"  target="*check"  ]
*text

[chara_show  name="kano"  time="1000"  wait="true"  storage="chara/4/kano_normal.png"  width="320"  height="720"  left="700"  top=""  reflect="false"  ]
[tb_start_text mode=1 ]
#叶
「状況確認の通り、敬一君(獅子神)は嘘つきで確定だ」[p]
「嘘がつけるのは人狼と狂人だけだから、占い師COが3人いる時点で残りのオレ(叶)とユミピコ(天堂)は村人確定」[p]

[_tb_end_text]

[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
「なのに敬一君はユミピコを人狼って報告してるから嘘つきな訳だな」[p]
「で」[p]
「晨君(真経津)と礼二君(村雨)がどっちがホンモノかはわかってない」[p]
「ここは1回、礼二君を疑ってみるか」[p]
[_tb_end_text]

[call  storage="UI.ks"  target="*myrole"  ]
[jump  storage="debate.ks"  target="*debate_top"  ]
*text2

[tb_start_text mode=1 ]
「礼二君がニセモノの占い師だったみたいだ」[p]
「つまりホンモノは晨君。晨君が敬一君を人間って報告してるから、敬一君は狂人」[p]
「人狼は礼二君で確定な訳だ」[p]
「あとは礼二君を沢山疑って、みんなにも人狼って気づいてもらわないとな」[p]
[_tb_end_text]

[jump  storage="end.ks"  target="*turn_set"  ]
*text3

[chara_hide_all  time="1000"  wait="true"  ]
[chara_show  name="suo"  time="1000"  wait="true"  storage="chara/6/suo_normal.png"  width="320"  height="720"  ]
[tb_start_text mode=1 ]
#周防
「さすがでございます」[p]
「村人陣営は無事に勝利を納めました」[p]
「見破りは観察力の高さと相手の平常心の低さに依存します」[p]
「観察力の高いキャラを選んだり、怪しい者を積極的に疑って平常心を下げましょう」[p]
[_tb_end_text]

[chara_mod  name="suo"  time="300"  cross="false"  storage="chara/6/suo_egao.png"  ]
[tb_start_text mode=1 ]
「勿論、見破りに依存せずに皆様の知恵で戦っていただいても構いません」[p]
「お好きな戦い方でお楽しみください」[p]
「それでは」[p]
[_tb_end_text]

[mask  time="300"  effect="fadeIn"  color="0x000000"  ]
[bg  time="0"  method="crossfade"  storage="92690259_p0.png"  ]
[chara_hide_all  time="0"  wait="true"  ]
[tb_eval  exp="f.tutorial=0"  name="tutorial"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_hide_message_window  ]
[mask_off  time="300"  effect="fadeOut"  ]
[jump  storage="role.ks"  target=""  ]
