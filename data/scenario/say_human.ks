[_tb_system_call storage=system/_say_human.ks]

*say_human

[tb_eval  exp="f.result=0"  name="result"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[iscript]
f.target = parseInt(f.ai_actor)===0 ? parseInt(f.player) : parseInt(f.ai_actor);
[endscript]

*list

[call  storage="mafutsu.ks"  target="*s_human"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*s_human"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*s_human"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*s_human"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*s_human"  cond="f.target==5"  ]
[call  storage="say_human.ks"  target="*p_stop"  cond=""  ]
*ai_stop

[iscript]
function getRole(i){return parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][i-1]);}
function isAlive(i){return String(f.alive).split(',')[i-1]==='1';}
var pn=parseInt(f.player);
var an=parseInt(f.ai_actor);
var pool=[];
for(var i=1;i<=5;i++){if(i!==pn&&i!==an&&isAlive(i))pool.push(i);}
for(var i=pool.length-1;i>0;i--){var j=Math.floor(Math.random()*(i+1));var tmp=pool[i];pool[i]=pool[j];pool[j]=tmp;}
f.result='';
for(var i=0;i<pool.length;i++){
var c=pool[i];
var role=getRole(c);
var prob=0;
if(c===1){
prob=0.25;
}else if(c===2){
if(role===2) prob=0.60;
else if(role===1) prob=0;
else prob=0.20;
}else if(c===3){
prob=0.12;
}else if(c===4){
if(role===2) prob=0.40;
else if(role===1) prob=0.15;
else prob=0.20;
}else if(c===5){
if(role===2) prob=0.40;
else prob=0.15;
}
if(Math.random()<prob){f.target=c;f.result='stop';break;}
}
[endscript]

[jump  storage="say_human.ks"  target="*stop_list"  cond="f.result=='stop'"  ]
*human

