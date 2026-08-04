[_tb_system_call storage=system/_debate.ks]

[cm  ]
*gamestart

[mask  time="300"  effect="fadeIn"  color="0x000000"  ]
[tb_show_message_window  ]
[chara_hide_all  time="0"  wait="true"  ]
[call  storage="UI.ks"  target="*myrole"  ]
[bg  time="0"  method="crossfade"  storage="93853245_p0.png"  ]
[mask_off  time="300"  effect="fadeOut"  ]
[call  storage="specialist.ks"  target="*uranai_randam"  ]
[call  storage="specialist.ks"  target="*game_start"  cond="f.role==10"  ]
[iscript]
// ===== 人狼の初期認識：人狼同士のliarを相互に確定(5)としてセット =====
// モードに依存しない（5人モードは人狼が1人のため対象ペアが存在せず、ループは何もしない）
(function(){
var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
var roles=String(f.character).split(",").map(Number);
var wolves=[];
for(var i=1;i<=n;i++){if(roles[i-1]<=5)wolves.push(i);}
var lr=String(f.liar).split(",");
for(var a=0;a<wolves.length;a++){
for(var b=0;b<wolves.length;b++){
if(a===b)continue;
lr[gi(wolves[a],wolves[b])]="5";
}
}
f.liar=lr.join(",");
})();
[endscript]

[iscript]
if(parseInt(f.gamemode)>=9&&parseInt(f.role)<=5){
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var charArr=String(f.character).split(",");
var wolfNames=[];
for(var i=0;i<charArr.length;i++){
if(parseInt(charArr[i])<=5)wolfNames.push(names[i+1]);
}
f.display01=wolfNames.join("、");
}
[endscript]

[jump  storage="debate.ks"  target="*wolf_skip"  cond="f.gamemode<9||f.role>5"  ]
[tb_start_text mode=1 ]
#システム
この試合の人狼は[emb exp="f.display01"]です。[p]

[_tb_end_text]

*wolf_skip

*debate_dialogue

[call  storage="debate.ks"  target="*char_dispatch_debate01"  ]
[jump  storage="end.ks"  target="*turn_count"  ]
*debate_top

[iscript]
var aliveArr = String(f.alive).split(",");
if(aliveArr[parseInt(f.player)-1] === "0") f.player_death = 1;
[endscript]

[iscript]
f.jump=0;
f.result=0;
f.target=0;
f.ai_actor=0;
f.role2=0;
f.win=0;
f.display01=0;
f.display02="";
f.display03="";
f.display04="";
f.display05="";
f.display06="";
f.display07="";
f.display08="";
f.display09="";
[endscript]

[jump  storage="debate.ks"  target="*auto"  cond="f.player_death==1"  ]
[glink  color="btn_08_red"  storage="debate.ks"  size="20"  text="疑う"  x="100"  y="50"  width="150"  height=""  _clickable_img=""  target="*doubt"  ]
[glink  color="btn_08_white"  storage="debate.ks"  size="20"  text="かばう"  x="100"  y="125"  width="150"  height=""  _clickable_img=""  target="*cover"  ]
[glink  color="btn_08_lime"  storage="debate.ks"  size="20"  text="様子を見る"  x="100"  y="200"  width="150"  height=""  _clickable_img=""  target="*watch"  ]
[jump  storage="debate.ks"  target="*s_human"  cond="f.say_human==1"  ]
[glink  color="btn_08_black"  storage="debate.ks"  size="20"  text="人間と言え"  x="300"  y="275"  width="150"  height=""  _clickable_img=""  target="*say_human"  ]
*s_human

[jump  storage="debate.ks"  target="*push_done"  cond="f.push==1"  ]
[glink  color="btn_08_yellow"  storage="debate.ks"  size="20"  text="強く疑う"  x="100"  y="275"  width="150"  height=""  _clickable_img=""  target="*push"  ]
*push_done

[call  storage="debate.ks"  target="*CO_judge"  ]
[jump  storage="debate.ks"  target="*pCO_list"  cond="f.display02==1"  ]
[glink  color="btn_08_purple"  storage="debate.ks"  size="20"  text="COを求める"  x="300"  y="200"  width="150"  height=""  _clickable_img=""  target="*plz_CO"  ]
*pCO_list

[call  storage="debate.ks"  target="*CO_judge"  ]
[jump  storage="debate.ks"  target="*CO_list"  cond="f.display02==1"  ]
[glink  color="btn_08_blue"  storage="debate.ks"  size="20"  text="COする"  x="300"  y="50"  width="150"  height=""  _clickable_img=""  target="*CO"  ]
*CO_list

