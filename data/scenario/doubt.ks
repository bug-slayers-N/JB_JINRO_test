[_tb_system_call storage=system/_doubt.ks]

*doubt

[cm  ]
[tb_eval  exp="f.jump='doubt'"  name="jump"  cmd="="  op="t"  val="doubt"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listA"  ]
*list_back

[iscript]
var playerNum = parseInt(f.player);
var targetNum = parseInt(f.target);
// ゆさぶり力を設定
var yusaburi;
if (playerNum === 1) { yusaburi = 0.9; }
else if (playerNum === 2) {
var steps = [0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
yusaburi = steps[Math.floor(Math.random() * steps.length)];
}
else if (playerNum === 3) { yusaburi = 0.6; }
else if (playerNum === 4) { yusaburi = 0.7; }
else { yusaburi = 0.8; }
// ダメージ計算（基礎値36×ゆさぶり力）
var damage = 40 * yusaburi;
// 平常心減算ヘルパー
function subCalm(num, val) {
if (num === 1) { f.mafutsu_calm = f.mafutsu_calm - val; }
else if (num === 2) { f.sisigami_calm = f.sisigami_calm - val; }
else if (num === 3) { f.murasame_calm = f.murasame_calm - val; }
else if (num === 4) { f.kano_calm = f.kano_calm - val; }
else { f.tendo_calm = f.tendo_calm - val; }
}
// 対象の平常心をダメージ分減算
subCalm(targetNum, damage);
// 対象→プレイヤーへの好感度を-10
function gi(a, b) {
var o = (a - 1) * 4;
var t = [];
for (var i = 1; i <= 5; i++) { if (i !== a) t.push(i); }
return o + t.indexOf(b);
}
var likes = String(f.like).split(",");
var likeIdx = gi(targetNum, playerNum);
likes[likeIdx] = parseInt(likes[likeIdx]) - 10;
f.like = likes.join(",");
[endscript]

[jump  storage="doubt.ks"  target="*push"  cond="f.win=='push'"  ]
*push_back

[jump  storage="mafutsu.ks"  target="*doubt2"  cond="f.player==1"  ]
[jump  storage="sisigami.ks"  target="*doubt2"  cond="f.player==2"  ]
[jump  storage="murasame.ks"  target="*doubt2"  cond="f.player==3"  ]
[jump  storage="kano.ks"  target="*doubt2"  cond="f.player==4"  ]
[jump  storage="tendo.ks"  target="*doubt2"  cond="f.player==5"  ]
*show

[call  storage="mafutsu.ks"  target="*kuro"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*kuro"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*kuro"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*kuro"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*kuro"  cond="f.target==5"  ]
[jump  storage="observe.ks"  target="*observe"  ]
*doubt_ai

[iscript]
// actorの役職を取得してf.resultに格納（分岐判定用）
f.result=parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][parseInt(f.ai_actor)-1]);
[endscript]

*ai_jinro

