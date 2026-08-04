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
f.suspect="0,0,0,0,0,0,0,0,0,0";

// ===== 平常心（5人分の基礎値） =====
f.calm="100,80,110,100,120";

// ===== 投票関連（5人分） =====
f.votes="0,0,0,0,0";
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
f.liar="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
f.like="10,0,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,30,0,0,0,0,0,30,0,0,0,0,0,0,0,0,0,30,0,0,0,0,0,30,0,0,0";
f.suspect="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";

// ===== 平常心（9人分の基礎値。6〜9も補正なしの基礎値、ペアバフは都度計算） =====
f.calm="100,80,110,100,120,110,90,100,110";

// ===== 投票関連（9人分） =====
f.votes="0,0,0,0,0,0,0,0,0";
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
function setLiar(idx,val){
var lr=String(f.liar).split(',');
var cur=parseInt(lr[idx]);
if(cur===5||cur===9||cur===10||cur===11||cur===15)return;
lr[idx]=String(val);
f.liar=lr.join(',');
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

// ===== ②5人モード専用：処刑続行バレ =====
if(n===5){
var executed=parseInt(f.result);
if(executed>0){
for(var c=0;c<claims.length;c++){
var reporter=claims[c][1],target=claims[c][2],result=claims[c][3];
if(target===executed&&result===1){
for(var obs=1;obs<=n;obs++){
if(obs===reporter)continue;
if(!isAlive(obs))continue;
setLiar(gi(obs,reporter),1);
}
}
}
}
}

// ===== ②5人モード専用：CO人数による正直確定（閾値3＝人狼1＋狂人1＋占い師1） =====
if(n===5){
var coCount=0;
for(var i=1;i<=n;i++){if(getCO(i)!==0)coCount++;}
if(coCount>=3){
for(var i=1;i<=n;i++){
if(getCO(i)!==0)continue;
for(var obs=1;obs<=n;obs++){
if(obs===i)continue;
if(!isAlive(obs))continue;
setLiar(gi(obs,i),15);
}
}
}
}

// ===== ①モード共通：占いCO者が観測者自身（人狼）を人間と判定→確定狂人(9) =====
for(var w=1;w<=n;w++){
if(getRole(w)>5)continue; // 真の人狼のみ（狂人自身は初期認識を持たないため対象外）
if(!isAlive(w))continue;
for(var c=0;c<sclaimArr.length;c++){
var reporter=sclaimArr[c][1],target=sclaimArr[c][2],result=sclaimArr[c][3];
if(reporter===w)continue;
if(target===w&&result===0)setLiar(gi(w,reporter),9);
}
}

// ===== ③9人モード専用：霊媒CO者が味方人狼（既知）を人間と判定→確定狂人(9) =====
if(n===9){
for(var w=1;w<=n;w++){
if(getRole(w)>5)continue;
if(!isAlive(w))continue;
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
// ※9人モードの処刑続行バレ・CO人数閾値の再設計は未着手（引継書に明記のTODO）

// ===== ①モード共通：死亡COチェーン（A黒B・B黒C→C確定人狼） =====
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
if(!isAlive(obs))continue;
var lr=String(f.liar).split(',');
lr[gi(obs,cTarget)]='5';
f.liar=lr.join(',');
}
}
}

// ===== ①モード共通：伝播ループ（1→9変換／狂人確定→残り村人化／村人矛盾検出を収束するまで数回回す） =====
for(var loop=0;loop<4;loop++){
// 嘘つき(1)発見→無条件で狂人(9)
for(var obs=1;obs<=n;obs++){
if(!isAlive(obs))continue;
for(var t=1;t<=n;t++){
if(t===obs)continue;
if(getLiar(obs,t)===1)setLiar(gi(obs,t),9);
}
}
// 狂人(9)確定→残りの未確定者(0,1,2)を村人(15)に変換
for(var obs=1;obs<=n;obs++){
if(!isAlive(obs))continue;
var hasMad=false;
for(var t=1;t<=n;t++){
if(t===obs)continue;
if(getLiar(obs,t)===9){hasMad=true;break;}
}
if(!hasMad)continue;
for(var t=1;t<=n;t++){
if(t===obs)continue;
var v=getLiar(obs,t);
if(v===0||v===1||v===2)setLiar(gi(obs,t),15);
}
}
// 村人確定者(15)を人狼と申告したCO者は矛盾＝嘘つき(1)
for(var obs=1;obs<=n;obs++){
if(!isAlive(obs))continue;
for(var c=0;c<claims.length;c++){
var reporter=claims[c][1],target=claims[c][2],result=claims[c][3];
if(reporter===obs)continue;
if(target===obs)continue;
if(result===1&&getLiar(obs,target)===15)setLiar(gi(obs,reporter),1);
}
}
}
[endscript]

