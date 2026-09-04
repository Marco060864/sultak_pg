forward
global type w_doc_ff from w_base
end type
type pb_bilancia from picturebutton within w_doc_ff
end type
type dw_cod_barre from udw_000 within w_doc_ff
end type
type cb_nuovo_doc from commandbutton within w_doc_ff
end type
type cb_duplica from uo_commandbutton within w_doc_ff
end type
type cb_esplodi from uo_commandbutton within w_doc_ff
end type
type cb_stampa from uo_commandbutton within w_doc_ff
end type
type cb_cancella from uo_commandbutton within w_doc_ff
end type
type cb_salva from uo_commandbutton within w_doc_ff
end type
type cb_inserisci from uo_commandbutton within w_doc_ff
end type
type cb_annulla from uo_commandbutton within w_doc_ff
end type
type cb_ok from uo_commandbutton within w_doc_ff
end type
type tab_1 from tab within w_doc_ff
end type
type tabpage_1 from userobject within tab_1
end type
type cb_canc_doc from commandbutton within tabpage_1
end type
type cbx_cc_num_doc from checkbox within tabpage_1
end type
type cbx_riga_automatica from checkbox within tabpage_1
end type
type cbx_ric_num_prog from checkbox within tabpage_1
end type
type cb_deriva from uo_cmdbutton_for_tab within tabpage_1
end type
type dw_6 from udw_001 within tabpage_1
end type
type dw_4 from udw_001 within tabpage_1
end type
type cb_ricerca from uo_cmdbutton_for_tab within tabpage_1
end type
type dw_1 from udw_001 within tabpage_1
end type
type dw_3 from udw_001 within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_canc_doc cb_canc_doc
cbx_cc_num_doc cbx_cc_num_doc
cbx_riga_automatica cbx_riga_automatica
cbx_ric_num_prog cbx_ric_num_prog
cb_deriva cb_deriva
dw_6 dw_6
dw_4 dw_4
cb_ricerca cb_ricerca
dw_1 dw_1
dw_3 dw_3
end type
type tabpage_2 from userobject within tab_1
end type
type cbx_1 from checkbox within tabpage_2
end type
type dw_10 from udw_001 within tabpage_2
end type
type cbx_calo_cambia_peso from checkbox within tabpage_2
end type
type cbx_in_derivazione from checkbox within tabpage_2
end type
type dw_12 from udw_000 within tabpage_2
end type
type dw_9 from udw_001 within tabpage_2
end type
type dw_7 from datawindow within tabpage_2
end type
type dw_5 from udw_000 within tabpage_2
end type
type dw_8 from udw_002 within tabpage_2
end type
type dw_2 from udw_001 within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cbx_1 cbx_1
dw_10 dw_10
cbx_calo_cambia_peso cbx_calo_cambia_peso
cbx_in_derivazione cbx_in_derivazione
dw_12 dw_12
dw_9 dw_9
dw_7 dw_7
dw_5 dw_5
dw_8 dw_8
dw_2 dw_2
end type
type tab_1 from tab within w_doc_ff
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type internetresult_1 from internetresult within w_doc_ff
end type
end forward

global type w_doc_ff from w_base
integer width = 4859
integer height = 2452
boolean resizable = false
string icon = "AppIcon!"
boolean center = true
pb_bilancia pb_bilancia
dw_cod_barre dw_cod_barre
cb_nuovo_doc cb_nuovo_doc
cb_duplica cb_duplica
cb_esplodi cb_esplodi
cb_stampa cb_stampa
cb_cancella cb_cancella
cb_salva cb_salva
cb_inserisci cb_inserisci
cb_annulla cb_annulla
cb_ok cb_ok
tab_1 tab_1
internetresult_1 internetresult_1
end type
global w_doc_ff w_doc_ff

type variables
udw_001 idw_corrente
boolean ib_nochangerow, ib_applica_filtro
//20260809 true durante il salvataggio "di servizio" fatto solo per ottenere
//rdoc_id prima di aprire la gestione partite: blocca il ricalcolo del castelletto
boolean ib_no_ricalcolo
string is_scorporo_iva, is_ultimo_campo
long il_riga_corrente

end variables

forward prototypes
public subroutine wf_aggiorna_titolo (long al_riga_corrente)
public subroutine wf_calcola_totale ()
public subroutine wf_calcola_spese ()
public subroutine wf_apertura_da_stampe (long al_id_doc)
public subroutine wf_calcola_scadenze ()
public subroutine wf_copia_righe (s_riga_derivata ast_riga)
public subroutine wf_carica_dddw ()
public subroutine wf_carica_destinazioni (long al_conto)
public subroutine wf_carica_pagamento (long al_conto)
public subroutine wf_dati_articolo (long al_row, long al_art_id)
public subroutine wf_carica_banca (long al_conto)
public subroutine wf_calcola_saldo ()
public subroutine wf_scorporo_iva (long al_id_guida)
public subroutine wf_allinea_cod_clfo (long al_riga, long al_id_art)
public subroutine wf_copia_in_basso (string as_colonna, decimal adc_valore, long row)
public subroutine wf_inserisci_spese ()
public subroutine wf_allinea_es_articolo (long al_art_id)
public function integer wf_filtra_intestatari (string as_prefisso)
public subroutine wf_calcola_saldo_derivazione (long al_riga)
public subroutine wf_storna_acconto (integer ai_rate, string as_prima_rata, decimal ad_tot_doc)
public subroutine wf_carica_valuta_cambio (long al_conto)
public subroutine wf_carica_spese (long al_id_conto)
public subroutine wf_scarico_automatico (decimal adc_peso_vecchio, decimal adc_peso_nuovo, long al_num_riga)
public subroutine wf_coerenza_reg_documento ()
public subroutine wf_riga_automatica ()
public subroutine wf_metti_des_marco (long al_id_art, long al_row)
public function long wf_crea_articolo (string as_codice, long al_riga, long al_id_cat_codifica)
public subroutine wf_allinea_finocalo (long al_riga)
public subroutine wf_gestisci_partita_oro (string as_peso, long al_row, decimal adc_peso_originale)
protected subroutine wf_campi_trasporto (long al_id_guida)
public subroutine wf_allinea_ddt_collegati (long al_riga)
public function decimal wf_scarica_partite_auto (s_partita_oro astr)
end prototypes

public subroutine wf_aggiorna_titolo (long al_riga_corrente);if al_riga_corrente>0 then
	title= "Documento n° "+tab_1.tabpage_1.dw_1.getitemstring(al_riga_corrente, "doc_numero") &
							+ " del "+string(tab_1.tabpage_1.dw_1.getitemdate(al_riga_corrente, "doc_data"))
else
	title= "Documento ... "
end if
end subroutine

public subroutine wf_calcola_totale ();//calcola i totali del castelletto iVA del documento
long ll_breakrow, ll_iva_id, ll_id_iva_sconto_imp, ll_id_doc
integer i, li_riga_iva
decimal{3} ldc_imp, ldc_iva, ldc_imp_met, ldc_sc_imp, ldc_sc_perc, ldc_acconto
boolean lb_sconto_imp
datastore lds_iva
long ll_righe

if tab_1.tabpage_1.dw_1.rowcount()>0 then
	
	//20260809 i subtotali per aliquota si calcolano su un datastore locale.
	//Prima si usava dw_5, che pero' e' in sharedata con dw_2: il setsort/sort
	//su dw_5 riordinava il buffer delle righe documento e faceva puntare
	//altrove i numeri di riga tenuti in mano dalle funzioni postate
	//(wf_gestisci_partita_oro, wf_allinea_finocalo).
	//Il dataobject si prende da dw_5 e non si scrive a mano, cosi' funziona
	//anche sui documenti negozio dove dw_5 diventa d_rdoc_negozio_sh01_tb.
	lds_iva=create datastore
	lds_iva.dataobject=tab_1.tabpage_2.dw_5.dataobject
	ll_righe=tab_1.tabpage_2.dw_2.rowcount()
	if ll_righe>0 then
		tab_1.tabpage_2.dw_2.rowscopy(1, ll_righe, primary!, lds_iva, 1, primary!)
		//il raggruppamento per iva_id vuole le righe ordinate per iva_id,
		//altrimenti le computed "for group 1" non tornano
		lds_iva.setsort("iva_id")
		lds_iva.sort()
		lds_iva.groupcalc()
	end if
	
	ll_breakrow = 0
	//svuoto la dw_3 dove calcolo il castelletto
	tab_1.tabpage_1.dw_3.rowsmove(1, 10000, primary!,tab_1.tabpage_1.dw_3, 1, delete! )
	//prendo l'eventuale acconto e gli sconti documento
	ldc_acconto=tab_1.tabpage_1.dw_1.getitemdecimal(1, "acconto")
	ldc_sc_imp=tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "doc_sconto_imp")
	ldc_sc_perc=tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "doc_sconto_perc")
	//devo recuperare l'iva DELLO SCONTO
	ll_id_iva_sconto_imp=tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "iva_sconto_importo")
	
	do while ll_breakrow>=0
		ll_breakrow = lds_iva.FindGroupChange(ll_breakrow, 1)
	// If no breaks are found, exit.
		IF ll_breakrow <= 0 THEN EXIT
		ldc_imp=lds_iva.GetItemdecimal(ll_breakrow, "c_doc_imp_gr1")  
		ldc_imp_met=lds_iva.GetItemdecimal(ll_breakrow, "c_doc_metallo_gr1")  
		ldc_iva=lds_iva.GetItemdecimal(ll_breakrow, "c_doc_iva_gr1")	
		ll_iva_id=lds_iva.GetItemnumber(ll_breakrow, "iva_id")
		//prima calcolo lo sconto percentuale (sul totale)
		if ldc_sc_perc>0 then
			ldc_imp -= ldc_imp*ldc_sc_perc/100
		end if
		//se esiste uno sconto importo lo sottraggo (solo il totale della manifattura)
		if ldc_sc_imp>0 then
			lb_sconto_imp=true
			
			if isnull(ll_id_iva_sconto_imp) or ll_id_iva_sconto_imp=0 then
				messagebox("Attenzione!", "Se si valorizza lo sconto a importo è obbligatorio valorizzare anche l'iva cui va applicato!")	
			else
				if ll_id_iva_sconto_imp=ll_iva_id then
					if ldc_imp<ldc_sc_imp then
						messagebox("Attenzione!", "Lo sconto è maggiore del costo!")
					else
						ldc_imp -= ldc_sc_imp
						lb_sconto_imp=false
					end if
					end if
			end if
		end if
		ldc_imp = round(ldc_imp+ldc_imp_met, 2)
		//ldc_iva *= ldc_imp/100
		//ora inserisco la riga nel castelletto
		li_riga_iva=tab_1.tabpage_1.dw_3.trigger event ue_insert(0)
		if ldc_acconto>0 then
			tab_1.tabpage_1.dw_3.setitem(li_riga_iva, "doc_acconto", ldc_acconto) 
		end if
		tab_1.tabpage_1.dw_3.setitem(li_riga_iva, "civa_tot_imp", ldc_imp)
		//tab_1.tabpage_1.dw_3.setitem(li_riga_iva, "civa_tot_iva", ldc_iva)
		tab_1.tabpage_1.dw_3.setitem(li_riga_iva, "iva_id", ll_iva_id)
		
	
	// Increment starting row to find next break
		ll_breakrow = ll_breakrow + 1
	
	LOOP

	destroy lds_iva

	if lb_sconto_imp then
		messagebox("Attenzione!", "Aliquota iva dello sconto a importo NON trovata o sconto troppo grande! Coreggere dato: lo sconto NON è stato applicato!")
	end if
	
	wf_calcola_spese()
	wf_calcola_scadenze()
	
	
	
	//20260809 tolto il ripristino dell'ordine su dw_5: non si sorta piu' niente
	//sul buffer condiviso, quindi non c'e' niente da ripristinare
	
	tab_1.tabpage_1.dw_3.post event ue_update() 
end if




end subroutine

public subroutine wf_calcola_spese ();//calcola il valore delle spese
integer li_righe, i, li_righe_cast_iva, a, li_riga_iva
decimal ldc_spesa, ldc_iva, ldc_aliquota_spesa, ldc_spesa_attuale
long ll_iva_id_spese, ll_iva_id_cast

wf_inserisci_spese()

li_righe=tab_1.tabpage_1.dw_4.rowcount()

for i= 1 to li_righe
	li_righe_cast_iva=tab_1.tabpage_1.dw_3.rowcount()
	ldc_spesa=tab_1.tabpage_1.dw_4.getitemdecimal(i, "sp_doc_importo")
	ll_iva_id_spese=tab_1.tabpage_1.dw_4.getitemnumber(i, "iva_id")
	a=tab_1.tabpage_1.dw_3.find("iva_id="+string(ll_iva_id_spese), 1, li_righe_cast_iva)
	if a>0 then
		ldc_spesa_attuale=tab_1.tabpage_1.dw_3.getitemdecimal(a, "civa_spese")
		if isnull(ldc_spesa_attuale) then ldc_spesa_attuale=0
		tab_1.tabpage_1.dw_3.setitem(a, "civa_spese", ldc_spesa+ldc_spesa_attuale)
		//ldc_iva=tab_1.tabpage_1.dw_3.getitemdecimal(a, "c_civa_spese")
//		ldc_iva+=tab_1.tabpage_1.dw_3.getitemdecimal(a, "civa_tot_iva")
//		tab_1.tabpage_1.dw_3.setitem(a, "civa_tot_iva", ldc_iva)
	else
		li_riga_iva=tab_1.tabpage_1.dw_3.trigger event ue_insert(0)
		tab_1.tabpage_1.dw_3.setitem(li_riga_iva, "iva_id", ll_iva_id_spese)
		tab_1.tabpage_1.dw_3.setitem(li_riga_iva, "civa_spese", ldc_spesa)
		//ldc_iva=tab_1.tabpage_1.dw_3.getitemdecimal(i, "c_civa_spese")
//		select iva_aliquota
//		into :ldc_aliquota_spesa
//		from iva
//		where iva_id=:ll_iva_id_spese;
		//tab_1.tabpage_1.dw_3.setitem(li_riga_iva, "civa_tot_iva", ldc_spesa*ldc_aliquota_spesa/100)

	end if
	
next
FOR I= 1 TO tab_1.tabpage_1.dw_3.rowcount()
	ldc_iva=tab_1.tabpage_1.dw_3.getitemdecimal(i, "c_civa_spese")
	tab_1.tabpage_1.dw_3.setitem(i, "civa_tot_iva",ldc_iva)
next
end subroutine

public subroutine wf_apertura_da_stampe (long al_id_doc);long ll_riga, ll_conto
dwobject dwo_conto

if al_id_doc >0 then
	ll_riga=tab_1.tabpage_1.dw_1.retrieve(al_id_doc)
	if ll_riga>0 then
		tab_1.tabpage_1.dw_1.trigger event rowfocuschanged(ll_riga)
		ll_conto=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga, "doc_conto_id")
		dwo_conto=tab_1.tabpage_1.dw_1.object.doc_conto_id
		tab_1.tabpage_1.dw_1.trigger event itemchanged(ll_riga,dwo_conto, string(ll_conto) )
		tab_1.tabpage_1.dw_1.post setitemstatus(ll_riga, 0, primary!, datamodified!)
		tab_1.tabpage_1.dw_1.post setitemstatus(ll_riga, 0, primary!, notmodified!)
	end if
end if
end subroutine

public subroutine wf_calcola_scadenze ();long ll_id_pag, ll_riga_corrente
integer li_gg_dec, li_rate, li_gg_rate, i, li_riga_scadenza, li_gg, a, li_mese_doc, li_mese_scad
string ls_dffm, ls_prima_rata //"U" o nulla=come le altre, "I"=solo iva 
date ldt_data_scadenza, ldt_data_doc
decimal ld_tot_doc, ld_imp_rata, ld_tot_iva, ld_acconto
integer li_solo_iva=0, li_test_bis, li_ok, li_mesi, li_mese_scadenza, li_anno
integer li_anno_2, li_mese_scadenza_2, li_giorno_fisso, li_gg_attuale
boolean gia_incrementato

li_ok=0
ll_riga_corrente=tab_1.tabpage_1.dw_1.getrow()
if ll_riga_corrente>0 then
	//controllo se esistono scadenze inserite manulamente
	//se non sono scadenze inserite a mano allora
	//cancello le scadenze attuali altrimenti mi fermo qui
	for i=  tab_1.tabpage_1.dw_6.rowcount() to 1 step -1
		if tab_1.tabpage_1.dw_6.getitemnumber(i, "ins_manualmente")<> 1 then
			tab_1.tabpage_1.dw_6.deleterow(i)
		else
			li_ok=-1
		end if
	next
	if li_ok=0 then
		ll_id_pag=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga_corrente, "paga_id")
		if ll_id_pag>0 then
		//recupero il totale documento 
			if tab_1.tabpage_1.dw_3.rowcount()>0 then
				ld_tot_doc=tab_1.tabpage_1.dw_3.getitemdecimal(1, "c_tot_doc")
				if ld_tot_doc>0 then
					//recupero i termini delle scadenza-pagamento
					select rpaga_gg_decorrenza, rpaga_num_rate, rpaga_gg_rate, rpaga_scadenza, rpaga_fisso, prima_rata
					into :li_gg_dec, :li_rate, :li_gg_rate, :ls_dffm, :li_giorno_fisso, :ls_prima_rata
					from dba.rpaga
					where paga_id=:ll_id_pag
					;
					//recupero la data del doc
					ldt_data_doc=tab_1.tabpage_1.dw_1.getitemdate(ll_riga_corrente, "doc_data")
					//li_mese_doc=month(ldt_data_scadenza)
					//calcolo effettivo delle rate
					li_mese_doc=month(ldt_data_doc)
					for i= 1 to li_rate
						li_riga_scadenza=tab_1.tabpage_1.dw_6.trigger event ue_insert(0)
						//la riga è inserita automaticamente, quindi tolgo il flag inserita manualmente
						tab_1.tabpage_1.dw_6.post setitem(li_riga_scadenza, "ins_manualmente", 0)
						//se è la prima riga i gg tra le rate sono in gg_dec altrimenti in gg_rate
						if i=1 then 
							li_gg=li_gg_dec
							ldt_data_scadenza=ldt_data_doc
						else 
							li_gg=li_gg_rate
						end if
						//calcolo la data della scadenza 
						li_mese_scadenza=month(ldt_data_scadenza)
						if li_mese_scadenza=1 then li_gg  -=  2
						
						ldt_data_scadenza=relativedate(ldt_data_scadenza,  li_gg)
						li_mese_scadenza=month(ldt_data_scadenza)
						if li_mese_scadenza<li_mese_doc and not(gia_incrementato) then 
							li_anno=year(ldt_data_doc)+1
							gia_incrementato=true
						else
							li_anno=year(ldt_data_scadenza)
						end if
