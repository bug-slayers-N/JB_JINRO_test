[_tb_system_call storage=system/_CO.ks]

*please_CO

[iscript]
if(parseInt(f.gamemode)===5){
f.result=1;
}
[endscript]

[jump  storage="CO.ks"  target="*9mode_choice_end"  cond="f.gamemode==5"  ]
*9mode_choice

[jump  storage="CO.ks"  target="*please_CO_player_choice"  cond="f.ai_actor==f.player"  ]
[iscript]
var coArr=String(f.co).split(",");
var has1=coArr.indexOf("1")!==-1;
f.result=has1?2:1;
[endscript]

[jump  storage="CO.ks"  target="*9mode_choice_end"  ]
*please_CO_player_choice

[iscript]
var coArr=String(f.co).split(",");
var has1=coArr.indexOf("1")!==-1;
var has2=coArr.indexOf("2")!==-1;
var jmp=0;
if(has1)jmp=1;
else if(has2)jmp=2;
f.jump=jmp;
if(jmp===1)f.result=2;
else if(jmp===2)f.result=1;
else f.result=0;
[endscript]

[jump  storage="CO.ks"  target="*9mode_choice_end"  cond="f.result!=0"  ]
[tb_start_text mode=1 ]
#システム
COの役職は？[p]
[_tb_end_text]

[glink  color="black"  storage="CO.ks"  size="20"  autopos="true"  text="占い師"  target="*please_CO_choice_seer"  ]
[glink  color="black"  storage="CO.ks"  size="20"  autopos="true"  text="霊媒師"  target="*please_CO_choice_psychic"  ]
[s  ]
*please_CO_choice_seer

[tb_eval  exp="f.result=1"  name="result"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="CO.ks"  target="*player_CO"  cond="f.role2=='fco'"  ]
[jump  storage="CO.ks"  target="*9mode_choice_end"  ]
*please_CO_choice_psychic

[tb_eval  exp="f.result=2"  name="result"  cmd="="  op="t"  val="2"  val_2="undefined"  ]
[jump  storage="CO.ks"  target="*player_CO"  cond="f.role2=='fco'"  ]
*9mode_choice_end

*please_CO_characall

[iscript]
var result=parseInt(f.result);
f.display09=(result===1)?"占い師":"霊媒師";
[endscript]

[call  storage="mafutsu.ks"  target="*pCO"  cond="f.ai_actor==1"  ]
[call  storage="sisigami.ks"  target="*pCO"  cond="f.ai_actor==2"  ]
[call  storage="murasame.ks"  target="*pCO"  cond="f.ai_actor==3"  ]
[call  storage="kano.ks"  target="*pCO"  cond="f.ai_actor==4"  ]
[call  storage="tendo.ks"  target="*pCO"  cond="f.ai_actor==5"  ]
[call  storage="shigure.ks"  target="*pCO"  cond="f.ai_actor==6"  ]
[call  storage="yamabuki.ks"  target="*pCO"  cond="f.ai_actor==7"  ]
[call  storage="gato.ks"  target="*pCO"  cond="f.ai_actor==8"  ]
[call  storage="urushibara.ks"  target="*pCO"  cond="f.ai_actor==9"  ]
*please_CO_characall_end

*player_CO_start

[iscript]
var role = parseInt(f.role);
var result = parseInt(f.result);
var pn = parseInt(f.player);
var coArr = String(f.co).split(",");
var playerCoed = coArr[pn-1]!=="0";
var qualifies = !playerCoed && ((role<10) || (role===10&&result===1) || (role===11&&result===2));
f.jump = qualifies?1:0;
[endscript]

[jump  storage="CO.ks"  target="*AI_lottery"  cond="f.jump==0"  ]
[jump  storage="CO.ks"  target="*AI_lottery"  cond="f.player_death==1"  ]
[glink  color="black"  storage="CO.ks"  size="20"  text="COする"  target="*player_CO_yes"  autopos="true"  ]
[glink  color="black"  storage="CO.ks"  size="20"  text="COしない"  autopos="true"  target="*player_CO_no"  ]
[s  ]
*player_CO_yes

[tb_eval  exp="f.ai_actor=f.player"  name="ai_actor"  cmd="="  op="h"  val="player"  val_2="undefined"  ]
[jump  storage="CO.ks"  target="*player_CO"  ]
*player_CO_no

[jump  storage="CO.ks"  target="*AI_lottery"  ]
*player_CO

