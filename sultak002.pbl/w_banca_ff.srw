forward
global type w_banca_ff from w_semplice_gd
end type
end forward

global type w_banca_ff from w_semplice_gd
integer width = 2542
end type
global w_banca_ff w_banca_ff

on w_banca_ff.create
call super::create
end on

on w_banca_ff.destroy
call super::destroy
end on

type cb_primo from w_semplice_gd`cb_primo within w_banca_ff
integer x = 978
integer y = 952
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_banca_ff
integer x = 1394
integer y = 952
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_banca_ff
integer x = 1138
integer y = 952
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_banca_ff
integer x = 1266
integer y = 952
end type

type dw_1 from w_semplice_gd`dw_1 within w_banca_ff
integer width = 2409
integer height = 864
string dataobject = "d_banca_ff"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_banca_ff
integer x = 50
integer y = 936
end type

type cb_salva from w_semplice_gd`cb_salva within w_banca_ff
integer x = 334
integer y = 936
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_banca_ff
integer x = 622
integer y = 936
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_banca_ff
integer x = 1879
integer y = 924
end type

type cb_ok from w_semplice_gd`cb_ok within w_banca_ff
integer x = 2171
integer y = 924
end type

