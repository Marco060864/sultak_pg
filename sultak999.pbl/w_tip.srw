forward
global type w_tip from w_base
end type
type cb_1 from uo_commandbutton within w_tip
end type
type cb_esci from commandbutton within w_tip
end type
type rte_tip from richtextedit within w_tip
end type
end forward

global type w_tip from w_base
integer width = 1637
integer height = 1316
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 134217752
cb_1 cb_1
cb_esci cb_esci
rte_tip rte_tip
end type
global w_tip w_tip

on w_tip.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_esci=create cb_esci
this.rte_tip=create rte_tip
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_esci
this.Control[iCurrent+3]=this.rte_tip
end on

on w_tip.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_esci)
destroy(this.rte_tip)
end on

event open;call super::open;string ls_tip, ls_nome_oggetto
integer li_pos

ls_tip=message.stringparm

if ls_tip> " " then
	li_pos=pos(ls_tip, "|")
	if li_pos> 0 then
		ls_nome_oggetto=left(ls_tip, li_pos -1)
		ls_tip=right(ls_tip, len(ls_tip) - li_pos)
		this.title="Tip riferito a: "+ls_nome_oggetto
		rte_tip.ReplaceText(ls_tip)
	end if
else
	close(this)
end if
end event

type cb_1 from uo_commandbutton within w_tip
integer x = 82
integer y = 1076
integer taborder = 30
end type

type cb_esci from commandbutton within w_tip
integer x = 1134
integer y = 1084
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
boolean cancel = true
end type

event clicked;close(parent)
end event

type rte_tip from richtextedit within w_tip
integer x = 59
integer y = 44
integer width = 1458
integer height = 944
integer taborder = 10
boolean init_wordwrap = true
boolean init_rulerbar = true
boolean init_tabbar = true
boolean init_toolbar = true
boolean init_popmenu = true
borderstyle borderstyle = stylelowered!
end type

