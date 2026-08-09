forward
global type uo_commandbutton from commandbutton
end type
end forward

global type uo_commandbutton from commandbutton
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
global uo_commandbutton uo_commandbutton

event rbuttondown;string ls_tip
integer li_len


if len(tag)>2 then
	ls_tip=parent.dynamic wf_window_name()+"|"+tag
	openwithparm(w_tip, ls_tip)
end if

end event

on uo_commandbutton.create
end on

on uo_commandbutton.destroy
end on

event constructor;////Add to constructor event of your Toggle Button
//THIS.Resize(517, 160)
//THIS.Text = 'On'
//THIS.Text = 'Off'
////THIS.Value = TRUE
//THIS.FaceName="Arial"
//THIS.TextSize=12
////THIS.FontColor=0
////FontCharSet=
end event

