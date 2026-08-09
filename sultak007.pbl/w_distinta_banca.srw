forward
global type w_distinta_banca from w_padre_figlio_cx
end type
type cb_riba from commandbutton within w_distinta_banca
end type
end forward

global type w_distinta_banca from w_padre_figlio_cx
integer y = 424
integer width = 3577
integer height = 1850
cb_riba cb_riba
end type
global w_distinta_banca w_distinta_banca

on w_distinta_banca.create
int iCurrent
call super::create
this.cb_riba=create cb_riba
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_riba
end on

on w_distinta_banca.destroy
call super::destroy
destroy(this.cb_riba)
end on

event resize;call super::resize;cb_ricerca.y=64	
cb_ricerca.x=1883
end event

type cb_ricerca from w_padre_figlio_cx`cb_ricerca within w_distinta_banca
integer x = 3149
integer y = 61
end type

type dw_1 from w_padre_figlio_cx`dw_1 within w_distinta_banca
integer width = 3035
integer height = 653
string dataobject = "d_dis_banca_gd"
end type

type dw_2 from w_padre_figlio_cx`dw_2 within w_distinta_banca
integer x = 69
integer y = 730
integer width = 3430
integer height = 816
string dataobject = "d_riga_dis_banca"
end type

type cb_inserisci from w_padre_figlio_cx`cb_inserisci within w_distinta_banca
integer x = 80
integer y = 1594
end type

type cb_salva from w_padre_figlio_cx`cb_salva within w_distinta_banca
integer x = 366
integer y = 1594
end type

type cb_cancella from w_padre_figlio_cx`cb_cancella within w_distinta_banca
integer x = 655
integer y = 1594
end type

type cb_annulla from w_padre_figlio_cx`cb_annulla within w_distinta_banca
integer x = 1251
integer y = 1590
end type

type cb_ok from w_padre_figlio_cx`cb_ok within w_distinta_banca
integer x = 1547
integer y = 1594
end type

type cb_riba from commandbutton within w_distinta_banca
integer x = 3149
integer y = 208
integer width = 260
integer height = 90
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Riba"
end type

event clicked;long ll_row, ll_id, ll_prog_dis, ll_retv
s_distinta par_dis


ll_row= dw_1.getrow()
if ll_row > 0 then   
	ll_id =dw_1.getitemnumber(ll_row, "id_dist_banca")
	par_dis.l_id_dis_banca=ll_id

	OpenWithParm (w_sel_data_ff, par_dis)
	
end if            
end event

