forward
global type w_filo_laccio from w_semplice_gd
end type
end forward

global type w_filo_laccio from w_semplice_gd
integer width = 2432
end type
global w_filo_laccio w_filo_laccio

on w_filo_laccio.create
call super::create
end on

on w_filo_laccio.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_filo_laccio
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_filo_laccio
end type

type cb_primo from w_semplice_gd`cb_primo within w_filo_laccio
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_filo_laccio
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_filo_laccio
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_filo_laccio
end type

type dw_1 from w_semplice_gd`dw_1 within w_filo_laccio
string dataobject = "d_filo_laccio"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_filo_laccio
end type

type cb_salva from w_semplice_gd`cb_salva within w_filo_laccio
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_filo_laccio
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_filo_laccio
end type

type cb_ok from w_semplice_gd`cb_ok within w_filo_laccio
end type