//						else
//							li_mese_scadenza=month(ldt_data_scadenza)
//							li_mese_scadenza+=li_gg/30
//						end if
						ldt_data_scadenza=date(string(li_anno)+"/"+ string(li_mese_scadenza)+"/"+string(day(ldt_data_scadenza)))
						//gestione giorno fisso 08062015
						if li_giorno_fisso>0 and   ls_dffm<>'M' then
							li_anno_2=year(ldt_data_scadenza)
							li_mese_scadenza_2=month(ldt_data_scadenza)
							li_gg_attuale=day(ldt_data_scadenza)
							if li_gg_attuale> li_giorno_fisso then
								if li_mese_scadenza_2 = 12 then 
									li_anno_2= li_anno_2 + 1
									li_mese_scadenza_2 = 1
								else
									li_mese_scadenza_2=li_mese_scadenza_2 + 1
								end if
							end if
							ldt_data_scadenza=date(string(li_anno_2)+"/"+ string(li_mese_scadenza_2)+"/"+string(li_giorno_fisso))
						end if
						if ls_dffm='M'  then
							//gestione giorno fisso 20201102
							if li_giorno_fisso>0 then
							//	li_anno_2=year(ldt_data_scadenza)
								li_mese_scadenza_2=month(ldt_data_scadenza)
								li_gg_attuale=day(ldt_data_scadenza)
								if li_gg_attuale> li_giorno_fisso then
									if li_mese_scadenza_2 = 12 then 
										li_anno_2= li_anno_2 + 1
										li_mese_scadenza_2 = 1
									else
										li_mese_scadenza_2=li_mese_scadenza_2 + 1
									end if
								end if
								ldt_data_scadenza=date(string(li_anno_2)+"/"+ string(li_mese_scadenza_2)+"/"+string(li_giorno_fisso))
		
							else
//								ldt_data_scadenza=date(string(li_anno)+"/"+ string(li_mese_scadenza)+"/"+string(a)) 
							
							
//								if i=1 then
//									//li_mesi=li_gg/30
//									//QUESTA NON CAPISCO PIù PERCHé l'ho fatta ...
//									//li_mesi = li_mesi - (li_mese_scadenza - li_mese_doc)
//									//if li_mesi=1 then
//									//li_mese_scadenza=li_mese_doc + li_mesi
////									if li_mese_scadenza>12 then 
////										li_anno= year(ldt_data_doc) +1
////										li_mese_scadenza= li_mese_scadenza - 12
////									else
////										li_anno= year(ldt_data_scadenza)
////									end if
//								else
//									
//								end if
								
								choose case li_mese_scadenza
									case 1,3,5,7,8,10,12
										a=31
									case 2
										li_test_bis=integer(right(string(year(ldt_data_scadenza)), 2))
										if mod(li_test_bis, 4)=0 then
											a=29
										else
											a=28
										end if
									case 4,6,9,11
										a=30
								end choose
							end if	
									
//							do while not  isdate(string(year(ldt_data_scadenza))+"/"+ string(month(ldt_data_scadenza))+"/"+string(a))
//								a --
//							loop
							//ldt_data_scadenza=date(string(year(ldt_data_scadenza))+"/"+ string(month(ldt_data_scadenza))+"/"+string(a))
							ldt_data_scadenza=date(string(li_anno)+"/"+ string(li_mese_scadenza)+"/"+string(a)) 
						end if
						
						tab_1.tabpage_1.dw_6.setitem(li_riga_scadenza, "scad_data", ldt_data_scadenza)
						//calcolo gli importi
						if i=1 and ls_prima_rata='I' then
							ld_tot_iva=tab_1.tabpage_1.dw_3.getitemdecimal(1, "c_tot_iva")
							ld_imp_rata=ld_tot_iva
							ld_tot_doc -= ld_tot_iva
							li_solo_iva=1
						elseif i< li_rate then
							ld_imp_rata=round(ld_tot_doc/(li_rate - li_solo_iva), 2)
						else
							ld_tot_doc=tab_1.tabpage_1.dw_3.getitemdecimal(1, "c_tot_doc")
							ld_imp_rata=ld_tot_doc - tab_1.tabpage_1.dw_6.getitemdecimal(1, "c_tot_senza_UR")
						end if
						tab_1.tabpage_1.dw_6.setitem(li_riga_scadenza, "scad_importo", ld_imp_rata)
					next
				end if		
			end if
		end if
		tab_1.tabpage_1.dw_6.post event ue_update()
	end if
	//se non è inserita manualmente controllo acconto da stornare
	wf_storna_acconto(li_rate, ls_prima_rata, ld_tot_doc)
end if

//post wf_inserisci_spese()
end subroutine

public subroutine wf_copia_righe (s_riga_derivata ast_riga);
end subroutine

public subroutine wf_carica_dddw ();datawindowchild dwc_tit, dwc_art, dwc_um
integer rtncode

rtncode = tab_1.tabpage_2.dw_2.GetChild('rdoc_art_id', dwc_art)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild Articolo")

rtncode = tab_1.tabpage_2.dw_2.GetChild('tit_id', dwc_tit)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild Titolo")

rtncode = tab_1.tabpage_2.dw_2.GetChild('um_id', dwc_um)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild Unita misura")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child
dwc_art.SetTransObject(SQLCA)
dwc_tit.SetTransObject(SQLCA)
dwc_um.SetTransObject(SQLCA)
// Populate with values for eastern states

dwc_art.Retrieve()
dwc_tit.Retrieve()
dwc_um.Retrieve()


//
//um_id
end subroutine

public subroutine wf_carica_destinazioni (long al_conto);integer rtncode
datawindowchild ldwc_dest
long ll_ana

rtncode = tab_1.tabpage_1.dw_1.GetChild('dest_id', ldwc_dest)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild destinazione")
//// Set the transaction object for the child
ldwc_dest.SetTransObject(sqlca)
//// Populate with values for eastern states

select ana_id  
into :ll_ana 
from dba.conto
where conto_id= :al_conto
;
ldwc_dest.retrieve(ll_ana)


end subroutine

public subroutine wf_carica_pagamento (long al_conto);long ll_id_paga, ll_row

select paga_id
into :ll_id_paga
from conto
where conto_id= :al_conto
;
ll_row=tab_1.tabpage_1.dw_1.getrow()
if ll_row>0 then
	tab_1.tabpage_1.dw_1.setitem(ll_row, "paga_id", ll_id_paga)
end if
end subroutine

public subroutine wf_dati_articolo (long al_row, long al_art_id);string ls_des, ls_tipo, ls_um_tipo,ls_tipo_azienda
long ll_id_tit, ll_id_um, ll_id_vali, ll_id_listino, ll_id_conto, ll_reg_id
decimal ldc_c_calo, ldc_prezzo, ldc_null, ldc_peso_non_prezioso
date ldt_data_doc
long ll_id_taglia, ll_id_colore, ll_id_iva, ll_iva_soggetto, ll_id_causale

setnull(ldc_null)

select art_descrizione, art_tit_preferenziale, art_calo_preferenziale,  um_id, peso_non_prezioso,
			id_taglia, id_colore, iva_id
into :ls_des, :ll_id_tit, :ldc_c_calo, :ll_id_um, :ldc_peso_non_prezioso, :ll_id_taglia, :ll_id_colore,
		:ll_id_iva
from dba.art
where art_id= :al_art_id;

ll_id_conto=tab_1.tabpage_1.dw_1.getitemnumber(1, "doc_conto_id")
select iva_id
into :ll_iva_soggetto
from dba.conto
where conto_id=:ll_id_conto
;
if isnull(ll_iva_soggetto) then
	IF ISNULL(ll_id_iva) THEN
		SELECT iva_id
		into :ll_id_iva
		from dba.val_base
		;
		if ll_id_iva>0 then
			tab_1.tabpage_2.dw_2.setitem(al_row, "iva_id", ll_id_iva)
		else
			messagebox("Attenzione!", "Specificare iva in valori base!")
		end if
	end if
end if




if ldc_peso_non_prezioso>0 then
	tab_1.tabpage_2.dw_2.setitem(al_row, "rdoc_non_prezioso", ldc_peso_non_prezioso)
end if

if ls_des>"" and not isnull(ls_Des) then
	tab_1.tabpage_2.dw_2.setitem(al_row, "rdoc_descrizione", ls_Des)
end if

select tipo_azienda
into :ls_tipo_azienda
from dba.val_base;
choose case ls_tipo_azienda
	case 'N' //se è un negozio
		if ll_id_taglia>0  then
			tab_1.tabpage_2.dw_2.setitem(al_row, "id_taglia", ll_id_taglia)
		end if
		if ll_id_colore>0  then
			tab_1.tabpage_2.dw_2.setitem(al_row, "id_colore", ll_id_colore)
		end if
end choose
//fine se è un negozio

if ll_id_tit>0  then
	tab_1.tabpage_2.dw_2.setitem(al_row, "tit_id", ll_id_tit)
end if
if ldc_c_calo>0  then
	tab_1.tabpage_2.dw_2.setitem(al_row, "rdoc_calo", ldc_c_calo)
end if


if ll_id_um>0  then
	tab_1.tabpage_2.dw_2.setitem(al_row, "um_id", ll_id_um)
	ll_id_conto=tab_1.tabpage_1.dw_1.getitemnumber(1, "doc_conto_id")
	ldt_data_doc=tab_1.tabpage_1.dw_1.getitemdate(1, "doc_data")
	//non va: se reso su acq prende tipo='V', invece deve essere "A"
//	ll_reg_id=tab_1.tabpage_1.dw_1.getitemnumber(1, "reg_id")
//	select reg_tipo
//	into :ls_tipo
//	from registro
//	where reg_id=:ll_reg_id
//	;
	//ls_tipo= right(ls_tipo, 1)
	//if ls_tipo='C' then ls_tipo='V'
	ll_id_causale=tab_1.tabpage_2.dw_2.getitemnumber(al_row, "causale_id")
	select valorizzazione
	into :ls_tipo
	from dba.causale
	where caus_id=:ll_id_causale
	;
	if isnull(ls_tipo) then ls_tipo='V'
	//cerco prima se esiste un listino personale
	select listino_id
	into :ll_id_listino
	from conto
	where conto_id=:ll_id_conto
	;
	//se non esiste trovo quello di base
	if isnull(ll_id_listino) then
		select listino_id
		into :ll_id_listino
		from listino
		where base='S'
		and list_tipo=:ls_tipo
		;
		
   end if
	//Seleziono il periodo di validità buono
	select vali_id
		into :ll_id_vali
		from validita
		where listino_id=:ll_id_listino
		and vali_da_data<= :ldt_data_doc	and vali_a_data>= :ldt_data_doc
		;
		select um_tipo
		into :ls_um_tipo
		from u_misura
		where um_id=:ll_id_um
		;
		
		ldc_prezzo=f_recupera_prezzo(al_row, al_art_id, ls_um_tipo, ll_id_vali)
		if ldc_prezzo>0 then
			tab_1.tabpage_2.dw_2.setitem(al_row, "vali_id", ll_id_vali)
			if ls_um_tipo='P' then
				tab_1.tabpage_2.dw_2.setitem(al_row, "rdoc_pr_pezzo", ldc_null)
				if is_scorporo_iva='S' then
					tab_1.tabpage_2.dw_2.trigger event &
					itemchanged(al_row, tab_1.tabpage_2.dw_2.object.rdoc_pr_man, string(ldc_prezzo))
				else
					tab_1.tabpage_2.dw_2.setitem(al_row, "rdoc_pr_man", ldc_prezzo)
				end if
			else
				tab_1.tabpage_2.dw_2.setitem(al_row, "rdoc_pr_man", ldc_null)
				if is_scorporo_iva='S' then
					tab_1.tabpage_2.dw_2.trigger event &
					itemchanged(al_row, tab_1.tabpage_2.dw_2.object.rdoc_pr_pezzo, string(ldc_prezzo))
				else
					tab_1.tabpage_2.dw_2.setitem(al_row, "rdoc_pr_pezzo", ldc_prezzo)
				end if
			end if
		end if
end if
	

end subroutine

public subroutine wf_carica_banca (long al_conto);integer rtncode, li_righe
long ll_id_banca, ll_null
datawindowchild ldwc_conto_banca

setnull(ll_null)

rtncode = tab_1.tabpage_1.dw_1.GetChild('banca_id', ldwc_conto_banca)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild Banca soggetto")
//// Set the transaction object for the child
ldwc_conto_banca.SetTransObject(sqlca)
//// Populate with values for eastern states
li_righe=ldwc_conto_banca.retrieve(al_conto)

if li_righe>0 then
	select conto_banca_id
	into :ll_id_banca
	from dba.conto_banca
	where conto_id=:al_conto
	and conto_banca_base='S'
	;
	if ll_id_banca>0 then
		tab_1.tabpage_1.dw_1.setitem(1, "banca_id", ll_id_banca)
	end if
else
	ldwc_conto_banca.reset()
	tab_1.tabpage_1.dw_1.setitem(1, "banca_id", ll_null)
end if
end subroutine

public subroutine wf_calcola_saldo ();date ldt_da_data, ldt_a_data
string ls_tipo
long ll_id_conto, ll_riga, ll_id_causale

ll_riga=tab_1.tabpage_2.dw_2.getrow()
if ll_riga>0 then
	ll_id_causale=tab_1.tabpage_2.dw_2.getitemnumber(ll_riga, "causale_id")
	ldt_a_data=tab_1.tabpage_1.dw_1.getitemdate(1, "doc_data")
	ldt_da_data=f_trova_data_inizio_saldi(ldt_a_data)
	ll_id_conto=tab_1.tabpage_1.dw_1.getitemnumber(1, "doc_conto_id")
	ls_tipo=f_trova_tipo_partita(ll_id_causale)

		tab_1.tabpage_2.dw_7.retrieve(ldt_da_data, ldt_a_data, ls_tipo, ll_id_conto)
	
end if
end subroutine

public subroutine wf_scorporo_iva (long al_id_guida);

if al_id_guida>0 then
	//guardo se devo scorporare iva
	select scorporo_iva
	into :is_scorporo_iva
	from dba.guida 
	where guida_id=:al_id_guida
	;
else
	is_scorporo_iva='N'
end if
end subroutine

public subroutine wf_allinea_cod_clfo (long al_riga, long al_id_art);long ll_id_sog, ll_riga_trovata


if isnull(al_id_art) then
	tab_1.tabpage_2.dw_8.reset()
else
	
	ll_id_sog=tab_1.tabpage_1.dw_1.getitemnumber(1, "doc_conto_id")
	
	ll_riga_trovata=tab_1.tabpage_2.dw_8.retrieve(ll_id_sog, al_id_art)
	if ll_riga_trovata<=0 then
		tab_1.tabpage_2.dw_8.reset()
		ll_riga_trovata=tab_1.tabpage_2.dw_8.trigger event ue_insert(0)
		tab_1.tabpage_2.dw_8.setitem(ll_riga_trovata, "id_sog", ll_id_sog)
		tab_1.tabpage_2.dw_8.setitem(ll_riga_trovata, "id_art", al_id_art)
		
	end if
end if
POST SETFOCUS(TAB_1.TABPAGE_2.DW_2)

end subroutine

public subroutine wf_copia_in_basso (string as_colonna, decimal adc_valore, long row);
//ricopia la quotazione in basso a parità di metallo
string ls_metallo, ls_metallo_2

integer i

ls_metallo = tab_1.tabpage_2.dw_2.Describe("Evaluate('LookUpDisplay(tit_id) ', " + string(row) + ")")
ls_metallo=left(ls_metallo, 2)
for i = row + 1 to tab_1.tabpage_2.dw_2.rowcount()
	ls_metallo_2=tab_1.tabpage_2.dw_2.Describe("Evaluate('LookUpDisplay(tit_id) ', " + string(i) + ")")
	ls_metallo_2=left(ls_metallo_2, 2)
	if ls_metallo_2=ls_metallo then
		tab_1.tabpage_2.dw_2.object.rdoc_quotazione[i]= adc_valore
	end if
next


end subroutine

public subroutine wf_inserisci_spese ();//prende le spese legate al pagamento e le inserisce nella tabella spese 300408
long ll_id_paga, ll_id_spesa, ll_riga_ins, ll_id_iva
decimal ldc_imp
string ls_app
integer li_num_scad

ll_id_paga=tab_1.tabpage_1.dw_1.getitemnumber(1, "paga_id")
if ll_id_paga>0 then
	select pagamento.spesa_id, app_spesa, imp_spesa, iva_id, rpaga_num_rate
	into :ll_id_spesa, :ls_app, :ldc_imp, :ll_id_iva, :li_num_scad
	from dba.pagamento, dba.spesa, dba.rpaga
	where pagamento.paga_id=:ll_id_paga and rpaga.paga_id=pagamento.paga_id
	and pagamento.spesa_id=spesa.spesa_id
	;
	if ll_id_spesa>0 then
		if ls_app='R' then
			ldc_imp *=li_num_scad
		end if
		if tab_1.tabpage_1.dw_4.find("spesa_id="+string(ll_id_spesa), 1, tab_1.tabpage_1.dw_4.rowcount())<1 then
			tab_1.tabpage_1.dw_4.trigger event ue_insert(0)
			ll_riga_ins=tab_1.tabpage_1.dw_4.rowcount()
			tab_1.tabpage_1.dw_4.setitem(ll_riga_ins, "spesa_id", ll_id_spesa)
			if isnull(ll_id_iva) then
				select iva_id
				into :ll_id_iva
				from dba.val_base;
				if isnull(ll_id_iva) then messagebox("Attenzione!", "Inserire l'aliquota IVA standard nella tabella dei valori di base!")
			end if
			tab_1.tabpage_1.dw_4.setitem(ll_riga_ins, "iva_id", ll_id_iva)
			tab_1.tabpage_1.dw_4.setitem(ll_riga_ins, "sp_doc_importo", ldc_imp)
		end if
	end if	
end if
end subroutine

public subroutine wf_allinea_es_articolo (long al_art_id);date ldt_data_doc, ldt_inizio
string ls_saldi, ls_test

