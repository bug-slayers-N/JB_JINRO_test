[_tb_system_call storage=system/_specialist.ks]

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
function allLiarClean(c){ // 生存者全員からcが村人確定(15)と見なされているか
for(var j=1;j<=n;j++){
if(j===c)continue;
if(aliveArr[j-1]==="0")continue;
if(lr[gi(j,c)]!=="15")return false;
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

*seer_result

[iscript]
var n=parseInt(f.gamemode);
var roles=String(f.character).split(",").map(Number);
var tgt=parseInt(f.target);
var seerNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===10){seerNum=i;break;}}
function addSeerResult(target,result){
if(String(f.seer_result)==="0"){f.seer_result=target+","+result;}
else{f.seer_result=f.seer_result+","+target+","+result;}
}
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
if(tgt>0){ // 候補が居ない(target===0)場合は不正データを記録しない
var res=(roles[tgt-1]<=5)?1:0;
addSeerResult(tgt,res);
if(seerNum>0){
// 本人視点のliarを更新：人狼結果は一律5、人間結果は0→3・1→9、2以上は更新しない
var lr=String(f.liar).split(",");
var idx=gi(seerNum,tgt);
var cur=parseInt(lr[idx]);
if(res===1){
lr[idx]="5";
}else if(cur===0){
lr[idx]="3";
}else if(cur===1){
lr[idx]="9";
}
f.liar=lr.join(",");
}
}
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
*seer_add_sclaim

