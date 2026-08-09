forward
global type w_scegli_data_guida_ext from w_selezione_ext
end type
end forward

global type w_scegli_data_guida_ext from w_selezione_ext
integer width = 1527
integer height = 812
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_scegli_data_guida_ext w_scegli_data_guida_ext

on w_scegli_data_guida_ext.create
call super::create
end on

on w_scegli_data_guida_ext.destroy
call super::destroy
end on

event open;call super::open;long ll_id_guida
DataWindowChild dwc_guida
integer rtncode
date ldt_data,ldt_a_data
string ls_azienda
s_deriva s_der
rtncode = dw_1.GetChild('guida_id', dwc_guida)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child
dwc_guida.SetTransObject(SQLCA)

// Populate with values for eastern states

dwc_guida.Retrieve()

s_der=message.powerobjectparm
ll_id_guida=s_der.s_id_guida
select id_guida_derivata
into :ll_id_guida
from dba.guida_deriva
where id_guida_madre= :ll_id_guida;
if ll_id_guida<=0 or isnull(ll_id_guida) then
	select guida_da_evadere
	into :ll_id_guida
	from dba.val_base
	;
end if
if ll_id_guida>0 then
	dw_1.setitem(1, "guida_id", ll_id_guida)
end if
ldt_a_data=s_der.s_a_data
//ldt_data=dw_1.getitemdate(1, "a_data")
select ese_data_inizio
into :ldt_data
from esercizio
where :ldt_a_data>=ese_data_inizio
and :ldt_a_data<=ese_data_fine
;

if ldt_data>date('1900-01-01') then
	dw_1.setitem(1, "da_data", ldt_data)
end if
dw_1.setitem(1, "a_data", ldt_a_data)
select az_codice
into :ls_azienda
from dba.azienda;
if pos(upper(ls_azienda),'FOMA')>0 then
	dw_1.setitem(1, "evadi_per", "F")
end if
end event

type cb_1 from w_selezione_ext`cb_1 within w_scegli_data_guida_ext
integer x = 110
integer y = 536
end type

type cb_ok from w_selezione_ext`cb_ok within w_scegli_data_guida_ext
integer x = 1033
integer y = 528
end type

event cb_ok::clicked;call super::clicked;s_deriva s_der


dw_1.accepttext()
s_der.s_da_data=dw_1.getitemdate(1, "da_data")
s_der.s_a_data=dw_1.getitemdate(1, "a_data")
s_der.s_id_guida=dw_1.getitemnumber(1, "guida_id")
s_der.s_evadi_per=dw_1.getitemstring(1, "evadi_per")

CloseWithReturn(Parent, s_der)
end event

type dw_1 from w_selezione_ext`dw_1 within w_scegli_data_guida_ext
integer width = 1381
integer height = 416
string dataobject = "d_deriva_data_guida_ext"
end type