select es_articolo_in_riga_documento
into :ls_test
from dba.val_base
;
if ls_test='S' then
	ldt_data_doc=TAB_1.TABPAGE_1.DW_1.getitemdate(1, "doc_data")
	select es_art_in_esercizio 
	into :ls_saldi
	from dba.val_base;
	if ls_saldi='S' then
		ldt_inizio= f_data_inizio_saldi()
		if isnull(ldt_inizio) then
			ldt_inizio= f_trova_inizio_esercizio(ldt_data_doc)
		end if
	end if
	
	TAB_1.TABPAGE_2.DW_9.retrieve(al_art_id, ldt_inizio, ldt_data_doc)
end if
end subroutine

public function integer wf_filtra_intestatari (string as_prefisso);datawindowchild ldw_conto, ldw_conto_1
integer rtncode

setredraw(false)
rtncode = tab_1.tabpage_1.dw_1.GetChild('doc_conto_id', ldw_conto)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild ldw_conto")			
ldw_conto.settransobject(sqlca)
rtncode = tab_1.tabpage_1.dw_1.GetChild('doc_conto_id_1', ldw_conto_1)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild ldw_conto")			
ldw_conto_1.settransobject(sqlca)
if as_prefisso>" " then
	ldw_conto.setfilter("left(conto_conto_codice, 2)='"+as_prefisso+"'")
	ldw_conto.filter()

	ldw_conto_1.setfilter("left(conto_conto_codice, 2)='"+as_prefisso+"'")
	ldw_conto_1.filter()
else
	ldw_conto.setfilter("")
	ldw_conto.filter()
	ldw_conto_1.setfilter("")
	ldw_conto_1.filter()
end if
setredraw(true)
return 1
end function

public subroutine wf_calcola_saldo_derivazione (long al_riga);long ll_id_riga_derivata, ll_righe, ll_id_riga
decimal ldc_fc_resto,ldc_fc_originale, ldc_fc_attuale, ldc_da_stornare
decimal ldc_c_calo
integer i, li_ret
dwitemstatus ldws_stato

ll_id_riga_derivata=tab_1.tabpage_2.dw_2.getitemnumber(al_riga, "rdoc_id_riga_madre")
ll_righe=tab_1.tabpage_2.dw_2.rowcount()
if ll_id_riga_derivata>0 then
	//li_ret=tab_1.tabpage_2.dw_2.setitemstatus(al_riga,0, primary!, newmodified!)
	li_ret=tab_1.tabpage_2.dw_2.trigger event ue_update()
	
	select finoecalo - isnull(finoecalo_evaso, 0)
	into :ldc_fc_resto
	from dba.rdoc
	where rdoc_id=:ll_id_riga_derivata;
	if ldc_fc_resto>0 then
		//for i = 1 to ll_righe
			//if i=al_riga then continue
			
//			ll_id_riga=tab_1.tabpage_2.dw_2.getitemnumber(i, "rdoc_id_riga_madre")
//			if ll_id_riga=ll_id_riga_derivata then
////				ldws_stato= tab_1.tabpage_2.dw_2.getitemstatus(i, 0, Primary!)
////				if ldws_stato<>notmodified! then
////					if ldws_stato=datamodified! then
////						ldc_fc_originale=dec(tab_1.tabpage_2.dw_2.Object.Data.primary.Original[i,26])
////						ldc_fc_attuale=tab_1.tabpage_2.dw_5.getitemdecimal(i, "c_fino_calo")
////						ldc_da_stornare=ldc_fc_attuale - ldc_fc_originale
////					else
////						ldc_da_stornare=tab_1.tabpage_2.dw_5.getitemdecimal(i, "c_fino_calo")
////					end if
////					ldc_fc_resto -=ldc_da_stornare
////					if ldc_fc_resto<0 then
////						messagebox("Attenzione!", "Si sta scaricando oltre la quantità esistente!")
////					end if
//				//end if
//			end if
//		next
		ldc_c_calo=tab_1.tabpage_2.dw_2.getitemdecimal(al_riga, "rdoc_calo")
		tab_1.tabpage_2.dw_2.setitem(al_riga, "rdoc_peso", ldc_fc_resto/ ldc_c_calo*1000)
	end if
end if
end subroutine

public subroutine wf_storna_acconto (integer ai_rate, string as_prima_rata, decimal ad_tot_doc);//storna l'eventuale acconto dalle scadenze se sono inserite in automatico (se manuali non fa nulla)
//verifica se la prima rata è come le altre o solo iva (nel caso la lascia intonsa e scala dalle altre rate)

integer i, i_rate, a=1
decimal {2} ld_acconto, ld_acc_per_rata, ld_imp_rata, ld_per_ultima_rata

ld_acconto=tab_1.tabpage_1.dw_1.getitemdecimal(1, "acconto")
if ld_acconto>0 and ai_rate>0 then
	if i= 1 and as_prima_rata='I' then //la prima rata è solo iva, lascio stare e passo alla prossima
		ai_rate --
		a=2
		ld_per_ultima_rata=tab_1.tabpage_1.dw_6.getitemdecimal(i, "scad_importo")
	end if
	ld_acc_per_rata=ld_acconto/ai_rate
	for i = a to ai_rate
		if i= ai_rate then //è l'ultima rata, calcolo il totale per differenza
			ld_imp_rata= ad_tot_doc - ld_acconto - ld_per_ultima_rata
		else
			ld_imp_rata=tab_1.tabpage_1.dw_6.getitemdecimal(i, "scad_importo")
			ld_imp_rata= ld_imp_rata - ld_acc_per_rata
			ld_per_ultima_rata +=ld_imp_rata
		end if
		tab_1.tabpage_1.dw_6.setitem(i, "scad_importo", ld_imp_rata)
					
	next
end if

end subroutine

public subroutine wf_carica_valuta_cambio (long al_conto);long ll_id_valuta
decimal ldc_cambio

select val_id
into :ll_id_valuta
from dba.ana a, dba.conto c
where a.ana_id=c.ana_id
and c.conto_id=:al_conto;

if isnull(ll_id_valuta) then ll_id_valuta=1

select val_parita_euro
into :ldc_cambio
from dba.valuta
where val_id=:ll_id_valuta
;
if isnull(ldc_cambio) then ldc_cambio=1

tab_1.tabpage_1.dw_1.setitem(1, "val_id", ll_id_valuta)
tab_1.tabpage_1.dw_1.setitem(1, "cambio", ldc_cambio)

end subroutine

public subroutine wf_carica_spese (long al_id_conto);datastore ds_conto_sp
long ll_righe, ll_id_iva, ll_id_spesa, ldc_importo, ll_riga, ll_riga_trovata
integer i

ds_conto_sp=create datastore
ds_conto_sp.dataobject="ds_conto_spese"
ds_conto_sp.settransobject(sqlca)
ll_righe=ds_conto_sp.retrieve(al_id_conto)
if ll_righe>0 then
	if tab_1.tabpage_1.dw_1.trigger event ue_update()=1 then
		for i= 1 to ll_righe
			ldc_importo=0
			ll_id_iva=ds_conto_sp.getitemnumber(i, "id_iva")
			ll_id_spesa=ds_conto_sp.getitemnumber(i, "id_spesa")
			//20251014 se la spesa è già presente NON la inserisco!
			ll_riga_trovata=tab_1.tabpage_1.dw_4.find("spesa_id="+string(ll_id_spesa), 1, 9999999)
			if ll_riga_trovata>0 then
				exit
			end if
			ldc_importo=ds_conto_sp.getitemdecimal(i, "importo")
			ll_riga=tab_1.tabpage_1.dw_4.trigger event ue_insert(0)
			tab_1.tabpage_1.dw_4.setitem(ll_riga, "iva_id", ll_id_iva)
			tab_1.tabpage_1.dw_4.setitem(ll_riga, "sp_doc_importo", ldc_importo)
			tab_1.tabpage_1.dw_4.setitem(ll_riga, "spesa_id", ll_id_spesa)
		next
		wf_calcola_spese()
		
	end if
end if
destroy ds_conto_sp
end subroutine

public subroutine wf_scarico_automatico (decimal adc_peso_vecchio, decimal adc_peso_nuovo, long al_num_riga);//decimal ldc_peso, ldc_peso_evaso_precedente, ldc_peso_evaso_reintegrato, ldc_peso_evaso_attuale
//decimal ldc_peso_disponibile,ldc_peso_da_scaricare
//integer a=0
//long ll_id_riga_madre, ll_riga_da_aggiornare, ll_riga, ll_null, ll_numero_riga
//long ll_id_soggetto, ll_id_guida, ll_id_metallo, ll_id_titolo
//
//setnull(ll_null)
//ll_id_soggetto=tab_1.tabpage_1.dw_1.getitemnumber(1, "doc_conto_id")
//if tab_1.tabpage_1.cbx_deriva_automatico.checked then
//	//carico i carichi da scaricare
//	if tab_1.tabpage_2.dw_10.rowcount()<=0   then
//		ll_id_guida=tab_1.tabpage_1.dw_11.getitemnumber(1, "guida_id")
//		ll_id_titolo= tab_1.tabpage_2.dw_2.getitemnumber(al_num_riga, "tit_id")
//		select tit_met_id 
//		into :ll_id_metallo
//		from dba.titolo
//		where tit_id=:ll_id_titolo;
//		tab_1.tabpage_2.dw_10.retrieve(date('2013-01-01'), TODAY(), ll_id_guida, ll_id_soggetto,ll_id_metallo)
//	end if
//	ldc_peso_da_scaricare=adc_peso_nuovo
//	do while ldc_peso_da_scaricare>0
//		if a>0 then //è il secondo giro per lo stesso scarico: creo un'altra riga copiata da quella iniziale
//			tab_1.tabpage_2.dw_2.rowscopy(al_num_riga, al_num_riga, Primary!, tab_1.tabpage_2.dw_2, al_num_riga+1, Primary!)
//			al_num_riga++
//			//cambio i dati necessari (id_riga_madre
//			tab_1.tabpage_2.dw_2.setitem(al_num_riga, "rdoc_id_riga_madre", ll_null)
//			//la riga precedente viene scaricata per il peso disponibile (esistente in quella riga)
//			tab_1.tabpage_2.dw_2.setitem(al_num_riga - 1, "rdoc_peso", ldc_peso_disponibile)
//			//il resto viene assegnato alla nova riga
//			tab_1.tabpage_2.dw_2.setitem(al_num_riga, "rdoc_peso", ldc_peso_da_scaricare)	
//			ll_numero_riga= tab_1.tabpage_2.dw_2.getitemnumber(al_num_riga, "c_max_num_riga")
//			tab_1.tabpage_2.dw_2.setitem(al_num_riga, "rdoc_numero", ll_numero_riga+1)
//			a=0
//		end if
//		//controllo se la riga ha già segnato l'id_riga della riga che scarica
//		ll_id_riga_madre=tab_1.tabpage_2.dw_2.getitemnumber(al_num_riga, "rdoc_id_riga_madre")
//		if ll_id_riga_madre>0 then 
//			 ll_riga_da_aggiornare=tab_1.tabpage_2.dw_10.find("rdoc_rdoc_id= "+string(ll_id_riga_madre), 1, tab_1.tabpage_2.dw_10.rowcount())
//			//se la riga ha già un peso evaso lo recupero
//			ldc_peso_evaso_precedente= tab_1.tabpage_2.dw_10.getitemdecimal(ll_riga_da_aggiornare, "rdoc_rdoc_peso_evaso")
//			if ldc_peso_evaso_precedente > adc_peso_vecchio then  //reintegro la riga dello scarico del peso vecchio
//				ldc_peso_evaso_reintegrato = ldc_peso_evaso_precedente - adc_peso_vecchio
//			else
//				ldc_peso_evaso_reintegrato=0  //se vado sotto 0 mi fermo a 0
//			end if
//		else //altrimenti lo recupero e lo segno nella riga
//			ll_riga_da_aggiornare=tab_1.tabpage_2.dw_10.find("c_peso_residuo > 0",1, tab_1.tabpage_2.dw_10.rowcount())
//			ll_id_riga_madre=tab_1.tabpage_2.dw_10.getitemnumber(ll_riga_da_aggiornare, "rdoc_rdoc_id")
//			tab_1.tabpage_2.dw_2.setitem(al_num_riga, "rdoc_id_riga_madre", ll_id_riga_madre)
//			ldc_peso_evaso_reintegrato=0 
//		end if
//		//ora guardo il peso disponibile allo scarico
//		ldc_peso_disponibile= tab_1.tabpage_2.dw_10.getitemdecimal(ll_riga_da_aggiornare, "c_peso_residuo")
//		if ldc_peso_da_scaricare>=ldc_peso_disponibile then //se il peso disponibile non basta lo tolgo dal peso da scaricare e faccio un altro giro
//			ldc_peso_da_scaricare -= ldc_peso_disponibile
//			a++
//		else //altrimenti metto a 0 il peso da scaricare così si finisce il giro
//			ldc_peso_disponibile=ldc_peso_da_scaricare
//			ldc_peso_da_scaricare=0
//		end if
//		
//		ldc_peso_evaso_attuale=ldc_peso_evaso_reintegrato + ldc_peso_disponibile
//		//Da rifletterci: il peso evaso viene aggiornato dal trigger sul salvataggio
//		//ma io ne ho bisogno subito perché altrimenti l'altro scarico trova dati incoerenti ...
//		//daltronde l'anallisi iniziale dice: si scarica ogni riga netta (le righe di carico sono scaricate per intero, mai per frazione)
//		//qunidi ... pensamoci!
//		tab_1.tabpage_2.dw_10.setitem(ll_riga_da_aggiornare, "rdoc_rdoc_peso_evaso", ldc_peso_evaso_attuale)
//	loop
//
//end if
end subroutine

public subroutine wf_coerenza_reg_documento ();date ldt_data_doc, ldt_data_inizio_esercizio, ldt_data_fine_esercizio
long ll_id_registro

if tab_1.tabpage_1.dw_1.getrow()>0 then
	ll_id_registro=tab_1.tabpage_1.dw_1.getitemnumber(1, "reg_id")
	ldt_data_doc=tab_1.tabpage_1.dw_1.getitemdate(1, "doc_data")
	select ese_data_inizio, ese_data_fine
	into	:ldt_data_inizio_esercizio, :ldt_data_fine_esercizio
	from dba.esercizio e, dba.registro r
	where e.ese_id=r.reg_ese_id
	and r.reg_id=:ll_id_registro
	;
	if ldt_data_doc>ldt_data_fine_esercizio or ldt_data_doc<ldt_data_inizio_esercizio then
		messagebox("Attenzione!", "Documento incoerente: data documento NON compatile con il registro assegnato!")
	end if
end if
end subroutine

public subroutine wf_riga_automatica ();long ll_id_guida, ll_id_conto, ll_righe, i, ll_id_art, ll_riga,ll_prima_riga
datastore ds_riga_automatica

ll_id_guida=tab_1.tabpage_1.dw_1.getitemnumber(1, "guida_id")
ll_id_conto=tab_1.tabpage_1.dw_1.getitemnumber(1, "doc_conto_id")
ds_riga_automatica=create datastore
ds_riga_automatica.dataobject="d_riga_automatica_ra"
ds_riga_automatica.settransobject(sqlca)
ll_righe=ds_riga_automatica.retrieve(ll_id_guida, ll_id_conto)
for i=1 to ll_righe
	ll_id_art=ds_riga_automatica.getitemnumber(i, "id_art")
	 idw_corrente=tab_1.tabpage_2.dw_2
	 ll_riga=cb_inserisci.trigger event clicked()
	 if i=1 then ll_prima_riga=ll_riga
	 tab_1.tabpage_2.dw_2.setitem(ll_riga, "rdoc_art_id", ll_id_art)
	  tab_1.tabpage_2.dw_2.trigger event itemchanged(ll_riga,  tab_1.tabpage_2.dw_2.object.rdoc_art_id, string(ll_id_art))
	
next
 tab_1.tabpage_2.dw_2.scrolltorow(ll_prima_riga)
end subroutine

public subroutine wf_metti_des_marco (long al_id_art, long al_row);string ls_cod_azienda, ls_des

select az_codice into :ls_cod_azienda from dba.azienda;
	
if al_id_art=14 and ls_cod_azienda='MARCO' then
//	ls_des=tab_1.tabpage_2.dw_2.getitemstring(al_row, "rdoc_descrizione")
	ls_des="Consulenza Informatica - Oper. ai sensi art.1, c. da 54 a 89 L. 190 23/12/14. Non sogg. a rit. acc. art.1, c. 67 L.190 23/12/14."+&
	"Contributo alla gestione separata INPS 4%"
	tab_1.tabpage_2.dw_2.setitem(al_row, "rdoc_descrizione", ls_des)
end if

end subroutine

public function long wf_crea_articolo (string as_codice, long al_riga, long al_id_cat_codifica);datastore ds_art
long ll_id_art_locale, ll_id_tit, ll_um_id
string ls_des
decimal ldc_calo_pref
datawindowchild dwc_articolo
integer rtncode




	ds_art=create datastore
	ds_art.dataobject="d_art_imp"
	ds_art.settransobject(sqlca)
	
		select art_id
		into :ll_id_art_locale
		from dba.art 
		where art_codice=:as_codice
		;
		if ll_id_art_locale>0 then //l'articolo esiste già non si deve fare nulla , quasi nulla
			tab_1.tabpage_2.dw_2.SetItem(al_riga,"rdoc_art_id", ll_id_art_locale)
			
		else //l'articolo non esiste occorre inserirlo
			ds_art.reset()
			ds_art.insertrow(1)
			ds_art.setitem(1, "art_codice", as_codice)
			tab_1.tabpage_2.dw_5.accepttext()
			ls_des=tab_1.tabpage_2.dw_5.getitemstring(al_riga, "rdoc_descrizione")
			ds_art.setitem(1, "art_descrizione", ls_des)
			ds_art.setitem(1, "art_id_codifica", al_id_cat_codifica)
			ds_art.setitem(1, "usa_in_magazzino", 'S')
			ll_id_tit=tab_1.tabpage_2.dw_2.getitemnumber(al_riga, "tit_id")  // "")
			ldc_calo_pref=tab_1.tabpage_2.dw_2.getitemdecimal(al_riga, "rdoc_calo")  //
			ll_um_id=  tab_1.tabpage_2.dw_2.getitemnumber(al_riga, "um_id")
			ds_art.setitem(1, "um_id", ll_um_id)
			ds_art.setitem(1, "art_tit_preferenziale", ll_id_tit)
			ds_art.setitem(1, "art_calo_preferenziale", ldc_calo_pref)
			if ds_art.update()=1 then
				commit;
			else
				rollback;
				 MessageBox( "Error", "Articolo NON salvato")
			end if
			ll_id_art_locale=ds_art.getitemnumber(1, "art_id")
			
			//ricarico la dropdown
			rtncode = tab_1.tabpage_2.dw_2.GetChild('rdoc_art_id', dwc_articolo)
			IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild art")
			dwc_articolo.SetTransObject(sqlca)
			dwc_articolo.retrieve()
			tab_1.tabpage_2.dw_2.post SetItem(al_riga,"rdoc_art_id", ll_id_art_locale)
	
				
		end if
	destroy ds_art
	
	
	return ll_id_art_locale