[jump  storage="doubt.ks"  target="*ai_mad"  cond="f.result!=1"  ]
[iscript]
var actorNum=parseInt(f.ai_actor);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
var coArr=String(f.co).split(",");
var claim=String(f.claim).split(",");
var claim2=String(f.claim2).split(",");
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getCalm(num){
if(num===1)return parseFloat(f.mafutsu_calm);
if(num===2)return parseFloat(f.sisigami_calm);
if(num===3)return parseFloat(f.murasame_calm);
if(num===4)return parseFloat(f.kano_calm);
return parseFloat(f.tendo_calm);
}
function getPC(actor,tgt){return getCalm(tgt)+parseInt(lk[gi(actor,tgt)]);}
function hasCO(num){return coArr[num-1]!=="0";}
function getTargets(actor){
var t=[];
for(var i=1;i<=5;i++){if(i===actor)continue;if(aliveArr[i-1]==="0")continue;t.push(i);}
return t;
}
function selfDefenseTarget(actor){
var all=[];
for(var i=1;i<=5;i++){
if(aliveArr[i-1]==="0")continue;
var pc=(i===actor)?getCalm(actor):getPC(actor,i);
all.push({num:i,pc:pc});
}
all.sort(function(a,b){return a.pc-b.pc;});
if(all.length>=3&&(all[0].num===actor||all[1].num===actor)){return all[2].num;}
return 0;
}
var targets=getTargets(actorNum);
var target=0;
// ① 自分を人狼と申告したCOが存在すれば75%で抽選
if(target===0){
var accusers=targets.filter(function(t){
if(coArr[t-1]==="0")return false;
var c1t=parseInt(claim[(t-1)*2]),c1r=parseInt(claim[(t-1)*2+1]);
var c2t=parseInt(claim2[(t-1)*2]),c2r=parseInt(claim2[(t-1)*2+1]);
return (c1t===actorNum&&c1r===1)||(c2t===actorNum&&c2r===1);
});
if(accusers.length>0&&Math.random()<0.75){
target=accusers[Math.floor(Math.random()*accusers.length)];
}
}
// ② 全生存者視点でliar=1または4のキャラが当選
if(target===0){
var bustedAll=targets.filter(function(t){
for(var obs=1;obs<=5;obs++){
if(obs===t)continue;
if(aliveArr[obs-1]==="0")continue;
var v=parseInt(lr[gi(obs,t)]);
if(v!==1&&v!==4)return false;
}
return true;
});
if(bustedAll.length>0){
bustedAll.sort(function(a,b){return getCalm(b)-getCalm(a);});
target=bustedAll[0];
}
}
// ③ 自己防衛
if(target===0){
var defT=selfDefenseTarget(actorNum);
if(defT)target=defT;
}
// ④ 平常心が高いキャラ
if(target===0){
var sorted=targets.slice();
sorted.sort(function(a,b){return getCalm(b)-getCalm(a);});
if(sorted.length>0)target=sorted[0];
}
f.target=target;
[endscript]

[jump  storage="doubt.ks"  target="*ai_calc"  ]
*ai_mad

[jump  storage="doubt.ks"  target="*ai_seer"  cond="f.result!=2"  ]
[iscript]
var actorNum=parseInt(f.ai_actor);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
var coArr=String(f.co).split(",");
var claimArr=String(f.claim).split(",");
var claim2Arr=String(f.claim2).split(",");
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getCalm(num){
if(num===1)return parseFloat(f.mafutsu_calm);
if(num===2)return parseFloat(f.sisigami_calm);
if(num===3)return parseFloat(f.murasame_calm);
if(num===4)return parseFloat(f.kano_calm);
return parseFloat(f.tendo_calm);
}
function isWolfFor(actor,tgt){var v=parseInt(lr[gi(actor,tgt)]);return v===1||v===3;}
function hasCO(num){return coArr[num-1]!=="0";}
function reportedHuman(actor,tgt){
var i1=parseInt(claimArr[(actor-1)*2])===tgt&&claimArr[(actor-1)*2+1]==="0";
var i2=parseInt(claim2Arr[(actor-1)*2])===tgt&&claim2Arr[(actor-1)*2+1]==="0";
return i1||i2;
}
function getTargets(actor){
var t=[];
for(var i=1;i<=5;i++){if(i===actor)continue;if(aliveArr[i-1]==="0")continue;if(reportedHuman(actor,i))continue;t.push(i);}
return t;
}
var targets=getTargets(actorNum);
var target=0;
var wolfList=targets.filter(function(t){return isWolfFor(actorNum,t);});
if(wolfList.length>0){
var others=targets.filter(function(t){return wolfList.indexOf(t)===-1;});
var coList=others.filter(function(t){return hasCO(t);});
if(coList.length>0){
coList.sort(function(a,b){return getCalm(b)-getCalm(a);});
target=coList[0];
}else{
others.sort(function(a,b){return getCalm(b)-getCalm(a);});
if(others.length>0)target=others[0];
}
}else{
var coList=targets.filter(function(t){return hasCO(t);});
if(coList.length>0){
coList.sort(function(a,b){return getCalm(b)-getCalm(a);});
target=coList[0];
}else{
var sorted=targets.slice();
sorted.sort(function(a,b){return getCalm(b)-getCalm(a);});
if(sorted.length>0)target=sorted[0];
}
}
f.target=target;
[endscript]

