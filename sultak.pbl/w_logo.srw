forward
global type w_logo from w_base
end type
type p_1 from picture within w_logo
end type
end forward

global type w_logo from w_base
integer width = 1774
integer height = 1504
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
boolean center = true
p_1 p_1
end type
global w_logo w_logo

on w_logo.create
int iCurrent
call super::create
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
end on

on w_logo.destroy
call super::destroy
destroy(this.p_1)
end on

type p_1 from picture within w_logo
integer x = 5
integer y = 12
integer width = 1742
integer height = 1484
string picturename = "C:\sultak\icone\sultak.bmp"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

