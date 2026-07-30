[_tb_system_call storage=system/_say_human.ks]

*say_human

[tb_eval  exp="f.display07=f.ai_actor"  name="display07"  cmd="="  op="h"  val="ai_actor"  val_2="undefined"  ]
[tb_eval  exp="f.say_human=1"  name="say_human"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[call  storage="mafutsu.ks"  target="*s_human"  cond="f.display07==1"  ]
[call  storage="sisigami.ks"  target="*s_human"  cond="f.display07==2"  ]
[call  storage="murasame.ks"  target="*s_human"  cond="f.display07==3"  ]
[call  storage="kano.ks"  target="*s_human"  cond="f.display07==4"  ]
[call  storage="tendo.ks"  target="*s_human"  cond="f.display07==5"  ]
[call  storage="shigure.ks"  target="*s_human"  cond="f.display07==6"  ]
[call  storage="yamabuki.ks"  target="*s_human"  cond="f.display07==7"  ]
[call  storage="gato.ks"  target="*s_human"  cond="f.display07==8"  ]
[call  storage="urushibara.ks"  target="*s_human"  cond="f.display07==9"  ]
*p_stop

[jump  storage="say_human.ks"  target="*say_human_lottery"  cond="f.display07==f.player"  ]
[jump  storage="say_human.ks"  target="*say_human_lottery"  cond="f.player_death==1"  ]
[glink  color="black"  storage="say_human.ks"  size="20"  text="止める"  autopos="true"  target="*p_stop_yes"  ]
[glink  color="black"  storage="say_human.ks"  size="20"  text="止めない"  autopos="true"  target="*p_stop_no"  ]
[s  ]
*p_stop_yes

[tb_eval  exp="f.ai_actor=f.player"  name="ai_actor"  cmd="="  op="h"  val="player"  val_2="undefined"  ]
[jump  storage="say_human.ks"  target="*stop_list"  ]
*p_stop_no

*say_human_lottery

[iscript]
function getRole(i){return parseInt(String(f.character).split(',')[i-1]);}
function isAlive(i){return String(f.alive).split(',')[i-1]==='1';}
var n=parseInt(f.gamemode);
var caller=parseInt(f.display07);
var pn=parseInt(f.player);
// ①死亡者と発言者を除くキャラを取得
var pool=[];
for(var i=1;i<=n;i++){if(i!==caller&&isAlive(i))pool.push(i);}
// ②ランダムに並び替えてdisplay09に保存
for(var i=pool.length-1;i>0;i--){var j=Math.floor(Math.random()*(i+1));var tmp=pool[i];pool[i]=pool[j];pool[j]=tmp;}
f.display09=pool.join(",");
// ③前から役職・性格に応じた確率でストップ抽選（プレイヤーは「止めない」を選んだので必ず0%）
f.result=0;
for(var i=0;i<pool.length;i++){
var c=pool[i];
var role=getRole(c);
var prob=0;
if(c===pn){
prob=0;
}else if(c===1){
prob=0.25;
}else if(c===2){
if(role===9) prob=0.60;
else if(role<=5) prob=0;
else prob=0.20;
}else if(c===3){
prob=0.12;
}else if(c===4){
if(role===9) prob=0.40;
else if(role<=5) prob=0.15;
else prob=0.20;
}else if(c===5){
if(role===9) prob=0.40;
else prob=0.15;
}else if(c===6){
if(role===9) prob=0.40;
else prob=0.15;
}else if(c===7){
if(role===9) prob=0.40;
else if(role<=5) prob=0.15;
else prob=0.20;
}else if(c===8){
if(role===9) prob=0.40;
else if(role<=5) prob=0.15;
else prob=0.20;
}else if(c===9){
if(role===9) prob=0.60;
else if(role<=5) prob=0;
else prob=0.20;
}
// ④止まったら何人目かをresultに、いなければ0のまま
if(Math.random()<prob){f.result=i+1;break;}
}
// ⑤jumpに0を代入
f.jump=0;
[endscript]

*say_human_reply

[tb_eval  exp="f.jump+=1"  name="jump"  cmd="+="  op="t"  val="1"  val_2="undefined"  ]
[iscript]
// 直前に喋ったキャラのダメージ処理（jump==1の初回は誰もまだ喋っていないのでスキップ）
if(parseInt(f.jump)>1){
var prevActor=parseInt(f.ai_actor);
var prevRole=parseInt(String(f.character).split(',')[prevActor-1]);
if(prevRole<10){
var aliveArr=String(f.alive).split(',');
var yusaburi;
if(prevActor===1){yusaburi=0.9;}
else if(prevActor===2){var steps=[0.5,0.6,0.7,0.8,0.9,1.0];yusaburi=steps[Math.floor(Math.random()*steps.length)];}
else if(prevActor===3){yusaburi=0.6;}
else if(prevActor===4){yusaburi=0.7;}
else if(prevActor===5){yusaburi=0.8;}
else if(prevActor===6){yusaburi=0.7;if(aliveArr[6]==='1')yusaburi*=1.1;}
else if(prevActor===7){yusaburi=0.8;if(aliveArr[5]==='1')yusaburi*=1.1;}
else if(prevActor===8){yusaburi=0.7;if(aliveArr[8]==='1')yusaburi*=1.4;}
else{yusaburi=0.6;}
var damage=20*yusaburi;
var calmArr=String(f.calm).split(',');
calmArr[prevActor-1]=String(parseFloat(calmArr[prevActor-1])-damage);
f.calm=calmArr.join(',');
}
}
// 今回の位置を決定
var pool=String(f.display09).split(",");
var n=pool.length;
if(parseInt(f.jump)>n){
f.jump="end";
}else{
var c=parseInt(pool[parseInt(f.jump)-1]);
f.ai_actor=c;
if(parseInt(f.jump)===parseInt(f.result)){
f.jump="stop";
}
}
[endscript]

[jump  storage="say_human.ks"  target="*end"  cond="f.jump=='end'"  ]
[jump  storage="say_human.ks"  target="*stop_list"  cond="f.jump=='stop'"  ]
[jump  storage="mafutsu.ks"  target="*human"  cond="f.ai_actor==1"  ]
[jump  storage="sisigami.ks"  target="*human"  cond="f.ai_actor==2"  ]
[jump  storage="murasame.ks"  target="*human"  cond="f.ai_actor==3"  ]
[jump  storage="kano.ks"  target="*human"  cond="f.ai_actor==4"  ]
[jump  storage="tendo.ks"  target="*human"  cond="f.ai_actor==5"  ]
[jump  storage="shigure.ks"  target="*human"  cond="f.ai_actor==6"  ]
[jump  storage="yamabuki.ks"  target="*human"  cond="f.ai_actor==7"  ]
[jump  storage="gato.ks"  target="*human"  cond="f.ai_actor==8"  ]
[jump  storage="urushibara.ks"  target="*human"  cond="f.ai_actor==9"  ]
*stop_list

[call  storage="mafutsu.ks"  target="*stop"  cond="f.ai_actor==1"  ]
[call  storage="sisigami.ks"  target="*stop"  cond="f.ai_actor==2"  ]
[call  storage="murasame.ks"  target="*stop"  cond="f.ai_actor==3"  ]
[call  storage="kano.ks"  target="*stop"  cond="f.ai_actor==4"  ]
[call  storage="tendo.ks"  target="*stop"  cond="f.ai_actor==5"  ]
[call  storage="shigure.ks"  target="*stop"  cond="f.ai_actor==6"  ]
[call  storage="yamabuki.ks"  target="*stop"  cond="f.ai_actor==7"  ]
[call  storage="gato.ks"  target="*stop"  cond="f.ai_actor==8"  ]
[call  storage="urushibara.ks"  target="*stop"  cond="f.ai_actor==9"  ]
[call  storage="mafutsu.ks"  target="*stop2"  cond="f.display07==1"  ]
[call  storage="sisigami.ks"  target="*stop2"  cond="f.display07==2"  ]
[call  storage="murasame.ks"  target="*stop2"  cond="f.display07==3"  ]
[call  storage="kano.ks"  target="*stop2"  cond="f.display07==4"  ]
[call  storage="tendo.ks"  target="*stop2"  cond="f.display07==5"  ]
[call  storage="shigure.ks"  target="*stop2"  cond="f.display07==6"  ]
[call  storage="yamabuki.ks"  target="*stop2"  cond="f.display07==7"  ]
[call  storage="gato.ks"  target="*stop2"  cond="f.display07==8"  ]
[call  storage="urushibara.ks"  target="*stop2"  cond="f.display07==9"  ]
[iscript]
function addCalm(i,val){var arr=String(f.calm).split(',');arr[i-1]=String(parseFloat(arr[i-1])+val);f.calm=arr.join(',');}
addCalm(parseInt(f.ai_actor),-15);
addCalm(parseInt(f.display07),-15);
[endscript]

[jump  storage="say_human.ks"  target="*end"  ]
*end

[jump  storage="observe.ks"  target="*observe"  ]
