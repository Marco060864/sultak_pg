forward
global type w_an_conto_cancella from w_semplice_gd
end type
end forward

global type w_an_conto_cancella from w_semplice_gd
integer width = 3840
end type
global w_an_conto_cancella w_an_conto_cancella

on w_an_conto_cancella.create
call super::create
end on

on w_an_conto_cancella.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_an_conto_cancella
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_an_conto_cancella
end type

type cb_primo from w_semplice_gd`cb_primo within w_an_conto_cancella
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_an_conto_cancella
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_an_conto_cancella
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_an_conto_cancella
end type

type dw_1 from w_semplice_gd`dw_1 within w_an_conto_cancella
integer x = 41
integer y = 24
integer width = 3419
string dataobject = "d_cancella_ana_conto"
boolean vscrollbar = true
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_an_conto_cancella
end type

type cb_salva from w_semplice_gd`cb_salva within w_an_conto_cancella
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_an_conto_cancella
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_an_conto_cancella
end type

type cb_ok from w_semplice_gd`cb_ok within w_an_conto_cancella
end type

