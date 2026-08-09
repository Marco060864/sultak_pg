forward
global type w_spesa_ff from w_semplice_gd
end type
end forward

global type w_spesa_ff from w_semplice_gd
integer width = 2350
integer height = 948
end type
global w_spesa_ff w_spesa_ff

on w_spesa_ff.create
call super::create
end on

on w_spesa_ff.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_spesa_ff
integer x = 910
integer y = 700
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_spesa_ff
integer x = 1440
integer y = 700
end type

type cb_primo from w_semplice_gd`cb_primo within w_spesa_ff
integer x = 1746
integer y = 676
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_spesa_ff
integer x = 2162
integer y = 676
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_spesa_ff
integer x = 1906
integer y = 676
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_spesa_ff
integer x = 2034
integer y = 676
end type

type dw_1 from w_semplice_gd`dw_1 within w_spesa_ff
integer width = 2267
integer height = 580
string dataobject = "d_spesa_ff"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_spesa_ff
integer x = 55
integer y = 688
end type

type cb_salva from w_semplice_gd`cb_salva within w_spesa_ff
integer x = 338
integer y = 688
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_spesa_ff
integer x = 626
integer y = 688
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_spesa_ff
integer x = 1728
integer y = 692
end type

type cb_ok from w_semplice_gd`cb_ok within w_spesa_ff
integer x = 2021
integer y = 692
end type

