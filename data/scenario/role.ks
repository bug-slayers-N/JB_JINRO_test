[_tb_system_call storage=system/_role.ks]

[cm  ]
[call  storage="system.ks"  target="*init"  ]
[bg  time="1000"  method="crossfade"  storage="92690259_p0.png"  ]
[call  storage="role.ks"  target="*test"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#システム
遊ぶ人数を選んでください(現在は5人モードのみ)。[p]
[_tb_end_text]

*member

[glink  color="btn_05_green"  storage="role.ks"  size="20"  text="5人で遊ぶ(人狼1人)"  target="*5"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[glink  color="btn_05_yellow"  storage="role.ks"  size="20"  text="9人で遊ぶ(人狼2人)"  target="*none"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[s  ]
*none

[tb_start_text mode=1 ]
#システム
他のギャンブラーの実装をお待ちください。(次回実装予定→牙頭＋漆原＋時雨＋山吹)[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*member"  ]
*5

[tb_eval  exp="f.member=5"  name="member"  cmd="="  op="t"  val="5"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#システム
5人モードを選択しました。選択可能キャラは真経津、獅子神、村雨、叶、天堂です。[p]
[_tb_end_text]

[tb_hide_message_window  ]
[bg  time="1000"  method="crossfade"  storage="BG_selectChara.png"  ]
[glink  color="btn_06_red"  storage="role.ks"  size="20"  text="真経津晨にする"  x="50"  y="550"  width=""  height=""  _clickable_img=""  target="*mafutsu"  ]
[glink  color="btn_06_yellow"  storage="role.ks"  size="20"  text="獅子神敬一にする"  x="310"  y="550"  width=""  height=""  _clickable_img=""  target="*sisigami"  ]
[glink  color="btn_06_blue"  storage="role.ks"  size="20"  text="村雨礼二にする"  x="550"  y="550"  width=""  height=""  _clickable_img=""  target="*murasame"  ]
[glink  color="btn_06_purple"  storage="role.ks"  size="20"  text="叶黎明にする"  x="810"  y="550"  width=""  height=""  _clickable_img=""  target="*kano"  ]
[glink  color="btn_06_black"  storage="role.ks"  size="20"  text="天堂弓彦にする"  x="1050"  y="550"  width=""  height=""  _clickable_img=""  target="*tendo"  ]
[s  ]
*choice

[bg  time="1000"  method="crossfade"  storage="92690259_p0.png"  ]
[tb_show_message_window  ]
[return  ]
*mafutsu

[call  storage="role.ks"  target="*choice"  ]
[tb_eval  exp="f.player=1"  name="player"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#システム
真経津晨を選びました。[p]
[_tb_end_text]

[call  storage="mafutsu.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*sisigami

[call  storage="role.ks"  target="*choice"  ]
[tb_eval  exp="f.player=2"  name="player"  cmd="="  op="t"  val="2"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#システム
獅子神敬一を選びました。[p]
[_tb_end_text]

[call  storage="sisigami.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*murasame

[call  storage="role.ks"  target="*choice"  ]
[tb_eval  exp="f.player=3"  name="player"  cmd="="  op="t"  val="3"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#システム
村雨礼二を選びました。[p]
[_tb_end_text]

[call  storage="murasame.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*kano

[call  storage="role.ks"  target="*choice"  ]
[tb_eval  exp="f.player=4"  name="player"  cmd="="  op="t"  val="4"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#システム
叶黎明を選びました。[p]
[_tb_end_text]

[call  storage="kano.ks"  target="*show"  ]
[jump  storage="role.ks"  target="*role"  ]
*tendo

[call  storage="role.ks"  target="*choice"  ]
[tb_eval  exp="f.player=5"  name="player"  cmd="="  op="t"  val="5"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#システム
天堂弓彦を選びました。[p]
[_tb_end_text]

[call  storage="tendo.ks"  target="*show"  ]
*role

[tb_start_tyrano_code]
; 1〜5の数字をランダムにシャッフルして変数に割り当てる（[iscript]でJavaScript実行）
[iscript]
; 配列を作成してシャッフル
var nums = [1, 2, 3, 4, 5];
nums.sort(function() { return Math.random() - 0.5; });

// 変数に割り当て（f.はフラグ変数でセーブに残る）
f.mafutsu = nums[0];
f.sisigami = nums[1];
f.murasame = nums[2];
f.kano = nums[3];
f.tendo = nums[4];

// デバッグ用ログ（ブラウザのF12→Consoleで確認）
console.log('割り当て結果: mafutsu=' + f.mafutsu + ', sisigami=' + f.sisigami + ', murasame=' + f.murasame + ', kano=' + f.kano + ', tendo=' + f.tendo);
[endscript]
[_tb_end_tyrano_code]

[call  storage="role.ks"  target="*test"  ]
[tb_start_text mode=1 ]
#システム
最後に、役職はどうされますか？[p]
[_tb_end_text]

[glink  color="black"  storage="role.ks"  size="20"  text="ランダムで！"  autopos="true"  target="*random"  ]
[glink  color="black"  storage="role.ks"  size="20"  text="人狼で！"  target="*wolf"  autopos="true"  ]
[glink  color="black"  storage="role.ks"  size="20"  text="狂人で！"  autopos="true"  target="*lunatic"  ]
[glink  color="black"  storage="role.ks"  size="20"  text="占い師で！"  autopos="true"  target="*seer"  ]
[glink  color="black"  storage="role.ks"  size="20"  text="村人で！"  autopos="true"  target="*human"  ]
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

[tb_eval  exp="f.role=3"  name="role"  cmd="="  op="t"  val="3"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*myrole"  ]
[tb_start_text mode=1 ]
#システム
あなたは《占い師》です。頑張って人間陣営を勝たせましょう。[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*role_setting"  ]
*lunatic

[tb_eval  exp="f.role=2"  name="role"  cmd="="  op="t"  val="2"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*myrole"  ]
[tb_start_text mode=1 ]
#システム
あなたは《狂人》です。頑張って人狼を勝たせましょう。[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*role_setting"  ]
*human

[tb_eval  exp="f.role=4"  name="role"  cmd="="  op="t"  val="4"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*myrole"  ]
[tb_start_text mode=1 ]
#システム
あなたは《村人》です。頑張って人狼に勝ちましょう。[p]
[_tb_end_text]

[jump  storage="role.ks"  target="*role_setting"  ]
*random

[tb_eval  exp="f.role=Math.floor(Math.random()*(5-1+1)+1)"  name="role"  cmd="="  op="r"  val="1"  val_2="5"  ]
[jump  storage="role.ks"  target="*wolf"  cond="f.role==1"  ]
[jump  storage="role.ks"  target="*lunatic"  cond="f.role==2"  ]
[jump  storage="role.ks"  target="*seer"  cond="f.role==3"  ]
[jump  storage="role.ks"  target="*human"  cond=""  ]
*role_setting

[jump  storage="role.ks"  target="*mafutsu_set01"  cond="f.player==1"  ]
[jump  storage="role.ks"  target="*sisigami_set01"  cond="f.player==2"  ]
[jump  storage="role.ks"  target="*murasame_set01"  cond="f.player==3"  ]
[jump  storage="role.ks"  target="*kano_set01"  cond="f.player==4"  ]
[jump  storage="role.ks"  target="*tendo_set01"  cond="f.player==5"  ]
*mafutsu_set01

[tb_eval  exp="f.role2=f.mafutsu"  name="role2"  cmd="="  op="h"  val="mafutsu"  val_2="undefined"  ]
[tb_eval  exp="f.mafutsu=f.role"  name="mafutsu"  cmd="="  op="h"  val="role"  val_2="undefined"  ]
[jump  storage="role.ks"  target="*role_change"  ]
*sisigami_set01

[tb_eval  exp="f.role2=f.sisigami"  name="role2"  cmd="="  op="h"  val="sisigami"  val_2="undefined"  ]
[tb_eval  exp="f.sisigami=f.role"  name="sisigami"  cmd="="  op="h"  val="role"  val_2="undefined"  ]
[jump  storage="role.ks"  target="*role_change"  ]
*murasame_set01

[tb_eval  exp="f.role2=f.murasame"  name="role2"  cmd="="  op="h"  val="murasame"  val_2="undefined"  ]
[tb_eval  exp="f.murasame=f.role"  name="murasame"  cmd="="  op="h"  val="role"  val_2="undefined"  ]
[jump  storage="role.ks"  target="*role_change"  ]
*kano_set01

[tb_eval  exp="f.role2=f.kano"  name="role2"  cmd="="  op="h"  val="kano"  val_2="undefined"  ]
[tb_eval  exp="f.kano=f.role"  name="kano"  cmd="="  op="h"  val="role"  val_2="undefined"  ]
[jump  storage="role.ks"  target="*role_change"  ]
*tendo_set01

[tb_eval  exp="f.role2=f.tendo"  name="role2"  cmd="="  op="h"  val="tendo"  val_2="undefined"  ]
[tb_eval  exp="f.tendo=f.role"  name="tendo"  cmd="="  op="h"  val="role"  val_2="undefined"  ]
*role_change

[jump  storage="role.ks"  target="*mafutsu_set02"  cond="f.player==1"  ]
[jump  storage="role.ks"  target="*mafutsu_set02"  cond="f.mafutsu!=f.role"  ]
[tb_eval  exp="f.mafutsu=f.role2"  name="mafutsu"  cmd="="  op="h"  val="role2"  val_2="undefined"  ]
*mafutsu_set02

[jump  storage="role.ks"  target="*sisigami_set02"  cond="f.player==2"  ]
[jump  storage="role.ks"  target="*sisigami_set02"  cond="f.sisigami!=f.role"  ]
[tb_eval  exp="f.sisigami=f.role2"  name="sisigami"  cmd="="  op="h"  val="role2"  val_2="undefined"  ]
*sisigami_set02

[jump  storage="role.ks"  target="*murasame_set02"  cond="f.player==3"  ]
[jump  storage="role.ks"  target="*murasame_set02"  cond="f.murasame!=f.role"  ]
[tb_eval  exp="f.murasame=f.role2"  name="murasame"  cmd="="  op="h"  val="role2"  val_2="undefined"  ]
*murasame_set02

[jump  storage="role.ks"  target="*kano_set02"  cond="f.player==4"  ]
[jump  storage="role.ks"  target="*kano_set02"  cond="f.kano!=f.role"  ]
[tb_eval  exp="f.kano=f.role2"  name="kano"  cmd="="  op="h"  val="role2"  val_2="undefined"  ]
*kano_set02

[jump  storage="role.ks"  target="*tendo_set02"  cond="f.player==5"  ]
[jump  storage="role.ks"  target="*tendo_set02"  cond="f.tendo!=f.role"  ]
[tb_eval  exp="f.tendo=f.role2"  name="tendo"  cmd="="  op="h"  val="role2"  val_2="undefined"  ]
*tendo_set02

*role_end

[chara_show  name="suo"  time="1000"  wait="true"  storage="chara/6/suo_egao.png"  width="320"  height="720"  ]
[call  storage="role.ks"  target="*test"  ]
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
*test

[return  ]
[tb_start_tyrano_code]
[free layer=2 name="mafutsu_test"]
[free layer=2 name="sisigami_test"]
[free layer=2 name="murasame_test"]
[free layer=2 name="kano_test"]
[free layer=2 name="tendo_test"]
[free layer=2 name="role2_test"]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[ptext layer="2" text="&f.mafutsu" x="100" y="75" size="40" color="orange" name="mafutsu_test" width="256" align="center" overwrite="true"]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[ptext layer="2" text="&f.sisigami" x="200" y="75" size="40" color="yellow" name="sisigami_test" width="256" align="center" overwrite="true"]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[ptext layer="2" text="&f.murasame" x="300" y="75" size="40" color="blue" name="murasame_test" width="256" align="center" overwrite="true"]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[ptext layer="2" text="&f.kano" x="400" y="75" size="40" color="purple" name="kano_test" width="256" align="center" overwrite="true"]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[ptext layer="2" text="&f.tendo" x="500" y="75" size="40" color="black" name="tendo_test" width="256" align="center" overwrite="true"]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[ptext layer="2" text="&f.role2" x="100" y="200" size="40" color="black" name="role2_test" width="256" align="center" overwrite="true"]
[_tb_end_tyrano_code]

[return  ]