end function

public subroutine wf_allinea_finocalo (long al_riga);decimal ldc_finocalo
string ls_finocalo
decimal ldc_attuale
boolean lb_da_scrivere
if al_riga>0 then
	ldc_finocalo=tab_1.tabpage_2.dw_5.getitemdecimal(al_riga, "c_fino_calo")
	//20260904 Con le partite automatiche ('A') l'allineamento e' gia' stato
	//fatto dentro wf_gestisci_partita_oro PRIMA del cb_salva. Questa chiamata
	//arriva dal 'post' dell'itemchanged e gira DOPO il salvataggio: se
	//riscrivesse il valore, la riga tornerebbe "modificata" subito dopo
	//l'update pur senza modifiche reali da salvare. Quindi scrivo solo se
	//il valore e' davvero diverso. (PowerScript non ha short-circuit: annido.)
	ldc_attuale=tab_1.tabpage_2.dw_2.getitemdecimal(al_riga, "finoecalo")
	lb_da_scrivere = false
	if isnull(ldc_finocalo) then
		if not isnull(ldc_attuale) then lb_da_scrivere = true
	else
		if isnull(ldc_attuale) then
			lb_da_scrivere = true
		else
			if ldc_attuale <> ldc_finocalo then lb_da_scrivere = true
		end if
	end if
	if lb_da_scrivere then
		tab_1.tabpage_2.dw_2.setitem(al_riga, "finoecalo", ldc_finocalo)
	end if
	tab_1.tabpage_2.dw_2.setfocus()
//	tab_1.tabpage_2.dw_2.trigger event ue_update()
end if
end subroutine

public subroutine wf_gestisci_partita_oro (string as_peso, long al_row, decimal adc_peso_originale);long ll_id_tit, ll_id_caus
string ls_metallo, ls_tipo_partita, ls_scarico, ls_test,ls_partita_a_legato
date ldt_data_fine, ldt_da_data
s_partita_oro lstr_partita
integer li_ret
decimal ldc_scaricato,ldc_non_prezioso
long ll_id_guida
string ls_ges_partite

select attiva_partite, data_inizio_saldi, partite_a_legato
into :ls_test, :ldt_da_data, :ls_partita_a_legato
from dba.val_base
;
if ls_test='S' then
	//controllo se la causale prevede gestione partita oro (segno caus_c_s='S')
	ll_id_caus=tab_1.tabpage_2.dw_2.getitemnumber(al_row, "causale_id")
	select caus_c_s, caus_partita
	into :ls_scarico, :lstr_partita.s_tipo_partita 
	from dba.causale
	where caus_id=:ll_id_caus;
	if ls_scarico='S' then
		//20260831 come si gestiscono le partite lo dice la guida del documento:
		//'A' automatiche, 'P' a scelta utente, 'N' o NULL nessuna gestione
		ll_id_guida = tab_1.tabpage_1.dw_1.getitemnumber(1, "guida_id")
		setnull(ls_ges_partite)
		select ges_partite
		into   :ls_ges_partite
		from   dba.guida
		where  guida_id = :ll_id_guida ;
		if isnull(ls_ges_partite) then ls_ges_partite = "N"
		ls_ges_partite = upper(trim(ls_ges_partite))
		if ls_ges_partite <> "A" and ls_ges_partite <> "P" then return

		lstr_partita.dc_coef_calo=tab_1.tabpage_2.dw_2.getitemdecimal(al_row, "rdoc_calo")

		//20231123 inserisco il legato
		lstr_partita.dc_legato=dec(as_peso)
		ldc_non_prezioso=round(tab_1.tabpage_2.dw_2.getitemdecimal(al_row, "rdoc_non_prezioso") ,2)
		if isnull(ldc_non_prezioso) then ldc_non_prezioso=0
		lstr_partita.dc_finocalo=round((lstr_partita.dc_legato -  ldc_non_prezioso) * lstr_partita.dc_coef_calo  /1000, 2)
				
		
		lstr_partita.data_fine=tab_1.tabpage_1.dw_1.getitemdate(1, "doc_data")
		lstr_partita.l_conto=tab_1.tabpage_1.dw_1.getitemnumber(1, "doc_conto_id")
		lstr_partita.l_tit=tab_1.tabpage_2.dw_2.getitemnumber(al_row, "tit_id")
		lstr_partita.l_id_riga_scarico=tab_1.tabpage_2.dw_2.getitemnumber(al_row, "rdoc_id")
		if isnull(lstr_partita.l_id_riga_scarico) then
			//20260809 salvataggio di servizio: serve solo a farsi assegnare rdoc_id
			//prima di aprire la gestione partite. Non deve far ripartire il ricalcolo
			//del castelletto, che verrebbe postato e girerebbe dentro la modale.
			ib_no_ricalcolo=true
			li_ret=tab_1.tabpage_2.dw_2.trigger event ue_update()
			ib_no_ricalcolo=false
			lstr_partita.l_id_riga_scarico=tab_1.tabpage_2.dw_2.getitemnumber(al_row, "rdoc_id")
		end if
		select m.met_metallo, m.met_id
		into :lstr_partita.s_metallo,  :lstr_partita.l_metallo
		from metallo m, titolo t
		where m.met_id=t.tit_met_id
		and tit_id=:lstr_partita.l_tit
		;
		//passo la data di inizio saldi
		lstr_partita.data_inizio_saldi=ldt_da_data
	 	//recupero il peso che c'era prima dell'itemchanged 20220728
		if ls_ges_partite = "A" then
			ldc_scaricato = wf_scarica_partite_auto(lstr_partita)
		else
			openwithparm(w_partita_oro_gd, lstr_partita)
			ldc_scaricato = message.doubleparm
		end if
		if isnull(ldc_scaricato) or ldc_scaricato=0 then ldc_scaricato=adc_peso_originale //non si è scaricato lascio tutto com'era  	//recupero il peso che c'era prima dell'itemchanged 20220728
		//if ldc_scaricato<>lstr_partita.dc_finocalo then
			//prima passavo il fino ora passo il legato
			//tab_1.tabpage_2.dw_2.post setitem(al_row, "rdoc_peso", ldc_scaricato / lstr_partita.dc_coef_calo*1000)
		//tab_1.tabpage_2.dw_2.post setitem(al_row, "rdoc_peso", ldc_scaricato) //spostato sotto senza post 20220824
		tab_1.tabpage_2.dw_2.setitem(al_row, "rdoc_peso", ldc_scaricato)
		//end if
		//20260904 Con 'A' non si apre nessuna modale. Il message loop di
		//w_partita_oro_gd era anche cio' che faceva girare in tempo il
		//"post wf_allinea_finocalo(row)" dell'itemchanged: senza modale quel
		//post gira DOPO il cb_salva qui sotto, su un buffer che non viene piu'
		//salvato, e finoecalo puo' restare a zero sul database. Lo allineo prima.
		if ls_ges_partite = "A" then wf_allinea_finocalo(al_row)
		 idw_corrente=tab_1.tabpage_2.dw_2 
		cb_salva.trigger event clicked()
		
	end if
end if
end subroutine

public function decimal wf_scarica_partite_auto (s_partita_oro astr);//20260831 Allocazione automatica delle partite quando guida.ges_partite='A'.
//Usa lo stesso dataobject e gli stessi argomenti della finestra manuale
//w_partita_oro_gd, ma alloca dalla piu' vecchia. Ritorna il legato scaricato.
datastore lds_aperture, lds_scarico
decimal ldc_da_scaricare, ldc_residuo, ldc_quota, ldc_chiudi_a_gr, ldc_legato
long ll_righe, ll_riga, i
integer li_num
string ls_err

ldc_da_scaricare = astr.dc_finocalo
if isnull(ldc_da_scaricare) then return 0
if ldc_da_scaricare <= 0 then return 0
if isnull(astr.dc_coef_calo) then return 0
if astr.dc_coef_calo <= 0 then
	messagebox("Attenzione!", "Coefficiente di calo mancante o a zero: le partite non sono state scaricate.")
	return 0
end if

//soglia sotto la quale una partita si considera chiusa (come nella finestra)
ldc_chiudi_a_gr = 0.1
select par_chiusa_residuo into :ldc_chiudi_a_gr from dba.val_base ;
if isnull(ldc_chiudi_a_gr) then ldc_chiudi_a_gr = 0.1

//--- 1) reintegro: via gli scarichi gia' fatti da QUESTA riga, altrimenti a
//    ogni ritocco del peso i nuovi si sommerebbero ai vecchi
lds_scarico = create datastore
lds_scarico.dataobject = "d_partita_scarico_ra_gd"
lds_scarico.settransobject(sqlca)
ll_righe = lds_scarico.retrieve(astr.l_id_riga_scarico)
if ll_righe > 0 then
	lds_scarico.rowsmove(1, ll_righe, primary!, lds_scarico, 1, delete!)
	if lds_scarico.update() = 1 then
		commit;
	else
		rollback;
		ls_err = sqlca.sqlerrtext
		if isnull(ls_err) then ls_err = ""
		messagebox("Errore!", "Non riesco a liberare gli scarichi precedenti:~r~n" + ls_err)
		destroy lds_scarico
		return 0
	end if
end if

//--- 2) partite aperte: stessi criteri della finestra manuale
lds_aperture = create datastore
lds_aperture.dataobject = "d_partita_oro_gd"
lds_aperture.settransobject(sqlca)
ll_righe = lds_aperture.retrieve(astr.s_tipo_partita, astr.data_fine, astr.l_conto, &
                                 astr.l_metallo, astr.data_inizio_saldi, astr.l_tit)

if ll_righe > 0 then
	//il coef di calo serve alle computed c_residuo / c_a_legato
	for i = 1 to ll_righe
		lds_aperture.setitem(i, "c_coef_calo", astr.dc_coef_calo)
	next
	//scarto le partite gia' esaurite, come fa la finestra
	lds_aperture.setfilter("c_residuo > " + f_cambia_virgola_in_punto(string(ldc_chiudi_a_gr)))
	lds_aperture.filter()
	//DALLA PIU' VECCHIA: la SELECT di d_partita_oro_gd non ha ORDER BY,
	//quindi l'ordine va imposto qui
	lds_aperture.setsort("doc_data A, rdoc_id A")
	lds_aperture.sort()
	ll_righe = lds_aperture.rowcount()
end if

//--- 3) allocazione, dalla piu' vecchia
li_num = 0
for i = 1 to ll_righe
	if ldc_da_scaricare <= 0 then exit
	ldc_residuo = lds_aperture.getitemdecimal(i, "c_residuo")
	if isnull(ldc_residuo) then ldc_residuo = 0
	if ldc_residuo > 0 then
		if ldc_residuo >= ldc_da_scaricare then
			ldc_quota = ldc_da_scaricare
		else
			ldc_quota = ldc_residuo
		end if
		li_num ++
		ll_riga = lds_scarico.insertrow(0)
		lds_scarico.setitem(ll_riga, "id_scarico",  astr.l_id_riga_scarico)
		lds_scarico.setitem(ll_riga, "id_apertura", lds_aperture.getitemnumber(i, "rdoc_id"))
		lds_scarico.setitem(ll_riga, "numero",      li_num)
		lds_scarico.setitem(ll_riga, "scarico",     ldc_quota)
		ldc_da_scaricare -= ldc_quota
	end if
next

if li_num > 0 then
	if lds_scarico.update() = 1 then
		commit;
	else
		rollback;
		ls_err = sqlca.sqlerrtext
		if isnull(ls_err) then ls_err = ""
		messagebox("Errore!", "Scarico partite non riuscito:~r~n" + ls_err)
		destroy lds_aperture
		destroy lds_scarico
		return 0
	end if
end if

//--- 4) legato effettivamente scaricato
ldc_legato = round((astr.dc_finocalo - ldc_da_scaricare) * 1000 / astr.dc_coef_calo, 2)
//stessa tolleranza della finestra manuale (cb_ok): sotto 0,2 si prende il richiesto
if abs(astr.dc_legato - ldc_legato) < 0.2 then ldc_legato = astr.dc_legato

if ldc_da_scaricare > 0 then
	messagebox("Attenzione!", "Carico insufficiente: restano " + &
	    string(ldc_da_scaricare, "#,##0.00") + " di fino da scaricare.~r~n" + &
	    "La riga del documento viene creata ugualmente.")
	//la riga mantiene il peso richiesto dall'utente
	ldc_legato = astr.dc_legato
end if

destroy lds_aperture
destroy lds_scarico

return ldc_legato
end function

protected subroutine wf_campi_trasporto (long al_id_guida);string ls_mezzo
long ll_id_trasp, ll_id_caus_trasp, ll_id_asp_beni


select prop_doc_a_mezzo, prop_trasp_id, prop_caus_trasp_id, prop_asp_beni_id
into :ls_mezzo, :ll_id_trasp, :ll_id_caus_trasp, :ll_id_asp_beni
from dba.guida where guida_id=:al_id_guida;
if ls_mezzo>" " then tab_1.tabpage_1.dw_1.setitem(1, "doc_a_mezzo", ls_mezzo)
if ll_id_asp_beni>0 then tab_1.tabpage_1.dw_1.setitem(1, "asp_beni_id", ll_id_asp_beni)
if ll_id_trasp>0 then tab_1.tabpage_1.dw_1.setitem(1, "trasp_id", ll_id_trasp)
if ll_id_caus_trasp>0 then tab_1.tabpage_1.dw_1.setitem(1, "caus_trasporto_id", ll_id_caus_trasp)



end subroutine

public subroutine wf_allinea_ddt_collegati (long al_riga);
end subroutine

on w_doc_ff.create
int iCurrent
call super::create
this.pb_bilancia=create pb_bilancia
this.dw_cod_barre=create dw_cod_barre
this.cb_nuovo_doc=create cb_nuovo_doc
this.cb_duplica=create cb_duplica
this.cb_esplodi=create cb_esplodi
this.cb_stampa=create cb_stampa
this.cb_cancella=create cb_cancella
this.cb_salva=create cb_salva
this.cb_inserisci=create cb_inserisci
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.tab_1=create tab_1
this.internetresult_1=create internetresult_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_bilancia
this.Control[iCurrent+2]=this.dw_cod_barre
this.Control[iCurrent+3]=this.cb_nuovo_doc
this.Control[iCurrent+4]=this.cb_duplica
this.Control[iCurrent+5]=this.cb_esplodi
this.Control[iCurrent+6]=this.cb_stampa
this.Control[iCurrent+7]=this.cb_cancella
this.Control[iCurrent+8]=this.cb_salva
this.Control[iCurrent+9]=this.cb_inserisci
this.Control[iCurrent+10]=this.cb_annulla
this.Control[iCurrent+11]=this.cb_ok
this.Control[iCurrent+12]=this.tab_1
end on

on w_doc_ff.destroy
call super::destroy
destroy(this.pb_bilancia)
destroy(this.dw_cod_barre)
destroy(this.cb_nuovo_doc)
destroy(this.cb_duplica)
destroy(this.cb_esplodi)
destroy(this.cb_stampa)
destroy(this.cb_cancella)
destroy(this.cb_salva)
destroy(this.cb_inserisci)
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.tab_1)
destroy(this.internetresult_1)
end on

event open;DataWindowChild ldwc_iva, ldwc_maga, ldwc_causale
integer rtncode
string ls_tipo_azienda


tab_1.tabpage_1.dw_1.settransobject(sqlca)

select tipo_azienda
into :ls_tipo_azienda
from dba.val_base;
choose case ls_tipo_azienda
	case 'N' 
		tab_1.tabpage_2.dw_2.dataobject="d_rdoc_negozio_gd"
		tab_1.tabpage_2.dw_5.dataobject="d_rdoc_negozio_sh01_tb"
end choose
	
tab_1.tabpage_2.dw_2.settransobject(sqlca)

tab_1.tabpage_2.dw_7.settransobject(sqlca)
tab_1.tabpage_2.dw_8.settransobject(sqlca)
tab_1.tabpage_2.dw_9.settransobject(sqlca)
tab_1.tabpage_1.dw_3.settransobject(sqlca)
tab_1.tabpage_1.dw_4.settransobject(sqlca)
tab_1.tabpage_1.dw_6.settransobject(sqlca)
tab_1.tabpage_2.dw_12.settransobject(sqlca)


tab_1.tabpage_2.dw_10.settransobject(sqlca)

dw_cod_barre.insertrow(1)

tab_1.tabpage_1.dw_1.trigger event ue_insert(0)
tab_1.tabpage_2.dw_2.sharedata(tab_1.tabpage_2.dw_5)
//tab_1.tabpage_2.dw_2.sharedata(tab_1.tabpage_2.dw_13)

rtncode = tab_1.tabpage_2.dw_5.GetChild('iva_id', ldwc_iva)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild iva")
rtncode = tab_1.tabpage_2.dw_5.GetChild('mag_id', ldwc_maga)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild maga")
rtncode = tab_1.tabpage_2.dw_5.GetChild('causale_id', ldwc_causale)
//
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild causale")
// Set the transaction object for the child

ldwc_maga.SetTransObject(sqlca)
ldwc_causale.SetTransObject(sqlca)
ldwc_iva.SetTransObject(sqlca)
// Populate with values for eastern states

ldwc_causale.Retrieve()
ldwc_maga.Retrieve()
ldwc_iva.Retrieve()



if message.doubleparm>0 then wf_apertura_da_stampe(message.doubleparm)





end event

event key;call super::key;//if keyflags=2 then
//	CHOOSE CASE key
//		
//		CASE KeyN!
//		cb_nuovo_doc.triggerevent(clicked!)
//	
//	END CHOOSE
//end if
end event

event close;call super::close;string ls_codice

select az_codice into :ls_codice from dba.azienda;
if ls_codice='CSL' then
	tab_1.tabpage_1.dw_1.trigger event ue_update()
	tab_1.tabpage_2.dw_2.trigger event ue_update()
	tab_1.tabpage_1.dw_3.trigger event ue_update()
	tab_1.tabpage_1.dw_4.trigger event ue_update()
	tab_1.tabpage_1.dw_6.trigger event ue_update()
