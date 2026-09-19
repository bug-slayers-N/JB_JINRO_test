[_tb_system_call storage=system/_UI.ks]

*myrole

[tb_ptext_hide  time="0"  ]
[tb_ptext_show  x="1130"  y="400"  size="30"  color="0xff0000"  time="0"  text="&f.turn;"  anim="false"  face="undefined"  edge="undefined"  shadow="undefined"  ]
[tb_image_show  time="100"  storage="default/UI_right_turn_260429kari_1.png"  width="150"  height="300"  x="1097"  y="179"  _clickable_img=""  name="img_3"  ]
[tb_ptext_show  x="1145"  y="320"  size="30"  color="0xff0000"  time="0"  text="&f.day;"  anim="false"  face="undefined"  edge="undefined"  shadow="undefined"  ]
[jump  storage="UI.ks"  target="*jinro"  cond="f.role>5"  ]
[tb_ptext_show  x="1140"  y="240"  size="30"  color="0xa85714"  time="100"  text="人狼"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*jinro

[jump  storage="UI.ks"  target="*seer"  cond="f.role!=10"  ]
[tb_ptext_show  x="1120"  y="240"  size="30"  color="0x6956e8"  time="100"  text="占い師"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*seer

[jump  storage="UI.ks"  target="*psychic"  cond="f.role!=11"  ]
[tb_ptext_show  x="1120"  y="240"  size="30"  color="0x7e34ed"  time="100"  text="霊媒師"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*psychic

[jump  storage="UI.ks"  target="*knight"  cond="f.role!=12"  ]
[tb_ptext_show  x="1140"  y="240"  size="30"  color="0x00e6b8"  time="100"  text="騎士"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*knight

[jump  storage="UI.ks"  target="*lunatic"  cond="f.role!=9"  ]
[tb_ptext_show  x="1140"  y="240"  size="30"  color="0xe84141"  time="100"  text="狂人"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*lunatic

[jump  storage="UI.ks"  target="*human"  cond="f.role<15"  ]
[tb_ptext_show  x="1140"  y="240"  size="30"  color="0x48c737"  time="100"  text="村人"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*human

[return  ]
*name_change

[iscript]
var names = ["", "真経津", "獅子神", "村雨", "叶", "天堂", "時雨", "山吹", "牙頭", "漆原"];
f.name = names[f.target];
[endscript]

[return  ]
*list_ma

[tb_eval  exp="f.target=1"  name="target"  cmd="="  op="t"  val="1"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_si

[tb_eval  exp="f.target=2"  name="target"  cmd="="  op="t"  val="2"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_mu

[tb_eval  exp="f.target=3"  name="target"  cmd="="  op="t"  val="3"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_ka

[tb_eval  exp="f.target=4"  name="target"  cmd="="  op="t"  val="4"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_te

[tb_eval  exp="f.target=5"  name="target"  cmd="="  op="t"  val="5"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_shigure

[tb_eval  exp="f.target=6"  name="target"  cmd="="  op="t"  val="6"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_yamabuki

[tb_eval  exp="f.target=7"  name="target"  cmd="="  op="t"  val="7"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_gato

[tb_eval  exp="f.target=8"  name="target"  cmd="="  op="t"  val="8"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_urushibara

[tb_eval  exp="f.target=9"  name="target"  cmd="="  op="t"  val="9"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_judge

[tb_eval  exp="f.display05+=1"  name="display05"  cmd="+="  op="t"  val="1"  ]
[iscript]
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
var c = parseInt(f.display05);
var hide = (!isAlive(c) || c === parseInt(f.player));
if(!hide && f.jump==='wolf'){
// 人狼の襲撃対象選択時のみ、仲間の人狼（役職番号5以下）を選択肢から除外する
var role = parseInt(String(f.character).split(',')[c-1]);
if(role <= 5) hide = true;
}
f.display06 = hide ? 1 : 0;
[endscript]

[return  ]
*listA

[tb_eval  exp="f.list='A'"  name="list"  cmd="="  op="t"  val="A"  val_2="undefined"  ]
[tb_eval  exp="f.display05=0"  name="display05"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listA_9"  cond="f.gamemode==9"  ]
[jump  storage="UI.ks"  target="*listA_5"  ]
*listA_9

[tb_eval  exp="f.display04=50"  name="display04"  cmd="="  op="t"  val="50"  val_2="undefined"  ]
[tb_eval  exp="f.display08=50"  name="display08"  cmd="="  op="t"  val="50"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_1_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="真経津"  x="300"  y="&f.display04"  target="*list_ma"  ]
[tb_eval  exp="f.display04+=100"  name="display04"  cmd="+="  op="t"  val="100"  ]
*A9_1_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_2_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="獅子神"  x="800"  y="&f.display08"  target="*list_si"  ]
[tb_eval  exp="f.display08+=100"  name="display08"  cmd="+="  op="t"  val="100"  ]
*A9_2_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_3_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="村雨"  x="300"  y="&f.display04"  target="*list_mu"  ]
[tb_eval  exp="f.display04+=100"  name="display04"  cmd="+="  op="t"  val="100"  ]
*A9_3_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_4_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="叶"  x="800"  y="&f.display08"  target="*list_ka"  ]
[tb_eval  exp="f.display08+=100"  name="display08"  cmd="+="  op="t"  val="100"  ]
*A9_4_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_5_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="天堂"  x="300"  y="&f.display04"  target="*list_te"  ]
[tb_eval  exp="f.display04+=100"  name="display04"  cmd="+="  op="t"  val="100"  ]
*A9_5_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_6_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="時雨"  x="800"  y="&f.display08"  target="*list_shigure"  ]
[tb_eval  exp="f.display08+=100"  name="display08"  cmd="+="  op="t"  val="100"  ]
*A9_6_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_7_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="山吹"  x="300"  y="&f.display04"  target="*list_yamabuki"  ]
[tb_eval  exp="f.display04+=100"  name="display04"  cmd="+="  op="t"  val="100"  ]
*A9_7_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_8_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="牙頭"  x="800"  y="&f.display08"  target="*list_gato"  ]
[tb_eval  exp="f.display08+=100"  name="display08"  cmd="+="  op="t"  val="100"  ]
*A9_8_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_9_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="漆原"  x="300"  y="&f.display04"  target="*list_urushibara"  ]
[tb_eval  exp="f.display04+=100"  name="display04"  cmd="+="  op="t"  val="100"  ]
*A9_9_skip

[call  storage="UI.ks"  target="*back"  ]
*A9_end

[s  ]
*listA_5

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A5_1_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="真経津"  autopos="true"  target="*list_ma"  ]
*A5_1_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A5_2_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="獅子神"  autopos="true"  target="*list_si"  ]
*A5_2_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A5_3_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="村雨"  autopos="true"  target="*list_mu"  ]
*A5_3_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A5_4_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="叶"  autopos="true"  target="*list_ka"  ]
*A5_4_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A5_5_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="天堂"  autopos="true"  target="*list_te"  ]
*A5_5_skip

[call  storage="UI.ks"  target="*back"  ]
*A5_end

[s  ]
*listB

[tb_eval  exp="f.list='B'"  name="list"  cmd="="  op="t"  val="B"  val_2="undefined"  ]
[tb_hide_message_window  ]
[tb_ptext_hide  time="0"  ]
[tb_image_hide  time="0"  ]
[jump  storage="UI.ks"  target="*9mode_pic"  cond="f.gamemode==9"  ]
*5mode_pic

[bg  time="1000"  method="crossfade"  storage="BG_selectChara_noText_260429kari.png"  ]
[jump  storage="UI.ks"  target="*listB_5"  ]
*9mode_pic

[bg  time="1000"  method="crossfade"  storage="BG_selectChara_9chara_noText.png"  ]
[jump  storage="UI.ks"  target="*listB_9"  ]
*listB_9

[tb_eval  exp="f.display05=0"  name="display05"  cmd="="  op="t"  val="0"  ]
[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_1_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_red"  storage="UI.ks"  size="20"  text="真経津晨にする"  x="72"  y="302"  target="*list_ma"  ]
*B9_1_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_2_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_yellow"  storage="UI.ks"  size="20"  text="獅子神敬一にする"  x="310"  y="302"  target="*list_si"  ]
*B9_2_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_3_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_blue"  storage="UI.ks"  size="20"  text="村雨礼二にする"  x="567"  y="302"  target="*list_mu"  ]
*B9_3_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_4_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_purple"  storage="UI.ks"  size="20"  text="叶黎明にする"  x="817"  y="302"  target="*list_ka"  ]
*B9_4_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_5_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_black"  storage="UI.ks"  size="20"  text="天堂弓彦にする"  x="1050"  y="302"  target="*list_te"  ]
*B9_5_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_6_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_green"  storage="UI.ks"  size="20"  text="時雨賢人にする"  x="72"  y="635"  target="*list_shigure"  ]
*B9_6_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_7_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_yellow"  storage="UI.ks"  size="20"  text="山吹千春にする"  x="310"  y="635"  target="*list_yamabuki"  ]
*B9_7_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_8_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_red"  storage="UI.ks"  size="20"  text="牙頭猛晴にする"  x="817"  y="635"  target="*list_gato"  ]
*B9_8_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_9_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_black"  storage="UI.ks"  size="20"  text="漆原伊月にする"  x="1050"  y="635"  target="*list_urushibara"  ]
*B9_9_skip

[glink  color="btn_01_red"  storage="UI.ks"  size="20"  text="状況確認"  x="590"  y="550"  target="*list_check"  width=""  height=""  _clickable_img=""  ]
[s  ]
*listB_5

[tb_eval  exp="f.display05=0"  name="display05"  cmd="="  op="t"  val="0"  ]
[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B5_1_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_red"  storage="UI.ks"  size="20"  text="真経津晨にする"  x="50"  y="500"  target="*list_ma"  ]
*B5_1_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B5_2_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_yellow"  storage="UI.ks"  size="20"  text="獅子神敬一にする"  x="305"  y="500"  target="*list_si"  ]
*B5_2_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B5_3_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_blue"  storage="UI.ks"  size="20"  text="村雨礼二にする"  x="550"  y="500"  target="*list_mu"  ]
*B5_3_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B5_4_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_purple"  storage="UI.ks"  size="20"  text="叶黎明にする"  x="810"  y="500"  target="*list_ka"  ]
*B5_4_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B5_5_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_black"  storage="UI.ks"  size="20"  text="天堂弓彦にする"  x="1050"  y="500"  target="*list_te"  ]
*B5_5_skip

[glink  color="btn_01_red"  storage="UI.ks"  size="20"  text="・状況確認・"  x="561"  y="587"  target="*list_check"  width=""  height=""  _clickable_img=""  ]
[s  ]
*list_check

[iscript]
var charNames=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var resultNames=["人間","人狼"];
// kindは"s"(占い師/sclaim)または"p"(霊媒師/pclaim)。1種別分のテキストを丸ごと組み立てる
// UI.ksの状況確認は当日(f.day)分の申告は表示しない
function buildClaimText(kind){
var raw=(kind==="s")?String(f.sclaim):String(f.pclaim);
var label=(kind==="s")?"占い師":"霊媒師";
if(raw==="0")return "";
var arr=raw.split(',');
var claims=[];
for(var i=0;i<arr.length;i+=4){claims.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
var today=parseInt(f.day);
// 報告者ごとにまとめる：[[day,target,result],...]（当日分は除外）
var byReporter={};
for(var j=0;j<claims.length;j++){
var day=claims[j][0],reporter=claims[j][1],target=claims[j][2],result=claims[j][3];
if(day===today)continue;
if(!byReporter[reporter])byReporter[reporter]=[];
byReporter[reporter].push([day,target,result]);
}
// 報告者はキャラ番号順、各報告者内の対象はday順に整列
var reporters=Object.keys(byReporter).map(Number).sort(function(a,b){return a-b;});
if(reporters.length===0)return "";
var blocks=[];
for(var r=0;r<reporters.length;r++){
var reporter=reporters[r];
var rclaims=byReporter[reporter].slice().sort(function(a,b){return a[0]-b[0];});
var parts=[];
for(var k=0;k<rclaims.length;k++){
var tgt=rclaims[k][1],res=rclaims[k][2];
if(tgt===9&&res===9){
parts.push("対象者無し");
}else{
parts.push(charNames[tgt]+"："+resultNames[res]);
}
}
blocks.push(charNames[reporter]+"→"+parts.join("、")+"、");
}
return label+"の結果報告は次の通りです。"+blocks.join("");
}
f.display02=buildClaimText("s");
f.display03=buildClaimText("p");
f.result=(f.display02!==""||f.display03!=="")?1:0;
[endscript]

[tb_show_message_window  ]
[jump  storage="UI.ks"  target="*check_report_skip"  cond="f.result==0"  ]

[emb exp="f.display02"]
[jump  storage="UI.ks"  target="*check_claim_join_skip"  cond="f.display02==''||f.display03==''"  ]
[r]
*check_claim_join_skip

[emb exp="f.display03"][p]


[r]

[jump  storage="UI.ks"  target="*check_body_end"  ]
*check_report_skip


現在、公開されている報告はありません。[p]


[r]

*check_body_end

[p]

[tb_hide_message_window  ]
[jump  storage="UI.ks"  target="*listB_9"  cond="f.gamemode==9"  ]
[jump  storage="UI.ks"  target="*listB_5"  ]
*back

[glink  color="black"  storage="UI.ks"  size="20"  text="戻る"  target="*back_top"  ]
[return  ]
*jump

[jump  storage="CO.ks"  target="*CO_back"  cond="f.jump=='CO'"  ]
[jump  storage="specialist.ks"  target="*seer_back"  cond="f.jump=='seer'"  ]
[jump  storage="specialist.ks"  target="*fakeseer_back"  cond="f.jump=='fakeseer'"  ]
[jump  storage="doubt.ks"  target="*list_back"  cond="f.jump=='doubt'"  ]
[jump  storage="cover.ks"  target="*list_back"  cond="f.jump=='cover'"  ]
[jump  storage="vote.ks"  target="*player_vote_back"  cond="f.jump=='vote'"  ]
[jump  storage="night.ks"  target="*knight_back"  cond="f.jump=='knight'"  ]
[jump  storage="night.ks"  target="*wolf_end"  cond="f.jump=='wolf'"  ]
*back_top

[tb_eval  exp="f.action-=1"  name="action"  cmd="-="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="debate.ks"  target="*debate_top"  ]
