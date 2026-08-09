//objectcomments ricorda che tutte le dw con cui fai le stampe devono avere un campo calcolato "tot_pagine" (nascosto o meno) che rende il numero delle pagine da stampare
forward
global type w_stampa from w_base
end type
type pb_1 from picturebutton within w_stampa
end type
type cb_preview from picturebutton within w_stampa
end type
type dw_1 from udw_stampa within w_stampa
end type
type pb_salva_su_file from picturebutton within w_stampa
end type
type pb_stampa from picturebutton within w_stampa
end type
type sle_pg from singlelineedit within w_stampa
end type
type st_1 from statictext within w_stampa
end type
type st_2 from statictext within w_stampa
end type
type sle_copie from singlelineedit within w_stampa
end type
type sle_zoom from singlelineedit within w_stampa
end type
type cb_7 from uo_commandbutton within w_stampa
end type
type cb_6 from uo_commandbutton within w_stampa
end type
type cb_pg_dopo from uo_commandbutton within w_stampa
end type
type cb_pg_prima from uo_commandbutton within w_stampa
end type
type cb_esci from uo_commandbutton within w_stampa
end type
end forward

global type w_stampa from w_base
integer x = 23
integer y = 12
integer width = 3451
integer height = 1744
windowtype windowtype = popup!
pb_1 pb_1
cb_preview cb_preview
dw_1 dw_1
pb_salva_su_file pb_salva_su_file
pb_stampa pb_stampa
sle_pg sle_pg
st_1 st_1
st_2 st_2
sle_copie sle_copie
sle_zoom sle_zoom
cb_7 cb_7
cb_6 cb_6
cb_pg_dopo cb_pg_dopo
cb_pg_prima cb_pg_prima
cb_esci cb_esci
end type
global w_stampa w_stampa

type variables

integer ii_zoom=100
string is_doc_per_stampa, is_h_footer, is_h2_footer
udw_stampa iudw_corrente
end variables

on w_stampa.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.cb_preview=create cb_preview
this.dw_1=create dw_1
this.pb_salva_su_file=create pb_salva_su_file
this.pb_stampa=create pb_stampa
this.sle_pg=create sle_pg
this.st_1=create st_1
this.st_2=create st_2
this.sle_copie=create sle_copie
this.sle_zoom=create sle_zoom
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_pg_dopo=create cb_pg_dopo
this.cb_pg_prima=create cb_pg_prima
this.cb_esci=create cb_esci
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_preview
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.pb_salva_su_file
this.Control[iCurrent+5]=this.pb_stampa
this.Control[iCurrent+6]=this.sle_pg
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.sle_copie
this.Control[iCurrent+10]=this.sle_zoom
this.Control[iCurrent+11]=this.cb_7
this.Control[iCurrent+12]=this.cb_6
this.Control[iCurrent+13]=this.cb_pg_dopo
this.Control[iCurrent+14]=this.cb_pg_prima
this.Control[iCurrent+15]=this.cb_esci
end on

on w_stampa.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.cb_preview)
destroy(this.dw_1)
destroy(this.pb_salva_su_file)
destroy(this.pb_stampa)
destroy(this.sle_pg)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_copie)
destroy(this.sle_zoom)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_pg_dopo)
destroy(this.cb_pg_prima)
destroy(this.cb_esci)
end on

event resize;call super::resize;iudw_corrente.setredraw(false)
iudw_corrente.height=newheight - 250
iudw_corrente.width=newwidth - 75
iudw_corrente.setredraw(true)
end event

event open;call super::open;
iudw_corrente=dw_1


end event

type pb_1 from picturebutton within w_stampa
string tag = "Imposta la stampante"
integer x = 2519
integer y = 28
integer width = 169
integer height = 124
integer taborder = 23
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Properties!"
alignment htextalign = left!
end type

event clicked;printsetup()
iudw_corrente.object.datawindow.print.preview='yes'
	iudw_corrente.object.datawindow.print.preview.rulers='yes'
end event

type cb_preview from picturebutton within w_stampa
integer x = 1915
integer y = 28
integer width = 169
integer height = 124
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Preview!"
end type

event clicked;if iudw_corrente.object.datawindow.print.preview='no' then
	
	iudw_corrente.object.datawindow.print.preview='yes'
	iudw_corrente.object.datawindow.print.preview.rulers='yes'
else

	iudw_corrente.object.datawindow.print.preview='No'
//	dw_1.object.datawindow.print.preview.rulers='no'
end if
end event

type dw_1 from udw_stampa within w_stampa
integer x = 37
integer y = 172
integer width = 3314
integer height = 1404
integer taborder = 18
boolean hscrollbar = true
boolean vscrollbar = true
end type

event rbuttondown;call super::rbuttondown;string ls_tip
integer li_len

