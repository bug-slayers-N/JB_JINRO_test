[_tb_system_call storage=system/_cover.ks]

*cover

[cm  ]
[tb_eval  exp="f.jump='cover'"  name="jump"  cmd="="  op="t"  val="cover"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listA"  ]
*list_back

[iscript]
var playerNum=parseInt(f.player);
var targetNum=parseInt(f.target);
var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
var calmArr=String(f.calm).split(",");
function getCalm(num){return parseFloat(calmArr[num-1]);}
function addCalm(num,val){calmArr[num-1]=String(parseFloat(calmArr[num-1])+val);f.calm=calmArr.join(",");}
var aliveArr=String(f.alive).split(",");
function isAlive(i){return aliveArr[i-1]==="1";}
var actorCalm=getCalm(playerNum);
var lowest=true;
for(var i=1;i<=n;i++){if(!isAlive(i)||i===playerNum)continue;if(getCalm(i)<actorCalm){lowest=false;break;}}
var lk=String(f.like).split(",");
var idx=gi(targetNum,playerNum);
var murasame=playerNum===3;
if(lowest){
f.result="low";
lk[idx]=parseInt(lk[idx])-10;
}else{
f.result=0;
addCalm(targetNum,murasame?30:20);
lk[idx]=parseInt(lk[idx])+(murasame?30:20);
}
f.like=lk.join(",");
[endscript]

[tb_eval  exp="f.ai_actor=f.player"  name="ai_actor"  cmd="="  op="h"  val="player"  val_2="undefined"  ]
[jump  storage="cover.ks"  target="*dispatch_cover2"  ]
*show

[jump  storage="cover.ks"  target="*reaction_only"  cond="f.display07==1"  ]
[jump  storage="addition.ks"  target="*addition"  ]
*reaction_only

[iscript]
f.display07=0;
[endscript]

[call  storage="mafutsu.ks"  target="*shiro"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*shiro"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*shiro"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*shiro"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*shiro"  cond="f.target==5"  ]
[call  storage="shigure.ks"  target="*shiro"  cond="f.target==6"  ]
[call  storage="yamabuki.ks"  target="*shiro"  cond="f.target==7"  ]
[call  storage="gato.ks"  target="*shiro"  cond="f.target==8"  ]
[call  storage="urushibara.ks"  target="*shiro"  cond="f.target==9"  ]
[jump  storage="observe.ks"  target="*observe"  ]
*cover_ai

[iscript]
// AI主導の場合、f.jumpがAI.ksのpickCmd()由来の数値(2)のままになっているため、
// addition.ksでの文字列比較('doubt'/'cover')が成立するよう明示的に文字列へ再設定する
f.jump='cover';
// actorの役職を取得してf.resultに格納（分岐判定用）
var charArr=String(f.character).split(",");
f.result=parseInt(charArr[parseInt(f.ai_actor)-1]);
[endscript]

*ai_jinro

[jump  storage="cover.ks"  target="*ai_mad"  cond="f.result>5"  ]
[iscript]
var actorNum=parseInt(f.ai_actor);
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var coArr=String(f.co).split(",");
function getClaimList(f_var){if(String(f_var)==="0")return [];var arr=String(f_var).split(',');var res=[];for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}return res;}
function latestClaimBy(list,reporter){var found=null;for(var i=0;i<list.length;i++){if(list[i][1]===reporter)found=list[i];}return found;}
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
var calmArr=String(f.calm).split(",");
function getCalm(num){return parseFloat(calmArr[num-1]);}
function getPC(actor,tgt){return getCalm(tgt)+parseInt(lk[gi(actor,tgt)]);}
function isAlive(i){return aliveArr[i-1]==="1";}
function reportedWolf(actor,c){
// 全sclaimエントリを走査し、最新分だけでなく過去のいずれかで
// c(候補)がactor(行動主=人狼)を人狼だと申告していれば除外対象にする
var scList=getClaimList(f.sclaim);
for(var k=0;k<scList.length;k++){
if(scList[k][1]===c&&scList[k][2]===actor&&scList[k][3]===1)return true;
}
var pc=latestClaimBy(getClaimList(f.pclaim),c);
if(pc&&pc[2]===actor&&pc[3]===1)return true;
return false;
}
var actorCO=coArr[actorNum-1]!=="0";
var candidates=[];
for(var i=1;i<=n;i++){
if(i===actorNum||!isAlive(i)||reportedWolf(actorNum,i))continue;
if(actorCO&&coArr[i-1]!=="0")continue;
candidates.push(i);
}
candidates.sort(function(a,b){var d=getPC(actorNum,b)-getPC(actorNum,a);return d!==0?d:a-b;});
var topN=Math.ceil(candidates.length*0.5);
var pool=candidates.slice(0,topN);
f.target=pool.length>0?pool[Math.floor(Math.random()*pool.length)]:0;
[endscript]

