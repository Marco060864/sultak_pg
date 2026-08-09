forward
global type w_scheda_magazzino from w_selezione_stampa
end type
end forward

global type w_scheda_magazzino from w_selezione_stampa
integer width = 2249
integer height = 1328
end type
global w_scheda_magazzino w_scheda_magazzino

event open;call super::open;DataWindowChild dwc_clfo, dwc_ese, dwc_art, dwc_maga, dwc_tit, dwc_met
DataWindowChild dwc_cat_cod, dwc_da_art, dwc_ad_art, dwc_caus

integer rtncode
date ld_data_inizio
string ls_tipo_az

rtncode = dw_1.GetChild('cl_fo', dwc_clfo )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('id_esercizio', dwc_ese )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('per_articolo', dwc_art )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('per_magazzino', dwc_maga )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('per_titolo', dwc_tit )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('per_metallo', dwc_met )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('per_cat_codifica', dwc_cat_cod )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
rtncode = dw_1.GetChild('per_causale', dwc_caus )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
rtncode = dw_1.GetChild('da_articolo', dwc_da_art )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
rtncode = dw_1.GetChild('ad_articolo', dwc_ad_art )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")


// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_clfo.SetTransObject(SQLCA)
dwc_ese.SetTransObject(SQLCA)
dwc_met.SetTransObject(SQLCA)
dwc_tit.SetTransObject(SQLCA)
dwc_maga.SetTransObject(SQLCA)
dwc_art.SetTransObject(SQLCA)

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

dwc_da_art.Retrieve()
dwc_ad_art.Retrieve()
dwc_caus.Retrieve()
dwc_cat_cod.Retrieve()


ld_data_inizio=date("01-01-"+string(year(today())))

select tipo_azienda
into :ls_tipo_az
from dba.val_base;
if ls_tipo_az='N' then //è un negozio ...
dw_1.setitem(1, "tipo_stampa", "d_st_scheda_magazzino_negozio")
else
	dw_1.setitem(1, "tipo_stampa", "d_st_scheda_magazzino")
end if
dw_1.setitem(1, "data_inizio", ld_data_inizio)
dw_1.setitem(1, "da_data",ld_data_inizio)
dw_1.setitem(1, "a_data", today())

end event

on w_scheda_magazzino.create
call super::create
end on

on w_scheda_magazzino.destroy
call super::destroy
end on

type cb_1 from w_selezione_stampa`cb_1 within w_scheda_magazzino
integer y = 1008
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_scheda_magazzino
integer x = 1710
integer y = 1016
end type

event cb_stampa::clicked;call super::clicked;dw_1.accepttext()
s_sel_stampa s_selezione

s_selezione.s_cl_fo=dw_1.getitemstring(1, "cl_fo")
s_selezione.s_tipo_stampa= dw_1.getitemstring(1, "tipo_stampa")
s_selezione.s_da_data= dw_1.getitemdate(1, "da_data")
s_selezione.s_a_data= dw_1.getitemdate(1, "a_data")
s_selezione.s_data_inizio=dw_1.getitemdate(1, "data_inizio")
s_selezione.s_id_magazzino=dw_1.getitemnumber(1, "per_magazzino")
s_selezione.s_id_articolo=dw_1.getitemnumber(1, "per_articolo")
s_selezione.s_id_titolo=dw_1.getitemnumber(1, "per_titolo")
s_selezione.s_id_metallo=dw_1.getitemnumber(1, "per_metallo")

if dw_1.getitemnumber(1, "per_causale")>0 then
	s_selezione.s_id_causale[1]=dw_1.getitemnumber(1, "per_causale")
end if
s_selezione.da_articolo=dw_1.getitemstring(1, "da_articolo")
s_selezione.ad_articolo=dw_1.getitemstring(1, "ad_articolo")
s_selezione.cat_codifica=dw_1.getitemnumber(1, "per_cat_codifica")
s_selezione.fiscale=dw_1.getitemstring(1, "fiscale")

openwithparm(w_st_scheda_magazzino, s_selezione)



end event

type dw_1 from w_selezione_stampa`dw_1 within w_scheda_magazzino
integer width = 2080
integer height = 872
string dataobject = "d_scheda_magazzino"
end type

event dw_1::itemchanged;call super::itemchanged;string ls_cod_art

if dwo.name='da_articolo' then
	ls_cod_art=getitemstring(row, "ad_articolo")
	if data>ls_cod_art then
		messagebox("Errore!", "Articolo di partenza maggiore di quello di fine!")
		return 2
	end if
	
end if
end event

