forward
global type w_tab_ra_padre_figlio_cx from w_base
end type
type tab_1 from tab within w_tab_ra_padre_figlio_cx
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from udw_001 within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from udw_002 within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tab_1 from tab within w_tab_ra_padre_figlio_cx
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_ricerca from commandbutton within w_tab_ra_padre_figlio_cx
end type
type cb_inserisci from commandbutton within w_tab_ra_padre_figlio_cx
end type
type cb_salva from commandbutton within w_tab_ra_padre_figlio_cx
end type
type cb_cancella from commandbutton within w_tab_ra_padre_figlio_cx
end type
type cb_annulla from commandbutton within w_tab_ra_padre_figlio_cx
end type
type cb_ok from commandbutton within w_tab_ra_padre_figlio_cx
end type
end forward

global type w_tab_ra_padre_figlio_cx from w_base
integer x = 786
integer y = 426
integer width = 4275
integer height = 2685
tab_1 tab_1
cb_ricerca cb_ricerca
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_tab_ra_padre_figlio_cx w_tab_ra_padre_figlio_cx

type variables
integer i_dw_corrente //1=dw_1, 2=dw_2
end variables

forward prototypes
public function integer wf_salva_dw (ref udw_001 adw_1, ref udw_002 adw_2, integer as_flag)
end prototypes

public function integer wf_salva_dw (ref udw_001 adw_1, ref udw_002 adw_2, integer as_flag);//salvo sicuramente la testa (in ogni caso) (dw_1)
//se il flag=2 allora devo salvare anche le righe (dw_2)
//ma solo se il salvataggio della testa è andato a buon fine
integer li_ret

li_ret=adw_1.triggerevent("ue_update")
//if sqlca.sqlnrows>0 then
//	li_ret=1
//else
//	li_ret=0
//end if
if as_flag=2 and li_ret=1 then	
	li_ret=adw_2.triggerevent("ue_update")
end if

return li_ret
	
	
end function

on w_tab_ra_padre_figlio_cx.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_ricerca=create cb_ricerca
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_ricerca
this.Control[iCurrent+3]=this.cb_inserisci
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.cb_cancella
this.Control[iCurrent+6]=this.cb_annulla
this.Control[iCurrent+7]=this.cb_ok
end on

on w_tab_ra_padre_figlio_cx.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_ricerca)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;call super::open;tab_1.tabpage_1.dw_1.settransobject(sqlca)
tab_1.tabpage_2.dw_2.settransobject(sqlca)

i_dw_corrente=1
tab_1.tabpage_1.dw_1.trigger event ue_insert(0)

	
end event

event resize;call super::resize;cb_inserisci.y=newheight - 224
cb_inserisci.x=tab_1.tabpage_1.dw_1.x
cb_cancella.y=newheight - 224
cb_salva.y=newheight - 224
cb_salva.x=cb_inserisci.x + 285
cb_cancella.x=cb_salva.x + 285
//cb_primo.y=newheight - 208
//cb_primo.x=cb_inserisci.x + 918
//cb_indietro.y=newheight - 208
//cb_indietro.x=cb_primo.x + 160
//cb_avanti.y=newheight - 208
//cb_avanti.x=cb_indietro.x + 160
//cb_ultimo.y=newheight - 208
//cb_ultimo.x=cb_avanti.x + 128
cb_ok.y=newheight - 224
cb_ok.x=newwidth - cb_ok.width - 100
cb_ricerca.y=newheight - 224
cb_ricerca.x=cb_ok.x - 285
cb_annulla.y=newheight - 224
cb_annulla.x=cb_ricerca.x - 285

end event

type tab_1 from tab within w_tab_ra_padre_figlio_cx
event create ( )
event destroy ( )
integer x = 48
integer y = 26
integer width = 4155
integer height = 2160
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
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
integer x = 15
integer y = 106
integer width = 4125
integer height = 2042
long backcolor = 79741120
string text = "Generale"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from udw_001 within tabpage_1
integer x = 55
integer y = 51
integer width = 3931
integer height = 1901
integer taborder = 10
boolean bringtotop = true
boolean maxbox = true
end type

event getfocus;call super::getfocus;i_dw_corrente=1
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_id  //primary key del master da riportare per il retrieve del detail

//se esiste la riga
if currentrow>0 then
	//recupero la primary key dal padre
	ll_id=getitemnumber(currentrow, 1)
	// se esiste PK ..
	if ll_id>0 then
		//la riporto per il retrieve del detail
		tab_1.tabpage_2.dw_2.retrieve(ll_id)
	else
		tab_1.tabpage_2.dw_2.reset()
	end if