[call  storage="debate.ks"  target="*CO_judge"  ]
[jump  storage="debate.ks"  target="*fake_CO_list"  cond="f.display02==1"  ]
[glink  color="btn_08_black"  storage="debate.ks"  size="20"  text="偽COする"  x="300"  y="125"  width="150"  height=""  _clickable_img=""  target="*fake_CO"  ]
*fake_CO_list

[glink  color="btn_07_red"  storage="debate.ks"  size="20"  text="状況確認"  target="*check"  x="213"  y="369"  width=""  height=""  _clickable_img=""  ]
[s  ]
*doubt

[call  storage="system.ks"  target="*action"  ]
[jump  storage="mafutsu.ks"  target="*doubt"  cond="f.player==1"  ]
[jump  storage="sisigami.ks"  target="*doubt"  cond="f.player==2"  ]
[jump  storage="murasame.ks"  target="*doubt"  cond="f.player==3"  ]
[jump  storage="kano.ks"  target="*doubt"  cond="f.player==4"  ]
[jump  storage="tendo.ks"  target="*doubt"  cond="f.player==5"  ]
[jump  storage="shigure.ks"  target="*doubt"  cond="f.player==6"  ]
[jump  storage="yamabuki.ks"  target="*doubt"  cond="f.player==7"  ]
[jump  storage="gato.ks"  target="*doubt"  cond="f.player==8"  ]
[jump  storage="urushibara.ks"  target="*doubt"  cond="f.player==9"  ]
*cover

[call  storage="system.ks"  target="*action"  ]
[jump  storage="mafutsu.ks"  target="*cover"  cond="f.player==1"  ]
[jump  storage="sisigami.ks"  target="*cover"  cond="f.player==2"  ]
[jump  storage="murasame.ks"  target="*cover"  cond="f.player==3"  ]
[jump  storage="kano.ks"  target="*cover"  cond="f.player==4"  ]
[jump  storage="tendo.ks"  target="*cover"  cond="f.player==5"  ]
[jump  storage="shigure.ks"  target="*cover"  cond="f.player==6"  ]
[jump  storage="yamabuki.ks"  target="*cover"  cond="f.player==7"  ]
[jump  storage="gato.ks"  target="*cover"  cond="f.player==8"  ]
[jump  storage="urushibara.ks"  target="*cover"  cond="f.player==9"  ]
*watch

[call  storage="system.ks"  target="*quiet"  ]
[jump  storage="AI.ks"  target="*randam_ai"  ]
*push

[call  storage="system.ks"  target="*action"  ]
[tb_eval  exp="f.win='push'"  name="win"  cmd="="  op="t"  val="push"  val_2="undefined"  ]
[jump  storage="doubt.ks"  target="*doubt"  ]
*plz_CO

[call  storage="system.ks"  target="*action"  ]
[tb_eval  exp="f.ai_actor=f.player"  name="ai_actor"  cmd="="  op="h"  val="player"  val_2="undefined"  ]
[jump  storage="CO.ks"  target="*please_CO"  ]
*CO

[call  storage="system.ks"  target="*action"  ]
[tb_eval  exp="f.ai_actor=f.player"  name="ai_actor"  cmd="="  op="h"  val="player"  val_2="undefined"  ]
[iscript]
var role=parseInt(f.role);
if(role===10)f.result=1;
else if(role===11)f.result=2;
[endscript]

[jump  storage="CO.ks"  target="*player_CO"  ]
*fake_CO

[call  storage="system.ks"  target="*action"  ]
[tb_eval  exp="f.ai_actor=f.player"  name="ai_actor"  cmd="="  op="h"  val="player"  val_2="undefined"  ]
[tb_eval  exp="f.role2='fco'"  name="role2"  cmd="="  op="t"  val="fco"  val_2="undefined"  ]
[jump  storage="CO.ks"  target="*9mode_choice"  ]
*say_human

[call  storage="system.ks"  target="*action"  ]
[tb_eval  exp="f.ai_actor=f.player"  name="ai_actor"  cmd="="  op="h"  val="player"  val_2="undefined"  ]
[jump  storage="say_human.ks"  target="*say_human"  ]
*auto

[glink  color="btn_08_lime"  storage="AI.ks"  size="20"  text="様子を見る"  x="100"  y="200"  width="150"  height=""  _clickable_img=""  target="*randam_ai"  ]
[s  ]
*check

