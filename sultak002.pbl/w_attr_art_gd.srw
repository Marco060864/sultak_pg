forward
global type w_attr_art_gd from w_padre_figlio_cx
end type
end forward

global type w_attr_art_gd from w_padre_figlio_cx
integer width = 3511
integer height = 1924
end type
global w_attr_art_gd w_attr_art_gd

on w_attr_art_gd.create
call super::create
end on

on w_attr_art_gd.destroy
call super::destroy
end on

type cb_ricerca from w_padre_figlio_cx`cb_ricerca within w_attr_art_gd
integer x = 2299
integer y = 1596
end type

type dw_1 from w_padre_figlio_cx`dw_1 within w_attr_art_gd
integer y = 24
integer width = 3369
integer height = 1088
string dataobject = "d_art_gd"
end type

type dw_2 from w_padre_figlio_cx`dw_2 within w_attr_art_gd
integer x = 69
integer y = 1132
integer width = 3365
integer height = 440
string dataobject = "d_attr_art_gd"
end type

type cb_inserisci from w_padre_figlio_cx`cb_inserisci within w_attr_art_gd
integer x = 1422
integer y = 1596
end type

type cb_salva from w_padre_figlio_cx`cb_salva within w_attr_art_gd
integer x = 1710
integer y = 1596
end type

type cb_cancella from w_padre_figlio_cx`cb_cancella within w_attr_art_gd
integer x = 1998
integer y = 1596
end type

type cb_annulla from w_padre_figlio_cx`cb_annulla within w_attr_art_gd
integer x = 2592
integer y = 1592
end type

type cb_ok from w_padre_figlio_cx`cb_ok within w_attr_art_gd
integer x = 2885
integer y = 1596
end type