[iscript]
var role=parseInt(f.role);
var result=parseInt(f.result);
var jmp=0;
if(role===10){
jmp=1;
}else if(role===11){
jmp=2;
}else{
if(result===1){
jmp=3;
}else if(result===2){
jmp=4;
}
}
var aliveArr=String(f.alive).split(",");
var allAlive=aliveArr.indexOf("0")===-1;
if(allAlive&&(jmp===2||jmp===4))jmp=5;
f.jump=jmp;
if(jmp!==0){
var coVal=(jmp===1||jmp===3)?"1":"2";
var coArr=String(f.co).split(",");
coArr[parseInt(f.player)-1]=coVal;
f.co=coArr.join(",");
}
[endscript]

[jump  storage="CO.ks"  target="*psychic_day1"  cond="f.jump==5"  ]
[call  storage="specialist.ks"  target="*seer_add_sclaim"  cond="f.jump==1"  ]
[call  storage="specialist.ks"  target="*psychic_add_pclaim"  cond="f.jump==2"  ]
[call  storage="specialist.ks"  target="*fake_seer_player"  cond="f.jump==3"  ]
[call  storage="specialist.ks"  target="*fake_psychic_player"  cond="f.jump==4"  ]
*player_CO_end

[jump  storage="CO.ks"  target="*CO_characall"  ]
*AI_lottery

[iscript]
var n=parseInt(f.gamemode);
var pn=parseInt(f.player);
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
var charArr=String(f.character).split(",").map(Number);
var pArr=[0,2,0,0,2,1,1,2,2,0];
function getRole(i){return charArr[i-1];}
// 抽選対象の基礎プール：生存・プレイヤー除外・未CO・役職12未満
var basePool=[];
for(var i=1;i<=n;i++){
if(i===pn)continue;
if(aliveArr[i-1]==="0")continue;
if(coArr[i-1]!=="0")continue;
if(getRole(i)>=12)continue;
basePool.push(i);
}
// 人狼の重複CO防止ガード：今回のresultと同じ役職を味方人狼が既にCO済みなら
// 人狼の抽選(パートA)自体を止める
var wolfBlocked=false;
for(var i=1;i<=n;i++){
if(getRole(i)>5)continue;
if(parseInt(f.result)===1&&coArr[i-1]==="1")wolfBlocked=true;
if(parseInt(f.result)===2&&coArr[i-1]==="2")wolfBlocked=true;
}
var poolA=wolfBlocked?[]:basePool.filter(function(i){return getRole(i)<=5;});
var poolB=basePool.filter(function(i){return getRole(i)===9;});
var specRole=(parseInt(f.result)===1)?10:11;
var poolC=basePool.filter(function(i){return getRole(i)===specRole;});
function rollPool(pool,rateTbl){
var hits=[];
for(var j=0;j<pool.length;j++){
var c=pool[j];
var p=pArr[c];
var rate=rateTbl[p];
if(Math.random()<rate)hits.push(c);
}
if(hits.length===0)return 0;
return hits[Math.floor(Math.random()*hits.length)];
}
var rateA={2:0.20,1:0.10,0:0.05};
var rateB={2:0.60,1:0.40,0:0.20};
var has1lot=coArr.indexOf("1")!==-1;
var has2lot=coArr.indexOf("2")!==-1;
var soloBoost=(has1lot!==has2lot);
if(soloBoost){
rateA={2:0.30,1:0.20,0:0.15};
rateB={2:0.70,1:0.50,0:0.30};
}
var rateC={2:0.60,1:0.40,0:0.20};
var parts=["A","B","C"];
for(var s=parts.length-1;s>0;s--){
var r=Math.floor(Math.random()*(s+1));
var tmp=parts[s];parts[s]=parts[r];parts[r]=tmp;
}
var winner=0;
for(var pIdx=0;pIdx<parts.length;pIdx++){
if(winner>0)break;
if(parts[pIdx]==="A")winner=rollPool(poolA,rateA);
else if(parts[pIdx]==="B")winner=rollPool(poolB,rateB);
else if(parts[pIdx]==="C")winner=rollPool(poolC,rateC);
}
f.ai_actor=winner;
// ===== COを求めるに応えてai_actorに選ばれた回数を+1 =====
if(winner>0){
var countArr=String(f.count).split(',');
countArr[winner-1]=String(parseInt(countArr[winner-1],10)+1);
f.count=countArr.join(',');
}
[endscript]

[jump  storage="CO.ks"  target="*AI_CO"  cond="f.ai_actor>0"  ]
*AI_lottery_end

