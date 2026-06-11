[_tb_system_call storage=system/_system.ks]

*init

[iscript]
f.turn=0;
f.day=1;
f.alive="1,1,1,1,1";
f.co="0,0,0,0,0";
f.claim="0,0,0,0,0,0,0,0,0,0";
f.claim2="0,0,0,0,0,0,0,0,0,0";
f.like="10,0,0,0,0,30,0,0,0,30,0,0,0,10,0,0,0,10,0,0";
f.liar="0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
f.seer_result1="0,0";
f.seer_result2="0,0";
f.target=0;
f.result=0;
f.name=0;
f.name2=0;
f.ai_actor=0;
f.ai_command=0;
f.ai_result=0;
f.votes="0,0,0,0,0";
f.vote_disp1=0;
f.vote_disp2=0;
f.vote_disp3=0;
f.vote_disp4=0;
f.vote_disp5=0;
f.revote=0;
f.say_human=0;
f.player_death=0;
f.mafutsu_calm=100;
f.sisigami_calm=80;
f.murasame_calm=110;
f.kano_calm=100;
f.tendo_calm=120;
f.action=0;
f.push=0;
f.win=0;
f.tutorial=0;
[endscript]

[return  ]
*liar

[iscript]
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
var playerNum=parseInt(f.player);
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
var claim=String(f.claim).split(",");
var claim2=String(f.claim2).split(",");
var lr=String(f.liar).split(",");
function gi(a,b){
var o=(a-1)*4;
var t=[];
for(var i=1;i<=5;i++){if(i!==a)t.push(i);}
return o+t.indexOf(b);
}
function setLiar(idx,val){
var cur=parseInt(lr[idx]);
if(cur>=3)return;
lr[idx]=String(val);
}
// ===== 全員共通①：処刑続行バレ =====
var executed=parseInt(f.result);
if(executed>0){
for(var i=1;i<=5;i++){
if(coArr[i-1]==="0")continue;
var c1t=parseInt(claim[(i-1)*2]);
var c1r=parseInt(claim[(i-1)*2+1]);
var c2t=parseInt(claim2[(i-1)*2]);
var c2r=parseInt(claim2[(i-1)*2+1]);
var busted=false;
if(c1t===executed&&c1r===1)busted=true;
if(c2t===executed&&c2r===1)busted=true;
if(busted){
for(var obs=1;obs<=5;obs++){
if(obs===i)continue;
if(aliveArr[obs-1]==="0")continue;
setLiar(gi(obs,i),1);
}
}
}
}
// ===== 全員共通②：CO人数による正直確定 =====
var coCount=0;
for(var i=1;i<=5;i++){
if(coArr[i-1]==="1")coCount++;
}
if(coCount>=3){
for(var i=1;i<=5;i++){
if(aliveArr[i-1]==="0")continue;
if(coArr[i-1]==="1")continue;
for(var obs=1;obs<=5;obs++){
if(obs===i)continue;
if(aliveArr[obs-1]==="0")continue;
setLiar(gi(obs,i),5);
}
}
}
// ===== 全員共通③：liar=5のキャラを人狼申告したCO→liar=1 =====
for(var obs=1;obs<=5;obs++){
if(aliveArr[obs-1]==="0")continue;
for(var i=1;i<=5;i++){
if(i===obs)continue;
if(coArr[i-1]==="0")continue;
var c1t=parseInt(claim[(i-1)*2]);
var c1r=parseInt(claim[(i-1)*2+1]);
var c2t=parseInt(claim2[(i-1)*2]);
var c2r=parseInt(claim2[(i-1)*2+1]);
if(c1r===1&&c1t>0&&parseInt(lr[gi(obs,c1t)])===5)setLiar(gi(obs,i),1);
if(c2r===1&&c2t>0&&parseInt(lr[gi(obs,c2t)])===5)setLiar(gi(obs,i),1);
}
}
// ===== 全員共通④：死亡COチェーン（A黒B・B黒C→C人狼確定） =====
for(var a=1;a<=5;a++){
if(coArr[a-1]==="0")continue;
if(aliveArr[a-1]==="1")continue;
for(var b=1;b<=5;b++){
if(b===a)continue;
if(coArr[b-1]==="0")continue;
if(aliveArr[b-1]==="1")continue;
var aBc1t=parseInt(claim[(a-1)*2]);
var aBc1r=parseInt(claim[(a-1)*2+1]);
var aBc2t=parseInt(claim2[(a-1)*2]);
var aBc2r=parseInt(claim2[(a-1)*2+1]);
var aClaimedB=(aBc1t===b&&aBc1r===1)||(aBc2t===b&&aBc2r===1);
if(!aClaimedB)continue;
var bc1t=parseInt(claim[(b-1)*2]);
var bc1r=parseInt(claim[(b-1)*2+1]);
var bc2t=parseInt(claim2[(b-1)*2]);
var bc2r=parseInt(claim2[(b-1)*2+1]);
var c=0;
if(bc1r===1&&bc1t>0&&aliveArr[bc1t-1]==="1")c=bc1t;
else if(bc2r===1&&bc2t>0&&aliveArr[bc2t-1]==="1")c=bc2t;
if(c===0)continue;
for(var obs=1;obs<=5;obs++){
if(obs===c)continue;
if(aliveArr[obs-1]==="0")continue;
lr[gi(obs,c)]="3";
}
}
}
// ===== 狂人視点：自分を人狼と申告したCO→liar=1 =====
for(var mad=1;mad<=5;mad++){
if(roles[mad-1]!==2)continue;
if(aliveArr[mad-1]==="0")continue;
for(var i=1;i<=5;i++){
if(i===mad)continue;
if(coArr[i-1]==="0")continue;
var c1t=parseInt(claim[(i-1)*2]);
var c1r=parseInt(claim[(i-1)*2+1]);
var c2t=parseInt(claim2[(i-1)*2]);
var c2r=parseInt(claim2[(i-1)*2+1]);
if(c1t===mad&&c1r===1)setLiar(gi(mad,i),1);
if(c2t===mad&&c2r===1)setLiar(gi(mad,i),1);
}
}
// ===== 占い師視点 =====
for(var seer=1;seer<=5;seer++){
if(roles[seer-1]!==3)continue;
if(aliveArr[seer-1]==="0")continue;
for(var i=1;i<=5;i++){
if(i===seer)continue;
if(coArr[i-1]==="0")continue;
setLiar(gi(seer,i),1);
}
var sr1=String(f.seer_result1).split(",");
var sr2=String(f.seer_result2).split(",");
var sr1tgt=parseInt(sr1[0]);var sr1res=parseInt(sr1[1]);
var sr2tgt=parseInt(sr2[0]);var sr2res=parseInt(sr2[1]);
if(sr1tgt>0&&sr1res===1)lr[gi(seer,sr1tgt)]="3";
if(sr2tgt>0&&sr2res===1)lr[gi(seer,sr2tgt)]="3";
if(sr1tgt>0&&sr1res===0&&parseInt(lr[gi(seer,sr1tgt)])===1)lr[gi(seer,sr1tgt)]="4";
if(sr2tgt>0&&sr2res===0&&parseInt(lr[gi(seer,sr2tgt)])===1)lr[gi(seer,sr2tgt)]="4";
var hasMad=false;
for(var i=1;i<=5;i++){
if(i===seer)continue;
if(parseInt(lr[gi(seer,i)])===4){hasMad=true;break;}
}
if(hasMad){
for(var i=1;i<=5;i++){
if(i===seer)continue;
if(parseInt(lr[gi(seer,i)])===1)lr[gi(seer,i)]="3";
}
}
}
// ===== 村人視点：自分を人狼と申告したCO→liar=1 =====
for(var vil=1;vil<=5;vil++){
if(roles[vil-1]!==4&&roles[vil-1]!==5)continue;
if(aliveArr[vil-1]==="0")continue;
for(var i=1;i<=5;i++){
if(i===vil)continue;
if(coArr[i-1]==="0")continue;
var c1t=parseInt(claim[(i-1)*2]);
var c1r=parseInt(claim[(i-1)*2+1]);
var c2t=parseInt(claim2[(i-1)*2]);
var c2r=parseInt(claim2[(i-1)*2+1]);
if(c1t===vil&&c1r===1)setLiar(gi(vil,i),1);
if(c2t===vil&&c2r===1)setLiar(gi(vil,i),1);
}
}
// ===== 人狼視点 =====
for(var wolf=1;wolf<=5;wolf++){
if(roles[wolf-1]!==1)continue;
if(aliveArr[wolf-1]==="0")continue;
for(var i=1;i<=5;i++){
if(i===wolf)continue;
if(aliveArr[i-1]==="0")continue;
if(parseInt(lr[gi(wolf,i)])===1)lr[gi(wolf,i)]="4";
}
for(var i=1;i<=5;i++){
if(i===wolf)continue;
if(coArr[i-1]==="0")continue;
var c1t=parseInt(claim[(i-1)*2]);
var c1r=parseInt(claim[(i-1)*2+1]);
var c2t=parseInt(claim2[(i-1)*2]);
var c2r=parseInt(claim2[(i-1)*2+1]);
if(c1t>0&&c1t!==wolf&&c1r===1)lr[gi(wolf,i)]="4";
if(c2t>0&&c2t!==wolf&&c2r===1)lr[gi(wolf,i)]="4";
if(c1t===wolf&&c1r===0)lr[gi(wolf,i)]="4";
if(c2t===wolf&&c2r===0)lr[gi(wolf,i)]="4";
}
for(var i=1;i<=5;i++){
if(i===wolf)continue;
if(aliveArr[i-1]==="0")continue;
setLiar(gi(wolf,i),2);
}
}
f.liar=lr.join(",");
[endscript]

