forward
global type w_imp_dati_nita from w_base
end type
type dw_7 from udw_001 within w_imp_dati_nita
end type
type dw_6 from udw_001 within w_imp_dati_nita
end type
type dw_5 from udw_001 within w_imp_dati_nita
end type
type dw_4 from udw_001 within w_imp_dati_nita
end type
type dw_3 from udw_001 within w_imp_dati_nita
end type
type dw_2 from udw_001 within w_imp_dati_nita
end type
type dw_1 from udw_001 within w_imp_dati_nita
end type
type cb_reset from commandbutton within w_imp_dati_nita
end type
type cb_importa from commandbutton within w_imp_dati_nita
end type
type cb_carica from commandbutton within w_imp_dati_nita
end type
end forward

global type w_imp_dati_nita from w_base
integer width = 4773
integer height = 3000
dw_7 dw_7
dw_6 dw_6
dw_5 dw_5
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
cb_reset cb_reset
cb_importa cb_importa
cb_carica cb_carica
end type
global w_imp_dati_nita w_imp_dati_nita

forward prototypes
public subroutine wf_cambia_iva ()
public subroutine wf_articolo (long al_id_articolo, long al_riga_doc, long al_id_cat_codifica, long al_id_titolo, decimal adc_coef_calo)
end prototypes

public subroutine wf_cambia_iva ();//long ll_id_tab_iva
//INTEGER I
//
//select id_TAB_IVA
//into :ll_id_tab_iva
//from 
//dba.tab_iva
//where per_aliquota=22 and per_detrazione=100
//;
//if ll_id_tab_iva> 0 then
//	for i= 1 TO DW_2.ROWCOUNT()
//		DW_2.SETITEM(I, "ID_TAB_IVA",ll_id_tab_iva)
//		//DW_2.SETITEM(I, "provv_imp_carea_2", 0)
//	NEXT
//else
//	messagebox("Attenzione!", "IVA NON TROVATA!")
//END IF
//	
end subroutine

public subroutine wf_articolo (long al_id_articolo, long al_riga_doc, long al_id_cat_codifica, long al_id_titolo, decimal adc_coef_calo);string ls_codice, ls_des
long ll_riga_trovata, ll_id_art_locale,  ll_null, ll_id_art_riga, ll_id_art_fornitore
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc

setnull(ll_null)
ll_riga_trovata=dw_4.find("id_articolo="+string(al_id_articolo), 1, dw_4.rowcount())
if ll_riga_trovata>0 then
	ls_codice=dw_4.getitemstring(ll_riga_trovata, "codice")
	ll_id_art_fornitore=dw_4.getitemnumber(ll_riga_trovata, "id_articolo")
	select art_id
	into :ll_id_art_locale
	from dba.art 
	where  art_codice=string(:ll_id_art_fornitore)  // art_codice=:ls_codice or
	;
	if ll_id_art_locale>0 then //l'articolo esiste già non si deve fare nulla , quasi nulla
		dw_2.SetItem(al_riga_doc,"rdoc_art_id", ll_id_art_locale)
		
	else //l'articolo non esiste occorre inserirlo
		dw_7.reset()
		dw_7.insertrow(1)
		dw_7.setitem(1, "art_codice", string(ll_id_art_fornitore))
		ls_des=dw_4.getitemstring(ll_riga_trovata, "descrizione")
		dw_7.setitem(1, "art_descrizione", ls_des)
		dw_7.setitem(1, "art_id_codifica", al_id_cat_codifica)
		dw_7.setitem(1, "usa_in_magazzino", 'S')
		dw_7.setitem(1, "art_tit_preferenziale", al_id_titolo)
		dw_7.setitem(1, "art_calo_preferenziale", adc_coef_calo)
		dw_7.trigger event ue_update()
		ll_id_art_locale=dw_7.getitemnumber(1, "art_id")
		dw_2.SetItem(al_riga_doc,"rdoc_art_id", ll_id_art_locale)
		

			
	end if
