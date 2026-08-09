forward
global type uo_cmdbutton_for_tab from commandbutton
end type
end forward

global type uo_cmdbutton_for_tab from commandbutton
integer width = 402
integer height = 112
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type
global uo_cmdbutton_for_tab uo_cmdbutton_for_tab

event rbuttondown;string ls_tip
integer li_len


if len(tag)>2 then
	ls_tip=string(parent.dynamic trigger event ue_info())+"|"+tag
	openwithparm(w_tip, ls_tip)
end if

end event

on uo_cmdbutton_for_tab.create
end on

on uo_cmdbutton_for_tab.destroy
end on

