forward
global type w_partite_st from w_selezione_stampa
end type
end forward

global type w_partite_st from w_selezione_stampa
integer height = 760
end type
global w_partite_st w_partite_st

event open;call super::open;DataWindowChild dwc_clfo, dwc_ese, dwc_cat_cod, dwc_caus, dwc_da_art, dwc_ad_art

integer rtncode
date ld_data_inizio
string ls_st_saldi_cl_fo

rtncode = dw_1.GetChild('cl_fo', dwc_clfo )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

//rtncode = dw_1.GetChild('id_esercizio', dwc_ese )
//
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
//
//rtncode = dw_1.GetChild('per_cat_codifica', dwc_cat_cod )
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
//rtncode = dw_1.GetChild('per_causale', dwc_caus )
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
//rtncode = dw_1.GetChild('da_articolo', dwc_da_art )
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
//rtncode = dw_1.GetChild('ad_articolo', dwc_ad_art )
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_clfo.SetTransObject(SQLCA)
dwc_ese.SetTransObject(SQLCA)

dwc_da_art.SetTransObject(SQLCA)
dwc_ad_art.SetTransObject(SQLCA)
dwc_cat_cod.SetTransObject(SQLCA)
dwc_caus.SetTransObject(SQLCA)
// Populate with values for eastern states
dwc_clfo.Retrieve()
dwc_ese.Retrieve()

dwc_da_art.Retrieve()
dwc_ad_art.Retrieve()
dwc_caus.Retrieve()
dwc_cat_cod.Retrieve()

ld_data_inizio=date("01-01-"+string(year(today())))
dw_1.setitem(1, "tipo_stampa", "d_st_scheda_cl_fo")
dw_1.setitem(1, "data_inizio", ld_data_inizio)
dw_1.setitem(1, "da_data",ld_data_inizio)
dw_1.setitem(1, "a_data", today())

select st_saldi_cl_fo
into :ls_st_saldi_cl_fo
from dba.val_base
;
if ls_st_saldi_cl_fo>" " then
	dw_1.post setitem(1, "tipo_stampa", ls_st_saldi_cl_fo)
else
	dw_1.post setitem(1, "tipo_stampa", "Base")
end if


end event

on w_partite_st.create
call super::create
end on

on w_partite_st.destroy
call super::destroy
end on

type cb_1 from w_selezione_stampa`cb_1 within w_partite_st
integer y = 468
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_partite_st
integer y = 476
end type

event cb_stampa::clicked;call super::clicked;dw_1.accepttext()
s_sel_stampa s_selezione

s_selezione.id_conto=dw_1.getitemnumber(1, "cl_fo")
s_selezione.s_tipo_stampa= dw_1.getitemstring(1, "tipo_stampa")
s_selezione.s_da_data= dw_1.getitemdate(1, "da_data")
s_selezione.s_a_data= dw_1.getitemdate(1, "a_data")
s_selezione.s_data_inizio=dw_1.getitemdate(1, "data_inizio")

if dw_1.getitemnumber(1, "per_causale")>0 then
	s_selezione.s_id_causale[1]=dw_1.getitemnumber(1, "per_causale")
end if
s_selezione.da_articolo=dw_1.getitemstring(1, "da_articolo")
s_selezione.ad_articolo=dw_1.getitemstring(1, "ad_articolo")
s_selezione.cat_codifica=dw_1.getitemnumber(1, "per_cat_codifica")

openwithparm(w_partite_rpt, s_selezione)


end event

type dw_1 from w_selezione_stampa`dw_1 within w_partite_st
integer height = 392
string dataobject = "d_partite_st"
end type

