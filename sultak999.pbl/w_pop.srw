forward
global type w_pop from w_base
end type
type dw_1 from udw_001 within w_pop
end type
end forward

global type w_pop from w_base
integer width = 1262
integer height = 676
boolean minbox = false
boolean maxbox = false
dw_1 dw_1
end type
global w_pop w_pop

on w_pop.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_pop.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
end event

type dw_1 from udw_001 within w_pop
integer x = 82
integer y = 56
integer width = 1033
integer taborder = 10
end type