[jump  storage="cover.ks"  target="*back"  cond="f.target==0"  ]
[jump  storage="cover.ks"  target="*ai_calc"  ]
*ai_mad

[jump  storage="cover.ks"  target="*ai_seer"  cond="f.result!=9"  ]
[iscript]
var actorNum=parseInt(f.ai_actor);
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
function getClaimList(f_var){if(String(f_var)==="0")return [];var arr=String(f_var).split(',');var res=[];for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}return res;}
function latestClaimBy(list,reporter){var found=null;for(var i=0;i<list.length;i++){if(list[i][1]===reporter)found=list[i];}return found;}
var actorCO=coArr[actorNum-1]!=="0";
function isAlive(i){return aliveArr[i-1]==="1";}
function reportedWolf(seer,target){
var sc=latestClaimBy(getClaimList(f.sclaim),seer);
var pc=latestClaimBy(getClaimList(f.pclaim),seer);
if(sc&&sc[2]===target&&sc[3]===1)return true;
if(pc&&pc[2]===target&&pc[3]===1)return true;
return false;
}
function isExcluded(i){
if(i===actorNum||!isAlive(i))return true;
if(reportedWolf(i,actorNum)||reportedWolf(actorNum,i))return true;
if(actorCO&&coArr[i-1]!=="0")return true;
return false;
}
if(Math.random()>=0.5){
f.target=0;f.ai_result=1;
}else{
var candidates=[];
for(var i=1;i<=n;i++){
if(!isExcluded(i))candidates.push(i);
}
if(candidates.length>0){
f.target=candidates[Math.floor(Math.random()*candidates.length)];
f.ai_result=0;
}else{
f.target=0;f.ai_result=1;
}
}
[endscript]

[jump  storage="cover.ks"  target="*ai_calc"  cond="f.target!=0"  ]
[jump  storage="cover.ks"  target="*back"  ]
*ai_seer

[jump  storage="cover.ks"  target="*ai_vill"  cond="f.result!=10"  ]
[iscript]
var actorNum=parseInt(f.ai_actor);
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
var coArr=String(f.co).split(",");
function isAlive(i){return aliveArr[i-1]==="1";}
function hasCO(i){return coArr[i-1]!=="0";}
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getLiar(a,b){return parseInt(lr[gi(a,b)]);}
function getLike(a,b){return parseInt(lk[gi(a,b)]);}
var calmArr=String(f.calm).split(",");
function getCalm(num){var v=parseFloat(calmArr[num-1]);if(num===6&&isAlive(7))v*=1.1;if(num===7&&isAlive(6))v*=1.1;if(num===9&&isAlive(8))v*=1.4;return v;}
function getPC(actor,tgt){return getCalm(tgt)+getLike(actor,tgt);}
function getSeerResultList(){if(String(f.seer_result)==="0")return [];var arr=String(f.seer_result).split(',');var res=[];for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}return res;}
var target=0;
// ①本物の占い結果で「人間」と出ている＋生存＋未CO のキャラからランダム
var seerResults=getSeerResultList();
var step1=[];
for(var si=0;si<seerResults.length;si++){
var srTgt=seerResults[si][0],srRes=seerResults[si][1];
if(srRes===0&&isAlive(srTgt)&&srTgt!==actorNum&&!hasCO(srTgt))step1.push(srTgt);
}
if(step1.length>0){
target=step1[Math.floor(Math.random()*step1.length)];
}
// ②本人視点のliarが10以上（役職確定・村人陣営側）だが、
// 他の生存者の少なくとも1人はまだliar10未満（＝共通認識にはなっていない）のキャラからランダム
if(target===0){
var step2=[];
for(var i=1;i<=n;i++){
if(i===actorNum||!isAlive(i))continue;
if(getLiar(actorNum,i)<10)continue;
var knownByAll=true;
for(var j=1;j<=n;j++){
if(j===i||!isAlive(j))continue;
if(getLiar(j,i)<10){knownByAll=false;break;}
}
if(!knownByAll)step2.push(i);
}
if(step2.length>0){
target=step2[Math.floor(Math.random()*step2.length)];
}
}
// ③本人視点のliarが0・2・3のキャラのうち、知覚平常心（平常心＋好感度）上位50%からランダム
if(target===0){
var step3=[];
for(var i=1;i<=n;i++){
if(i===actorNum||!isAlive(i))continue;
var lv=getLiar(actorNum,i);
if(lv===0||lv===2||lv===3)step3.push(i);
}
step3.sort(function(a,b){var d=getPC(actorNum,b)-getPC(actorNum,a);return d!==0?d:a-b;});
var topN=Math.ceil(step3.length*0.5);
var pool=step3.slice(0,topN);
if(pool.length>0){
target=pool[Math.floor(Math.random()*pool.length)];
}
}
// ④ここまでで決まらなければtarget=0のまま
f.target=target;
[endscript]