[chara_hide_all  time="1000"  wait="true"  ]
[tb_start_text mode=1 ]
#システム
誰もCOしなかった…[p]
[_tb_end_text]

[jump  storage="end.ks"  target="*turn_set"  ]
*AI_CO

[iscript]
var actor=parseInt(f.ai_actor);
var role=parseInt(String(f.character).split(",")[actor-1]);
var result=parseInt(f.result);
var jmp=0;
if(role===10)jmp=1;
else if(role===11)jmp=2;
else if(role<=5||role===9)jmp=(result===1)?3:4;
var aliveArr=String(f.alive).split(",");
var allAlive=aliveArr.indexOf("0")===-1;
if(allAlive&&(jmp===2||jmp===4))jmp=5;
f.jump=jmp;
if(jmp!==0){
var coVal=(jmp===1||jmp===3)?"1":"2";
var coArr=String(f.co).split(",");
coArr[actor-1]=coVal;
f.co=coArr.join(",");
}
[endscript]

[jump  storage="CO.ks"  target="*psychic_day1"  cond="f.jump==5"  ]
[call  storage="specialist.ks"  target="*seer_add_sclaim"  cond="f.jump==1"  ]
[call  storage="specialist.ks"  target="*psychic_add_pclaim"  cond="f.jump==2"  ]
[call  storage="specialist.ks"  target="*fake_seer_AI"  cond="f.jump==3"  ]
[call  storage="specialist.ks"  target="*fake_psychic_AI"  cond="f.jump==4"  ]
*AI_CO_end

*CO_characall

[iscript]
var result=parseInt(f.result);
f.display09=(result===1)?"占い師":"霊媒師";
var charNames = ["", "真経津", "獅子神", "村雨", "叶", "天堂", "時雨", "山吹", "牙頭", "漆原"];
var resultNames = ["人間", "人狼"];
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
var actor = parseInt(f.ai_actor);
var claims = (result===1)?getSclaim():getPclaim();
var mine = [];
for(var i=0;i<claims.length;i++){
if(claims[i][1] === actor) mine.push(claims[i]);
}
var latest = mine[mine.length-1];
f.name = charNames[latest[2]];
f.name2 = resultNames[latest[3]];
[endscript]

*CO_dialogue

[call  storage="mafutsu.ks"  target="*CO"  cond="f.ai_actor==1"  ]
[call  storage="sisigami.ks"  target="*CO"  cond="f.ai_actor==2"  ]
[call  storage="murasame.ks"  target="*CO"  cond="f.ai_actor==3"  ]
[call  storage="kano.ks"  target="*CO"  cond="f.ai_actor==4"  ]
[call  storage="tendo.ks"  target="*CO"  cond="f.ai_actor==5"  ]
[call  storage="shigure.ks"  target="*CO"  cond="f.ai_actor==6"  ]
[call  storage="yamabuki.ks"  target="*CO"  cond="f.ai_actor==7"  ]
[call  storage="gato.ks"  target="*CO"  cond="f.ai_actor==8"  ]
[call  storage="urushibara.ks"  target="*CO"  cond="f.ai_actor==9"  ]
*CO_characall_end

*vsCO

[iscript]
var pn=parseInt(f.player);
var coArr=String(f.co).split(",");
var playerCoed=coArr[pn-1]!=="0";
f.jump=(playerCoed||String(f.role2)==="co")?10:0;
[endscript]

[jump  storage="CO.ks"  target="*AI_vsCO"  cond="f.jump==10"  ]
*player_vsCO

[iscript]
var role=parseInt(f.role);
var result=parseInt(f.result);
var qualifies=(role<10)||(role===10&&result===1)||(role===11&&result===2);
f.jump=qualifies?100:0;
[endscript]

[jump  storage="CO.ks"  target="*AI_vsCO"  cond="f.jump!=100"  ]
[jump  storage="CO.ks"  target="*AI_vsCO"  cond="f.player_death==1"  ]
[glink  color="black"  storage="CO.ks"  size="20"  text="対抗COする"  target="*player_vsCO_yes"  autopos="true"  ]
[glink  color="black"  storage="CO.ks"  size="20"  text="対抗COしない"  target="*player_vsCO_no"  autopos="true"  ]
[s  ]
*player_vsCO_yes

