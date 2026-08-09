forward
global type w_mostra_immagine from w_base
end type
type p_2 from picture within w_mostra_immagine
end type
type p_1 from picture within w_mostra_immagine
end type
end forward

global type w_mostra_immagine from w_base
integer width = 1211
integer height = 1080
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
p_2 p_2
p_1 p_1
end type
global w_mostra_immagine w_mostra_immagine

forward prototypes
public subroutine wf_mostra (string as_imm)
end prototypes

public subroutine wf_mostra (string as_imm);string ls_imm, ls_path
integer  li_w_max, li_h, li_w
decimal ldc_dim_rapporto


li_h=800
li_w_max=1000
select dir_foto
into :ls_path
from val_base;

if as_imm>"" then
	if pos(as_imm, "\") <=0 then ls_imm=ls_path+"\"+as_imm
	p_2.picturename=ls_imm
	ldc_dim_rapporto=p_2.width/p_2.height
	li_w=ldc_dim_rapporto*li_h
	if li_w>li_w_max then
		li_w=li_w_max
		li_h=1/ldc_dim_rapporto*li_w
	end if		
	p_1.picturename=ls_imm
	p_1.width=li_w
	p_1.height=li_h
end if
end subroutine

on w_mostra_immagine.create
int iCurrent
call super::create
this.p_2=create p_2
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_2
this.Control[iCurrent+2]=this.p_1
end on

on w_mostra_immagine.destroy
call super::destroy
destroy(this.p_2)
destroy(this.p_1)
end on

event open;call super::open;string ls_imm

ls_imm=message.stringparm
wf_mostra(ls_imm)
end event

type p_2 from picture within w_mostra_immagine
boolean visible = false
integer x = 1189
integer y = 396
integer width = 192
integer height = 168
boolean originalsize = true
boolean focusrectangle = false
end type

type p_1 from picture within w_mostra_immagine
integer x = 32
integer y = 28
integer width = 1125
integer height = 920
string pointer = "Arrow!"
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

