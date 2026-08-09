[_tb_system_call storage=system/_night.ks]

*night

[tb_start_text mode=1 ]
#システム
夜になりました。[p]
[_tb_end_text]

[call  storage="specialist.ks"  target="*night"  ]
[iscript]
// プレイヤー死亡（観戦モード）またはプレイヤーが人狼でない場合はAIが代打ちする。
// jump/role単独条件のjumpを2本に分けず、ここで1つのフラグに合成してから単一条件のjumpに渡す。
f.jump=(parseInt(f.player_death)===1||parseInt(f.role)>5)?1:0;
[endscript]

[jump  storage="night.ks"  target="*ai_wolf"  cond="f.jump==1"  ]
[jump  storage="night.ks"  target="*player_wolf"  ]
*ai_wolf

[iscript]
var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getEl(a,b){return parseInt(String(a).split(',')[b],10);}
function si(a,b,val){var arr=String(a).split(',');arr[b]=String(val);return arr.join(',');}
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function isCO(c){return String(f.co).split(',')[c-1]==='1';}
var charArr=String(f.character).split(',');
var calmArr=String(f.calm).split(',');
function isWolf(c){return parseInt(charArr[c-1])<=5;} // 人狼陣営のうち"人狼"本体のみ対象（狂人9は襲撃対象になり得るため除外しない）
var wolfChar=0;
for(var i=0;i<n;i++){if(parseInt(charArr[i])===1){wolfChar=i+1;break;}}
// マフツを一時的に好感度-20して標的から遠ざける（終了後に戻す）
var mafutsuIdx=(wolfChar!==1&&isAlive(1))?gi(wolfChar,1):-1;
if(mafutsuIdx!==-1)f.like=si(f.like,mafutsuIdx,getEl(f.like,mafutsuIdx)-20);
function getPC(c){return parseFloat(calmArr[c-1])+getEl(f.like,gi(wolfChar,c));}
function getLiar(b){return getEl(f.liar,gi(wolfChar,b));}
// filterFnを満たす生存者（人狼陣営の"人狼"本体は除く）をPC降順で返す
function pickBest(filterFn){
var cands=[];
for(var c=1;c<=n;c++){
if(isWolf(c)||!isAlive(c))continue;
if(filterFn(c))cands.push(c);
}
cands.sort(function(a,b){var d=getPC(b)-getPC(a);return d!==0?d:a-b;});
return cands.length>0?cands[0]:0;
}
var coCount=0;
for(var c=1;c<=n;c++){if(isAlive(c)&&isCO(c))coCount++;}
var target=0;
// ①3人以上COなら非COキャラからランダム
if(!target&&coCount>=3){
var cands=[];
for(var c=1;c<=n;c++){if(isWolf(c)||!isAlive(c)||isCO(c))continue;cands.push(c);}
if(cands.length>0)target=cands[Math.floor(Math.random()*cands.length)];
}
// ②人狼がCOしている→非COキャラ優先、なければ全生存者から
target=target||pickBest(function(c){return isCO(wolfChar)&&!isCO(c);})||
(isCO(wolfChar)?pickBest(function(c){return true;}):0);
// ③人狼がCOしていない→liar=1を除いたCO済みキャラ優先、なければCO済み全員
if(!target&&!isCO(wolfChar)){
target=pickBest(function(c){return isCO(c)&&getLiar(c)!==1;})||
pickBest(function(c){return isCO(c);});
}
// ④フォールバック：全生存者から
target=target||pickBest(function(c){return true;});
if(mafutsuIdx!==-1)f.like=si(f.like,mafutsuIdx,getEl(f.like,mafutsuIdx)+20);
f.target=target;
[endscript]

[jump  storage="night.ks"  target="*wolf_end"  ]
*player_wolf

[tb_start_text mode=1 ]
襲撃する相手を選びましょう。[p]
[_tb_end_text]

