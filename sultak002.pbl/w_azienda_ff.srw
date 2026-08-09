forward
global type w_azienda_ff from w_semplice_gd
end type
end forward

global type w_azienda_ff from w_semplice_gd
integer width = 4046
integer height = 1848
string title = "Azienda"
end type
global w_azienda_ff w_azienda_ff

on w_azienda_ff.create
call super::create
end on

on w_azienda_ff.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_azienda_ff
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_azienda_ff
integer x = 1961
integer y = 1588
end type

type cb_primo from w_semplice_gd`cb_primo within w_azienda_ff
integer x = 864
integer y = 1444
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_azienda_ff
integer x = 1280
integer y = 1444
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_azienda_ff
integer x = 1024
integer y = 1444
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_azienda_ff
integer x = 1152
integer y = 1444
end type

type dw_1 from w_semplice_gd`dw_1 within w_azienda_ff
integer y = 24
integer width = 3895
integer height = 1392
string dataobject = "d_azienda_ff"
boolean vscrollbar = false
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_azienda_ff
integer x = 325
integer y = 1572
end type

type cb_salva from w_semplice_gd`cb_salva within w_azienda_ff
integer x = 608
integer y = 1572
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_azienda_ff
integer x = 896
integer y = 1572
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_azienda_ff
integer x = 1381
integer y = 1572
end type

type cb_ok from w_semplice_gd`cb_ok within w_azienda_ff
integer x = 1673
integer y = 1572
end type