if dwo.type="column" or  dwo.type="rectangle" or dwo.type="text" then
	if len(string(dwo.tag))>2 then
		ls_tip=dwo.name+"|"+dwo.tag
		openwithparm(w_tip, ls_tip)
	end if
end if
end event

event printstart;call super::printstart;integer li_copie
string ls_pg, ls_orienta

li_copie=integer(sle_copie.text)
if isnull(li_copie) or li_copie=0 then li_copie=1
dw_1.Modify("DataWindow.Print.copies = "+string(li_copie))

ls_pg=sle_pg.text
dw_1.Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

type pb_salva_su_file from picturebutton within w_stampa
string tag = "Salva la stampa su file."
integer x = 2322
integer y = 28
integer width = 169
integer height = 124
integer taborder = 12
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom008!"
alignment htextalign = left!
end type

event clicked;iudw_corrente.saveas()
end event

type pb_stampa from picturebutton within w_stampa
string tag = "invia alla stampante."
integer x = 2112
integer y = 28
integer width = 169
integer height = 124
integer taborder = 14
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Print!"
end type

event clicked;string ls_num_doc, ls_data, ls_h_footer
long ll_job
integer li_righe, li_num_copie

//li_num_copie=integer(sle_copie.text)
//if li_num_copie<=0 or isnull(li_num_copie) then li_num_copie=1
//iudw_corrente.Modify("DataWindow.Print.copies = "+ string(li_num_copie))
li_righe=iudw_corrente.rowcount()
if li_righe>0 then
		
		//Scegli stampante
		ls_num_doc=parent.classname()
		IF is_doc_per_stampa>" " then
			ls_num_doc=	is_doc_per_stampa
		else
			ls_data=string(today(), "dd-mm-yy")
			ls_num_doc+="_"+ls_data
		end if
			
		iudw_corrente.Modify("DataWindow.Print.DocumentName='"+ls_num_doc+"'")
		iudw_corrente.print(false, true)
			
	else
		messagebox("Attenzione!", "Non c'è nulla da stampare!")
	end if
end event

type sle_pg from singlelineedit within w_stampa
string tag = "Stampa le pagine indicate: inserire ~",~" per pagine singole e il trattino per stampare da pg. a pg. (es: 1,4,7 stmapa solo le pg. 1,4,7; mentre 1-4 stampa dalla pagina 1 alla pagina 4 comprese)."
integer x = 1440
integer y = 36
integer width = 306
integer height = 92
integer taborder = 9
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type st_1 from statictext within w_stampa
integer x = 1161
integer y = 44
integer width = 283
integer height = 76
integer taborder = 8
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Stampa Pgg."
boolean focusrectangle = false
end type

type st_2 from statictext within w_stampa
boolean visible = false
integer x = 238
integer y = 44
integer width = 151
integer height = 76
integer taborder = 3
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Copie"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_copie from singlelineedit within w_stampa
string tag = "Specifica il numero di copie da stampare."
boolean visible = false
integer x = 398
integer y = 36
integer width = 165
integer height = 92
integer taborder = 4
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type sle_zoom from singlelineedit within w_stampa
string tag = "Valore dello Zoom della pagina (100= reale)."
integer x = 722
integer y = 36
integer width = 146
integer height = 92
integer taborder = 6
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "100"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

event modified;ii_zoom=integer(this.text)
dw_1.object.datawindow.zoom=ii_zoom

end event

type cb_7 from uo_commandbutton within w_stampa
string tag = "Rimpicciolisce la stampa del 5%."
integer x = 585
integer y = 36
integer width = 123
integer height = 92
integer taborder = 5
integer textsize = -8
string text = "Out"
end type

event clicked;ii_zoom=ii_zoom - 5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_6 from uo_commandbutton within w_stampa
string tag = "Ingrandisce la stampa del 5%."
integer x = 878
integer y = 36
integer width = 123
integer height = 92
integer taborder = 7
integer textsize = -8
string text = "In"
end type

event clicked;ii_zoom=ii_zoom+5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_pg_dopo from uo_commandbutton within w_stampa
string tag = "Mostra la pagina successiva."
integer x = 142
integer y = 36
integer width = 96
integer height = 92
integer taborder = 2
integer textsize = -12
string text = ">"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_pg_prima from uo_commandbutton within w_stampa
string tag = "Mostra la pagina precedente."
integer x = 27
integer y = 36
integer width = 96
integer height = 92
integer taborder = 1
integer textsize = -12
string text = "<"
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_esci from uo_commandbutton within w_stampa
string tag = "Chiude la finestra."
integer x = 3040
integer y = 32
integer width = 256
integer height = 92
integer taborder = 13
integer textsize = -8
string text = "&Chiudi"
end type

event clicked;close(parent)
end event