[iscript]
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var aliveNames=[];
for(var i=0;i<n;i++){
if(aliveArr[i]==="1")aliveNames.push(names[i+1]);
}
f.result=aliveNames.join("、");
[endscript]

[iscript]
var charNames=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var resultNames=["人間","人狼"];
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
var slots=["","","","","","","","",""];
// 占い報告：day日目 → スロット(2*day-1)（1日目→01、2日目→03、3日目→05…）
// day=0（ゲーム開始時のランダム占い）は1日目と同じスロット01に集約表示する
var sclaims=getSclaim();
for(var i=0;i<sclaims.length;i++){
var day=sclaims[i][0],reporter=sclaims[i][1],target=sclaims[i][2],result=sclaims[i][3];
var slot=(day===0)?1:2*day-1;
if(slot>=1&&slot<=9){
slots[slot-1]+=charNames[reporter]+" → "+charNames[target]+"："+resultNames[result]+"、";
}
}
// 霊媒報告：day日目 → スロット(2*day-2)（2日目→02、3日目→04、4日目→06、5日目→08）
var pclaims=getPclaim();
for(var j=0;j<pclaims.length;j++){
var pday=pclaims[j][0],preporter=pclaims[j][1],ptarget=pclaims[j][2],presult=pclaims[j][3];
var pslot=2*pday-2;
if(pslot>=1&&pslot<=9){
slots[pslot-1]+=charNames[preporter]+" → "+charNames[ptarget]+"："+resultNames[presult]+"、";
}
}
f.display01=slots[0];
f.display02=slots[1];
f.display03=slots[2];
f.display04=slots[3];
f.display05=slots[4];
f.display06=slots[5];
f.display07=slots[6];
f.display08=slots[7];
f.display09=slots[8];
[endscript]

[tb_start_text mode=1 ]
#システム
残りの生存者は[emb exp="f.result"]です。[p]


[_tb_end_text]

[iscript]
var coArr2=String(f.co).split(",");
f.result=coArr2.some(function(v){return v!=="0";})?0:1;
[endscript]

[jump  storage="debate.ks"  target="*0CO"  cond="f.result==1"  ]
[tb_start_text mode=1 ]
占い師・霊媒師の報告は[emb exp="f.display01"][emb exp="f.display02"][emb exp="f.display03"][emb exp="f.display04"][emb exp="f.display05"][emb exp="f.display06"][emb exp="f.display07"][emb exp="f.display08"][emb exp="f.display09"]です。[p]

[_tb_end_text]

*0CO

[jump  storage="tutorial.ks"  target="*text"  cond="f.tutorial==1"  ]
[call  storage="debate.ks"  target="*char_dispatch_debate01"  ]
[jump  storage="debate.ks"  target="*debate_top"  ]
*char_dispatch_debate01

[call  storage="mafutsu.ks"  target="*debate01"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*debate01"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*debate01"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*debate01"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*debate01"  cond="f.player==5"  ]
[call  storage="shigure.ks"  target="*debate01"  cond="f.player==6"  ]
[call  storage="yamabuki.ks"  target="*debate01"  cond="f.player==7"  ]
[call  storage="gato.ks"  target="*debate01"  cond="f.player==8"  ]
[call  storage="urushibara.ks"  target="*debate01"  cond="f.player==9"  ]
[return  ]
*CO_judge

[tb_eval  exp="f.display01+=1"  name="display01"  cmd="+="  op="t"  val="1"  val_2="undefined"  ]
[iscript]
function getCO(c){return parseInt(String(f.co).split(',')[c-1]);}
var gm = parseInt(f.gamemode);
var coArr = String(f.co).split(',');
var has1 = coArr.indexOf('1') !== -1;
var has2 = coArr.indexOf('2') !== -1;
var role = parseInt(f.role);
var d1 = parseInt(f.display01);
if(d1 === 1){
var cond = (gm === 5 && has1) || (gm === 9 && has1 && has2);
f.display02 = cond ? 1 : 0;
}else if(d1 === 2){
if(role === 10 && has1){
f.display02 = 1;
}else if(role === 11 && has2){
f.display02 = 1;
}else if(role !== 10 && role !== 11){
f.display02 = 1;
}else{
f.display02 = 0;
}
}else if(d1 === 3){
var condA = (gm === 5 && has1) || (gm === 9 && has1 && has2);
var condB = getCO(parseInt(f.player)) !== 0;
f.display02 = (condA || condB) ? 1 : 0;
}
[endscript]

[return  ]
