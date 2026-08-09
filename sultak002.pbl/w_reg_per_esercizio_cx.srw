forward
global type w_reg_per_esercizio_cx from w_padre_figlio_cx
end type
type cb_copia from commandbutton within w_reg_per_esercizio_cx
end type
end forward

global type w_reg_per_esercizio_cx from w_padre_figlio_cx
integer width = 2706
integer height = 1837
cb_copia cb_copia
end type
global w_reg_per_esercizio_cx w_reg_per_esercizio_cx

on w_reg_per_esercizio_cx.create
int iCurrent
call super::create
this.cb_copia=create cb_copia
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_copia
end on

on w_reg_per_esercizio_cx.destroy
call super::destroy
destroy(this.cb_copia)
end on

type cb_ricerca from w_padre_figlio_cx`cb_ricerca within w_reg_per_esercizio_cx
boolean visible = false
integer x = 2311
integer y = 1456
end type

type dw_1 from w_padre_figlio_cx`dw_1 within w_reg_per_esercizio_cx
integer width = 2033
integer height = 381
string dataobject = "d_esercizio_gd"
boolean vscrollbar = true
end type

type dw_2 from w_padre_figlio_cx`dw_2 within w_reg_per_esercizio_cx
integer x = 69
integer width = 2183
integer height = 957
string dataobject = "d_reg_per_esercizio"
boolean vscrollbar = true
end type

type cb_inserisci from w_padre_figlio_cx`cb_inserisci within w_reg_per_esercizio_cx
integer x = 40
integer y = 1459
end type

type cb_salva from w_padre_figlio_cx`cb_salva within w_reg_per_esercizio_cx
integer x = 329
integer y = 1459
end type

type cb_cancella from w_padre_figlio_cx`cb_cancella within w_reg_per_esercizio_cx
integer x = 618
integer y = 1459
end type

type cb_annulla from w_padre_figlio_cx`cb_annulla within w_reg_per_esercizio_cx
integer x = 1704
integer y = 1459
end type

type cb_ok from w_padre_figlio_cx`cb_ok within w_reg_per_esercizio_cx
integer x = 1997
integer y = 1459
end type

type cb_copia from commandbutton within w_reg_per_esercizio_cx
integer x = 2139
integer y = 51
integer width = 497
integer height = 381
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copia Registri"
end type

event clicked;long ll_id_ese, ll_riga_corrente, ll_righe, ll_new_id_ese
integer i
long ll_null
setnull(ll_null)


ll_riga_corrente=dw_1.getrow()
if ll_riga_corrente>1 then
		ll_id_ese=dw_1.getitemnumber(ll_riga_corrente - 1, "ese_id")
		ll_righe=dw_2.retrieve(ll_id_ese)
		ll_new_id_ese=dw_1.getitemnumber(ll_riga_corrente, "ese_id")
		for i= 1 to ll_righe
			dw_2.setitem(i, "reg_ese_id", ll_new_id_ese)
			dw_2.setitem(i, "reg_id", ll_null)
			dw_2.setitemstatus(i, 0, primary!, NewModified!	)
		next
		setfocus(dw_2)
end if
end event

