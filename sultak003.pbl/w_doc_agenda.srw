forward
global type w_doc_agenda from w_base
end type
type dw_1 from udw_001 within w_doc_agenda
end type
type cb_imp_st from commandbutton within w_doc_agenda
end type
type cbx_anteprima from checkbox within w_doc_agenda
end type
type st_copie from statictext within w_doc_agenda
end type
type st_1 from statictext within w_doc_agenda
end type
type sle_range from singlelineedit within w_doc_agenda
end type
type sle_copie from singlelineedit within w_doc_agenda
end type
type cb_stampa from commandbutton within w_doc_agenda
end type
type cb_annulla from commandbutton within w_doc_agenda
end type
type cb_ok from commandbutton within w_doc_agenda
end type
type cb_salva from commandbutton within w_doc_agenda
end type
type rte_doc_agenda from richtextedit within w_doc_agenda
end type
end forward

global type w_doc_agenda from w_base
integer width = 3419
integer height = 2236
windowtype windowtype = response!
dw_1 dw_1
cb_imp_st cb_imp_st
cbx_anteprima cbx_anteprima
st_copie st_copie
st_1 st_1
sle_range sle_range
sle_copie sle_copie
cb_stampa cb_stampa
cb_annulla cb_annulla
cb_ok cb_ok
cb_salva cb_salva
rte_doc_agenda rte_doc_agenda
end type
global w_doc_agenda w_doc_agenda

on w_doc_agenda.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_imp_st=create cb_imp_st
this.cbx_anteprima=create cbx_anteprima
this.st_copie=create st_copie
this.st_1=create st_1
this.sle_range=create sle_range
this.sle_copie=create sle_copie
this.cb_stampa=create cb_stampa
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.cb_salva=create cb_salva
this.rte_doc_agenda=create rte_doc_agenda
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_imp_st
this.Control[iCurrent+3]=this.cbx_anteprima
this.Control[iCurrent+4]=this.st_copie
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.sle_range
this.Control[iCurrent+7]=this.sle_copie
this.Control[iCurrent+8]=this.cb_stampa
this.Control[iCurrent+9]=this.cb_annulla
this.Control[iCurrent+10]=this.cb_ok
this.Control[iCurrent+11]=this.cb_salva
this.Control[iCurrent+12]=this.rte_doc_agenda
end on

on w_doc_agenda.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_imp_st)
destroy(this.cbx_anteprima)
destroy(this.st_copie)
destroy(this.st_1)
destroy(this.sle_range)
destroy(this.sle_copie)
destroy(this.cb_stampa)
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.cb_salva)
destroy(this.rte_doc_agenda)
end on

event open;call super::open;string ls_dir, LS_FILE
long ll_id_visita

select dir_pdf
into :ls_dir
from dba.val_base
;
if isnull(ls_dir) then ls_dir='c:\'
LS_FILE=message.stringparm
title=ls_dir+message.stringparm
if fileexists(ls_dir+message.stringparm) then
	rte_doc_agenda.insertdocument(ls_dir+message.stringparm, true)
	
end if

dw_1.settransobject(sqlca)

ll_id_visita=LONG( MID(ls_file, 5, len(ls_file) - 8))
dw_1.retrieve(ll_id_visita)
end event

event ue_postopen;call super::ue_postopen;rte_doc_agenda.selecttextall()
rte_doc_agenda.copy()
dw_1.SelectText(999,1, 0,0)
dw_1.paste()
end event

type dw_1 from udw_001 within w_doc_agenda
integer x = 27
integer y = 188
integer width = 3310
integer height = 964
integer taborder = 50
string dataobject = "d_visite_rtf"
end type

type cb_imp_st from commandbutton within w_doc_agenda
integer x = 2053
integer y = 32
integer width = 343
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampante"
end type

event clicked;printsetup()
end event

type cbx_anteprima from checkbox within w_doc_agenda
integer x = 1609
integer y = 52
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Anteprima"
boolean lefttext = true
end type

event clicked;
rte_doc_agenda.Preview(not rte_doc_agenda.IsPreview())

end event

type st_copie from statictext within w_doc_agenda
integer x = 1056
integer y = 48
integer width = 302
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "N° Copie:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_doc_agenda
integer x = 32
integer y = 52
integer width = 439
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Stampa Pagine:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_range from singlelineedit within w_doc_agenda
integer x = 475
integer y = 32
integer width = 571
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type sle_copie from singlelineedit within w_doc_agenda
integer x = 1367
integer y = 32
integer width = 206
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1"
boolean autohscroll = false
integer limit = 4
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type cb_stampa from commandbutton within w_doc_agenda
integer x = 2423
integer y = 32
integer width = 251
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;integer li_copie
string ls_range


ls_range=sle_range.text
li_copie=integer(sle_copie.text)
rte_doc_agenda.print(li_copie, ls_range, true, true)
end event

type cb_annulla from commandbutton within w_doc_agenda
integer x = 2926
integer y = 32
integer width = 201
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Esci"
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_doc_agenda
integer x = 3145
integer y = 32
integer width = 187
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;

cb_salva.triggerevent(clicked!)
close(parent)
end event

type cb_salva from commandbutton within w_doc_agenda
integer x = 2711
integer y = 36
integer width = 187
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;rte_doc_agenda.savedocument(parent.title)

dw_1.trigger event ue_update()



end event

type rte_doc_agenda from richtextedit within w_doc_agenda
integer x = 27
integer y = 1176
integer width = 3310
integer height = 912
integer taborder = 50
boolean init_vscrollbar = true
boolean init_wordwrap = true
boolean init_pictureframe = true
boolean init_rulerbar = true
boolean init_toolbar = true
boolean init_popmenu = true
integer init_undodepth = 3
long init_leftmargin = 1000
long init_topmargin = 1000
long init_rightmargin = 1000
long init_bottommargin = 2000
borderstyle borderstyle = stylelowered!
end type