[jump  storage="doubt.ks"  target="*ai_calc"  ]
*ai_seer

[jump  storage="doubt.ks"  target="*ai_vill"  cond="f.result!=3"  ]
[iscript]
var actorNum=parseInt(f.ai_actor);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
var coArr=String(f.co).split(",");
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getCalm(num){
if(num===1)return parseFloat(f.mafutsu_calm);
if(num===2)return parseFloat(f.sisigami_calm);
if(num===3)return parseFloat(f.murasame_calm);
if(num===4)return parseFloat(f.kano_calm);
return parseFloat(f.tendo_calm);
}
function getPC(actor,tgt){return getCalm(tgt)+parseInt(lk[gi(actor,tgt)]);}
function getTargets(actor){
var t=[];
for(var i=1;i<=5;i++){if(i===actor)continue;if(aliveArr[i-1]==="0")continue;t.push(i);}
return t;
}
function selfDefenseTarget(actor){
var all=[];
for(var i=1;i<=5;i++){
if(aliveArr[i-1]==="0")continue;
var pc=(i===actor)?getCalm(actor):getPC(actor,i);
all.push({num:i,pc:pc});
}
all.sort(function(a,b){return a.pc-b.pc;});
if(all.length>=3&&(all[0].num===actor||all[1].num===actor)){return all[2].num;}
return 0;
}
var targets=getTargets(actorNum);
var target=0;
// ① liar=3（人狼確定）が当選
if(target===0){
var wolf3=targets.filter(function(t){return parseInt(lr[gi(actorNum,t)])===3;});
if(wolf3.length>0){
target=wolf3[0];
}
}
// ② liar=1（嘘つき確定）が当選、複数いたら平常心高い優先
if(target===0){
var liar1=targets.filter(function(t){return parseInt(lr[gi(actorNum,t)])===1;});
if(liar1.length>0){
liar1.sort(function(a,b){return getCalm(b)-getCalm(a);});
target=liar1[0];
}
}
// ③ 自己防衛
if(target===0){
var defT=selfDefenseTarget(actorNum);
if(defT)target=defT;
}
// ④ 自分からの知覚平常心が低いキャラ
if(target===0){
var sorted=targets.slice();
sorted.sort(function(a,b){return getPC(actorNum,a)-getPC(actorNum,b);});
if(sorted.length>0)target=sorted[0];
}
f.target=target;
[endscript]

[jump  storage="doubt.ks"  target="*ai_calc"  ]
*ai_vill

