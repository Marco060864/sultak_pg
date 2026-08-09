forward
global type w_sel_partita from w_selezione_stampa
end type
end forward

global type w_sel_partita from w_selezione_stampa
integer width = 1847
integer height = 772
end type
global w_sel_partita w_sel_partita

on w_sel_partita.create
call super::create
end on

on w_sel_partita.destroy
call super::destroy
end on

event open;call super::open;date ldt_data_inizio_saldi, ldt_data_fine
integer rtncode
DataWindowChild dwc_clfo, dwc_met
rtncode = dw_1.GetChild('id_conto', dwc_clfo )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
rtncode = dw_1.GetChild('id_metallo', dwc_met )
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
CONNECT USING SQLCA;
// Set the transaction object for the child
dwc_clfo.SetTransObject(SQLCA)
dwc_met.SetTransObject(SQLCA)
// Populate with values for eastern states
dwc_clfo.Retrieve()
dwc_met.Retrieve()


select data_inizio_saldi into : ldt_data_inizio_saldi from dba.val_base;

if ldt_data_inizio_saldi>date ("1900-01-01") then
	dw_1.setitem(1, "data_inizio_saldi",ldt_data_inizio_saldi )
end if
	

ldt_data_fine=date(string(year(today()))+"/12/31")
dw_1.setitem(1, "data_fine",ldt_data_fine )

dw_1.setitem(1, "id_metallo", 2)
dw_1.setitem(1, "tipo_partita", "CL")
end event

type cb_1 from w_selezione_stampa`cb_1 within w_sel_partita
integer x = 87
integer y = 488
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_sel_partita
integer x = 1307
integer y = 496
end type

event cb_stampa::clicked;call super::clicked;s_partita_oro s_par


s_par.data_inizio_saldi=dw_1.getitemdate(1, "data_inizio_saldi")
if isnull( s_par.data_inizio_saldi) then 
	messagebox("Attenzione!", "La data inizo saldi NON è stata inserita!")
	return
end if
s_par.data_fine=dw_1.getitemdate(1, "data_fine")
if isnull( s_par.data_fine) then 
	messagebox("Attenzione!", "La data fine NON è stata inserita!")
	return
end if
s_par.l_metallo=dw_1.getitemnumber(1, "id_metallo")
if isnull( s_par.l_metallo) then 
	messagebox("Attenzione!", "Il metallo NON è stato inserito!")
	return
end if
s_par.l_conto=dw_1.getitemnumber(1, "id_conto")
if isnull( s_par.l_conto) then 
	messagebox("Attenzione!", "Il conto NON è stato inserito!")
	return
end if
s_par.s_tipo_partita=dw_1.getitemstring(1, "tipo_partita")
if isnull( s_par.s_tipo_partita) then 
	messagebox("Attenzione!", "Il tipo partita NON è stata inserita!")
	return
end if
openwithparm(w_partita_car_scar, s_par)


end event

type dw_1 from w_selezione_stampa`dw_1 within w_sel_partita
integer width = 1669
integer height = 432
string dataobject = "d_sel_st_partite_car_scarico"
end type

