forward
global type w_saldo_partite from w_pop
end type
end forward

global type w_saldo_partite from w_pop
integer width = 1211
integer height = 576
end type
global w_saldo_partite w_saldo_partite

on w_saldo_partite.create
call super::create
end on

on w_saldo_partite.destroy
call super::destroy
end on

event open;call super::open;s_saldo_partita s_partita

s_partita=message.powerobjectparm

dw_1.retrieve(s_partita.da_data, s_partita.a_data, s_partita.tipo, s_partita.id_conto)
end event

type dw_1 from w_pop`dw_1 within w_saldo_partite
integer x = 14
integer y = 12
integer width = 1134
string dataobject = "d_vedi_saldi_partite"
end type