end if
end event

type pb_bilancia from picturebutton within w_doc_ff
integer x = 1307
integer width = 178
integer height = 140
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\sultak\icone\Bilancia.png"
alignment htextalign = left!
end type

event clicked;DWObject my_dwo
decimal ld_peso_netto
long	ll_row, ll_id_articolo
string ls_metallo

w_bilancia w_bil
open(w_bil)

ld_peso_netto=w_bil.f_rendi_peso()
close(w_bil)
//if isnull(ld_peso_netto) then ld_peso_netto=0
//messagebox("A", string (ld_peso_netto))

if ld_peso_netto>0 then
	ll_row = tab_1.tabpage_2.dw_2.getrow()
	my_dwo = tab_1.tabpage_2.dw_2.object.rdoc_peso
	tab_1.tabpage_2.dw_2.setitem(ll_row,"rdoc_peso",ld_peso_netto)
	tab_1.tabpage_2.dw_2.trigger event itemchanged(ll_row, my_dwo, string(ld_peso_netto))
end if

//
end event

type dw_cod_barre from udw_000 within w_doc_ff
integer x = 3479
integer y = 8
integer width = 361
integer height = 152
integer taborder = 60
string dataobject = "d_cod_barre_ext"
end type

event editchanged;call super::editchanged;string  ls_num_bol, ls_des, ls_num_doc,ls_data_range
datastore ds_righe
long ll_riga_copiata, ll_null, ll_id_riga_prov, ll_doc_id, ll_num_riga, ll_righe, ll_id_causale,ll_id_guida
date ldt_data_doc, ldt_data_range
integer li_num_riga=0

setnull(ll_null)
if dwo.name="cod_barre"  then
	if len(data)=7   then
		ls_num_bol=data //mid(data, 3, 5)  //20251104 cambiamo 7 numeri non più 5
		ds_righe=create datastore
		ds_righe.dataobject="d_rdoc_sh_imp_cod_barre"
		ds_righe.settransobject(sqlca)
		ll_righe=0
		ll_righe=ds_righe.retrieve(long(ls_num_bol))
		if ll_righe=0 or isnull(ll_righe) then //20251104 se non trovo righe provo a tornare al vecchio sistema...
			ls_num_bol=mid(data, 3, 5)
			ll_righe=0
			ll_righe=ds_righe.retrieve(long(ls_num_bol))
		end if
		if ll_righe>=1 then //20230510 se c'è più di una riga prendo la prima (sono in ordine descrscente)
			//controllo se è già stata derivata ...
			ll_id_riga_prov=ds_righe.getitemnumber(1, "rdoc_id" )
			ldt_data_range=relativedate(today(), -90)
			ls_data_range=string(ldt_data_range, "yyyy/mm/dd")
			select doc_numero, doc_data, rdoc_numero
			into :ls_num_doc, :ldt_data_doc, :li_num_riga
			from dba.rdoc r, doc d where d.doc_id=r.rdoc_doc_id and rdoc_id_riga_madre=:ll_id_riga_prov
			and doc_data > date(:ls_data_range);
			if li_num_riga>0 then
				messagebox("Attenzione!", "Bollettina già derivata nel doc n. "+ls_num_doc+" del "+string(ldt_data_doc, "dd/mm/yyyy") + " - Riga: " +string(li_num_riga))
			else
				ds_righe.rowscopy(1, 1, primary!, tab_1.tabpage_2.dw_2, tab_1.tabpage_2.dw_2.rowcount()+1,  primary! )
				ll_riga_copiata=tab_1.tabpage_2.dw_2.rowcount()
				ll_id_guida=tab_1.tabpage_1.dw_1.getitemnumber(1, "guida_id")
				select guida_caus_id into :ll_id_causale
				from dba.guida where guida_id=:ll_id_guida
				;
				tab_1.tabpage_2.dw_2.setitem(ll_riga_copiata, "causale_id", ll_id_causale)
				tab_1.tabpage_2.dw_2.setitem(ll_riga_copiata, "rdoc_id_riga_madre", ll_id_riga_prov)
				tab_1.tabpage_2.dw_2.setitem(ll_riga_copiata, "rdoc_id", ll_null)
				ll_doc_id=tab_1.tabpage_1.dw_1.getitemnumber(1, "doc_id")
				tab_1.tabpage_2.dw_2.setitem(ll_riga_copiata, "rdoc_doc_id", ll_doc_id)
				ll_num_riga=tab_1.tabpage_2.dw_2.getitemnumber(ll_riga_copiata, "c_max_num_riga")
				ls_des=tab_1.tabpage_2.dw_2.getitemstring(ll_riga_copiata,"rdoc_descrizione")+" - BOL.: "+ls_num_bol
				tab_1.tabpage_2.dw_2.setitem(ll_riga_copiata, "rdoc_descrizione", ls_des)
				//tab_1.tabpage_2.dw_2.setitem(ll_riga_copiata, "num_bollettina", ll_null)
				tab_1.tabpage_2.dw_2.setitem(ll_riga_copiata, "rdoc_numero", ll_num_riga+1)
				tab_1.tabpage_2.dw_2.scrolltorow(ll_riga_copiata)
			end if
//		elseif  ll_righe>1 then  //20230510 c'è anche quella dell'anno precedente... inutile fermare per doppio risultato, prendo il primo
//			openwithparm(w_verifica_cod_barre, long(ls_num_bol))
		else
			messagebox("Attenzione!", "Bollettina "+ls_num_bol+" NON trovata!")
		end if
		reset()
		insertrow(1)
		post setfocus(this)
		post setcolumn("cod_barre")
		destroy ds_righe
	end if
end if
end event

type cb_nuovo_doc from commandbutton within w_doc_ff
string tag = "CTRL+N"
integer x = 2395
integer y = 20
integer width = 302
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuovo Doc."
end type

event clicked;dwitemstatus ls_status
long ll_test, ll_riga

if tab_1.tabpage_1.dw_1.rowcount()>0 then
	ls_status=tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!)
	if ls_status=datamodified! then
		ll_test=tab_1.tabpage_1.dw_1.trigger event ue_update()
		if ll_test<>1 then
			messagebox("Attenzione!", "Salvataggio documento NON riiuscito: non posso creare un nuovo documento!")
			return
		end if
	end if
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_3.reset()
	tab_1.tabpage_1.dw_4.reset()
	tab_1.tabpage_1.dw_6.reset()
	tab_1.tabpage_2.dw_2.reset()
	tab_1.tabpage_2.dw_7.reset()
	tab_1.tabpage_2.dw_8.reset()
	tab_1.tabpage_2.dw_9.reset()
//	tab_1.tabpage_2.dw_10.reset()
	ll_riga=tab_1.tabpage_1.dw_1.trigger event ue_insert(0)
	tab_1.SelectTab(1)

end if
	
end event

type cb_duplica from uo_commandbutton within w_doc_ff
integer x = 1979
integer y = 20
integer width = 206
integer height = 96
integer taborder = 50
integer textsize = -8
string text = "Duplica"
end type

event clicked;long ll_riga, ll_max_riga, ll_null, ll_id_reg, ll_num_prog, ll_id_doc, ll_id_rdoc,ll_id_riga_derivata
integer li_ret, i,li_num_riga
setnull(ll_null)
datastore dw_spese
decimal ldc_fc_resto,ldc_c_calo


if idw_corrente=tab_1.tabpage_2.dw_2 then
	ll_riga=tab_1.tabpage_2.dw_2.getrow()
	if ll_riga>0 then
		ll_id_riga_derivata=tab_1.tabpage_2.dw_2.getitemnumber(ll_riga, "rdoc_id_riga_madre")
		tab_1.tabpage_2.dw_2.rowscopy(ll_riga, ll_riga, Primary!, tab_1.tabpage_2.dw_2, ll_riga+1, Primary!)
		ll_max_riga=tab_1.tabpage_2.dw_2.getitemnumber(1, "c_max_num_riga")
//		for i= 1 to tab_1.tabpage_2.dw_2.rowcount()
//			tab_1.tabpage_2.dw_2.setitem(i, "rdoc_numero",i*100)
//		next
		li_num_riga=tab_1.tabpage_2.dw_2.getitemnumber(ll_riga, "rdoc_numero")
		tab_1.tabpage_2.dw_2.setitem(ll_riga+1, "rdoc_numero", li_num_riga+1)
		//ll_id_rdoc=tab_1.tabpage_2.dw_2.getitemnumber(tab_1.tabpage_2.dw_2.getrow(), "rdoc_id")
		tab_1.tabpage_2.dw_2.setitem(ll_riga+1, "rdoc_id", ll_null)
		select rdoc_peso*rdoc_calo/1000 - isnull(finoecalo_evaso, 0)
		into :ldc_fc_resto
		from dba.rdoc
		where rdoc_id=:ll_id_riga_derivata;
		ldc_c_calo=tab_1.tabpage_2.dw_2.getitemdecimal(ll_riga, "rdoc_calo")
		if ldc_fc_resto>0 then
			tab_1.tabpage_2.dw_2.setitem(ll_riga+1, "rdoc_peso", ldc_fc_resto/ ldc_c_calo*1000)
		else
			tab_1.tabpage_2.dw_2.setitem(ll_riga+1, "rdoc_peso", 0)
		end if
//		wf_calcola_saldo_derivazione(ll_riga+1)
	end if
	
	return ll_riga+1
elseif  idw_corrente=tab_1.tabpage_1.dw_1 then
//	tab_1.tabpage_1.dw_1.setitem(1, "doc_id", ll_null)  //20240221 Non funge qundi commento appena posso lo metto a posto
//	ll_id_reg=tab_1.tabpage_1.dw_1.GETITEMNUMBER(1, "REG_id")
//	select max(doc_num_prog)
//	into :ll_num_prog
//	from dba.doc
//	where reg_id = :ll_id_reg;
//	ll_num_prog++
//	tab_1.tabpage_1.dw_1.setitem(1, "doc_num_prog", ll_num_prog)
//	tab_1.tabpage_1.dw_1.setitem(1, "doc_numero", string(ll_num_prog))
//	li_ret=tab_1.tabpage_1.dw_1.setitemstatus(1,0, primary!, newmodified!)
////	//memorizzo le spese se ci sono
////	if tab_1.tabpage_1.dw_4.rowcount()>0 then
////		dw_spese=create datastore
////		dw_spese.object=tab_1.tabpage_1.dw_4.object
////		dw_spese.settransobject(sqlca)
////		tab_1.tabpage_1.dw_4.rowcopy(
////	//fine spese
//	
//	li_ret=tab_1.tabpage_1.dw_1.trigger event ue_update()
//	ll_id_doc=tab_1.tabpage_1.dw_1.GETITEMNUMBER(1, "doc_id")
//	
//	if li_ret=1 and ll_id_doc>0 then
//		
//		for i= 1 to tab_1.tabpage_2.dw_2.rowcount()
//			 tab_1.tabpage_2.dw_2.setitem(i, "rdoc_doc_id", ll_id_doc)
//			 li_ret=tab_1.tabpage_2.dw_2.setitemstatus(i,0, primary!, newmodified!)
//		next
//		li_ret=tab_1.tabpage_2.dw_2.trigger event ue_update()
	//end if
end if

end event

type cb_esplodi from uo_commandbutton within w_doc_ff
integer x = 1765
integer y = 20
integer width = 206
integer height = 96
integer taborder = 70
integer textsize = -8
string text = "Esplodi"
end type

event clicked;integer li_righe, i, li_r_distinta, a, li_riga_inserita, li_riga_trovata
long ll_art_id, ll_id_distinta, ll_riga_madre, ll_art_riga_distinta
long ll_id_riga_partenza
datastore ds_righe_distinta
decimal ldc_qta, ldc_qta_riga, ldc_peso_riga

li_righe=tab_1.tabpage_2.dw_2.rowcount()
ll_id_riga_partenza=tab_1.tabpage_2.dw_2.getrow()
if ll_id_riga_partenza>0 then
	ll_id_distinta=0
	ll_art_id=tab_1.tabpage_2.dw_2.getitemnumber(ll_id_riga_partenza, "rdoc_art_id")
	if ll_art_id>0 then
		select distinta_id
		into :ll_id_distinta
		from dba.distinta
		where art_id=:ll_art_id;
		if ll_id_distinta>0 then
			tab_1.tabpage_2.dw_2.trigger event ue_update()
			ldc_qta=tab_1.tabpage_2.dw_2.getitemdecimal(ll_id_riga_partenza, "rdoc_qta")
			ll_riga_madre=tab_1.tabpage_2.dw_2.getitemnumber(ll_id_riga_partenza, "rdoc_id")
			ds_righe_distinta=create datastore
			ds_righe_distinta.dataobject='d_riga_distinta_tb'
			ds_righe_distinta.settransobject(sqlca)
			li_r_distinta=ds_righe_distinta.retrieve(ll_id_distinta)
			for a= 1 to li_r_distinta
				ll_art_riga_distinta=ds_righe_distinta.getitemnumber(a, "art_id")
				ldc_qta_riga=ds_righe_distinta.getitemdecimal(a, "qta")
				ldc_qta_riga*=ldc_qta
				ldc_peso_riga=ds_righe_distinta.getitemdecimal(a, "peso")
				ldc_peso_riga*=ldc_qta
				li_riga_trovata=tab_1.tabpage_2.dw_2.find("id_riga_articolo_padre= "+string(ll_riga_madre)+&
														" and rdoc_art_id= "+string(ll_art_riga_distinta), +&
														ll_id_riga_partenza, ll_id_riga_partenza+ li_r_distinta)
				if li_riga_trovata>0 then
					tab_1.tabpage_2.dw_2.setitem(li_riga_trovata, "rdoc_qta", ldc_qta_riga)
					tab_1.tabpage_2.dw_2.setitem(li_riga_trovata, "rdoc_peso", ldc_peso_riga)
				else
					li_riga_inserita=tab_1.tabpage_2.dw_2.trigger event ue_insert(0)
					tab_1.tabpage_2.dw_2.setitem(li_riga_inserita, "rdoc_art_id", ll_art_riga_distinta)
					wf_dati_articolo(li_riga_inserita, ll_art_riga_distinta)
					tab_1.tabpage_2.dw_2.setitem(li_riga_inserita, "rdoc_qta", ldc_qta_riga)
					tab_1.tabpage_2.dw_2.setitem(li_riga_inserita, "rdoc_peso", ldc_peso_riga)
					tab_1.tabpage_2.dw_2.setitem(li_riga_inserita, "stampa", 'N')
					tab_1.tabpage_2.dw_2.setitem(li_riga_inserita, "id_riga_articolo_padre", ll_riga_madre)
				end if
			next
			destroy ds_righe_distinta
		end if
	end if

end if
end event

type cb_stampa from uo_commandbutton within w_doc_ff
integer x = 3931
integer y = 20
integer width = 229
integer height = 96
integer taborder = 60
integer textsize = -8
integer weight = 700
string text = "Stampa"
end type

event clicked;date ldt_data
datetime ldtt_test
string ls_cod_azienda
integer li_pos

s_st_doc st_doc
if tab_1.tabpage_1.dw_1.getrow()=1 then
	select az_codice into :ls_cod_azienda from dba.azienda;
	ldt_data=tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "doc_data")
	if ls_cod_azienda="CSL" then
		ldtt_test=tab_1.tabpage_1.dw_1.getitemdatetime(tab_1.tabpage_1.dw_1.getrow(), "data_ora_trasporto")
			ldt_data=tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "doc_data")
		if isnull(ldtt_test) or ldtt_test<=datetime("1900-01-01 00:00:00") then
			tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "data_ora_trasporto", datetime(ldt_data, now())) //20230601 Vittorio vuole data_ora se manca
		end if
	end if
	idw_corrente=tab_1.tabpage_1.dw_1
	cb_salva.triggerevent(clicked!)
	st_doc.sl_id_doc=tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "doc_id")
	if isnull(st_doc.sl_id_doc) then return
//	ldt_data=tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "doc_data")  //spostato su sopra
	st_doc.ss_name=tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "doc_numero")
	li_pos= pos(st_doc.ss_name, "/")
	if li_pos>0 then
		st_doc.ss_name=replace(st_doc.ss_name, li_pos, 1, "-")
		//st_doc.ss_name=left(st_doc.ss_name, li_pos - 1)+"-"+right(st_doc.ss_name, len(st_doc.ss_name) - li_pos)
	end if
	st_doc.ss_name="DOC_n_"+st_doc.ss_name+ "_del_"+ string(ldt_data, "dd-mm-yyyy")
	st_doc.dt_inizio_esercizio=f_trova_inizio_esercizio(ldt_data)
	
	openwithparm(w_st_doc, st_doc, parent)
	post setfocus(tab_1.tabpage_2.dw_2)
end if

end event

type cb_cancella from uo_commandbutton within w_doc_ff
integer x = 2981
integer y = 20
integer width = 247
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
ll_riga_da_cancellare=idw_corrente.getrow()

if ll_riga_da_cancellare>0 then
	tab_1.tabpage_2.dw_2.trigger event ue_delete(ll_riga_da_cancellare)	
end if
end event

type cb_salva from uo_commandbutton within w_doc_ff
integer x = 3241
integer y = 20
integer width = 187
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
string text = "Salva"
end type

event clicked;long ll_riga_corrente


if idw_corrente=tab_1.tabpage_2.dw_2 then
	ll_riga_corrente=idw_corrente.getrow()
	tab_1.tabpage_2.dw_2.trigger event ue_update()
else
	tab_1.tabpage_1.dw_1.trigger event ue_update()
	//tab_1.tabpage_2.dw_2.trigger event ue_update()
	tab_1.tabpage_1.dw_3.trigger event ue_update()
	tab_1.tabpage_1.dw_4.trigger event ue_update()
	tab_1.tabpage_1.dw_6.trigger event ue_update()
end if

//tab_1.tabpage_1.dw_1.trigger event ue_update()
//tab_1.tabpage_2.dw_2.trigger event ue_update()
//tab_1.tabpage_1.dw_3.trigger event ue_update()
//tab_1.tabpage_1.dw_4.trigger event ue_update()
//tab_1.tabpage_1.dw_6.trigger event ue_update()

if idw_corrente=tab_1.tabpage_2.dw_2 and ll_riga_corrente>0 then
	setfocus(idw_corrente)
	 idw_corrente.post scrolltorow(ll_riga_corrente)
end if
end event

type cb_inserisci from uo_commandbutton within w_doc_ff
integer x = 2720
integer y = 20
integer width = 247
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
string text = "Inserisci"
end type

event clicked;long ll_riga, ll_test
dwitemstatus ls_status

