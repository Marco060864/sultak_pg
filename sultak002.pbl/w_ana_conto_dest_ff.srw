forward
global type w_ana_conto_dest_ff from w_base
end type
type tab_1 from tab within w_ana_conto_dest_ff
end type
type tabpage_1 from userobject within tab_1
end type
type dw_3 from udw_001 within tabpage_1
end type
type dw_2 from udw_001 within tabpage_1
end type
type dw_1 from udw_001 within tabpage_1
end type
type cb_ricerca from commandbutton within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
cb_ricerca cb_ricerca
end type
type tabpage_2 from userobject within tab_1
end type
type dw_4 from udw_001 within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_4 dw_4
end type
type tab_1 from tab within w_ana_conto_dest_ff
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_inserisci from commandbutton within w_ana_conto_dest_ff
end type
type cb_salva from commandbutton within w_ana_conto_dest_ff
end type
type cb_cancella from commandbutton within w_ana_conto_dest_ff
end type
type cb_annulla from commandbutton within w_ana_conto_dest_ff
end type
type cb_ok from commandbutton within w_ana_conto_dest_ff
end type
end forward

global type w_ana_conto_dest_ff from w_base
integer x = 786
integer y = 428
integer width = 4041
integer height = 2288
tab_1 tab_1
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_ana_conto_dest_ff w_ana_conto_dest_ff

type variables
udw_001 i_dw_corrente //1=dw_1, 2=dw_2
boolean ib_applica_filtro
end variables

forward prototypes
public subroutine wf_crea_conto (long al_row, string as_colonna, string as_data)
public function integer wf_salva_dw (ref udw_001 adw_1, ref udw_001 adw_2, integer as_flag, ref udw_001 adw_3, ref udw_001 adw_4)
end prototypes

public subroutine wf_crea_conto (long al_row, string as_colonna, string as_data);string ls_row, ls_cod1, ls_cod2
long ll_id_sottomastro
integer i, li_len

if as_colonna="sottomastro_id" then
	ll_id_sottomastro=long(as_data)
	ls_row=string(al_row)
	ls_cod1=tab_1.tabpage_1.dw_2.describe("Evaluate('lookupdisplay(sottomastro_id) '," +ls_row+")")
	select max(conto_codice)
	into :ls_cod2
	from dba.conto
	where left(conto_codice, 4)= :ls_cod1
	;
	ls_cod2=right(ls_cod2, 4)
	ls_cod2=string(integer(ls_cod2)+1)
	if isnull(ls_cod2) or ls_cod2="" then ls_cod2= "0001"
	li_len=len(ls_cod2)
	for i = 1 to 4 - li_len
		ls_cod2="0"+ls_cod2
	next
	tab_1.tabpage_1.dw_2.setitem(al_row, "conto_codice", ls_cod1+ls_cod2)
end if
end subroutine

public function integer wf_salva_dw (ref udw_001 adw_1, ref udw_001 adw_2, integer as_flag, ref udw_001 adw_3, ref udw_001 adw_4);//salvo sicuramente la testa (in ogni caso) (dw_1)
//se il flag=2 allora devo salvare anche le righe (dw_2)
//ma solo se il salvataggio della testa è andato a buon fine
integer li_ret

li_ret=adw_1.triggerevent("ue_update")

if as_flag=2 and li_ret=1 then	
	li_ret=adw_2.triggerevent("ue_update")
	li_ret=adw_3.triggerevent("ue_update")
	li_ret=adw_4.triggerevent("ue_update")
end if
return li_ret
	
	
end function

on w_ana_conto_dest_ff.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_inserisci
this.Control[iCurrent+3]=this.cb_salva
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.cb_annulla
this.Control[iCurrent+6]=this.cb_ok
end on

on w_ana_conto_dest_ff.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;call super::open;//long ll_id
tab_1.tabpage_1.dw_1.settransobject(sqlca)
tab_1.tabpage_1.dw_2.settransobject(sqlca)
tab_1.tabpage_1.dw_3.settransobject(sqlca)
tab_1.tabpage_2.dw_4.settransobject(sqlca)

tab_1.tabpage_1.dw_1.insertrow(1)
//if tab_1.tabpage_1.dw_1.retrieve()>0 then
//	ll_id=tab_1.tabpage_1.dw_1.getitemnumber(1,1)
//	tab_1.tabpage_1.dw_2.retrieve(ll_id)
//	tab_1.tabpage_1.dw_3.retrieve(ll_id)
//	tab_1.tabpage_2.dw_4.retrieve(ll_id)
//end if
	
end event

type tab_1 from tab within w_ana_conto_dest_ff
event create ( )
event destroy ( )
integer x = 5
integer y = 16
integer width = 3963
integer height = 2112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3927
integer height = 1984
long backcolor = 79741120
string text = "Anagrafiche - Conti - Destinazioni"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
cb_ricerca cb_ricerca
end type

