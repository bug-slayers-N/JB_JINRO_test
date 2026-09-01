[_tb_system_call storage=system/_end.ks]

*turn_set

[mask  time="300"  effect="fadeIn"  color="0x000000"  ]
[chara_hide_all  time="0"  wait="true"  ]
[call  storage="mafutsu.ks"  target="*debate_Top"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*debate_Top"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*debate_Top"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*debate_Top"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*debate_Top"  cond="f.player==5"  ]
[call  storage="shigure.ks"  target="*debate_Top"  cond="f.player==6"  ]
[call  storage="yamabuki.ks"  target="*debate_Top"  cond="f.player==7"  ]
[call  storage="gato.ks"  target="*debate_Top"  cond="f.player==8"  ]
[call  storage="urushibara.ks"  target="*debate_Top"  cond="f.player==9"  ]
*turn_count

[tb_eval  exp="f.jump=0"  name="jump"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_eval  exp="f.win=0"  name="win"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[iscript]
var day=parseInt(f.day);
var turn=parseInt(f.turn);
var mode=parseInt(f.gamemode);
var threshold;
if(day===1){
threshold=10;
}else if(day===2&&mode===9){
threshold=7;
}else{
threshold=5;
}
f.result = turn>=threshold ? 1 : 0;
[endscript]

[jump  storage="end.ks"  target="*turn_reset_end"  cond="f.result==0"  ]
[tb_eval  exp="f.turn=0"  name="turn"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_eval  exp="f.day+=1"  name="day"  cmd="+="  op="t"  val="1"  val_2="undefined"  ]
[tb_eval  exp="f.action=0"  name="action"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="vote.ks"  target="*player_vote_end"  cond="f.player_death==1"  ]
[jump  storage="mafutsu.ks"  target="*vote"  cond="f.player==1"  ]
[jump  storage="sisigami.ks"  target="*vote"  cond="f.player==2"  ]
[jump  storage="murasame.ks"  target="*vote"  cond="f.player==3"  ]
[jump  storage="kano.ks"  target="*vote"  cond="f.player==4"  ]
[jump  storage="tendo.ks"  target="*vote"  cond="f.player==5"  ]
[jump  storage="shigure.ks"  target="*vote"  cond="f.player==6"  ]
[jump  storage="yamabuki.ks"  target="*vote"  cond="f.player==7"  ]
[jump  storage="gato.ks"  target="*vote"  cond="f.player==8"  ]
[jump  storage="urushibara.ks"  target="*vote"  cond="f.player==9"  ]
*turn_reset_end

[tb_eval  exp="f.turn+=1"  name="turn"  cmd="+="  op="t"  val="1"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*myrole"  ]
[mask_off  time="300"  effect="fadeOut"  ]
[jump  storage="debate.ks"  target="*debate_top"  ]
*game_set

[call  storage="end.ks"  target="*omake"  cond="f.tutorial!=1"  ]
[tb_show_message_window  ]
[bg  time="1000"  method="crossfade"  storage="92690259_p0.png"  ]
[iscript]
f.display01=f.win===1?"村人陣営の勝利です。":"人狼陣営の勝利です。";
[endscript]

[tb_start_text mode=1 ]
#システム
[emb exp="f.display01"][p]
今回の役職は[p]
[_tb_end_text]

[iscript]
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var roleMap={1:"人狼",2:"人狼",3:"人狼",4:"人狼",5:"人狼",9:"狂人",10:"占い師",11:"霊媒師",12:"騎士",15:"村人",16:"村人",17:"村人"};
var n=parseInt(f.gamemode);
var charArr=String(f.character).split(",");
var lines=[];
for(var i=0;i<n;i++){
var role=parseInt(charArr[i]);
lines.push(names[i+1]+"："+(roleMap[role]||"不明"));
}
f.result=lines.join("、");
[endscript]

[tb_start_text mode=1 ]
#システム
[emb exp="f.result"]でした[p]

[_tb_end_text]

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
function getRole(i){return parseInt(String(f.character).split(',')[i-1]);}
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function isCO(c){return String(f.co).split(',')[c-1]==='1';}
function isWolfTeam(role){return role<10;}
var p=parseInt(f.player),r=parseInt(f.role),w=parseInt(f.win);
var n=parseInt(f.gamemode);
var ac=String(f.alive).split(',').filter(function(v){return v==='1';}).length;
var pd=isAlive(p);
// win2判定（人狼プレイヤーが狂人と2人生存で勝利）
if(isWolfTeam(r)&&r!==9){
var survivors=[];
for(var i=1;i<=n;i++){if(isAlive(i))survivors.push(getRole(i));}
if(survivors.length===2&&survivors.some(function(v){return v===r;})&&survivors.some(function(v){return v===9;})){
f.list='win2';
}
}
if(p===1){
if(r===1&&w===2)sf.ma_s01=1;
if(!isWolfTeam(r)&&ac===4&&w===1)sf.ma_s02=1;
if(r===1&&isCO(1)&&w===2)sf.ma_s03=1;
}
if(p===2&&!isWolfTeam(r)&&w===1){
sf.si_s01=1;
if(pd)sf.si_s02=1;
if(ac===4)sf.si_s03=1;
}
if(p===3){
if(r===10&&w===1){sf.mu_s01=1;if(pd)sf.mu_s02=1;}
if(r===1&&isAlive(3)){for(var i=1;i<=n;i++){if(getRole(i)===9&&isAlive(i)){sf.mu_s03=1;break;}}}
}
if(p===4){
if(r===9&&w===2){sf.ka_s01=1;if(pd)sf.ka_s02=1;}
if(!isWolfTeam(r)&&ac===4&&parseInt(f.action)<3)sf.ka_s03=1;
}
if(p===5){
var wc=(isWolfTeam(r)&&w===2)||(!isWolfTeam(r)&&w===1);
if(wc&&isCO(5)){sf.te_s01=1;if(pd)sf.te_s02=1;}
if(r===10&&w===1&&pd)sf.te_s03=1;
}
if(p===6||p===7){
var wc2=(isWolfTeam(r)&&w===2)||(!isWolfTeam(r)&&w===1);
if(p===7&&pd&&wc2)sf.keiji_s01=1;
if(isAlive(6)&&isAlive(7)&&wc2)sf.keiji_s02=1;
if(isAlive(2)&&isAlive(3)&&isAlive(6)&&isAlive(7)&&wc2)sf.keiji_s03=1;
}
[endscript]

[return  ]
