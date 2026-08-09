forward
global type w_db from w_semplice_gd
end type
end forward

global type w_db from w_semplice_gd
integer width = 2638
integer height = 1348
end type
global w_db w_db

on w_db.create
call super::create
end on

on w_db.destroy
call super::destroy
end on

type cb_ricerca from w_semplice_gd`cb_ricerca within w_db
integer x = 1454
integer y = 988
end type

type cb_primo from w_semplice_gd`cb_primo within w_db
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_db
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_db
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_db
end type

type dw_1 from w_semplice_gd`dw_1 within w_db
integer width = 2528
string dataobject = "d_db"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_db
end type

type cb_salva from w_semplice_gd`cb_salva within w_db
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_db
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_db
end type

type cb_ok from w_semplice_gd`cb_ok within w_db
end type

