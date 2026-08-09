forward
global type w_web_categoria from w_semplice_gd
end type
end forward

global type w_web_categoria from w_semplice_gd
integer width = 4023
end type
global w_web_categoria w_web_categoria

on w_web_categoria.create
call super::create
end on

on w_web_categoria.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_web_categoria
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_web_categoria
end type

type cb_primo from w_semplice_gd`cb_primo within w_web_categoria
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_web_categoria
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_web_categoria
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_web_categoria
end type

type dw_1 from w_semplice_gd`dw_1 within w_web_categoria
integer width = 3909
string dataobject = "d_web_categoria"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_web_categoria
end type

type cb_salva from w_semplice_gd`cb_salva within w_web_categoria
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_web_categoria
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_web_categoria
end type

type cb_ok from w_semplice_gd`cb_ok within w_web_categoria
end type

