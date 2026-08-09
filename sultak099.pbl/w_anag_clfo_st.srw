forward
global type w_anag_clfo_st from w_selezione_stampa
end type
end forward

global type w_anag_clfo_st from w_selezione_stampa
integer height = 1060
end type
global w_anag_clfo_st w_anag_clfo_st

on w_anag_clfo_st.create
call super::create
end on

on w_anag_clfo_st.destroy
call super::destroy
end on

event open;call super::open;DataWindowChild dwc_da_art, dwc_ad_art

integer rtncode
date ld_data_inizio

rtncode = dw_1.GetChild('da_soggetto', dwc_da_art )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('a_soggetto', dwc_ad_art )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_da_art.SetTransObject(SQLCA)
dwc_ad_art.SetTransObject(SQLCA)
// Populate with values for eastern states
dwc_da_art.Retrieve()
dwc_ad_art.Retrieve()
dwc_da_art.setsort("ana_ana_rag_sociale")
dwc_ad_art.setsort("ana_ana_rag_sociale")
dwc_da_art.sort()
dwc_ad_art.sort()
end event

type cb_1 from w_selezione_stampa`cb_1 within w_anag_clfo_st
integer x = 96
integer y = 760
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_anag_clfo_st
integer x = 1911
integer y = 768
end type

event cb_stampa::clicked;call super::clicked;s_sel_stampa s_stampa

s_stampa.da_articolo=dw_1.getitemstring(1, "da_soggetto")
if isnull(s_stampa.da_articolo) then s_stampa.da_articolo=" "
s_stampa.ad_articolo=dw_1.getitemstring(1, "a_soggetto")
if isnull(s_stampa.ad_articolo) then s_stampa.ad_articolo="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
if s_stampa.ad_articolo<s_stampa.da_articolo then 
	messagebox("Attenzione!", "I valori non sono scelti in modo coerente!")
	return
end if
s_stampa.s_tipo_stampa=dw_1.getitemstring(1, "filtro")
openwithparm(w_anag_clfo, s_stampa)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_anag_clfo_st
integer height = 552
string dataobject = "d_scegli_anagrafica"
end type

