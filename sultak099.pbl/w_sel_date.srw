forward
global type w_sel_date from w_selezione_stampa
end type
end forward

global type w_sel_date from w_selezione_stampa
integer width = 1477
integer height = 876
end type
global w_sel_date w_sel_date

on w_sel_date.create
call super::create
end on

on w_sel_date.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.setitem(1, "da_data", relativedate(date(today()), -30))
end event

type cb_1 from w_selezione_stampa`cb_1 within w_sel_date
integer x = 64
integer y = 556
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_sel_date
integer x = 923
integer y = 556
end type

event cb_stampa::clicked;call super::clicked;s_sel_stampa sl_stampa

dw_1.accepttext()
sl_stampa.s_da_data=dw_1.getitemdate(1, "da_data")
sl_stampa.s_a_data=dw_1.getitemdate(1, "a_data")
sl_stampa.s_id_magazzino=dw_1.getitemnumber(1, "ddt_come_ia")
openwithparm(w_st_saldo_iva, sl_stampa)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_sel_date
integer width = 1262
integer height = 432
string dataobject = "d_sel_date_2"
end type