[tb_eval  exp="f.jump='wolf'"  name="jump"  cmd="="  op="t"  val="wolf"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listB"  ]
*wolf_end

[tb_eval  exp="f.result=f.target"  name="result"  cmd="="  op="h"  val="target"  val_2="undefined"  ]
[tb_eval  exp="f.jump='wolf'"  name="jump"  cmd="="  op="t"  val="wolf"  val_2="undefined"  ]
[jump  storage="system.ks"  target="*death"  cond=""  ]
*morning

[mask  time="300"  effect="fadeIn"  color="0x000000"  ]
[bg  time="0"  method="crossfade"  storage="93853245_p0.png"  ]
[tb_show_message_window  ]
[mask_off  time="300"  effect="fadeOut"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[tb_start_text mode=1 ]
#システム
昨夜、[emb exp="f.name"]が襲撃されました。[p]

[_tb_end_text]

[iscript]
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var aliveNames=[];
for(var i=0;i<n;i++){
if(aliveArr[i]==="1")aliveNames.push(names[i+1]);
}
f.display01=aliveNames.join("、");
[endscript]

[tb_eval  exp="f.display02=f.day"  name="display02"  cmd="="  op="h"  val="day"  val_2="undefined"  ]
[tb_eval  exp="f.display02+=1"  name="display02"  cmd="+="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_text mode=1 ]
残りの生存者は[emb exp="f.display01"]です。[p]
[emb exp="f.day"]日目を開始します。[p]
[_tb_end_text]

[iscript]
// 本物占い師・霊媒師の生存＋CO状況をチェックし、sclaim/pclaimに未転記の結果を全て転記する
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function getCO(c){return parseInt(String(f.co).split(',')[c-1]);}
function getRole(i){return parseInt(String(f.character).split(',')[i-1]);}
function addSclaim(reporter,target,result){
var entry=f.day+","+reporter+","+target+","+result;
if(String(f.sclaim)==="0"){f.sclaim=entry;}else{f.sclaim=f.sclaim+","+entry;}
}
function addPclaim(reporter,target,result){
var entry=f.day+","+reporter+","+target+","+result;
if(String(f.pclaim)==="0"){f.pclaim=entry;}else{f.pclaim=f.pclaim+","+entry;}
}
function getSeerResults(){
if(String(f.seer_result)==="0")return [];
var arr=String(f.seer_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
function getPsychicResults(){
if(String(f.psychic_result)==="0")return [];
var arr=String(f.psychic_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
function getSclaim(){
if(String(f.sclaim)==="0")return [];
var arr=String(f.sclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
function getPclaim(){
if(String(f.pclaim)==="0")return [];
var arr=String(f.pclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
var n=parseInt(f.gamemode);
var seerChar=0,psychicChar=0;
for(var i=1;i<=n;i++){
if(getRole(i)===10)seerChar=i;
if(getRole(i)===11)psychicChar=i;
}
// 本物占い師：生存かつ占いCO済みなら、sclaimに未転記の占い結果を全件転記
if(seerChar!==0&&isAlive(seerChar)&&getCO(seerChar)===1){
var sr=getSeerResults();
var scArr=getSclaim();
var scCount=0;
for(var j=0;j<scArr.length;j++){if(scArr[j][1]===seerChar)scCount++;}
for(var k=scCount;k<sr.length;k++){
addSclaim(seerChar,sr[k][0],sr[k][1]);
}
}
// 本物霊媒師：生存かつ霊媒CO済みなら、pclaimに未転記の霊媒結果を全件転記
if(psychicChar!==0&&isAlive(psychicChar)&&getCO(psychicChar)===2){
var pr=getPsychicResults();
var pcArr=getPclaim();
var pcCount=0;
for(var m=0;m<pcArr.length;m++){if(pcArr[m][1]===psychicChar)pcCount++;}
for(var q=pcCount;q<pr.length;q++){
addPclaim(psychicChar,pr[q][0],pr[q][1]);
}
}
[endscript]

[iscript]
// 本日付でsclaim/pclaimに追加された全エントリを「報告者→対象:結果」形式のテキストに再形成
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function getSclaim(){
if(String(f.sclaim)==="0")return [];
var arr=String(f.sclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
function getPclaim(){
if(String(f.pclaim)==="0")return [];
var arr=String(f.pclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
var today=parseInt(f.day);
var sclaimArr=getSclaim();
var seerLines=[];
for(var j=0;j<sclaimArr.length;j++){
var e=sclaimArr[j];
if(e[0]===today&&isAlive(e[1])){
var resText=e[3]===1?"人狼":"人間";
seerLines.push(names[e[1]]+"→"+names[e[2]]+":"+resText);
}
}
f.display01=seerLines.join("\n");
var pclaimArr=getPclaim();
var psychicLines=[];
for(var k=0;k<pclaimArr.length;k++){
var e2=pclaimArr[k];
if(e2[0]===today&&isAlive(e2[1])){
var resText2=e2[3]===1?"人狼":"人間";
psychicLines.push(names[e2[1]]+"→"+names[e2[2]]+":"+resText2);
}
}
f.display02=psychicLines.join("\n");
[endscript]

[if exp="f.display01!==''"]
[tb_start_text mode=1 ]
#システム
占い師から下記の報告がありました。[p]
[emb exp="f.display01"][p]
[_tb_end_text]
[endif]

[if exp="f.display02!==''"]
[tb_start_text mode=1 ]
#システム
霊媒師からは下記の報告がありました。[p]
[emb exp="f.display02"][p]
[_tb_end_text]
[endif]

[jump  storage="end.ks"  target="*turn_set"  ]
