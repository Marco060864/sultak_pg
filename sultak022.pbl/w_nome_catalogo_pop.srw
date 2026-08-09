forward
global type w_nome_catalogo_pop from w_pop
end type
type cb_ok from commandbutton within w_nome_catalogo_pop
end type
type cb_annulla from commandbutton within w_nome_catalogo_pop
end type
end forward

global type w_nome_catalogo_pop from w_pop
integer width = 1568
integer height = 636
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_nome_catalogo_pop w_nome_catalogo_pop

on w_nome_catalogo_pop.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
end on

on w_nome_catalogo_pop.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

event open;call super::open;dw_1.trigger event ue_insert(0)
end event

type dw_1 from w_pop`dw_1 within w_nome_catalogo_pop
integer width = 1362
integer height = 204
string dataobject = "d_catalogo_gd"
end type

type cb_ok from commandbutton within w_nome_catalogo_pop
integer x = 1042
integer y = 332
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;string ls_catalogo, ls_test
long ll_riga, ll_id_cat
dw_1.accepttext()

ll_riga=dw_1.getrow()
if ll_riga>0 then
	ls_catalogo=dw_1.getitemstring(ll_riga, "codice")
	if ls_catalogo> " " then
		//cerco se pre caso esistesse già il codice inserito
		select codice
		into :ls_test
		from dba.catalogo
		where codice=:ls_catalogo;
		if ls_test> " " then
			messagebox("Attenzione!", "Questo esiste già un catalogo con questo codice!")
		else
			//allora salvo e inserisco il catalogo
			dw_1.triggerevent("ue_update")
			ll_id_cat=dw_1.getitemnumber(ll_riga, "id_catalogo")
			closewithreturn(parent, ll_id_cat)
			
		end if
	else
		messagebox("Attenzione!", "Inserire il codice del catalogo!")
	end if
end if
end event

type cb_annulla from commandbutton within w_nome_catalogo_pop
integer x = 87
integer y = 332
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

