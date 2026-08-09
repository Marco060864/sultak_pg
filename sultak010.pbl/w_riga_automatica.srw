forward
global type w_riga_automatica from w_semplice_gd
end type
end forward

global type w_riga_automatica from w_semplice_gd
integer width = 2878
end type
global w_riga_automatica w_riga_automatica

on w_riga_automatica.create
call super::create
end on

on w_riga_automatica.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_riga_automatica
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_riga_automatica
end type

type cb_primo from w_semplice_gd`cb_primo within w_riga_automatica
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_riga_automatica
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_riga_automatica
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_riga_automatica
end type

type dw_1 from w_semplice_gd`dw_1 within w_riga_automatica
integer width = 2732
string title = ""
string dataobject = "d_riga_automatica"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_riga_automatica
end type

type cb_salva from w_semplice_gd`cb_salva within w_riga_automatica
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_riga_automatica
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_riga_automatica
end type

type cb_ok from w_semplice_gd`cb_ok within w_riga_automatica
end type