else
	messagebox("Attenzione!", "Art. "+ string(al_id_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON PRESENTE NEL FILE ART")
end if


end subroutine

on w_imp_dati_nita.create
int iCurrent
call super::create
this.dw_7=create dw_7
this.dw_6=create dw_6
this.dw_5=create dw_5
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_reset=create cb_reset
this.cb_importa=create cb_importa
this.cb_carica=create cb_carica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_7
this.Control[iCurrent+2]=this.dw_6
this.Control[iCurrent+3]=this.dw_5
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cb_reset
this.Control[iCurrent+9]=this.cb_importa
this.Control[iCurrent+10]=this.cb_carica
end on

on w_imp_dati_nita.destroy
call super::destroy
destroy(this.dw_7)
destroy(this.dw_6)
destroy(this.dw_5)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_reset)
destroy(this.cb_importa)
destroy(this.cb_carica)
end on

event open;call super::open;long ll_id_conto, ll_id_guida, ll_id_cat_codifica

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_7.settransobject(sqlca)

dw_3.insertrow(1)

select id_guida_import, id_conto_import, id_cat_codifica_import
into :ll_id_guida, :ll_id_conto, :ll_id_cat_codifica
from dba.val_base
;
dw_3.setitem(1, "id_guida",ll_id_guida)
dw_3.setitem(1, "id_intestatario",ll_id_conto)
dw_3.setitem(1, "id_cat_codifica",ll_id_cat_codifica)
end event

type dw_7 from udw_001 within w_imp_dati_nita
integer x = 59
integer y = 1052
integer width = 2103
integer height = 612
integer taborder = 30
string title = "articolo"
string dataobject = "d_art_imp"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_6 from udw_001 within w_imp_dati_nita
integer x = 69
integer y = 1964
integer width = 4617
integer height = 384
integer taborder = 10
string title = "doc"
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_5 from udw_001 within w_imp_dati_nita
integer x = 69
integer y = 1680
integer width = 4617
integer height = 244
integer taborder = 10
string title = "doc"
string dataobject = "ds_documento_2016"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_4 from udw_001 within w_imp_dati_nita
integer x = 69
integer y = 2372
integer width = 4617
integer height = 384
integer taborder = 30
string title = "articolo"
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_3 from udw_001 within w_imp_dati_nita
integer x = 2194
integer y = 1064
integer width = 2149
integer height = 220
integer taborder = 30
string title = "Dati"
string dataobject = "d_dati_imp"
end type

type dw_2 from udw_001 within w_imp_dati_nita
integer x = 64
integer y = 360
integer width = 4617
integer height = 668
integer taborder = 10
string title = "riga_doc"
string dataobject = "d_rigadoc_imp"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_1 from udw_001 within w_imp_dati_nita
integer x = 64
integer y = 48
integer width = 4617
integer height = 296
integer taborder = 10
string title = "doc"
string dataobject = "d_doc_imp"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;//
long ll_id_doc

if row>0 then
	ll_id_doc=dw_1.getitemnumber(row, "doc_id")

	if ll_id_doc>0 then
		OpenWithParm(w_doc_ff, ll_id_doc)
	end if
end if
end event

type cb_reset from commandbutton within w_imp_dati_nita
integer x = 3182
integer y = 1300
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "reset"
end type

event clicked;dw_1.reset()
dw_2.reset()
dw_4.reset()
dw_5.reset()
dw_6.reset()
dw_7.reset()
end event

type cb_importa from commandbutton within w_imp_dati_nita
integer x = 2697
integer y = 1304
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importa"
end type

event clicked;long ll_id_guida, ll_id_mag, ll_id_reg_mod, ll_id_locazione, ll_id_causale, ll_id_esercizio, ll_id_reg
date ldt_data_odierna, ldt_data_doc
string ls_tipo_registro, ls_numero, ls_tipo_reg, ls_tipo_num_registro,ls_des, ls_metallo, ls_um, ls_um_tipo
long ll_null, ll_righe, ll_id_art, ll_id_doc,ll_num_prog_esistente, ll_id_sog_intestatario, ll_num_prog,ll_riga_inserita, ll_id_cat_codifica
integer i, li_ret, li_num_registro, li_pos, li_num_pezzi
decimal{2} ldc_peso, ldc_fino, ldc_calo, ldc_coef_calo, ldc_titolo
decimal ldc_prezzo
long ll_id_tit_locale, ll_id_met, ll_id_um, ll_id_bollettina, ll_id_iva, ll_id_valuta, ll_num_bollettina

setnull(ll_null)
ll_id_sog_intestatario=dw_3.getitemnumber(1, "id_intestatario")
if ll_id_sog_intestatario>0 then
	ll_id_guida=dw_3.getitemnumber(1, "id_guida")
	if ll_id_guida>0 then
		select iva_id, a.val_id into :ll_id_iva, :ll_id_valuta from dba.conto c, dba.ana a 
		where conto_id=:ll_id_sog_intestatario
		and a.ana_id=c.ana_id
		;
		if isnull(ll_id_iva) or ll_id_iva=0 then
			select iva_id into :ll_id_iva from dba.val_base;
			if isnull(ll_id_iva) or ll_id_iva=0 then
				messagebox("Attenzione!", "Iva non valorizzata in Valori Base: processo annullato")
				return
			end if
		end if
		//con il profilo trovo magazzino, locazione, causale e registro (modello)
		select guida_reg_id, guida_id_magazzino, guida_caus_id
		into :ls_tipo_num_registro, :ll_id_locazione, :ll_id_causale
		from dba.guida
		where guida_id= :ll_id_guida
		;
		ls_tipo_reg=left(ls_tipo_num_registro, 2)
		li_num_registro=integer(mid(ls_tipo_num_registro, 3, len(ls_tipo_num_registro)))
		//ora trovo il registro attuale (modello registro riportato alla data odierna)
		ldt_data_odierna=date(today())
		select ese_id
		into :ll_id_esercizio
		from dba.esercizio
		where ese_data_inizio<= :ldt_data_odierna
		and ese_data_fine>=:ldt_data_odierna
		;
		SELECT reg_id
		INTO :ll_id_reg  
		FROM "dba"."registro"  
		WHERE ( "registro"."reg_tipo" = :ls_tipo_reg ) AND  
				( "registro"."reg_numero" = :li_num_registro )
				and reg_ese_id=:ll_id_esercizio;
		
		select max(doc_num_prog)
		into :ll_num_prog
		from dba.doc
		where reg_id=:ll_id_reg
		;
		if ll_num_prog>0 then 
			ll_num_prog++
		else
			ll_num_prog=1
		end if	
		
		//poi trovo num_progressivo e data registrazione (data odierna)
	
		//controllo che il documento non esista già
		ls_numero=dw_5.getitemstring(1, "num_documento")
		ldt_data_doc=dw_5.getitemdate(1, "data_documento")
		ll_num_prog_esistente=0
		select doc_num_prog
		into :ll_num_prog_esistente
		from dba.doc
		where reg_id=:ll_id_reg
		and doc_NUMERO=:ls_numero
		and doc_data=:ldt_data_doc
		;
		if ll_num_prog_esistente>0 then
			messagebox("Attenzione!", "Il documento è già stato importato al num. prog.: "+string(ll_num_prog_esistente)+"! Aggiornare le righe?")//, stopsign!, yesno!)=1 then
//				delete from dba.riga_documento
		else
//			dw_5.SetItem(1, "id_sog_commerciale", ll_id_sog_intestatario)
//			dw_5.SetItem(1, "id_sog_commerciale_fattura", ll_id_sog_intestatario)
//			dw_5.SetItem(1, "id_registro", ll_id_reg)
//			dw_5.SetItem(1, "id_prof_documento", ll_id_guida)
//			dw_5.SetItem(1, "num_progressivo",ll_num_prog)
//			dw_5.SetItem(1, "data_registrazione", ldt_data_odierna)
//			dw_5.SetItem(1, "id_caus_magazzino", ll_id_causale)
//			dw_5.SetItem(1, "id_locazione_1", ll_id_locazione)
//			dw_5.SetItem(1, "id_magazzino", ll_id_locazione)
//			dw_5.SetItem(1, "origine", "PDA doc. importato il "+string(datetime(today(),now()) ,"dd/mm/yy hh:mm:ss"))
			//ora copio in sultak
			ll_riga_inserita=dw_1.insertrow(1)
			dw_1.SetItem(ll_riga_inserita, "DOC_CONTO_ID", ll_id_sog_intestatario)
			dw_1.SetItem(ll_riga_inserita, "reg_id", ll_id_reg)
			dw_1.SetItem(ll_riga_inserita, "guida_id", ll_id_guida)
			//inserisco valuta
			dw_1.SetItem(ll_riga_inserita, "val_id", ll_id_valuta)
			dw_1.SetItem(ll_riga_inserita, "doc_num_prog",ll_num_prog)
			dw_1.SetItem(ll_riga_inserita, "doc_data_prog", ldt_data_odierna)
			dw_1.SetItem(ll_riga_inserita, "doc_data", ldt_data_doc)
			dw_1.SetItem(ll_riga_inserita, "doc_numero", ls_numero)
			dw_1.SetItem(ll_riga_inserita, "NOTA", "PDA doc. importato il "+string(datetime(today(),now()) ,"dd/mm/yy hh:mm:ss"))
			//dw_5.SetItem(1, "id_documento", ll_null)
			//dw_5.setitemstatus(1, 0, Primary!, NewModified!)
			li_ret=dw_1.trigger event ue_update()
			ll_id_doc=dw_1.getitemnumber(1, "doc_id")
			//messagebox("Attenzione!", ll_id_doc)
			if ll_id_doc>0 then
				ll_righe=dw_6.rowcount()
				ll_id_cat_codifica=dw_3.getitemnumber(1, "id_CAT_CODIFICA")
				for i= 1 to ll_righe
					ll_riga_inserita=dw_2.insertrow(0)
					dw_2.SetItem(ll_riga_inserita, "rdoc_numero", ll_riga_inserita)
					dw_2.SetItem(ll_riga_inserita, "rdoc_doc_id", ll_id_doc)
					//inserisco l'iva
					dw_2.SetItem(ll_riga_inserita, "iva_id", ll_id_iva)
					dw_2.SetItem(ll_riga_inserita, "chius_forzata", 'N')
					dw_2.SetItem(ll_riga_inserita, "stampa", 'S')
					dw_2.SetItem(ll_riga_inserita, "causale_id", ll_id_causale)
					dw_2.SetItem(ll_riga_inserita, "mag_id", ll_id_locazione)
					dw_2.SetItem(ll_riga_inserita, "rdoc_non_prezioso", 0)
					li_num_pezzi=dw_6.getitemnumber(i, "quantita")
					dw_2.SetItem(ll_riga_inserita, "rdoc_qta", li_num_pezzi)
					ldc_prezzo=dw_6.getitemdecimal(i, "prezzo")
					if isnull(ldc_prezzo) then ldc_prezzo=dw_6.getitemdecimal(i, "prezzo_manifattura")
					ll_id_bollettina=dw_6.getitemdecimal(i, "provv_imp_subage_2")
					dw_2.SetItem(ll_riga_inserita, "id_taglia", ll_id_bollettina)
					ll_num_bollettina=0
					ll_num_bollettina=dw_6.getitemdecimal(i, "provv_imp_carea") //20251104 cambiamo 7 caratteri num_bol intero "1842345"
					if ll_num_bollettina=0 or isnull(ll_num_bollettina) then  //ma se fosse ancora con il vecchio metodo si prova a recuperare lo stesso...
						ll_num_bollettina=dw_6.getitemdecimal(i, "provv_imp_carea_2")
					end if //da inserire 20210830 (è il numero bol che si deve vedere nel DDT e da richiamare con cod_barre in riga doc
					dw_2.SetItem(ll_riga_inserita, "num_bollettina", ll_num_bollettina)
					ls_des=dw_6.getitemstring(i, "descrizione")
					//trovo unita misura
					li_pos=pos(ls_des, ";;")
					ls_um=mid(ls_des, li_pos+2, 2)
					ls_des=left(ls_des, li_pos - 1)
					select um_id, um_tipo
					into :ll_id_um, :ls_um_tipo
					from dba.u_misura
					where upper(um_codice)=upper(:ls_um)
					;
					if ll_id_um > 0 then
						dw_2.SetItem(ll_riga_inserita, "um_id", ll_id_um)
						if ldc_prezzo>0 then
							if ls_um_tipo='N' then
								dw_2.SetItem(ll_riga_inserita, "rdoc_pr_pezzo", ldc_prezzo)
							else
								dw_2.SetItem(ll_riga_inserita, "rdoc_pr_man", ldc_prezzo)
							end if
						end if
					else
						messagebox("Attenzione!", "Unita di misura: "+ls_um+" non trovata!")
					end if
						
					
					li_pos=pos(ls_des, "::")
					ls_metallo=mid(ls_des, li_pos+2, 2)
					ldc_titolo=dec(right(ls_des, len(ls_des) - (li_pos +3)))
					ls_des=left(ls_des, li_pos - 1)
					dw_2.SetItem(ll_riga_inserita, "rdoc_descrizione", ls_des)
					select met_id
					into :ll_id_met
					from dba.metallo
					where met_metallo=:ls_metallo;
					if ll_id_met> 0 then
						select tit_id
						into :ll_id_tit_locale
						from dba.titolo
						where tit_titolo=:ldc_titolo
						and tit_met_ID=:ll_id_met
						;  
						if ll_id_tit_locale>0 then
							dw_2.SetItem(ll_riga_inserita, "tit_id", ll_id_tit_locale)
						else
							messagebox("Attenzione!", "titolo non trovato")
//							select tit_id
//							into :ll_id_tit_locale
//							from dba.titolo
//							where tit_titolo=925
//							and tit_met_ID=:ls_metallo
//							;  
//							dw_2.SetItem(ll_riga_inserita, "tit_id", ll_id_tit_locale) //metto argento 925 sperando vada bene perché tanto l'errore non lo controllano e allora mi devo arrangiare... 20211122
						end if
					else
						messagebox("Attenzione!", "Il metallo "+ls_metallo+" non esiste nella tabella metallo! Titolo NON trovato")		
					end if
					
					ldc_peso=dw_6.getitemdecimal(i, "peso_netto")
					dw_2.SetItem(ll_riga_inserita, "rdoc_peso", ldc_peso)
					
					ldc_fino=dw_6.getitemdecimal(i, "fino")
					ldc_calo=dw_6.getitemdecimal(i, "calo")
					dw_2.SetItem(ll_riga_inserita, "finoecalo", ldc_fino+ldc_calo)
					
					ldc_coef_calo=dw_6.getitemdecimal(i, "coef_calo")
					dw_2.SetItem(ll_riga_inserita, "rdoc_calo", ldc_coef_calo)
					
//					if ldc_peso>0 then 
//						ldc_titolo=ldc_fino/ldc_peso*1000
//					else
//						ldc_titolo=925
//					end if
//					select tit_id
//					into :ll_id_tit_locale
//					from dba.titolo
//					where tit_titolo=:ldc_titolo
//					;
//					if ll_id_tit_locale>0 then
//						dw_2.SetItem(ll_riga_inserita, "tit_id", ll_id_tit_locale)
//					else
//						messagebox("Attenzione!", "titolo non trovato")
//					end if

					ll_id_art=dw_6.getitemnumber(i, "id_articolo")
					wf_articolo(ll_id_art, ll_riga_inserita, ll_id_cat_codifica, ll_id_tit_locale , ldc_coef_calo)

				next
				li_ret=dw_2.trigger event ue_update()		
			else
				messagebox("Attenzione!", "Doc NON salvato!!")
			end if
		end if
	else
		messagebox("Attenzione!", "Inserire il profilo documento!!")
	end if
else
	messagebox("Attenzione!", "Inserire l'intestatario del documento!!")
end if
	
	
	

end event

type cb_carica from commandbutton within w_imp_dati_nita
integer x = 2194
integer y = 1304
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "carica"
end type

event clicked;integer li_ret


string ls_path, ls_file
	
getfileopenname("Cerca DOCasci_", ls_path, ls_file, "txt", "testo, *.txt", "C:\nita\imp_doc")
//if  not(trim(ls_file)="" or isnull(ls_file)) then
//	 tab_1.tabpage_1.dw_prof_documento_gen_ff.setitem(row, "nome_report", ls_path)
//	end if
//end if	 

li_ret=dw_5.importfile(ls_file, 2, 2)
if li_ret=1 then
	ls_file="Riga"+right(ls_file, len(ls_file) -3)
	li_ret=dw_6.importfile(ls_file, 2, 99999)
	ls_file="Art"+right(ls_file, len(ls_file) -4)
	li_ret=dw_4.importfile(ls_file, 2, 99999)
	//ls_file="Uc"+right(ls_file, len(ls_file) -3)
	//li_ret=dw_5.importfile(ls_file, 2, 99999)
end if
//post wf_cambia_iva()
end event

