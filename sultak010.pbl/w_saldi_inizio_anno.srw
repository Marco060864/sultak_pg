forward
global type w_saldi_inizio_anno from w_base
end type
type dw_2 from udw_001 within w_saldi_inizio_anno
end type
type dw_1 from udw_001 within w_saldi_inizio_anno
end type
end forward

global type w_saldi_inizio_anno from w_base
integer x = 1056
integer y = 484
integer width = 3650
integer height = 2003
dw_2 dw_2
dw_1 dw_1
end type
global w_saldi_inizio_anno w_saldi_inizio_anno

on w_saldi_inizio_anno.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_1
end on

on w_saldi_inizio_anno.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_1)
end on

type dw_2 from udw_001 within w_saldi_inizio_anno
integer x = 95
integer y = 1088
integer width = 1397
integer taborder = 20
end type

type dw_1 from udw_001 within w_saldi_inizio_anno
integer x = 33
integer y = 29
integer width = 3525
integer height = 950
integer taborder = 10
string dataobject = "d_saldi_inizio_anno"
boolean vscrollbar = true
end type

