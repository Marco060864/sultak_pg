forward
global type w_cancella_doc from w_selezione_ext
end type
type dw_2 from udw_001 within w_cancella_doc
end type
type cb_cancella from commandbutton within w_cancella_doc
end type
type dw_3 from udw_002 within w_cancella_doc
end type
type cb_scegli from commandbutton within w_cancella_doc
end type
type cb_2 from commandbutton within w_cancella_doc
end type
end forward

global type w_cancella_doc from w_selezione_ext
integer width = 3241
integer height = 2256
dw_2 dw_2
cb_cancella cb_cancella
dw_3 dw_3
cb_scegli cb_scegli
cb_2 cb_2
end type
global w_cancella_doc w_cancella_doc

on w_cancella_doc.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_cancella=create cb_cancella
this.dw_3=create dw_3
this.cb_scegli=create cb_scegli
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_cancella
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_scegli
this.Control[iCurrent+5]=this.cb_2
end on

on w_cancella_doc.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_cancella)
destroy(this.dw_3)
destroy(this.cb_scegli)
destroy(this.cb_2)
end on

event open;call super::open;date ldt_data_inizio, ldt_oggi
DataWindowChild dwc_clfo, dwc_guida

integer rtncode
date ld_data_inizio


dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
ldt_oggi=today()

select ese_data_inizio
into :ldt_data_inizio
from esercizio
where ese_data_inizio<= :ldt_oggi
and ese_data_fine>=:ldt_oggi
;
dw_1.setitem(1, "da_data", ldt_data_inizio)
dw_1.setitem(1, "a_data", ldt_oggi)
dw_1.setitem(1, "da_num", "1")
dw_1.setitem(1, "a_num", "ZZZZZZZZZZZZZZZ") 

dw_1.setitem(1, "da_prog", 1)
dw_1.setitem(1, "a_prog", 9999999999)


rtncode = dw_1.GetChild('id_sog', dwc_clfo )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('id_guida', dwc_guida )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_clfo.SetTransObject(SQLCA)
dwc_guida.SetTransObject(SQLCA)
// Populate with values for eastern states
dwc_clfo.Retrieve()
dwc_guida.Retrieve()


end event

type cb_1 from w_selezione_ext`cb_1 within w_cancella_doc
integer x = 50
integer y = 516
end type

type cb_ok from w_selezione_ext`cb_ok within w_cancella_doc
integer x = 2222
integer y = 516
string text = "Applica filtri"
end type

event cb_ok::clicked;call super::clicked;date ldt_da_data, ldt_a_data
string ls_da_num, ls_a_num
long ll_id_sog, ll_da_prog, ll_a_prog,ll_id_guida

dw_1.accepttext()
dw_2.is_sql=""
ldt_da_data=dw_1.getitemdate(1, "da_data")
if isnull(ldt_da_data) then 
	messagebox("Attenzione!", "Data iniziale non inserita!")
	return
else
	dw_2.is_sql+=" WHERE doc_data>='"+string(ldt_da_data, "yyyy/mm/dd")+"' "
end if
ldt_a_data=dw_1.getitemdate(1, "a_data")
if isnull(ldt_a_data) then 
	messagebox("Attenzione!", "Data finale non inserita!")
	return
else
	dw_2.is_sql+=" and doc_data<='"+string(ldt_a_data, "yyyy/mm/dd")+"' "
end if
if ldt_a_data<ldt_da_data then
	messagebox("Attenzione!", "Data iniziale maggiore di quella finale!")
	return
end if

ls_da_num=dw_1.getitemstring(1, "da_num")
if isnull(ls_da_num) then 
	//messagebox("Attenzione!", "Numero iniziale non inserito!")
	//return
else
	dw_2.is_sql+=" and doc_numero>='"+ls_da_num+"' "
end if
ls_a_num=dw_1.getitemstring(1, "a_num")
if isnull(ls_a_num) then 
	messagebox("Attenzione!", "Numero finale non inserito!")
	return
else
	dw_2.is_sql+=" and doc_numero<='"+ls_a_num+"' "
end if
if ls_a_num<ls_da_num then
	messagebox("Attenzione!", "Numero iniziale maggiore di quello finale!")
	return
end if
ll_da_prog=dw_1.getitemnumber(1, "da_prog")
if isnull(ll_da_prog) then 
	messagebox("Attenzione!", "Prog iniziale non inserito!")
	return
else
	dw_2.is_sql+=" and doc_num_prog>="+string(ll_da_prog)+" "
end if
ll_a_prog=dw_1.getitemnumber(1, "a_prog")
if isnull(ll_a_prog) then 
	messagebox("Attenzione!", "Prog. finale non inserito!")
	return
else
	dw_2.is_sql+=" and doc_num_prog<="+string(ll_a_prog)+" "
end if


