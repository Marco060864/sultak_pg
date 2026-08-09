forward
global type w_ese_gd from w_semplice_gd
end type
end forward

global type w_ese_gd from w_semplice_gd
integer width = 2263
integer height = 1244
end type
global w_ese_gd w_ese_gd

on w_ese_gd.create
call super::create
end on

on w_ese_gd.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_ese_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_ese_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_ese_gd
integer x = 919
integer y = 624
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_ese_gd
integer x = 1335
integer y = 624
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_ese_gd
integer x = 1079
integer y = 624
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_ese_gd
integer x = 1207
integer y = 624
end type

type dw_1 from w_semplice_gd`dw_1 within w_ese_gd
integer width = 2085
integer height = 912
string dataobject = "d_esercizio_gd"
boolean vscrollbar = true
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_ese_gd
integer x = 37
end type

type cb_salva from w_semplice_gd`cb_salva within w_ese_gd
integer x = 320
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_ese_gd
integer x = 608
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_ese_gd
integer x = 1568
end type

type cb_ok from w_semplice_gd`cb_ok within w_ese_gd
integer x = 1861
end type

