forward
global type w_ass_col_iva_taglia_gd from w_semplice_gd
end type
end forward

global type w_ass_col_iva_taglia_gd from w_semplice_gd
integer width = 3378
end type
global w_ass_col_iva_taglia_gd w_ass_col_iva_taglia_gd

on w_ass_col_iva_taglia_gd.create
call super::create
end on

on w_ass_col_iva_taglia_gd.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_ass_col_iva_taglia_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_ass_col_iva_taglia_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_ass_col_iva_taglia_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_ass_col_iva_taglia_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_ass_col_iva_taglia_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_ass_col_iva_taglia_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_ass_col_iva_taglia_gd
integer width = 3259
string dataobject = "d_ass_colore_iva_taglia_gd"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_ass_col_iva_taglia_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_ass_col_iva_taglia_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_ass_col_iva_taglia_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_ass_col_iva_taglia_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_ass_col_iva_taglia_gd
end type

