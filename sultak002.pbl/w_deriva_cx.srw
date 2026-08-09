forward
global type w_deriva_cx from w_base
end type
type dw_3 from udw_001 within w_deriva_cx
end type
type dw_2 from udw_000 within w_deriva_cx
end type
type cb_annulla from commandbutton within w_deriva_cx
end type
type cb_ok from commandbutton within w_deriva_cx
end type
type dw_1 from udw_001 within w_deriva_cx
end type
end forward

global type w_deriva_cx from w_base
integer width = 3890
integer height = 2444
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_3 dw_3
dw_2 dw_2
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_deriva_cx w_deriva_cx

type variables
long al_id_iva_soggetto
string as_iva_in_derivazione
end variables

forward prototypes
public subroutine wf_chiudi_riga (long al_row)
public subroutine wf_recupera_spese ()
public subroutine wf_gestisci_cl (long al_riga)
public subroutine wf_chiudi_doc (long al_row)
end prototypes

public subroutine wf_chiudi_riga (long al_row);long ll_id_riga
if messagebox("Attenzione!", "Vuoi davvero evadere forzatamente la riga?", stopsign!, yesno!)=1 then
	//dw_1.triggerevent("ue_update")
	ll_id_riga=dw_1.getitemnumber(al_row, "rdoc_rdoc_id")
	update dba.rdoc
	set chius_forzata='S'
	where rdoc_id=:ll_id_riga;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox( "Doc. Selezionati: Salvataggio non riuscito!",sqlca.sqlerrtext)
	end if
end if
end subroutine

public subroutine wf_recupera_spese ();long ll_righe,  ll_id_doc, ll_null, ll_riga_paga, ll_paga_id
long ll_righe_ds, ll_paga_id_esistente, ll_id_spesa,ll_id_doc_old, ll_id_iva
datastore ds_spese
integer i, li_riga_trovata
decimal ldc_valore, ldc_perc

//per ora va bene anche così. appena hai tempo ottimizza!

ll_righe=dw_2.rowcount()
//metto in ordine per documento (in modo che le righe dello stesso doc
//siano una di seguito all'altra
dw_2.sort()
for i= 1 to ll_righe
	//controllo che sia cambiato il documento (altrimenti ho già fatto tutto)
	ll_id_doc_old=ll_id_doc 
	ll_id_doc=dw_2.getitemnumber(1, "rdoc_doc_id")
	if ll_id_doc_old=ll_id_doc then continue
	//inizio
	ll_riga_paga=dw_1.find("doc_doc_id="+string(ll_id_doc), 1, dw_1.rowcount())
	if ll_riga_paga>0 then
		ll_paga_id=dw_1.getitemnumber(ll_riga_paga, "doc_paga_id")
	end if
	
	if ll_paga_id>0 then
		ll_paga_id_esistente=w_doc_ff.tab_1.tabpage_1.dw_1.getitemnumber(1, "paga_id")
		//se esiste già un id_pagamento allora deve essere uguale altrimenti segnalo l'errore
		if ll_paga_id_esistente>0 then
			if ll_paga_id_esistente<>ll_paga_id then
				messagebox("Attenzione!", "Si sta derivando un documento con diverso tipo di pagamento"+&
				"da quello già esistente! Il nuovo tipo di pagamento non sarà recuperato.")
			end if
		else //se non esiste lo riporto
			w_doc_ff.tab_1.tabpage_1.dw_1.setitem(1, "paga_id", ll_paga_id)
		end if
	//fine recupero pagamento
	end if
	//per recuperare le spese faccio il retrieve della finestra spese
	//nel doc e poi cambio lo status (se ci sono due doc da derivare non funge)
	//allora cambio: faccio il retrieve in una datastore e aggiungo il contenuto
	//alla dw spese del doc
	ds_spese=create datastore
	ds_spese.dataobject="d_sp_doc_gd"
	ds_spese.settransobject(sqlca)
	ll_righe_ds=ds_spese.retrieve(ll_id_doc)
	ll_righe=w_doc_ff.tab_1.tabpage_1.dw_4.rowcount()
	
	ll_id_doc=w_doc_ff.tab_1.tabpage_1.dw_1.getitemnumber(1, "doc_id")
	
	for i=1 to ll_righe_ds
		//per ogni tipo di spesa trovata prendo il tipo
		ll_id_spesa=ds_spese.getitemnumber(i, "spesa_id")
		ldc_valore=ds_spese.getitemdecimal(i, "sp_doc_importo")
		li_riga_trovata=w_doc_ff.tab_1.tabpage_1.dw_4.find("spesa_id="+string(ll_id_spesa), 1, ll_righe)
		if li_riga_trovata<=0 then
			//ldc_valore += w_doc_ff.tab_1.tabpage_1.dw_4.getitemdecimal(li_riga_trovata, "sp_doc_importo")
		//else
			li_riga_trovata=w_doc_ff.tab_1.tabpage_1.dw_4.insertrow(0)
			w_doc_ff.tab_1.tabpage_1.dw_4.setitem(li_riga_trovata, "spesa_id",ll_id_spesa)
			ll_id_iva=ds_spese.getitemnumber(i, "iva_id")
			ldc_perc=ds_spese.getitemnumber(i, "sp_doc_percentuale")
			w_doc_ff.tab_1.tabpage_1.dw_4.setitem(li_riga_trovata, "sp_doc_percentuale",ldc_perc)
			w_doc_ff.tab_1.tabpage_1.dw_4.setitem(li_riga_trovata, "iva_id",ll_id_iva)
		end if
		w_doc_ff.tab_1.tabpage_1.dw_4.setitem(li_riga_trovata, "sp_doc_importo", ldc_valore)
		w_doc_ff.tab_1.tabpage_1.dw_4.setitem(li_riga_trovata, "doc_id", ll_id_doc)
