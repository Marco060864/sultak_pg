forward
global type w_causale_ff from w_semplice_gd
end type
end forward

global type w_causale_ff from w_semplice_gd
integer width = 2418
integer height = 1112
end type
global w_causale_ff w_causale_ff

on w_causale_ff.create
call super::create
end on

on w_causale_ff.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_causale_ff
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_causale_ff
end type

type cb_primo from w_semplice_gd`cb_primo within w_causale_ff
integer x = 1129
integer y = 900
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_causale_ff
integer x = 1545
integer y = 900
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_causale_ff
integer x = 1289
integer y = 900
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_causale_ff
integer x = 1417
integer y = 900
end type

type dw_1 from w_semplice_gd`dw_1 within w_causale_ff
integer height = 788
string dataobject = "d_causali_ff"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_causale_ff
integer y = 784
end type

type cb_salva from w_semplice_gd`cb_salva within w_causale_ff
integer y = 784
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_causale_ff
integer y = 784
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_causale_ff
integer y = 784
end type

type cb_ok from w_semplice_gd`cb_ok within w_causale_ff
integer y = 784
end type

