forward
global type w_attr_art_cx from w_ra_padre_figlio_cx
end type
end forward

global type w_attr_art_cx from w_ra_padre_figlio_cx
integer width = 3008
end type
global w_attr_art_cx w_attr_art_cx

on w_attr_art_cx.create
call super::create
end on

on w_attr_art_cx.destroy
call super::destroy
end on

type cb_ricerca from w_ra_padre_figlio_cx`cb_ricerca within w_attr_art_cx
integer y = 1244
end type

event cb_ricerca::clicked;s_ricerca s_ric
w_new_ricerca_sw w_ric_sw

s_ric.dataobject='d_art_gd'
s_ric.titolo_finestra="Ricerca Articolo"

openwithparm(w_ric_sw, s_ric)

Super::EVENT Clicked()
end event

type dw_1 from w_ra_padre_figlio_cx`dw_1 within w_attr_art_cx
integer width = 2811
string dataobject = "d_art_ff"
end type

type dw_2 from w_ra_padre_figlio_cx`dw_2 within w_attr_art_cx
integer x = 69
integer y = 496
integer width = 2825
integer height = 716
string dataobject = "d_attr_art_gd"
end type

type cb_inserisci from w_ra_padre_figlio_cx`cb_inserisci within w_attr_art_cx
integer y = 1244
end type

type cb_salva from w_ra_padre_figlio_cx`cb_salva within w_attr_art_cx
integer y = 1244
end type

type cb_cancella from w_ra_padre_figlio_cx`cb_cancella within w_attr_art_cx
integer y = 1244
end type

type cb_annulla from w_ra_padre_figlio_cx`cb_annulla within w_attr_art_cx
integer y = 1240
end type

type cb_ok from w_ra_padre_figlio_cx`cb_ok within w_attr_art_cx
integer y = 1244
end type

