[_tb_system_call storage=system/_observe.ks]

*observe

[iscript]
var n=parseInt(f.gamemode);
var op=[70,60,80,85,70,70,70,70,70];
var al=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
var charArr=String(f.character).split(",");
var calmArr=String(f.calm).split(",");
var playerNum=parseInt(f.player);
f.ai_result=0;
f.target=0;
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function isWolfTeam(role){return role<10;}
function setLiar(idx){
var cur=parseInt(lr[idx]);
if(cur===0){lr[idx]="1";}
else if(cur===3){lr[idx]="9";}
// それ以外の値はここでは更新しない
}
function getCalm(i){
var v=parseFloat(calmArr[i-1]);
if(i===6&&al[6]==="1")v*=1.1;
if(i===7&&al[5]==="1")v*=1.1;
if(i===9&&al[7]==="1")v*=1.4;
return v;
}
for(var ob=1;ob<=n;ob++){
if(al[ob-1]==="0")continue;
var pw=op[ob-1];
if(ob===4&&parseInt(f.turn)%3===0&&parseInt(f.turn)!==0){pw=pw*1.5;}
if(ob===6&&al[6]==="1")pw=pw*1.1;
if(ob===7&&al[5]==="1")pw=pw*1.1;
var pl=[];
for(var t=1;t<=n;t++){
if(t===ob)continue;
if(al[t-1]==="0")continue;
var li=gi(ob,t);
var lv=parseInt(lr[li]);
if(lv!==0&&lv!==2)continue;
var pc=getCalm(t)+parseInt(lk[li]);
pl.push({target:t,perceived:pc});
}
pl.sort(function(a,b){return a.perceived-b.perceived;});
var ot=pl.slice(0,2);
var dt=false;
for(var i=0;i<ot.length;i++){
if(dt)break;
var tg=ot[i].target;
var li2=gi(ob,tg);
var df=pw-ot[i].perceived;
if(df<=0){lk[li2]=parseInt(lk[li2])+10;continue;}
var tr=parseInt(charArr[tg-1]);
if(!isWolfTeam(tr)){lk[li2]=parseInt(lk[li2])+10;continue;}
var rt=(df/2+pw/5)/100;
if(Math.random()<rt){
setLiar(li2);
dt=true;
if(ob===playerNum){f.target=tg;f.ai_result=1;}
}else{lk[li2]=parseInt(lk[li2])+10;}
}
}
f.like=lk.join(",");
f.liar=lr.join(",");
[endscript]

[jump  storage="observe.ks"  target="*end"  cond="f.ai_result==0"  ]
[jump  storage="observe.ks"  target="*liar"  ]
*end

[call  storage="system.ks"  target="*liar"  ]
[jump  storage="end.ks"  target="*turn_set"  ]
*liar

[chara_hide_all  time="1000"  wait="true"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[call  storage="mafutsu.ks"  target="*liar"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*liar"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*liar"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*liar"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*liar"  cond="f.player==5"  ]
[call  storage="shigure.ks"  target="*liar"  cond="f.player==6"  ]
[call  storage="yamabuki.ks"  target="*liar"  cond="f.player==7"  ]
[call  storage="gato.ks"  target="*liar"  cond="f.player==8"  ]
[call  storage="urushibara.ks"  target="*liar"  cond="f.player==9"  ]
[jump  storage="observe.ks"  target="*end"  ]
