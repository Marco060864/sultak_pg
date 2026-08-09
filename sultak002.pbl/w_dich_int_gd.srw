forward
global type w_dich_int_gd from w_semplice_gd
end type
end forward

global type w_dich_int_gd from w_semplice_gd
integer width = 5129
integer height = 1888
end type
global w_dich_int_gd w_dich_int_gd

on w_dich_int_gd.create
call super::create
end on

on w_dich_int_gd.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_dich_int_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_dich_int_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_dich_int_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_dich_int_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_dich_int_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_dich_int_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_dich_int_gd
integer width = 4987
integer height = 1580
string dataobject = "d_dich_intento_gd"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_dich_int_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_dich_int_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_dich_int_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_dich_int_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_dich_int_gd
end type

