[_tb_system_call storage=system/_doubt.ks]

*doubt

[cm  ]
[tb_eval  exp="f.jump='doubt'"  name="jump"  cmd="="  op="t"  val="doubt"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listA"  ]
*list_back

[iscript]
var playerNum = parseInt(f.player);
var targetNum = parseInt(f.target);
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
// ゆさぶり力を設定
var yusaburi;
if (playerNum === 1) { yusaburi = 0.9; }
else if (playerNum === 2) {
var steps = [0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
yusaburi = steps[Math.floor(Math.random() * steps.length)];
}
else if (playerNum === 3) { yusaburi = 0.6; }
else if (playerNum === 4) { yusaburi = 0.7; }
else if (playerNum === 5) { yusaburi = 0.8; }
else if (playerNum === 6) { yusaburi = 0.7; if(isAlive(7)) yusaburi *= 1.1; }
else if (playerNum === 7) { yusaburi = 0.8; if(isAlive(6)) yusaburi *= 1.1; }
else if (playerNum === 8) { yusaburi = 0.7; if(isAlive(9)) yusaburi *= 1.4; }
else { yusaburi = 0.6; }
// ダメージ計算（基礎値40×ゆさぶり力）
var damage = 40 * yusaburi;
// 平常心減算ヘルパー（獅子神=2は受けるダメージ1.1倍）
function subCalm(num,val){if(num===2){val*=1.1;}var arr=String(f.calm).split(',');arr[num-1]=String(parseFloat(arr[num-1])-val);f.calm=arr.join(',');}
// 対象の平常心をダメージ分減算
subCalm(targetNum, damage);
// 対象→プレイヤーへの好感度を-10
function gi(a,b){var n=parseInt(f.gamemode);var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
var likes = String(f.like).split(",");
var likeIdx = gi(targetNum, playerNum);
likes[likeIdx] = parseInt(likes[likeIdx]) - 10;
f.like = likes.join(",");
[endscript]

[jump  storage="doubt.ks"  target="*push"  cond="f.win=='push'"  ]
*push_back

[tb_eval  exp="f.ai_actor=f.player"  name="ai_actor"  cmd="="  op="h"  val="player"  val_2="undefined"  ]
[jump  storage="doubt.ks"  target="*dispatch_doubt2"  ]
*show

[jump  storage="doubt.ks"  target="*reaction_only"  cond="f.display07==1"  ]
[jump  storage="addition.ks"  target="*addition"  ]
*reaction_only

[iscript]
f.display07=0;
[endscript]

[call  storage="mafutsu.ks"  target="*kuro"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*kuro"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*kuro"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*kuro"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*kuro"  cond="f.target==5"  ]
[call  storage="shigure.ks"  target="*kuro"  cond="f.target==6"  ]
[call  storage="yamabuki.ks"  target="*kuro"  cond="f.target==7"  ]
[call  storage="gato.ks"  target="*kuro"  cond="f.target==8"  ]
[call  storage="urushibara.ks"  target="*kuro"  cond="f.target==9"  ]
[jump  storage="observe.ks"  target="*observe"  ]
*doubt_ai

[iscript]
// AI主導の場合、f.jumpがAI.ksのpickCmd()由来の数値(1)のままになっているため、
// addition.ksでの文字列比較('doubt'/'cover')が成立するよう明示的に文字列へ再設定する
f.jump='doubt';
// actorの役職を取得してf.resultに格納（分岐判定用）
f.result=parseInt(String(f.character).split(',')[parseInt(f.ai_actor)-1]);
[endscript]

*ai_jinro

[jump  storage="doubt.ks"  target="*ai_mad"  cond="f.result>5"  ]
*ai_jinro_block

[iscript]
var actorNum=parseInt(f.ai_actor);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
var coArr=String(f.co).split(",");
var claim=String(f.claim).split(",");
var claim2=String(f.claim2).split(",");
function gi(a,b){var n=parseInt(f.gamemode);var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getCalm(num){return parseFloat(String(f.calm).split(',')[num-1]);}
function getPC(actor,tgt){return getCalm(tgt)+parseInt(lk[gi(actor,tgt)]);}
function hasCO(num){return coArr[num-1]!=="0";}
function getTargets(actor){
var n=parseInt(f.gamemode);
var t=[];
for(var i=1;i<=n;i++){if(i===actor)continue;if(aliveArr[i-1]==="0")continue;t.push(i);}
return t;
}
function selfDefenseTarget(actor){
var n=parseInt(f.gamemode);
var all=[];
for(var i=1;i<=n;i++){
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
for(var obs=1;obs<=parseInt(f.gamemode);obs++){
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

[jump  storage="doubt.ks"  target="*ai_seer"  cond="f.result!=9"  ]
[iscript]
var actorNum=parseInt(f.ai_actor);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
var coArr=String(f.co).split(",");
var claimArr=String(f.claim).split(",");
var claim2Arr=String(f.claim2).split(",");
function gi(a,b){var n=parseInt(f.gamemode);var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getCalm(num){return parseFloat(String(f.calm).split(',')[num-1]);}
function isWolfFor(actor,tgt){var v=parseInt(lr[gi(actor,tgt)]);return v===1||v===3;}
function hasCO(num){return coArr[num-1]!=="0";}
function reportedHuman(actor,tgt){
var i1=parseInt(claimArr[(actor-1)*2])===tgt&&claimArr[(actor-1)*2+1]==="0";
var i2=parseInt(claim2Arr[(actor-1)*2])===tgt&&claim2Arr[(actor-1)*2+1]==="0";
return i1||i2;
}
function getTargets(actor){
var n=parseInt(f.gamemode);
var t=[];
for(var i=1;i<=n;i++){if(i===actor)continue;if(aliveArr[i-1]==="0")continue;if(reportedHuman(actor,i))continue;t.push(i);}
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

[jump  storage="doubt.ks"  target="*ai_vill"  cond="f.result!=10"  ]
[iscript]
var actorNum=parseInt(f.ai_actor);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
var coArr=String(f.co).split(",");
function gi(a,b){var n=parseInt(f.gamemode);var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getCalm(num){return parseFloat(String(f.calm).split(',')[num-1]);}
function getPC(actor,tgt){return getCalm(tgt)+parseInt(lk[gi(actor,tgt)]);}
function getTargets(actor){
var n=parseInt(f.gamemode);
var t=[];
for(var i=1;i<=n;i++){if(i===actor)continue;if(aliveArr[i-1]==="0")continue;t.push(i);}
return t;
}
function selfDefenseTarget(actor){
var n=parseInt(f.gamemode);
var all=[];
for(var i=1;i<=n;i++){
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
function gi(a,b){var n=parseInt(f.gamemode);var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getCalm(num){return parseFloat(String(f.calm).split(',')[num-1]);}
function getPC(actor,tgt){return getCalm(tgt)+parseInt(lk[gi(actor,tgt)]);}
function hasCO(num){return coArr[num-1]!=="0";}
function getTargets(actor){
var n=parseInt(f.gamemode);
var t=[];
for(var i=1;i<=n;i++){if(i===actor)continue;if(aliveArr[i-1]==="0")continue;t.push(i);}
return t;
}
function selfDefenseTarget(actor){
var n=parseInt(f.gamemode);
var all=[];
for(var i=1;i<=n;i++){
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
function gi(a,b){var n=parseInt(f.gamemode);var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
// ゆさぶり力を設定
var yusaburi;
if (actorNum === 1) { yusaburi = 0.9; }
else if (actorNum === 2) {
var steps = [0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
yusaburi = steps[Math.floor(Math.random() * steps.length)];
}
else if (actorNum === 3) { yusaburi = 0.6; }
else if (actorNum === 4) { yusaburi = 0.7; }
else if (actorNum === 5) { yusaburi = 0.8; }
else if (actorNum === 6) { yusaburi = 0.7; if(isAlive(7)) yusaburi *= 1.1; }
else if (actorNum === 7) { yusaburi = 0.8; if(isAlive(6)) yusaburi *= 1.1; }
else if (actorNum === 8) { yusaburi = 0.7; if(isAlive(9)) yusaburi *= 1.4; }
else { yusaburi = 0.6; }
// 対象の平常心をダメージ分減算
var damage = 40 * yusaburi;
// 平常心減算ヘルパー（獅子神=2は受けるダメージ1.1倍）
function subCalm(num,val){if(num===2){val*=1.1;}var arr=String(f.calm).split(',');arr[num-1]=String(parseFloat(arr[num-1])-val);f.calm=arr.join(',');}
subCalm(target, damage);
// target→actorの好感度-10
var likeIdx = gi(target, actorNum);
lk[likeIdx] = parseInt(lk[likeIdx]) - 10;
f.like = lk.join(",");
[endscript]

*dispatch_doubt2

[jump  storage="mafutsu.ks"  target="*doubt2"  cond="f.ai_actor==1"  ]
[jump  storage="sisigami.ks"  target="*doubt2"  cond="f.ai_actor==2"  ]
[jump  storage="murasame.ks"  target="*doubt2"  cond="f.ai_actor==3"  ]
[jump  storage="kano.ks"  target="*doubt2"  cond="f.ai_actor==4"  ]
[jump  storage="tendo.ks"  target="*doubt2"  cond="f.ai_actor==5"  ]
[jump  storage="shigure.ks"  target="*doubt2"  cond="f.ai_actor==6"  ]
[jump  storage="yamabuki.ks"  target="*doubt2"  cond="f.ai_actor==7"  ]
[jump  storage="gato.ks"  target="*doubt2"  cond="f.ai_actor==8"  ]
[jump  storage="urushibara.ks"  target="*doubt2"  cond="f.ai_actor==9"  ]
*push

[tb_eval  exp="f.push=1"  name="push"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="doubt.ks"  target="*push_speech"  ]
*push_speech

[iscript]
var p = parseInt(f.player);
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var pushText={
1:"「強く推すポイントは？間違ったこと言うとむしろ恥ずかしい思いをするよ」",
2:"「強く推すところはなんだ？」",
3:"「強く推すその理由は？」",
4:"「何を理由に強く推すんだ？」",
5:"「強く推すには理由がいる」",
6:"「根拠は揃ってるんですか？」",
7:"「あ～？理由はなんなんだよ」",
8:"「さすがに理由はあった方がいい」",
9:"「うん、しっかり根拠を示そうか」"
};
var pushChoice={
1:["直感だけどね","声のトーンが違うくない？","鏡の中に君を助ける答えはない"],
2:["正直、勘","オレですら怪しく思う","どう考えても人狼"],
3:["理論はない、医者の勘","生体反応を見ろ","論理的に考えて人狼"],
4:["観測者の勘","嘘をついている反応","誰の目に観ても人狼"],
5:["神の直感","神の目からは逃れられない","哀れな咎人に神罰を下そう"],
6:["刑事の勘","嘘つきなのはバレてますよ","人狼である証拠はあがってる"],
7:["刑事の勘","嘘つきってバレってから","証拠はもう揃ってんだよ"],
8:["オレの直感は当たる","嘘つきなのは間違いない","負け犬程ごちゃごちゃうるせぇ"],
9:["私的な直感","嘘つきの証拠は既にある","人狼という判決は覆せない"]
};
f.name2 = names[p];
f.pushline1 = pushText[p];
f.display01 = pushChoice[p][0];
f.display02 = pushChoice[p][1];
f.display03 = pushChoice[p][2];
[endscript]

[tb_start_text mode=1 ]
#&f.name2
[emb exp="f.pushline1"][p]
[_tb_end_text]

[glink  color="black"  storage="doubt.ks"  size="20"  text="&f.display01"  target="*damage1"  ]
[glink  color="black"  storage="doubt.ks"  size="20"  text="&f.display02"  target="*damage2"  ]
[glink  color="black"  storage="doubt.ks"  size="20"  text="&f.display03"  target="*damage3"  ]
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
// 平常心減算ヘルパー（獅子神=2は受けるダメージ1.1倍）
function subCalm(num,val){if(num===2){val*=1.1;}var arr=String(f.calm).split(',');arr[num-1]=String(parseFloat(arr[num-1])-val);f.calm=arr.join(',');}
subCalm(playerNum,20);
[endscript]

[jump  storage="doubt.ks"  target="*push_back"  ]
*push_damage

[iscript]
var playerNum=parseInt(f.player);
var targetNum=parseInt(f.target);
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
var yusaburi;
if(playerNum===1){yusaburi=0.9;}
else if(playerNum===2){var steps=[0.5,0.6,0.7,0.8,0.9,1.0];yusaburi=steps[Math.floor(Math.random()*steps.length)];}
else if(playerNum===3){yusaburi=0.6;}
else if(playerNum===4){yusaburi=0.7;}
else if(playerNum===5){yusaburi=0.8;}
else if(playerNum===6){yusaburi=0.7;if(isAlive(7))yusaburi*=1.1;}
else if(playerNum===7){yusaburi=0.8;if(isAlive(6))yusaburi*=1.1;}
else if(playerNum===8){yusaburi=0.7;if(isAlive(9))yusaburi*=1.4;}
else{yusaburi=0.6;}
var base=0;
if(f.win==="d1"){base=10;}
else if(f.win==="d2"){base=20;}
else if(f.win==="d3"){base=30;}
var damage=base*yusaburi;
// 平常心減算ヘルパー（獅子神=2は受けるダメージ1.1倍）
function subCalm(num,val){if(num===2){val*=1.1;}var arr=String(f.calm).split(',');arr[num-1]=String(parseFloat(arr[num-1])-val);f.calm=arr.join(',');}
subCalm(targetNum,damage);
[endscript]

[jump  storage="doubt.ks"  target="*push_back"  ]
*push2_judge

[iscript]
var playerNum=parseInt(f.player);
var targetNum=parseInt(f.target);
function gi(a,b){var n=parseInt(f.gamemode);var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
var lr=String(f.liar).split(",");
var lv=parseInt(lr[gi(playerNum,targetNum)]);
f.result=(lv===1||lv===4||lv===5||lv===9)?0:1;
[endscript]

[jump  storage="doubt.ks"  target="*push_damage"  cond="f.result==0"  ]
[jump  storage="doubt.ks"  target="*damage0"  ]
*push3_judge

[iscript]
var playerNum=parseInt(f.player);
var targetNum=parseInt(f.target);
var n=parseInt(f.gamemode);
var lr=String(f.liar).split(",");
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
// プレイヤー視点のライアーが5（確定）のときのみ成功
var lv=parseInt(lr[gi(playerNum,targetNum)]);
f.result=(lv===5)?0:1;
[endscript]

[jump  storage="doubt.ks"  target="*push_damage"  cond="f.result==0"  ]
[jump  storage="doubt.ks"  target="*damage0"  ]
*push_act

[iscript]
var playerNum=parseInt(f.player);
var currentTarget=parseInt(f.target);
var aliveArr=String(f.alive).split(",");
var candidates=[];
for(var i=1;i<=parseInt(f.gamemode);i++){
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
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
f.name2=names[playerNum];
[endscript]

[jump  storage="mafutsu.ks"  target="*push_act"  cond="f.target==1"  ]
[jump  storage="sisigami.ks"  target="*push_act"  cond="f.target==2"  ]
[jump  storage="murasame.ks"  target="*push_act"  cond="f.target==3"  ]
[jump  storage="kano.ks"  target="*push_act"  cond="f.target==4"  ]
[jump  storage="tendo.ks"  target="*push_act"  cond="f.target==5"  ]
[jump  storage="shigure.ks"  target="*push_act"  cond="f.target==6"  ]
[jump  storage="yamabuki.ks"  target="*push_act"  cond="f.target==7"  ]
[jump  storage="gato.ks"  target="*push_act"  cond="f.target==8"  ]
[jump  storage="urushibara.ks"  target="*push_act"  cond="f.target==9"  ]
