forward
global type w_verifica_cod_barre from w_pop
end type
end forward

global type w_verifica_cod_barre from w_pop
integer width = 4105
integer height = 892
end type
global w_verifica_cod_barre w_verifica_cod_barre

on w_verifica_cod_barre.create
call super::create
end on

on w_verifica_cod_barre.destroy
call super::destroy
end on

event open;call super::open;long ll_num_bol

dw_1.settransobject(sqlca)

ll_num_bol=message.doubleparm
if ll_num_bol>0 then
	dw_1.retrieve(ll_num_bol)
end if
end event

type dw_1 from w_pop`dw_1 within w_verifica_cod_barre
integer width = 3890
integer height = 612
string dataobject = "d_rdoc_sh_imp_cod_barre"
end type

