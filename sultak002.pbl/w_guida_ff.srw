forward
global type w_guida_ff from w_semplice_gd
end type
end forward

global type w_guida_ff from w_semplice_gd
integer width = 2821
integer height = 1728
end type
global w_guida_ff w_guida_ff

on w_guida_ff.create
call super::create
end on

on w_guida_ff.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_guida_ff
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_guida_ff
end type

type cb_primo from w_semplice_gd`cb_primo within w_guida_ff
integer x = 1166
integer y = 852
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_guida_ff
integer x = 1582
integer y = 852
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_guida_ff
boolean visible = true
integer x = 1463
integer y = 852
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_guida_ff
boolean visible = true
integer x = 1591
integer y = 852
end type

type dw_1 from w_semplice_gd`dw_1 within w_guida_ff
integer width = 2235
integer height = 800
string dataobject = "d_guida_ff"
boolean livescroll = false
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_guida_ff
integer y = 840
end type

type cb_salva from w_semplice_gd`cb_salva within w_guida_ff
integer y = 840
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_guida_ff
integer y = 840
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_guida_ff
integer x = 1714
integer y = 840
end type

type cb_ok from w_semplice_gd`cb_ok within w_guida_ff
integer x = 2007
integer y = 840
end type

