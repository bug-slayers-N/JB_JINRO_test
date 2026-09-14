[_tb_system_call storage=system/_preview.ks ]

[mask time=10]
[tb_show_message_window] 
[mask_off time=10]
*s21

[call  storage="omake.ks"  target="*story_start"  ]
[call  storage="tendo.ks"  target="*show"  ]
[call  storage="tendo.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#天堂
「神は全能だ、愚か者どもを再び導きなおすことも出来る」[p]
[_tb_end_text]

[call  storage="gato.ks"  target="*show2"  ]
[call  storage="gato.ks"  target="*show_normal2"  ]
[call  storage="urushibara.ks"  target="*show2"  ]
[call  storage="urushibara.ks"  target="*show_normal2"  ]
[tb_start_text mode=1 ]
#牙頭・漆原
「……」[p]
#漆原
「うん…さっきの試合はまた世話になってしまったかもしれないね」[p]
#牙頭
「もうオレらの間に懺悔するようなことはねぇだろ」[p]
[_tb_end_text]

[call  storage="tendo.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#天堂
「お前らの間に懺悔すべきことはもうない」[p]
[_tb_end_text]

[call  storage="gato.ks"  target="*show_do"  ]
[tb_start_text mode=1 ]
#牙頭
「ハァ？」[p]
[_tb_end_text]

[call  storage="tendo.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
#天堂
「見つめるべきものもわからんのか」[p]
[_tb_end_text]

[call  storage="urushibara.ks"  target="*show_normal"  ]
[tb_start_text mode=1 ]
#漆原
「そうだね、折角天堂さんは僕達の探し物を見つけてくれたのに、僕達はまたカラス銀行に来た」[p]
「でも本当に今日はがっちゃんとただ遊ぶだけのつもりで来たんだ。その証拠に私服で来ようとしてたしね」[p]
「それに何より、僕達がもう賭博をやるつもりがないのは天堂さんが一番感じたんじゃない？」[p]

[_tb_end_text]

[call  storage="urushibara.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
「ずっと素直だったよね、ね、がっちゃん」[p]
[_tb_end_text]

[call  storage="gato.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#牙頭
「さァな、ただ本気で遊んでたのはガチだぜ」[p]
[_tb_end_text]

[call  storage="tendo.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#天堂
「わかったのなら、よし」[p]
「しかし、礼の1つはあってもいいだろう？」[p]
[_tb_end_text]

[call  storage="gato.ks"  target="*show_normal2"  ]
[tb_start_text mode=1 ]
#牙頭
「結局オレんとこのクーポンがめに来ただけかよ！」[p]

[_tb_end_text]

[call  storage="urushibara.ks"  target="*show_normal2"  ]
[tb_start_text mode=1 ]
#漆原
「もう永久パスを発行しようか…」[p]
[_tb_end_text]

[jump  storage="omake.ks"  target="*story_end2"  ]
