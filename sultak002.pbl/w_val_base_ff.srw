forward
global type w_val_base_ff from w_semplice_gd
end type
type cb_filo_laccio from commandbutton within w_val_base_ff
end type
end forward

global type w_val_base_ff from w_semplice_gd
integer width = 4846
integer height = 2068
boolean resizable = false
cb_filo_laccio cb_filo_laccio
end type
global w_val_base_ff w_val_base_ff

on w_val_base_ff.create
int iCurrent
call super::create
this.cb_filo_laccio=create cb_filo_laccio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_filo_laccio
end on

on w_val_base_ff.destroy
call super::destroy
destroy(this.cb_filo_laccio)
end on

event resize;call super::resize;cb_filo_laccio.y= cb_ricerca.y
cb_filo_laccio.x=cb_ricerca.x  - cb_ricerca.width - 300


end event

type cb_stampa from w_semplice_gd`cb_stampa within w_val_base_ff
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_val_base_ff
end type

type cb_primo from w_semplice_gd`cb_primo within w_val_base_ff
integer x = 306
integer y = 1260
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_val_base_ff
integer x = 718
integer y = 1260
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_val_base_ff
integer x = 462
integer y = 1260
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_val_base_ff
integer x = 590
integer y = 1260
end type

type dw_1 from w_semplice_gd`dw_1 within w_val_base_ff
integer x = 37
integer y = 36
integer width = 4754
integer height = 1616
string dataobject = "d_val_base_ff"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_val_base_ff
integer x = 91
integer y = 1788
end type

type cb_salva from w_semplice_gd`cb_salva within w_val_base_ff
integer x = 375
integer y = 1788
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_val_base_ff
integer x = 663
integer y = 1788
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_val_base_ff
integer x = 1147
integer y = 1788
end type

type cb_ok from w_semplice_gd`cb_ok within w_val_base_ff
integer x = 1440
integer y = 1788
end type

type cb_filo_laccio from commandbutton within w_val_base_ff
integer x = 2107
integer y = 1776
integer width = 439
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "FILO LACCIO"
end type

event clicked;open(w_filo_laccio)
end event

