forward
global type w_art_foto_gd from w_semplice_gd
end type
end forward

global type w_art_foto_gd from w_semplice_gd
integer width = 2318
integer height = 1368
end type
global w_art_foto_gd w_art_foto_gd

on w_art_foto_gd.create
call super::create
end on

on w_art_foto_gd.destroy
call super::destroy
end on

type cb_primo from w_semplice_gd`cb_primo within w_art_foto_gd
integer x = 1714
integer y = 1140
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_art_foto_gd
integer x = 2130
integer y = 1140
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_art_foto_gd
integer x = 1874
integer y = 1140
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_art_foto_gd
integer x = 2002
integer y = 1140
end type

type dw_1 from w_semplice_gd`dw_1 within w_art_foto_gd
integer width = 2235
integer height = 1068
string dataobject = "d_art_foto_gd"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_art_foto_gd
integer y = 1124
end type

type cb_salva from w_semplice_gd`cb_salva within w_art_foto_gd
integer y = 1124
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_art_foto_gd
integer y = 1124
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_art_foto_gd
integer y = 1124
end type

type cb_ok from w_semplice_gd`cb_ok within w_art_foto_gd
integer y = 1124
end type

