forward
global type w_listini from w_selezione_stampa
end type
end forward

global type w_listini from w_selezione_stampa
integer height = 1060
end type
global w_listini w_listini

event open;call super::open;DataWindowChild dwc_listino, dwc_da_art, dwc_ad_art

integer rtncode


rtncode = dw_1.GetChild('listino', dwc_listino )
rtncode = dw_1.GetChild('da_articolo', dwc_da_art )
rtncode = dw_1.GetChild('ad_articolo', dwc_ad_art )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")


// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_listino.SetTransObject(SQLCA)
dwc_da_art.SetTransObject(SQLCA)
dwc_ad_art.SetTransObject(SQLCA)

// Populate with values for eastern states
dwc_listino.Retrieve()
dwc_da_art.Retrieve()
dwc_ad_art.Retrieve()



dw_1.setitem(1, "tipo_stampa", "d_listini")


end event

on w_listini.create
call super::create
end on

on w_listini.destroy
call super::destroy
end on

type cb_1 from w_selezione_stampa`cb_1 within w_listini
integer y = 700
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_listini
integer y = 708
end type

event cb_stampa::clicked;call super::clicked;dw_1.accepttext()
s_sel_stampa s_selezione

s_selezione.s_id_magazzino= dw_1.getitemnumber(1, "listino")
if s_selezione.s_id_magazzino>0 then
	s_selezione.s_tipo_stampa= dw_1.getitemstring(1, "tipo_stampa")
	s_selezione.da_articolo= dw_1.getitemstring(1, "da_articolo")
	
	s_selezione.ad_articolo= dw_1.getitemstring(1, "ad_articolo")
	
	openwithparm(w_st_listini, s_selezione)
else
	messagebox("Attenzione!", "Indicare il listino da stampare!")
end if

end event

type dw_1 from w_selezione_stampa`dw_1 within w_listini
integer height = 612
string dataobject = "d_listini_sel"
end type

