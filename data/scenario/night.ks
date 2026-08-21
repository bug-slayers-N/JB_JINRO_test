[_tb_system_call storage=system/_night.ks]

*night

*liar_execution

[iscript]
// ガード（最優先）：確定値(5以上)は上書きしない。この更新は全体ライアー更新であり、個別(観測者ごと)の既知情報は考慮しない。
function setLiar(idx,val){
var lr=String(f.liar).split(',');
if(parseInt(lr[idx])>=5)return;
lr[idx]=String(val);
f.liar=lr.join(',');
}

var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function getClaims(field){
if(String(f[field])==="0")return [];
var arr=String(f[field]).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}

// ===== ①処刑トリガー：処刑されたのにゲームが続いている＝処刑対象は人狼ではなかった =====
// （5人モード限定。人狼1体のみだから「処刑して尚ゲーム続行」＝処刑対象は人狼ではなかったと断定できる。pclaimは5人モードに存在しないためsclaimのみ見る）
if(n===5){
var claims=getClaims('sclaim');
var executed=parseInt(f.role2);
if(executed>0){
for(var c=0;c<claims.length;c++){
var reporter=claims[c][1],target=claims[c][2],result=claims[c][3];
if(target===executed&&result===1){
for(var obs=1;obs<=n;obs++){
if(obs===reporter)continue;
setLiar(gi(obs,reporter),1);
}
}
}
}
}

// ===== ②霊媒師トリガー：alive4人以下なのに一度も人狼と報告していない霊媒師申告者は嘘つき確定 =====
// （9人モード限定。勝利条件式(人狼数>=人間数で人狼勝利)から、alive<=4でゲーム継続中(=night到達)なら人狼は必ずちょうど1体生存中と確定する。
//   人狼が死ぬ手段は処刑のみなので、もう1体の人狼はどこかの処刑で必ず出ている。それを一度も「人狼」と報告していない申告者は嘘つき確定。）
if(n===9){
var aliveCount=0;
var aliveArr=String(f.alive).split(',');
for(var i=0;i<n;i++){if(aliveArr[i]==='1')aliveCount++;}
if(aliveCount<=4){
var pclaims=getClaims('pclaim');
var tally={};
for(var c=0;c<pclaims.length;c++){
var reporter=pclaims[c][1],result=pclaims[c][3];
if(!tally[reporter])tally[reporter]={human:0,wolf:0};
if(result===1)tally[reporter].wolf++;else tally[reporter].human++;
}
for(var rep in tally){
if(tally[rep].wolf>0)continue;
if(tally[rep].human===0)continue;
var repNum=parseInt(rep);
for(var obs=1;obs<=n;obs++){
if(obs===repNum)continue;
setLiar(gi(obs,repNum),1);
}
}
}
}
[endscript]

[tb_start_text mode=1 ]
#システム
夜になりました。[p]
[_tb_end_text]

[call  storage="specialist.ks"  target="*night"  ]
*knight

[iscript]
// 5人モードには騎士が存在しないためスキップ。騎士(役職12)が不在／死亡している場合もスキップする。
var n=parseInt(f.gamemode);
var roles=String(f.character).split(",").map(Number);
var aliveArr=String(f.alive).split(",");
var knightNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===12){knightNum=i;break;}}
if(n===5||knightNum===0||aliveArr[knightNum-1]==="0"){
f.jump=0;
}else{
f.jump=(parseInt(f.role)===12)?1:2;
}
[endscript]

[jump  storage="night.ks"  target="*knight_end"  cond="f.jump==0"  ]
[jump  storage="night.ks"  target="*knight_ai"  cond="f.jump==2"  ]
*knight_player

[tb_start_text mode=1 ]
#システム
護衛する相手を選んでください。[p]
[_tb_end_text]

[tb_eval  exp="f.jump='knight'"  name="jump"  cmd="="  op="t"  val="knight"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listA"  ]
*knight_back

[tb_show_message_window  ]
[tb_eval  exp="f.role2=f.target"  name="role2"  cmd="="  op="h"  val="target"  val_2="undefined"  ]
[jump  storage="night.ks"  target="*knight_end"  ]
*knight_ai

[iscript]
// AIが騎士を担う場合：自分以外の生存者から護衛対象を選ぶ（listAの自己除外と同じ条件）
// 占い師CO済みキャラは当選確率7倍。CO済みが2人以上いる場合は平常心(calm)が最も高い1人のみ7倍とする。
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
var calmArr=String(f.calm).split(",");
var playerNum=parseInt(f.player);
var cands=[];
for(var i=1;i<=n;i++){
if(i===playerNum)continue;
if(aliveArr[i-1]==="0")continue;
cands.push(i);
}
var coCands=cands.filter(function(c){return coArr[c-1]==="1";});
var boosted=-1;
if(coCands.length===1){
boosted=coCands[0];
}else if(coCands.length>=2){
boosted=coCands[0];
for(var j=1;j<coCands.length;j++){
if(parseFloat(calmArr[coCands[j]-1])>parseFloat(calmArr[boosted-1]))boosted=coCands[j];
}
}
var weights=cands.map(function(c){return c===boosted?7:1;});
var total=weights.reduce(function(a,b){return a+b;},0);
var r=Math.random()*total;
var picked=cands.length>0?cands[cands.length-1]:0;
for(var k=0;k<cands.length;k++){
r-=weights[k];
if(r<0){picked=cands[k];break;}
}
f.target=cands.length>0?picked:0;
f.role2=f.target;
[endscript]

*knight_end

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
[iscript]
// 騎士の護衛対象と人狼の襲撃対象が一致した場合、護衛成功として死亡処理をスキップする
// あわせて、騎士本人の視点でtargetのliarを更新する（護衛成功＝対象は人狼に襲撃された＝人狼ではないと確定できる）
// 現在値0(不明)→3(人間)、1(嘘つき)→9(狂人確定、嘘つき+人狼でないので狂人確定)、2(正直)→2のまま、5以上(確定値)→変更なし
var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
if(parseInt(f.target)===parseInt(f.role2)){
f.role2="skip";
var roles=String(f.character).split(",").map(Number);
var knightNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===12){knightNum=i;break;}}
if(knightNum>0){
var idx=gi(knightNum,parseInt(f.target));
var lr=String(f.liar).split(",");
var cur=parseInt(lr[idx]);
if(cur===0){
lr[idx]="3";
f.liar=lr.join(",");
}else if(cur===1){
lr[idx]="9";
f.liar=lr.join(",");
}
// cur===2はそのまま維持、cur>=5(確定値)は変更しない
}
}
[endscript]

