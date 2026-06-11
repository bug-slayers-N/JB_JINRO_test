[_tb_system_call storage=system/_vote.ks]

*player_vote

[jump  storage="vote.ks"  target="*player_vote_end"  cond="f.player_death==1"  ]
[chara_hide_all  time="300"  wait="true"  ]
[tb_hide_message_window  ]
[tb_eval  exp="f.jump='vote'"  name="jump"  cmd="="  op="t"  val="vote"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listB"  ]
*player_vote_back

[call  storage="UI.ks"  target="*name_change"  ]
[tb_show_message_window  ]
[bg  time="1000"  method="crossfade"  storage="92690259_p0.png"  ]
[tb_start_text mode=1 ]
#システム
[emb exp="f.name"]に投票しました。[p]
[_tb_end_text]

*player_vote_end

[mask_off  time="1000"  effect="fadeOut"  ]
[jump  storage="vote.ks"  target="*like_boost"  cond="f.revote==1"  ]
*vote_ai

[iscript]
var aliveArr=String(f.alive).split(",");
var vt=[];
for(var i=0;i<5;i++){if(aliveArr[i]==="1")vt.push(i+1);}
f.vote_target=vt.join(",");
f.votes="0,0,0,0,0";
[endscript]

*like_boost

[iscript]
function getEl(a,b){return parseInt(String(a).split(',')[b],10);}
function si(a,b,val){var arr=String(a).split(',');arr[b]=String(val);return arr.join(',');}
function isAlive(i){return parseInt(String(f.alive).split(',')[i-1])===1;}
if(isAlive(1)){
var idxs=[4,8,12,16];
for(var i=0;i<idxs.length;i++){f.like=si(f.like,idxs[i],getEl(f.like,idxs[i])+20);}
}
[endscript]

*ai_wolf

[iscript]
function getEl(a,b){return parseInt(String(a).split(',')[b],10);}
function si(a,b,v){var arr=String(a).split(',');arr[b]=String(v);return arr.join(',');}
function isAlive(i){return parseInt(String(f.alive).split(',')[i-1])===1;}
function hasCO(i){return parseInt(String(f.co).split(',')[i-1])===1;}
function getRole(i){return parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][i-1]);}
function getCalm(i){return parseFloat([f.mafutsu_calm,f.sisigami_calm,f.murasame_calm,f.kano_calm,f.tendo_calm][i-1]);}
function pairIdx(a,b){return (a-1)*4+(b<a?b-1:b-2);}
function getLiar(a,b){return getEl(f.liar,pairIdx(a,b));}
function getPC(a,b){return getCalm(b)+getEl(f.like,pairIdx(a,b));}
function getClaim1(i){var b=(i-1)*2;return{target:getEl(f.claim,b),result:getEl(f.claim,b+1)};}
function getClaim2(i){var b=(i-1)*2;return{target:getEl(f.claim2,b),result:getEl(f.claim2,b+1)};}
function getVotable(a){
var vt=String(f.vote_target).split(",");
var t=[];
for(var i=0;i<vt.length;i++){var c=parseInt(vt[i]);if(c!==a)t.push(c);}
return t;
}
function pickLowest(a,arr){var best=-1,bc=999999;for(var i=0;i<arr.length;i++){var c=arr[i],pc=getPC(a,c);if(pc<bc||(pc===bc&&c<best)){bc=pc;best=c;}}return best;}
function pickHighest(a,arr){var best=-1,bc=-999999;for(var i=0;i<arr.length;i++){var c=arr[i],pc=getPC(a,c);if(pc>bc||(pc===bc&&c<best)){bc=pc;best=c;}}return best;}
var pn=parseInt(f.player);
for(var actor=1;actor<=5;actor++){
if(actor===pn||!isAlive(actor)||getRole(actor)!==1)continue;
var votable=getVotable(actor),target=-1;
for(var i=0;i<votable.length;i++){
var t=votable[i];
var ok=true;
for(var v=1;v<=5;v++){if(isAlive(v)&&v!==t&&v!==actor&&getLiar(v,t)!==1){ok=false;break;}}
if(ok){target=t;break;}
}
if(target===-1){
var acc=[];
for(var i=0;i<votable.length;i++){
var t=votable[i];
if(!hasCO(t))continue;
var c1=getClaim1(t),c2=getClaim2(t);
if((c1.target===actor&&c1.result===1)||(c2.target===actor&&c2.result===1))acc.push(t);
}
if(acc.length>0)target=pickHighest(actor,acc);
}
if(target===-1&&hasCO(actor)){
var opp=[];
for(var i=0;i<votable.length;i++){if(hasCO(votable[i]))opp.push(votable[i]);}
if(opp.length>0)target=pickLowest(actor,opp);
}
if(target===-1)target=pickLowest(actor,votable);
f.votes=si(f.votes,actor-1,target);
}
[endscript]

*ai_mad