[return  ]
*death

[iscript]
f.player_death=parseInt(f.result)===parseInt(f.player)?1:0;
[endscript]

[call  storage="end.ks"  target="*player_death"  cond="f.player_death==1"  ]
[iscript]
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
var dead=parseInt(f.result);
var aliveArr=String(f.alive).split(",");
aliveArr[dead-1]="0";
f.alive=aliveArr.join(",");
var liarArr=String(f.liar).split(',');
// 死者を全生存者のliarで「確認済み人間(2)」に更新
for(var v=1;v<=5;v++){
if(v===dead)continue;
liarArr[gi(v,dead)]='2';
}
f.liar=liarArr.join(',');
[endscript]

*game_set

[iscript]
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
var aliveArr=String(f.alive).split(",");
var aliveWolf=0,aliveHuman=0;
for(var i=0;i<5;i++){
if(aliveArr[i]==="0")continue;
if(roles[i]===1)aliveWolf++;else aliveHuman++;
}
f.win=aliveWolf===0?1:aliveWolf>=aliveHuman?2:0;
[endscript]

[jump  storage="end.ks"  target="*game_set"  cond="f.win!=0"  ]
[jump  storage="night.ks"  target="*night"  cond="f.jump=='vote'"  ]
[jump  storage="scenario.ks"  target="*morning"  cond="f.jump=='wolf'"  ]
*alive

