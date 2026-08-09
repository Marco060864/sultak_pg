forward
global type w_chiudi_partita from w_semplice_gd
end type
type dw_2 from udw_000 within w_chiudi_partita
end type
end forward

global type w_chiudi_partita from w_semplice_gd
integer width = 3479
dw_2 dw_2
end type
global w_chiudi_partita w_chiudi_partita

on w_chiudi_partita.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_chiudi_partita.destroy
call super::destroy
destroy(this.dw_2)
end on

event resize;call super::resize;dw_1.height=newheight - 292 - 250
dw_2.y=dw_1.y + dw_1.height

end event

event open;call super::open;dw_2.settransobject(sqlca)
dw_2.insertrow(1)
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_chiudi_partita
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_chiudi_partita
end type

type cb_primo from w_semplice_gd`cb_primo within w_chiudi_partita
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_chiudi_partita
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_chiudi_partita
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_chiudi_partita
end type

type dw_1 from w_semplice_gd`dw_1 within w_chiudi_partita
integer width = 3319
string dataobject = "D_CHIUDI_PARTITA"
end type

event dw_1::sqlpreview;call super::sqlpreview;//string ls_sql
//long ll_pos
//
//if this.is_sql>" " and sqltype=PreviewSelect! then
//
//	ls_sql=sqlsyntax
//	
//	ll_pos=pos(ls_sql, "ORDER")
//	if ll_pos>0 then
//		ls_sql=left(ls_sql, ll_pos - 1)
//	end if
//	ls_sql+=this.is_sql
//	//messagebox("S", ls_sql)
//	setsqlpreview(ls_sql)
//
//end if
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_chiudi_partita
end type

type cb_salva from w_semplice_gd`cb_salva within w_chiudi_partita
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_chiudi_partita
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_chiudi_partita
end type

type cb_ok from w_semplice_gd`cb_ok within w_chiudi_partita
end type

type dw_2 from udw_000 within w_chiudi_partita
integer x = 32
integer y = 960
integer width = 942
integer height = 200
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_cl_fo_sel_partita"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;long ll_id_conto

ll_id_conto=long(data)
if ll_id_conto>0 then
	dw_1.is_sql=" and doc.doc_conto_id="+string(ll_id_conto)+" "
	dw_1.retrieve()
else
	dw_1.is_sql=""
	dw_1.retrieve()
end if
end event

