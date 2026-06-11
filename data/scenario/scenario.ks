[_tb_system_call storage=system/_scenario.ks]

[cm  ]
*day01

[mask  time="1000"  effect="fadeIn"  color="0x000000"  ]
[bg  time="1000"  method="crossfade"  storage="92690259_p0.png"  ]
[chara_hide_all  time="0"  wait="true"  ]
[tb_show_message_window  ]
[mask_off  time="1000"  effect="fadeOut"  ]
[glink  color="btn_05_red"  storage="scenario.ks"  size="20"  target="*day01_01"  text="シナリオを見る"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[glink  color="btn_05_white"  storage="scenario.ks"  size="20"  target="*day01_03"  text="シナリオをとばす"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[s  ]
*day01_01

[call  storage="mafutsu.ks"  target="*day01_01"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*day01_01"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*day01_01"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*day01_01"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*day01_01"  cond="f.player==5"  ]
[mask  time="300"  effect="fadeIn"  color="0x000000"  ]
[chara_hide_all  time="0"  wait="false"  ]
[tb_image_hide  time="0"  ]
[tb_ptext_hide  time="0"  ]
[mask_off  time="300"  effect="fadeOut"  ]
*day01_02

[call  storage="mafutsu.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#真経津
「やっぱりみんなも呼ばれてたんだね～」[p]
[_tb_end_text]

[call  storage="sisigami.ks"  target="*show2"  ]
[call  storage="sisigami.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#獅子神
「なんなんだよ、このゲーム…」[p]
[_tb_end_text]

[call  storage="murasame.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#村雨
「銀行もVIPもよほど暇と見える」[p]
[_tb_end_text]

[call  storage="kano.ks"  target="*show"  ]
[call  storage="kano.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#叶
「晨君達が相手じゃなかったら、こんなクソゲーすぐ帰ってたぞ」[p]
[_tb_end_text]

[call  storage="tendo.ks"  target="*show2"  ]
[call  storage="tendo.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#天堂
「どんな条件であれ、私が勝つということに変わりはない」[p]

[_tb_end_text]

[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#叶
「画面の向こう側にいる奴を相手するんだから、オレこそ負ける要素がないんだよね」[p]
[_tb_end_text]

[call  storage="sisigami.ks"  target="*show"  ]
[call  storage="sisigami.ks"  target="*show_gimon"  ]
[tb_start_text mode=1 ]
#獅子神
「そもそも村人陣営と人狼陣営の勝負なんだから、チーム戦じゃねぇのか…？」[p]
[_tb_end_text]

[call  storage="murasame.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#村雨
「己の手で陣営を勝利させるという意味だろう。全く、自我が肥大しすぎている」[p]
「獅子神の言う通り、これはチーム戦だぞ」[p]

[_tb_end_text]

[call  storage="mafutsu.ks"  target="*show"  ]
[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_text mode=1 ]
#真経津
「なんでもいいからさっさとはじめよ～！」[p]
[_tb_end_text]

*day01_03

[jump  storage="debate.ks"  target=""  ]
*morning

[mask  time="300"  effect="fadeIn"  color="0x000000"  ]
[bg  time="0"  method="crossfade"  storage="93853245_p0.png"  ]
[tb_show_message_window  ]
[mask_off  time="300"  effect="fadeOut"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[tb_start_text mode=1 ]
#システム
昨夜、[emb exp="f.name"]が襲撃されました。[p]

[_tb_end_text]

[iscript]
var names=["真経津","獅子神","村雨","叶","天堂"];
var aliveArr=String(f.alive).split(",");
var aliveNames=[];
for(var i=0;i<5;i++){
if(aliveArr[i]==="1")aliveNames.push(names[i]);
}
f.vote_disp1=aliveNames.join("、");
[endscript]

[tb_start_text mode=1 ]
残りの生存者は[emb exp="f.vote_disp1"]です。[p]
2日目を開始します。[p]
[_tb_end_text]

[iscript]
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
var playerNum=parseInt(f.player);
var playerRole=parseInt(f.role);
var found=false;
for(var i=1;i<=5;i++){
if(i===playerNum&&playerRole!==3) continue;
if(coArr[i-1]!=="1") continue;
var role=parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][i-1]);
if(role!==3) continue;
if(aliveArr[i-1]==="1"){found=true;break;}
}
f.jump=found?"":"nothing";
[endscript]

[jump  storage="scenario.ks"  target="*nothing"  cond="f.jump=='nothing'"  ]
[tb_start_text mode=1 ]
占い師からは下記の報告がありました。[p]
[_tb_end_text]

[iscript]
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
var seerNum=0;
for(var i=1;i<=5;i++){if(roles[i-1]===3){seerNum=i;break;}}
var sr2=String(f.seer_result2).split(",");
var claim2=String(f.claim2).split(",");
var idx=(seerNum-1)*2;
claim2[idx]=sr2[0];
claim2[idx+1]=sr2[1];
f.claim2=claim2.join(",");
[endscript]

[iscript]
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function isCO(c){return String(f.co).split(',')[c-1]==='1';}
var charNames=["真経津","獅子神","村雨","叶","天堂"];
var claim2arr=String(f.claim2).split(',');
var disps=["","","","",""];
var idx=0;
for(var i=1;i<=5;i++){
if(isAlive(i)&&isCO(i)){
var tgt=parseInt(claim2arr[(i-1)*2]);
var res=parseInt(claim2arr[(i-1)*2+1]);
if(tgt!==0){
var reporter=charNames[i-1];
var target=charNames[tgt-1];
var result=res===1?"人狼":"人間";
disps[idx]=reporter+"は"+target+"を"+result+"と報告しました。";
idx++;
}
}
}
f.vote_disp1=disps[0];
f.vote_disp2=disps[1];
f.vote_disp3=disps[2];
f.vote_disp4=disps[3];
f.vote_disp5=disps[4];
[endscript]

[tb_start_text mode=1 ]
[emb exp="f.vote_disp1"]  [emb exp="f.vote_disp2"]  [emb exp="f.vote_disp3"]  [emb exp="f.vote_disp4"]  [emb exp="f.vote_disp5"][p]
[_tb_end_text]

*nothing

[tb_eval  exp="f.jump=0"  name="jump"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="end.ks"  target="*turn_set"  ]
*jinro_win

[iscript]
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
for(var i=1;i<=5;i++){
if(roles[i-1]===1){f.target=i;break;}
}
[endscript]

[call  storage="mafutsu.ks"  target="*jinro_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*jinro_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*jinro_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*jinro_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*jinro_win"  cond="f.target==5"  ]
[iscript]
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
for(var i=1;i<=5;i++){
if(roles[i-1]===2){f.target=i;break;}
}
[endscript]

[call  storage="mafutsu.ks"  target="*jinro_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*jinro_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*jinro_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*jinro_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*jinro_win"  cond="f.target==5"  ]
[jump  storage="scenario.ks"  target="*game_end"  ]
*human_win

[iscript]
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
for(var i=1;i<=5;i++){
if(roles[i-1]===3){f.target=i;break;}
}
[endscript]

[call  storage="mafutsu.ks"  target="*human_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*human_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*human_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*human_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*human_win"  cond="f.target==5"  ]
[iscript]
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
for(var i=1;i<=5;i++){
if(roles[i-1]===4){f.target=i;break;}
}
[endscript]

[call  storage="mafutsu.ks"  target="*human_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*human_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*human_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*human_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*human_win"  cond="f.target==5"  ]
[iscript]
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
for(var i=1;i<=5;i++){
if(roles[i-1]===5){f.target=i;break;}
}
[endscript]

[call  storage="mafutsu.ks"  target="*human_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*human_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*human_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*human_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*human_win"  cond="f.target==5"  ]
*game_end

[jump  storage="tutorial.ks"  target="*text3"  cond="f.tutorial==1"  ]
*win

[iscript]
var role=parseInt(f.role);
var win=parseInt(f.win);
if(win===1&&role>=3&&role<=5){f.win=0;}
else if(win===2&&role>=1&&role<=2){f.win=0;}
else{f.win=1;}
[endscript]

[jump  storage="scenario.ks"  target="*lose"  cond="f.win!=0"  ]
[jump  storage="scenario.ks"  target="*win2"  cond="f.list=='win2'"  ]
[call  storage="mafutsu.ks"  target="*win"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*win"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*win"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*win"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*win"  cond="f.player==5"  ]
[jump  storage="scenario.ks"  target="*game_end2"  ]
*lose

[call  storage="mafutsu.ks"  target="*lose"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*lose"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*lose"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*lose"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*lose"  cond="f.player==5"  ]
[jump  storage="scenario.ks"  target="*game_end2"  ]
*win2

[call  storage="mafutsu.ks"  target="*win2"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*win2"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*win2"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*win2"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*win2"  cond="f.player==5"  ]
*game_end2

[chara_hide_all  time="1000"  wait="true"  ]
[chara_show  name="suo"  time="1000"  wait="true"  storage="chara/6/suo_normal.png"  width="320"  height="720"  ]
[tb_start_text mode=1 ]
#周防
「お疲れ様でした」[p]
「ジャンケット人狼ゲーム、お楽しみいただけましたでしょうか？」[p]
「特定条件を満たすと、おまけの彼らの様子が見れるようです」[p]
「是非チャレンジしてみてくださいませ」[p]

[_tb_end_text]

[chara_mod  name="suo"  time="300"  cross="false"  storage="chara/6/suo_egao.png"  ]
[tb_start_text mode=1 ]
「それでは、またのお越しをお待ちしております」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[tb_hide_message_window  ]
[glink  color="btn_05_white"  storage="title_screen.ks"  size="20"  text="・&nbsp;タイトルへ&nbsp;・"  x="100"  y="100"  width=""  height=""  _clickable_img=""  autopos="true"  ]
[glink  color="btn_05_red"  storage="role.ks"  size="20"  text="・　連戦する　・"  x="94"  y="172"  width=""  height=""  _clickable_img=""  autopos="true"  ]
[glink  color="btn_05_blue"  storage="scenario.ks"  size="20"  text="・Xで結果を共有・"  target="*X"  x="87"  y="246"  width=""  height=""  _clickable_img=""  autopos="true"  ]
[s  ]
[mask  time="1000"  effect="fadeIn"  color="0x000000"  ]
*X

[iscript]
var charNames = ["真経津","獅子神","村雨","叶","天堂"];
var roleNames = ["","人狼","狂人","占い師","村人","村人"];
var charName = charNames[parseInt(f.player)-1];
var roleName = roleNames[parseInt(f.role)];
var isWin = parseInt(f.win)===0;
var result = isWin ? "勝利" : "敗北";
var text = "【非公式】"+charName+"("+roleName+")で"+result+"しました。フレンズ達の人狼ゲームで嘘つきを見破ろう！→https://bug-slayers-N.github.io/JB_JINRO/";
window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(text));
[endscript]

[jump  storage="title_screen.ks"  target=""  ]
