forward
global type w_sel_data_ff from w_wiz_main
end type
type dw_1 from datawindow within w_sel_data_ff
end type
type cb_1 from commandbutton within w_sel_data_ff
end type
type st_1 from statictext within w_sel_data_ff
end type
type st_2 from statictext within w_sel_data_ff
end type
end forward

global type w_sel_data_ff from w_wiz_main
integer x = 640
integer y = 928
integer width = 1927
integer height = 675
string title = "Uscita Riba"
long backcolor = 78682240
dw_1 dw_1
cb_1 cb_1
st_1 st_1
st_2 st_2
end type
global w_sel_data_ff w_sel_data_ff

on w_sel_data_ff.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
end on

on w_sel_data_ff.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;call super::open;dw_1.InsertRow(0)


end event

type dw_1 from datawindow within w_sel_data_ff
integer x = 66
integer y = 170
integer width = 1785
integer height = 371
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_data_ff"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_sel_data_ff
integer x = 69
integer y = 29
integer width = 443
integer height = 109
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string text = "Prepara disco"
end type

event clicked;long ll_row, ll_id, ll_prog_dis, ll_retv
date d_dat
string ls_path

s_distinta par_dis 
par_dis=message.powerobjectparm
ll_id= par_dis.l_id_dis_banca   

dw_1.accepttext()

ll_row= dw_1.getrow()
if ll_row > 0 then   

	d_dat =dw_1.getitemdate(ll_row, "d_dat")
	ls_path= dw_1.getitemstring(ll_row, "path_riba")

par_dis.l_id_dis_banca = ll_id
par_dis.d_dat_rib      = d_dat
par_dis.ls_path_riba   = ls_path

OpenWithParm(w_uscita_riba_lt, par_dis )
close(parent)
end if            


end event

type st_1 from statictext within w_sel_data_ff
integer x = 592
integer y = 19
integer width = 1002
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Inserire il path per l~'uscita Ascii indicando "
boolean focusrectangle = false
end type

type st_2 from statictext within w_sel_data_ff
integer x = 589
integer y = 83
integer width = 1002
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "una directory corretta"
boolean focusrectangle = false
end type

