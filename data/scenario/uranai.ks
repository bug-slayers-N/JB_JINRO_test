[_tb_system_call storage=system/_uranai.ks]

*uranai_randam

[iscript]
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
var aliveArr=String(f.alive).split(",");
var lr=String(f.liar).split(",");
var sr1=String(f.seer_result1).split(",");
var sr2=String(f.seer_result2).split(",");
var seerNum=0;
for(var i=1;i<=5;i++){if(roles[i-1]===3){seerNum=i;break;}}
var alreadyPicked=[];
if(parseInt(sr1[0])>0) alreadyPicked.push(parseInt(sr1[0]));
if(parseInt(sr2[0])>0) alreadyPicked.push(parseInt(sr2[0]));
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function allLiar5(c){
for(var j=1;j<=5;j++){
if(j===c)continue;
if(aliveArr[j-1]==="0")continue;
if(lr[gi(j,c)]!=="5")return false;
}
return true;
}
var candidates=[];
var fallback=[];
for(var i=1;i<=5;i++){
if(i===seerNum)continue;
if(aliveArr[i-1]==="0")continue;
if(alreadyPicked.indexOf(i)>=0)continue;
if(allLiar5(i)){fallback.push(i);}
else{candidates.push(i);}
}
if(candidates.length===0) candidates=fallback;
f.target=candidates.length>0?candidates[Math.floor(Math.random()*candidates.length)]:0;
[endscript]

*uranai

[iscript]
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
var tgt=parseInt(f.target);
var res=(roles[tgt-1]===1)?1:0;
var sr1=String(f.seer_result1).split(",");
if(parseInt(sr1[0])===0){
f.seer_result1=String(tgt)+","+String(res);
} else {
f.seer_result2=String(tgt)+","+String(res);
}
[endscript]

[return  ]
*game_start

[iscript]
var names=["真経津","獅子神","村雨","叶","天堂"];
var sr2=String(f.seer_result2).split(",");
var useResult2=(parseInt(sr2[0])>0);
var sr=useResult2?sr2:String(f.seer_result1).split(",");
f.name=names[parseInt(sr[0])-1];
f.result=(parseInt(sr[1])===1)?"人狼":"人間";
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
var names=["真経津","獅子神","村雨","叶","天堂"];
var sr2=String(f.seer_result2).split(",");
var useResult2=(parseInt(sr2[0])>0);
var sr=useResult2?sr2:String(f.seer_result1).split(",");
f.name=names[parseInt(sr[0])-1];
f.result=(parseInt(sr[1])===1)?"人狼":"人間";
[endscript]

[tb_start_tyrano_code]
#システム
占いの結果：[emb exp="f.name"]は[emb exp="f.result"]です[p]
[_tb_end_tyrano_code]

[jump  storage="night.ks"  target="*uranai_back"  ]
*true_CO

[jump  storage="uranai.ks"  target="*player_CO"  cond="f.role!=3"  ]
[tb_eval  exp="f.ai_actor=0"  name="ai_actor"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
*player_CO

[iscript]
var actorNum=parseInt(f.ai_actor)>0?parseInt(f.ai_actor):parseInt(f.player);
var sr1=String(f.seer_result1).split(",");
var claim=String(f.claim).split(",");
var coArr=String(f.co).split(",");
var idx=(actorNum-1)*2;
claim[idx]=sr1[0];
claim[idx+1]=sr1[1];
coArr[actorNum-1]="1";
f.claim=claim.join(",");
f.co=coArr.join(",");
[endscript]

[return  ]
*fake_CO

[iscript]
var actorNum=parseInt(f.ai_actor)>0?parseInt(f.ai_actor):parseInt(f.player);
var actorRole=parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][actorNum-1]);
var claim=String(f.claim).split(",");
var coArr=String(f.co).split(",");
var idx=(actorNum-1)*2;
if(actorRole===1){
// 人狼：未COキャラからランダム1人を人間と申告
var cands=[];
for(var i=1;i<=5;i++){ if(coArr[i-1]==="0"&&i!==actorNum) cands.push(i); }
var t=cands[Math.floor(Math.random()*cands.length)];
claim[idx]=t;
claim[idx+1]=0;
} else if(actorRole===2){
// 狂人：対象も結果も完全ランダム
var cands=[];
for(var i=1;i<=5;i++){ if(i!==actorNum) cands.push(i); }
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
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getLiar(a,b){return parseInt(lr[gi(a,b)]);}
function getCalm(num){
if(num===1)return parseFloat(f.mafutsu_calm);
if(num===2)return parseFloat(f.sisigami_calm);
if(num===3)return parseFloat(f.murasame_calm);
if(num===4)return parseFloat(f.kano_calm);
return parseFloat(f.tendo_calm);
}
var playerNum=parseInt(f.player);
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
var claim2=String(f.claim2).split(",");
var lr=String(f.liar).split(",");
for(var actor=1;actor<=5;actor++){
if(actor===playerNum) continue;
if(aliveArr[actor-1]==="0") continue;
if(coArr[actor-1]!=="1") continue;
var actorRole=parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][actor-1]);
if(actorRole!==1&&actorRole!==2) continue;
var claim=String(f.claim).split(",");
var idx=(actor-1)*2;
var firstReport=parseInt(claim[idx]);
var tgt=0;
var res=0;
var cands=[];
for(var i=1;i<=5;i++){
if(i===actor) continue;
if(aliveArr[i-1]==="0") continue;
if(i===firstReport) continue;
cands.push(i);
}
if(actorRole===1){
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
var n=cands.length;
var midIdx=(n%2===1)?Math.floor(n/2):-1;
if(midIdx>=0&&pick===midIdx){
res=0;
} else if(pick<Math.ceil(n/2)){
res=1;
} else {
res=0;
}
tgt=cands[pick];
}
}
}
} else if(actorRole===2){
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
