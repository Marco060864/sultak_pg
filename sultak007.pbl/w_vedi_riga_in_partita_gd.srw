forward
global type w_vedi_riga_in_partita_gd from w_semplice_gd
end type
end forward

global type w_vedi_riga_in_partita_gd from w_semplice_gd
integer width = 4631
end type
global w_vedi_riga_in_partita_gd w_vedi_riga_in_partita_gd

on w_vedi_riga_in_partita_gd.create
call super::create
end on

on w_vedi_riga_in_partita_gd.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_vedi_riga_in_partita_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_vedi_riga_in_partita_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_vedi_riga_in_partita_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_vedi_riga_in_partita_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_vedi_riga_in_partita_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_vedi_riga_in_partita_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_vedi_riga_in_partita_gd
integer width = 4489
string dataobject = "d_vedi_riga_partita"
boolean hscrollbar = true
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_vedi_riga_in_partita_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_vedi_riga_in_partita_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_vedi_riga_in_partita_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_vedi_riga_in_partita_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_vedi_riga_in_partita_gd
end type

