forward
global type w_el_per_localita from w_base
end type
type cb_esci from commandbutton within w_el_per_localita
end type
type dw_2 from udw_002 within w_el_per_localita
end type
type dw_1 from udw_001 within w_el_per_localita
end type
end forward

global type w_el_per_localita from w_base
integer width = 2469
integer height = 1548
cb_esci cb_esci
dw_2 dw_2
dw_1 dw_1
end type
global w_el_per_localita w_el_per_localita

on w_el_per_localita.create
int iCurrent
call super::create
this.cb_esci=create cb_esci
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_esci
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_1
end on

on w_el_per_localita.destroy
call super::destroy
destroy(this.cb_esci)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_1.insertrow(1)
end event

type cb_esci from commandbutton within w_el_per_localita
integer x = 1943
integer y = 1320
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type dw_2 from udw_002 within w_el_per_localita
integer x = 55
integer y = 244
integer width = 2327
integer height = 1036
integer taborder = 20
string dataobject = "d_elenco_soggetti_localita"
end type

type dw_1 from udw_001 within w_el_per_localita
integer x = 421
integer y = 64
integer width = 1385
integer height = 148
string dataobject = "d_scegli_localita"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;string ls_loc

dw_2.retrieve(data)
end event