if idw_corrente=tab_1.tabpage_1.dw_1 then
	if idw_corrente.rowcount()>0 then
		ls_status=idw_corrente.getitemstatus(1, 0, primary!)
		if ls_status=datamodified! then
			ll_test=idw_corrente.trigger event ue_update()
			if ll_test=1 then 
				idw_corrente.reset()
				ll_riga=idw_corrente.trigger event ue_insert(0)
			end if
				
		else
			idw_corrente.reset()
			ll_riga=idw_corrente.trigger event ue_insert(0)	
		end if
	else
		ll_riga=idw_corrente.trigger event ue_insert(0)
	end if
else
	ll_riga=idw_corrente.trigger event ue_insert(0)
	return ll_riga
end if



end event

type cb_annulla from uo_commandbutton within w_doc_ff
integer x = 4187
integer y = 20
integer width = 201
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_ok from uo_commandbutton within w_doc_ff
integer x = 4402
integer y = 20
integer width = 183
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
string text = "Ok"
end type

event clicked;if messagebox("Salvare?", "Salvare i dati prima di chiudere?", stopsign!, yesno!)=1 then
	idw_corrente.trigger event ue_update()
end if
close(parent)
end event

type tab_1 from tab within w_doc_ff
integer x = 50
integer y = 48
integer width = 4750
integer height = 2280
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean powertips = true
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

event selectionchanged;long ll_id_doc, ll_riga
string ls_test

if oldindex=1 and newindex=2 then
		
	ll_riga=tab_1.tabpage_1.dw_1.getrow()
	
	if ll_riga>0 then wf_calcola_saldo()
	
	ll_id_doc=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga, "doc_id")
	if isnull(ll_id_doc) then
		cb_salva.triggerevent("clicked")
		ll_id_doc=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga, "doc_id")
		if tab_1.tabpage_2.dw_2.rowcount()=0 then
			idw_corrente=tab_1.tabpage_2.dw_2
			tab_1.tabpage_2.dw_2.setfocus()
			if  tab_1.tabpage_1.cbx_riga_automatica.checked then
				wf_riga_automatica()
			else
				cb_inserisci.triggerevent(clicked!)
			end if
		end if
		if isnull(ll_id_doc) then
			return 1
		end if
	else
		if tab_1.tabpage_2.dw_2.rowcount()=0 then 	
			idw_corrente=tab_1.tabpage_2.dw_2
			cb_inserisci.triggerevent(clicked!)
		end if
		//qui aggiungere per inserire riga aut e prima riga anche se l'utente ha salvato al testa prima di andare sulle righe (da fare???)
	end if
	//controllo se si devono vedere o meno i campi n_lacci n_fili 20220405
	select vedi_lacci_fili into :ls_test from dba.val_base;
	if ls_test="S" then
		tab_1.tabpage_2.dw_2.modify("n_lacci.visible=1")
		tab_1.tabpage_2.dw_2.modify("n_fili.visible=1")
	else
		tab_1.tabpage_2.dw_2.modify("n_lacci.visible=0")
		tab_1.tabpage_2.dw_2.modify("n_fili.visible=0")
	end if  //fine 20220405
	tab_1.tabpage_2.dw_2.post setfocus()
	
end if
end event

event key;//if keyflags=2 then
//	CHOOSE CASE key
//		
//		CASE KeyN!
//		cb_nuovo_doc.triggerevent(clicked!)
//	
//	END CHOOSE
//end if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4713
integer height = 2152
long backcolor = 79741120
string text = "Documento"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_canc_doc cb_canc_doc
cbx_cc_num_doc cbx_cc_num_doc
cbx_riga_automatica cbx_riga_automatica
cbx_ric_num_prog cbx_ric_num_prog
cb_deriva cb_deriva
dw_6 dw_6
dw_4 dw_4
cb_ricerca cb_ricerca
dw_1 dw_1
dw_3 dw_3
end type

on tabpage_1.create
this.cb_canc_doc=create cb_canc_doc
this.cbx_cc_num_doc=create cbx_cc_num_doc
this.cbx_riga_automatica=create cbx_riga_automatica
this.cbx_ric_num_prog=create cbx_ric_num_prog
this.cb_deriva=create cb_deriva
this.dw_6=create dw_6
this.dw_4=create dw_4
this.cb_ricerca=create cb_ricerca
this.dw_1=create dw_1
this.dw_3=create dw_3
this.Control[]={this.cb_canc_doc,&
this.cbx_cc_num_doc,&
this.cbx_riga_automatica,&
this.cbx_ric_num_prog,&
this.cb_deriva,&
this.dw_6,&
this.dw_4,&
this.cb_ricerca,&
this.dw_1,&
this.dw_3}
end on

on tabpage_1.destroy
destroy(this.cb_canc_doc)
destroy(this.cbx_cc_num_doc)
destroy(this.cbx_riga_automatica)
destroy(this.cbx_ric_num_prog)
destroy(this.cb_deriva)
destroy(this.dw_6)
destroy(this.dw_4)
destroy(this.cb_ricerca)
destroy(this.dw_1)
destroy(this.dw_3)
end on

type cb_canc_doc from commandbutton within tabpage_1
integer x = 2587
integer y = 500
integer width = 389
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Canc. Doc."
end type

event clicked;if dw_1.getrow()>0 then
	if messagebox("Attenzione!", "Vuoi davvero cancellare irreversibilmente il documento?", stopsign!, yesno!)=1 then
		dw_1.trigger event ue_delete(0)
		dw_1.trigger event ue_update()
		dw_1.post event  ue_insert(0)
	end if
end if
end event

type cbx_cc_num_doc from checkbox within tabpage_1
integer x = 2610
integer y = 128
integer width = 887
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Controllo Coerenza Num. Doc."
end type

type cbx_riga_automatica from checkbox within tabpage_1
integer x = 3017
integer y = 28
integer width = 521
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Riga Automatica"
end type

type cbx_ric_num_prog from checkbox within tabpage_1
integer x = 2610
integer y = 360
integer width = 960
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ricerca per numero progressivo"
boolean checked = true
end type

type cb_deriva from uo_cmdbutton_for_tab within tabpage_1
string tag = "chiede data e profilo da derivare, salva la testa del documento (qundi deve essere completa)."
integer x = 2587
integer y = 224
integer width = 389
integer taborder = 30
string text = "Deriva"
end type

event clicked;long ll_riga_corrente, ll_doc_id, ll_id_riga, ll_righe_esistenti,ll_righe_inserite
integer i, li_num_riga
long ll_caus_id, ll_mag_id, ll_null
s_deriva s_der
string ls_test, ls_codice

dw_1.accepttext()  //20240404 aggiunto un po' tardi, se n'è accorto Jamal che non riportava la riga giusta: grande testatore!!!
ll_riga_corrente=dw_1.getrow()
if ll_riga_corrente>0 then
	s_der.s_id_guida=dw_1.getitemnumber(ll_riga_corrente, "guida_id")
	//recupero causale e magazzino
//		select guida_caus_id, guida_id_magazzino
//		into :ll_caus_id, :ll_mag_id
//		from dba.guida
//		where guida_id=:s_der.s_id_guida
//		;
	s_der.s_a_data=dw_1.getitemdate(ll_riga_corrente, "doc_data")
	s_der.s_id_conto=dw_1.getitemnumber(ll_riga_corrente, "doc_conto_id")
	if s_der.s_id_conto>0 and s_der.s_id_guida>0 then
		openwithparm(w_scegli_data_guida_ext, s_der)
		if isvalid(message.powerobjectparm) then
			s_der=message.powerobjectparm
			s_der.s_id_conto=dw_1.getitemnumber(ll_riga_corrente, "doc_conto_id")
			//20240815 provo a togliere   e mettere salvataggio SOLO del documento (testa doc)
			tab_1.tabpage_1.dw_1.trigger event ue_update()
			//cb_salva.triggerevent("clicked") 
			//fine 2024081
			
			//ll_righe_esistenti=tab_1.tabpage_2.dw_2.rowcount()
			openwithparm(w_deriva_cx, s_der)
			ls_test=message.stringparm
			if ls_test='OK' then
				tab_1.SelectTab(2)
				
				
				
//				ll_doc_id=tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "doc_id")
//				if tab_1.tabpage_2.dw_2.rowcount()<1 then
//					li_num_riga=0
//				else
//					li_num_riga=	tab_1.tabpage_2.dw_2.getitemnumber(1, "c_max_num_riga")
//					if isnull(li_num_riga) then li_num_riga=0	
//				end if
//				//provo
//				setredraw(false)
//				setnull(ll_null)
//				ll_righe_inserite=tab_1.tabpage_2.dw_2.rowcount()
//				for i = ll_righe_esistenti +1 to ll_righe_inserite
//					li_num_riga++
//					ll_id_riga=tab_1.tabpage_2.dw_2.getitemnumber(i, "rdoc_id")
//					tab_1.tabpage_2.dw_2.object.rdoc_id_riga_madre[i]=ll_id_riga
//					tab_1.tabpage_2.dw_2.object.rdoc_id[i]=ll_null	
//					tab_1.tabpage_2.dw_2.object.rdoc_numero[i]=li_num_riga	
//					tab_1.tabpage_2.dw_2.object.finoecalo_evaso[i]=0
//					tab_1.tabpage_2.dw_2.object.rdoc_peso_evaso[i]=0
//					tab_1.tabpage_2.dw_2.object.rdoc_qta_evasa[i]=0
//					tab_1.tabpage_2.dw_2.object.rdoc_doc_id[i]=ll_doc_id
//					tab_1.tabpage_2.dw_2.object.causale_id[i]=ll_caus_id
//					tab_1.tabpage_2.dw_2.object.mag_id[i]=ll_mag_id
//				
//				//	tab_1.tabpage_2.dw_2.setitem(i, "rdoc_id_riga_madre", ll_id_riga)
//				//	tab_1.tabpage_2.dw_2.setitem(i, "rdoc_id", ll_null)
//					//tab_1.tabpage_2.dw_2.setitem(i, "finoecalo_evaso", 0)
//				//	tab_1.tabpage_2.dw_2.setitem(i, "rdoc_peso_evaso", 0)
//					//tab_1.tabpage_2.dw_2.setitem(i, "rdoc_qta_evasa", 0)
//					
//					//tab_1.tabpage_2.dw_2.setitem(i, "rdoc_numero",li_num_riga)
//					//tab_1.tabpage_2.dw_2.setitem(i, "rdoc_doc_id", ll_doc_id)
//					//anche causale e magazzino
//					//tab_1.tabpage_2.dw_2.setitem(i, "causale_id", ll_caus_id)
//					//tab_1.tabpage_2.dw_2.setitem(i, "mag_id", ll_mag_id)
//				next
//					//tab_1.tabpage_2.dw_2.object.data[	ll_righe_esistenti+1,28, ll_righe_inserite,28 ]=
//					
//					
//					
//				
				post wf_carica_dddw()
				tab_1.tabpage_2.cbx_in_derivazione.checked=true
				if tab_1.tabpage_2.dw_2.rowcount()<=100 then
					tab_1.tabpage_2.cbx_in_derivazione.trigger event clicked()  //20240229 faccio spazio fra le righe per eventuali duplicazione riga in derivazione
				end if
				tab_1.tabpage_2.dw_2.post scrolltorow(i)
				select az_codice into :ls_codice from dba.azienda;
				if ls_codice='CSL' then
					tab_1.tabpage_2.dw_2.post event ue_update()  //20230601 aggiunto su richiesta di Vittorio che altrimenti scarica 2 volte le stesse righe
				end if
				setredraw(true)
				//messagebox ("E", "FINE DERIVA")
			end if
		end if
	end if
end if
end event

type dw_6 from udw_001 within tabpage_1
integer x = 2592
integer y = 828
integer width = 910
integer height = 668
integer taborder = 20
boolean titlebar = true
string title = "Scadenze"
string dataobject = "d_scadenza_gd"
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;idw_corrente=this
end event

event ue_post_insert;call super::ue_post_insert;long ll_riga_doc, ll_id_doc

ll_riga_doc=tab_1.tabpage_1.dw_1.getrow()

if ll_riga_doc>0 then
	ll_id_doc=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga_doc, "doc_id")
	if ll_id_doc>0 then
		this.setitem(al_riga, "doc_id", ll_id_doc)
		this.setitem(al_riga, "ins_manualmente", 1)
	else
		messagebox("Errore!", "Salvare prima il documento poi inserire le scadenze!")
		deleterow(al_riga)
	end if

else
	messagebox("Errore!", "Manca Documento! Inserire il documento poi la riga!")
	this.trigger event ue_delete(al_riga)
		
end if
end event

type dw_4 from udw_001 within tabpage_1
integer x = 1673
integer y = 1508
integer width = 1838
integer height = 620
integer taborder = 20
string dataobject = "d_sp_doc_gd"
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;idw_corrente=this
end event

event ue_post_insert;call super::ue_post_insert;long ll_riga_doc, ll_id_doc

ll_riga_doc=tab_1.tabpage_1.dw_1.getrow()

if ll_riga_doc>0 then
	ll_id_doc=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga_doc, "doc_id")
	if ll_id_doc>0 then
		this.setitem(al_riga, "doc_id", ll_id_doc)
	else
		messagebox("Errore!", "Salvare prima il documento poi inserire le spese!")
		deleterow(al_riga)
	end if

else
	messagebox("Errore!", "Manca Documento! Inserire il documento poi la riga!")
	this.trigger event ue_delete(al_riga)
		
end if
end event

event updateend;call super::updateend;if rowsdeleted+rowsinserted+rowsupdated>0 then
	post wf_calcola_totale()
end if
end event

type cb_ricerca from uo_cmdbutton_for_tab within tabpage_1
string tag = "apre la finestra di ricerca dei documenti."
integer x = 2587
integer y = 12
integer width = 389
integer taborder = 20
integer textsize = -8
integer weight = 700
string text = "Ricerca"
end type

event clicked;long ll_id, ll_riga, ll_conto, ll_id_guida
string ls_prefisso
s_ricerca s_ric
w_new_ricerca_sw w_ric_sw

s_ric.dataobject='d_doc_sw'
s_ric.titolo_finestra="Ricerca Documento"

if ib_applica_filtro then
	s_ric.filtro[1]=string(dw_1.getitemnumber(1, "doc_num_prog"))
	s_ric.colonna_filtro[1]="doc_num_prog"
	s_ric.filtro[2]=string(dw_1.getitemnumber(1, "guida_id"))
	s_ric.colonna_filtro[2]="guida_id"
	
	s_ric.filtro[3]=string(dw_1.getitemnumber(1, "reg_id"))
	s_ric.colonna_filtro[3]="reg_id"
	ib_applica_filtro=false
end if

openwithparm(w_ric_sw, s_ric)

if isvalid(message) then 
	ll_id=message.doubleparm
	if ll_id>0 then
		ll_riga=dw_1.retrieve(ll_id)
		//resetto cbx_in_derivazione
		tab_1.tabpage_2.cbx_in_derivazione.checked=false
		ll_id_guida=dw_1.getitemnumber(dw_1.getrow(), "guida_id")
		select  pref_conto
		into :ls_prefisso
		from dba.guida
		where guida_id= :ll_id_guida;
		wf_filtra_intestatari(ls_prefisso)
		if ll_riga>0 then
			dw_1.trigger event rowfocuschanged(ll_riga)
			ll_conto=dw_1.getitemnumber(dw_1.getrow(), "doc_conto_id")
			wf_carica_destinazioni(ll_conto)
			wf_carica_banca(ll_conto)
		else
			cb_inserisci.triggerevent(clicked!)
		end if
	end if
end if


end event

type dw_1 from udw_001 within tabpage_1
integer x = 14
integer width = 2533
integer height = 1500
integer taborder = 20
string dataobject = "d_doc_ff"
boolean livescroll = false
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_id_doc, ll_riga_corrente, ll_id_guida
string ls_tipo_doc_ae


ll_riga_corrente=currentrow
if ll_riga_corrente>0 then
	ll_id_doc=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga_corrente, "doc_id")
	
	
	if ll_id_doc>0 then
		ll_id_guida=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga_corrente, "guida_id")
		if ll_id_guida>0 then
			wf_scorporo_iva(ll_id_guida)
			select tipo_documento_ae into :ls_tipo_doc_ae from dba.guida where guida_id=:ll_id_guida;
//			if ls_tipo_doc_ae="TD04" or ls_tipo_doc_ae="TD05" then
//				tab_1.tabpage_2.dw_13.visible=true
//			else
//				tab_1.tabpage_2.dw_13.visible=false
//			end if
		end if
		
		tab_1.tabpage_2.dw_2.retrieve(ll_id_doc)
		tab_1.tabpage_1.dw_3.retrieve(ll_id_doc)
		tab_1.tabpage_1.dw_4.retrieve(ll_id_doc)
		tab_1.tabpage_1.dw_6.retrieve(ll_id_doc)
		wf_aggiorna_titolo(ll_riga_corrente)
	else
		tab_1.tabpage_2.dw_2.reset()
		tab_1.tabpage_1.dw_3.reset()
		tab_1.tabpage_1.dw_4.reset()
		tab_1.tabpage_1.dw_6.reset()
		wf_aggiorna_titolo(0)
		
	end if
else
	tab_1.tabpage_2.dw_2.reset()
	tab_1.tabpage_1.dw_3.reset()
	tab_1.tabpage_1.dw_4.reset()
	wf_aggiorna_titolo(0)
end if

end event

event getfocus;call super::getfocus;idw_corrente=this
//this.modify("datawindow.color = 10789024")
end event

event updateend;call super::updateend;if rowsdeleted+rowsupdated>0 then
//se hanno cambiato l'acconto devo ricalcolare...	
	post wf_calcola_totale()
end if
end event

event ue_post_insert;call super::ue_post_insert;//valori di default
long ll_val_id

select val_id
into :ll_val_id
from dba.val_base;
setitem(al_riga, "val_id", ll_val_id)
end event

event itemchanged;call super::itemchanged;//se cambia la guida riempio i campi che dipendono da essa
//registro, num e data protocollo, num e data documento
long ll_guida_id,  ll_num_prog, ll_num, ll_conto, ll_ana
long ll_id_reg, ll_id_paga, ll_old_paga_id, ll_riga_trovata
integer rtncode, ll_num_registro, li_pos
date ld_data_doc, ld_data_prog, ldt_inizio, ldt_fine, ldt_null
datawindowchild ldwc_dest
string ls_tipo_reg, ls_num_doc, ls_tipo, ls_guida_reg_id, ls_prefisso,ls_tipo_doc_ae, ls_des_registro
long ll_spesa_id