//		w_doc_ff.tab_1.tabpage_1.dw_4.setitemstatus(li_riga_trovata, 0, Primary!, newModified!)
	
	next
	
	
next


end subroutine

public subroutine wf_gestisci_cl (long al_riga);//
end subroutine

public subroutine wf_chiudi_doc (long al_row);long ll_id_doc
if messagebox("Attenzione!", "Vuoi davvero evadere forzatamente il documento intero?", stopsign!, yesno!)=1 then
	//dw_1.triggerevent("ue_update")
	ll_id_doc=dw_3.getitemnumber(al_row, "doc_doc_id")
	update dba.rdoc
	set chius_forzata='S'
	where rdoc_doc_id=:ll_id_doc;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox( "Doc. Selezionati: Salvataggio non riuscito!",sqlca.sqlerrtext)
	end if
end if
end subroutine

event open;call super::open;long ll_id
s_deriva s_der
string ls_azienda


dw_2.settransobject(sqlca)
s_der=message.powerobjectparm
//if s_der.s_evadi_per="F" then
//	dw_3.DATAOBJECT="d_doc_da_evadere_foma"
//	dw_1.DATAOBJECT="d_rdoc_da_evadere_foma"
//end if
//select az_codice
//into :ls_azienda
//from dba.azienda;
//if pos(upper(ls_azienda),'FOMA')>0 then
//	dw_3.DATAOBJECT="d_doc_da_evadere_foma"
//	dw_1.DATAOBJECT="d_rdoc_da_evadere_foma"
//end if

dw_3.settransobject(sqlca)
dw_1.settransobject(sqlca)



 dw_3.retrieve(s_der.s_id_conto, s_der.s_id_guida, s_der.s_da_data, s_der.s_a_data)

end event

on w_deriva_cx.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.dw_2=create dw_2
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_annulla
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.dw_1
end on

on w_deriva_cx.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;long ll_id_conto
if dw_3.rowcount()>0 then
	ll_id_conto=dw_3.getitemnumber(1, "doc_doc_conto_id")
	select iva_id
	into :al_id_iva_soggetto
	from dba.conto
	where conto_id=:ll_id_conto
	;
	select iva_in_derivazione
	into :as_iva_in_derivazione
	from dba.val_base
	;
	if isnull(as_iva_in_derivazione) then as_iva_in_derivazione='D'
end if
end event

type dw_3 from udw_001 within w_deriva_cx
integer x = 37
integer y = 32
integer width = 3790
integer height = 564
integer taborder = 10
string dataobject = "d_doc_da_evadere"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;long ll_id_doc, ll_riga, ll_null
decimal ld_qta_residua, ld_peso_residuo
long ll_righe

if row >0 then
	choose case dwo.name
		case "scelto" 
			ll_id_doc=getitemnumber(row, "doc_doc_id")
			if data='S' then
				dw_1.retrieve(ll_id_doc)
				ll_righe=dw_1.rowcount()
		
				do 
					ll_riga++
					ll_riga=dw_1.find("doc_doc_id="+string(ll_id_doc), ll_riga, ll_righe )
					if ll_riga>0  then
						dw_1.trigger event itemchanged(ll_riga, dw_1.object.scelto, "S")
						dw_1.setitem(ll_riga, "scelto", "S")
					else
						exit
					end if
				loop while ll_riga>0 and ll_riga < ll_righe
			else
				ll_righe=dw_1.rowcount()
				do 
					ll_riga++
					ll_riga=dw_1.find("doc_doc_id="+string(ll_id_doc),ll_riga, ll_righe )
					if ll_riga>0 then
						dw_1.trigger event itemchanged(ll_riga, dw_1.object.scelto, "N")
						dw_1.deleterow(ll_riga)
						ll_righe --
					else
						exit
					end if
				loop while ll_riga>0 and ll_riga <= ll_righe
			end if
		case "doc_chius_forzata"
			wf_chiudi_doc(row)	
		
	end choose