[iscript]
var names=["真経津","獅子神","村雨","叶","天堂"];
var aliveArr=String(f.alive).split(",");
var aliveNames=[];
for(var i=0;i<5;i++){
if(aliveArr[i]==="1")aliveNames.push(names[i]);
}
f.vote_disp1=aliveNames.join("、");
[endscript]

[tb_start_text mode=1 ]
#システム
残りの生存者は[emb exp="f.vote_disp1"]です。[p]
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
function addCalm(i,val){if(i===1)f.mafutsu_calm=parseFloat(f.mafutsu_calm)+val;else if(i===2)f.sisigami_calm=parseFloat(f.sisigami_calm)+val;else if(i===3)f.murasame_calm=parseFloat(f.murasame_calm)+val;else if(i===4)f.kano_calm=parseFloat(f.kano_calm)+val;else f.tendo_calm=parseFloat(f.tendo_calm)+val;}
addCalm(f.player,-20);
[endscript]

[iscript]
var aliveArr=String(f.alive).split(",");
var candidates=[];
for(var i=1;i<=5;i++){
if(i!==parseInt(f.player)&&aliveArr[i-1]==="1")candidates.push(i);
}
f.target=candidates[Math.floor(Math.random()*candidates.length)];
var names=['真経津','獅子神','村雨','叶','天堂'];
f.name=names[parseInt(f.player)-1];
[endscript]

[call  storage="mafutsu.ks"  target="*noisy"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*noisy"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*noisy"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*noisy"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*noisy"  cond="f.target==5"  ]
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
function addCalm(i,val){if(i===1)f.mafutsu_calm=parseFloat(f.mafutsu_calm)+val;else if(i===2)f.sisigami_calm=parseFloat(f.sisigami_calm)+val;else if(i===3)f.murasame_calm=parseFloat(f.murasame_calm)+val;else if(i===4)f.kano_calm=parseFloat(f.kano_calm)+val;else f.tendo_calm=parseFloat(f.tendo_calm)+val;}
addCalm(parseInt(f.player),-20);
[endscript]

[return  ]
