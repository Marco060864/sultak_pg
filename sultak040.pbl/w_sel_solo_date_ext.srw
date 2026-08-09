forward
global type w_sel_solo_date_ext from w_selezione_ext
end type
end forward

global type w_sel_solo_date_ext from w_selezione_ext
integer width = 1362
integer height = 716
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_sel_solo_date_ext w_sel_solo_date_ext

on w_sel_solo_date_ext.create
call super::create
end on

on w_sel_solo_date_ext.destroy
call super::destroy
end on

type cb_1 from w_selezione_ext`cb_1 within w_sel_solo_date_ext
integer x = 64
integer y = 440
end type

type cb_ok from w_selezione_ext`cb_ok within w_sel_solo_date_ext
integer x = 882
integer y = 436
end type

event cb_ok::clicked;call super::clicked;s_sel_stampa st

dw_1.accepttext()
st.s_da_data=dw_1.getitemdate(1, "da_data")
st.s_a_data=dw_1.getitemdate(1, "a_data")

closewithreturn(parent, st)
end event

type dw_1 from w_selezione_ext`dw_1 within w_sel_solo_date_ext
integer width = 1216
integer height = 332
string dataobject = "d_sel_solo_date"
end type

