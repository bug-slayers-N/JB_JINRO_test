*addition

[iscript]
// ===== 1人目の元々のアクション種別を保持（落選時のフォールバック用） =====
f.display06=f.jump;

var n=parseInt(f.gamemode);
var actor1=parseInt(f.ai_actor);
var target=parseInt(f.target);
var aliveArr=String(f.alive).split(",");
function isAlive(i){return aliveArr[i-1]==="1";}
var lr=String(f.liar).split(",");
var lk=String(f.like).split(",");
var calmArr=String(f.calm).split(",");
function getCalm(i){return parseFloat(calmArr[i-1]);}
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getPC(actor,tgt){return getCalm(tgt)+parseInt(lk[gi(actor,tgt)]);}
var charArr=String(f.character).split(",");
var playerNum=parseInt(f.player);

// ===== 母集団：1人目(actor1)と対象(target)とプレイヤーを除く生存者 =====
var basePool=[];
for(var i=1;i<=n;i++){
if(i===actor1||i===target||i===playerNum)continue;
if(!isAlive(i))continue;
basePool.push(i);
}

var winner=0;
var decision="";

// ===== 第一抽選：countしきい値プール =====
var threshold=parseInt(f.day)-1;
var countArr=String(f.count).split(",");
var pool1=basePool.filter(function(c){return parseInt(countArr[c-1])<=threshold;});
if(pool1.length>0){
winner=pool1[Math.floor(Math.random()*pool1.length)];
var lv=parseInt(lr[gi(winner,target)]);
if(lv===1||lv===4||lv===5||lv===9){
decision="doubt";
}else if(lv===2||lv>=10){
decision="cover";
}else{
// liar=0または3：知覚平常心フォールバック
var rankPool=[];
for(var i=1;i<=n;i++){
if(i===winner)continue;
if(!isAlive(i))continue;
rankPool.push(i);
}
rankPool.sort(function(a,b){return getPC(winner,b)-getPC(winner,a);});
var rank=rankPool.indexOf(target);
decision=(rank<rankPool.length/2)?"cover":"doubt";
}
}

// ===== 第二抽選：liarプール（第一抽選が空だった場合） =====
if(winner===0){
var pool2=basePool.filter(function(c){
var v=parseInt(lr[gi(c,target)]);
return v===1||v===4||v===5||v===9||v===2||v>=10;
});
if(pool2.length>0){
winner=pool2[Math.floor(Math.random()*pool2.length)];
var v2=parseInt(lr[gi(winner,target)]);
decision=(v2===1||v2===4||v2===5||v2===9)?"doubt":"cover";
}
}

// ===== 第三抽選：人狼身内かばい（9人モード限定・対象が人狼の場合のみ） =====
if(winner===0&&n===9&&parseInt(charArr[target-1])<=5){
var aliveList=[];
for(var i=1;i<=n;i++){if(isAlive(i))aliveList.push(i);}
aliveList.sort(function(a,b){return getCalm(b)-getCalm(a);});
var half=aliveList.length/2;
var pool3=basePool.filter(function(c){
if(parseInt(charArr[c-1])>5)return false;
var rank=aliveList.indexOf(c);
return rank<half;
});
if(pool3.length>0){
winner=pool3[Math.floor(Math.random()*pool3.length)];
decision="cover";
}
}

f.ai_actor=winner;
if(winner>0)f.jump=decision;
[endscript]

[jump  storage="doubt.ks"  target="*reaction_only"  cond="f.display06=='doubt' && f.ai_actor==0"  ]
[jump  storage="cover.ks"  target="*reaction_only"  cond="f.display06=='cover' && f.ai_actor==0"  ]

[iscript]
// ===== 当選時：count+1、効果値は本来の半分 =====
var winnerNum=parseInt(f.ai_actor);
var targetNum=parseInt(f.target);
var countArr2=String(f.count).split(",");
countArr2[winnerNum-1]=String(parseInt(countArr2[winnerNum-1],10)+1);
f.count=countArr2.join(",");

function isAlive2(c){return String(f.alive).split(',')[c-1]==='1';}
function gi2(a,b){var n=parseInt(f.gamemode);var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}

if(f.jump==="doubt"){
var yusaburi;
if(winnerNum===1){yusaburi=0.9;}
else if(winnerNum===2){var steps=[0.5,0.6,0.7,0.8,0.9,1.0];yusaburi=steps[Math.floor(Math.random()*steps.length)];}
else if(winnerNum===3){yusaburi=0.6;}
else if(winnerNum===4){yusaburi=0.7;}
else if(winnerNum===5){yusaburi=0.8;}
else if(winnerNum===6){yusaburi=0.7;if(isAlive2(7))yusaburi*=1.1;}
else if(winnerNum===7){yusaburi=0.8;if(isAlive2(6))yusaburi*=1.1;}
else if(winnerNum===8){yusaburi=0.7;if(isAlive2(9))yusaburi*=1.4;}
else{yusaburi=0.6;}
var damage=(40*yusaburi)/2;
var calmArr2=String(f.calm).split(",");
calmArr2[targetNum-1]=String(parseFloat(calmArr2[targetNum-1])-damage);
f.calm=calmArr2.join(",");
// target→winnerの好感度も本来(-10)の半分だけ減算
var lkArr=String(f.like).split(",");
var likeIdx=gi2(targetNum,winnerNum);
lkArr[likeIdx]=String(parseInt(lkArr[likeIdx])-5);
f.like=lkArr.join(",");
}else{
var murasame=winnerNum===3;
var addVal=(murasame?30:20)/2;
var calmArr2=String(f.calm).split(",");
calmArr2[targetNum-1]=String(parseFloat(calmArr2[targetNum-1])+addVal);
f.calm=calmArr2.join(",");
// target→winnerの好感度も本来の効果値と同じだけ（半減済みのaddVal分）加算
var lkArr=String(f.like).split(",");
var likeIdx=gi2(targetNum,winnerNum);
lkArr[likeIdx]=String(parseInt(lkArr[likeIdx])+addVal);
f.like=lkArr.join(",");
}

// ===== 2人目の台詞演出後、doubt.ks/cover.ksの*showに戻ってきた時にロビーへ再突入しないようフラグを立てる =====
f.display07=1;
// ===== キャラks側で「2人目として呼ばれた」ことを判定するためのフラグ =====
f.display08="add";
[endscript]

[jump  storage="doubt.ks"  target="*dispatch_doubt2"  cond="f.jump=='doubt'"  ]
[jump  storage="cover.ks"  target="*dispatch_cover2"  cond="f.jump=='cover'"  ]