[iscript]
function getEl(a,b){return parseInt(String(a).split(',')[b],10);}
function si(a,b,v){var arr=String(a).split(',');arr[b]=String(v);return arr.join(',');}
function isAlive(i){return parseInt(String(f.alive).split(',')[i-1])===1;}
function hasCO(i){return parseInt(String(f.co).split(',')[i-1])===1;}
function getRole(i){return parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][i-1]);}
function getCalm(i){return parseFloat([f.mafutsu_calm,f.sisigami_calm,f.murasame_calm,f.kano_calm,f.tendo_calm][i-1]);}
function pairIdx(a,b){return (a-1)*4+(b<a?b-1:b-2);}
function getLiar(a,b){return getEl(f.liar,pairIdx(a,b));}
function getPC(a,b){return getCalm(b)+getEl(f.like,pairIdx(a,b));}
function getVotable(a){
var vt=String(f.vote_target).split(",");
var t=[];
for(var i=0;i<vt.length;i++){var c=parseInt(vt[i]);if(c!==a)t.push(c);}
return t;
}
function pickLowest(a,arr){var best=-1,bc=999999;for(var i=0;i<arr.length;i++){var c=arr[i],pc=getPC(a,c);if(pc<bc||(pc===bc&&c<best)){bc=pc;best=c;}}return best;}
var pn=parseInt(f.player);
for(var actor=1;actor<=5;actor++){
if(actor===pn||!isAlive(actor)||getRole(actor)!==2)continue;
var votable=getVotable(actor),target=-1;
if(hasCO(actor)){
var opp=[];
for(var i=0;i<votable.length;i++){if(hasCO(votable[i]))opp.push(votable[i]);}
if(opp.length>0)target=pickLowest(actor,opp);
}
if(target===-1){
var pool=[];
for(var i=0;i<votable.length;i++){if(getLiar(actor,votable[i])!==1)pool.push(votable[i]);}
if(pool.length===0)pool=votable;
target=pickLowest(actor,pool);
}
f.votes=si(f.votes,actor-1,target);
}
[endscript]

*ai_seer

[iscript]
function getEl(a,b){return parseInt(String(a).split(',')[b],10);}
function si(a,b,v){var arr=String(a).split(',');arr[b]=String(v);return arr.join(',');}
function isAlive(i){return parseInt(String(f.alive).split(',')[i-1])===1;}
function getRole(i){return parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][i-1]);}
function getCalm(i){return parseFloat([f.mafutsu_calm,f.sisigami_calm,f.murasame_calm,f.kano_calm,f.tendo_calm][i-1]);}
function pairIdx(a,b){return (a-1)*4+(b<a?b-1:b-2);}
function getLiar(a,b){return getEl(f.liar,pairIdx(a,b));}
function getPC(a,b){return getCalm(b)+getEl(f.like,pairIdx(a,b));}
function getVotable(a){
var vt=String(f.vote_target).split(",");
var t=[];
for(var i=0;i<vt.length;i++){var c=parseInt(vt[i]);if(c!==a)t.push(c);}
return t;
}
function pickLowest(a,arr){var best=-1,bc=999999;for(var i=0;i<arr.length;i++){var c=arr[i],pc=getPC(a,c);if(pc<bc||(pc===bc&&c<best)){bc=pc;best=c;}}return best;}
var pn=parseInt(f.player);
for(var actor=1;actor<=5;actor++){
if(actor===pn||!isAlive(actor)||getRole(actor)!==3)continue;
var votable=getVotable(actor),target=-1;
var wolves=[];
for(var i=0;i<votable.length;i++){if(getLiar(actor,votable[i])===3)wolves.push(votable[i]);}
if(wolves.length>0)target=pickLowest(actor,wolves);
var liars=[];
for(var i=0;i<votable.length;i++){if(getLiar(actor,votable[i])===1)liars.push(votable[i]);}
if(target===-1&&liars.length>0)target=pickLowest(actor,liars);
if(target===-1)target=pickLowest(actor,votable);
f.votes=si(f.votes,actor-1,target);
}
[endscript]

*ai_vill

[iscript]
function getEl(a,b){return parseInt(String(a).split(',')[b],10);}
function si(a,b,v){var arr=String(a).split(',');arr[b]=String(v);return arr.join(',');}
function isAlive(i){return parseInt(String(f.alive).split(',')[i-1])===1;}
function getRole(i){return parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][i-1]);}
function getCalm(i){return parseFloat([f.mafutsu_calm,f.sisigami_calm,f.murasame_calm,f.kano_calm,f.tendo_calm][i-1]);}
function pairIdx(a,b){return (a-1)*4+(b<a?b-1:b-2);}
function getLiar(a,b){return getEl(f.liar,pairIdx(a,b));}
function getPC(a,b){return getCalm(b)+getEl(f.like,pairIdx(a,b));}
function getVotable(a){
var vt=String(f.vote_target).split(",");
var t=[];
for(var i=0;i<vt.length;i++){var c=parseInt(vt[i]);if(c!==a)t.push(c);}
return t;
}
function pickLowest(a,arr){var best=-1,bc=999999;for(var i=0;i<arr.length;i++){var c=arr[i],pc=getPC(a,c);if(pc<bc||(pc===bc&&c<best)){bc=pc;best=c;}}return best;}
var pn=parseInt(f.player);
for(var actor=1;actor<=5;actor++){
if(actor===pn||!isAlive(actor)||(getRole(actor)!==4&&getRole(actor)!==5))continue;
var votable=getVotable(actor),target=-1;
var wolves=[];
for(var i=0;i<votable.length;i++){if(getLiar(actor,votable[i])===3)wolves.push(votable[i]);}
if(wolves.length>0)target=pickLowest(actor,wolves);
var liars=[];
for(var i=0;i<votable.length;i++){if(getLiar(actor,votable[i])===1)liars.push(votable[i]);}
if(target===-1&&liars.length>0)target=pickLowest(actor,liars);
if(target===-1)target=pickLowest(actor,votable);
f.votes=si(f.votes,actor-1,target);
}
[endscript]

