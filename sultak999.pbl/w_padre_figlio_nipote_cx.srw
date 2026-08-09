forward
global type w_padre_figlio_nipote_cx from w_base
end type
type dw_3 from udw_002 within w_padre_figlio_nipote_cx
end type
type cb_ricerca from uo_commandbutton within w_padre_figlio_nipote_cx
end type
type dw_1 from udw_001 within w_padre_figlio_nipote_cx
end type
type dw_2 from udw_002 within w_padre_figlio_nipote_cx
end type
type cb_inserisci from uo_commandbutton within w_padre_figlio_nipote_cx
end type
type cb_salva from uo_commandbutton within w_padre_figlio_nipote_cx
end type
type cb_cancella from uo_commandbutton within w_padre_figlio_nipote_cx
end type
type cb_annulla from uo_commandbutton within w_padre_figlio_nipote_cx
end type
type cb_ok from uo_commandbutton within w_padre_figlio_nipote_cx
end type
end forward

global type w_padre_figlio_nipote_cx from w_base
integer x = 786
integer y = 424
integer width = 2139
integer height = 2036
dw_3 dw_3
cb_ricerca cb_ricerca
dw_1 dw_1
dw_2 dw_2
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_padre_figlio_nipote_cx w_padre_figlio_nipote_cx

type variables
integer i_dw_corrente //1=dw_1, 2=dw_2
end variables

forward prototypes
public function integer wf_salva_dw (ref udw_001 adw_1, ref udw_002 adw_2, udw_002 adw_3, integer as_flag)
end prototypes

public function integer wf_salva_dw (ref udw_001 adw_1, ref udw_002 adw_2, udw_002 adw_3, integer as_flag);//salvo sicuramente la testa (in ogni caso) (dw_1)
//se il flag=2 allora devo salvare anche le righe (dw_2)
//ma solo se il salvataggio della testa è andato a buon fine
integer li_ret

li_ret=adw_1.triggerevent("ue_update")
//if sqlca.sqlnrows>0 then
//	li_ret=1
//else
//	li_ret=0
//end if
if as_flag>1 and li_ret=1 then	
	li_ret=adw_2.triggerevent("ue_update")
	if as_flag=3 and li_ret=1 then
		li_ret=adw_3.triggerevent("ue_update")
	end if
end if

return li_ret
	
	
end function

on w_padre_figlio_nipote_cx.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.cb_ricerca=create cb_ricerca
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.cb_ricerca
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_inserisci
this.Control[iCurrent+6]=this.cb_salva
this.Control[iCurrent+7]=this.cb_cancella
this.Control[iCurrent+8]=this.cb_annulla
this.Control[iCurrent+9]=this.cb_ok
end on

on w_padre_figlio_nipote_cx.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.cb_ricerca)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;call super::open;long ll_id
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
i_dw_corrente=1
//dw_1.trigger event ue_insert(0)

if dw_1.retrieve()>0 then
	ll_id=dw_1.getitemnumber(1,1)
	if dw_2.retrieve(ll_id)>0 then
		ll_id=dw_2.getitemnumber(1, 2)
		dw_3.retrieve(ll_id)
	end if
end if
	
end event

event resize;call super::resize;

cb_inserisci.y=newheight - 224
cb_inserisci.x=dw_1.x
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

type dw_3 from udw_002 within w_padre_figlio_nipote_cx
integer x = 832
integer y = 512
integer width = 937
integer taborder = 30
end type

event getfocus;call super::getfocus;i_dw_corrente=3
end event

event ue_post_insert;call super::ue_post_insert;long ll_id, ll_riga_dw_2

ll_riga_dw_2=dw_2.getrow()
if ll_riga_dw_2>0 then
	ll_id=dw_2.getitemnumber(ll_riga_dw_2, 2)
	if ll_id>0 then
		dw_3.setitem(al_riga, 1, ll_id)
	end if
end if
end event

type cb_ricerca from uo_commandbutton within w_padre_figlio_nipote_cx
string tag = "Propone la griglia per ricercare per ogni campo visibile."
integer x = 923
integer y = 960
integer width = 261
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
string text = "Ricerca"
end type

event clicked;long ll_id, ll_riga

if isvalid(message) then ll_id=message.doubleparm


ll_riga=dw_1.retrieve(ll_id)
if ll_riga>0 then
	dw_1.trigger event rowfocuschanged(ll_riga)
else
	cb_inserisci.triggerevent(clicked!)
end if
end event

type dw_1 from udw_001 within w_padre_figlio_nipote_cx
integer x = 69
integer y = 52
integer width = 1746
integer taborder = 10
boolean bringtotop = true
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_id  //primary key del master da riportare per il retrieve del detail

