[_tb_system_call storage=system/_scene1.ks]

[cm  ]
[bg  storage="93853245_p0.png"  time="1000"  ]
[jump  storage="scene1.ks"  target="*attention"  cond="sf.attention==1"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#初回注意事項
このゲームはファン活動の一環として作られた【非公式】のゲームです。原作者様ならびに各権利者様とは一切関係がございません。[p]
公式に問い合わせたり、二次創作に理解のない方に向けて再配布することはご遠慮ください。[p]
個人制作のフリーゲーム故に小さな不具合等の粗がございます。ご容赦ください。[p]
特に人狼ロジックの抜け漏れは確実にあります。本当にご容赦ください。(報告もらったら対応します)[p]
問題があった場合は即座に公開・配布を停止致しますので、クレジットよりご連絡お願いします。[p]
[_tb_end_text]

[tb_hide_message_window  ]
[tb_eval  exp="sf.attention=1"  name="attention"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
*attention

[jump  storage="start.ks"  target="*start"  ]
