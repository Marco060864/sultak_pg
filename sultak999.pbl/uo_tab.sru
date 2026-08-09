forward
global type uo_tab from tab
end type
end forward

global type uo_tab from tab
integer width = 1152
integer height = 864
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
event type string ue_info ( )
end type
global uo_tab uo_tab

event type string ue_info();string ls_ret
ls_ret=parent.dynamic wf_window_name()
return ls_ret
end event