[iscript]
// 占い師（character配列でrole=10のキャラ）を探す
var seerChar=0;
var charArr=String(f.character).split(',');
for(var i=0;i<charArr.length;i++){
if(parseInt(charArr[i])===10){seerChar=i+1;break;}
}
if(seerChar>0){
// seer_resultを取得 [[target,result],...]（添字0=0日目=最初のランダム占い,添字1=1日目...）
function getSeerResults(){
if(String(f.seer_result)==="0")return [];
var arr=String(f.seer_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
// sclaimを取得 [[day,reporter,target,result],...]
function getSclaim(){
if(String(f.sclaim)==="0")return [];
var arr=String(f.sclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
var seerResults=getSeerResults();
var sclaimArr=getSclaim();
for(var d=0;d<seerResults.length;d++){
var day=d; // 最初のペア(添字0)は最初のランダム占い＝day0
var target=seerResults[d][0];
var result=seerResults[d][1];
// 同じday・同じreporter(seerChar)のエントリがsclaimに既にあるか確認
var exists=false;
for(var j=0;j<sclaimArr.length;j++){
if(sclaimArr[j][0]===day && sclaimArr[j][1]===seerChar){exists=true;break;}
}
if(!exists){
// addSclaim()はf.dayを自動使用するため、実際に占った日付を保持するためここでは直接追記する
var entry=day+","+seerChar+","+target+","+result;
if(String(f.sclaim)==="0"){f.sclaim=entry;}
else{f.sclaim=f.sclaim+","+entry;}
}
}
}
[endscript]

[return  ]
*psychic_add_pclaim

[iscript]
// 霊媒師（character配列でrole=11のキャラ）を探す
var psychicChar=0;
var charArr=String(f.character).split(',');
for(var i=0;i<charArr.length;i++){
if(parseInt(charArr[i])===11){psychicChar=i+1;break;}
}
if(psychicChar>0){
// psychic_resultを取得 [[target,result],...]（添字0が最も左＝day1の結果、添字1=day2...）
function getPsychicResults(){
if(String(f.psychic_result)==="0")return [];
var arr=String(f.psychic_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
// pclaimを取得 [[day,reporter,target,result],...]
function getPclaim(){
if(String(f.pclaim)==="0")return [];
var arr=String(f.pclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
var psychicResults=getPsychicResults();
var pclaimArr=getPclaim();
for(var d=0;d<psychicResults.length;d++){
var day=d+1; // 最も左のペア(添字0)はday1
var target=psychicResults[d][0];
var result=psychicResults[d][1];
// 同じday・同じreporter(psychicChar)のエントリがpclaimに既にあるか確認
var exists=false;
for(var j=0;j<pclaimArr.length;j++){
if(pclaimArr[j][0]===day && pclaimArr[j][1]===psychicChar){exists=true;break;}
}
if(!exists){
var entry=day+","+psychicChar+","+target+","+result;
if(String(f.pclaim)==="0"){f.pclaim=entry;}
else{f.pclaim=f.pclaim+","+entry;}
}
}
}
[endscript]

[return  ]
*fake_seer

[iscript]
f.display01=(parseInt(f.ai_actor)===parseInt(f.player))?1:0;
[endscript]

[jump  storage="specialist.ks"  target="*fake_seer_AI"  cond="f.display01==0"  ]
*fake_seer_player

[tb_start_text mode=1 ]
#システム
誰を占ったことにしますか？[p]
[_tb_end_text]

[tb_eval  exp="f.jump='fakeseer'"  name="jump"  cmd="="  op="t"  val="fakeseer"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listB"  ]
*fakeseer_back

[tb_start_text mode=1 ]
#システム
結果はどちらにしますか？[p]
[_tb_end_text]

[glink  color="black"  storage="specialist.ks"  size="20"  autopos="true"  text="人間"  target="*fake_seer_player_human"  ]
[glink  color="black"  storage="specialist.ks"  size="20"  autopos="true"  text="人狼"  target="*fake_seer_player_wolf"  ]
[s  ]
*fake_seer_player_human

[tb_eval  exp="f.display01=0"  name="display01"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="specialist.ks"  target="*fake_seer_end"  ]
*fake_seer_player_wolf

[tb_eval  exp="f.display01=1"  name="display01"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="specialist.ks"  target="*fake_seer_end"  ]
*fake_seer_AI

[iscript]
var n=parseInt(f.gamemode);
var actorNum=parseInt(f.ai_actor);
var roles=String(f.character).split(",").map(Number);
var actorRole=roles[actorNum-1];
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getLiar(a,b){return parseInt(String(f.liar).split(',')[gi(a,b)]);}
function getSclaim(){
if(String(f.sclaim)==="0")return [];
var arr=String(f.sclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
var sclaimArr=getSclaim();
// 自分が過去にsclaimで対象にした相手は除外(同じ相手を二度占ったことにしない)
// CO時点(初回申告)はsclaim履歴が無いため、この除外は自然に無害(空配列)になる
var alreadyPicked=[];
for(var i=0;i<sclaimArr.length;i++){
if(sclaimArr[i][1]===actorNum) alreadyPicked.push(sclaimArr[i][2]);
}
var t=0,res=0;
if(actorRole<=5){
// 人狼：未CO・生存・自分以外・未占い済みからランダムに1人選ぶ。自分視点でliar=4(囮指定)の相手は通常プールから除外する
var cands=[];
var coExcluded=[]; // CO済み、またはliar=4(囮指定)につき通常プールからは除外した相手
for(var i=1;i<=n;i++){
if(i===actorNum)continue;
if(aliveArr[i-1]==="0")continue;
if(alreadyPicked.indexOf(i)>=0)continue;
if(coArr[i-1]!=="0"||getLiar(actorNum,i)===4){coExcluded.push(i);continue;}
cands.push(i);
}
if(cands.length>0){
// 通常プールから選出：人間と申告
t=cands[Math.floor(Math.random()*cands.length)];
res=0;
}else if(coExcluded.length>0){
// 通常プール切れ：coExcluded内にliar=4(囮指定)の相手がいればそこから優先的に選び人狼と申告、いなければ人間と申告
var decoyPool=coExcluded.filter(function(c){return getLiar(actorNum,c)===4;});
if(decoyPool.length>0){
t=decoyPool[Math.floor(Math.random()*decoyPool.length)];
res=1;
}else{
t=coExcluded[Math.floor(Math.random()*coExcluded.length)];
res=0;
}
}else{
// 復帰後も候補切れ：無効値の9,9センチネルをそのままsclaimに書き込む
t=9;
res=9;
}
}else if(actorRole===9){
// 狂人：生存・自分以外・未占い済みからランダムに1人選び、結果もランダム
var cands=[];
for(var i=1;i<=n;i++){
if(i===actorNum)continue;
if(aliveArr[i-1]==="0")continue;
if(alreadyPicked.indexOf(i)>=0)continue;
cands.push(i);
}
if(cands.length>0){
t=cands[Math.floor(Math.random()*cands.length)];
res=Math.floor(Math.random()*2);
}else{
t=9;
res=9;
}
}
f.target=t;
f.display01=res;
[endscript]

*fake_seer_end

[iscript]
var actor=parseInt(f.ai_actor);
var day=parseInt(f.day);
var mainDay=day-1; // 今回発表するメインの報告のday
var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getSclaim(){
if(String(f.sclaim)==="0")return [];
var arr=String(f.sclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
function addSclaimRaw(d,reporter,target,result){
var entry=d+","+reporter+","+target+","+result;
if(String(f.sclaim)==="0"){f.sclaim=entry;}
else{f.sclaim=f.sclaim+","+entry;}
// 追加時点でreporter視点のtargetライアーを更新：人間報告→3、人狼報告→4（5以上は上書き禁止）
if(target>0&&target!==reporter){
var lr=String(f.liar).split(',');
var idx=gi(reporter,target);
if(parseInt(lr[idx])<5){
lr[idx]=(result===1)?"4":"3";
f.liar=lr.join(',');
}
}
}
var sclaimArr=getSclaim();
var hasPrior=false;
for(var i=0;i<sclaimArr.length;i++){
if(sclaimArr[i][1]===actor){hasPrior=true;break;}
}
if(!hasPrior){
// 初回CO：day0〜(mainDay-1)を過去データとしてランダム生成して埋める
// character変数で11以上(霊媒師・村人等)のキャラを生存死亡問わずランダムに選び、人間と報告
var roles=String(f.character).split(",").map(Number);
var safeCands=[];
for(var i=1;i<=n;i++){
if(roles[i-1]>=11)safeCands.push(i);
}
for(var d=0;d<mainDay;d++){
var bt=safeCands.length>0?safeCands[Math.floor(Math.random()*safeCands.length)]:actor;
addSclaimRaw(d,actor,bt,0);
}
}
addSclaimRaw(mainDay,actor,parseInt(f.target),parseInt(f.display01));
[endscript]

[return  ]
*fake_psychic

[iscript]
var day=parseInt(f.day);
var mainDay=day-1; // 今回発表するメインの報告のday
function getPsychicResults(){
if(String(f.psychic_result)==="0")return [];
var arr=String(f.psychic_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
var presults=getPsychicResults();
var todays=presults[mainDay-1]; // psychic_resultは添字0=day1なので、pclaimのmainDay(=f.day-1)に対応する添字はmainDay-1
f.target=todays?todays[0]:0;
f.display01=(parseInt(f.ai_actor)===parseInt(f.player))?1:0;
[endscript]

[jump  storage="specialist.ks"  target="*fake_psychic_none"  cond="f.target<=0"  ]
[jump  storage="specialist.ks"  target="*fake_psychic_AI"  cond="f.display01==0"  ]
*fake_psychic_player

[tb_start_text mode=1 ]
#システム
前回の処刑結果はどうされますか？[p]
[_tb_end_text]

[glink  color="black"  storage="specialist.ks"  size="20"  autopos="true"  text="人間"  target="*fake_psychic_player_human"  ]
[glink  color="black"  storage="specialist.ks"  size="20"  autopos="true"  text="人狼"  target="*fake_psychic_player_wolf"  ]
[s  ]
*fake_psychic_player_human

[tb_eval  exp="f.display01=0"  name="display01"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="specialist.ks"  target="*fake_psychic_end"  ]
*fake_psychic_player_wolf

[tb_eval  exp="f.display01=1"  name="display01"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="specialist.ks"  target="*fake_psychic_end"  ]
*fake_psychic_none

[tb_eval  exp="f.display01=0"  name="display01"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="specialist.ks"  target="*fake_psychic_end"  ]
*fake_psychic_AI

[iscript]
var actor=parseInt(f.ai_actor);
var n=parseInt(f.gamemode);
var roles=String(f.character).split(",").map(Number);
var actorRole=roles[actor-1];
var dead=parseInt(f.target);
var day=parseInt(f.day);
var mainDay=day-1; // 今回発表するメインの報告のday
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getLiar(a,b){return parseInt(String(f.liar).split(',')[gi(a,b)]);}
function getPclaim(){
if(String(f.pclaim)==="0")return [];
var arr=String(f.pclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
var pclaimArr=getPclaim();
// これまでにこのactorが「人狼」と報告した回数（上限チェック用・人狼側のみ使用）
var wolfReportsSoFar=0;
for(var i=0;i<pclaimArr.length;i++){
if(pclaimArr[i][1]===actor && pclaimArr[i][3]===1) wolfReportsSoFar++;
}
function getSclaim(){
if(String(f.sclaim)==="0")return [];
var arr=String(f.sclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
var coArr=String(f.co).split(",");
var res;
if(actorRole<=5){
// 人狼：①1度でも人狼報告済みなら以後は人間固定 ②未報告かつ仲間の人狼が死んだら素直に人狼
// ③未報告かつ初日処刑者の報告でsclaim未登場・CO数少なめなら人狼、それ以外は人間
if(wolfReportsSoFar>=1){
// ①人狼を1度でも報告済みなら、以後は問答無用で人間報告
res=0;
}else if(roles[dead-1]<=5){
// ②未報告かつ死んだキャラが仲間の人狼(role<=5)なら、素直に人狼報告
res=1;
}else if(mainDay===1){
// 未報告かつ初日処刑者の報告：sclaimに未登場 かつ 占い師CO2人以下・霊媒師CO2人以下 なら人狼報告
var sclaimArr=getSclaim();
var inSclaim=false;
for(var i=0;i<sclaimArr.length;i++){
if(sclaimArr[i][2]===dead){inSclaim=true;break;}
}
var seerCoCount=0,psychicCoCount=0;
for(var i=0;i<coArr.length;i++){
if(coArr[i]==="1")seerCoCount++;
if(coArr[i]==="2")psychicCoCount++;
}
res=(!inSclaim && seerCoCount<=2 && psychicCoCount<=2)?1:0;
}else{
res=0;
}
}else{
// 狂人：キャップなし。自分視点でliar=4(囮指定)なら人狼、それ以外は人間
res=(getLiar(actor,dead)===4)?1:0;
}
f.display01=res;
[endscript]

*fake_psychic_end

[iscript]
var actor=parseInt(f.ai_actor);
var day=parseInt(f.day);
var mainDay=day-1; // 今回発表するメインの報告のday
var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}

function getPsychicResults(){
  if(String(f.psychic_result)==="0")return [];
  var arr=String(f.psychic_result).split(',');
  var res=[];
  for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
  return res;
}
function getPclaim(){
  if(String(f.pclaim)==="0")return [];
  var arr=String(f.pclaim).split(',');
  var res=[];
  for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
  return res;
}
function addPclaimRaw(d,reporter,target,result){
  var entry=d+","+reporter+","+target+","+result;
  if(String(f.pclaim)==="0"){f.pclaim=entry;}
  else{f.pclaim=f.pclaim+","+entry;}
  // 追加時点でreporter視点のtargetライアーを更新：人間報告→3、人狼報告→4（5以上は上書き禁止）
  if(target>0&&target!==reporter){
    var lr=String(f.liar).split(',');
    var idx=gi(reporter,target);
    if(parseInt(lr[idx])<5){
      lr[idx]=(result===1)?"4":"3";
      f.liar=lr.join(',');
    }
  }
}

var presults=getPsychicResults();

var pclaimArr=getPclaim();
var hasPrior=false;
for(var i=0;i<pclaimArr.length;i++){
  if(pclaimArr[i][1]===actor){hasPrior=true;break;}
}
if(!hasPrior){
  // 初回CO：day0〜(mainDay-1)を過去データとしてバックフィル
  // 対象はpsychic_resultの実際の処刑対象をそのまま借用、結果はランダム(処刑無しの日は0)
  for(var d=0;d<mainDay;d++){
    var pastTarget=(d>=1 && presults[d-1]) ? presults[d-1][0] : 0;
    var pastResult=(pastTarget>0) ? Math.floor(Math.random()*2) : 0;
    addPclaimRaw(d,actor,pastTarget,pastResult);
  }
}

// 今回分(mainDay)：対象者はpsychic_resultの実際の処刑対象から取得
// 結果はf.display01(既に決定済みの人間/人狼の偽結果)をそのまま転記
var mainTarget=(mainDay>=1 && presults[mainDay-1]) ? presults[mainDay-1][0] : 0;
addPclaimRaw(mainDay, actor, mainTarget, parseInt(f.display01));
[endscript]

[return  ]
*seer_night

[iscript]
var roles=String(f.character).split(",").map(Number);
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var seerNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===10){seerNum=i;break;}}
if(seerNum===0||aliveArr[seerNum-1]==="0"){
f.jump=0; // 占い師が死亡している（不在は5/9人モードとも無いが念のため）→即リターン
}else{
f.jump=(parseInt(f.role)===10)?1:2;
}
[endscript]

[jump  storage="specialist.ks"  target="*seer_night_end"  cond="f.jump==0"  ]
[jump  storage="specialist.ks"  target="*seer_night_ai"  cond="f.jump==2"  ]
*seer_night_player

[tb_start_text mode=1 ]
#システム
占い対象を選んでください。[p]
[_tb_end_text]

[tb_eval  exp="f.jump='seer'"  name="jump"  cmd="="  op="t"  val="seer"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listA"  ]
*seer_back

[tb_show_message_window  ]
[jump  storage="specialist.ks"  target="*seer_night_write"  ]
*seer_night_ai

[iscript]
var roles=String(f.character).split(",").map(Number);
var n=parseInt(f.gamemode);
var seerNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===10){seerNum=i;break;}}
var aliveArr=String(f.alive).split(",");
function getSeerResults(){
if(String(f.seer_result)==="0")return [];
var arr=String(f.seer_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
var alreadyPicked=getSeerResults().map(function(r){return r[0];});
var cands=[];
for(var i=1;i<=n;i++){
if(i===seerNum)continue;
if(aliveArr[i-1]==="0")continue;
if(alreadyPicked.indexOf(i)>=0)continue;
cands.push(i);
}
f.target=cands.length>0?cands[Math.floor(Math.random()*cands.length)]:0;
[endscript]

*seer_night_write

[call  storage="specialist.ks"  target="*seer_result"  ]
[jump  storage="specialist.ks"  target="*seer_night_end"  cond="f.role!=10"  ]
[iscript]
var roles=String(f.character).split(",").map(Number);
var tgt=parseInt(f.target);
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
f.name=(tgt>0)?names[tgt]:"";
f.result=(tgt>0)?((roles[tgt-1]<=5)?"人狼":"人間"):"";
[endscript]

[jump  storage="specialist.ks"  target="*seer_night_end"  cond="f.target<=0"  ]
[tb_start_tyrano_code]
#システム
占いの結果：[emb exp="f.name"]は[emb exp="f.result"]です[p]
[_tb_end_tyrano_code]

*seer_night_end

[return  ]
*psychic_night

[iscript]
var roles=String(f.character).split(",").map(Number);
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var psychicNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===11){psychicNum=i;break;}}
var dead=parseInt(f.role2);
var hasExecution=(dead>0);
function addPsychicResult(target,result){
if(String(f.psychic_result)==="0"){f.psychic_result=target+","+result;}
else{f.psychic_result=f.psychic_result+","+target+","+result;}
}
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var res=0;
if(psychicNum>0){
// 本物霊媒師の生死に関わらず毎晩記録を続ける（処刑が無かった晩も対象者0・結果0で記録し、添字とdayを常に一致させる）
res=hasExecution?((roles[dead-1]<=5)?1:0):0;
addPsychicResult(hasExecution?dead:0,res);
if(hasExecution){
// 本人視点のliarを更新：人狼結果は一律5、人間結果は0→3・1→9、2以上は更新しない
var lr=String(f.liar).split(",");
var idx=gi(psychicNum,dead);
var cur=parseInt(lr[idx]);
if(res===1){
lr[idx]="5";
}else if(cur===0){
lr[idx]="3";
}else if(cur===1){
lr[idx]="9";
}
f.liar=lr.join(",");
}
}
// jump: 0=このモードに霊媒師不在／3=記帳直後だが本人死亡につき即終了／0=生存だがplayerが霊媒師でない／1=表示あり／2=処刑無しの表示
if(psychicNum===0){
f.jump=0;
}else if(aliveArr[psychicNum-1]==="0"){
f.jump=3;
}else if(parseInt(f.role)!==11){
f.jump=0;
}else{
f.jump=hasExecution?1:2;
}
f.name=hasExecution?names[dead]:"";
f.result=(res===1)?"人狼":"人間";
[endscript]

[jump  storage="specialist.ks"  target="*psychic_night_end"  cond="f.jump==0"  ]
[jump  storage="specialist.ks"  target="*psychic_night_end"  cond="f.jump==3"  ]
[jump  storage="specialist.ks"  target="*psychic_night_none"  cond="f.jump==2"  ]
[tb_start_tyrano_code]
#システム
昨夜の霊媒結果が出ました。[emb exp="f.name"]は[emb exp="f.result"]です[p]
[_tb_end_tyrano_code]

[jump  storage="specialist.ks"  target="*psychic_night_end"  ]
*psychic_night_none

[tb_start_tyrano_code]
#システム
処刑がなかったので結果はありません[p]
[_tb_end_tyrano_code]

*psychic_night_end

[return  ]
*fake_seer_night

[iscript]
var n=parseInt(f.gamemode);
var roles=String(f.character).split(",").map(Number);
var coArr=String(f.co).split(",");
var aliveArr=String(f.alive).split(",");
var playerNum=parseInt(f.player);
// プレイヤー自身が生存中の偽占い師(co='1'だがrole!=10)かどうかを判定
f.jump=(coArr[playerNum-1]==="1"&&roles[playerNum-1]!==10&&aliveArr[playerNum-1]==="1")?1:0;
[endscript]

[jump  storage="specialist.ks"  target="*fake_seer_night_ai_loop"  cond="f.jump==0"  ]
[tb_eval  exp="f.ai_actor=f.player"  name="ai_actor"  cmd="="  op="t"  val="player"  val_2="undefined"  ]
[call  storage="specialist.ks"  target="*fake_seer_player"  ]
*fake_seer_night_ai_loop

[iscript]
f.ai_actor=0;
[endscript]

*fake_seer_night_ai_search

[iscript]
var n=parseInt(f.gamemode);
var roles=String(f.character).split(",").map(Number);
var coArr=String(f.co).split(",");
var aliveArr=String(f.alive).split(",");
var playerNum=parseInt(f.player);
var start=parseInt(f.ai_actor)+1;
var found=0;
// ai_actorより大きいキャラ番号の中で、一番小さい「生存中のAI偽占い師」を探す（プレイヤーは既に処理済みなので除外）
for(var i=start;i<=n;i++){
if(i===playerNum)continue;
if(coArr[i-1]==="1"&&roles[i-1]!==10&&aliveArr[i-1]==="1"){found=i;break;}
}
f.ai_actor=found;
[endscript]

[jump  storage="specialist.ks"  target="*fake_seer_night_end"  cond="f.ai_actor==0"  ]
[call  storage="specialist.ks"  target="*fake_seer_AI"  ]
[jump  storage="specialist.ks"  target="*fake_seer_night_ai_search"  ]
*fake_seer_night_end

[return  ]
*fake_psychic_night

[iscript]
var n=parseInt(f.gamemode);
var roles=String(f.character).split(",").map(Number);
var coArr=String(f.co).split(",");
var aliveArr=String(f.alive).split(",");
var playerNum=parseInt(f.player);
// プレイヤー自身が生存中の偽霊媒師(co='2'だがrole!=11)かどうかを判定
f.jump=(coArr[playerNum-1]==="2"&&roles[playerNum-1]!==11&&aliveArr[playerNum-1]==="1")?1:0;
[endscript]

[jump  storage="specialist.ks"  target="*fake_psychic_night_ai_loop"  cond="f.jump==0"  ]
[tb_eval  exp="f.ai_actor=f.player"  name="ai_actor"  cmd="="  op="t"  val="player"  val_2="undefined"  ]
[call  storage="specialist.ks"  target="*fake_psychic"  ]
*fake_psychic_night_ai_loop

[iscript]
f.ai_actor=0;
[endscript]

*fake_psychic_night_ai_search

[iscript]
var n=parseInt(f.gamemode);
var roles=String(f.character).split(",").map(Number);
var coArr=String(f.co).split(",");
var aliveArr=String(f.alive).split(",");
var playerNum=parseInt(f.player);
var start=parseInt(f.ai_actor)+1;
var found=0;
// ai_actorより大きいキャラ番号の中で、一番小さい「生存中のAI偽霊媒師」を探す（プレイヤーは既に処理済みなので除外）
for(var i=start;i<=n;i++){
if(i===playerNum)continue;
if(coArr[i-1]==="2"&&roles[i-1]!==11&&aliveArr[i-1]==="1"){found=i;break;}
}
f.ai_actor=found;
[endscript]

[jump  storage="specialist.ks"  target="*fake_psychic_night_end"  cond="f.ai_actor==0"  ]
[call  storage="specialist.ks"  target="*fake_psychic"  ]
[jump  storage="specialist.ks"  target="*fake_psychic_night_ai_search"  ]
*fake_psychic_night_end

[return  ]
*night

[call  storage="specialist.ks"  target="*seer_night"  ]
[call  storage="specialist.ks"  target="*psychic_night"  ]
[tb_eval  exp="f.ai_actor=0"  name="ai_actor"  cmd="="  op="t"  val="0"  ]
[call  storage="specialist.ks"  target="*fake_seer_night"  ]
[tb_eval  exp="f.ai_actor=0"  name="ai_actor"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[call  storage="specialist.ks"  target="*fake_psychic_night"  ]
[return  ]
