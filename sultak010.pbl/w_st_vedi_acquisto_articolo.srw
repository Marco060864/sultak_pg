forward
global type w_st_vedi_acquisto_articolo from w_base
end type
type dw_4 from udw_000 within w_st_vedi_acquisto_articolo
end type
type st_1 from statictext within w_st_vedi_acquisto_articolo
end type
type cb_1 from commandbutton within w_st_vedi_acquisto_articolo
end type
type dw_3 from udw_000 within w_st_vedi_acquisto_articolo
end type
type dw_2 from udw_001 within w_st_vedi_acquisto_articolo
end type
type dw_1 from udw_001 within w_st_vedi_acquisto_articolo
end type
end forward

global type w_st_vedi_acquisto_articolo from w_base
integer width = 3099
integer height = 1980
dw_4 dw_4
st_1 st_1
cb_1 cb_1
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
end type
global w_st_vedi_acquisto_articolo w_st_vedi_acquisto_articolo

event open;call super::open;date ldt_data

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_3.insertrow(1)
dw_4.insertrow(1)

select data_inizio
into :ldt_data
from esercizio
where data_inizio <= today()
and data_fine >=today()
;

dw_3.setitem(1, "da_data", ldt_data)

end event

on w_st_vedi_acquisto_articolo.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_1
end on

on w_st_vedi_acquisto_articolo.destroy
call super::destroy
destroy(this.dw_4)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type dw_4 from udw_000 within w_st_vedi_acquisto_articolo
integer x = 1655
integer y = 252
integer width = 1367
integer height = 248
integer taborder = 40
boolean titlebar = true
string title = "Cerca Articolo"
string dataobject = "d_cerca_art_ext"
end type

type st_1 from statictext within w_st_vedi_acquisto_articolo
integer x = 46
integer y = 1724
integer width = 2450
integer height = 144
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Questa stampa restituisce la ~"proprietà fiscale~" dei vari articoli di magazzino. prende quindi in cosiderazione SOLO i movimenti ~"fiscali~"."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_st_vedi_acquisto_articolo
integer x = 1696
integer y = 36
integer width = 411
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "VAI"
end type

event clicked;date ldt_da_data, ldt_a_data

ldt_da_data=dw_3.getitemdate(1, "da_data")

ldt_a_data=dw_3.getitemdate(1, "a_data")
dw_1.retrieve(ldt_da_data, ldt_a_data)
end event

type dw_3 from udw_000 within w_st_vedi_acquisto_articolo
integer x = 2167
integer y = 36
integer width = 850
integer height = 172
integer taborder = 20
string dataobject = "d_sel_date"
end type

type dw_2 from udw_001 within w_st_vedi_acquisto_articolo
integer x = 50
integer y = 516
integer width = 2962
integer height = 1168
integer taborder = 10
string dataobject = "d_data_acquisto_articoli"
boolean vscrollbar = true
end type

type dw_1 from udw_001 within w_st_vedi_acquisto_articolo
integer x = 50
integer y = 28
integer width = 1586
integer height = 476
integer taborder = 10
string dataobject = "d_saldo_fiscale_articoli"
end type

event rowfocuschanged;call super::rowfocuschanged;//passa articolo e peso esistente a dw_2
long ll_id_art
string ls_giacenza
if currentrow>0 then
	ll_id_art=getitemnumber(currentrow, "art_art_id")
	ls_giacenza=string(getitemdecimal(currentrow, "giacenza"))	
	dw_2.retrieve(ll_id_art, ls_giacenza)
end if
end event

