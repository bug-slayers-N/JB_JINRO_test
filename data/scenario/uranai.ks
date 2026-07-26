[_tb_system_call storage=system/_uranai.ks]

*uranai_randam

[iscript]
var n=parseInt(f.gamemode);
var roles=String(f.character).split(",").map(Number);
var aliveArr=String(f.alive).split(",");
var lr=String(f.liar).split(",");
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getSeerResults(){
if(String(f.seer_result)==="0")return [];
var arr=String(f.seer_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
var seerNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===10){seerNum=i;break;}}
var alreadyPicked=getSeerResults().map(function(r){return r[0];});
function allLiarClean(c){
for(var j=1;j<=n;j++){
if(j===c)continue;
if(aliveArr[j-1]==="0")continue;
if(lr[gi(j,c)]!=="5")return false;
}
return true;
}
var candidates=[];
var fallback=[];
for(var i=1;i<=n;i++){
if(i===seerNum)continue;
if(aliveArr[i-1]==="0")continue;
if(alreadyPicked.indexOf(i)>=0)continue;
if(allLiarClean(i)){fallback.push(i);}
else{candidates.push(i);}
}
if(candidates.length===0) candidates=fallback;
f.target=candidates.length>0?candidates[Math.floor(Math.random()*candidates.length)]:0;
[endscript]

*uranai

[iscript]
var roles=String(f.character).split(",").map(Number);
var tgt=parseInt(f.target);
var res=(roles[tgt-1]<=5)?1:0;
function addSeerResult(target,result){
if(String(f.seer_result)==="0"){f.seer_result=target+","+result;}
else{f.seer_result=f.seer_result+","+target+","+result;}
}
addSeerResult(tgt,res);
[endscript]

[return  ]
*game_start

[iscript]
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
function getSeerResults(){
if(String(f.seer_result)==="0")return [];
var arr=String(f.seer_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
var results=getSeerResults();
var latest=results[results.length-1];
f.name=names[latest[0]];
f.result=(latest[1]===1)?"人狼":"人間";
[endscript]

[tb_start_tyrano_code]
#システム
昨夜の結果：[emb exp="f.name"]は[emb exp="f.result"]です[p]
[_tb_end_tyrano_code]

[return  ]
*uranai_night

[tb_start_text mode=1 ]
#システム
占い対象を選んでください。[p]
[_tb_end_text]

[tb_eval  exp="f.jump='uranai'"  name="jump"  cmd="="  op="t"  val="uranai"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listB"  ]
*uranai_back

[tb_show_message_window  ]
[call  storage="uranai.ks"  target="*uranai"  ]
[iscript]
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
function getSeerResults(){
if(String(f.seer_result)==="0")return [];
var arr=String(f.seer_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
var results=getSeerResults();
var latest=results[results.length-1];
f.name=names[latest[0]];
f.result=(latest[1]===1)?"人狼":"人間";
[endscript]

[tb_start_tyrano_code]
#システム
占いの結果：[emb exp="f.name"]は[emb exp="f.result"]です[p]
[_tb_end_tyrano_code]

[jump  storage="night.ks"  target="*uranai_back"  ]
*true_CO

[jump  storage="uranai.ks"  target="*player_CO"  cond="f.role!=10"  ]
[tb_eval  exp="f.ai_actor=0"  name="ai_actor"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
*player_CO

[iscript]
var actorNum=parseInt(f.ai_actor)>0?parseInt(f.ai_actor):parseInt(f.player);
function getSeerResults(){
if(String(f.seer_result)==="0")return [];
var arr=String(f.seer_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
var first=getSeerResults()[0];
var claim=String(f.claim).split(",");
var coArr=String(f.co).split(",");
var idx=(actorNum-1)*2;
claim[idx]=String(first[0]);
claim[idx+1]=String(first[1]);
coArr[actorNum-1]="1";
f.claim=claim.join(",");
f.co=coArr.join(",");
[endscript]

[return  ]
*fake_CO

[iscript]
var roles=String(f.character).split(",").map(Number);
var actorNum=parseInt(f.ai_actor)>0?parseInt(f.ai_actor):parseInt(f.player);
var actorRole=roles[actorNum-1];
var claim=String(f.claim).split(",");
var coArr=String(f.co).split(",");
var idx=(actorNum-1)*2;
var n=parseInt(f.gamemode);
if(actorRole<=5){
// 人狼：未COキャラからランダム1人を人間と申告
var cands=[];
for(var i=1;i<=n;i++){ if(coArr[i-1]==="0"&&i!==actorNum) cands.push(i); }
var t=cands[Math.floor(Math.random()*cands.length)];
claim[idx]=t;
claim[idx+1]=0;
} else if(actorRole===9){
// 狂人：対象も結果も完全ランダム
var cands=[];
for(var i=1;i<=n;i++){ if(i!==actorNum) cands.push(i); }
var t=cands[Math.floor(Math.random()*cands.length)];
claim[idx]=t;
claim[idx+1]=Math.floor(Math.random()*2);
}
coArr[actorNum-1]="1";
f.claim=claim.join(",");
f.co=coArr.join(",");
[endscript]

[return  ]
*fake_CO2

[iscript]
var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getLiar(a,b){return parseInt(lr[gi(a,b)]);}
function getCalm(num){return parseFloat(String(f.calm).split(",")[num-1]);}
var roles=String(f.character).split(",").map(Number);
var playerNum=parseInt(f.player);
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
var claim2=String(f.claim2).split(",");
var lr=String(f.liar).split(",");
for(var actor=1;actor<=n;actor++){
if(actor===playerNum) continue;
if(aliveArr[actor-1]==="0") continue;
if(coArr[actor-1]!=="1") continue;
var actorRole=roles[actor-1];
if(actorRole>=10) continue;
var claim=String(f.claim).split(",");
var idx=(actor-1)*2;
var firstReport=parseInt(claim[idx]);
var tgt=0;
var res=0;
var cands=[];
for(var i=1;i<=n;i++){
if(i===actor) continue;
if(aliveArr[i-1]==="0") continue;
if(i===firstReport) continue;
cands.push(i);
}
if(actorRole<=5){
if(cands.length===1){
var saidWolf=(parseInt(claim[idx+1])===1);
tgt=cands[0];
res=saidWolf?0:1;
} else {
var liarList=cands.filter(function(c){var l=getLiar(actor,c);return l===1||l===4;});
if(liarList.length>0){
tgt=liarList[0];res=1;
} else {
var coList=cands.filter(function(c){return coArr[c-1]==="1";});
if(coList.length>0){
tgt=coList[0];res=1;
} else {
cands.sort(function(a,b){return getCalm(a)-getCalm(b);});
var pick=Math.floor(Math.random()*cands.length);
var clen=cands.length;
var midIdx=(clen%2===1)?Math.floor(clen/2):-1;
if(midIdx>=0&&pick===midIdx){
res=0;
} else if(pick<Math.ceil(clen/2)){
res=1;
} else {
res=0;
}
tgt=cands[pick];
}
}
}
} else if(actorRole===9){
var saidWolf2=(parseInt(claim[idx+1])===1);
if(saidWolf2){
tgt=cands[Math.floor(Math.random()*cands.length)];res=0;
} else {
tgt=cands[Math.floor(Math.random()*cands.length)];
res=Math.floor(Math.random()*2);
}
}
claim2[idx]=String(tgt);
claim2[idx+1]=String(res);
}
f.claim2=claim2.join(",");
[endscript]

[return  ]
