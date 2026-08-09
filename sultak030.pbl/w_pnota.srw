forward
global type w_pnota from w_semplice_cx
end type
type cb_stampa1 from commandbutton within w_pnota
end type
type cbx_sblocca from checkbox within w_pnota
end type
type cb_importa from commandbutton within w_pnota
end type
type dw_2 from udw_001 within w_pnota
end type
type cbx_fissa_data from checkbox within w_pnota
end type
end forward

global type w_pnota from w_semplice_cx
integer width = 3534
integer height = 1560
string title = "Prima Nota"
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
cb_stampa1 cb_stampa1
cbx_sblocca cbx_sblocca
cb_importa cb_importa
dw_2 dw_2
cbx_fissa_data cbx_fissa_data
end type
global w_pnota w_pnota

on w_pnota.create
int iCurrent
call super::create
this.cb_stampa1=create cb_stampa1
this.cbx_sblocca=create cbx_sblocca
this.cb_importa=create cb_importa
this.dw_2=create dw_2
this.cbx_fissa_data=create cbx_fissa_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stampa1
this.Control[iCurrent+2]=this.cbx_sblocca
this.Control[iCurrent+3]=this.cb_importa
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cbx_fissa_data
end on

on w_pnota.destroy
call super::destroy
destroy(this.cb_stampa1)
destroy(this.cbx_sblocca)
destroy(this.cb_importa)
destroy(this.dw_2)
destroy(this.cbx_fissa_data)
end on

event open;call super::open;dw_1.retrieve()
DW_1.OBJECT.DATA_GIORNO.TEXT=STRING(TODAY())
dw_2.INSERTROW(1)
end event

event resize;call super::resize;cb_stampa1.x=cb_ricerca.x - 350
cb_stampa1.y=cb_ricerca.y

cbx_sblocca.y=cb_stampa1.y + 120
cbx_sblocca.x=cb_ricerca.x 
cb_importa.x=dw_1.x+dw_1.width - cb_importa.width
cb_importa.y=cb_ok.y 

DW_2.X=CB_CANCELLA.X+ CB_CANCELLA.width+100
DW_2.Y=CB_CANCELLA.Y

cbx_fissa_data.y=cbx_sblocca.y - 100
cbx_fissa_data.x=cbx_sblocca.x

end event

type cb_stampa from w_semplice_cx`cb_stampa within w_pnota
boolean visible = false
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_pnota
boolean visible = false
end type

type cb_primo from w_semplice_cx`cb_primo within w_pnota
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_pnota
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_pnota
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_pnota
end type

type dw_1 from w_semplice_cx`dw_1 within w_pnota
integer width = 3410
string dataobject = "d_pnota_tb"
end type

event dw_1::ue_post_insert;call super::ue_post_insert;long ll_max_prog
date ldt_data

if al_riga>1 then
	ll_max_prog=getitemnumber(1, "c_max_prog")
	setitem(al_riga, "num_prog", ll_max_prog+1)
ELSE
	setitem(al_riga, "num_prog", 1)
END IF

if cbx_fissa_data.checked and al_riga>1 then
	ldt_data=getitemdate(al_riga - 1, "data_doc")
	setitem(al_riga, "data_doc", ldt_data)
	setcolumn("descrizione")
else
	setcolumn("data_doc")
end if



end event

event dw_1::itemchanged;call super::itemchanged;string ls_flag

ls_flag=getitemstring(row, "importata")
if ls_flag='S' and not(cbx_sblocca.checked) then
	return 2
end if
end event

event dw_1::rbuttondown;str_calendar str_data
if dwo.name="data_giorno" then
	open(w_calendario)
	if isvalid(message.PowerObjectParm) then
	str_data=message.PowerObjectParm
	
		dw_1.OBJECT.data_giorno.TEXT=STRING(str_data.data)
	end if
end if
dw_1.reselectrow(1)
end event

type cb_inserisci from w_semplice_cx`cb_inserisci within w_pnota
integer y = 988
end type

type cb_salva from w_semplice_cx`cb_salva within w_pnota
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_pnota
end type

event cb_cancella::clicked;string ls_flag
ls_flag=dw_1.getitemstring(dw_1.getrow(), "importata")
if ls_flag='S' and not(cbx_sblocca.checked) then
	return 2
else
	call super::clicked
end if
end event

type cb_annulla from w_semplice_cx`cb_annulla within w_pnota
boolean visible = false
end type

type cb_ok from w_semplice_cx`cb_ok within w_pnota
boolean visible = false
end type

type cb_stampa1 from commandbutton within w_pnota
integer x = 2427
integer y = 988
integer width = 261
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;DATE LDT_A_DATA, LDT_DA_DATA
integer li_test



dw_1.accepttext()
dw_2.accepttext()

dw_1.trigger event ue_update()

LDT_DA_DATA=DW_2.GETITEMDATE(1, "DA_DATA")
LDT_A_DATA=DW_2.GETITEMDATE(1, "A_DATA")

DW_1.SETFILTER("DATA_DOC>= DATE('"+STRING(LDT_DA_DATA)+"') AND DATA_DOC<=DATE('"+STRING(LDT_A_DATA)+"')")
DW_1.FILTER()
openwithparm(w_pnota_st, dw_1)
DW_1.SETFILTER("")
DW_1.FILTER()
end event

type cbx_sblocca from checkbox within w_pnota
integer x = 1509
integer y = 1132
integer width = 562
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sblocca Importate"
end type

type cb_importa from commandbutton within w_pnota
integer x = 2725
integer y = 980
integer width = 517
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importa"
end type

event clicked;if text='Importa' then
	text='Aggiorna'
	open (w_recupera_dati)
	
//	run("abicimport.exe")
else
	text='Importa'
	dw_1.retrieve()
end if
end event

type dw_2 from udw_001 within w_pnota
integer x = 919
integer y = 968
integer width = 704
integer height = 192
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_seldate"
end type

event rbuttondown;call super::rbuttondown;str_calendar str_data
if dwo.name="da_data" or dwo.name="a_data" then
	open(w_calendario)
	if isvalid(message.PowerObjectParm) then
	str_data=message.PowerObjectParm
	
		setitem(1, string(dwo.name), str_data.data)
	end if
end if
end event

type cbx_fissa_data from checkbox within w_pnota
integer x = 1509
integer y = 1240
integer width = 562
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fissa Data Doc."
end type

event clicked;setfocus(dw_1)
end event

