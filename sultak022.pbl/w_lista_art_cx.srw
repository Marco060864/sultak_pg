forward
global type w_lista_art_cx from w_padre_figlio_cx
end type
end forward

global type w_lista_art_cx from w_padre_figlio_cx
integer width = 2816
end type
global w_lista_art_cx w_lista_art_cx

on w_lista_art_cx.create
call super::create
end on

on w_lista_art_cx.destroy
call super::destroy
end on

event resize;call super::resize;dw_2.height=newheight - 320
dw_1.height=dw_2.height
dw_1.width=(newwidth - 150)/2
dw_2.width=(newwidth - 150)/2
dw_2.x=dw_1.x + dw_1.width +50
end event

type cb_ricerca from w_padre_figlio_cx`cb_ricerca within w_lista_art_cx
end type

type dw_1 from w_padre_figlio_cx`dw_1 within w_lista_art_cx
integer x = 37
integer width = 1390
string dataobject = "d_lista_art"
end type

type dw_2 from w_padre_figlio_cx`dw_2 within w_lista_art_cx
integer x = 1445
integer y = 48
integer width = 1298
integer height = 972
string dataobject = "d_lista_art_figlio"
end type

type cb_inserisci from w_padre_figlio_cx`cb_inserisci within w_lista_art_cx
end type

type cb_salva from w_padre_figlio_cx`cb_salva within w_lista_art_cx
end type

type cb_cancella from w_padre_figlio_cx`cb_cancella within w_lista_art_cx
end type

type cb_annulla from w_padre_figlio_cx`cb_annulla within w_lista_art_cx
end type

type cb_ok from w_padre_figlio_cx`cb_ok within w_lista_art_cx
end type

