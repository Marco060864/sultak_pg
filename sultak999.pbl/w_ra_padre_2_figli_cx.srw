forward
global type w_ra_padre_2_figli_cx from w_base
end type
type dw_2 from udw_001 within w_ra_padre_2_figli_cx
end type
type dw_3 from udw_001 within w_ra_padre_2_figli_cx
end type
type dw_1 from udw_001 within w_ra_padre_2_figli_cx
end type
type cb_inserisci from uo_commandbutton within w_ra_padre_2_figli_cx
end type
type cb_salva from uo_commandbutton within w_ra_padre_2_figli_cx
end type
type cb_cancella from uo_commandbutton within w_ra_padre_2_figli_cx
end type
type cb_annulla from uo_commandbutton within w_ra_padre_2_figli_cx
end type
type cb_ok from uo_commandbutton within w_ra_padre_2_figli_cx
end type
end forward

global type w_ra_padre_2_figli_cx from w_base
integer x = 786
integer y = 424
integer width = 3067
integer height = 1308
dw_2 dw_2
dw_3 dw_3
dw_1 dw_1
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_ra_padre_2_figli_cx w_ra_padre_2_figli_cx

type variables
udw_001 i_dw_corrente //1=dw_1, 2=dw_2
integer il_giri=0
end variables

forward prototypes
public function integer wf_salva_dw (ref udw_001 adw_1, ref udw_001 adw_2, integer as_flag, ref udw_001 adw_3)
end prototypes

public function integer wf_salva_dw (ref udw_001 adw_1, ref udw_001 adw_2, integer as_flag, ref udw_001 adw_3);//salvo sicuramente la testa (in ogni caso) (dw_1)
//se il flag=2 allora devo salvare anche le righe (dw_2)
//ma solo se il salvataggio della testa è andato a buon fine
integer li_ret

li_ret=adw_1.trigger event ue_update()

if as_flag=2 and li_ret=1 then	
	li_ret=adw_2.trigger event ue_update()
	li_ret=adw_3.trigger event ue_update()
end if
return li_ret
	
	
end function

on w_ra_padre_2_figli_cx.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_1=create dw_1
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_inserisci
this.Control[iCurrent+5]=this.cb_salva
this.Control[iCurrent+6]=this.cb_cancella
this.Control[iCurrent+7]=this.cb_annulla
this.Control[iCurrent+8]=this.cb_ok
end on

on w_ra_padre_2_figli_cx.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_1)
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

 i_dw_corrente=dw_1
cb_inserisci.post event clicked()

//if dw_1.retrieve()>0 then
//	ll_id=dw_1.getitemnumber(1,1)
//	dw_2.retrieve(ll_id)
//	dw_3.retrieve(ll_id)
//end if
	
end event

type dw_2 from udw_001 within w_ra_padre_2_figli_cx
integer x = 73
integer y = 496
integer width = 1115
integer taborder = 30
end type

event getfocus;call super::getfocus;i_dw_corrente=this
end event

type dw_3 from udw_001 within w_ra_padre_2_figli_cx
integer x = 1641
integer y = 492
integer width = 1271
integer taborder = 20
boolean bringtotop = true
end type

event getfocus;call super::getfocus;i_dw_corrente=this
end event

event rowfocuschanged;call super::rowfocuschanged;//long ll_id  //primary key del master da riportare per il retrieve del detail
//
////se esiste la riga
//if currentrow>0 then
//	//recupero la primary key dal padre
//	ll_id=getitemnumber(currentrow, 1)
//	// se esiste PK ..
//	if ll_id>0 then
//		//la riporto per il retrieve del detail
//		dw_2.retrieve(ll_id)
//	else
//		dw_2.reset()
//	end if
//end if
//
end event

event ue_post_insert;call super::ue_post_insert;long ll_id  //primary key del master da riportare per il retrieve del detail