[jump  storage="say_human.ks"  target="*ma"  cond="f.target==1"  ]
[tb_eval  exp="f.jump=1"  name="jump"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[call  storage="say_human.ks"  target="*alive"  ]
[call  storage="mafutsu.ks"  target="*human"  ]
[call  storage="say_human.ks"  target="*damage"  ]
*ma

[jump  storage="say_human.ks"  target="*si"  cond="f.target==2"  ]
[tb_eval  exp="f.jump=2"  name="jump"  cmd="="  op="t"  val="2"  val_2="undefined"  ]
[call  storage="say_human.ks"  target="*alive"  ]
[call  storage="sisigami.ks"  target="*human"  ]
[call  storage="say_human.ks"  target="*damage"  ]
*si

[jump  storage="say_human.ks"  target="*mu"  cond="f.target==3"  ]
[tb_eval  exp="f.jump=3"  name="jump"  cmd="="  op="t"  val="3"  val_2="undefined"  ]
[call  storage="say_human.ks"  target="*alive"  ]
[call  storage="murasame.ks"  target="*human"  ]
[call  storage="say_human.ks"  target="*damage"  ]
*mu

[jump  storage="say_human.ks"  target="*ka"  cond="f.target==4"  ]
[tb_eval  exp="f.jump=4"  name="jump"  cmd="="  op="t"  val="4"  val_2="undefined"  ]
[call  storage="say_human.ks"  target="*alive"  ]
[call  storage="kano.ks"  target="*human"  ]
[call  storage="say_human.ks"  target="*damage"  ]
*ka

[jump  storage="say_human.ks"  target="*te"  cond="f.target==5"  ]
[tb_eval  exp="f.jump=5"  name="jump"  cmd="="  op="t"  val="5"  val_2="undefined"  ]
[call  storage="say_human.ks"  target="*alive"  ]
[call  storage="tendo.ks"  target="*human"  ]
[call  storage="say_human.ks"  target="*damage"  ]
*te

[tb_eval  exp="f.say_human=1"  name="say_human"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="observe.ks"  target="*observe"  ]
*damage

[iscript]
var c = parseInt(f.jump);
var role = parseInt([f.mafutsu, f.sisigami, f.murasame, f.kano, f.tendo][c - 1]);
var actorNum = parseInt(f.ai_actor) === 0 ? parseInt(f.player) : parseInt(f.ai_actor);
var yusaburi;
if (actorNum === 1) { yusaburi = 0.9; }
else if (actorNum === 2) {
var steps = [0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
yusaburi = steps[Math.floor(Math.random() * steps.length)];
}
else if (actorNum === 3) { yusaburi = 0.6; }
else if (actorNum === 4) { yusaburi = 0.7; }
else { yusaburi = 0.8; }
var damage = 20 * yusaburi;
if (role === 1 || role === 2) {
if (c === 1) { f.mafutsu_calm = parseFloat(f.mafutsu_calm) - damage; }
else if (c === 2) { f.sisigami_calm = parseFloat(f.sisigami_calm) - damage; }
else if (c === 3) { f.murasame_calm = parseFloat(f.murasame_calm) - damage; }
else if (c === 4) { f.kano_calm = parseFloat(f.kano_calm) - damage; }
else if (c === 5) { f.tendo_calm = parseFloat(f.tendo_calm) - damage; }
}
[endscript]

[return  ]
*p_stop

[jump  storage="say_human.ks"  target="*ai_stop"  cond="f.ai_actor==0"  ]
[jump  storage="say_human.ks"  target="*ai_stop"  cond="f.player_death==1"  ]
[glink  color="black"  storage="say_human.ks"  size="20"  text="止める"  autopos="true"  target="*p_stop2"  ]
[glink  color="black"  storage="say_human.ks"  size="20"  text="止めない"  autopos="true"  target="*human"  ]
[s  ]
*p_stop2

[tb_eval  exp="f.target=f.player"  name="target"  cmd="="  op="h"  val="player"  val_2="undefined"  ]
*stop_list

[call  storage="mafutsu.ks"  target="*stop"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*stop"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*stop"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*stop"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*stop"  cond="f.target==5"  ]
[iscript]
if(parseInt(f.ai_actor)===0){f.ai_actor=f.player;}
[endscript]

[call  storage="mafutsu.ks"  target="*stop2"  cond="f.ai_actor==1"  ]
[call  storage="sisigami.ks"  target="*stop2"  cond="f.ai_actor==2"  ]
[call  storage="murasame.ks"  target="*stop2"  cond="f.ai_actor==3"  ]
[call  storage="kano.ks"  target="*stop2"  cond="f.ai_actor==4"  ]
[call  storage="tendo.ks"  target="*stop2"  cond="f.ai_actor==5"  ]
[iscript]
function addCalm(i,val){if(i===1)f.mafutsu_calm=parseFloat(f.mafutsu_calm)+val;else if(i===2)f.sisigami_calm=parseFloat(f.sisigami_calm)+val;else if(i===3)f.murasame_calm=parseFloat(f.murasame_calm)+val;else if(i===4)f.kano_calm=parseFloat(f.kano_calm)+val;else f.tendo_calm=parseFloat(f.tendo_calm)+val;}
addCalm(parseInt(f.target),-15);
addCalm(parseInt(f.ai_actor),-15);
[endscript]

[jump  storage="observe.ks"  target="*observe"  ]
*alive

[iscript]
var aliveArr = String(f.alive).split(",");
var c = parseInt(f.jump);
f.result = aliveArr[c-1] === "0" ? c : 0;
[endscript]

[jump  storage="say_human.ks"  target="*ma"  cond="f.result==1"  ]
[jump  storage="say_human.ks"  target="*si"  cond="f.result==2"  ]
[jump  storage="say_human.ks"  target="*mu"  cond="f.result==3"  ]
[jump  storage="say_human.ks"  target="*ka"  cond="f.result==4"  ]
[jump  storage="say_human.ks"  target="*te"  cond="f.result==5"  ]
[return  ]