setnull(ldt_null)
choose case string(dwo.name)
	case "guida_id"
		ll_guida_id=long (data)
		
		if ll_guida_id>0 then
			wf_campi_trasporto(ll_guida_id)
			wf_scorporo_iva(ll_guida_id)
			
			select guida_reg_id, pref_conto
			into :ls_guida_reg_id, :ls_prefisso
			from dba.guida
			where guida_id= :ll_guida_id;
			
			wf_filtra_intestatari(ls_prefisso)
			
			if ls_guida_reg_id > " " then
				
				ls_tipo=left(ls_guida_reg_id, 2)
				ll_num_registro=integer(right(ls_guida_reg_id, len(ls_guida_reg_id) - 2))
							
				select reg_id, reg_registro
				into :ll_id_reg, :ls_des_registro
				from dba.registro, dba.esercizio
				where reg_tipo= :ls_tipo
				and reg_numero=:ll_num_registro
				and reg_ese_id = ese_id
				and ese_data_inizio<=today()
				and ese_data_fine>=today();
				
				ls_des_registro=right(ls_des_registro, 2)
				if pos(ls_des_registro, "/")<=0 then
					ls_des_registro=""
				end if
				setitem (row, "reg_id", ll_id_reg)
				
				select max(doc_num_prog)
				into :ll_num_prog
				from dba.doc
				where reg_id = :ll_id_reg;
				if isnull(ll_num_prog) then ll_num_prog=0
				if right(ls_tipo, 1) <> "A" then
				
					select doc_numero
					into :ls_num_doc
					from dba.doc
					where reg_id = :ll_id_reg
					and doc_num_prog=:ll_num_prog;
					if isnull(ls_num_doc) or ls_num_doc="" then ls_num_doc="0"
					
					//controllo se non è numerico il num_doc (da fare)
					li_pos=pos(ls_num_doc, "/")
					if li_pos>0 then
						ls_num_doc=left(ls_num_doc, li_pos - 1)
					end if
										
					ll_num=long(ls_num_doc)
				elseif right(ls_tipo, 1) <> "V" then
				
				end if 
			
				if ll_num_prog >= 0 then
					setitem (row, "doc_num_prog", ll_num_prog+1)
					if right(ls_tipo, 1) <> "A" then
						setitem (row, "doc_numero", string(ll_num + 1)+ls_des_registro)
					else
						setitem (row, "doc_numero", "")	
					end if
//				else
//					setitem (row, "doc_num_prog", 1)
//					if right(ls_tipo, 1) <> "A" then
//						setitem (row, "doc_numero",  string(1))
//					else
//						setitem (row, "doc_numero", "")	
//					end if
				end if
			else
				messagebox("Errore!", "Registro non trovato nella guida!")
			end if
			ld_data_prog = getitemdate(row, "doc_data_prog")
			ld_data_doc =	getitemdate(row, "doc_data")
			if isnull(ld_data_prog) then
				setitem(row, "doc_data_prog", date(today()))
			end if
			if isnull(ld_data_doc) then
				setitem(row, "doc_data", date(today()))
			end if
		else
			messagebox("Attenzione!", "Registro da utilizzare non trovato, controllare GUIDA")
		end if
		select tipo_documento_ae into :ls_tipo_doc_ae from dba.guida where guida_id=:ll_guida_id;
//		if ls_tipo_doc_ae="TD04" or ls_tipo_doc_ae="TD05" then
//			tab_1.tabpage_2.dw_13.visible=true
//		else
//			tab_1.tabpage_2.dw_13.visible=false
//		end if
	//se cambia il conto carico le relative destinazioni (se ci sono)
	CASE "doc_conto_id" , "doc_conto_id_1"
		ll_conto=long(data)
		wf_carica_destinazioni(ll_conto)
		wf_carica_pagamento(ll_conto)
		wf_carica_banca(ll_conto)
		wf_carica_valuta_cambio(ll_conto)
		wf_carica_spese(ll_conto)
	//se cambia il registro ricalcolo il numero prog e doc
	case "reg_id"
		ll_id_reg=long (data)
		select max(doc_num_prog)
		into :ll_num_prog
		from dba.doc
		where reg_id = :ll_id_reg;
		
		select doc_numero, doc_data, doc_data_prog
		into :ls_num_doc, :ld_data_doc, :ld_data_prog
		from dba.doc
		where reg_id = :ll_id_reg
		and doc_num_prog=:ll_num_prog;
		ll_num=long(ls_num_doc)
		if ll_num_prog > 0 then
			setitem (row, "doc_num_prog", ll_num_prog+1)
			setitem (row, "doc_numero", string(ll_num + 1))
			setitem (row, "doc_data", ld_data_doc)
			setitem (row, "doc_data_prog", ld_data_prog)
		else
			setitem (row, "doc_num_prog", 1)
			setitem (row, "doc_numero",  1)
		end if
//		setitem(1, "doc_data_prog", ldt_null)
//		setitem(1, "doc_data", ldt_null)
		post setcolumn("doc_data_prog")
//		ld_data_doc=getitemdate(1, "doc_data")
//		select ese_data_inizio, ese_data_fine
//		into :ldt_inizio, :ldt_fine
//		from dba.registro r, dba.esercizio e
//		where r.reg_id = :ll_id_reg
//		and r.reg_ese_id=e.ese_id;
//		if ld_data_doc>ldt_fine or ld_data_doc<ldt_inizio then
//			messagebox("Attenzione!", "La data non rientra nell'esercizio scelto: cambiare l'esercizio e reinserire la data!")
//			post setcolumn("doc_data")
//			return 2
//		end if				
	case "doc_data"
		ll_id_reg=getitemnumber(row, "reg_id")
		select ese_data_inizio, ese_data_fine
		into :ldt_inizio, :ldt_fine
		from dba.registro r, dba.esercizio e
		where r.reg_id = :ll_id_reg
		and r.reg_ese_id=e.ese_id;
		if date(data)>ldt_fine or date(data)<ldt_inizio then
			messagebox("Attenzione!", "La data non rientra nell'esercizio scelto: cambiare l'esercizio e reinserire la data!")
			post setcolumn("reg_id")
			return 2
			
		end if				
	case "paga_id"
		ll_old_paga_id=getitemnumber(row, "paga_id")
		if ll_old_paga_id>0 then
			select spesa_id
			into :ll_spesa_id
			from dba.pagamento
			where paga_id=:ll_old_paga_id;
			if ll_spesa_id>0 then
				ll_riga_trovata=tab_1.tabpage_1.dw_4.find("spesa_id="+string(ll_spesa_id), 1, tab_1.tabpage_1.dw_4.rowcount())
				if ll_riga_trovata>0 then
					tab_1.tabpage_1.dw_4.deleterow(ll_riga_trovata)
				end if
			end if
		end if
	case "doc_num_prog"
		if long(data)>0 and cbx_ric_num_prog.checked then
			ib_applica_filtro=true
			cb_ricerca.postevent(clicked!)
		end if
end choose
end event

event ue_delete;call super::ue_delete;
//long ll_righe
//integer i, li_ret
//
//ll_righe=tab_1.tabpage_2.dw_2.rowcount()
////20240815 cambio si fa più brutale e soprattutto veloce
////tab_1.tabpage_2.dw_2.rowsmove(1, ll_righe, primary!, tab_1.tabpage_2.dw_2, 1, delete!)
////for i=ll_righe to 1 step -1
////	tab_1.tabpage_2.dw_2.trigger event ue_delete(i)
////	
////next
//li_ret=tab_1.tabpage_2.dw_2.triggerevent("ue_update")
//if li_ret=1 then
//	call super::ue_delete
//else
//	messagebox("Attenzione!", "Cancellazione non salvata!")
//end if
end event

event updatestart;call super::updatestart;//da spostare al più presto sul DB (trigger sul before update o call a una procedura)
//controlla se numerazione è coerente
long ll_num_prog, ll_riga, ll_test, ll_id_reg, ll_num_doc
string ls_num_doc, ls_tipo, ls_test
date ldt_data_doc, ldt_data_prog, ldt_test

ll_riga=getrow()
if ll_riga>0 then
//aggiungo controllo sulla coerenza registro scelto e data documento
	wf_coerenza_reg_documento()
	ll_id_reg=getitemnumber(ll_riga, "reg_id")
	ll_num_prog=getitemnumber(ll_riga, "doc_num_prog")
	ldt_data_prog=getitemdate(ll_riga,"doc_data_prog")
	
	select doc_data_prog, doc_num_prog
	into :ldt_test, :ll_test
	from dba.doc
	where reg_id=:ll_id_reg and
	((doc_num_prog> :ll_num_prog
	and doc_data_prog< :ldt_data_prog)
	or (doc_num_prog< :ll_num_prog
	and doc_data_prog> :ldt_data_prog))
	;
	if ll_test>0 then
		messagebox("Attenzione!", "In questo registro esiste già il documento con data prog = "&
		+string(ldt_test) +" e num. Prog.= "+string(ll_test)+"!~r~n" +&
		"Cambiare N. Prog. o Data Reg.!")
		post setcolumn("doc_num_prog")
		this.post setfocus()
		return 1
	end if
	//controllo coerenza num_doc (solo se è ddt uscita (regitro tipo dv)
	if cbx_cc_num_doc.checked then
		ldt_data_doc=getitemdate(ll_riga,"doc_data")
		ls_num_doc =getitemstring(ll_riga,"doc_numero")
		ll_num_doc=long (ls_num_doc)
		select reg_tipo
		into :ls_tipo
		from registro
		where reg_id=:ll_id_reg;
		if right(ls_tipo, 1) <> "A" then
			select doc_data, doc_numero
			into :ldt_test, :ls_test
			from dba.doc
			where reg_id=:ll_id_reg and
			((cast(doc_numero as integer)> :ll_num_doc
			and doc_data< :ldt_data_doc)
			or (cast(doc_numero as integer)< :ll_num_doc
			and doc_data> :ldt_data_doc))
			;
			if ll_test>0 then
				messagebox("Attenzione!", "In questo registro esiste già il documento con Doc. Data = "&
				+string(ldt_test) +" e N. Doc.= "+string(ls_test)+"!~r~n" +&
				"Cambiare N. Doc. o Doc. Data!")
				post setcolumn("doc_numero")
				this.post setfocus()
				return 1
			end if
		else
			ll_num_prog=getitemnumber(ll_riga, "doc_num_prog")
			select doc_data, doc_numero
			into :ldt_test, :ls_test
			from dba.doc
			where reg_id=:ll_id_reg and
			(doc_numero = :ls_num_doc
			and doc_data= :ldt_data_doc
			and doc_num_prog<> :ll_num_prog)
			;
			if ls_test> " " then
				messagebox("Attenzione!", "In questo registro esiste già il documento con Doc. Data = "&
				+string(ldt_test) +" e N. Doc.= "+ls_test+"!~r~n" +&
				"Controllare!")
			end if
		end if
	end if
end if
end event

event ue_key;call super::ue_key;if keyflags=2 then
	CHOOSE CASE key
		
		CASE KeyN!
		cb_nuovo_doc.triggerevent(clicked!)
	
	END CHOOSE
end if
end event

type dw_3 from udw_001 within tabpage_1
integer x = 14
integer y = 1508
integer width = 1632
integer height = 620
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_civa_gd"
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;idw_corrente=this
end event

event ue_post_insert;call super::ue_post_insert;long ll_riga_doc, ll_id_doc

ll_riga_doc=tab_1.tabpage_1.dw_1.getrow()

if ll_riga_doc>0 then
	ll_id_doc=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga_doc, "doc_id")
	if ll_id_doc>0 then
		this.setitem(al_riga, "doc_id", ll_id_doc)
	else
		messagebox("Errore!", "Manca Documento! Inserire il documento poi la riga!")
		this.trigger event ue_delete(al_riga)
	end if

else
	messagebox("Errore!", "Manca Documento! Inserire il documento poi la riga!")
	this.trigger event ue_delete(al_riga)
		
end if
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4713
integer height = 2152
long backcolor = 79741120
string text = "Righe Documento"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cbx_1 cbx_1
dw_10 dw_10
cbx_calo_cambia_peso cbx_calo_cambia_peso
cbx_in_derivazione cbx_in_derivazione
dw_12 dw_12
dw_9 dw_9
dw_7 dw_7
dw_5 dw_5
dw_8 dw_8
dw_2 dw_2
end type

on tabpage_2.create
this.cbx_1=create cbx_1
this.dw_10=create dw_10
this.cbx_calo_cambia_peso=create cbx_calo_cambia_peso
this.cbx_in_derivazione=create cbx_in_derivazione
this.dw_12=create dw_12
this.dw_9=create dw_9
this.dw_7=create dw_7
this.dw_5=create dw_5
this.dw_8=create dw_8
this.dw_2=create dw_2
this.Control[]={this.cbx_1,&
this.dw_10,&
this.cbx_calo_cambia_peso,&
this.cbx_in_derivazione,&
this.dw_12,&
this.dw_9,&
this.dw_7,&
this.dw_5,&
this.dw_8,&
this.dw_2}
end on

on tabpage_2.destroy
destroy(this.cbx_1)
destroy(this.dw_10)
destroy(this.cbx_calo_cambia_peso)
destroy(this.cbx_in_derivazione)
destroy(this.dw_12)
destroy(this.dw_9)
destroy(this.dw_7)
destroy(this.dw_5)
destroy(this.dw_8)
destroy(this.dw_2)
end on

type cbx_1 from checkbox within tabpage_2
integer x = 3986
integer y = 1040
integer width = 581
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi DDT Collegati"
end type

event clicked;if dw_10.visible=false then
	dw_10.visible=true
else
	dw_10.visible=false
end if
end event

type dw_10 from udw_001 within tabpage_2
boolean visible = false
integer x = 3867
integer y = 28
integer width = 855
integer height = 860
integer taborder = 50
string dataobject = "ds_ddt_collegati"
end type

event ue_post_insert;call super::ue_post_insert;long ll_id_rdoc,ll_riga


ll_riga=dw_2.getrow()
if ll_riga>0 then
	ll_id_rdoc=dw_2.getitemnumber(ll_riga, "rdoc_id")
	if ll_id_rdoc>0 then
		setitem(al_riga, "id_rdoc", ll_id_rdoc)
	else
		messagebox("Attenzione!", "Non hai Salvato le righe!")
	end if
else
	messagebox("Attenzione!", "Non hai selzionato la riga di riferimento!")
end if

end event

type cbx_calo_cambia_peso from checkbox within tabpage_2
integer x = 3739
integer y = 2004
integer width = 247
integer height = 76
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CALO"
end type

type cbx_in_derivazione from checkbox within tabpage_2
integer x = 3433
integer y = 2004
integer width = 270
integer height = 76
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "DERIVA"
end type

event clicked;integer i

//for i= 1 to tab_1.tabpage_2.dw_2.rowcount()
//	tab_1.tabpage_2.dw_2.setitem(i, "rdoc_numero",i*100)
//next

setfocus(tab_1.tabpage_2.dw_2)
end event

type dw_12 from udw_000 within tabpage_2
integer x = 3406
integer y = 1544
integer width = 654
integer height = 364
integer taborder = 50
string dataobject = "d_st_riep_metalli"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_9 from udw_001 within tabpage_2
integer x = 2510
integer y = 912
integer width = 841
integer height = 188
integer taborder = 40
string dataobject = "d_es_articolo"
end type

type dw_7 from datawindow within tabpage_2
integer x = 1573
integer y = 1492
integer width = 891
integer height = 364
integer taborder = 40
string title = "none"
string dataobject = "d_vedi_saldi_partite"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_5 from udw_000 within tabpage_2
event ue_key pbm_dwnkey
integer x = 5
integer y = 896
integer width = 4722
integer height = 1228
integer taborder = 30
string title = ""
string dataobject = "d_rdoc_sh01_tb"
boolean livescroll = false
end type

event ue_key;if keyflags=2 then
	CHOOSE CASE key
		
		CASE KeyS!
			tab_1.tabpage_2.dw_2.trigger event ue_update()
		CASE KeyI!
			tab_1.tabpage_2.dw_2.trigger event ue_insert(getrow())
		CASE  keyadd!
			tab_1.tabpage_2.dw_2.trigger event ue_insert(0)
		CASE KeyD!, keysubtract!
			tab_1.tabpage_2.dw_2.trigger event ue_delete(getrow())
		CASE KeyN!
		cb_nuovo_doc.triggerevent(clicked!)
	END CHOOSE
end if
end event

event itemfocuschanged;call super::itemfocuschanged;if left(string(dwo.name),11) = "rdoc_sconto" then
	ib_nochangerow=true
end if
end event

event rowfocuschanging;call super::rowfocuschanging;GraphicObject which_control
INTEGER I
i=getcolumn()
which_control=getfocus()
if which_control=this and (i = 21 or i = 22) then
	setcolumn("rdoc_descrizione")
	return 1
end if
end event

event losefocus;call super::losefocus;dw_8.modify("datawindow.color = 79741120")
end event

event getfocus;call super::getfocus;dw_8.modify("datawindow.color = 10789024")
idw_corrente=tab_1.tabpage_2.dw_2
end event

event clicked;call super::clicked;integer i
long ll_id_art, ll_vali_id, ll_id_um, ll_id_reg, ll_id_listino, ll_id_sog, ll_id_listino_base
decimal ldc_prezzo
string ls_tipo, ls_tipo_reg, ls_tipo_lis, ls_data
long ll_vali_id_base
date ldt_data

