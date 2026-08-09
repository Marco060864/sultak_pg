forward
global type w_sel_documenti from w_selezione_stampa
end type
end forward

global type w_sel_documenti from w_selezione_stampa
integer width = 2249
integer height = 1256
end type
global w_sel_documenti w_sel_documenti

event open;call super::open;DataWindowChild dwc_clfo, dwc_ese, dwc_art, dwc_maga, dwc_tit, dwc_met
DataWindowChild dwc_reg, dwc_tipo_reg
DataWindowChild dwc_cat_cod, dwc_da_art, dwc_ad_art, dwc_caus
integer rtncode
date ld_data_inizio
long ll_id_ese

rtncode = dw_1.GetChild('cl_fo', dwc_clfo )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('id_esercizio', dwc_ese )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

//rtncode = dw_1.GetChild('per_articolo', dwc_art )
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
//
//rtncode = dw_1.GetChild('per_magazzino', dwc_maga )
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
//
//rtncode = dw_1.GetChild('per_titolo', dwc_tit )
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
//
//rtncode = dw_1.GetChild('per_metallo', dwc_met )
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('id_registro', dwc_reg )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('reg_tipo', dwc_tipo_reg )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")


//rtncode = dw_1.GetChild('per_cat_codifica', dwc_cat_cod )
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
rtncode = dw_1.GetChild('per_causale', dwc_caus )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
//rtncode = dw_1.GetChild('da_articolo', dwc_da_art )
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
//rtncode = dw_1.GetChild('ad_articolo', dwc_ad_art )
//IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_clfo.SetTransObject(SQLCA)
dwc_ese.SetTransObject(SQLCA)
//dwc_met.SetTransObject(SQLCA)
//dwc_tit.SetTransObject(SQLCA)
//dwc_maga.SetTransObject(SQLCA)
//dwc_art.SetTransObject(SQLCA)
dwc_reg.SetTransObject(SQLCA)
dwc_tipo_reg.SetTransObject(SQLCA)


dwc_da_art.SetTransObject(SQLCA)
dwc_ad_art.SetTransObject(SQLCA)
dwc_cat_cod.SetTransObject(SQLCA)
dwc_caus.SetTransObject(SQLCA)
// Populate with values for eastern states
dwc_clfo.Retrieve()
dwc_ese.Retrieve()
dwc_maga.Retrieve()
dwc_art.Retrieve()
dwc_tit.Retrieve()
dwc_met.Retrieve()
dwc_tipo_reg.retrieve()

dwc_da_art.Retrieve()
dwc_ad_art.Retrieve()
dwc_caus.Retrieve()
dwc_cat_cod.Retrieve()

ld_data_inizio=date("01-01-"+string(year(today())))
dw_1.setitem(1, "tipo_stampa", "d_st_documenti")
dw_1.setitem(1, "data_inizio", ld_data_inizio)
dw_1.setitem(1, "da_data", ld_data_inizio)
dw_1.setitem(1, "a_data", today())

select ese_id
into :ll_id_ese
from dba.esercizio
where ese_data_inizio= :ld_data_inizio
;

dwc_reg.retrieve(ll_id_ese)

end event

on w_sel_documenti.create
call super::create
end on

on w_sel_documenti.destroy
call super::destroy
end on

type cb_1 from w_selezione_stampa`cb_1 within w_sel_documenti
integer x = 87
integer y = 940
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_sel_documenti
integer x = 1696
integer y = 948
end type

event cb_stampa::clicked;call super::clicked;dw_1.accepttext()
s_sel_stampa s_selezione

s_selezione.id_conto=dw_1.getitemnumber(1, "id_cl_fo")
s_selezione.s_tipo_stampa= dw_1.getitemstring(1, "tipo_stampa")
s_selezione.s_da_data= dw_1.getitemdate(1, "da_data")
s_selezione.s_a_data= dw_1.getitemdate(1, "a_data")
s_selezione.s_data_inizio=f_trova_inizio_esercizio(s_selezione.s_da_data)
//s_selezione.s_id_magazzino=dw_1.getitemnumber(1, "per_magazzino")
//s_selezione.s_id_articolo=dw_1.getitemnumber(1, "per_articolo")
//s_selezione.s_id_titolo=dw_1.getitemnumber(1, "per_titolo")
//s_selezione.s_id_metallo=dw_1.getitemnumber(1, "per_metallo")
s_selezione.s_id_registro=dw_1.getitemnumber(1, "id_registro")
s_selezione.s_tipo_registro= dw_1.getitemstring(1, "reg_tipo")
s_selezione.s_evasi_no_tutti=dw_1.getitemstring(1, "evasi_no_tutti")

if dw_1.getitemnumber(1, "per_causale")>0 then
	s_selezione.s_id_causale[1]=dw_1.getitemnumber(1, "per_causale")
end if
//s_selezione.da_articolo=dw_1.getitemstring(1, "da_articolo")
//s_selezione.ad_articolo=dw_1.getitemstring(1, "ad_articolo")
//s_selezione.cat_codifica=dw_1.getitemnumber(1, "per_cat_codifica")

openwithparm(w_st_documenti, s_selezione)


end event

type dw_1 from w_selezione_stampa`dw_1 within w_sel_documenti
integer width = 2080
integer height = 840
string dataobject = "d_sel_documenti"
end type

event dw_1::itemchanged;call super::itemchanged;date ld_data_inizio
long ll_id_ese
integer rtncode
datawindowchild dwc_reg

rtncode = dw_1.GetChild('id_registro', dwc_reg )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
dwc_reg.SetTransObject(SQLCA)

if string(dwo.name)="id_esercizio" then
	ld_data_inizio=date(data)
	
	select ese_id
	into :ll_id_ese
	from dba.esercizio
	where ese_data_inizio= :ld_data_inizio
	;
	dwc_reg.retrieve(ll_id_ese)
end if
end event

