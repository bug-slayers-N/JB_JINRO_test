[_tb_system_call storage=system/_role.ks]

[cm  ]
[call  storage="system.ks"  target="*init"  ]
[bg  time="1000"  method="crossfade"  storage="92690259_p0.png"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#システム
遊ぶ人数を選んでください(現在は13人モードは選べません)。[p]
[_tb_end_text]

*member

[iscript]
f.Ezmode=0;
[endscript]

[glink  color="btn_05_green"  storage="role.ks"  size="20"  text="5人で遊ぶ(人狼1人)"  target="*5mode_select"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[glink  color="btn_05_yellow"  storage="role.ks"  size="20"  text="9人で遊ぶ(人狼2人)"  target="*9mode_select"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[glink  color="btn_05_blue"  storage="role.ks"  size="20"  text="9人で遊ぶ(簡単モード)"  target="*9mode_easy_select"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[glink  color="btn_05_purple"  storage="role.ks"  size="20"  text="13人で遊ぶ(人狼3人)"  target="*13mode_select"  x="99"  y="192"  width=""  height=""  _clickable_img=""  autopos="true"  ]
[s  ]
*13mode_select

[tb_start_text mode=1 ]
#システム
他のギャンブラーの実装をお待ちください。(次回実装予定→雛形＋真鍋＋三角＋室積)[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*member"  ]
*5mode_select

[tb_eval  exp="f.gamemode=5"  name="gamemode"  cmd="="  op="t"  val="5"  val_2="undefined"  ]
[call  storage="system.ks"  target="*5mode_init"  ]
[tb_start_text mode=1 ]
#システム
5人モードを選択しました。選択可能キャラは真経津、獅子神、村雨、叶、天堂です。[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*5mode_pick"  ]
*9mode_easy_select

[tb_eval  exp="f.gamemode=9"  name="gamemode"  cmd="="  op="t"  val="9"  val_2="undefined"  ]
[tb_eval  exp="f.Ezmode=5"  name="Ezmode"  cmd="="  op="t"  val="5"  val_2="undefined"  ]
[call  storage="system.ks"  target="*9mode_init"  ]
[tb_start_text mode=1 ]
#システム
9人モード(簡単)を選択しました。人狼陣営時は被ダメが下がり、村人陣営時は全体の被ダメが上昇します。また、うるさい機能もなくなります。[p]
選択可能キャラは真経津、獅子神、村雨、叶、天堂、時雨、山吹、牙頭、漆原です。[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*9mode_pick"  ]
*9mode_select

[tb_eval  exp="f.gamemode=9"  name="gamemode"  cmd="="  op="t"  val="9"  val_2="undefined"  ]
[call  storage="system.ks"  target="*9mode_init"  ]
[tb_start_text mode=1 ]
#システム
9人モードを選択しました。選択可能キャラは真経津、獅子神、村雨、叶、天堂、時雨、山吹、牙頭、漆原です。[p]
[_tb_end_text]

*character_pick

[jump  storage="role.ks"  target="*9mode_pick"  cond="f.gamemode==9"  ]
*5mode_pick

[tb_hide_message_window  ]
[bg  time="1000"  method="crossfade"  storage="BG_selectChara.png"  ]
[jump  storage="role.ks"  target="*5mode_pick_list"  ]
*9mode_pick

[tb_hide_message_window  ]
[bg  time="1000"  method="crossfade"  storage="BG_selectChara_9chara.png"  ]
[jump  storage="role.ks"  target="*9mode_pick_list"  ]
*5mode_pick_list

[glink  color="btn_06_red"  storage="role.ks"  size="20"  text="真経津晨にする"  x="50"  y="550"  width=""  height=""  _clickable_img=""  target="*mafutsu"  ]
[glink  color="btn_06_yellow"  storage="role.ks"  size="20"  text="獅子神敬一にする"  x="310"  y="550"  width=""  height=""  _clickable_img=""  target="*sisigami"  ]
[glink  color="btn_06_blue"  storage="role.ks"  size="20"  text="村雨礼二にする"  x="550"  y="550"  width=""  height=""  _clickable_img=""  target="*murasame"  ]
[glink  color="btn_06_purple"  storage="role.ks"  size="20"  text="叶黎明にする"  x="810"  y="550"  width=""  height=""  _clickable_img=""  target="*kano"  ]
[glink  color="btn_06_black"  storage="role.ks"  size="20"  text="天堂弓彦にする"  x="1050"  y="550"  width=""  height=""  _clickable_img=""  target="*tendo"  ]
[jump  storage="role.ks"  target="*picklist_end"  ]
*9mode_pick_list

[glink  color="btn_06_red"  storage="role.ks"  size="20"  text="真経津晨にする"  x="72"  y="302"  width=""  height=""  _clickable_img=""  target="*mafutsu"  ]
[glink  color="btn_06_yellow"  storage="role.ks"  size="20"  text="獅子神敬一にする"  x="310"  y="302"  width=""  height=""  _clickable_img=""  target="*sisigami"  ]
[glink  color="btn_06_blue"  storage="role.ks"  size="20"  text="村雨礼二にする"  x="567"  y="302"  width=""  height=""  _clickable_img=""  target="*murasame"  ]
[glink  color="btn_06_purple"  storage="role.ks"  size="20"  text="叶黎明にする"  x="817"  y="302"  width=""  height=""  _clickable_img=""  target="*kano"  ]
[glink  color="btn_06_black"  storage="role.ks"  size="20"  text="天堂弓彦にする"  x="1050"  y="302"  width=""  height=""  _clickable_img=""  target="*tendo"  ]
[glink  color="btn_06_green"  storage="role.ks"  size="20"  text="時雨賢人にする"  x="72"  y="635"  width=""  height=""  _clickable_img=""  target="*shigure"  ]
[glink  color="btn_06_yellow"  storage="role.ks"  size="20"  text="山吹千春にする"  x="310"  y="635"  width=""  height=""  _clickable_img=""  target="*yamabuki"  ]
[glink  color="btn_06_red"  storage="role.ks"  size="20"  text="牙頭猛晴にする"  x="817"  y="635"  width=""  height=""  _clickable_img=""  target="*gato"  ]
[glink  color="btn_06_black"  storage="role.ks"  size="20"  text="漆原伊月にする"  x="1050"  y="635"  width=""  height=""  _clickable_img=""  target="*urushibara"  ]
*picklist_end

[s  ]
*mafutsu

[tb_eval  exp="f.target=1"  name="target"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[call  storage="role.ks"  target="*pick_commit"  ]
[call  storage="mafutsu.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*sisigami

[tb_eval  exp="f.target=2"  name="target"  cmd="="  op="t"  val="2"  val_2="undefined"  ]
[call  storage="role.ks"  target="*pick_commit"  ]
[call  storage="sisigami.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*murasame

[tb_eval  exp="f.target=3"  name="target"  cmd="="  op="t"  val="3"  val_2="undefined"  ]
[call  storage="role.ks"  target="*pick_commit"  ]
[call  storage="murasame.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*kano

[tb_eval  exp="f.target=4"  name="target"  cmd="="  op="t"  val="4"  val_2="undefined"  ]
[call  storage="role.ks"  target="*pick_commit"  ]
[call  storage="kano.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*tendo

[tb_eval  exp="f.target=5"  name="target"  cmd="="  op="t"  val="5"  val_2="undefined"  ]
[call  storage="role.ks"  target="*pick_commit"  ]
[call  storage="tendo.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*shigure

[tb_eval  exp="f.target=6"  name="target"  cmd="="  op="t"  val="6"  val_2="undefined"  ]
[call  storage="role.ks"  target="*pick_commit"  ]
[call  storage="shigure.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*yamabuki

[tb_eval  exp="f.target=7"  name="target"  cmd="="  op="t"  val="7"  val_2="undefined"  ]
[call  storage="role.ks"  target="*pick_commit"  ]
[call  storage="yamabuki.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*gato

[tb_eval  exp="f.target=8"  name="target"  cmd="="  op="t"  val="8"  val_2="undefined"  ]
[call  storage="role.ks"  target="*pick_commit"  ]
[call  storage="gato.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*urushibara

[tb_eval  exp="f.target=9"  name="target"  cmd="="  op="t"  val="9"  val_2="undefined"  ]
[call  storage="role.ks"  target="*pick_commit"  ]
[call  storage="urushibara.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*pick_commit

[tb_eval  exp="f.player=f.target"  name="player"  cmd="="  op="h"  val="target"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[bg  time="1000"  method="crossfade"  storage="92690259_p0.png"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#システム
[emb exp="f.name"]を選択しました。[p]
[_tb_end_text]

[return  ]
*role

[iscript]
var arr = String(f.character).split(',');
for(var i=arr.length-1;i>0;i--){
var j=Math.floor(Math.random()*(i+1));
var tmp=arr[i];arr[i]=arr[j];arr[j]=tmp;
}
f.character=arr.join(',');
f.role=parseInt(arr[f.player-1]);
[endscript]

[tb_start_text mode=1 ]
#システム
最後に、役職はどうされますか？[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*9mode_role"  cond="f.gamemode==9"  ]
*5mode_role

[glink  color="black"  storage="role.ks"  size="20"  text="ランダムで！"  autopos="true"  target="*random"  ]
[glink  color="black"  storage="role.ks"  size="20"  text="人狼で！"  target="*wolf"  autopos="true"  ]
[glink  color="black"  storage="role.ks"  size="20"  text="狂人で！"  autopos="true"  target="*lunatic"  ]
[glink  color="black"  storage="role.ks"  size="20"  text="占い師で！"  autopos="true"  target="*seer"  ]
[glink  color="black"  storage="role.ks"  size="20"  text="村人で！"  autopos="true"  target="*human"  ]
[jump  storage="role.ks"  target="*role_pick_end"  ]
*9mode_role

[glink  color="black"  storage="role.ks"  size="20"  text="人狼で！"  target="*wolf"  autopos="false"  x="404"  y="141"  width=""  height=""  _clickable_img=""  ]
[glink  color="black"  storage="role.ks"  size="20"  text="狂人で！"  autopos="false"  target="*lunatic"  x="668"  y="137"  width=""  height=""  _clickable_img=""  ]
[glink  color="black"  storage="role.ks"  size="20"  text="占い師で！"  autopos="false"  target="*seer"  x="390"  y="224"  width=""  height=""  _clickable_img=""  ]
[glink  color="black"  storage="role.ks"  size="20"  text="霊媒師で！"  autopos="false"  target="*psychic"  x="660"  y="223"  width=""  height=""  _clickable_img=""  ]
[glink  color="black"  storage="role.ks"  size="20"  text="騎士で！"  autopos="false"  target="*knight"  x="400"  y="303"  width=""  height=""  _clickable_img=""  ]
[glink  color="black"  storage="role.ks"  size="20"  text="村人で！"  autopos="false"  target="*human"  x="672"  y="302"  width=""  height=""  _clickable_img=""  ]
[glink  color="black"  storage="role.ks"  size="20"  text="ランダムで！"  autopos="false"  target="*random"  x="516"  y="383"  width=""  height=""  _clickable_img=""  ]
*role_pick_end

[s  ]
*wolf

[tb_eval  exp="f.role=1"  name="role"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*myrole"  ]
[tb_start_text mode=1 ]
#システム
あなたは《人狼》です。頑張って生き残りましょう。[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*role_setting"  ]
*seer

[tb_eval  exp="f.role=10"  name="role"  cmd="="  op="t"  val="10"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*myrole"  ]
[tb_start_text mode=1 ]
#システム
あなたは《占い師》です。頑張って人間陣営を勝たせましょう。[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*role_setting"  ]
*lunatic

[tb_eval  exp="f.role=9"  name="role"  cmd="="  op="t"  val="9"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*myrole"  ]
[tb_start_text mode=1 ]
#システム
あなたは《狂人》です。頑張って人狼を勝たせましょう。[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*role_setting"  ]
*human

[tb_eval  exp="f.role=15"  name="role"  cmd="="  op="t"  val="15"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*myrole"  ]
[tb_start_text mode=1 ]
#システム
あなたは《村人》です。頑張って人狼に勝ちましょう。[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*role_setting"  ]
*psychic

[tb_eval  exp="f.role=11"  name="role"  cmd="="  op="t"  val="11"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*myrole"  ]
[tb_start_text mode=1 ]
#システム
あなたは《霊媒師》です。頑張って人間陣営を勝たせましょう。[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*role_setting"  ]
*knight

[tb_eval  exp="f.role=12"  name="role"  cmd="="  op="t"  val="12"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*myrole"  ]
[tb_start_text mode=1 ]
#システム
あなたは《騎士》です。頑張って人間陣営を勝たせましょう。[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*role_setting"  ]
*random

[jump  storage="role.ks"  target="*wolf"  cond="f.role==1"  ]
[jump  storage="role.ks"  target="*wolf"  cond="f.role==2"  ]
[jump  storage="role.ks"  target="*lunatic"  cond="f.role==9"  ]
[jump  storage="role.ks"  target="*seer"  cond="f.role==10"  ]
[jump  storage="role.ks"  target="*psychic"  cond="f.role==11"  ]
[jump  storage="role.ks"  target="*knight"  cond="f.role==12"  ]
[jump  storage="role.ks"  target="*human"  cond=""  ]
*role_setting

[iscript]
var arr = String(f.character).split(',');
var playerIdx = f.player-1;
var oldRole = parseInt(arr[playerIdx]);
var newRole = f.role;
for(var i=0;i<arr.length;i++){
if(parseInt(arr[i])===newRole){
arr[i]=String(oldRole);
break;
}
}
arr[playerIdx]=String(newRole);
f.character=arr.join(',');
if(parseInt(f.Ezmode)===5){
f.Ezmode=(parseInt(f.role)<10)?1:2;
}
// 騎士s03未解放時、時雨/山吹プレイヤー・村人陣営・かんたんモードなら村雨/獅子神を人狼陣営から救済
if(parseInt(sf.keiji_s03)!==1&&(parseInt(f.player)===6||parseInt(f.player)===7)&&parseInt(f.role)>=10&&parseInt(f.Ezmode)===2){
var poolArr=String(f.character).split(',');
var excluded=[playerIdx,1,2];
[2,1].forEach(function(idx){
var r=parseInt(poolArr[idx]);
if(r===1||r===2||r===9){
for(var i=0;i<poolArr.length;i++){
if(excluded.indexOf(i)!==-1)continue;
var rv=parseInt(poolArr[i]);
if(rv===15||rv===16||rv===17){
poolArr[idx]=String(rv);
poolArr[i]=String(r);
break;
}
}
}
});
f.character=poolArr.join(',');
}
// amigo_s03未解放時、天堂プレイヤー・かんたんモードなら牙頭/漆原を天堂と同じ陣営へ寄せる
if(parseInt(sf.amigo_s03)!==1&&parseInt(f.player)===5&&parseInt(f.Ezmode)===2){
var poolArr2=String(f.character).split(',');
var excluded2=[playerIdx,7,8];
[8,7].forEach(function(idx){
var r=parseInt(poolArr2[idx]);
if(r===1||r===2||r===9){
for(var i=0;i<poolArr2.length;i++){
if(excluded2.indexOf(i)!==-1)continue;
var rv=parseInt(poolArr2[i]);
if(rv===15||rv===16||rv===17){
poolArr2[idx]=String(rv);
poolArr2[i]=String(r);
break;
}
}
}
});
f.character=poolArr2.join(',');
}
if(parseInt(sf.amigo_s03)!==1&&parseInt(f.player)===5&&parseInt(f.Ezmode)===1){
var poolArr3=String(f.character).split(',');
var excluded3=[playerIdx,7,8];
[8,7].forEach(function(idx){
var r=parseInt(poolArr3[idx]);
if(r===15||r===16||r===17){
for(var i=0;i<poolArr3.length;i++){
if(excluded3.indexOf(i)!==-1)continue;
var rv=parseInt(poolArr3[i]);
if(rv===1||rv===2||rv===9){
poolArr3[idx]=String(rv);
poolArr3[i]=String(r);
break;
}
}
}
});
f.character=poolArr3.join(',');
}
[endscript]

*role_end

[chara_show  name="suo"  time="1000"  wait="true"  storage="chara/6/suo_egao.png"  width="320"  height="720"  ]
[tb_start_text mode=1 ]
#周防
「素敵なご選択ですね」[p]
「それでは、あなたとギャンブラーに幸あらんことを」[p]
[_tb_end_text]

[glink  color="btn_05_red"  storage="scenario.ks"  size="20"  text="ゲーム開始"  target="*day01"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[glink  color="btn_05_yellow"  storage="scenario.ks"  size="20"  text="議論から開始"  x="112"  y="202"  width=""  height=""  _clickable_img=""  autopos="true"  target="*day01_03"  ]
[glink  color="btn_05_white"  storage="role.ks"  size="20"  text="選びなおす"  target="*change"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[s  ]
*change

[tb_image_hide  time="0"  ]
[tb_ptext_hide  time="0"  ]
[chara_hide_all  time="0"  wait="false"  ]
[jump  storage="role.ks"  target="*member"  ]
