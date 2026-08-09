forward
global type w_selezione_stampa from w_base
end type
type cb_1 from uo_commandbutton within w_selezione_stampa
end type
type cb_stampa from uo_commandbutton within w_selezione_stampa
end type
type dw_1 from udw_000 within w_selezione_stampa
end type
end forward

global type w_selezione_stampa from w_base
integer width = 2446
integer height = 1200
cb_1 cb_1
cb_stampa cb_stampa
dw_1 dw_1
end type
global w_selezione_stampa w_selezione_stampa

on w_selezione_stampa.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_stampa=create cb_stampa
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_stampa
this.Control[iCurrent+3]=this.dw_1
end on

on w_selezione_stampa.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_stampa)
destroy(this.dw_1)
end on

event open;call super::open;

dw_1.insertrow(1)



end event

type cb_1 from uo_commandbutton within w_selezione_stampa
string tag = "Chiude senza salvare nulla."
integer x = 101
integer y = 848
integer taborder = 30
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_stampa from uo_commandbutton within w_selezione_stampa
string tag = "Chiude salvando le modifiche."
integer x = 1915
integer y = 856
integer taborder = 20
string text = "Stampa"
end type

type dw_1 from udw_000 within w_selezione_stampa
integer x = 64
integer y = 40
integer width = 2295
integer height = 764
integer taborder = 10
end type