else
	tab_1.tabpage_2.dw_2.reset()
end if
//setrowfocusindicator(hand!)
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 15
integer y = 106
integer width = 4125
integer height = 2042
long backcolor = 79741120
string text = "Dettaglio"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from udw_002 within tabpage_2
integer x = 48
integer y = 45
integer width = 3964
integer height = 1914
integer taborder = 30
boolean bringtotop = true
boolean maxbox = true
end type

event getfocus;call super::getfocus;i_dw_corrente=2
end event

event rowfocuschanged;call super::rowfocuschanged;//setrowfocusindicator(hand!)
end event

event ue_post_insert;call super::ue_post_insert;long ll_riga, ll_id
ll_riga=tab_1.tabpage_1.dw_1.getrow()
if ll_riga>0 then
	ll_id=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga, 1)
	if isnull(ll_id)  then
		if wf_salva_dw(tab_1.tabpage_1.dw_1,tab_1.tabpage_2.dw_2, 1)=1 then
			ll_id=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga, 1)
			if ll_id>0 then
				//trigger event ue_post_insert(ll_riga) //al_riga
			end if
		end if
	else
		//ll_riga=dw_2.trigger event ue_insert(0)
		setitem(ll_riga, 1, ll_id)//al_riga
	end if
else
	deleterow(ll_riga)//al_riga
end if

end event

type cb_ricerca from commandbutton within w_tab_ra_padre_figlio_cx
string tag = "Propone la griglia per ricercare per ogni campo visibile."
integer x = 911
integer y = 2211
integer width = 260
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricerca"
end type

type cb_inserisci from commandbutton within w_tab_ra_padre_figlio_cx
string tag = "Inserisce una nuova riga nella finestra che ha il fuoco."
integer x = 33
integer y = 2211
integer width = 260
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;long ll_riga
if i_dw_corrente=1 then
	ll_riga=tab_1.tabpage_1.dw_1.trigger event ue_insert(0)
elseif  i_dw_corrente=2 then
	ll_riga=tab_1.tabpage_2.dw_2.trigger event ue_insert(0)
end if
end event

type cb_salva from commandbutton within w_tab_ra_padre_figlio_cx
string tag = "Salva la finestra che ha il fuoco. Se essa è figlia, salva anche la finestra madre."
integer x = 322
integer y = 2211
integer width = 260
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;if i_dw_corrente=1 then
	wf_salva_dw(tab_1.tabpage_1.dw_1, tab_1.tabpage_2.dw_2, 1)
elseif  i_dw_corrente=2 then
	wf_salva_dw(tab_1.tabpage_1.dw_1,tab_1.tabpage_2. dw_2, 2)
end if
end event

type cb_cancella from commandbutton within w_tab_ra_padre_figlio_cx
string tag = "Cancella la riga selezionata nella finestra che ha il fuoco. Richiede il salvataggio successivo per perfezionare la cancellazione."
integer x = 607
integer y = 2211
integer width = 260
integer height = 96
integer taborder = 70
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
if i_dw_corrente=1 then
	ll_riga_da_cancellare=tab_1.tabpage_1.dw_1.getrow()
	if ll_riga_da_cancellare>0 then
	 	tab_1.tabpage_1.dw_1.trigger event ue_delete(ll_riga_da_cancellare)
		//ripulisco, senza cancellare poché lo farà la FK in cascata al momemnto del update,
		//la dw_2
		tab_1.tabpage_2.dw_2.reset()
	end if
elseif  i_dw_corrente=2 then
	ll_riga_da_cancellare=tab_1.tabpage_2.dw_2.getrow()
	if ll_riga_da_cancellare>0 then
		tab_1.tabpage_2.dw_2.trigger event ue_delete(ll_riga_da_cancellare)
	end if
end if
end event

type cb_annulla from commandbutton within w_tab_ra_padre_figlio_cx
string tag = "Chiude senza salvare nulla."
integer x = 1203
integer y = 2208
integer width = 260
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_tab_ra_padre_figlio_cx
string tag = "Chiude salvando le modifiche."
integer x = 1496
integer y = 2211
integer width = 260
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
	wf_salva_dw(tab_1.tabpage_1.dw_1, tab_1.tabpage_2.dw_2, 2)
end if
close(parent)
end event

