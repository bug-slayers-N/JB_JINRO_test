[_tb_system_call storage=system/_observe.ks]

*observe

[iscript]
var ca=[parseFloat(f.mafutsu_calm),parseFloat(f.sisigami_calm),parseFloat(f.murasame_calm),parseFloat(f.kano_calm),parseFloat(f.tendo_calm)];
var op=[70,60,80,85,70];
var ro=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
var al=String(f.alive).split(",");
var lk=String(f.like).split(",");
var lr=String(f.liar).split(",");
var playerNum=parseInt(f.player);
f.ai_result=0;
f.target=0;
function gi(a,b){var o=(a-1)*4;var t=[];for(var i=1;i<=5;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
for(var ob=1;ob<=5;ob++){
if(al[ob-1]==="0")continue;
var pw=op[ob-1];
if(ob===4&&parseInt(f.turn)%3===0&&parseInt(f.turn)!==0){pw=pw*1.5;}
var pl=[];
for(var t=1;t<=5;t++){
if(t===ob)continue;
if(al[t-1]==="0")continue;
var li=gi(ob,t);
var lv=parseInt(lr[li]);
if(lv===1||lv===3||lv===4)continue;
var pc=ca[t-1]+parseInt(lk[li]);
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
var tr=ro[tg-1];
if(tr===3||tr===4||tr===5){lk[li2]=parseInt(lk[li2])+10;continue;}
var rt=(df/2+pw/5)/100;
if(Math.random()<rt){
lr[gi(ob,tg)]="1";
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
[jump  storage="observe.ks"  target="*end"  ]
*test

[iscript]
var ca=[f.mafutsu_calm,f.sisigami_calm,f.murasame_calm,f.kano_calm,f.tendo_calm];
var ro=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
var lk=String(f.like).split(",");
var playerNum=parseInt(f.player);
var likeIdx=(playerNum-1)*4;
var targets=[];
for(var i=1;i<=5;i++){if(i!==playerNum)targets.push(i);}
var debugMsg="player="+playerNum+" role="+ro[playerNum-1]+"\n";
for(var t=1;t<=5;t++){
if(t===playerNum)continue;
var idx=(playerNum-1)*4+targets.indexOf(t);
var perceived=ca[t-1]+parseInt(lk[idx]);
debugMsg+="target="+t+" role="+ro[t-1]+" calm="+ca[t-1]+" perceived="+perceived+"\n";
}
debugMsg+="ai_result="+f.ai_result+" f.target="+f.target;
alert(debugMsg);
[endscript]

