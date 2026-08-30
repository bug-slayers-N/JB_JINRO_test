[_tb_system_call storage=system/_system.ks]

*init

[iscript]
// ===== 進行 =====
f.gamemode=5;
f.day=1;
f.turn=0;
f.win=0;
f.player_death=0;
f.say_human=0;
f.action=0;
f.push=0;
f.tutorial=0;
f.calm_low=0;
f.sclaim=0;
f.pclaim=0;
// ===== 役職（共通部分。f.characterはモード別initで設定） =====
f.role=1;
f.player=1;
// ===== 占い師・霊媒師専用（本人限定の真実記録／公開申告ログ） =====
f.seer_result="0";
f.psychic_result="0";
f.sclaim="0";
f.pclaim="0";
// ===== 投票関連（display系はここでのみ初期化。モード別initでは触らない） =====
f.revote=0;
f.display01=0;
f.display02=0;
f.display03=0;
f.display04=0;
f.display05=0;
f.display06=0;
f.display07=0;
f.display08=0;
f.display09=0;
[endscript]

[return  ]
*5mode_init

[iscript]
// ===== モード確定 =====
f.gamemode=5;
// ===== 役職プール（5人分。role.ksでシャッフル・上書きされる） =====
f.character="1,9,10,15,16";
// ===== エンコード変数（5人サイズ：n=5、20値=n×(n-1)、10値=n×2） =====
f.alive="1,1,1,1,1";
f.co="0,0,0,0,0";
f.liar="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
f.like="10,0,0,0,0,30,0,0,0,30,0,0,0,10,0,0,0,10,0,0";
// ===== 平常心（5人分の基礎値） =====
f.calm="100,80,110,100,120";
// ===== 投票関連（5人分） =====
f.votes="0,0,0,0,0";
// ===== 様子を見るでai_actorに選ばれた回数（5人分） =====
f.count="0,0,0,0,0";
[endscript]

[return  ]
*9mode_init

[iscript]
// ===== モード確定 =====
f.gamemode=9;
// ===== 役職プール（9人分。role.ksでシャッフル・上書きされる） =====
f.character="1,2,9,10,11,12,15,16,17";
// ===== エンコード変数（9人サイズ：n=9、72値=n×(n-1)、18値=n×2） =====
f.alive="1,1,1,1,1,1,1,1,1";
f.co="0,0,0,0,0,0,0,0,0";
f.liar="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
f.like="10,0,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,30";
// ===== 平常心（9人分の基礎値。6〜9も補正なしの基礎値、ペアバフは都度計算） =====
f.calm="100,80,110,100,120,110,90,100,110";
// ===== 投票関連（9人分） =====
f.votes="0,0,0,0,0,0,0,0,0";
// ===== 様子を見るでai_actorに選ばれた回数（9人分） =====
f.count="0,0,0,0,0,0,0,0,0";
[endscript]

[return  ]
*liar

