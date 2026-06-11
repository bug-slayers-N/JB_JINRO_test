[_tb_system_call storage=system/_cover.ks]

*cover

[cm  ]
[tb_eval  exp="f.jump='cover'"  name="jump"  cmd="="  op="t"  val="cover"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listA"  ]
*list_back

[iscript]
var playerNum=parseInt(f.player);
var targetNum=parseInt(f.target);
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getCalm(num){
if(num===1)return parseFloat(f.mafutsu_calm);
if(num===2)return parseFloat(f.sisigami_calm);
if(num===3)return parseFloat(f.murasame_calm);
if(num===4)return parseFloat(f.kano_calm);
return parseFloat(f.tendo_calm);
}
function addCalm(num,val){
if(num===1){f.mafutsu_calm=parseFloat(f.mafutsu_calm)+val;}
else if(num===2){f.sisigami_calm=parseFloat(f.sisigami_calm)+val;}
else if(num===3){f.murasame_calm=parseFloat(f.murasame_calm)+val;}
else if(num===4){f.kano_calm=parseFloat(f.kano_calm)+val;}
else{f.tendo_calm=parseFloat(f.tendo_calm)+val;}
}
var aliveArr=String(f.alive).split(",");
function isAlive(i){return aliveArr[i-1]==="1";}
var actorCalm=getCalm(playerNum);
var lowest=true;
for(var i=1;i<=5;i++){if(!isAlive(i)||i===playerNum)continue;if(getCalm(i)<actorCalm){lowest=false;break;}}
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

[jump  storage="mafutsu.ks"  target="*cover2"  cond="f.player==1"  ]
[jump  storage="sisigami.ks"  target="*cover2"  cond="f.player==2"  ]
[jump  storage="murasame.ks"  target="*cover2"  cond="f.player==3"  ]
[jump  storage="kano.ks"  target="*cover2"  cond="f.player==4"  ]
[jump  storage="tendo.ks"  target="*cover2"  cond="f.player==5"  ]
*show

[call  storage="mafutsu.ks"  target="*shiro"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*shiro"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*shiro"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*shiro"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*shiro"  cond="f.target==5"  ]
[jump  storage="observe.ks"  target="*observe"  ]
*cover_ai

[iscript]
// actorの役職を取得してf.resultに格納（分岐判定用）
f.result=parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][parseInt(f.ai_actor)-1]);
[endscript]

*ai_jinro