[iscript]
var actorNum=parseInt(f.ai_actor);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
var coArr=String(f.co).split(",");
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getCalm(num){
if(num===1)return parseFloat(f.mafutsu_calm);
if(num===2)return parseFloat(f.sisigami_calm);
if(num===3)return parseFloat(f.murasame_calm);
if(num===4)return parseFloat(f.kano_calm);
return parseFloat(f.tendo_calm);
}
function getPC(actor,tgt){return getCalm(tgt)+parseInt(lk[gi(actor,tgt)]);}
function hasCO(num){return coArr[num-1]!=="0";}
function getTargets(actor){
var t=[];
for(var i=1;i<=5;i++){if(i===actor)continue;if(aliveArr[i-1]==="0")continue;t.push(i);}
return t;
}
function selfDefenseTarget(actor){
var all=[];
for(var i=1;i<=5;i++){
if(aliveArr[i-1]==="0")continue;
var pc=(i===actor)?getCalm(actor):getPC(actor,i);
all.push({num:i,pc:pc});
}
all.sort(function(a,b){return a.pc-b.pc;});
if(all.length>=3&&(all[0].num===actor||all[1].num===actor)){return all[2].num;}
return 0;
}
var targets=getTargets(actorNum);
var target=0;
// ① liar=3（人狼確定）が当選
if(target===0){
var wolf3=targets.filter(function(t){return parseInt(lr[gi(actorNum,t)])===3;});
if(wolf3.length>0){
target=wolf3[0];
}
}
// ② liar=1（嘘つき確定）が当選、複数いたら平常心高い優先
if(target===0){
var liar1=targets.filter(function(t){return parseInt(lr[gi(actorNum,t)])===1;});
if(liar1.length>0){
liar1.sort(function(a,b){return getCalm(b)-getCalm(a);});
target=liar1[0];
}
}
// ③ CO済みキャラを平常心低い順
if(target===0){
var coList=targets.filter(function(t){return hasCO(t);});
if(coList.length>0){
coList.sort(function(a,b){return getCalm(a)-getCalm(b);});
target=coList[0];
}
}
// ④ 自己防衛
if(target===0){
var defT=selfDefenseTarget(actorNum);
if(defT)target=defT;
}
// ⑤ ランダム
if(target===0&&targets.length>0){
target=targets[Math.floor(Math.random()*targets.length)];
}
f.target=target;
[endscript]

[jump  storage="doubt.ks"  target="*ai_calc"  ]
*ai_calc

