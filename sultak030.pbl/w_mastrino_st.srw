forward
global type w_mastrino_st from w_selezione_stampa
end type
end forward

global type w_mastrino_st from w_selezione_stampa
integer x = 1056
integer y = 484
integer width = 1960
integer height = 877
end type
global w_mastrino_st w_mastrino_st

on w_mastrino_st.create
call super::create
end on

on w_mastrino_st.destroy
call super::destroy
end on

event open;call super::open;date ldt_data
integer rtncode
DataWindowChild dwc_reg_iva


ldt_data=date(year(today()), 1, 1)

dw_1.setitem(1, "da_data", ldt_data)

rtncode = dw_1.GetChild("conto", dwc_reg_iva )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")


CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_reg_iva.SetTransObject(SQLCA)

dwc_reg_iva.Retrieve()
end event

type cb_1 from w_selezione_stampa`cb_1 within w_mastrino_st
integer x = 66
integer y = 557
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_mastrino_st
integer x = 1342
integer y = 557
end type

event cb_stampa::clicked;call super::clicked;s_sel_stampa sl_stampa

dw_1.accepttext()
sl_stampa.s_da_data=dw_1.getitemdate(1, "da_data")
sl_stampa.s_a_data=dw_1.getitemdate(1, "a_data")
sl_stampa.s_cl_fo=dw_1.getitemstring(1, "conto")
openwithparm(w_mastrino_rpt, sl_stampa)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_mastrino_st
integer width = 1675
integer height = 432
string title = "Libro Giornale"
string dataobject = "d_mastrino_sel"
end type