end if
end event

event clicked;call super::clicked;INTEGER I

if dwo.name='b_sel' then
	for i= 1 to dw_3.rowcount()
		dw_3.trigger event itemchanged(i, dw_3.object.scelto, "S")
		dw_3.SETITEM(i, "scelto", "S")
	next
end if
end event

type dw_2 from udw_000 within w_deriva_cx
integer x = 37
integer y = 1356
integer width = 3790
integer height = 572
integer taborder = 20
string dataobject = "d_rdoc_deriva_gd"
boolean vscrollbar = true
end type

event retrievestart;call super::retrievestart;return 2
end event

type cb_annulla from commandbutton within w_deriva_cx
integer x = 599
integer y = 1988
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
boolean cancel = true
end type

event clicked;string ls_test='NO'
closewithreturn(parent, ls_test)
end event

type cb_ok from commandbutton within w_deriva_cx
integer x = 2615
integer y = 1996
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
boolean default = true
end type

event clicked;long ll_righe, ll_riga, ll_id_riga, ll_null, ll_id_guida
integer i, li_num_riga
string ls_test='NO'
boolean lb_spese
long ll_doc_id, ll_caus_id, ll_mag_id

ll_righe=dw_2.rowcount()
if ll_righe>0 then
	ll_riga=w_doc_ff.tab_1.tabpage_2.dw_2.rowcount()
	if isnull(ll_riga) or ll_riga<1 then ll_riga=0
	//proviamo
	w_doc_ff.setredraw(false)
	li_num_riga=ll_riga
	if isnull(li_num_riga) then li_num_riga=0
	setnull(ll_null)
	ll_doc_id=w_doc_ff.tab_1.tabpage_1.dw_1.getitemnumber(1, "doc_id")
	//recupero causale e magazzino
	ll_id_guida=w_doc_ff.tab_1.tabpage_1.dw_1.getitemnumber(1, "guida_id")
	select guida_caus_id, guida_id_magazzino
	into :ll_caus_id, :ll_mag_id
	from dba.guida
	where guida_id=:ll_id_guida
	;
	for i=1 to ll_righe
		li_num_riga++
		ll_id_riga=dw_2.getitemnumber(i, "rdoc_id")
		dw_2.setitem(i, "rdoc_id_riga_madre", ll_id_riga)
		dw_2.setitem(i, "rdoc_id", ll_null)
		dw_2.setitem(i, "finoecalo_evaso", 0)
		dw_2.setitem(i, "rdoc_peso_evaso", 0)
		dw_2.setitem(i, "rdoc_qta_evasa", 0)
		
		dw_2.setitem(i, "rdoc_numero",li_num_riga)
		dw_2.setitem(i, "rdoc_doc_id", ll_doc_id)
		//anche causale e magazzino
		dw_2.setitem(i, "causale_id", ll_caus_id)
		dw_2.setitem(i, "mag_id", ll_mag_id)	

	next
	dw_2.rowscopy(1, ll_righe, primary!, w_doc_ff.tab_1.tabpage_2.dw_2, ll_riga+1,  primary! )
	wf_recupera_spese()
	w_doc_ff.setredraw(true)
	ls_test='OK'
end if

closewithreturn(parent, ls_test)
//s_deriva s_der
//s_der.s_udw_riga=dw_2
//
//ll_righe=s_der.s_udw_riga.rowcount()
//
//
//if ll_righe>0 then
//	closewithreturn(parent, s_der)
//else
	
	
	
	
//end if
end event

type dw_1 from udw_001 within w_deriva_cx
integer x = 37
integer y = 620
integer width = 3790
integer height = 716
integer taborder = 10
string dataobject = "d_rdoc_da_evadere"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;long ll_id_riga, ll_riga, ll_null, ll_caus_id, ll_guida,ll_id_iva
long ll_id_tit, ll_id_um, ll_art_id, ll_id_met_art_da_usare, ll_id_met_derivato, ll_id_titolo_da_derivare
decimal ld_qta_residua, ld_peso_residuo, ld_finocalo_residuo, ld_ccalo
string ls_causale_cl, ls_Des