[iscript]
var n=parseInt(f.gamemode);
function gi(a,b){var nn=parseInt(f.gamemode);var o=(a-1)*(nn-1);var t=[];for(var i=1;i<=nn;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function getCO(c){return parseInt(String(f.co).split(',')[c-1]);}
function getRole(i){return parseInt(String(f.character).split(',')[i-1]);}
function getLiar(a,b){return parseInt(String(f.liar).split(',')[gi(a,b)]);}
// liar書き込み：5以上（人狼5・狂人9・占い師10・霊媒師11・村人15…）は確定値として何があっても上書き禁止
function setLiar(idx,val){
var lr=String(f.liar).split(',');
var cur=parseInt(lr[idx]);
if(cur>=5)return;
lr[idx]=String(val);
f.liar=lr.join(',');
}
// 知覚平常心（PC＝ペアバフ込み平常心＋観測者からの好感度、観測者視点つき）
function getPC(a,b){
var calmArr2=String(f.calm).split(',');
var v=parseFloat(calmArr2[b-1]);
var al2=String(f.alive).split(',');
if(b===6&&al2[6]==='1')v*=1.1;
if(b===7&&al2[5]==='1')v*=1.1;
if(b===9&&al2[7]==='1')v*=1.4;
var lk2=String(f.like).split(',');
return v+parseFloat(lk2[gi(a,b)]);
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
var sclaimArr=getSclaim();
var pclaimArr=getPclaim();
var claims=sclaimArr.concat(pclaimArr);
// ※人狼視点は「人狼の初期認識」（役職確定直後）で完成済みのためここでは何もしない
// ※liar変数は生死に関わらず更新する（観測者側のisAlive判定は行わない）
// ===================================================
// フェーズ1：全体ライアー（客観・視点によらずブロードキャスト型）
// ===================================================
// ---CO人数による正直確定（モード共通：gm5=3CO／gm9=5COで閾値到達→未CO者を村人(15)確定）---
var coThreshold=(n===5)?3:5;
var coCount=0;
for(var i=1;i<=n;i++){if(getCO(i)!==0)coCount++;}
if(coCount>=coThreshold){
for(var i=1;i<=n;i++){
if(getCO(i)!==0)continue;
for(var obs=1;obs<=n;obs++){
if(obs===i)continue;
setLiar(gi(obs,i),15);
}
}
}
// ---死亡COチェーン（5人モード専用）：A黒B・B黒C→Cを人狼(5)確定---
if(n===5){
for(var a=1;a<=n;a++){
if(getCO(a)===0)continue;
if(isAlive(a))continue;
for(var b=1;b<=n;b++){
if(b===a)continue;
if(getCO(b)===0)continue;
if(isAlive(b))continue;
var aClaimedB=false;
for(var c=0;c<claims.length;c++){
if(claims[c][1]===a&&claims[c][2]===b&&claims[c][3]===1){aClaimedB=true;break;}
}
if(!aClaimedB)continue;
var cTarget=0;
for(var c=0;c<claims.length;c++){
if(claims[c][1]===b&&claims[c][3]===1){cTarget=claims[c][2];break;}
}
if(cTarget===0)continue;
for(var obs=1;obs<=n;obs++){
if(obs===cTarget)continue;
setLiar(gi(obs,cTarget),5);
}
}
}
}
// ---sclaim/pclaim全員視点チェック：全員一致で正直(2)以上が確定している人物を「人狼」と報告した申告者は嘘つき(1)確定---
function isPubliclyCleared(t){
for(var i=1;i<=n;i++){
if(i===t)continue;
var v=getLiar(i,t);
if(!(v===2||v>=10))return false;
}
return true;
}
for(var c=0;c<claims.length;c++){
var reporter=claims[c][1],target=claims[c][2],result=claims[c][3];
if(result!==1)continue;
if(!isPubliclyCleared(target))continue;
for(var obs=1;obs<=n;obs++){
if(obs===reporter)continue;
setLiar(gi(obs,reporter),1);
}
}
// ---狂人(9)発見済み→残りの嘘つき(1)は人狼(5)へ自動昇格---
for(var obs=1;obs<=n;obs++){
var hasMad=false;
for(var t=1;t<=n;t++){
if(t===obs)continue;
if(getLiar(obs,t)===9){hasMad=true;break;}
}
if(!hasMad)continue;
for(var t=1;t<=n;t++){
if(t===obs)continue;
if(getLiar(obs,t)===1)setLiar(gi(obs,t),5);
}
}
// ---陣営人数確定による残りメンバーの人間確定：1・5・9の合計がgm5=2/gm9=3に到達したら、残りの0/2/3を2に（4以上は不可侵）---
var campCountTarget=(n===5)?2:3;
for(var obs=1;obs<=n;obs++){
var campCount=0;
for(var t=1;t<=n;t++){
if(t===obs)continue;
var v=getLiar(obs,t);
if(v===1||v===5||v===9)campCount++;
}
if(campCount<campCountTarget)continue;
for(var t=1;t<=n;t++){
if(t===obs)continue;
var v=getLiar(obs,t);
if(v===0||v===2||v===3)setLiar(gi(obs,t),2);
}
}
// ===================================================
// フェーズ2：個別ライアー（主観・観測者ごと）
// ===================================================
// ---占いCO者が人狼自身(w)を人間と判定→その人狼視点でliar=9確定---
for(var w=1;w<=n;w++){
if(getRole(w)>5)continue; // 真の人狼のみ（狂人自身は初期認識を持たないため対象外）
for(var c=0;c<sclaimArr.length;c++){
var reporter=sclaimArr[c][1],target=sclaimArr[c][2],result=sclaimArr[c][3];
if(reporter===w)continue;
if(target===w&&result===0)setLiar(gi(w,reporter),9);
}
}
// ---（9人専用）霊媒CO者が既知の味方人狼を人間と判定→その人狼視点でliar=9確定---
if(n===9){
for(var w=1;w<=n;w++){
if(getRole(w)>5)continue;
for(var c=0;c<pclaimArr.length;c++){
var reporter=pclaimArr[c][1],target=pclaimArr[c][2],result=pclaimArr[c][3];
if(reporter===w)continue;
if(target===w)continue;
if(result!==0)continue;
if(getLiar(w,target)!==5)continue; // 初期認識済みの味方人狼のみ対象
setLiar(gi(w,reporter),9);
}
}
}
// ---収束ループ（観測者ごとの主観推論を4回まわして収束させる）---
for(var loop=0;loop<4;loop++){
// 嘘つき(1)発見→無条件で狂人(9)
for(var obs=1;obs<=n;obs++){
for(var t=1;t<=n;t++){
if(t===obs)continue;
if(getLiar(obs,t)===1)setLiar(gi(obs,t),9);
}
}
// 狂人(9)確定→残りの未確定者(0,1,2)を村人(15)に変換
for(var obs=1;obs<=n;obs++){
var hasMad2=false;
for(var t=1;t<=n;t++){
if(t===obs)continue;
if(getLiar(obs,t)===9){hasMad2=true;break;}
}
if(!hasMad2)continue;
for(var t=1;t<=n;t++){
if(t===obs)continue;
var v=getLiar(obs,t);
if(v===0||v===1||v===2)setLiar(gi(obs,t),15);
}
}
// 村人確定者(15)を人狼と申告したCO者は矛盾＝嘘つき(1)
for(var obs=1;obs<=n;obs++){
for(var c=0;c<claims.length;c++){
var reporter=claims[c][1],target=claims[c][2],result=claims[c][3];
if(reporter===obs)continue;
if(target===obs)continue;
if(result===1&&getLiar(obs,target)===15)setLiar(gi(obs,reporter),1);
}
}
}
// ---狂人セクション：狂人自身の視点でのライアー更新---
for(var m=1;m<=n;m++){
if(getRole(m)!==9)continue;
// ①1(嘘つき)があれば無条件で5(人狼)に自動昇格
for(var t=1;t<=n;t++){
if(t===m)continue;
if(getLiar(m,t)===1)setLiar(gi(m,t),5);
}
// ②自分が占い師COしている場合、自分以外の占い師CO者を4(囮)に
if(getCO(m)===1){
for(var c=1;c<=n;c++){
if(c===m)continue;
if(getCO(c)===1)setLiar(gi(m,c),4);
}
}
// ③自分が霊媒師COしている場合、自分以外の霊媒師CO者を4(囮)に
if(getCO(m)===2){
for(var c=1;c<=n;c++){
if(c===m)continue;
if(getCO(c)===2)setLiar(gi(m,c),4);
}
}
// ④⑤liar=5(人狼確定)の相手が占い師/霊媒師COしている場合、それ以外の同役職CO者を4(囮)に
for(var w2=1;w2<=n;w2++){
if(w2===m)continue;
if(getLiar(m,w2)!==5)continue;
if(getCO(w2)===1){
for(var c=1;c<=n;c++){
if(c===m||c===w2)continue;
if(getCO(c)===1)setLiar(gi(m,c),4);
}
}
if(getCO(w2)===2){
for(var c=1;c<=n;c++){
if(c===m||c===w2)continue;
if(getCO(c)===2)setLiar(gi(m,c),4);
}
}
}
}
// ---人狼セクション：占い師CO人狼→他の占い師CO者(自分以外)を無条件で4(囮)に---
for(var w3=1;w3<=n;w3++){
if(getRole(w3)>5)continue;
if(getCO(w3)!==1)continue;
for(var c=1;c<=n;c++){
if(c===w3)continue;
if(getCO(c)===1)setLiar(gi(w3,c),4);
}
}
// ---人狼セクション：霊媒師CO人狼→他の霊媒師CO者(自分以外)を無条件で4(囮)に---
for(var w4=1;w4<=n;w4++){
if(getRole(w4)>5)continue;
if(getCO(w4)!==2)continue;
for(var c=1;c<=n;c++){
if(c===w4)continue;
if(getCO(c)===2)setLiar(gi(w4,c),4);
}
}
// ---人狼＋狂人：最終整合性（liar=4の個数をgm5=2／gm9=3個に揃える）---
var quotaTarget=(n===5)?2:3;
for(var obs2=1;obs2<=n;obs2++){
if(!(getRole(obs2)<=5||getRole(obs2)===9))continue;
var fourList=[];
for(var t=1;t<=n;t++){
if(t===obs2)continue;
if(getLiar(obs2,t)===4)fourList.push(t);
}
if(fourList.length<quotaTarget){
// 不足：現在生存中・liar値0〜3のキャラから知覚平常心が低い順に補充
var need=quotaTarget-fourList.length;
var pool=[];
for(var t=1;t<=n;t++){
if(t===obs2)continue;
if(!isAlive(t))continue;
var v=getLiar(obs2,t);
if(v<0||v>3)continue;
pool.push(t);
}
pool.sort(function(x,y){return getPC(obs2,x)-getPC(obs2,y);});
for(var k=0;k<need&&k<pool.length;k++){
setLiar(gi(obs2,pool[k]),4);
}
}else if(fourList.length>quotaTarget){
// 過多：4かつ未COのキャラから知覚平常心が高い順に0へ降格
var excess=fourList.length-quotaTarget;
var demotePool=fourList.filter(function(t){return getCO(t)===0;});
demotePool.sort(function(x,y){return getPC(obs2,y)-getPC(obs2,x);});
for(var k=0;k<excess&&k<demotePool.length;k++){
var didx=gi(obs2,demotePool[k]);
var dlr=String(f.liar).split(',');
dlr[didx]="0";
f.liar=dlr.join(',');
}
}
}
// ---生存者4人以下の例外：4の対象が全員生存中なら最高PCを0へ降格し、死亡者のliar=0からランダムに1人4へ---
var aliveTotal=0;
for(var i=1;i<=n;i++){if(isAlive(i))aliveTotal++;}
if(aliveTotal<=4){
for(var obs3=1;obs3<=n;obs3++){
if(!(getRole(obs3)<=5||getRole(obs3)===9))continue;
var fourList2=[];
for(var t=1;t<=n;t++){
if(t===obs3)continue;
if(getLiar(obs3,t)===4)fourList2.push(t);
}
if(fourList2.length!==quotaTarget)continue;
var allAliveFour=true;
for(var k=0;k<fourList2.length;k++){if(!isAlive(fourList2[k])){allAliveFour=false;break;}}
if(!allAliveFour)continue;
var highest=fourList2[0];
for(var k=1;k<fourList2.length;k++){if(getPC(obs3,fourList2[k])>getPC(obs3,highest))highest=fourList2[k];}
var hidx=gi(obs3,highest);
var hlr=String(f.liar).split(',');
hlr[hidx]="0";
f.liar=hlr.join(',');
var deadZero=[];
for(var t=1;t<=n;t++){
if(t===obs3)continue;
if(isAlive(t))continue;
if(getLiar(obs3,t)===0)deadZero.push(t);
}
if(deadZero.length>0){
var pick=deadZero[Math.floor(Math.random()*deadZero.length)];
setLiar(gi(obs3,pick),4);
}
}
}
[endscript]

[return  ]
*death

[iscript]
// ===== プレイヤー死亡判定 =====
// 旧実装はここでf.targetを0/1のフラグに流用していたが、f.targetは「襲撃対象のキャラ番号」として
// night.ks側（*morning→UI.ks *name_change）まで生存している必要があるため、
// 衝突しないf.name2を代わりに使う（f.name2はこの時点で未使用・後段でも参照されない安全な一時変数）。
f.name2=parseInt(f.result)===parseInt(f.player)?1:0;
if(f.name2===1){f.player_death=1;}
[endscript]

[call  storage="end.ks"  target="*player_death"  cond="f.name2==1"  ]
[iscript]
var dead=parseInt(f.result);
var aliveArr=String(f.alive).split(",");
aliveArr[dead-1]="0";
f.alive=aliveArr.join(",");
// liarの確定値（5,9,10,11,15）は死亡しても消さない。生死判定はisAlive()側で行う。
[endscript]

*game_set

[iscript]
var n=parseInt(f.gamemode);
var roles=String(f.character).split(",").map(function(v){return parseInt(v);});
var aliveArr=String(f.alive).split(",");
var aliveWolf=0,aliveHuman=0;
for(var i=0;i<n;i++){
if(aliveArr[i]==="0")continue;
if(roles[i]<=5)aliveWolf++;else aliveHuman++;
}
f.win=aliveWolf===0?1:aliveWolf>=aliveHuman?2:0;
[endscript]

[jump  storage="end.ks"  target="*game_set"  cond="f.win!=0"  ]
[jump  storage="night.ks"  target="*night"  cond="f.jump=='vote'"  ]
[jump  storage="night.ks"  target="*morning"  cond="f.jump=='wolf'"  ]
*alive

[iscript]
var n=parseInt(f.gamemode);
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var aliveArr=String(f.alive).split(",");
var aliveNames=[];
for(var i=0;i<n;i++){
if(aliveArr[i]==="1")aliveNames.push(names[i+1]);
}
f.display01=aliveNames.join("、");
[endscript]

[tb_start_text mode=1 ]
#システム
残りの生存者は[emb exp="f.display01"]です。[p]
[_tb_end_text]

[return  ]
*action

[tb_eval  exp="f.result=0"  name="result"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_eval  exp="f.action+=1"  name="action"  cmd="+="  op="t"  val="1"  val_2="undefined"  ]
[iscript]
if(parseInt(f.day)===1){
if(parseInt(f.turn)>=6){
if(parseInt(f.action)/parseInt(f.turn)>0.5){
f.result='noisy';
}
}
}else{
if(parseInt(f.action)>=3){
f.result='noisy';
}
}
[endscript]

[jump  storage="system.ks"  target="*noisy"  cond="f.result=='noisy'"  ]
[return  ]
*noisy

[iscript]
function addCalm(i,val){var arr=String(f.calm).split(",");arr[i-1]=String(parseFloat(arr[i-1])+val);f.calm=arr.join(",");}
addCalm(parseInt(f.player),-20);
[endscript]

[iscript]
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var candidates=[];
for(var i=1;i<=n;i++){
if(i!==parseInt(f.player)&&aliveArr[i-1]==="1")candidates.push(i);
}
f.target=candidates[Math.floor(Math.random()*candidates.length)];
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
f.name=names[parseInt(f.player)];
[endscript]

[call  storage="mafutsu.ks"  target="*noisy"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*noisy"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*noisy"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*noisy"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*noisy"  cond="f.target==5"  ]
[call  storage="shigure.ks"  target="*noisy"  cond="f.target==6"  ]
[call  storage="yamabuki.ks"  target="*noisy"  cond="f.target==7"  ]
[call  storage="gato.ks"  target="*noisy"  cond="f.target==8"  ]
[call  storage="urushibara.ks"  target="*noisy"  cond="f.target==9"  ]
[jump  storage="observe.ks"  target="*observe"  ]
*quiet

[tb_eval  exp="f.result=0"  name="result"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[iscript]
// quietチェックのみ（noisyチェックはしない）
var day=parseInt(f.day),turn=parseInt(f.turn),action=parseInt(f.action);
if(day===1){
if(turn>=5&&action/turn<0.2)f.result='quiet';
}else{
if(turn>=4&&action===0)f.result='quiet';
}
[endscript]

[jump  storage="system.ks"  target="*q_damege"  cond="f.result=='quiet'"  ]
[return  ]
*q_damege

[iscript]
function addCalm(i,val){var arr=String(f.calm).split(",");arr[i-1]=String(parseFloat(arr[i-1])+val);f.calm=arr.join(",");}
addCalm(parseInt(f.player),-20);
[endscript]

[return  ]