on tabpage_1.create
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_ricerca=create cb_ricerca
this.Control[]={this.dw_3,&
this.dw_2,&
this.dw_1,&
this.cb_ricerca}
end on

on tabpage_1.destroy
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_ricerca)
end on

type dw_3 from udw_001 within tabpage_1
integer x = 23
integer y = 1648
integer width = 3877
integer height = 300
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_destinazione_gd"
end type

event getfocus;call super::getfocus;i_dw_corrente=this
end event

event ue_post_insert;call super::ue_post_insert;long ll_id_ana, ll_row

ll_row=dw_1.getrow()
if ll_row>0 then
	ll_id_ana=dw_1.getitemnumber(ll_row, "ana_id")
	if ll_id_ana>0 then
		setitem(al_riga, "ana_id", ll_id_ana)
	else
		messagebox("Errore!", "Inserire prima una ragione sociale e salvarla!")
		deleterow(al_riga)
	end if
end if
setitem(al_riga, "dest_codice", "D_"+string(al_riga))
end event

type dw_2 from udw_001 within tabpage_1
integer x = 2085
integer y = 172
integer width = 1765
integer height = 860
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_conto_gd"
boolean hscrollbar = true
end type

event getfocus;call super::getfocus;i_dw_corrente=this
end event

event itemchanged;call super::itemchanged;post wf_crea_conto(row, dwo.name, data)
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_id   //primary key del master da riportare per il retrieve del detail


//se esiste la riga
if currentrow>0 then
	//recupero la primary key dal padre
	ll_id=getitemnumber(currentrow, 1)
	// se esiste PK ..
	if ll_id>0 then
		//la riporto per il retrieve del detail
		tab_1.tabpage_2.dw_4.retrieve(ll_id)	
	else
		tab_1.tabpage_2.dw_4.reset()
	end if
end if
end event

event ue_post_insert;call super::ue_post_insert;long ll_id_ana, ll_row

ll_row=dw_1.getrow()
if ll_row>0 then
	ll_id_ana=dw_1.getitemnumber(ll_row, "ana_id")
	if ll_id_ana>0 then
		setitem(al_riga, "ana_id", ll_id_ana)
	else
		messagebox("Errore!", "Inserire prima una ragione sociale e salvarla!")
		deleterow(al_riga)
	end if
end if

end event

event updatestart;call super::updatestart;string ls_descrizione
if rowcount()>0 then
	ls_descrizione=dw_1.getitemstring(1, "ana_rag_sociale")
	setitem(getrow(), "descrizione", ls_descrizione)
end if
end event

type dw_1 from udw_001 within tabpage_1
integer x = 23
integer y = 16
integer width = 2039
integer height = 1612
integer taborder = 20
boolean bringtotop = true
string title = ""
string dataobject = "d_ana_ff"
boolean livescroll = false
end type

event getfocus;call super::getfocus;i_dw_corrente=this
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_id, ll_id_conto  //primary key del master da riportare per il retrieve del detail
integer li_righe_conto

//se esiste la riga
if currentrow>0 then
	//recupero la primary key dal padre
	ll_id=getitemnumber(currentrow, 1)
	// se esiste PK ..
	if ll_id>0 then
		//la riporto per il retrieve del detail
		li_righe_conto=dw_2.retrieve(ll_id)
		dw_3.retrieve(ll_id)
		if li_righe_conto>0 then
			ll_id_conto=dw_2.getitemnumber(dw_2.getrow(), "conto_id")
			tab_1.tabpage_2.dw_4.retrieve(ll_id_conto)
		else
			tab_1.tabpage_2.dw_4.reset()
		end if
	else
		dw_2.reset()
		dw_3.reset()
		tab_1.tabpage_2.dw_4.reset()
	end if
end if

end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case "ana_rag_sociale"
		ib_applica_filtro=true
	case "nazione"
		if data<>'IT' then 
			messagebox("Attenzione!", "Se la nazione è <> 'IT' la provincia deve essere vuota  e il campo CAP andrà compilato con il valore generico 00000. Si potrà utilizzare l’indirizzo per indicare il CAP straniero.")
			setitem(row, "ana_provincia", "")
			setitem(row, "ana_cap", "00000")
		end if
		
end choose
end event

type cb_ricerca from commandbutton within tabpage_1
integer x = 2062
integer y = 20
integer width = 389
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricerca"
end type

event clicked;long ll_id, ll_riga

s_ricerca s_ric
w_new_ricerca_sw w_ric_sw

s_ric.dataobject='d_sog_sw'
s_ric.titolo_finestra="Ricerca Soggetti"
dw_1.accepttext()
if dw_1.rowcount()<1 then
	cb_inserisci.triggerevent(clicked!)
end if
if ib_applica_filtro=true then
	s_ric.filtro[1]=dw_1.getitemstring(1, "ana_rag_sociale")
	s_ric.colonna_filtro[1]="ana_ana_rag_sociale"
	ib_applica_filtro=false
end if

openwithparm(w_ric_sw, s_ric)
if isvalid(message) then ll_id=message.doubleparm