if dwo.name="t_salva_prezzo" then
	

	if messagebox("Attenzione!", "Vuoi davvero salvare i prezzi di questo documento nel listino?", stopsign!, yesno!)=1 then
		//guardo il registro se il documento è di vendita (uscita tipo_registro finisce con "V) o acquisto(finisce con "A")
		ll_id_reg=tab_1.tabpage_1.dw_1.getitemnumber(1, "reg_id")
		select reg_tipo
		into :ls_tipo_reg
		from dba.registro
		where reg_id=:ll_id_reg
		;
		ls_tipo_lis=right(ls_tipo_reg, 1)
		//cerco se l'intestatario del doc ha un listino
		ll_id_sog=tab_1.tabpage_1.dw_1.getitemnumber(1, "doc_conto_id")
		select listino_id
		into :ll_id_listino
		from dba.conto
		where conto_id=:ll_id_sog
		;
		ls_data=string(today(), "yyyy-mm-dd")
		ldt_data=date(ls_data)
		if ll_id_listino>0 then
				
			select vali_id
			into :ll_vali_id
			from dba.validita
			where listino_id= :ll_id_listino
			and vali_da_data<= :ldt_data
			and vali_a_data>=:ldt_data
			;
		end if
		//cerco il listino di base
		select listino_id
		into :ll_id_listino_base
		from dba.listino
		where list_tipo=:ls_tipo_lis
		and base='S'
		;
		if ll_id_listino_base>0 then
			select vali_id
			into :ll_vali_id_base
			from dba.validita
			where listino_id= :ll_id_listino_base
			and vali_da_data<=:ldt_data
			and vali_a_data>=:ldt_data
			;
		end if
		
		for i = 1 to dw_2.rowcount()
			ldc_prezzo=dw_2.getitemdecimal(i, "rdoc_pr_pezzo")
			ll_id_um=dw_2.getitemnumber(i, "um_id")
			ll_id_art=dw_2.getitemnumber(i, "rdoc_art_id")
			select um_tipo
			into :ls_tipo
			from dba.u_misura
			where um_id=:ll_id_um
			;
			if ll_vali_id>0 then
				f_salva_prezzo(ll_vali_id, ll_id_art, ldc_prezzo,ls_tipo)
			end if
			//ora per il listino di base
			f_salva_prezzo(ll_vali_id_base, ll_id_art, ldc_prezzo, ls_tipo)
		 next
	end if
end if
end event

event doubleclicked;call super::doubleclicked;long ll_id_riga

choose case string(dwo.name)
case "rdoc_id_riga_madre" 
	ll_id_riga=getitemnumber(row, "rdoc_id")
	if ll_id_riga>0 then
		openwithparm(w_trova_righe_derivate, ll_id_riga)
	end if
case "partita_oro"
	//openwithparm(w_trova_righe_derivate, ll_id_riga)
end choose
end event

event itemchanged;call super::itemchanged;integer i
long ll_id_art

if dwo.name='iva_id' and row=1 then
	if messagebox("Richiesta!", "Vuoi cambiare l'iva in tutte le righe?", stopsign!, yesno!)=1 then
		for i= 2 to rowcount()
			setitem(i, "iva_id", long(data))
		next
	end if
elseif dwo.name='rdoc_descrizione' then
	//20240815 se è una riga decrittiva (NON HA ARTICOLO) devo metere la qta=0,01 per poterla derivare eventualmente
	ll_id_art=tab_1.tabpage_2.dw_2.getitemnumber(row, "rdoc_art_id")
	if isnull(ll_id_art) then
		setitem(row, "rdoc_qta", 0.01)
	end if
	
end if
end event

type dw_8 from udw_002 within tabpage_2
integer x = 23
integer y = 1148
integer width = 1431
integer height = 112
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_mmart_sog_rdoc"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_2 from udw_001 within tabpage_2
integer x = 5
integer y = 28
integer width = 3845
integer height = 860
integer taborder = 20
string dataobject = "d_rdoc_gd"
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;idw_corrente=this
end event

event ue_post_insert;long ll_id_doc, ll_riga_doc, ll_riga_rdoc
long ll_iva_id, ll_mag_id, ll_caus_id, ll_id_guida, ll_id_conto, ll_num_riga
integer rtncode
datawindowchild ldwc_iva, ldwc_maga, ldwc_causale
decimal ldc_qta_prop

ll_riga_doc=tab_1.tabpage_1.dw_1.getrow()

if ll_riga_doc>0 then
	ll_id_doc=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga_doc, "doc_id")
	if ll_id_doc>0 then
		this.setitem(al_riga, "rdoc_doc_id", ll_id_doc)
		
		ll_id_guida=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga_doc, "guida_id")
		select guida_caus_id, guida_id_magazzino
		into :ll_caus_id, :ll_mag_id
		from dba.guida
		where guida_id=:ll_id_guida
		;
		
		this.setitem(al_riga, "causale_id", ll_caus_id)
		this.setitem(al_riga, "mag_id", ll_mag_id)
		ll_id_conto=tab_1.tabpage_1.dw_1.getitemnumber(ll_riga_doc, "doc_conto_id")
		select iva_id
		into :ll_iva_id
		from dba.conto
		where conto_id=:ll_id_conto
		;
		if isnull(ll_iva_id) then
			select iva_id
			into :ll_iva_id
			from dba.val_base;
		end if
		this.setitem(al_riga, "iva_id", ll_iva_id)
		ll_num_riga=this.getitemnumber(al_riga, "c_max_riga")
		this.setitem(al_riga, "rdoc_numero", ll_num_riga)
		//inserisco, se valorizzata in val_base, la qta proposta
		select qta_riga_doc_proposta
		into :ldc_qta_prop
		from dba.val_base
		;
		if ldc_qta_prop>0 then
			setitem(al_riga, "rdoc_qta", ldc_qta_prop)
		end if
			
	else
		messagebox("Errore!", "Riga senza Documento! Inserire il documento poi la riga!")
		this.trigger event ue_delete(ll_riga_rdoc)
		
	end if
	
	
end if

end event

event rowfocuschanged;call super::rowfocuschanged;long ll_art_id, ll_id_rdoc


ib_nochangerow=FALSE
TAB_1.TABPAGE_2.DW_5.SCROLLTOROW(CURRENTROW)
//TAB_1.TABPAGE_2.DW_13.SCROLLTOROW(CURRENTROW)
if CURRENTROW>0 then
	ll_art_id=TAB_1.TABPAGE_2.DW_2.getitemnumber(CURRENTROW, "rdoc_art_id")
	if ll_art_id>0 then
		wf_allinea_cod_clfo(CURRENTROW, ll_art_id)
		wf_allinea_es_articolo(ll_art_id)		
	end if
	ll_id_rdoc=DW_2.getitemnumber(CURRENTROW, "rdoc_id")
	if isnull(ll_id_rdoc) or ll_id_rdoc<=0 then 
		dw_10.reset()
	else
		dw_10.retrieve(ll_id_rdoc)
	end if
end if
end event

event ue_insert;//inserimento da confermare con update
long ll_riga


if idw_corrente=tab_1.tabpage_2.dw_2 then tab_1.tabpage_2.dw_5.accepttext()
idw_corrente.accepttext()

if cbx_in_derivazione.checked then
	ll_riga=cb_duplica.trigger event clicked()	
	post setcolumn("rdoc_peso")
else
	if al_riga_precedente>0 then al_riga_precedente++
	ll_riga=this.insertrow(al_riga_precedente)
	trigger event ue_post_insert(ll_riga)
end if
post setfocus()
post scrolltorow(ll_riga)
post setcolumn("rdoc_art_id")


return ll_riga
end event

event updateend;call super::updateend;long ll_id_art_sconto_punti, ll_id_doc

//20260809 ib_no_ricalcolo e' true solo durante il salvataggio di servizio fatto
//da wf_gestisci_partita_oro per ottenere rdoc_id: li' il castelletto non va
//ricalcolato. updateend scatta dentro update(), quindi il flag e' ancora alzato.
if rowsdeleted+rowsinserted+rowsupdated>0 and not ib_no_ricalcolo then
	post wf_calcola_totale()
	post wf_calcola_saldo()
	
end if
ll_id_doc=tab_1.tabpage_1.dw_1.getitemnumber(1, "doc_id")
dw_12.retrieve(ll_id_doc)

if il_riga_corrente>0 then post scrolltorow(il_riga_corrente)
if cbx_in_derivazione.checked then post setcolumn("rdoc_peso")
tab_1.tabpage_2.dw_2.setfocus()

end event

event itemchanged;call super::itemchanged;string ls_des, ls_tipo_um, ls_tipo_mov, ls_test
long ll_art_id, ll_id_tit, ll_vali_id, ll_um_id, ll_id_listino,ll_id_cat_codifica
decimal ldc_c_calo, ldc_prezzo, ldc_null, ldc_peso,LDC_QTA,ldc_peso_unitario,ldc_peso_attuale
long ll_id_caus, ll_iva, i, ll_id_tit2
date ldt_data_doc
decimal ldc_aliquota, ldc_imponibile, ldc_tara, ldc_old_tara, ldc_peso_lordo, ldc_old_calo, ldc_calo
string ls_cod_bar_art, ls_tipo


CHOOSE CASE string(dwo.name)
	case "rdoc_art_id", "rdoc_art_id_1"
		select cod_barre_articoli, cat_codifica_articolo
		into :ls_cod_bar_art, :ll_id_cat_codifica
		from dba.val_base;
		if ls_cod_bar_art='S' and len(data)=7 then
			ll_art_id=wf_crea_articolo(data, row, ll_id_cat_codifica)
			if ll_art_id>0 then 	
				data=string(ll_art_id)		
			end if
			//creo l'articolo corrispondente alla bollettina sparata
			//rinfresco la drop dropdown e carico il nuovo articolo
			//mi sposto sulla descrizione
		end if
		ll_art_id= long (data)
		wf_dati_articolo(row, ll_art_id)
		wf_allinea_cod_clfo(row, ll_art_id)
		wf_allinea_es_articolo(ll_art_id)
		wf_metti_des_marco(long(data), row)
		 post wf_allinea_finocalo(row)
	case "um_id"
		ll_um_id=long(data)
		select um_tipo
		into :ls_tipo_um
		from dba.u_misura
		where um_id=:ll_um_id;
		SETITEM(ROW, "um_tipo", ls_tipo_um)
		
		ll_id_caus=getitemnumber(row, "causale_id")
		select caus_c_s
		into :ls_tipo_mov
		from dba.causale
		where caus_id=:ll_id_caus;
		
		if ls_tipo_mov='C' then
			select listino_id_acq
			into :ll_id_listino
			from dba.val_base;
		else
			select listino_id_ven
			into :ll_id_listino
			from dba.val_base;
		end if
		
		ldt_data_doc=tab_1.tabpage_1.dw_1.getitemdate(1, "doc_data")
		select vali_id
		into :ll_vali_id
		from dba.validita
		where listino_id=:ll_id_listino
		and vali_da_data<=:ldt_data_doc
		and vali_a_data>=:ldt_data_doc
		;
		
		ll_art_id=getitemnumber(row, "rdoc_art_id")
		if ll_art_id>0 then
			setnull(ldc_null)
			ldc_prezzo=f_recupera_prezzo(row, ll_art_id, ls_tipo_um, ll_vali_id) 
			if ls_tipo_um='P' then
				setitem(row, "rdoc_pr_pezzo", ldc_null)
				trigger event itemchanged(row, object.rdoc_pr_man, string(ldc_prezzo))
			else
				setitem(row, "rdoc_pr_man", ldc_null)
				trigger event itemchanged(row, object.rdoc_pr_pezzo, string(ldc_prezzo))
				//setitem(row, "rdoc_pr_pezzo", ldc_prezzo)
			end if
		end if
	case "rdoc_peso"
		ll_art_id= getiTemnumber(row, "rdoc_art_id")
		if ll_art_id>0 then
			ldc_peso=dec(data)
			ldc_qta=getitemdecimal(row, "rdoc_qta")
			if ldc_peso>0  and (isnull(ldc_qta) or ldc_qta=0)   then
				select peso
				into :ldc_peso_unitario
				from dba.art
				where art_id= :ll_art_id;
				ldc_qta=getitemdecimal(row, "rdoc_qta")
				if isnull(ldc_qta) then ldc_qta=0
				if ldc_peso_unitario>0 and ldc_qta=0 then
					setitem(row, "rdoc_qta", ldc_peso/ldc_peso_unitario)
				end if
			end if
			ldc_peso=getitemdecimal(row, "rdoc_peso")
		  	post wf_gestisci_partita_oro(data, row, ldc_peso)
		 	post wf_allinea_finocalo(row)
			 if cbx_in_derivazione.checked then
				select attiva_partite
				into :ls_test
				from dba.val_base	;
				if not(ls_test="S") then 
					//post event ue_update()  //20240221 spostato su funzione w_calcola_saldo derivazione
					post setfocus()
			 		post scrolltorow(row)
				end if
			end if
			 
		end if
		
		//  post wf_scarico_automatico(getitemdecimal(row, "rdoc_peso"), dec(data), row)  //20220629 lo commento perché non lo usa nessuno e non so se funziona
	case "rdoc_qta"
		LDC_QTA=dec(data)
		ldc_peso=getitemdecimal(row, "rdoc_peso")
		ll_art_id= getiTemnumber(row, "rdoc_art_id")
		if ll_art_id>0 and (isnull(ldc_peso) or ldc_peso=0) then
			select peso
			into :ldc_peso
			from dba.art
			where art_id= :ll_art_id;
			if ldc_peso>0  then
				setitem(row, "rdoc_peso", ldc_peso*ldc_qta)
			end if
			
		end if
	case "rdoc_pr_pezzo", "rdoc_pr_man",  "rdoc_pr_gr_complessivo", "rdoc_quotazione"
		if is_scorporo_iva='S' then
			ll_iva=getitemnumber(row, "iva_id")
			if ll_iva>0 then
				select iva_aliquota
				into :ldc_aliquota
				from dba.iva
				where iva_id=:ll_iva;
				if ldc_aliquota>0 then
					ldc_imponibile=dec(data)/(1+ldc_aliquota/100)
					post setitem(row, string(dwo.name), ldc_imponibile)
				//	object.rdoc_quotazione[i]= ldc_imponibile
				end if
			end if
		end if
		if dwo.name= "rdoc_quotazione" then
			if isnull(is_scorporo_iva) or is_scorporo_iva <> 'S' then ldc_imponibile=dec(data) 
			//ricopia la quotazione in basso a parità di metallo
			if rowcount()>row then
				if messagebox("Attenzione!", "Si vuol ricopiare la quotazione digitata in tutte le righe sotto?"&
					, stopsign!, yesno!)=1 then
					wf_copia_in_basso(dwo.name, ldc_imponibile, row)
				end if
			end if
		end if
	case "tara"
		ldc_peso=getitemdecimal(row, "rdoc_peso")
		if isnull(ldc_peso) then ldc_peso=0
		ldc_old_tara=getitemdecimal(row, "tara")
		if isnull(ldc_old_tara) then ldc_old_tara=0 
		ldc_tara=dec(data)
		if isnull(ldc_tara) then ldc_tara=0 
		ldc_peso_lordo=ldc_peso+ldc_old_tara
		if ldc_peso - ldc_tara >0 then
			setitem(row, "rdoc_peso",  ldc_peso_lordo - ldc_tara)
			trigger event itemchanged(row, object.rdoc_peso, string (ldc_peso - ldc_tara))
		else
			messagebox("Attenzione!", "Tara maggiore del peso!")
			return 1
		end if
//		post wf_allinea_finocalo(row)  //non serve lo fa già sul peso che richiamo
	case "rdoc_calo"
		if cbx_calo_cambia_peso.checked then
			ldc_peso=getitemdecimal(row, "rdoc_peso")
			ldc_old_calo=getitemdecimal(row, "rdoc_calo")
			ldc_calo=dec(data)
			ldc_peso=ldc_old_calo*ldc_peso/ldc_calo
			setitem(row, "rdoc_peso", ldc_peso)
			trigger event itemchanged(row, object.rdoc_peso, string (ldc_peso))
			ldc_tara=getitemdecimal(row, "tara")
			trigger event itemchanged(row, object.tara, string (ldc_tara))
		end if
		//post wf_allinea_finocalo(row)
	case "n_fili", "n_lacci"
		if string(dwo.name)="n_fili" then 
			ls_tipo="F" 
		else 
			ls_tipo="L" 
		end if
		ldt_data_doc=tab_1.tabpage_1.dw_1.getitemdate(1, "doc_data")
		ldc_peso=f_peso_lacci_fili(ls_tipo, integer(data), ldt_data_doc)
		if ldc_peso>0 then
			ldc_peso_attuale=getitemdecimal(row, "rdoc_peso")
			if ldc_peso_attuale > ldc_peso then
				setitem(row, "rdoc_peso", ldc_peso_attuale - ldc_peso )
				trigger event itemchanged(row, object.rdoc_peso, string (ldc_peso))
			else
				messagebox("Attenzione!", "Filo o laccio maggiore del peso!")
			end if
		end if
//			post wf_allinea_finocalo(row)
			
end choose
end event

event updatestart;call super::updatestart;//20240815 spostato sull'inseremento/modifica peso della riga.... 

//long ll_find, ll_end, I
//string ll_list
////cerco le righe senza articolo (descrittive)
//
//ll_end = dw_2.RowCount() + 1
//ll_find = 1
//ll_find = dw_2.Find("isnull(rdoc_art_id)", ll_find, ll_end)
//DO WHILE ll_find > 0
//       //metto qta=0,01 così si può derivare
//        dw_2.setItem(ll_find,'rdoc_qta', 0.01)
//        // Search again
//        ll_find++
//        ll_find = dw_2.Find("isnull(rdoc_art_id)", ll_find, ll_end)
//LOOP
//for I = 1 to rowcount()
//	wf_allinea_finocalo(i)
//next
//
//

 il_riga_corrente=getrow()


end event

event itemfocuschanged;call super::itemfocuschanged;//string ls_cod_azienda
//
//if string(dwo.name)='rdoc_peso' then
//
//	if getitemdecimal(row, 'rdoc_peso')=0 then
//		trigger event itemchanged(row, dwo, "0")
//	end if
//end if


//if rowcount()=row then
//	if is_ultimo_campo='tara' then 
//		post event ue_insert(0)
//	end if
//	is_ultimo_campo=dwo.name
//end if


end event

event ue_key;
il_riga_corrente=getrow()
call super::ue_key
if keyflags=2 then
	CHOOSE CASE key
		
		CASE KeyN!
		cb_nuovo_doc.triggerevent(clicked!)
	
	END CHOOSE
end if



end event

event rbuttondown;call super::rbuttondown;string ls_coltype, ls_test
decimal ldc_valore
integer i

if dwo.type="column" and string(dwo.name)="rdoc_calo" then
	if messagebox("Attenzione!", "Vuoi riportare il valore cliccato in basso per tutta la colonna "+string(dwo.name)+"?", stopsign!,  yesno!)=1 then
//		ls_test=string(dwo.name)+".ColType"
//		ls_coltype = Describe(ls_test)
//		choose case ls_coltype
//			case "decimal"
				ldc_valore=getitemdecimal(row, string(dwo.name))
	//	end choose
		for i= row+1 to rowcount()
			setitem(i, string(dwo.name),ldc_valore)
		next	
	end if
end if
end event

type internetresult_1 from internetresult within w_doc_ff descriptor "pb_nvo" = "true" 
event create ( )
event destroy ( )
end type

on internetresult_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on internetresult_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

