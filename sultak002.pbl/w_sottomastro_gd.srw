forward
global type w_sottomastro_gd from w_semplice_gd
end type
end forward

global type w_sottomastro_gd from w_semplice_gd
integer width = 3003
end type
global w_sottomastro_gd w_sottomastro_gd

on w_sottomastro_gd.create
call super::create
end on

on w_sottomastro_gd.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_sottomastro_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_sottomastro_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_sottomastro_gd
integer x = 1737
integer y = 760
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_sottomastro_gd
integer x = 2153
integer y = 760
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_sottomastro_gd
integer x = 1897
integer y = 760
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_sottomastro_gd
integer x = 2025
integer y = 760
end type

type dw_1 from w_semplice_gd`dw_1 within w_sottomastro_gd
integer width = 2880
integer height = 700
string title = "Sottomastri"
string dataobject = "d_sottomastro_gd"
boolean vscrollbar = true
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_sottomastro_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_sottomastro_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_sottomastro_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_sottomastro_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_sottomastro_gd
end type