[iscript]
var actorNum = parseInt(f.ai_actor);
var target = parseInt(f.target);
var lk = String(f.like).split(",");
function gi(a, b) {
var o = (a - 1) * 4;
var t = [];
for (var i = 1; i <= 5; i++) { if (i !== a) t.push(i); }
return o + t.indexOf(b);
}
// ゆさぶり力を設定
var yusaburi;
if (actorNum === 1) { yusaburi = 0.9; }
else if (actorNum === 2) {
var steps = [0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
yusaburi = steps[Math.floor(Math.random() * steps.length)];
}
else if (actorNum === 3) { yusaburi = 0.6; }
else if (actorNum === 4) { yusaburi = 0.7; }
else { yusaburi = 0.8; }
// 対象の平常心をダメージ分減算
var damage = 40 * yusaburi;
function subCalm(num, val) {
if (num === 1) { f.mafutsu_calm = f.mafutsu_calm - val; }
else if (num === 2) { f.sisigami_calm = f.sisigami_calm - val; }
else if (num === 3) { f.murasame_calm = f.murasame_calm - val; }
else if (num === 4) { f.kano_calm = f.kano_calm - val; }
else { f.tendo_calm = f.tendo_calm - val; }
}
subCalm(target, damage);
// target→actorの好感度-10
var likeIdx = gi(target, actorNum);
lk[likeIdx] = parseInt(lk[likeIdx]) - 10;
f.like = lk.join(",");
[endscript]

[jump  storage="mafutsu.ks"  target="*doubt2"  cond="f.ai_actor==1"  ]
[jump  storage="sisigami.ks"  target="*doubt2"  cond="f.ai_actor==2"  ]
[jump  storage="murasame.ks"  target="*doubt2"  cond="f.ai_actor==3"  ]
[jump  storage="kano.ks"  target="*doubt2"  cond="f.ai_actor==4"  ]
[jump  storage="tendo.ks"  target="*doubt2"  cond="f.ai_actor==5"  ]
*push

[tb_eval  exp="f.push=1"  name="push"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="doubt.ks"  target="*push_mafutsu"  cond="f.player==1"  ]
[jump  storage="doubt.ks"  target="*push_sisigami"  cond="f.player==2"  ]
[jump  storage="doubt.ks"  target="*push_murasame"  cond="f.player==3"  ]
[jump  storage="doubt.ks"  target="*push_kano"  cond="f.player==4"  ]
[jump  storage="doubt.ks"  target="*push_tendo"  cond="f.player==5"  ]
*push_mafutsu

[tb_start_text mode=1 ]
#真経津
「強く推すポイントは？」[p]
「間違ったこと言うとむしろ恥ずかしい思いをするよ」[p]
[_tb_end_text]

[glink  color="black"  storage="doubt.ks"  size="20"  text="直感だけどね"  target="*damage1"  ]
[glink  color="black"  storage="doubt.ks"  size="20"  text="声のトーンが違うくない？"  target="*damage2"  ]
[glink  color="black"  storage="doubt.ks"  size="20"  text="鏡の中に君を助ける答えはない"  target="*damage3"  ]
[s  ]
*push_sisigami

[tb_start_text mode=1 ]
#獅子神
「強く推すところはなんだ？」[p]
[_tb_end_text]

[glink  color="black"  storage="doubt.ks"  size="20"  text="正直、勘"  target="*damage1"  ]
[glink  color="black"  storage="doubt.ks"  size="20"  text="オレですら怪しく思う"  target="*damage2"  ]
[glink  color="black"  storage="doubt.ks"  size="20"  text="どう考えても人狼"  target="*damage3"  ]
[s  ]
*push_murasame

[tb_start_text mode=1 ]
#村雨
「強く推すその理由は？」[p]
[_tb_end_text]

[glink  color="black"  storage="doubt.ks"  size="20"  text="理論はない、医者の勘"  target="*damage1"  ]
[glink  color="black"  storage="doubt.ks"  size="20"  text="生体反応を見ろ"  target="*damage2"  ]
[glink  color="black"  storage="doubt.ks"  size="20"  text="論理的に考えて人狼"  target="*damage3"  ]
[s  ]
*push_kano

[tb_start_text mode=1 ]
#叶
「何を理由に強く推すんだ？」[p]
[_tb_end_text]

[glink  color="black"  storage="doubt.ks"  size="20"  text="観測者の勘"  target="*damage1"  ]
[glink  color="black"  storage="doubt.ks"  size="20"  text="嘘をついている反応"  target="*damage2"  ]
[glink  color="black"  storage="doubt.ks"  size="20"  text="誰の目に観ても人狼"  target="*damage3"  ]
[s  ]
*push_tendo

[tb_start_text mode=1 ]
#天堂
「強く推すには理由がいる」[p]
[_tb_end_text]

[glink  color="black"  storage="doubt.ks"  size="20"  text="神の直感"  target="*damage1"  ]
[glink  color="black"  storage="doubt.ks"  size="20"  text="神の目からは逃れられない"  target="*damage2"  ]
[glink  color="black"  storage="doubt.ks"  size="20"  text="哀れな咎人に神罰を下そう"  target="*damage3"  ]
[s  ]
*damage1

[tb_eval  exp="f.win='d1'"  name="win"  cmd="="  op="t"  val="d1"  val_2="undefined"  ]
[jump  storage="doubt.ks"  target="*push_damage"  ]
*damage2

[tb_eval  exp="f.win='d2'"  name="win"  cmd="="  op="t"  val="d2"  val_2="undefined"  ]
[jump  storage="doubt.ks"  target="*push2_judge"  ]
*damage3

[tb_eval  exp="f.win='d3'"  name="win"  cmd="="  op="t"  val="d3"  val_2="undefined"  ]
[jump  storage="doubt.ks"  target="*push3_judge"  ]
*damage0

[iscript]
var playerNum=parseInt(f.player);
if(playerNum===1){f.mafutsu_calm=f.mafutsu_calm-20;}
else if(playerNum===2){f.sisigami_calm=f.sisigami_calm-20;}
else if(playerNum===3){f.murasame_calm=f.murasame_calm-20;}
else if(playerNum===4){f.kano_calm=f.kano_calm-20;}
else{f.tendo_calm=f.tendo_calm-20;}
[endscript]

[jump  storage="doubt.ks"  target="*push_back"  ]
*push_damage

[iscript]
var playerNum=parseInt(f.player);
var targetNum=parseInt(f.target);
var yusaburi;
if(playerNum===1){yusaburi=0.9;}
else if(playerNum===2){var steps=[0.5,0.6,0.7,0.8,0.9,1.0];yusaburi=steps[Math.floor(Math.random()*steps.length)];}
else if(playerNum===3){yusaburi=0.6;}
else if(playerNum===4){yusaburi=0.7;}
else{yusaburi=0.8;}
var base=0;
if(f.win==="d1"){base=10;}
else if(f.win==="d2"){base=20;}
else if(f.win==="d3"){base=30;}
var damage=base*yusaburi;
if(targetNum===1){f.mafutsu_calm=f.mafutsu_calm-damage;}
else if(targetNum===2){f.sisigami_calm=f.sisigami_calm-damage;}
else if(targetNum===3){f.murasame_calm=f.murasame_calm-damage;}
else if(targetNum===4){f.kano_calm=f.kano_calm-damage;}
else{f.tendo_calm=f.tendo_calm-damage;}
[endscript]

[jump  storage="doubt.ks"  target="*push_back"  ]
*push2_judge

[iscript]
var playerNum=parseInt(f.player);
var targetNum=parseInt(f.target);
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
var lr=String(f.liar).split(",");
var lv=parseInt(lr[gi(playerNum,targetNum)]);
f.result=(lv===1||lv===3||lv===4)?0:1;
[endscript]

[jump  storage="doubt.ks"  target="*push_damage"  cond="f.result==0"  ]
[jump  storage="doubt.ks"  target="*damage0"  ]
*push3_judge

[iscript]
var playerNum=parseInt(f.player);
var targetNum=parseInt(f.target);
var aliveArr=String(f.alive).split(",");
var lr=String(f.liar).split(",");
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
// ① 全員のライアーに3が入ってるか
var allThree=true;
for(var i=1;i<=5;i++){
if(i===targetNum)continue;
if(aliveArr[i-1]==="0")continue;
if(parseInt(lr[gi(i,targetNum)])!==3){allThree=false;break;}
}
// ② プレイヤーが本物占い師でライアーに3が入ってるか
var seerThree=roles[playerNum-1]===3&&parseInt(lr[gi(playerNum,targetNum)])===3;
f.result=(allThree||seerThree)?0:1;
[endscript]

[jump  storage="doubt.ks"  target="*push_damage"  cond="f.result==0"  ]
[jump  storage="doubt.ks"  target="*damage0"  ]
*push_act

[iscript]
var playerNum=parseInt(f.player);
var currentTarget=parseInt(f.target);
var aliveArr=String(f.alive).split(",");
var candidates=[];
for(var i=1;i<=5;i++){
if(i===playerNum)continue;
if(i===currentTarget)continue;
if(aliveArr[i-1]==="0")continue;
candidates.push(i);
}
if(candidates.length>0){
f.target=candidates[Math.floor(Math.random()*candidates.length)];
}
[endscript]

[iscript]
var playerNum=parseInt(f.player);
var names=["真経津","獅子神","村雨","叶","天堂"];
f.name2=names[playerNum-1];
[endscript]

[jump  storage="mafutsu.ks"  target="*push_act"  cond="f.target==1"  ]
[jump  storage="sisigami.ks"  target="*push_act"  cond="f.target==2"  ]
[jump  storage="murasame.ks"  target="*push_act"  cond="f.target==3"  ]
[jump  storage="kano.ks"  target="*push_act"  cond="f.target==4"  ]
[jump  storage="tendo.ks"  target="*push_act"  cond="f.target==5"  ]
