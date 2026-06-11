[_tb_system_call storage=system/_title_screen.ks]


;==============================
; タイトル画面
;==============================


[hidemenubutton]

[tb_clear_images]

[tb_keyconfig  flag="0"  ]

;標準のメッセージレイヤを非表示


[tb_ptext_hide  time="0"  ]
[tb_hide_message_window  ]
[mask_off  time="0"  effect="fadeOut"  ]

;タイトル表示


[bg  storage="BG_title.png"  ]
*title

[glink  color="btn_05_red"  text="・はじめから・"  x="330"  y="550"  size="20"  target="*start"  width=""  height=""  _clickable_img=""  ]
[glink  color="btn_05_black"  text="・つづきから・"  x="550"  y="550"  size="20"  target="*load"  width=""  height=""  _clickable_img=""  ]
[glink  color="btn_05_white"  text="・　おまけ　・"  x="770"  y="550"  size="20"  target="*omake_top"  width=""  height=""  _clickable_img=""  storage="omake.ks"  ]
[s  ]

;-------ボタンが押されたときの処理


*start

[showmenubutton]

[cm  ]
[tb_keyconfig  flag="1"  ]
[jump  storage="scene1.ks"  target=""  ]
[s  ]

;--------ロードが押された時の処理


*load

[cm  ]
[showload]

[jump  target="*title"  storage=""  ]
[s  ]
