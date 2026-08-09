forward
global type w_codifica_gd from w_semplice_gd
end type
end forward

global type w_codifica_gd from w_semplice_gd
string title = "Codifiche per Articoli"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
end type
global w_codifica_gd w_codifica_gd

on w_codifica_gd.create
call super::create
end on

on w_codifica_gd.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_codifica_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_codifica_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_codifica_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_codifica_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_codifica_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_codifica_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_codifica_gd
string dataobject = "d_codifica_gd"
boolean vscrollbar = true
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_codifica_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_codifica_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_codifica_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_codifica_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_codifica_gd
end type