if row >0 then
	choose case dwo.name
		case "scelto" 
			ll_id_riga=getitemnumber(row, "rdoc_rdoc_id")
			if data='S' then
				dw_2.retrieve(ll_id_riga)
				ll_riga=dw_2.find("rdoc_id="+string(ll_id_riga), 1, dw_2.rowcount())
				ld_qta_residua=getitemdecimal(row, "c_qta_residua")
				ld_finocalo_residuo=getitemdecimal(row, "c_finocalo_residuo")
				//controllo se è causale con partita di CL
				//nel caso recupero l'eventuale articolo specificato in dba.guida
				ll_caus_id=getitemnumber(row, "rdoc_causale_id")
				select caus_partita
				into :ls_causale_cl
				from dba.causale
				where caus_id=:ll_caus_id
				;
				if ls_causale_cl='CL' then
					//wf_gestisci_cl(row)
					//trovare la guida
					ll_guida=w_doc_ff.tab_1.tabpage_1.dw_1.getitemnumber(1, "guida_id")
					//recuperare art per cl
					select guida_art_id
					into :ll_art_id
					from dba.guida
					where guida_id=:ll_guida
					;
					if ll_art_id>0 then
						//recuperare il coef_calo e il titolo e l resto
						select art_descrizione, art_tit_preferenziale, art_calo_preferenziale,  um_id, t.tit_met_id
						into :ls_des, :ll_id_tit, :ld_ccalo, :ll_id_um, :ll_id_met_art_da_usare
						from dba.art a, dba.titolo t
						where art_id= :ll_art_id
						and a.art_tit_preferenziale=t.tit_id
						;
						//se (e solo se) l'art per il conto lavarazione è dello stesso metallo allora lo posso usare
						ll_id_titolo_da_derivare=dw_2.getitemnumber(ll_riga, "tit_id")
						select tit_met_id
						into :ll_id_met_derivato
						from dba.titolo
						where tit_id=:ll_id_titolo_da_derivare
						;
						if ll_id_met_art_da_usare=ll_id_met_derivato then
							dw_2.setitem(ll_riga, "rdoc_art_id", ll_art_id)
							if ls_des>"" then
								dw_2.setitem(ll_riga, "rdoc_descrizione", ls_Des)
							end if
							if ll_id_tit>0  then
								dw_2.setitem(ll_riga, "tit_id", ll_id_tit)
							end if
							if ld_ccalo>0  then
								dw_2.setitem(ll_riga, "rdoc_calo", ld_ccalo)
							end if
						end if
					else
						ld_ccalo=getitemdecimal(row, "rdoc_rdoc_calo") 
					end if
					ll_id_titolo_da_derivare=dw_2.getitemnumber(ll_riga, "tit_id")
					if ld_ccalo=0 or isnull(ld_ccalo) then ld_ccalo=getitemdecimal(row, "rdoc_rdoc_calo") 
					if ld_ccalo=0 or isnull(ld_ccalo) then
						if isnull(ll_id_tit) or ll_id_tit=0 then ll_id_tit= ll_id_titolo_da_derivare
						if ll_id_tit>0 then
							select tit_titolo into :ld_ccalo from dba.titolo where tit_id=:ll_id_tit;	
							dw_2.setitem(ll_riga, "rdoc_calo", ld_ccalo)
						end if
					end if
					if ld_ccalo=0 or isnull(ld_ccalo) then
						messagebox("Attenzione!", "Calo non trovato! Metto calo 1000! Riga: "+string(ll_riga))
						ld_ccalo=1000
					end if
					ld_peso_residuo=ld_finocalo_residuo*1000/ld_ccalo
					
				else
					ld_peso_residuo=getitemdecimal(row, "c_peso_residuo")
				end if
						
				dw_2.setitem(ll_riga, "rdoc_qta", ld_qta_residua)
				dw_2.setitem(ll_riga, "rdoc_peso", ld_peso_residuo)
				//nel momento in cui derivo una nova riga il suo fino_calo evaso=0, se non lo faccio prende quello della riga madre!
				dw_2.setitem(ll_riga, "finoecalo_evaso", 0)
				//2016-02-26 controllo iva se è concorde a quella dell'intestatario del doc
				ll_id_iva=dw_2.getitemnumber(ll_riga, "iva_id")
				if isnull(al_id_iva_soggetto) then al_id_iva_soggetto=ll_id_iva
				if ll_id_iva<>al_id_iva_soggetto then //se non concorda metto quella del soggetto
					if as_iva_in_derivazione='I' then //se è="I" (metti iva intestatario) la metto
						dw_2.setitem(ll_riga, "iva_id", al_id_iva_soggetto)
					end if
				end if
				
			else
				ll_riga=dw_2.find("rdoc_id="+string(	ll_id_riga), 1, dw_2.rowcount())
				if ll_riga>0 then
					dw_2.deleterow(ll_riga)
				end if
			end if
		case "rdoc_chius_forzata"
			wf_chiudi_riga(row)	
		case "doc_chius_forzata"
			
			
	end choose
end if
end event

event doubleclicked;//
end event

event retrievestart;call super::retrievestart;return 2
end event

