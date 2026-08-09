forward
global type w_calendario from w_base
end type
type cb_ok from commandbutton within w_calendario
end type
type mc_1 from monthcalendar within w_calendario
end type
end forward

global type w_calendario from w_base
integer width = 1147
integer height = 1124
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
mc_1 mc_1
end type
global w_calendario w_calendario

on w_calendario.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.mc_1=create mc_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.mc_1
end on

on w_calendario.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.mc_1)
end on

type cb_ok from commandbutton within w_calendario
integer x = 338
integer y = 828
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
boolean default = true
end type

event clicked;integer li_return
str_calendar str_data

li_return = mc_1.GetSelectedDate(str_data.data)

closewithreturn(parent, str_data)
end event

type mc_1 from monthcalendar within w_calendario
integer x = 59
integer y = 32
integer width = 1006
integer height = 760
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long titletextcolor = 134217742
long trailingtextcolor = 134217745
long monthbackcolor = 1073741824
long titlebackcolor = 134217741
integer maxselectcount = 31
integer scrollrate = 1
boolean todaysection = true
boolean todaycircle = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

