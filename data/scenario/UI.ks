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
*listA

[tb_eval  exp="f.list='A'"  name="list"  cmd="="  op="t"  val="A"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*list"  ]
*listB

[tb_eval  exp="f.list='B'"  name="list"  cmd="="  op="t"  val="B"  val_2="undefined"  ]
[tb_hide_message_window  ]
[tb_ptext_hide  time="0"  ]
[tb_image_hide  time="0"  ]
[jump  storage="UI.ks"  target="*vote"  cond="f.jump=='vote'"  ]
[jump  storage="UI.ks"  target="*vote"  cond="f.jump=='wolf'"  ]
[jump  storage="UI.ks"  target="*9mode_pic"  cond="f.gamemode==9"  ]
*5mode_pic

[bg  time="1000"  method="crossfade"  storage="BG_selectChara_noText_260429kari.png"  ]
[jump  storage="UI.ks"  target="*list"  ]
*9mode_pic

[bg  time="1000"  method="crossfade"  storage="9mode.png"  ]
*list

[tb_eval  exp="f.target=1"  name="target"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*ma_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*ma_B"  cond="f.list=='B'"  ]
*ma_B_jump

[tb_eval  exp="f.target=2"  name="target"  cmd="="  op="t"  val="2"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*si_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*si_B"  cond="f.list=='B'"  ]
*si_B_jump

[tb_eval  exp="f.target=3"  name="target"  cmd="="  op="t"  val="3"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*mu_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*mu_B"  cond="f.list=='B'"  ]
*mu_B_jump

[tb_eval  exp="f.target=4"  name="target"  cmd="="  op="t"  val="4"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*ka_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*ka_B"  cond="f.list=='B'"  ]
*ka_B_jump

[tb_eval  exp="f.target=5"  name="target"  cmd="="  op="t"  val="5"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*te_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*te_B"  cond="f.list=='B'"  ]
*te_B_jump

[jump  storage="UI.ks"  target="*list_end"  cond="f.gamemode!=9"  ]
[tb_eval  exp="f.target=6"  name="target"  cmd="="  op="t"  val="6"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*shigure_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*shigure_B"  cond="f.list=='B'"  ]
*shigure_B_jump

[tb_eval  exp="f.target=7"  name="target"  cmd="="  op="t"  val="7"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*yamabuki_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*yamabuki_B"  cond="f.list=='B'"  ]
*yamabuki_B_jump

[tb_eval  exp="f.target=8"  name="target"  cmd="="  op="t"  val="8"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*gato_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*gato_B"  cond="f.list=='B'"  ]
*gato_B_jump

[tb_eval  exp="f.target=9"  name="target"  cmd="="  op="t"  val="9"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*urushibara_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*urushibara_B"  cond="f.list=='B'"  ]
*urushibara_B_jump

*list_end

[jump  storage="UI.ks"  target="*back2"  cond="f.jump=='uranai'"  ]
[jump  storage="UI.ks"  target="*back2"  cond="f.jump=='CO'"  ]
[call  storage="UI.ks"  target="*back"  cond="f.list=='A'"  ]
*back2

[s  ]
*listB_check

[iscript]
var t=parseInt(f.target);
var aliveArr=String(f.alive).split(",");
f.result=(parseInt(f.player)===t||aliveArr[t-1]==="0")?1:0;
[endscript]

[jump  storage="UI.ks"  target="*listB_jump"  cond="f.result==1"  ]
[return  ]
*listB_jump

[jump  storage="UI.ks"  target="*ma_B_jump"  cond="f.target==1"  ]
[jump  storage="UI.ks"  target="*si_B_jump"  cond="f.target==2"  ]
[jump  storage="UI.ks"  target="*mu_B_jump"  cond="f.target==3"  ]
[jump  storage="UI.ks"  target="*ka_B_jump"  cond="f.target==4"  ]
[jump  storage="UI.ks"  target="*te_B_jump"  cond="f.target==5"  ]
[jump  storage="UI.ks"  target="*shigure_B_jump"  cond="f.target==6"  ]
[jump  storage="UI.ks"  target="*yamabuki_B_jump"  cond="f.target==7"  ]
[jump  storage="UI.ks"  target="*gato_B_jump"  cond="f.target==8"  ]
[jump  storage="UI.ks"  target="*urushibara_B_jump"  cond="f.target==9"  ]
*ma_A

[glink  color="black"  storage="UI.ks"  size="20"  text="真経津"  autopos="true"  target="*list_ma"  ]
[return  ]
*ma_B

[jump  storage="UI.ks"  target="*ma_B_9"  cond="f.gamemode==9"  ]
[glink  color="btn_06_red"  storage="UI.ks"  size="20"  text="真経津晨にする"  x="50"  y="500"  width=""  height=""  _clickable_img=""  target="*list_ma"  ]
[jump  storage="UI.ks"  target="*ma_B_end"  ]
*ma_B_9

[glink  color="btn_06_red"  storage="UI.ks"  size="20"  text="真経津晨にする"  x="72"  y="297"  width=""  height=""  _clickable_img=""  target="*list_ma"  ]
*ma_B_end

[return  ]
*si_A

[glink  color="black"  storage="UI.ks"  size="20"  text="獅子神"  autopos="true"  target="*list_si"  ]
[return  ]
*si_B

[jump  storage="UI.ks"  target="*si_B_9"  cond="f.gamemode==9"  ]
[glink  color="btn_06_yellow"  storage="UI.ks"  size="20"  text="獅子神敬一にする"  x="305"  y="500"  width=""  height=""  _clickable_img=""  target="*list_si"  ]
[jump  storage="UI.ks"  target="*si_B_end"  ]
*si_B_9

[glink  color="btn_06_yellow"  storage="UI.ks"  size="20"  text="獅子神敬一にする"  x="315"  y="289"  width=""  height=""  _clickable_img=""  target="*list_si"  ]
*si_B_end

[return  ]
*mu_A

[glink  color="black"  storage="UI.ks"  size="20"  text="村雨"  autopos="true"  target="*list_mu"  ]
[return  ]
*mu_B

[jump  storage="UI.ks"  target="*mu_B_9"  cond="f.gamemode==9"  ]
[glink  color="btn_06_blue"  storage="UI.ks"  size="20"  text="村雨礼二にする"  x="550"  y="500"  width=""  height=""  _clickable_img=""  target="*list_mu"  ]
[jump  storage="UI.ks"  target="*mu_B_end"  ]
*mu_B_9

[glink  color="btn_06_blue"  storage="UI.ks"  size="20"  text="村雨礼二にする"  x="573"  y="291"  width=""  height=""  _clickable_img=""  target="*list_mu"  ]
*mu_B_end

[return  ]
*ka_A

[glink  color="black"  storage="UI.ks"  size="20"  text="叶"  autopos="true"  target="*list_ka"  ]
[return  ]
*ka_B

[jump  storage="UI.ks"  target="*ka_B_9"  cond="f.gamemode==9"  ]
[glink  color="btn_06_purple"  storage="UI.ks"  size="20"  text="叶黎明にする"  x="810"  y="500"  width=""  height=""  _clickable_img=""  target="*list_ka"  ]
[jump  storage="UI.ks"  target="*ka_B_end"  ]
*ka_B_9

[glink  color="btn_06_purple"  storage="UI.ks"  size="20"  text="叶黎明にする"  x="825"  y="286"  width=""  height=""  _clickable_img=""  target="*list_ka"  ]
*ka_B_end

[return  ]
*te_A

[glink  color="black"  storage="UI.ks"  size="20"  text="天堂"  autopos="true"  target="*list_te"  ]
[return  ]
*te_B

[jump  storage="UI.ks"  target="*te_B_9"  cond="f.gamemode==9"  ]
[glink  color="btn_06_black"  storage="UI.ks"  size="20"  text="天堂弓彦にする"  x="1050"  y="500"  width=""  height=""  _clickable_img=""  target="*list_te"  ]
[jump  storage="UI.ks"  target="*te_B_end"  ]
*te_B_9

[glink  color="btn_06_black"  storage="UI.ks"  size="20"  text="天堂弓彦にする"  x="1062"  y="283"  width=""  height=""  _clickable_img=""  target="*list_te"  ]
*te_B_end

[return  ]
*shigure_A

[glink  color="black"  storage="UI.ks"  size="20"  text="時雨"  autopos="true"  target="*list_shigure"  ]
[return  ]
*shigure_B

[glink  color="btn_06_green"  storage="UI.ks"  size="20"  text="時雨賢人にする"  x="199"  y="600"  width=""  height=""  _clickable_img=""  target="*list_shigure"  ]
[return  ]
*yamabuki_A

[glink  color="black"  storage="UI.ks"  size="20"  text="山吹"  autopos="true"  target="*list_yamabuki"  ]
[return  ]
*yamabuki_B

[glink  color="btn_06_yellow"  storage="UI.ks"  size="20"  text="山吹千春にする"  x="440"  y="595"  width=""  height=""  _clickable_img=""  target="*list_yamabuki"  ]
[return  ]
*gato_A

[glink  color="black"  storage="UI.ks"  size="20"  text="牙頭"  autopos="true"  target="*list_gato"  ]
[return  ]
*gato_B

[glink  color="btn_06_red"  storage="UI.ks"  size="20"  text="牙頭猛晴にする"  x="691"  y="591"  width=""  height=""  _clickable_img=""  target="*list_gato"  ]
[return  ]
*urushibara_A

[glink  color="black"  storage="UI.ks"  size="20"  text="漆原"  autopos="true"  target="*list_urushibara"  ]
[return  ]
*urushibara_B

[glink  color="btn_06_black"  storage="UI.ks"  size="20"  text="漆原伊月にする"  x="944"  y="589"  width=""  height=""  _clickable_img=""  target="*list_urushibara"  ]
[return  ]
*back

[glink  color="black"  storage="UI.ks"  size="20"  text="戻る"  target="*back_top"  ]
[return  ]
*jump

[jump  storage="CO.ks"  target="*CO_back"  cond="f.jump=='CO'"  ]
[jump  storage="doubt.ks"  target="*list_back"  cond="f.jump=='doubt'"  ]
[jump  storage="cover.ks"  target="*list_back"  cond="f.jump=='cover'"  ]
[jump  storage="vote.ks"  target="*player_vote_back"  cond="f.jump=='vote'"  ]
[jump  storage="uranai.ks"  target="*uranai_back"  cond="f.jump=='uranai'"  ]
[jump  storage="night.ks"  target="*wolf_end"  cond="f.jump=='wolf'"  ]
*back_top

[tb_eval  exp="f.action-=1"  name="action"  cmd="-="  op="t"  val="1"  val_2="undefined"  ]
[tb_eval  exp="f.jump=0"  name="jump"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_eval  exp="f.win=0"  name="win"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="debate.ks"  target="*debate_top"  ]
*vote

[bg  time="1000"  method="crossfade"  storage="BG_selectChara_noText.png"  ]
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
var disps=[];
var sclaims=getSclaim();
for(var i=0;i<sclaims.length;i++){
var reporter=sclaims[i][1],target=sclaims[i][2],result=sclaims[i][3];
disps.push(charNames[reporter]+" → "+charNames[target]+"："+resultNames[result]+"、");
}
var pdisps=[];
var pclaims=getPclaim();
for(var j=0;j<pclaims.length;j++){
var preporter=pclaims[j][1],ptarget=pclaims[j][2],presult=pclaims[j][3];
pdisps.push(charNames[preporter]+" → "+charNames[ptarget]+"："+resultNames[presult]+"、");
}
f.result="占い報告："+disps.join("")+(pdisps.length>0?"　霊媒報告："+pdisps.join(""):"");
[endscript]

[tb_ptext_show  x="43"  y="35"  size="20"  color="0x000000"  time="0"  text="&f.result;"  anim="false"  face="fantasy"  edge="undefined"  shadow="undefined"  ]
[jump  storage="UI.ks"  target="*list"  ]
