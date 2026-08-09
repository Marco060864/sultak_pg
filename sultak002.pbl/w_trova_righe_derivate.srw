forward
global type w_trova_righe_derivate from w_pop
end type
type st_1 from statictext within w_trova_righe_derivate
end type
end forward

global type w_trova_righe_derivate from w_pop
integer width = 3547
integer height = 1052
string title = "Righe Derivate dalla Riga Corrente"
st_1 st_1
end type
global w_trova_righe_derivate w_trova_righe_derivate

event open;call super::open;long ll_id_riga

ll_id_riga=message.doubleparm
dw_1.settransobject(sqlca)
dw_1.retrieve(ll_id_riga)
end event

on w_trova_righe_derivate.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_trova_righe_derivate.destroy
call super::destroy
destroy(this.st_1)
end on

type dw_1 from w_pop`dw_1 within w_trova_righe_derivate
integer x = 46
integer y = 152
integer width = 3406
integer height = 740
string dataobject = "d_vedi_riga_derivata"
end type

type st_1 from statictext within w_trova_righe_derivate
integer x = 78
integer y = 28
integer width = 1454
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Righe Derivate dalla Riga Corrente"
boolean focusrectangle = false
end type