[jump  storage="night.ks"  target="*morning"  cond="f.role2=='skip'"  ]
[jump  storage="system.ks"  target="*death"  cond=""  ]
*morning

[mask  time="300"  effect="fadeIn"  color="0x000000"  ]
[bg  time="0"  method="crossfade"  storage="93853245_p0.png"  ]
[tb_show_message_window  ]
[mask_off  time="300"  effect="fadeOut"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[jump  storage="night.ks"  target="*morning_no_kill"  cond="f.role2=='skip'"  ]
*liar_attack

[iscript]
// ガード（最優先）：確定値(5以上)は上書きしない。全体ライアー更新であり、個別(観測者ごと)の既知情報は考慮しない。
function setLiar(idx,val){
var lr=String(f.liar).split(',');
if(parseInt(lr[idx])>=5)return;
lr[idx]=String(val);
f.liar=lr.join(',');
}

var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function getClaims(field){
if(String(f[field])==="0")return [];
var arr=String(f[field]).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}

// 襲撃失敗（護衛成功でrole2='skip'）ならここには来ない想定だが、念のため二重ガード
if(f.role2!=='skip'){

// ===== ①襲撃トリガー：襲撃対象を人狼と報告していた占い師は嘘つき確定 =====
// （人狼は仲間を襲撃対象に選ばない仕様（list_judge/ai_wolf双方で人狼同士を除外済み）なので、
//   襲撃された時点で対象が人狼でないことはモード問わず確定する）
var claims=getClaims('sclaim');
var attacked=parseInt(f.target);
for(var c=0;c<claims.length;c++){
var reporter=claims[c][1],target=claims[c][2],result=claims[c][3];
if(target===attacked&&result===1){
for(var obs=1;obs<=n;obs++){
if(obs===reporter)continue;
setLiar(gi(obs,reporter),1);
}
}
}

// ===== ②霊媒師トリガー：alive4人以下なのに一度も人狼と報告していない霊媒師申告者は嘘つき確定（9人モード限定） =====
if(n===9){
var aliveCount=0;
var aliveArr=String(f.alive).split(',');
for(var i=0;i<n;i++){if(aliveArr[i]==='1')aliveCount++;}
if(aliveCount<=4){
var pclaims=getClaims('pclaim');
var tally={};
for(var c=0;c<pclaims.length;c++){
var reporter=pclaims[c][1],result=pclaims[c][3];
if(!tally[reporter])tally[reporter]={human:0,wolf:0};
if(result===1)tally[reporter].wolf++;else tally[reporter].human++;
}
for(var rep in tally){
if(tally[rep].wolf>0)continue;
if(tally[rep].human===0)continue;
var repNum=parseInt(rep);
for(var obs=1;obs<=n;obs++){
if(obs===repNum)continue;
setLiar(gi(obs,repNum),1);
}
}
}
}

// ===== ③襲撃死亡：対象自身以外の全員視点で、現在値に応じてliarを変換 =====
// 0(不明)→3(人間) / 1(嘘つき)→9(狂人) / 2(正直)→2のまま / 3(人間)→3のまま / 4(囮)→3(人間、実際に人狼に襲撃され死亡した以上は誤りと確定) / 5以上(確定値)→変更なし
for(var obs2=1;obs2<=n;obs2++){
if(obs2===attacked)continue;
var idx2=gi(obs2,attacked);
var lr2=String(f.liar).split(',');
var cur2=parseInt(lr2[idx2]);
if(cur2>=5)continue;
var next2=cur2;
if(cur2===0)next2=3;
else if(cur2===1)next2=9;
else if(cur2===4)next2=3;
if(next2!==cur2){
lr2[idx2]=String(next2);
f.liar=lr2.join(',');
}
}

}
[endscript]

[tb_start_text mode=1 ]
#システム
昨夜、[emb exp="f.name"]が襲撃されました。[p]

[_tb_end_text]

[jump  storage="night.ks"  target="*morning_text_end"  ]
*morning_no_kill

[tb_start_text mode=1 ]
#システム
昨夜は誰も襲撃されませんでした。[p]

[_tb_end_text]

*morning_text_end

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