[tb_eval  exp="f.ai_actor=f.player"  name="ai_actor"  cmd="="  op="h"  val="player"  val_2="undefined"  ]
[tb_eval  exp="f.role2='co'"  name="role2"  cmd="="  op="t"  val="co"  val_2="undefined"  ]
[jump  storage="CO.ks"  target="*player_CO"  ]
*player_vsCO_no

[jump  storage="CO.ks"  target="*AI_vsCO"  ]
*AI_vsCO

[iscript]
var n=parseInt(f.gamemode);
var pn=parseInt(f.player);
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
var charArr=String(f.character).split(",").map(Number);
var pArr=[0,2,0,0,2,1,1,2,2,0];
function getRole(i){return charArr[i-1];}
var basePool=[];
for(var i=1;i<=n;i++){
if(i===pn)continue;
if(aliveArr[i-1]==="0")continue;
if(coArr[i-1]!=="0")continue;
if(getRole(i)>=12)continue;
basePool.push(i);
}
var wolfBlocked=false;
for(var i=1;i<=n;i++){
if(getRole(i)>5)continue;
if(parseInt(f.result)===1&&coArr[i-1]==="1")wolfBlocked=true;
if(parseInt(f.result)===2&&coArr[i-1]==="2")wolfBlocked=true;
}
var isRole2Co=(String(f.role2)==="co");
var resultNum=parseInt(f.result);
var otherVal=(resultNum===1)?"2":"1";
var otherCount=0;
for(var oi=0;oi<coArr.length;oi++){if(coArr[oi]===otherVal)otherCount++;}
var otherContested=(otherCount>=2);
var poolA=wolfBlocked?[]:basePool.filter(function(i){return getRole(i)<=5;});
var poolB=basePool.filter(function(i){return getRole(i)===9;});
var specRole=(parseInt(f.result)===1)?10:11;
var poolC=basePool.filter(function(i){return getRole(i)===specRole;});
function rollPool(pool,rateTbl){
var hits=[];
for(var j=0;j<pool.length;j++){
var c=pool[j];
var p=pArr[c];
var rate=rateTbl[p];
if(Math.random()<rate)hits.push(c);
}
if(hits.length===0)return 0;
return hits[Math.floor(Math.random()*hits.length)];
}
var rateA;
var rateB;
if(isRole2Co){
rateA={2:0.10,1:0.05,0:0.00};
rateB={2:0.10,1:0.00,0:0.00};
}else if(otherContested){
rateA={2:0.35,1:0.30,0:0.25};
rateB={2:1.00,1:0.86,0:0.60};
}else{
rateA={2:0.15,1:0.10,0:0.05};
rateB={2:0.80,1:0.66,0:0.40};
}
var rateC={2:0.95,1:0.80,0:0.65};
var parts=["A","B","C"];
for(var s=parts.length-1;s>0;s--){
var r=Math.floor(Math.random()*(s+1));
var tmp=parts[s];parts[s]=parts[r];parts[r]=tmp;
}
var winner=0;
for(var pIdx=0;pIdx<parts.length;pIdx++){
if(winner>0)break;
if(parts[pIdx]==="A")winner=rollPool(poolA,rateA);
else if(parts[pIdx]==="B")winner=rollPool(poolB,rateB);
else if(parts[pIdx]==="C")winner=rollPool(poolC,rateC);
}
if(winner>0){
f.ai_actor=winner;
f.role2="co";
// ===== 対抗COでai_actorに選ばれた回数を+1 =====
var countArr=String(f.count).split(',');
countArr[winner-1]=String(parseInt(countArr[winner-1],10)+1);
f.count=countArr.join(',');
}else{
f.ai_actor=0;
}
[endscript]

[jump  storage="CO.ks"  target="*AI_CO"  cond="f.ai_actor>0"  ]
*end

[iscript]
f.role2=0;
var coArr=String(f.co).split(",");
var result=parseInt(f.result);
var coCount=coArr.filter(function(c){return c===String(result);}).length;
if(coCount>=2)f.jump="CO3";
[endscript]

[jump  storage="CO.ks"  target="*CO3"  cond="f.jump=='CO3'"  ]
*CO3_back

