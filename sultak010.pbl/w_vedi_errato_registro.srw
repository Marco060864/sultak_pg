forward
global type w_vedi_errato_registro from w_semplice_gd
end type
end forward

global type w_vedi_errato_registro from w_semplice_gd
integer width = 3939
end type
global w_vedi_errato_registro w_vedi_errato_registro

on w_vedi_errato_registro.create
call super::create
end on

on w_vedi_errato_registro.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_vedi_errato_registro
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_vedi_errato_registro
end type

type cb_primo from w_semplice_gd`cb_primo within w_vedi_errato_registro
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_vedi_errato_registro
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_vedi_errato_registro
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_vedi_errato_registro
end type

type dw_1 from w_semplice_gd`dw_1 within w_vedi_errato_registro
integer width = 3460
string dataobject = "d_vedi_doc_errato_registro"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_vedi_errato_registro
end type

type cb_salva from w_semplice_gd`cb_salva within w_vedi_errato_registro
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_vedi_errato_registro
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_vedi_errato_registro
end type

type cb_ok from w_semplice_gd`cb_ok within w_vedi_errato_registro
end type

