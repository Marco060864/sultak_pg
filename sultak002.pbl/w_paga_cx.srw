forward
global type w_paga_cx from w_padre_figlio_cx
end type
end forward

global type w_paga_cx from w_padre_figlio_cx
integer width = 3927
integer height = 1900
string title = "Condizioni di Pagamento"
boolean maxbox = false
boolean resizable = false
end type
global w_paga_cx w_paga_cx

on w_paga_cx.create
call super::create
end on

on w_paga_cx.destroy
call super::destroy
end on

type cb_ricerca from w_padre_figlio_cx`cb_ricerca within w_paga_cx
boolean visible = false
integer x = 951
integer y = 1604
end type

type dw_1 from w_padre_figlio_cx`dw_1 within w_paga_cx
integer x = 37
integer y = 32
integer width = 3813
integer height = 1260
string dataobject = "d_paga_gd"
boolean vscrollbar = true
end type

type dw_2 from w_padre_figlio_cx`dw_2 within w_paga_cx
integer x = 37
integer y = 1320
integer width = 2926
integer height = 248
string dataobject = "d_rpaga_gd"
end type

type cb_inserisci from w_padre_figlio_cx`cb_inserisci within w_paga_cx
integer y = 1604
end type

type cb_salva from w_padre_figlio_cx`cb_salva within w_paga_cx
integer y = 1604
end type

type cb_cancella from w_padre_figlio_cx`cb_cancella within w_paga_cx
integer y = 1604
end type

type cb_annulla from w_padre_figlio_cx`cb_annulla within w_paga_cx
integer x = 2158
integer y = 1604
end type

type cb_ok from w_padre_figlio_cx`cb_ok within w_paga_cx
integer x = 2450
integer y = 1604
end type

