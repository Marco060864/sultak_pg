forward
global type w_sel_visite from w_selezione_stampa
end type
end forward

global type w_sel_visite from w_selezione_stampa
integer height = 844
end type
global w_sel_visite w_sel_visite

event open;call super::open;DataWindowChild dwc_clfo
integer rtncode
date ld_data_inizio
string ls_st_saldi_cl_fo

rtncode = dw_1.GetChild('cl_fo', dwc_clfo )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")


// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_clfo.SetTransObject(SQLCA)

// Populate with values for eastern states
dwc_clfo.Retrieve()


ld_data_inizio=date("01-01-"+string(year(today())))
dw_1.setitem(1, "tipo_stampa", "d_st_scheda_cl_fo")
dw_1.setitem(1, "data_inizio", ld_data_inizio)
dw_1.setitem(1, "da_data",ld_data_inizio)
dw_1.setitem(1, "a_data", today())
dw_1.setitem(1, "riscosso",'T')

//select st_saldi_cl_fo
//into :ls_st_saldi_cl_fo
//from dba.val_base
//;
//if ls_st_saldi_cl_fo>" " then
//	dw_1.post setitem(1, "tipo_stampa", ls_st_saldi_cl_fo)
//else
//	dw_1.post setitem(1, "tipo_stampa", "Base")
//end if


end event

on w_sel_visite.create
call super::create
end on

on w_sel_visite.destroy
call super::destroy
end on

type cb_1 from w_selezione_stampa`cb_1 within w_sel_visite
integer y = 552
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_sel_visite
integer y = 560
end type

event cb_stampa::clicked;call super::clicked;dw_1.accepttext()
s_sel_stampa s_selezione

s_selezione.s_cl_fo=dw_1.getitemstring(1, "cl_fo")
//s_selezione.s_tipo_stampa= dw_1.getitemstring(1, "tipo_stampa")
s_selezione.s_da_data= dw_1.getitemdate(1, "da_data")
s_selezione.s_a_data= dw_1.getitemdate(1, "a_data")
//s_selezione.s_data_inizio=dw_1.getitemdate(1, "data_inizio")

//if dw_1.getitemnumber(1, "per_causale")>0 then
//	s_selezione.s_id_causale[1]=dw_1.getitemnumber(1, "per_causale")
//end if
//s_selezione.da_articolo=dw_1.getitemstring(1, "da_articolo")
//s_selezione.ad_articolo=dw_1.getitemstring(1, "ad_articolo")
s_selezione.s_evasi_no_tutti=dw_1.getitemstring(1, "riscosso")

openwithparm(w_st_visite, s_selezione)


end event

type dw_1 from w_selezione_stampa`dw_1 within w_sel_visite
integer height = 448
string dataobject = "d_sel_visite"
end type