//se esiste la riga
if currentrow>0 then
	//recupero la primary key dal padre
	ll_id=getitemnumber(currentrow, 1)
	// se esiste PK ..
	if ll_id>=0 then
		//la riporto per il retrieve del detail
		if dw_2.retrieve(ll_id) >0 then
			dw_2.trigger event Rowfocuschanged(1)
		end if
	else
		dw_2.reset()
	end if
else
	dw_2.reset()
end if
//setrowfocusindicator(hand!)
end event

event getfocus;call super::getfocus;i_dw_corrente=1
end event

type dw_2 from udw_002 within w_padre_figlio_nipote_cx
integer x = 69
integer y = 488
integer width = 677
integer taborder = 20
boolean bringtotop = true
end type

event getfocus;call super::getfocus;i_dw_corrente=2
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_id  //primary key del master da riportare per il retrieve del detail

//se esiste la riga
if currentrow>0 then
	//recupero la primary key dal padre
	ll_id=getitemnumber(currentrow, 2)
	// se esiste PK ..
	if ll_id>=0 then
		//la riporto per il retrieve del detail
		dw_3.retrieve(ll_id)
	else
		dw_3.reset()
	end if
else
	dw_3.reset()
end if
//setrowfocusindicator(hand!)
end event

event ue_post_insert;call super::ue_post_insert;long ll_riga, ll_id
ll_riga=dw_1.getrow()
if ll_riga>0 then
	ll_id=dw_1.getitemnumber(ll_riga, 1)
	if isnull(ll_id)  then
		if wf_salva_dw(dw_1,dw_2,dw_3, 1)=1 then
			ll_id=dw_1.getitemnumber(ll_riga, 1)
			if ll_id > 0 then
				trigger event ue_post_insert(al_riga)
			end if
		end if
	else
		//ll_riga=dw_2.trigger event ue_insert(0)
		setitem(al_riga, 1, ll_id)
	end if
else
	deleterow(al_riga)
end if

end event

type cb_inserisci from uo_commandbutton within w_padre_figlio_nipote_cx
string tag = "Inserisce una nuova riga nella finestra che ha il fuoco."
integer x = 46
integer y = 960
integer width = 261
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string text = "Inserisci"
end type

event clicked;long ll_riga
if i_dw_corrente=1 then
	ll_riga=dw_1.trigger event ue_insert(0)
elseif  i_dw_corrente=2 then
	ll_riga=dw_2.trigger event ue_insert(0)
elseif  i_dw_corrente=3 then
	ll_riga=dw_3.trigger event ue_insert(0)
end if
end event

type cb_salva from uo_commandbutton within w_padre_figlio_nipote_cx
string tag = "Salva la finestra che ha il fuoco. Se essa è figlia, salva anche la finestra madre."
integer x = 334
integer y = 960
integer width = 261
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
string text = "Salva"
end type

event clicked;if i_dw_corrente=1 then
	wf_salva_dw(dw_1, dw_2,dw_3, 1)
elseif  i_dw_corrente=2 then
	wf_salva_dw(dw_1, dw_2,dw_3, 2)
elseif  i_dw_corrente=3 then
	wf_salva_dw(dw_1, dw_2, dw_3,3)
end if
end event

type cb_cancella from uo_commandbutton within w_padre_figlio_nipote_cx
string tag = "Cancella la riga selezionata nella finestra che ha il fuoco. Richiede il salvataggio successivo per perfezionare la cancellazione."
integer x = 622
integer y = 960
integer width = 261
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
if i_dw_corrente=1 then
	ll_riga_da_cancellare=dw_1.getrow()
	if ll_riga_da_cancellare>0 then
	 	dw_1.trigger event ue_delete(ll_riga_da_cancellare)
		//ripulisco, senza cancellare poché lo farà la FK in cascata al momemnto del update,
		//la dw_2
		dw_2.reset()
		dw_3.reset()
	end if
elseif  i_dw_corrente=2 then
	ll_riga_da_cancellare=dw_2.getrow()
	if ll_riga_da_cancellare>0 then
		dw_2.trigger event ue_delete(ll_riga_da_cancellare)
		dw_3.reset()
	end if
elseif  i_dw_corrente=3 then
	ll_riga_da_cancellare=dw_3.getrow()
	if ll_riga_da_cancellare>0 then
		dw_3.trigger event ue_delete(ll_riga_da_cancellare)
	end if
end if
end event

type cb_annulla from uo_commandbutton within w_padre_figlio_nipote_cx
string tag = "Chiude senza salvare nulla."
integer x = 1216
integer y = 956
integer width = 261
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_ok from uo_commandbutton within w_padre_figlio_nipote_cx
string tag = "Chiude salvando le modifiche."
integer x = 1509
integer y = 960
integer width = 261
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
string text = "Ok"
end type

event clicked;if messagebox("Salvare?", "Salvare i dati prima di chiudere?", stopsign!, yesno!)=1 then
	wf_salva_dw(dw_1, dw_2, dw_3, 3)
end if
close(parent)
end event

