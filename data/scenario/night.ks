[_tb_system_call storage=system/_night.ks]

*night

[tb_start_text mode=1 ]
#システム
夜になりました。[p]
[_tb_end_text]

[jump  storage="night.ks"  target="*player_death"  cond="f.player_death==1"  ]
[jump  storage="uranai.ks"  target="*uranai_night"  cond="f.role==10"  ]
[iscript]
var coArr = String(f.co).split(",");
var playerCO = coArr[parseInt(f.player)-1] === "1";
var role = parseInt(f.role);
f.result = 0; // 初期化（前ターンの残り値をクリア）
if(playerCO && (role <= 5 || role === 9)){
f.result = "fake";
}
[endscript]

[jump  storage="night.ks"  target="*fake_end"  cond="f.result!='fake'"  ]
[tb_eval  exp="f.name2='fake'"  name="name2"  cmd="="  op="t"  val="fake"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#システム
明日の占い報告を決めましょう。[p]
[_tb_end_text]

[jump  storage="CO.ks"  target="*player_fake_CO"  ]
*fake

[iscript]
var actorNum = parseInt(f.player);
var claim2 = String(f.claim2).split(",");
var idx = (actorNum-1)*2;
claim2[idx] = parseInt(f.target);
claim2[idx+1] = parseInt(f.result);
f.claim2 = claim2.join(",");
[endscript]

*fake_end

*player_death

[call  storage="uranai.ks"  target="*uranai_randam"  ]
*uranai_back

[call  storage="uranai.ks"  target="*fake_CO2"  ]
[jump  storage="night.ks"  target="*ai_wolf"  cond="f.role>5"  ]
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
var wolfChar=0;
for(var i=0;i<n;i++){if(parseInt(charArr[i])===1){wolfChar=i+1;break;}}
// マフツを一時的に好感度-20して標的から遠ざける（終了後に戻す）
var mafutsuIdx=(wolfChar!==1&&isAlive(1))?gi(wolfChar,1):-1;
if(mafutsuIdx!==-1)f.like=si(f.like,mafutsuIdx,getEl(f.like,mafutsuIdx)-20);
function getPC(c){return parseFloat(calmArr[c-1])+getEl(f.like,gi(wolfChar,c));}
function getLiar(b){return getEl(f.liar,gi(wolfChar,b));}
// filterFnを満たす生存者（自分除く）をPC降順で返す
function pickBest(filterFn){
var cands=[];
for(var c=1;c<=n;c++){
if(c===wolfChar||!isAlive(c))continue;
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
for(var c=1;c<=n;c++){if(c===wolfChar||!isAlive(c)||isCO(c))continue;cands.push(c);}
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