*suspect

[iscript]
var n=parseInt(f.gamemode);
function gi(a,b){var nn=parseInt(f.gamemode);var o=(a-1)*(nn-1);var t=[];for(var i=1;i<=nn;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function getRole(i){return parseInt(String(f.character).split(',')[i-1]);}
function getCO(i){return parseInt(String(f.co).split(',')[i-1]);}
function getLiar(a,b){return parseInt(String(f.liar).split(',')[gi(a,b)]);}
function getCalm(i){
var v=parseFloat(String(f.calm).split(',')[i-1]);
if(i===6&&isAlive(7))v*=1.1;
if(i===7&&isAlive(6))v*=1.1;
if(i===9&&isAlive(8))v*=1.4;
return v;
}
function getLike(a,b){return parseInt(String(f.like).split(',')[gi(a,b)]);}
function getPC(actor,tgt){return getCalm(tgt)+getLike(actor,tgt);}
function setSuspect(i,slot,val){
var arr=String(f.suspect).split(',');
arr[(i-1)*2+slot]=String(val);
f.suspect=arr.join(',');
}
// tが「t以外の生存キャラ全員」から見て人間確定(2)または特殊役職・村人確定(10以上)か
function isPubliclyCleared(t){
for(var i=1;i<=n;i++){
if(i===t)continue;
if(!isAlive(i))continue;
var v=getLiar(i,t);
if(!(v===2||v>=10))return false;
}
return true;
}

// ===== 村人サイド視点（役職10以上：占い師・霊媒師・騎士・村人） =====
for(var obs=1;obs<=n;obs++){
if(getRole(obs)<10)continue;
if(!isAlive(obs))continue;

var tier5=[],tier9=[],tier1=[];
for(var t=1;t<=n;t++){
if(t===obs)continue;
var lv=getLiar(obs,t);
if(lv===5)tier5.push(t);
else if(lv===9)tier9.push(t);
else if(lv===1)tier1.push(t);
}
tier5.sort(function(a,b){return getPC(obs,a)-getPC(obs,b);});
tier9.sort(function(a,b){return getPC(obs,a)-getPC(obs,b);});
tier1.sort(function(a,b){return getPC(obs,a)-getPC(obs,b);});
var picked=tier5.concat(tier9).concat(tier1).slice(0,2);

if(picked.length<2){
var fallback=[];
for(var t=1;t<=n;t++){
if(t===obs)continue;
if(picked.indexOf(t)!==-1)continue;
if(!isAlive(t))continue;
var lv=getLiar(obs,t);
if(lv===2||lv===15)continue;
fallback.push(t);
}
fallback.sort(function(a,b){return getPC(obs,a)-getPC(obs,b);});
while(picked.length<2&&fallback.length>0){
picked.push(fallback.shift());
}
}

setSuspect(obs,0,picked.length>0?picked[0]:0);
setSuspect(obs,1,picked.length>1?picked[1]:0);
}

// ===== 人狼視点（役職5以下：真の人狼のみ／仮ロジック） =====
for(var obs=1;obs<=n;obs++){
if(getRole(obs)>5)continue;
if(!isAlive(obs))continue;

var pool=[];
for(var t=1;t<=n;t++){
if(t===obs)continue;
if(!isAlive(t))continue;
if(getLiar(obs,t)===5)continue; // 味方人狼を母集団から除外
if(isPubliclyCleared(t))continue; // 全員一致で人間/村人確定済みは除外
pool.push(t);
}

var coTier=pool.filter(function(t){return getCO(t)!==0;});
coTier.sort(function(a,b){return getPC(obs,a)-getPC(obs,b);});
var picked=coTier.slice(0,2);

if(picked.length<2){
var fallback=pool.filter(function(t){return picked.indexOf(t)===-1;});
fallback.sort(function(a,b){return getPC(obs,a)-getPC(obs,b);});
while(picked.length<2&&fallback.length>0){
picked.push(fallback.shift());
}
}

setSuspect(obs,0,picked.length>0?picked[0]:0);
setSuspect(obs,1,picked.length>1?picked[1]:0);
}
[endscript]

[return  ]
*death

[iscript]
f.player_death=parseInt(f.result)===parseInt(f.player)?1:0;
[endscript]

[call  storage="end.ks"  target="*player_death"  cond="f.player_death==1"  ]
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
[jump  storage="scenario.ks"  target="*morning"  cond="f.jump=='wolf'"  ]
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
