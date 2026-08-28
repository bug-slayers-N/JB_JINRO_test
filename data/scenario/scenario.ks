[_tb_system_call storage=system/_scenario.ks]

[cm  ]
*day01

[mask  time="1000"  effect="fadeIn"  color="0x000000"  ]
[bg  time="1000"  method="crossfade"  storage="92690259_p0.png"  ]
[chara_hide_all  time="0"  wait="true"  ]
[tb_show_message_window  ]
[mask_off  time="1000"  effect="fadeOut"  ]
[glink  color="btn_05_red"  storage="scenario.ks"  size="20"  target="*day01_01"  text="シナリオを見る"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[glink  color="btn_05_white"  storage="scenario.ks"  size="20"  target="*day01_03"  text="シナリオをとばす"  autopos="true"  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[s  ]
*day01_01

[call  storage="mafutsu.ks"  target="*day01_01"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*day01_01"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*day01_01"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*day01_01"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*day01_01"  cond="f.player==5"  ]
[call  storage="shigure.ks"  target="*day01_01"  cond="f.player==6"  ]
[call  storage="yamabuki.ks"  target="*day01_01"  cond="f.player==7"  ]
[call  storage="gato.ks"  target="*day01_01"  cond="f.player==8"  ]
[call  storage="urushibara.ks"  target="*day01_01"  cond="f.player==9"  ]
[mask  time="300"  effect="fadeIn"  color="0x000000"  ]
[chara_hide_all  time="0"  wait="false"  ]
[tb_image_hide  time="0"  ]
[tb_ptext_hide  time="0"  ]
[mask_off  time="300"  effect="fadeOut"  ]
*day01_02

[call  storage="mafutsu.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#真経津
「やっぱりみんなも呼ばれてたんだね～」[p]
[_tb_end_text]

[call  storage="sisigami.ks"  target="*show2"  ]
[call  storage="sisigami.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#獅子神
「なんなんだよ、このゲーム…」[p]
[_tb_end_text]

[call  storage="murasame.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#村雨
「銀行もVIPもよほど暇と見える」[p]
[_tb_end_text]

[call  storage="kano.ks"  target="*show"  ]
[call  storage="kano.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#叶
「晨君達が相手じゃなかったら、こんなクソゲーすぐ帰ってたぞ」[p]
[_tb_end_text]

[call  storage="tendo.ks"  target="*show2"  ]
[call  storage="tendo.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#天堂
「どんな条件であれ、私が勝つということに変わりはない」[p]

[_tb_end_text]

[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#叶
「画面の向こう側にいる奴を相手するんだから、オレこそ負ける要素がないんだよね」[p]
[_tb_end_text]

[call  storage="sisigami.ks"  target="*show"  ]
[call  storage="sisigami.ks"  target="*show_gimon"  ]
[tb_start_text mode=1 ]
#獅子神
「そもそも村人陣営と人狼陣営の勝負なんだから、チーム戦じゃねぇのか…？」[p]
[_tb_end_text]

[call  storage="murasame.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#村雨
「己の手で陣営を勝利させるという意味だろう。全く、自我が肥大しすぎている」[p]
「獅子神の言う通り、これはチーム戦だぞ」[p]

[_tb_end_text]

[call  storage="mafutsu.ks"  target="*show"  ]
[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_text mode=1 ]
#真経津
「なんでもいいからさっさとはじめよ～！」[p]
[_tb_end_text]

[jump  storage="scenario.ks"  target="*day01_03"  cond="f.gamemode==5"  ]
*gm9

[call  storage="mafutsu.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#真経津
「あれ？他にも誰かいるみたい」[p]
[_tb_end_text]

[call  storage="yamabuki.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#？？？
「ヒーローは遅れてやってくるってなぁ」[p]
「な、相棒」[p]
[_tb_end_text]

[call  storage="shigure.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#？？？
「ま、我々は忙しいですから」[p]
「って、え、千晴君以外のメンバーって彼らなんですか！？」[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#山吹
「まじかよ。オメーら、あんときの恨みは忘れてねぇからな」[p]
[_tb_end_text]

[call  storage="murasame.ks"  target="*show"  ]
[call  storage="murasame.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#村雨
「カラス銀行は仕事をさぼったのか？」[p]
[_tb_end_text]

[call  storage="sisigami.ks"  target="*show2"  ]
[call  storage="sisigami.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#獅子神
「お、オレは生きててくれて嬉しいよ」[p]
[_tb_end_text]

[call  storage="gato.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#？？？
「お、みんな集まってるみたいじゃねぇか」[p]
[_tb_end_text]

[call  storage="urushibara.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#？？？
「ごめんね、がっちゃんが私服じゃなくてスーツで行くべきだって着替えてたら遅くなっちゃった」[p]
#牙頭
「ギャンブルじゃなくてゲーム大会だけど、カラ銀主催ならスーツの方がいいだろ」[p]
「みんないつもの服じゃねぇか」[p]
#漆原
「そうだね、がっちゃんの言う通りだ」[p]

[_tb_end_text]

[call  storage="mafutsu.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#真経津
「すっごい大所帯になってきたね、わくわくしてきたよ」[p]
[_tb_end_text]

*day01_03

[jump  storage="debate.ks"  target=""  ]
*jinro_win

[iscript]
f.target=0;
var n=parseInt(f.gamemode);
var charArr=String(f.character).split(",");
for(var i=1;i<=n;i++){
if(parseInt(charArr[i-1])===1){f.target=i;break;}
}
[endscript]

[call  storage="mafutsu.ks"  target="*jinro_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*jinro_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*jinro_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*jinro_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*jinro_win"  cond="f.target==5"  ]
[call  storage="shigure.ks"  target="*jinro_win"  cond="f.target==6"  ]
[call  storage="yamabuki.ks"  target="*jinro_win"  cond="f.target==7"  ]
[call  storage="gato.ks"  target="*jinro_win"  cond="f.target==8"  ]
[call  storage="urushibara.ks"  target="*jinro_win"  cond="f.target==9"  ]
[iscript]
// 9人モードのみ：人狼はrole1とrole2の2人いるため、2人目(role2)も演出対象にする
f.target=0;
var n=parseInt(f.gamemode);
if(n===9){
var charArr=String(f.character).split(",");
for(var i=1;i<=n;i++){
if(parseInt(charArr[i-1])===2){f.target=i;break;}
}
}
[endscript]

[call  storage="mafutsu.ks"  target="*jinro_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*jinro_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*jinro_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*jinro_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*jinro_win"  cond="f.target==5"  ]
[call  storage="shigure.ks"  target="*jinro_win"  cond="f.target==6"  ]
[call  storage="yamabuki.ks"  target="*jinro_win"  cond="f.target==7"  ]
[call  storage="gato.ks"  target="*jinro_win"  cond="f.target==8"  ]
[call  storage="urushibara.ks"  target="*jinro_win"  cond="f.target==9"  ]
[iscript]
f.target=0;
var n=parseInt(f.gamemode);
var charArr=String(f.character).split(",");
for(var i=1;i<=n;i++){
if(parseInt(charArr[i-1])===9){f.target=i;break;}
}
[endscript]

[call  storage="mafutsu.ks"  target="*jinro_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*jinro_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*jinro_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*jinro_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*jinro_win"  cond="f.target==5"  ]
[call  storage="shigure.ks"  target="*jinro_win"  cond="f.target==6"  ]
[call  storage="yamabuki.ks"  target="*jinro_win"  cond="f.target==7"  ]
[call  storage="gato.ks"  target="*jinro_win"  cond="f.target==8"  ]
[call  storage="urushibara.ks"  target="*jinro_win"  cond="f.target==9"  ]
[jump  storage="scenario.ks"  target="*game_end"  ]
*human_win

[iscript]
f.target=0;
var n=parseInt(f.gamemode);
var charArr=String(f.character).split(",");
for(var i=1;i<=n;i++){
if(parseInt(charArr[i-1])===10){f.target=i;break;}
}
[endscript]

[call  storage="mafutsu.ks"  target="*human_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*human_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*human_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*human_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*human_win"  cond="f.target==5"  ]
[call  storage="shigure.ks"  target="*human_win"  cond="f.target==6"  ]
[call  storage="yamabuki.ks"  target="*human_win"  cond="f.target==7"  ]
[call  storage="gato.ks"  target="*human_win"  cond="f.target==8"  ]
[call  storage="urushibara.ks"  target="*human_win"  cond="f.target==9"  ]
[iscript]
// 9人モードのみ：霊媒師(role11)も演出対象にする
f.target=0;
var n=parseInt(f.gamemode);
if(n===9){
var charArr=String(f.character).split(",");
for(var i=1;i<=n;i++){
if(parseInt(charArr[i-1])===11){f.target=i;break;}
}
}
[endscript]

[call  storage="mafutsu.ks"  target="*human_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*human_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*human_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*human_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*human_win"  cond="f.target==5"  ]
[call  storage="shigure.ks"  target="*human_win"  cond="f.target==6"  ]
[call  storage="yamabuki.ks"  target="*human_win"  cond="f.target==7"  ]
[call  storage="gato.ks"  target="*human_win"  cond="f.target==8"  ]
[call  storage="urushibara.ks"  target="*human_win"  cond="f.target==9"  ]
[iscript]
// 9人モードのみ：騎士(role12)も演出対象にする
f.target=0;
var n=parseInt(f.gamemode);
if(n===9){
var charArr=String(f.character).split(",");
for(var i=1;i<=n;i++){
if(parseInt(charArr[i-1])===12){f.target=i;break;}
}
}
[endscript]

[call  storage="mafutsu.ks"  target="*human_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*human_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*human_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*human_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*human_win"  cond="f.target==5"  ]
[call  storage="shigure.ks"  target="*human_win"  cond="f.target==6"  ]
[call  storage="yamabuki.ks"  target="*human_win"  cond="f.target==7"  ]
[call  storage="gato.ks"  target="*human_win"  cond="f.target==8"  ]
[call  storage="urushibara.ks"  target="*human_win"  cond="f.target==9"  ]
[iscript]
f.target=0;
var n=parseInt(f.gamemode);
var charArr=String(f.character).split(",");
for(var i=1;i<=n;i++){
if(parseInt(charArr[i-1])===15){f.target=i;break;}
}
[endscript]

[call  storage="mafutsu.ks"  target="*human_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*human_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*human_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*human_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*human_win"  cond="f.target==5"  ]
[call  storage="shigure.ks"  target="*human_win"  cond="f.target==6"  ]
[call  storage="yamabuki.ks"  target="*human_win"  cond="f.target==7"  ]
[call  storage="gato.ks"  target="*human_win"  cond="f.target==8"  ]
[call  storage="urushibara.ks"  target="*human_win"  cond="f.target==9"  ]
[iscript]
// 5人モードのみ：9人モードは村人枠をrole15の1人だけに絞るため、role16はここでは対象外
f.target=0;
var n=parseInt(f.gamemode);
if(n===5){
var charArr=String(f.character).split(",");
for(var i=1;i<=n;i++){
if(parseInt(charArr[i-1])===16){f.target=i;break;}
}
}
[endscript]

[call  storage="mafutsu.ks"  target="*human_win"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*human_win"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*human_win"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*human_win"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*human_win"  cond="f.target==5"  ]
[call  storage="shigure.ks"  target="*human_win"  cond="f.target==6"  ]
[call  storage="yamabuki.ks"  target="*human_win"  cond="f.target==7"  ]
[call  storage="gato.ks"  target="*human_win"  cond="f.target==8"  ]
[call  storage="urushibara.ks"  target="*human_win"  cond="f.target==9"  ]
*game_end

[jump  storage="tutorial.ks"  target="*text3"  cond="f.tutorial==1"  ]
*win

[iscript]
function isWolfTeam(role){return role<10;}
var role=parseInt(f.role);
var win=parseInt(f.win);
if(win===1&&!isWolfTeam(role)){f.win=0;}
else if(win===2&&isWolfTeam(role)){f.win=0;}
else{f.win=1;}
[endscript]

[jump  storage="scenario.ks"  target="*lose"  cond="f.win!=0"  ]
[jump  storage="scenario.ks"  target="*win2"  cond="f.list=='win2'"  ]
[call  storage="mafutsu.ks"  target="*win"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*win"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*win"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*win"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*win"  cond="f.player==5"  ]
[call  storage="shigure.ks"  target="*win"  cond="f.player==6"  ]
[call  storage="yamabuki.ks"  target="*win"  cond="f.player==7"  ]
[call  storage="gato.ks"  target="*win"  cond="f.player==8"  ]
[call  storage="urushibara.ks"  target="*win"  cond="f.player==9"  ]
[jump  storage="scenario.ks"  target="*game_end2"  ]
*lose

[call  storage="mafutsu.ks"  target="*lose"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*lose"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*lose"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*lose"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*lose"  cond="f.player==5"  ]
[call  storage="shigure.ks"  target="*lose"  cond="f.player==6"  ]
[call  storage="yamabuki.ks"  target="*lose"  cond="f.player==7"  ]
[call  storage="gato.ks"  target="*lose"  cond="f.player==8"  ]
[call  storage="urushibara.ks"  target="*lose"  cond="f.player==9"  ]
[jump  storage="scenario.ks"  target="*game_end2"  ]
*win2

[call  storage="mafutsu.ks"  target="*win2"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*win2"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*win2"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*win2"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*win2"  cond="f.player==5"  ]
[call  storage="shigure.ks"  target="*win2"  cond="f.player==6"  ]
[call  storage="yamabuki.ks"  target="*win2"  cond="f.player==7"  ]
[call  storage="gato.ks"  target="*win2"  cond="f.player==8"  ]
[call  storage="urushibara.ks"  target="*win2"  cond="f.player==9"  ]
*game_end2

[chara_hide_all  time="1000"  wait="true"  ]
[chara_show  name="suo"  time="1000"  wait="true"  storage="chara/6/suo_normal.png"  width="320"  height="720"  ]
[tb_start_text mode=1 ]
#周防
「お疲れ様でした」[p]
「ジャンケット人狼ゲーム、お楽しみいただけましたでしょうか？」[p]
「特定条件を満たすと、おまけの彼らの様子が見れるようです」[p]
「是非チャレンジしてみてくださいませ」[p]

[_tb_end_text]

[chara_mod  name="suo"  time="300"  cross="false"  storage="chara/6/suo_egao.png"  ]
[tb_start_text mode=1 ]
「それでは、またのお越しをお待ちしております」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[tb_hide_message_window  ]
[glink  color="btn_05_white"  storage="title_screen.ks"  size="20"  text="・&nbsp;タイトルへ&nbsp;・"  x="100"  y="100"  width=""  height=""  _clickable_img=""  autopos="true"  ]
[glink  color="btn_05_red"  storage="role.ks"  size="20"  text="・　連戦する　・"  x="94"  y="172"  width=""  height=""  _clickable_img=""  autopos="true"  ]
[glink  color="btn_05_blue"  storage="scenario.ks"  size="20"  text="・Xで結果を共有・"  target="*X"  x="87"  y="246"  width=""  height=""  _clickable_img=""  autopos="true"  ]
[s  ]
[mask  time="1000"  effect="fadeIn"  color="0x000000"  ]
*X

[iscript]
var charNames = ["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var roleMap = {1:"人狼",2:"人狼",3:"人狼",4:"人狼",5:"人狼",9:"狂人",10:"占い師",11:"霊媒師",12:"騎士",15:"村人",16:"村人",17:"村人"};
var charName = charNames[parseInt(f.player)];
var roleName = roleMap[parseInt(f.role)]||"不明";
var isWin = parseInt(f.win)===0;
var result = isWin ? "勝利" : "敗北";
var text = "【非公式】"+charName+"("+roleName+")で"+result+"しました。フレンズ達の人狼ゲームで嘘つきを見破ろう！→https://bug-slayers-N.github.io/JB_JINRO/";
window.open("https://twitter.com/intent/tweet?text="+encodeURIComponent(text));
[endscript]

[jump  storage="title_screen.ks"  target=""  ]
