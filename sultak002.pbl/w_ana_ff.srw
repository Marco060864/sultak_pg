forward
global type w_ana_ff from w_semplice_gd
end type
end forward

global type w_ana_ff from w_semplice_gd
integer width = 2373
integer height = 1472
end type
global w_ana_ff w_ana_ff

on w_ana_ff.create
call super::create
end on

on w_ana_ff.destroy
call super::destroy
end on

type cb_primo from w_semplice_gd`cb_primo within w_ana_ff
integer x = 1733
integer y = 1196
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_ana_ff
integer x = 2130
integer y = 1200
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_ana_ff
integer x = 1893
integer y = 1196
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_ana_ff
integer x = 2021
integer y = 1196
end type

type dw_1 from w_semplice_gd`dw_1 within w_ana_ff
integer width = 2254
integer height = 1100
string dataobject = "d_ana_no_arg_ff"
boolean livescroll = false
end type

event dw_1::ue_post_insert;call super::ue_post_insert;long ll_id_val, ll_id_lingua

select val_id
into :ll_id_val
from val_base;

setitem(al_riga, "val_id", ll_id_val)

select lingua_id
into :ll_id_lingua
from val_base;

setitem(al_riga, "lingua_id", ll_id_lingua)
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_ana_ff
integer x = 37
integer y = 1176
end type

type cb_salva from w_semplice_gd`cb_salva within w_ana_ff
integer x = 320
integer y = 1176
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_ana_ff
integer x = 608
integer y = 1176
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_ana_ff
integer x = 1728
integer y = 1172
end type

type cb_ok from w_semplice_gd`cb_ok within w_ana_ff
integer x = 2021
integer y = 1172
end type