[iscript]
// ===== 真占い師/真霊媒師：対抗COのライアーを更新（0→1、3→9。5人・9人モード共通、生死問わず対象） =====
var n=parseInt(f.gamemode);
var result=parseInt(f.result);
var needRole=(result===1)?10:11;
var roles=String(f.character).split(",").map(Number);
var coArr=String(f.co).split(",");
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
var trueHolder=0;
for(var i=1;i<=n;i++){
if(roles[i-1]===needRole){trueHolder=i;break;}
}
if(trueHolder>0){
for(var r=1;r<=n;r++){
if(r===trueHolder)continue;
if(coArr[r-1]!==String(result))continue;
var idx=gi(trueHolder,r);
var lr=String(f.liar).split(',');
var cur=parseInt(lr[idx]);
if(cur===0){
lr[idx]="1";
f.liar=lr.join(',');
}else if(cur===3){
lr[idx]="9";
f.liar=lr.join(',');
}
}
}
[endscript]

[call  storage="system.ks"  target="*liar"  ]
[iscript]
// ===== 人狼陣営：今回CO確定した役職に人狼がいた場合、残りの人狼が確率でrivalに4(囮)を入れる（gm9以上限定） =====
// ・確率抽選をする本人は「今回その役職をCOした当人以外の人狼」。当人自身の視点は既にsystem.ks側の無条件ルールで反映済み。
// ・対象は「仲間人狼以外」で、今回の役職(f.result)にCO済みの全キャラ。
// ・確率は抽選者本人の性格(積極的85%/普通70%/消極的40%)。特殊ペア(2⇔3, 6⇔7, 8⇔9)は100%。
var n=parseInt(f.gamemode);
if(n>=9){
var result=parseInt(f.result); // 1=占い師CO中、2=霊媒師CO中
var roles=String(f.character).split(",").map(Number);
var coArr=String(f.co).split(",");
var wolfCoed=0;
for(var i=1;i<=n;i++){
if(roles[i-1]<=5&&parseInt(coArr[i-1])===result){wolfCoed=i;break;}
}
if(wolfCoed>0){
var personality={1:"active",4:"active",7:"active",8:"active",5:"normal",6:"normal",2:"passive",3:"passive",9:"passive"};
var rateTbl={active:0.85,normal:0.70,passive:0.40};
var specialPairs=[[2,3],[6,7],[8,9]];
function isSpecialPair(a,b){
for(var p=0;p<specialPairs.length;p++){
if((specialPairs[p][0]===a&&specialPairs[p][1]===b)||(specialPairs[p][0]===b&&specialPairs[p][1]===a))return true;
}
return false;
}
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function setLiar4(idx){
var lr=String(f.liar).split(',');
if(parseInt(lr[idx])>=5)return;
lr[idx]="4";
f.liar=lr.join(',');
}
for(var r=1;r<=n;r++){
if(roles[r-1]>5)continue; // 人狼のみが抽選者
if(r===wolfCoed)continue; // 今回CO済みの当人は対象外
for(var c=1;c<=n;c++){
if(c===r)continue;
if(roles[c-1]<=5)continue; // 仲間人狼は対象外
if(parseInt(coArr[c-1])!==result)continue; // 今回の役職をCOしている相手のみ
var rate=isSpecialPair(r,c)?1.0:rateTbl[personality[r]];
if(Math.random()<rate)setLiar4(gi(r,c));
}
}
}
}
[endscript]

[jump  storage="end.ks"  target="*turn_set"  ]
*CO3

[iscript]
var n = parseInt(f.gamemode);
var coArr = String(f.co).split(",");
var aliveArr = String(f.alive).split(",");
var result = parseInt(f.result);
var cands = [];
for(var i = 1; i <= n; i++){
if(aliveArr[i-1] !== "1") continue;
if(result===1 && coArr[i-1] === "1") continue;
if(result===2 && coArr[i-1] === "2") continue;
cands.push(i);
}
f.target = cands[Math.floor(Math.random() * cands.length)];
[endscript]

[call  storage="mafutsu.ks"  target="*CO3"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*CO3"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*CO3"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*CO3"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*CO3"  cond="f.target==5"  ]
[call  storage="shigure.ks"  target="*CO3"  cond="f.target==6"  ]
[call  storage="yamabuki.ks"  target="*CO3"  cond="f.target==7"  ]
[call  storage="gato.ks"  target="*CO3"  cond="f.target==8"  ]
[call  storage="urushibara.ks"  target="*CO3"  cond="f.target==9"  ]
[jump  storage="CO.ks"  target="*CO3_back"  ]
*psychic_day1

[iscript]
var actor=parseInt(f.ai_actor);
var coArr=String(f.co).split(",");
coArr[actor-1]="2";
f.co=coArr.join(",");
f.jump="day1";
[endscript]

[jump  storage="CO.ks"  target="*CO_dialogue"  ]
