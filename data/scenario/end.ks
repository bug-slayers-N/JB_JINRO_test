[_tb_system_call storage=system/_end.ks]

*turn_set

[mask  time="300"  effect="fadeIn"  color="0x000000"  ]
[chara_hide_all  time="0"  wait="true"  ]
[call  storage="mafutsu.ks"  target="*debate_Top"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*debate_Top"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*debate_Top"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*debate_Top"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*debate_Top"  cond="f.player==5"  ]
*turn_count

[tb_eval  exp="f.jump=0"  name="jump"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_eval  exp="f.win=0"  name="win"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[iscript]
var day=parseInt(f.day);
var turn=parseInt(f.turn);
if(day===1&&turn>=10){f.result="vote";}
else if(day>=2&&turn>=5){f.result="vote";}
[endscript]

[jump  storage="end.ks"  target="*turn_reset"  cond="f.result!='vote'"  ]
[tb_eval  exp="f.turn=0"  name="turn"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_eval  exp="f.day+=1"  name="day"  cmd="+="  op="t"  val="1"  val_2="undefined"  ]
[tb_eval  exp="f.action=0"  name="action"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="vote.ks"  target="*player_vote_end"  cond="f.player_death==1"  ]
[jump  storage="mafutsu.ks"  target="*vote"  cond="f.player==1"  ]
[jump  storage="sisigami.ks"  target="*vote"  cond="f.player==2"  ]
[jump  storage="murasame.ks"  target="*vote"  cond="f.player==3"  ]
[jump  storage="kano.ks"  target="*vote"  cond="f.player==4"  ]
[jump  storage="tendo.ks"  target="*vote"  cond="f.player==5"  ]
*turn_reset

[tb_eval  exp="f.turn+=1"  name="turn"  cmd="+="  op="t"  val="1"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*myrole"  ]
[mask_off  time="300"  effect="fadeOut"  ]
[jump  storage="debate.ks"  target="*debate_top"  ]
*game_set

[call  storage="end.ks"  target="*omake"  cond="f.tutorial!=1"  ]
[tb_show_message_window  ]
[bg  time="1000"  method="crossfade"  storage="92690259_p0.png"  ]
[iscript]
f.vote_disp2=f.win===1?"村人陣営の勝利です。":"人狼陣営の勝利です。";
[endscript]

[tb_start_text mode=1 ]
#システム
[emb exp="f.vote_disp2"][p]
今回の役職は[p]
[_tb_end_text]

[iscript]
var names=["真経津","獅子神","村雨","叶","天堂"];
var roleNames=["","人狼","狂人","占い師","村人","村人"];
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
var lines=["","","","",""];
for(var i=0;i<5;i++){
lines[i]=names[i]+"："+roleNames[roles[i]];
}
f.vote_disp1=lines[0];
f.vote_disp2=lines[1];
f.vote_disp3=lines[2];
f.vote_disp4=lines[3];
f.vote_disp5=lines[4];
[endscript]

[tb_start_text mode=1 ]
#システム
[emb exp="f.vote_disp1"]、[emb exp="f.vote_disp2"]、[emb exp="f.vote_disp3"]、[emb exp="f.vote_disp4"]、[emb exp="f.vote_disp5"]でした[p]

[_tb_end_text]

[iscript]
f.mafutsu_calm=100;
f.sisigami_calm=80;
f.murasame_calm=110;
f.kano_calm=100;
f.tendo_calm=120;
[endscript]

[jump  storage="scenario.ks"  target="*jinro_win"  cond="f.win==2"  ]
[jump  storage="scenario.ks"  target="*human_win"  cond="f.win==1"  ]
*player_death

[tb_eval  exp="f.player_death=1"  name="player_death"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#システム
あなたのギャンブラーが死亡しました。[p]
ゲームを最後まで観戦しますか？ここで終了しますか？[p]
[_tb_end_text]

[glink  color="black"  storage="end.ks"  size="20"  text="観戦モード"  autopos="true"  target="*continue"  ]
[glink  color="black"  storage="end.ks"  size="20"  text="終了"  autopos="true"  target="*end"  ]
[s  ]
*continue

[tb_start_text mode=1 ]
様子を見るボタンのみ活性化します。様子をお楽しみください。[p]
[_tb_end_text]

[return  ]
*end

[bg  time="1000"  method="crossfade"  storage="92690259_p0.png"  ]
[jump  storage="scenario.ks"  target="*lose"  ]
*omake

[iscript]
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
var aliveArr=String(f.alive).split(",");
var playerRole=roles[parseInt(f.player)-1];
if(playerRole===1){
var survivors=[];
for(var i=0;i<5;i++){
if(aliveArr[i]==="1")survivors.push(roles[i]);
}
if(survivors.length===2&&survivors.indexOf(1)!==-1&&survivors.indexOf(2)!==-1){
f.list='win2';
}
}
[endscript]

[iscript]
function getRole(i){return parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][i-1]);}
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function isCO(c){return String(f.co).split(',')[c-1]==='1';}
var p=parseInt(f.player),r=parseInt(f.role),w=parseInt(f.win);
var ac=String(f.alive).split(',').filter(function(v){return v==='1';}).length;
var pd=isAlive(p);
if(p===1){
if(r===1&&w===2)sf.ma_s01=1;
if(r>=3&&ac===4&&w===1)sf.ma_s02=1;
if(r===1&&isCO(1)&&w===2)sf.ma_s03=1;
}
if(p===2&&(r===4||r===5)&&w===1){
sf.si_s01=1;
if(pd)sf.si_s02=1;
if(ac===4)sf.si_s03=1;
}
if(p===3){
if(r===3&&w===1){sf.mu_s01=1;if(pd)sf.mu_s02=1;}
if(r===1&&isAlive(3)){for(var i=1;i<=5;i++){if(getRole(i)===2&&isAlive(i)){sf.mu_s03=1;break;}}}
}
if(p===4){
if(r===2&&w===2){sf.ka_s01=1;if(pd)sf.ka_s02=1;}
if(r>=3&&r<=5&&ac===4&&parseInt(f.action)<3)sf.ka_s03=1;
}
if(p===5){
var wc=(r<=2&&w===2)||(r>=3&&w===1);
if(wc&&isCO(5)){sf.te_s01=1;if(pd)sf.te_s02=1;}
if(r===3&&w===1&&pd)sf.te_s03=1;
}
[endscript]

[return  ]
