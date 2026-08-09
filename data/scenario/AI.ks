[_tb_system_call storage=system/_AI.ks]

*randam_ai

[chara_hide_all  time="1000"  wait="true"  ]
[iscript]
var playerNum = parseInt(f.player);
var n = parseInt(f.gamemode);
var aliveArr = String(f.alive).split(",");
var baseW = [0, 12, 8, 8, 12, 10, 10, 12, 12, 8];
var calmArr = [0].concat(String(f.calm).split(",").map(parseFloat));
function getRole(i){ return parseInt(String(f.character).split(",")[i-1]); }
var cands = [];
for(var i = 1; i <= n; i++){
if(i === playerNum) continue;
if(aliveArr[i-1] === "0") continue;
cands.push(i);
}
var pinchId = -1;
var sorted = cands.slice().sort(function(a,b){ return calmArr[a] - calmArr[b]; });
if(sorted.length >= 2 && calmArr[sorted[1]] - calmArr[sorted[0]] >= 25){
pinchId = sorted[0];
}
var zeros = [];for(var i=0;i<n;i++)zeros.push("0");
var allZero = (String(f.co) === zeros.join(","));
var day = parseInt(f.day);
var coPromote = (day === 1 && parseInt(f.turn) >= 6 && allZero) || (day >= 2);
var mediumPromote = (day >= 2);
var totalW = 0;
var weights = [];
for(var j = 0; j < cands.length; j++){
var c = cands[j];
var mult = 1;
if(c === pinchId) mult = Math.max(mult, 3);
if(coPromote && (getRole(c) <= 10 || (getRole(c) === 11 && mediumPromote))) mult = Math.max(mult, 3);
weights.push(baseW[c] * mult);
totalW += baseW[c] * mult;
}
var r = Math.random() * totalW;
var cum = 0;
f.ai_actor = cands[cands.length - 1];
for(var k = 0; k < cands.length; k++){
cum += weights[k];
if(r < cum){ f.ai_actor = cands[k]; break; }
}
[endscript]

*command

[iscript]
var actor = parseInt(f.ai_actor);
var p = [0, 2, 0, 0, 2, 1, 1, 2, 2, 0][actor];
function getRole(i){ return parseInt(String(f.character).split(",")[i-1]); }
var role = getRole(actor);
var coArr = String(f.co).split(",");
var selfCoed = coArr[actor-1] !== "0";
var coUsed1 = coArr.indexOf("1") !== -1;
var coUsed2 = coArr.indexOf("2") !== -1;
var sayUsed = parseInt(f.say_human) === 1;
var day = parseInt(f.day);
var gamemode9 = parseInt(f.gamemode) === 9;
var coOpenForFake;
if(day === 1){
coOpenForFake = !coUsed1;
}else{
coOpenForFake = gamemode9 ? !(coUsed1 && coUsed2) : !coUsed1;
}
// [疑う, かばう, 人間と言え, CO系, COを求める]
var weightTable = {
wolf: { 2:[5,2,15,2,10], 1:[5,2,10,2,8], 0:[6,4,7,1,10] },
mad:  { 2:[5,2,2,15,2],  1:[5,2,2,8,5],  0:[7,4,1,5,2]  },
seer: { 0:[5,2,7,15,7],  1:[5,2,3,15,8], 2:[5,2,3,15,8] },
vill: [5,2,10,0,15]
};
var w;
if(role <= 5)        w = weightTable.wolf[p];
else if(role === 9)  w = weightTable.mad[p];
else if(role === 10) w = weightTable.seer[p];
else if(role === 11) w = (day === 1) ? weightTable.vill : weightTable.seer[p];
else if(role === 12) w = weightTable.vill;
else if(role >= 15)  w = weightTable.vill;
var cmds = [];
cmds.push([1, w[0]]);
cmds.push([2, w[1]]);
if(!sayUsed)                             cmds.push([4, w[2]]);
if(coOpenForFake && !selfCoed && (role <= 5 || role === 9)) cmds.push([6, w[3]]);
if(!coUsed1 && !selfCoed && role === 10)              cmds.push([5, w[3]]);
if(!coUsed2 && !selfCoed && role === 11)              cmds.push([5, w[3]]);
if(coOpenForFake)                        cmds.push([3, w[4]]);
function pickCmd(cmds){
var total = 0;
for(var j=0;j<cmds.length;j++) total += cmds[j][1];
var r = Math.random()*total, cum = 0;
for(var k=0;k<cmds.length;k++){
cum += cmds[k][1];
if(r < cum) return cmds[k][0];
}
return cmds[cmds.length-1][0];
}
f.jump = pickCmd(cmds);
if(f.jump===5){
if(role===10) f.result=1;
else if(role===11) f.result=2;
}
if(f.jump===6){
var canSeer=!coUsed1;
var canMedium=gamemode9&&day>=2&&!coUsed2;
if(canSeer&&canMedium){
f.result=(Math.random()<0.5)?1:2;
}else if(canSeer){
f.result=1;
}else if(canMedium){
f.result=2;
}
}
[endscript]

[jump  storage="doubt.ks"  target="*doubt_ai"  cond="f.jump==1"  ]
[jump  storage="cover.ks"  target="*cover_ai"  cond="f.jump==2"  ]
[jump  storage="CO.ks"  target="*please_CO"  cond="f.jump==3"  ]
[jump  storage="say_human.ks"  target="*say_human"  cond="f.jump==4"  ]
[jump  storage="CO.ks"  target="*AI_CO"  cond="f.jump==5"  ]
[jump  storage="CO.ks"  target="*AI_CO"  cond="f.jump==6"  ]
*nothing

[jump  storage="AI.ks"  target="*command"  ]
