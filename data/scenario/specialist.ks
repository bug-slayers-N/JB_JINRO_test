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

*uranai

[iscript]
var roles=String(f.character).split(",").map(Number);
var tgt=parseInt(f.target);
function addSeerResult(target,result){
if(String(f.seer_result)==="0"){f.seer_result=target+","+result;}
else{f.seer_result=f.seer_result+","+target+","+result;}
}
if(tgt>0){ // 候補が居ない(target===0)場合は不正データを記録しない
var res=(roles[tgt-1]<=5)?1:0;
addSeerResult(tgt,res);
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
*seer_CO

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
*psychic_CO

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
*fake_CO_seer

[iscript]
// プレイヤー本人がactorか、AIがactorかを判定してjumpで分岐
f.jump=(parseInt(f.ai_actor)===parseInt(f.player))?1:2;
[endscript]

[jump  storage="specialist.ks"  target="*fake_CO_seer_ai"  cond="f.jump==2"  ]
*fake_CO_seer_player

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

[glink  color="black"  storage="specialist.ks"  size="20"  autopos="true"  text="人間"  target="*fake_CO_seer_player_human"  ]
[glink  color="black"  storage="specialist.ks"  size="20"  autopos="true"  text="人狼"  target="*fake_CO_seer_player_wolf"  ]
[s  ]
*fake_CO_seer_player_human

[tb_eval  exp="f.display01=0"  name="display01"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="specialist.ks"  target="*fake_CO_seer_write"  ]
*fake_CO_seer_player_wolf

[tb_eval  exp="f.display01=1"  name="display01"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="specialist.ks"  target="*fake_CO_seer_write"  ]
*fake_CO_seer_ai

[iscript]
var n=parseInt(f.gamemode);
var actorNum=parseInt(f.ai_actor);
var roles=String(f.character).split(",").map(Number);
var actorRole=roles[actorNum-1];
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
var t=0,res=0;
if(actorRole<=5){
// 人狼：未CO・生存・自分以外からランダムに1人選び、人間と申告
var cands=[];
for(var i=1;i<=n;i++){
if(i===actorNum)continue;
if(coArr[i-1]!=="0")continue;
if(aliveArr[i-1]==="0")continue;
cands.push(i);
}
if(cands.length>0){
t=cands[Math.floor(Math.random()*cands.length)];
res=0;
}else{
// 候補切れ：無効値の9,9センチネルをそのままsclaimに書き込む
t=9;
res=9;
}
}else if(actorRole===9){
// 狂人：生存・自分以外からランダムに1人選び、結果もランダム
var cands=[];
for(var i=1;i<=n;i++){
if(i===actorNum)continue;
if(aliveArr[i-1]==="0")continue;
cands.push(i);
}
t=cands.length>0?cands[Math.floor(Math.random()*cands.length)]:0;
res=Math.floor(Math.random()*2);
}
f.target=t;
f.display01=res;
[endscript]

*fake_CO_seer_write

[iscript]
var actor=parseInt(f.ai_actor);
var day=parseInt(f.day);
var mainDay=day-1; // 今回発表するメインの報告のday
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
}
var sclaimArr=getSclaim();
var hasPrior=false;
for(var i=0;i<sclaimArr.length;i++){
if(sclaimArr[i][1]===actor){hasPrior=true;break;}
}
if(!hasPrior){
// 初回CO：day0〜(mainDay-1)を過去データとしてランダム生成して埋める
// character変数で11以上(霊媒師・村人等)のキャラを生存死亡問わずランダムに選び、人間と報告
var n=parseInt(f.gamemode);
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
*fake_CO_psychic

[iscript]
var actor=parseInt(f.ai_actor);
var day=parseInt(f.day);
var mainDay=day-1;
var n=parseInt(f.gamemode);
var roles=String(f.character).split(",").map(Number);
var liarArr=String(f.liar).split(",").map(Number);
var aliveArr=String(f.alive).split(",").map(Number);
var suspectArr=(String(f.suspect)==="0")?[]:String(f.suspect).split(",").map(Number);
var actorRole=roles[actor-1];
// 真霊媒師と同じ対象を使うため、psychic_resultから対象一覧を取得（添字0=day1の対象）
function getPsychicResults(){
if(String(f.psychic_result)==="0")return [];
var arr=String(f.psychic_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
var psychicResults=getPsychicResults();
function getPclaim(){
if(String(f.pclaim)==="0")return [];
var arr=String(f.pclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
var pclaimArr=getPclaim();
function addPclaimRaw(d,reporter,target,result){
var entry=d+","+reporter+","+target+","+result;
if(String(f.pclaim)==="0"){f.pclaim=entry;}
else{f.pclaim=f.pclaim+","+entry;}
}
// 初回COかどうか（このactorの報告がpclaimに一件もないか）
var hasPrior=false;
for(var i=0;i<pclaimArr.length;i++){
if(pclaimArr[i][1]===actor){hasPrior=true;break;}
}
// これまでにこのactorが「人狼」と報告した回数（上限チェック用の起点）
var wolfReportsSoFar=0;
for(var i=0;i<pclaimArr.length;i++){
if(pclaimArr[i][1]===actor && pclaimArr[i][3]===1) wolfReportsSoFar++;
}
// 上限チェックが有効な状況か（偽霊媒師=人狼・9人モード限定）
var aliveWolfCount=0,aliveTotal=0;
for(var i=1;i<=n;i++){
if(aliveArr[i-1]===1){
aliveTotal++;
if(roles[i-1]<=5) aliveWolfCount++;
}
}
var capActive=(actorRole<=5 && n===9 &&
((aliveWolfCount===2 && aliveTotal>=7)||(aliveWolfCount===1 && aliveTotal>=5)));
// 対象1人分の結果を判定：①liar15→人間 ②liar5→人狼 ③suspect在籍→人狼、それ以外→人間
// 上限チェックに引っかかる場合は人狼判定を人間に差し替える
function decideResult(target){
var tLiar=liarArr[target-1];
var res;
if(tLiar===15){res=0;}
else if(tLiar===5){res=1;}
else{
// actor(報告者本人)視点の2枠だけを見て、本人が疑っている相手かどうかを判定
var s0=suspectArr[(actor-1)*2];
var s1=suspectArr[(actor-1)*2+1];
res=(s0===target||s1===target)?1:0;
}
if(res===1 && capActive && wolfReportsSoFar>=1){res=0;}
if(res===1) wolfReportsSoFar++;
return res;
}
// 初回COならday1〜mainDay-1を過去データとして埋める（対象は各dayの実際の処刑者）
var startDay=hasPrior?mainDay:1;
for(var d=startDay; d<mainDay; d++){
if(psychicResults[d-1]){
var tgt=psychicResults[d-1][0];
addPclaimRaw(d,actor,tgt,decideResult(tgt));
}
}
// 本命（今回発表する分）
if(psychicResults[mainDay-1]){
var mtgt=psychicResults[mainDay-1][0];
addPclaimRaw(mainDay,actor,mtgt,decideResult(mtgt));
}
[endscript]

[return  ]
*seer_night

[iscript]
var roles=String(f.character).split(",").map(Number);
var n=parseInt(f.gamemode);
var seerNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===10){seerNum=i;break;}}
f.jump=(seerNum===parseInt(f.player))?1:2;
[endscript]

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

[iscript]
var roles=String(f.character).split(",").map(Number);
var n=parseInt(f.gamemode);
var seerNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===10){seerNum=i;break;}}
var isPlayer=(seerNum===parseInt(f.player));
var tgt=parseInt(f.target);
function addSeerResult(target,result){
if(String(f.seer_result)==="0"){f.seer_result=target+","+result;}
else{f.seer_result=f.seer_result+","+target+","+result;}
}
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var res=0;
if(tgt>0){
res=(roles[tgt-1]<=5)?1:0;
addSeerResult(tgt,res);
}
f.jump=isPlayer?1:0;
f.name=(tgt>0)?names[tgt]:"";
f.result=(res===1)?"人狼":"人間";
[endscript]

[jump  storage="specialist.ks"  target="*seer_night_end"  cond="f.jump==0"  ]
[tb_start_tyrano_code]
#システム
占いの結果：[emb exp="f.name"]は[emb exp="f.result"]です[p]
[_tb_end_tyrano_code]

*seer_night_end

[jump  storage="night.ks"  target="*uranai_back"  ]
*psychic_night

[iscript]
var roles=String(f.character).split(",").map(Number);
var n=parseInt(f.gamemode);
var psychicNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===11){psychicNum=i;break;}}
var isPlayer=(psychicNum===parseInt(f.player));
var dead=parseInt(f.role2);
function addPsychicResult(target,result){
if(String(f.psychic_result)==="0"){f.psychic_result=target+","+result;}
else{f.psychic_result=f.psychic_result+","+target+","+result;}
}
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var res=0;
if(dead>0){
res=(roles[dead-1]<=5)?1:0;
addPsychicResult(dead,res);
}
f.jump=isPlayer?1:0;
f.name=(dead>0)?names[dead]:"";
f.result=(res===1)?"人狼":"人間";
[endscript]