ll_riga=dw_1.retrieve(ll_id)
if ll_riga>0 then
	dw_1.trigger event rowfocuschanged(ll_riga)
else
	cb_inserisci.triggerevent(clicked!)
end if



end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3927
integer height = 1984
long backcolor = 79741120
string text = "Banche"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_2.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_2.destroy
destroy(this.dw_4)
end on

type dw_4 from udw_001 within tabpage_2
integer x = 32
integer y = 36
integer width = 2939
integer height = 588
integer taborder = 20
string dataobject = "d_conto_banca_gd"
boolean vscrollbar = true
end type

event ue_post_insert;call super::ue_post_insert;long ll_id_conto
integer li_riga_corrente_conto


li_riga_corrente_conto=tab_1.tabpage_1.dw_2.getrow()
if li_riga_corrente_conto>0 then
	ll_id_conto=tab_1.tabpage_1.dw_2.getitemnumber(li_riga_corrente_conto, "conto_id")
	if isnull(ll_id_conto) then
		this.deleterow(al_riga)
		cb_salva.triggerevent(clicked!)
		this.trigger event ue_insert(0)
	else
		tab_1.tabpage_2.dw_4.setitem(al_riga, "conto_id", ll_id_conto)
	end if
end if
end event

event getfocus;call super::getfocus;i_dw_corrente=this
end event

type cb_inserisci from commandbutton within w_ana_conto_dest_ff
integer x = 2199
integer y = 1188
integer width = 261
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;dwitemstatus ldw_status
long ll_riga, ll_id
if i_dw_corrente=tab_1.tabpage_1.dw_1 then
	if i_dw_corrente.rowcount()>0 then
		ldw_status=i_dw_corrente.getitemstatus(1,0, primary!)
		if ldw_status<>NotModified!	then
			if messagebox("Attenzione!", "Vuoi salvare il record modificato o no?", stopsign!, yesno!)=1 then
				i_dw_corrente.update()
			end if
		end if
	end if
	i_dw_corrente.reset()
	ll_riga=tab_1.tabpage_1.dw_1.trigger event ue_insert(0)
elseif i_dw_corrente=tab_1.tabpage_2.dw_4 then
	tab_1.tabpage_2.dw_4.trigger event ue_insert(0)
else
	
	ll_riga=tab_1.tabpage_1.dw_1.getrow()
	if ll_riga>0 then
		ll_id=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga, 1)
		if isnull(ll_id)  then
			if messagebox("Attenzione!", "Non è stata salvata la ragione sociale (finestra a SX)"+&
				" Se vuoi salvarla adesso scegli sì. altrimenti con No annulla l'inserimento.", stopsign!, yesno!)=1 then
				
				if wf_salva_dw(tab_1.tabpage_1.dw_1,tab_1.tabpage_1.dw_2,1, tab_1.tabpage_1.dw_3,tab_1.tabpage_2.dw_4)=1 then
					this.triggerevent(clicked!)
				end if
			end if
		else
			ll_riga=i_dw_corrente.trigger event ue_insert(0)
			
		end if
	end if
end if
end event

type cb_salva from commandbutton within w_ana_conto_dest_ff
integer x = 2487
integer y = 1188
integer width = 261
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;
wf_salva_dw(tab_1.tabpage_1.dw_1, tab_1.tabpage_1.dw_2, 2, tab_1.tabpage_1.dw_3, tab_1.tabpage_2.dw_4)

end event

type cb_cancella from commandbutton within w_ana_conto_dest_ff
integer x = 2779
integer y = 1188
integer width = 261
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
if i_dw_corrente=tab_1.tabpage_1.dw_1 then
	ll_riga_da_cancellare=tab_1.tabpage_1.dw_1.getrow()
	if ll_riga_da_cancellare>0 then
	 	tab_1.tabpage_1.dw_1.trigger event ue_delete(ll_riga_da_cancellare)
		//ripulisco, senza cancellare poché lo farà la FK in cascata al momento dell' update,
		//la dw_2
		tab_1.tabpage_1.dw_2.reset()
		tab_1.tabpage_1.dw_3.reset()
	end if
else 
	ll_riga_da_cancellare=tab_1.tabpage_1.dw_2.getrow()
	if ll_riga_da_cancellare>0 then
		i_dw_corrente.trigger event ue_delete(ll_riga_da_cancellare)
	end if
end if
end event

type cb_annulla from commandbutton within w_ana_conto_dest_ff
integer x = 3328
integer y = 1188
integer width = 261
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_ana_conto_dest_ff
integer x = 3621
integer y = 1188
integer width = 261
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;if messagebox("Salvare?", "Salvare i dati prima di chiudere?", stopsign!, yesno!)=1 then
	wf_salva_dw(tab_1.tabpage_1.dw_1, tab_1.tabpage_1.dw_2, 2, tab_1.tabpage_1.dw_3, tab_1.tabpage_2.dw_4)
end if
close(parent)
end event

