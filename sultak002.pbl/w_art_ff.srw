forward
global type w_art_ff from w_semplice_gd
end type
end forward

global type w_art_ff from w_semplice_gd
integer width = 2935
end type
global w_art_ff w_art_ff

on w_art_ff.create
call super::create
end on

on w_art_ff.destroy
call super::destroy
end on

type cb_ricerca from w_semplice_gd`cb_ricerca within w_art_ff
end type

event cb_ricerca::clicked;s_ricerca s_ric
w_new_ricerca_sw w_ric_sw

s_ric.dataobject='d_art_gd'
s_ric.titolo_finestra="Ricerca Articolo"

openwithparm(w_ric_sw, s_ric)

Super::EVENT Clicked()
end event

type cb_primo from w_semplice_gd`cb_primo within w_art_ff
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_art_ff
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_art_ff
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_art_ff
end type

type dw_1 from w_semplice_gd`dw_1 within w_art_ff
integer width = 2830
string dataobject = "d_art_ff"
boolean livescroll = false
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_art_ff
end type

type cb_salva from w_semplice_gd`cb_salva within w_art_ff
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_art_ff
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_art_ff
end type

type cb_ok from w_semplice_gd`cb_ok within w_art_ff
end type

