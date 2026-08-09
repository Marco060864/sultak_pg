forward
global type w_reg_iva_st from w_selezione_stampa
end type
end forward

global type w_reg_iva_st from w_selezione_stampa
integer width = 1960
integer height = 877
end type
global w_reg_iva_st w_reg_iva_st

on w_reg_iva_st.create
call super::create
end on

on w_reg_iva_st.destroy
call super::destroy
end on

event open;call super::open;date ldt_data
integer rtncode
DataWindowChild dwc_reg_iva


ldt_data=date(year(today()), 1, 1)

dw_1.setitem(1, "da_data", ldt_data)

rtncode = dw_1.GetChild("id_registro", dwc_reg_iva )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")


CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_reg_iva.SetTransObject(SQLCA)

dwc_reg_iva.Retrieve()
end event

type cb_1 from w_selezione_stampa`cb_1 within w_reg_iva_st
integer x = 66
integer y = 557
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_reg_iva_st
integer x = 1342
integer y = 557
end type

event cb_stampa::clicked;call super::clicked;s_sel_stampa sl_stampa

dw_1.accepttext()
sl_stampa.s_da_data=dw_1.getitemdate(1, "da_data")
sl_stampa.s_a_data=dw_1.getitemdate(1, "a_data")
sl_stampa.s_id_magazzino=dw_1.getitemnumber(1, "id_registro")
openwithparm(w_reg_iva_rpt, sl_stampa)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_reg_iva_st
integer width = 1675
integer height = 432
string dataobject = "d_reg_iva_sel"
end type

