forward
global type w_riapri_riga_gd from w_semplice_gd
end type
end forward

global type w_riapri_riga_gd from w_semplice_gd
integer width = 3301
end type
global w_riapri_riga_gd w_riapri_riga_gd

on w_riapri_riga_gd.create
call super::create
end on

on w_riapri_riga_gd.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_riapri_riga_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_riapri_riga_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_riapri_riga_gd
integer x = 997
integer y = 1320
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_riapri_riga_gd
integer x = 1413
integer y = 1320
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_riapri_riga_gd
integer x = 1157
integer y = 1320
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_riapri_riga_gd
integer x = 1285
integer y = 1320
end type

type dw_1 from w_semplice_gd`dw_1 within w_riapri_riga_gd
integer width = 3186
integer height = 1228
string dataobject = "d_riapri_riga_gd"
boolean vscrollbar = true
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_riapri_riga_gd
integer x = 78
integer y = 1304
end type

type cb_salva from w_semplice_gd`cb_salva within w_riapri_riga_gd
integer x = 361
integer y = 1304
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_riapri_riga_gd
integer x = 649
integer y = 1304
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_riapri_riga_gd
integer x = 1751
integer y = 1308
end type

type cb_ok from w_semplice_gd`cb_ok within w_riapri_riga_gd
integer x = 2043
integer y = 1308
end type

