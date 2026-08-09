forward
global type w_cat_imp_campi_gd from w_semplice_gd
end type
end forward

global type w_cat_imp_campi_gd from w_semplice_gd
end type
global w_cat_imp_campi_gd w_cat_imp_campi_gd

on w_cat_imp_campi_gd.create
call super::create
end on

on w_cat_imp_campi_gd.destroy
call super::destroy
end on

type cb_ricerca from w_semplice_gd`cb_ricerca within w_cat_imp_campi_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_cat_imp_campi_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_cat_imp_campi_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_cat_imp_campi_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_cat_imp_campi_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_cat_imp_campi_gd
integer width = 2629
string dataobject = "d_cat_imp_campi_gd"
end type

event dw_1::ue_post_insert;call super::ue_post_insert;string ls_codice

if al_riga>1 then
	ls_codice=dw_1.getitemstring(al_riga - 1, "codice")
	dw_1.setitem(al_riga, "codice", ls_codice)
end if
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_cat_imp_campi_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_cat_imp_campi_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_cat_imp_campi_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_cat_imp_campi_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_cat_imp_campi_gd
end type

