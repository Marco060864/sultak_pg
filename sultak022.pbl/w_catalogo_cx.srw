forward
global type w_catalogo_cx from w_padre_figlio_cx
end type
end forward

global type w_catalogo_cx from w_padre_figlio_cx
integer width = 5339
integer height = 2192
end type
global w_catalogo_cx w_catalogo_cx

on w_catalogo_cx.create
call super::create
end on

on w_catalogo_cx.destroy
call super::destroy
end on

type cb_ricerca from w_padre_figlio_cx`cb_ricerca within w_catalogo_cx
integer x = 1742
integer y = 1896
end type

type dw_1 from w_padre_figlio_cx`dw_1 within w_catalogo_cx
integer y = 32
integer height = 452
string dataobject = "d_catalogo_gd"
end type

type dw_2 from w_padre_figlio_cx`dw_2 within w_catalogo_cx
integer width = 5175
integer height = 1420
string dataobject = "d_ra_riga_catalogo_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_2::itemchanged;call super::itemchanged;long ll_id_art

choose case dwo.name
	case "cat_art_codice"
		select art_id
		into :ll_id_art
		from dba.art
		where art_codice=:data
		;
		setitem(row, "cat_art_id", ll_id_art)
end choose
		
end event

type cb_inserisci from w_padre_figlio_cx`cb_inserisci within w_catalogo_cx
integer x = 864
integer y = 1896
end type

type cb_salva from w_padre_figlio_cx`cb_salva within w_catalogo_cx
integer x = 1152
integer y = 1896
end type

type cb_cancella from w_padre_figlio_cx`cb_cancella within w_catalogo_cx
integer x = 1440
integer y = 1896
end type

type cb_annulla from w_padre_figlio_cx`cb_annulla within w_catalogo_cx
integer x = 2034
integer y = 1892
end type

type cb_ok from w_padre_figlio_cx`cb_ok within w_catalogo_cx
integer x = 2331
integer y = 1896
end type