ll_id_sog=dw_1.getitemnumber(1, "id_sog")
if ll_id_sog>0 then
	dw_2.is_sql+=" and doc.doc_conto_id="+string(ll_id_sog)
end if

ll_id_guida=dw_1.getitemnumber(1, "id_guida")
if ll_id_guida>0 then
	dw_2.is_sql+=" and doc.guida_id="+string(ll_id_guida)
end if


dw_2.retrieve()
end event

type dw_1 from w_selezione_ext`dw_1 within w_cancella_doc
integer x = 41
integer y = 36
integer width = 2615
integer height = 448
string dataobject = "d_sel_doc"
end type

type dw_2 from udw_001 within w_cancella_doc
integer x = 55
integer y = 652
integer width = 3109
integer height = 968
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_doc_selezionati"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_id_doc

if currentrow>0 then
	ll_id_doc=dw_2.getitemnumber(currentrow, "doc_doc_id")
	if ll_id_doc>0 then
	
		DW_3.RETRIEVE(ll_id_doc)
	else
		DW_3.reset()
	end if
end if
end event

type cb_cancella from commandbutton within w_cancella_doc
integer x = 2702
integer y = 64
integer width = 457
integer height = 424
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;integer i, li_ret,a, li_righe, li_ret2
long ll_righe, ll_id_doc
datastore ds_canc_righe, ds_canc_partite_A, ds_canc_partite_S


if Messagebox("Attenzione!", "Sei certo di voler cancellare i documenti scelti?", stopsign!, yesno!)=1 then
	ds_canc_righe=create datastore
	ds_canc_righe.dataobject="d_rdoc_gd"
	ds_canc_righe.settransobject(sqlca)
	
	ds_canc_partite_A=create datastore
	ds_canc_partite_A.dataobject="d_partita_carico_ra_gd"
	ds_canc_partite_A.settransobject(sqlca)
	
	ds_canc_partite_S=create datastore
	ds_canc_partite_S.dataobject="d_partita_scarico_ra_gd"
	ds_canc_partite_S.settransobject(sqlca)
	
	for i= dw_2.rowcount() to 1  step -1
		if dw_2.getitemstring(i, "c_cancella")='1' then

			ll_id_doc=dw_2.getitemnumber(i, "doc_doc_id")
			delete from dba.cast_iva
			where doc_id=:ll_id_doc;
			if sqlca.sqlcode<> 0 then li_ret+=-1
			delete from dba.cast_cpt
			where doc_id=:ll_id_doc;
			if sqlca.sqlcode<> 0 then li_ret+=-1
			delete from dba.scadenza
			where doc_id=:ll_id_doc;
			if sqlca.sqlcode<> 0 then li_ret+=-1
			delete from dba.sp_doc
			where doc_id=:ll_id_doc;
			if sqlca.sqlcode<> 0 then li_ret+=-1
			//creo ds per le eventuali partite orafe
			li_righe=ds_canc_partite_A.retrieve(ll_id_doc)
			for a= li_righe to 1 step -1
				ds_canc_partite_A.deleterow(a)
				if ds_canc_partite_A.update()<>1 then 
					li_ret+= -1
					exit
				end if
			next
			li_righe=ds_canc_partite_S.retrieve(ll_id_doc)
			for a= li_righe to 1 step -1
				ds_canc_partite_S.deleterow(a)
				if ds_canc_partite_S.update()<>1 then 
					li_ret+= -1
					exit
				end if
			next
			li_righe=ds_canc_righe.retrieve(ll_id_doc)
			for a= li_righe to 1 step -1
				ds_canc_righe.deleterow(a)
				if ds_canc_righe.update()<>1 then 
					li_ret+= -1
					exit
				end if
			next
						
			if li_ret<0 then
				rollback;
				//Messagebox("Attenzione!", SQLCA.SQLErrText)
				li_ret=0
			else
				commit;
				dw_2.deleterow(i)
				li_ret2=dw_2.trigger event ue_update()
			end if
			
		end if
	next
	destroy ds_canc_partite_A
	destroy ds_canc_partite_S
	destroy ds_canc_righe
	
end if
end event

type dw_3 from udw_002 within w_cancella_doc
integer x = 55
integer y = 1628
integer width = 3109
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_rdoc_gd"
end type

type cb_scegli from commandbutton within w_cancella_doc
integer x = 1175
integer y = 524
integer width = 448
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleziona Tutti"
end type

event clicked;integer i
long ll_doc

ll_doc=dw_2.rowcount()
for i= 1 to ll_doc
	dw_2.setitem(i, "c_cancella", "1")
next
end event

type cb_2 from commandbutton within w_cancella_doc
integer x = 1655
integer y = 524
integer width = 512
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Deseleziona Tutti"
end type

event clicked;integer i
long ll_doc

ll_doc=dw_2.rowcount()
for i= 1 to ll_doc
	dw_2.setitem(i, "c_cancella", "0")
next
end event