[jump  storage="cover.ks"  target="*ai_mad"  cond="f.result!=1"  ]
[iscript]
var actorNum=parseInt(f.ai_actor);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var coArr=String(f.co).split(",");
var claimArr=String(f.claim).split(",");
var claimArr2=String(f.claim2).split(",");
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getCalm(num){
if(num===1)return parseFloat(f.mafutsu_calm);
if(num===2)return parseFloat(f.sisigami_calm);
if(num===3)return parseFloat(f.murasame_calm);
if(num===4)return parseFloat(f.kano_calm);
return parseFloat(f.tendo_calm);
}
function getPC(actor,tgt){return getCalm(tgt)+parseInt(lk[gi(actor,tgt)]);}
function isAlive(i){return aliveArr[i-1]==="1";}
function reportedWolf(actor,c){
var idx=(c-1)*2;
if(parseInt(claimArr[idx])===actor&&claimArr[idx+1]==="1")return true;
if(parseInt(claimArr2[idx])===actor&&claimArr2[idx+1]==="1")return true;
return false;
}
var actorCO=coArr[actorNum-1]!=="0";
var candidates=[];
for(var i=1;i<=5;i++){
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

[jump  storage="cover.ks"  target="*ai_seer"  cond="f.result!=2"  ]
[iscript]
var actorNum=parseInt(f.ai_actor);
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
var claimArr=String(f.claim).split(",");
var claimArr2=String(f.claim2).split(",");
var actorCO=coArr[actorNum-1]!=="0";
function isAlive(i){return aliveArr[i-1]==="1";}
function reportedWolf(seer,target){
var idx=(seer-1)*2;
if(parseInt(claimArr[idx])===target&&claimArr[idx+1]==="1")return true;
if(parseInt(claimArr2[idx])===target&&claimArr2[idx+1]==="1")return true;
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
for(var i=1;i<=5;i++){
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

[jump  storage="cover.ks"  target="*ai_vill"  cond="f.result!=3"  ]
[iscript]
var actorNum=parseInt(f.ai_actor);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
var coArr=String(f.co).split(",");
var claimArr=String(f.claim).split(",");
var claimArr2=String(f.claim2).split(",");
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function isAlive(i){return aliveArr[i-1]==="1";}
function hasCO(i){return coArr[i-1]!=="0";}
function isLiarFor(actor,tgt){var v=parseInt(lr[gi(actor,tgt)]);return v===1||v===3||v===4;}
function reportedWolf(actor,c){
var idx=(c-1)*2;
if(parseInt(claimArr[idx])===actor&&claimArr[idx+1]==="1")return true;
if(parseInt(claimArr2[idx])===actor&&claimArr2[idx+1]==="1")return true;
return false;
}
var actorCO=coArr[actorNum-1]!=="0";
var sr1=String(f.seer_result1).split(",");
var sr2=String(f.seer_result2).split(",");
var humanResult=[];
var wolfResult=[];
if(parseInt(sr1[0])>0){if(parseInt(sr1[1])===0)humanResult.push(parseInt(sr1[0]));else wolfResult.push(parseInt(sr1[0]));}
if(parseInt(sr2[0])>0){if(parseInt(sr2[1])===0)humanResult.push(parseInt(sr2[0]));else wolfResult.push(parseInt(sr2[0]));}
var target=0;
var humanCands=humanResult.filter(function(c){
return isAlive(c)&&c!==actorNum&&!reportedWolf(actorNum,c)&&(!actorCO||!hasCO(c));
});
if(humanCands.length>0){target=humanCands[0];}
if(target===0){
var excluded=wolfResult;
if(!actorCO){
var coChars=[];
for(var i=1;i<=5;i++){if(isAlive(i)&&i!==actorNum&&hasCO(i)&&!reportedWolf(actorNum,i))coChars.push(i);}
if(coChars.length>=2){
var liarCO=coChars.filter(function(c){return isLiarFor(actorNum,c);});
var honestCO=coChars.filter(function(c){return !isLiarFor(actorNum,c)&&excluded.indexOf(c)===-1;});
if(liarCO.length>0&&honestCO.length>0){target=honestCO[0];}
}
}
if(target===0){
for(var i=1;i<=5;i++){
if(i===actorNum||!isAlive(i)||excluded.indexOf(i)!==-1||reportedWolf(actorNum,i))continue;
if(actorCO&&hasCO(i))continue;
if(parseInt(lk[gi(actorNum,i)])>=30){target=i;break;}
}
}
if(target===0){
var pool=[];
for(var i=1;i<=5;i++){
if(i===actorNum||!isAlive(i)||excluded.indexOf(i)!==-1||hasCO(i)||reportedWolf(actorNum,i))continue;
if(actorCO&&hasCO(i))continue;
if(parseInt(lk[gi(i,actorNum)])>=0)pool.push(i);
}
if(pool.length>0){
target=pool[Math.floor(Math.random()*pool.length)];
}else{
var best=-999999,bestChar=-1;
for(var i=1;i<=5;i++){
if(i===actorNum||!isAlive(i)||excluded.indexOf(i)!==-1||reportedWolf(actorNum,i))continue;
if(actorCO&&hasCO(i))continue;
var v=parseInt(lk[gi(i,actorNum)]);
if(v>best||(v===best&&i<bestChar)){best=v;bestChar=i;}
}
if(bestChar>0)target=bestChar;
}
}
}
f.target=target;
[endscript]

[jump  storage="cover.ks"  target="*back"  cond="f.target==0"  ]
[jump  storage="cover.ks"  target="*ai_calc"  ]
*ai_vill

[iscript]
var actorNum=parseInt(f.ai_actor);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
var coArr=String(f.co).split(",");
var claimArr=String(f.claim).split(",");
var claimArr2=String(f.claim2).split(",");
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function isAlive(i){return aliveArr[i-1]==="1";}
function hasCO(i){return coArr[i-1]!=="0";}
function isLiarFor(actor,tgt){var v=parseInt(lr[gi(actor,tgt)]);return v===1||v===3||v===4;}
function reportedWolf(actor,c){
var idx=(c-1)*2;
if(parseInt(claimArr[idx])===actor&&claimArr[idx+1]==="1")return true;
if(parseInt(claimArr2[idx])===actor&&claimArr2[idx+1]==="1")return true;
return false;
}
var target=0;
var coChars=[];
for(var i=1;i<=5;i++){if(isAlive(i)&&i!==actorNum&&hasCO(i)&&!reportedWolf(actorNum,i))coChars.push(i);}
if(coChars.length>=2){
var liarCO=coChars.filter(function(c){return isLiarFor(actorNum,c);});
var honestCO=coChars.filter(function(c){return !isLiarFor(actorNum,c);});
if(liarCO.length>0&&honestCO.length>0){target=honestCO[0];}
}
if(target===0){
for(var i=1;i<=5;i++){
if(i===actorNum||!isAlive(i)||reportedWolf(actorNum,i))continue;
if(parseInt(lk[gi(actorNum,i)])>=30){target=i;break;}
}
}
if(target===0){
var pool=[];
for(var i=1;i<=5;i++){
if(i===actorNum||!isAlive(i)||hasCO(i)||reportedWolf(actorNum,i))continue;
if(parseInt(lk[gi(i,actorNum)])>=0)pool.push(i);
}
if(pool.length>0){
target=pool[Math.floor(Math.random()*pool.length)];
}else{
var best=-999999,bestChar=-1;
for(var i=1;i<=5;i++){
if(i===actorNum||!isAlive(i)||reportedWolf(actorNum,i))continue;
var v=parseInt(lk[gi(i,actorNum)]);
if(v>best||(v===best&&i<bestChar)){best=v;bestChar=i;}
}
if(bestChar>0)target=bestChar;
}
}
f.target=target;
[endscript]

[jump  storage="cover.ks"  target="*back"  cond="f.target==0"  ]
[jump  storage="cover.ks"  target="*ai_calc"  ]
*ai_calc

[iscript]
var actorNum=parseInt(f.ai_actor);
var targetNum=parseInt(f.target);
var aliveArr=String(f.alive).split(",");
var lk=String(f.like).split(",");
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getCalm(num){
if(num===1)return parseFloat(f.mafutsu_calm);
if(num===2)return parseFloat(f.sisigami_calm);
if(num===3)return parseFloat(f.murasame_calm);
if(num===4)return parseFloat(f.kano_calm);
return parseFloat(f.tendo_calm);
}
function addCalm(num,val){
if(num===1){f.mafutsu_calm=parseFloat(f.mafutsu_calm)+val;}
else if(num===2){f.sisigami_calm=parseFloat(f.sisigami_calm)+val;}
else if(num===3){f.murasame_calm=parseFloat(f.murasame_calm)+val;}
else if(num===4){f.kano_calm=parseFloat(f.kano_calm)+val;}
else{f.tendo_calm=parseFloat(f.tendo_calm)+val;}
}
function isAlive(i){return aliveArr[i-1]==="1";}
var actorCalm=getCalm(actorNum);
var lowest=true;
for(var i=1;i<=5;i++){if(!isAlive(i)||i===actorNum)continue;if(getCalm(i)<actorCalm){lowest=false;break;}}
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

[jump  storage="mafutsu.ks"  target="*cover2"  cond="f.ai_actor==1"  ]
[jump  storage="sisigami.ks"  target="*cover2"  cond="f.ai_actor==2"  ]
[jump  storage="murasame.ks"  target="*cover2"  cond="f.ai_actor==3"  ]
[jump  storage="kano.ks"  target="*cover2"  cond="f.ai_actor==4"  ]
[jump  storage="tendo.ks"  target="*cover2"  cond="f.ai_actor==5"  ]
*back

[jump  storage="cover.ks"  target="*reset"  ]
*reset

[jump  storage="AI.ks"  target="*randam_ai"  ]