[jump  storage="specialist.ks"  target="*psychic_night_end"  cond="f.jump==0"  ]
[tb_start_tyrano_code]
#システム
昨晩の霊媒結果が出ました。[emb exp="f.name"]は[emb exp="f.result"]です[p]
[_tb_end_tyrano_code]

*psychic_night_end

[jump  storage="night.ks"  target="*psychic_back"  ]
*fake_seer_night

[iscript]
f.jump=(parseInt(f.ai_actor)===parseInt(f.player))?1:2;
[endscript]

[jump  storage="specialist.ks"  target="*fake_seer_night_ai"  cond="f.jump==2"  ]
*fake_seer_night_player

[tb_start_text mode=1 ]
#システム
誰を占ったことにしますか？[p]
[_tb_end_text]

[tb_eval  exp="f.jump='fseern'"  name="jump"  cmd="="  op="t"  val="fseern"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listB"  ]
*fseern_back

[tb_start_text mode=1 ]
#システム
結果はどちらにしますか？[p]
[_tb_end_text]

[glink  color="black"  storage="specialist.ks"  size="20"  autopos="true"  text="人間"  target="*fake_seer_night_player_human"  ]
[glink  color="black"  storage="specialist.ks"  size="20"  autopos="true"  text="人狼"  target="*fake_seer_night_player_wolf"  ]
[s  ]
*fake_seer_night_player_human

[tb_eval  exp="f.display01=0"  name="display01"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="specialist.ks"  target="*fake_seer_night_write"  ]
*fake_seer_night_player_wolf

[tb_eval  exp="f.display01=1"  name="display01"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="specialist.ks"  target="*fake_seer_night_write"  ]
*fake_seer_night_ai

[iscript]
var n=parseInt(f.gamemode);
var actorNum=parseInt(f.ai_actor);
var roles=String(f.character).split(",").map(Number);
var actorRole=roles[actorNum-1];
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
function getSclaim(){
if(String(f.sclaim)==="0")return [];
var arr=String(f.sclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
var sclaimArr=getSclaim();
// 自分が過去にsclaimで対象にした相手は除外(同じ相手を二度占ったことにしない)
var alreadyPicked=[];
for(var i=0;i<sclaimArr.length;i++){
if(sclaimArr[i][1]===actorNum) alreadyPicked.push(sclaimArr[i][2]);
}
var t=0,res=0;
if(actorRole<=5){
// 人狼：未CO・生存・自分以外・未占い済みからランダムに1人選び、人間と申告
var cands=[];
for(var i=1;i<=n;i++){
if(i===actorNum)continue;
if(coArr[i-1]!=="0")continue;
if(aliveArr[i-1]==="0")continue;
if(alreadyPicked.indexOf(i)>=0)continue;
cands.push(i);
}
if(cands.length>0){
t=cands[Math.floor(Math.random()*cands.length)];
res=0;
}else{
// 候補切れ：無効値の9,9センチネルをそのままsclaimに書き込む
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

*fake_seer_night_write

[iscript]
var actor=parseInt(f.ai_actor);
var day=parseInt(f.day);
function addSclaimRaw(d,reporter,target,result){
var entry=d+","+reporter+","+target+","+result;
if(String(f.sclaim)==="0"){f.sclaim=entry;}
else{f.sclaim=f.sclaim+","+entry;}
}
addSclaimRaw(day,actor,parseInt(f.target),parseInt(f.display01));
[endscript]

[return  ]
*fake_psychic_night


;人狼・狂人でCO済み(f.co="2")の者が毎晩発動。対象は真霊媒師と同じくf.role2(本日死亡したキャラ)で固定、結果のみ選ぶ/決める。f.pclaimに直接書き込む


[iscript]
f.jump=(parseInt(f.role2)<=0)?0:((parseInt(f.ai_actor)===parseInt(f.player))?1:2);
[endscript]

[jump  storage="specialist.ks"  target="*fake_psychic_night_end"  cond="f.jump==0"  ]
[jump  storage="specialist.ks"  target="*fake_psychic_night_ai"  cond="f.jump==2"  ]
*fake_psychic_night_player

[tb_start_text mode=1 ]
#システム
結果はどちらにしますか？[p]
[_tb_end_text]

[glink  color="black"  storage="specialist.ks"  size="20"  autopos="true"  text="人間"  target="*fake_psychic_night_player_human"  ]
[glink  color="black"  storage="specialist.ks"  size="20"  autopos="true"  text="人狼"  target="*fake_psychic_night_player_wolf"  ]
[s  ]
*fake_psychic_night_player_human

[tb_eval  exp="f.display01=0"  name="display01"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="specialist.ks"  target="*fake_psychic_night_write"  ]
*fake_psychic_night_player_wolf

[tb_eval  exp="f.display01=1"  name="display01"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="specialist.ks"  target="*fake_psychic_night_write"  ]
*fake_psychic_night_ai

[iscript]
var actor=parseInt(f.ai_actor);
var n=parseInt(f.gamemode);
var roles=String(f.character).split(",").map(Number);
var liarArr=String(f.liar).split(",").map(Number);
var aliveArr=String(f.alive).split(",").map(Number);
var suspectArr=(String(f.suspect)==="0")?[]:String(f.suspect).split(",").map(Number);
var actorRole=roles[actor-1];
var dead=parseInt(f.role2);
function getPclaim(){
if(String(f.pclaim)==="0")return [];
var arr=String(f.pclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
var pclaimArr=getPclaim();
var wolfReportsSoFar=0;
for(var i=0;i<pclaimArr.length;i++){
if(pclaimArr[i][1]===actor && pclaimArr[i][3]===1) wolfReportsSoFar++;
}
var aliveWolfCount=0,aliveTotal=0;
for(var i=1;i<=n;i++){
if(aliveArr[i-1]===1){
aliveTotal++;
if(roles[i-1]<=5) aliveWolfCount++;
}
}
var capActive=(actorRole<=5 && n===9 &&
((aliveWolfCount===2 && aliveTotal>=7)||(aliveWolfCount===1 && aliveTotal>=5)));
var tLiar=liarArr[dead-1];
var res;
if(tLiar===15){res=0;}
else if(tLiar===5){res=1;}
else{
var s0=suspectArr[(actor-1)*2];
var s1=suspectArr[(actor-1)*2+1];
res=(s0===dead||s1===dead)?1:0;
}
if(res===1 && capActive && wolfReportsSoFar>=1){res=0;}
f.display01=res;
[endscript]

*fake_psychic_night_write

[iscript]
var actor=parseInt(f.ai_actor);
var day=parseInt(f.day);
var dead=parseInt(f.role2);
function addPclaimRaw(d,reporter,target,result){
var entry=d+","+reporter+","+target+","+result;
if(String(f.pclaim)==="0"){f.pclaim=entry;}
else{f.pclaim=f.pclaim+","+entry;}
}
addPclaimRaw(day,actor,dead,parseInt(f.display01));
[endscript]

*fake_psychic_night_end

[return  ]
