forward
global type w_selezione_ext from w_base
end type
type cb_1 from uo_commandbutton within w_selezione_ext
end type
type cb_ok from uo_commandbutton within w_selezione_ext
end type
type dw_1 from udw_000 within w_selezione_ext
end type
end forward

global type w_selezione_ext from w_base
integer width = 2446
integer height = 1200
cb_1 cb_1
cb_ok cb_ok
dw_1 dw_1
end type
global w_selezione_ext w_selezione_ext

on w_selezione_ext.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
end on

on w_selezione_ext.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;

dw_1.insertrow(1)




end event

type cb_1 from uo_commandbutton within w_selezione_ext
string tag = "Chiude senza salvare nulla."
integer x = 105
integer y = 848
integer taborder = 30
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_ok from uo_commandbutton within w_selezione_ext
string tag = "Chiude salvando le modifiche."
integer x = 1915
integer y = 856
integer taborder = 20
string text = "OK"
boolean default = true
end type

event clicked;//
end event

type dw_1 from udw_000 within w_selezione_ext
integer x = 64
integer y = 40
integer width = 2295
integer height = 764
integer taborder = 10
end type

