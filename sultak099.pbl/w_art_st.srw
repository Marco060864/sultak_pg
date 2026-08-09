forward
global type w_art_st from w_selezione_stampa
end type
end forward

global type w_art_st from w_selezione_stampa
integer width = 2560
integer height = 762
end type
global w_art_st w_art_st

on w_art_st.create
call super::create
end on

on w_art_st.destroy
call super::destroy
end on

event open;call super::open;DataWindowChild dwc_da_art, dwc_ad_art

integer rtncode
date ld_data_inizio

rtncode = dw_1.GetChild('da_articolo', dwc_da_art )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('ad_articolo', dwc_ad_art )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_da_art.SetTransObject(SQLCA)
dwc_ad_art.SetTransObject(SQLCA)
// Populate with values for eastern states
dwc_da_art.Retrieve()
dwc_ad_art.Retrieve()

end event

type cb_1 from w_selezione_stampa`cb_1 within w_art_st
integer y = 442
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_art_st
integer y = 448
end type

event cb_stampa::clicked;call super::clicked;s_sel_stampa s_stampa

dw_1.accepttext()

s_stampa.da_articolo=dw_1.getitemstring(1, "da_articolo")
if isnull(s_stampa.da_articolo) then s_stampa.da_articolo=" "
s_stampa.ad_articolo=dw_1.getitemstring(1, "ad_articolo")
if isnull(s_stampa.ad_articolo) then s_stampa.ad_articolo="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
if s_stampa.ad_articolo<s_stampa.da_articolo then 
	messagebox("Attenzione!", "I valori non sono scelti in modo coerente!")
	return
end if
s_stampa.s_tipo_stampa=dw_1.getitemstring(1, "tipo_stampa")
if isnull(s_stampa.s_tipo_stampa) then
	s_stampa.s_tipo_stampa="LISTA"
end if
s_stampa.s_a_data=dw_1.getitemdate(1, "a_data")
openwithparm(w_art_rpt, s_stampa)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_art_st
integer width = 2377
integer height = 362
string dataobject = "d_art_st"
end type

