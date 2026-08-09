forward
global type w_lifo_st from w_selezione_stampa
end type
end forward

global type w_lifo_st from w_selezione_stampa
integer height = 956
end type
global w_lifo_st w_lifo_st

on w_lifo_st.create
call super::create
end on

on w_lifo_st.destroy
call super::destroy
end on

event open;call super::open;DataWindowChild dwc_da_art, dwc_ad_art, dwc_met, dwc_cat_cod

integer rtncode
date ld_data_inizio

rtncode = dw_1.GetChild('da_articolo', dwc_da_art )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('ad_articolo', dwc_ad_art )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('per_metallo', dwc_met )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('per_cat_codifica', dwc_cat_cod )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_da_art.SetTransObject(SQLCA)
dwc_ad_art.SetTransObject(SQLCA)
dwc_met.SetTransObject(SQLCA)
dwc_cat_cod.SetTransObject(SQLCA)
// Populate with values for eastern states
dwc_da_art.Retrieve()
dwc_ad_art.Retrieve()
dwc_met.retrieve()
dwc_cat_cod.retrieve()

ld_data_inizio=date("01-01-"+string(year(today())))

dw_1.setitem(1, "da_data", ld_data_inizio)
end event

type cb_1 from w_selezione_stampa`cb_1 within w_lifo_st
integer y = 648
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_lifo_st
integer x = 1906
integer y = 652
end type

event cb_stampa::clicked;call super::clicked;s_sel_stampa s_stampa

dw_1.accepttext()
s_stampa.s_data_inizio=dw_1.getitemdate(1, "da_data")
s_stampa.s_a_data=dw_1.getitemdate(1, "a_data")

s_stampa.da_articolo=dw_1.getitemstring(1, "da_articolo")
if isnull(s_stampa.da_articolo) then s_stampa.da_articolo=" "
s_stampa.ad_articolo=dw_1.getitemstring(1, "ad_articolo")
if isnull(s_stampa.ad_articolo) then s_stampa.ad_articolo="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
if s_stampa.ad_articolo<s_stampa.da_articolo then 
	messagebox("Attenzione!", "I valori non sono scelti in modo coerente!")
	return
end if
if s_stampa.s_a_data<s_stampa.s_data_inizio then 
	messagebox("Attenzione!", "I valori delle date non sono scelti in modo coerente!")
	return
end if
s_stampa.s_id_metallo=dw_1.getitemnumber(1, "per_metallo")
s_stampa.cat_codifica=dw_1.getitemnumber(1, "per_cat_codifica")
s_stampa.s_evasi_no_tutti=dw_1.getitemstring(1, "no_giacenza0")
openwithparm(w_lifo_rpt, s_stampa)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_lifo_st
integer height = 588
string dataobject = "d_lifo_st"
end type

