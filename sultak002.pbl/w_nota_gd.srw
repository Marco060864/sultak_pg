forward
global type w_nota_gd from w_semplice_gd
end type
end forward

global type w_nota_gd from w_semplice_gd
integer width = 2711
string title = "Note"
end type
global w_nota_gd w_nota_gd

on w_nota_gd.create
call super::create
end on

on w_nota_gd.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_nota_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_nota_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_nota_gd
integer x = 2071
integer y = 752
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_nota_gd
integer x = 2487
integer y = 752
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_nota_gd
integer x = 2231
integer y = 752
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_nota_gd
integer x = 2359
integer y = 752
end type

type dw_1 from w_semplice_gd`dw_1 within w_nota_gd
integer width = 2629
integer height = 688
string dataobject = "d_nota_gd"
boolean vscrollbar = true
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_nota_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_nota_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_nota_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_nota_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_nota_gd
end type