//se esiste la riga
//
//	//recupero la primary key dal padre
//	ll_id=getitemnumber(currentrow, 1)
//	// se esiste PK ..
//	if ll_id>0 then
//		
//	else
//		dw_2.reset()
//	end if
//end if
end event

type dw_1 from udw_001 within w_ra_padre_2_figli_cx
integer x = 55
integer y = 36
integer width = 2953
integer taborder = 1
boolean bringtotop = true
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_id  //primary key del master da riportare per il retrieve del detail

//se esiste la riga
if currentrow>0 then
	//recupero la primary key dal padre
	ll_id=getitemnumber(currentrow, 1)
	// se esiste PK ..
	if ll_id>0 then
		//la riporto per il retrieve del detail
		dw_2.retrieve(ll_id)
		dw_3.retrieve(ll_id)
	else
		dw_2.reset()
		dw_3.reset()
	end if
end if

end event

event getfocus;call super::getfocus;i_dw_corrente=this
end event

type cb_inserisci from uo_commandbutton within w_ra_padre_2_figli_cx
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

event clicked;long ll_riga, ll_id
if i_dw_corrente=dw_1 then
	dw_1.reset()
	ll_riga=dw_1.trigger event ue_insert(0)
else
	ll_riga=dw_1.getrow()
	if ll_riga>0 then
		ll_id=dw_1.getitemnumber(ll_riga, 1)
		if isnull(ll_id) and il_giri=0 then
			if wf_salva_dw(dw_1,dw_2, 1, dw_3)=1 then
				il_giri=1
				this.triggerevent(clicked!)				
			
			else
				messagebox("Attenzione!", "Salvataggio testa non riuscito!")			
			end if
		elseif   isnull(ll_id) and il_giri=1 then
			il_giri=0
			messagebox("Attenzione!", "Salvataggio testa non riuscito!")
		else
			ll_riga=i_dw_corrente.trigger event ue_insert(0)
			i_dw_corrente.setitem(ll_riga, 1, ll_id)
		end if
	end if
end if
end event

type cb_salva from uo_commandbutton within w_ra_padre_2_figli_cx
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

event clicked;if i_dw_corrente=dw_1 then
	wf_salva_dw(dw_1, dw_2, 1, dw_3)
else
	wf_salva_dw(dw_1, dw_2, 2, dw_3)
end if
end event

type cb_cancella from uo_commandbutton within w_ra_padre_2_figli_cx
string tag = "Cancella la riga selezionata nella finestra che ha il fuoco. Richiede il salvataggio successivo per perfezionare la cancellazione."
integer x = 622
integer y = 960
integer width = 261
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
if i_dw_corrente=dw_1 then
	ll_riga_da_cancellare=dw_1.getrow()
	if ll_riga_da_cancellare>0 then
	 	dw_1.trigger event ue_delete(ll_riga_da_cancellare)
		//ripulisco, senza cancellare poché lo farà la FK in cascata al momemnto del update,
		//la dw_2
		dw_2.reset()
		dw_3.reset()
	end if
else 
	ll_riga_da_cancellare=i_dw_corrente.getrow()
	if ll_riga_da_cancellare>0 then
		i_dw_corrente.trigger event ue_delete(ll_riga_da_cancellare)
	end if
end if
end event

type cb_annulla from uo_commandbutton within w_ra_padre_2_figli_cx
string tag = "Chiude senza salvare nulla."
integer x = 1106
integer y = 964
integer width = 261
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_ok from uo_commandbutton within w_ra_padre_2_figli_cx
string tag = "Chiude salvando le modifiche."
integer x = 1399
integer y = 960
integer width = 261
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
string text = "Ok"
boolean default = true
end type

event clicked;if messagebox("Salvare?", "Salvare i dati prima di chiudere?", stopsign!, yesno!)=1 then
	wf_salva_dw(dw_1, dw_2, 2, dw_3)
end if
close(parent)
end event

