forward
global type w_punti_presentante_sel from w_selezione_stampa
end type
type st_1 from statictext within w_punti_presentante_sel
end type
end forward

global type w_punti_presentante_sel from w_selezione_stampa
integer width = 1760
integer height = 1116
st_1 st_1
end type
global w_punti_presentante_sel w_punti_presentante_sel

on w_punti_presentante_sel.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_punti_presentante_sel.destroy
call super::destroy
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;date ldt_da_data
integer rtncode

datawindowchild ldw_pres
rtncode = dw_1.GetChild('id_presentante', ldw_pres)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
connect using sqlca;
ldw_pres.settransobject(sqlca)
ldw_pres.retrieve()
dw_1.settransobject(sqlca)
ldt_da_data=dw_1.getitemdate(1, "a_data")
ldt_da_data=relativedate(ldt_da_data, -30)
dw_1.setitem(1, "da_data", ldt_da_data)


end event

type cb_1 from w_selezione_stampa`cb_1 within w_punti_presentante_sel
integer y = 612
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_punti_presentante_sel
integer x = 1253
integer y = 612
end type

event cb_stampa::clicked;call super::clicked;
s_sel_stampa ls_dati
dw_1.accepttext()
ls_dati.id_conto=dw_1.getitemnumber(1, "id_presentante")
ls_dati.s_a_data=dw_1.getitemdate(1, "a_data")
ls_dati.s_da_data=dw_1.getitemdate(1, "da_data")
ls_dati.percentuale=dw_1.getitemdecimal(1, "percentuale")

openwithparm(w_punti_presentante_st, ls_dati)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_punti_presentante_sel
integer width = 1614
integer height = 496
string dataobject = "d_punti_pres_sel"
end type

type st_1 from statictext within w_punti_presentante_sel
integer x = 55
integer y = 756
integer width = 1623
integer height = 216
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ricorda che per poter scalare correttamente i punti scontati ogni conto presentante deve essere associato a se stesso nella tabella lega conto a presentante!"
boolean focusrectangle = false
end type