*ai_calc

[iscript]
var pn=parseInt(f.player);
var aliveArr=String(f.alive).split(",");
var votes=String(f.votes).split(",");
votes[pn-1]=parseInt(f.target);
var count=[0,0,0,0,0];
for(var i=0;i<5;i++){var v=parseInt(votes[i]);if(v>=1&&v<=5)count[v-1]++;}
var maxVote=0;
for(var i=0;i<5;i++){if(count[i]>maxVote)maxVote=count[i];}
var top=[];
for(var i=0;i<5;i++){if(aliveArr[i]==="0")continue;if(count[i]===maxVote)top.push(i+1);}
if(top.length===1){
f.result=top[0];
f.revote=0;
}else if(parseInt(f.revote)===1){
f.result=0;
f.revote=2;
}else{
f.result=0;
f.vote_target=top.join(",");
f.revote=1;
}
f.votes=votes.join(",");
[endscript]

[iscript]
function getEl(a,b){return parseInt(String(a).split(',')[b],10);}
function si(a,b,val){var arr=String(a).split(',');arr[b]=String(val);return arr.join(',');}
function isAlive(i){return parseInt(String(f.alive).split(',')[i-1])===1;}
if(isAlive(1)){
var idxs=[4,8,12,16];
for(var i=0;i<idxs.length;i++){f.like=si(f.like,idxs[i],getEl(f.like,idxs[i])-20);}
}
[endscript]

*text

[tb_ptext_hide  time="0"  ]
[tb_start_text mode=1 ]
投票結果が集計されました。[p]
[_tb_end_text]

[iscript]
var names=["真経津","獅子神","村雨","叶","天堂"];
var votes=String(f.votes).split(",");
var aliveArr=String(f.alive).split(",");
var lines=[];
for(var i=0;i<5;i++){
if(aliveArr[i]==="0")continue;
var v=parseInt(votes[i]);
if(v>=1&&v<=5)lines.push(names[i]+"→"+names[v-1]);
}
f.vote_disp1=lines[0]||"";
f.vote_disp2=lines[1]||"";
f.vote_disp3=lines[2]||"";
f.vote_disp4=lines[3]||"";
f.vote_disp5=lines[4]||"";
[endscript]

[tb_start_text mode=1 ]
[emb exp="f.vote_disp1"]  [emb exp="f.vote_disp2"]  [emb exp="f.vote_disp3"]  [emb exp="f.vote_disp4"]  [emb exp="f.vote_disp5"][p]
[_tb_end_text]

[jump  storage="vote.ks"  target="*reset"  cond="f.revote==1"  ]
[jump  storage="vote.ks"  target="*no_kill"  cond="f.revote==2"  ]
[iscript]
var names=["真経津","獅子神","村雨","叶","天堂"];
f.name=names[parseInt(f.result)-1];
[endscript]

[tb_start_text mode=1 ]
投票の結果、[emb exp="f.name"]の処刑が決まりました。[p]
[_tb_end_text]

[tb_eval  exp="f.jump='vote'"  name="jump"  cmd="="  op="t"  val="vote"  val_2="undefined"  ]
[jump  storage="mafutsu.ks"  target="*death"  cond="f.result==1"  ]
[jump  storage="sisigami.ks"  target="*death"  cond="f.result==2"  ]
[jump  storage="murasame.ks"  target="*death"  cond="f.result==3"  ]
[jump  storage="kano.ks"  target="*death"  cond="f.result==4"  ]
[jump  storage="tendo.ks"  target="*death"  cond="f.result==5"  ]
*reset

[tb_start_text mode=1 ]
#システム
同票だったので、再投票します。(AIは同票キャラにしか投票しなくなります)[p]
[_tb_end_text]

[jump  storage="vote.ks"  target="*vote_ai"  cond="f.player_death==1"  ]
[jump  storage="vote.ks"  target="*player_vote"  ]
*no_kill

[tb_start_text mode=1 ]
#システム
再び同票だったので処刑無しで進みます。[p]
[_tb_end_text]

[jump  storage="night.ks"  target="*night"  ]