[jump  storage="cover.ks"  target="*back"  cond="f.target==0"  ]
[jump  storage="cover.ks"  target="*ai_calc"  ]
*ai_vill

[iscript]
var actorNum=parseInt(f.ai_actor);
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
function isAlive(i){return aliveArr[i-1]==="1";}
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getLiar(a,b){return parseInt(lr[gi(a,b)]);}
function getLike(a,b){return parseInt(lk[gi(a,b)]);}
var calmArr=String(f.calm).split(",");
function getCalm(num){var v=parseFloat(calmArr[num-1]);if(num===6&&isAlive(7))v*=1.1;if(num===7&&isAlive(6))v*=1.1;if(num===9&&isAlive(8))v*=1.4;return v;}
function getPC(actor,tgt){return getCalm(tgt)+getLike(actor,tgt);}
var target=0;
// ②本人視点のliarが10以上（役職確定・村人陣営側）だが、
// 他の生存者の少なくとも1人はまだliar10未満（＝共通認識にはなっていない）のキャラからランダム
var step2=[];
for(var i=1;i<=n;i++){
if(i===actorNum||!isAlive(i))continue;
if(getLiar(actorNum,i)<10)continue;
var knownByAll=true;
for(var j=1;j<=n;j++){
if(j===i||!isAlive(j))continue;
if(getLiar(j,i)<10){knownByAll=false;break;}
}
if(!knownByAll)step2.push(i);
}
if(step2.length>0){
target=step2[Math.floor(Math.random()*step2.length)];
}
// ③本人視点のliarが0・2・3のキャラのうち、知覚平常心（平常心＋好感度）上位50%からランダム
if(target===0){
var step3=[];
for(var i=1;i<=n;i++){
if(i===actorNum||!isAlive(i))continue;
var lv=getLiar(actorNum,i);
if(lv===0||lv===2||lv===3)step3.push(i);
}
step3.sort(function(a,b){var d=getPC(actorNum,b)-getPC(actorNum,a);return d!==0?d:a-b;});
var topN=Math.ceil(step3.length*0.5);
var pool=step3.slice(0,topN);
if(pool.length>0){
target=pool[Math.floor(Math.random()*pool.length)];
}
}
// ④ここまでで決まらなければtarget=0のまま
f.target=target;
[endscript]

[jump  storage="cover.ks"  target="*back"  cond="f.target==0"  ]
[jump  storage="cover.ks"  target="*ai_calc"  ]
*ai_calc

[iscript]
var actorNum=parseInt(f.ai_actor);
var targetNum=parseInt(f.target);
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
var calmArr=String(f.calm).split(",");
function getCalm(num){return parseFloat(calmArr[num-1]);}
function addCalm(num,val){calmArr[num-1]=String(parseFloat(calmArr[num-1])+val);f.calm=calmArr.join(",");}
function isAlive(i){return aliveArr[i-1]==="1";}
var actorCalm=getCalm(actorNum);
var lowest=true;
for(var i=1;i<=n;i++){if(!isAlive(i)||i===actorNum)continue;if(getCalm(i)<actorCalm){lowest=false;break;}}
var idx=gi(targetNum,actorNum);
var murasame=actorNum===3;
if(lowest){
f.result="low";
lk[idx]=parseInt(lk[idx])-10;
}else{
f.result=0;
addCalm(targetNum,murasame?30:20);
lk[idx]=parseInt(lk[idx])+(murasame?30:20);
}
f.like=lk.join(",");
[endscript]

*dispatch_cover2

[jump  storage="mafutsu.ks"  target="*cover2"  cond="f.ai_actor==1"  ]
[jump  storage="sisigami.ks"  target="*cover2"  cond="f.ai_actor==2"  ]
[jump  storage="murasame.ks"  target="*cover2"  cond="f.ai_actor==3"  ]
[jump  storage="kano.ks"  target="*cover2"  cond="f.ai_actor==4"  ]
[jump  storage="tendo.ks"  target="*cover2"  cond="f.ai_actor==5"  ]
[jump  storage="shigure.ks"  target="*cover2"  cond="f.ai_actor==6"  ]
[jump  storage="yamabuki.ks"  target="*cover2"  cond="f.ai_actor==7"  ]
[jump  storage="gato.ks"  target="*cover2"  cond="f.ai_actor==8"  ]
[jump  storage="urushibara.ks"  target="*cover2"  cond="f.ai_actor==9"  ]
*back

[jump  storage="cover.ks"  target="*reset"  ]
*reset

[jump  storage="AI.ks"  target="*randam_ai"  ]
