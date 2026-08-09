forward
global type w_cerca_articoli from w_selezione_ext
end type
type cb_applica from commandbutton within w_cerca_articoli
end type
type cb_inserisci from commandbutton within w_cerca_articoli
end type
type cb_cancella from commandbutton within w_cerca_articoli
end type
type cb_salva from commandbutton within w_cerca_articoli
end type
type dw_2 from udw_001 within w_cerca_articoli
end type
end forward

global type w_cerca_articoli from w_selezione_ext
integer width = 2729
integer height = 2404
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_applica cb_applica
cb_inserisci cb_inserisci
cb_cancella cb_cancella
cb_salva cb_salva
dw_2 dw_2
end type
global w_cerca_articoli w_cerca_articoli

type variables
string is_cond_sql, is_sql_originale
end variables

on w_cerca_articoli.create
int iCurrent
call super::create
this.cb_applica=create cb_applica
this.cb_inserisci=create cb_inserisci
this.cb_cancella=create cb_cancella
this.cb_salva=create cb_salva
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_applica
this.Control[iCurrent+2]=this.cb_inserisci
this.Control[iCurrent+3]=this.cb_cancella
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.dw_2
end on

on w_cerca_articoli.destroy
call super::destroy
destroy(this.cb_applica)
destroy(this.cb_inserisci)
destroy(this.cb_cancella)
destroy(this.cb_salva)
destroy(this.dw_2)
end on

event open;call super::open;DataWindowChild dwc_da_art, dwc_ad_art, dwc_lista, dwc_conto
DataWindowChild dwc_codifica, dwc_titolo
integer rtncode
date ld_data_inizio


rtncode = dw_1.GetChild('id_cat_codifica', dwc_codifica )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('id_titolo', dwc_titolo )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")


rtncode = dw_1.GetChild('da_art', dwc_da_art )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('ad_art', dwc_ad_art )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('id_lista', dwc_lista )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

rtncode = dw_1.GetChild('id_conto', dwc_conto )

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_da_art.SetTransObject(SQLCA)
dwc_ad_art.SetTransObject(SQLCA)
dwc_lista.SetTransObject(SQLCA)
dwc_conto.SetTransObject(SQLCA)
dwc_titolo.SetTransObject(SQLCA)
dwc_codifica.SetTransObject(SQLCA)

// Populate with values for eastern states
dwc_da_art.Retrieve()
dwc_ad_art.Retrieve()
dwc_lista.Retrieve()
dwc_conto.Retrieve()
dwc_titolo.Retrieve()
dwc_codifica.Retrieve()


dw_2.settransobject(sqlca)


end event

event ue_postopen;call super::ue_postopen;is_cond_sql=dw_2.getsqlselect()
 is_sql_originale=dw_2.getsqlselect()
end event

type cb_1 from w_selezione_ext`cb_1 within w_cerca_articoli
integer x = 82
integer y = 2108
end type

event cb_1::clicked;call super::clicked;close(parent)
end event

type cb_ok from w_selezione_ext`cb_ok within w_cerca_articoli
string tag = "Chiude riportando gli articoli nella finestra chiamante"
integer y = 2108
string text = "Riporta"
end type

event cb_ok::clicked;call super::clicked;s_dw_risultati s_risultati
integer li_ret


s_risultati.ds=create datastore

s_risultati.ds.dataobject=dw_2.dataobject
li_ret=dw_2.rowscopy(1, dw_2.rowcount(), primary!, s_risultati.ds, 1, primary!)

closewithreturn(parent, s_risultati)



//s_dw_ritorna st_p
//integer li_ret
//
//if dw_2.rowcount()<=0 then
//	messagebox("Attenzione!", "Non esistono articoli da riportare!")
//	return
//end if
//st_p.ds=create datastore
//st_p.ds.dataobject=dw_2.dataobject
//li_ret=dw_2.rowscopy(1, dw_2.rowcount(), primary!, st_p.ds, 1, primary!)
//closewithreturn(parent, st_p)
end event

type dw_1 from w_selezione_ext`dw_1 within w_cerca_articoli
integer x = 50
integer y = 36
integer width = 2606
string dataobject = "d_scegli_articoli"
end type

type cb_applica from commandbutton within w_cerca_articoli
integer x = 69
integer y = 832
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Applica Filtri"
end type

event clicked;long ll_id_lista, ll_id_cat_codifica, ll_id_titolo
string ls_and, ls_sql, ls_da_art, ls_ad_art, ls_appoggio, ls_da, ls_a, ls_misura
decimal ldc_da_peso, ldc_a_peso, ldc_misura

dw_1.accepttext()

is_cond_sql=is_sql_originale

ls_da_art=dw_1.getitemstring(1, "da_art")
ls_ad_art=dw_1.getitemstring(1, "ad_art")
ldc_da_peso=dw_1.getitemdecimal(1, "da_peso")
ldc_a_peso=dw_1.getitemdecimal(1, "a_peso")
ldc_misura=dw_1.getitemdecimal(1, "misura")
ll_id_cat_codifica=dw_1.getitemnumber(1, "id_cat_codifica")
ll_id_titolo=dw_1.getitemnumber(1, "id_titolo")

if ls_da_art> "" then
	if pos(is_cond_sql, "where") > 0 then
		ls_and=" and "
	else
		ls_and=" where "
	end if
	ls_appoggio+=ls_and+" art_codice >= '"+ls_da_art+"' "
	is_cond_sql+=ls_appoggio
	ls_appoggio=""
end if

if ls_ad_art> "" then
	if pos(is_cond_sql, "where") > 0 then
		ls_and=" and "
	else
		ls_and=" where "
	end if
	ls_appoggio+=ls_and+" art_codice <= '"+ls_ad_art+"' "
	is_cond_sql+=ls_appoggio
	ls_appoggio=""
end if
	

if ldc_da_peso> 0 then
	ls_da=f_cambia_virgola_in_punto(string(ldc_da_peso))
	if pos(is_cond_sql, "where") > 0 then
		ls_and=" and "
	else
		ls_and=" where "
	end if
	ls_appoggio+=ls_and+" peso >= "+ls_da
	is_cond_sql+=ls_appoggio
	ls_appoggio=""
end if

if ldc_a_peso> 0 then
	ls_a=f_cambia_virgola_in_punto(string(ldc_a_peso))
	if pos(is_cond_sql, "where") > 0 then
		ls_and=" and "
	else
		ls_and=" where "
	end if
	ls_appoggio+=ls_and+" peso <= "+ls_a
	is_cond_sql+=ls_appoggio
	ls_appoggio=""
end if

if ldc_misura> 0 then
	ls_misura=f_cambia_virgola_in_punto(string(ldc_misura))
	if pos(is_cond_sql, "where") > 0 then
		ls_and=" and "
	else
		ls_and=" where "
	end if
	ls_appoggio+=ls_and+" misura = "+ls_misura
	is_cond_sql+=ls_appoggio
	ls_appoggio=""
end if


if ll_id_cat_codifica>0 then
	if pos(is_cond_sql, "where") >0 then
		ls_and=" and "
	else
		ls_appoggio=" where "
	end if
	ls_appoggio+=ls_and+" id_cat_codifica = "+string(ll_id_cat_codifica)
	is_cond_sql+=ls_appoggio
	ls_appoggio=""
end if

if ll_id_titolo>0 then
	if pos(is_cond_sql, "where") >0 then
		ls_and=" and "
	else
		ls_appoggio=" where "
	end if
	ls_appoggio+=ls_and+" art_tit_preferenziale = "+string(ll_id_titolo)
	is_cond_sql+=ls_appoggio
	ls_appoggio=""
end if

ll_id_lista=dw_1.getitemnumber(1, "id_lista")
if ll_id_lista>0 then
	is_cond_sql+=", lista_art_figlio "
	if pos(is_cond_sql, "where") >0 then
		ls_and=" and "
	else
		ls_appoggio=" where "
	end if

	ls_appoggio+=ls_and+" (lista_art_figlio.lista_art_id = "+string(ll_id_lista)+&
									" and lista_art_figlio.art_id= art.art_id "+") "
	is_cond_sql+=ls_appoggio
	ls_appoggio=""
end if

dw_2.retrieve()

//
//is_cond_sql=""
//
//ll_id_var=dw_1.getitemnumber(1, "variazione")
//if ll_id_var>0 then
//	is_cond_sql=", unita_confezione, prezzo "
//	ls_appoggio=" where articolo.id_articolo=unita_confezione.id_articolo "+&
//					" and unita_confezione.unita_base='S' "+&
//					"and unita_confezione.id_unita_confezione=prezzo.id_unita_confezione"
//	ls_appoggio+= " and prezzo.id_variazione="+string(ll_id_var)
//else
//	ls_appoggio= " where "
//end if
//
//ll_id_lista=dw_1.getitemnumber(1, "id_lista")
//if ll_id_lista>0 then
//	is_cond_sql+=", lista_art_key "
//	if ls_appoggio=" where " then 
//		ls_and=""
//	else
//		ls_and=" and "
//	end if
//	ls_appoggio+=ls_and+" (articolo.id_articolo= lista_art_key.id_articolo "+&
//									" and lista_art_key.id_lista_articoli= "+string(ll_id_lista)+") "
//	
//end if
//
//	
//	
//ll_righe=dw_3.rowcount()
//for i=1 to ll_righe
//	ll_id_classe=dw_3.getitemnumber(i, "id_classe")
//	
//	is_cond_sql+=", CLASSE_ARTICOLO AS CL_ART_"+STRING(i)+" "
//
//	
//	
//	if ls_appoggio=" where " then 
//		ls_and=""
//	else
//		ls_and=" and "
//	end if
//	ls_appoggio+=ls_and+" CL_ART_"+STRING(i)+".ID_ARTICOLO=ARTICOLO.ID_ARTICOLO "+&
//		 " AND CL_ART_"+STRING(i)+".ID_CLASSE="+STRING(ll_id_classe)+" "
//	
//next 
//
//	
//ls_da=dw_1.getitemstring(1, "da_articolo")
//if ls_da>"" then
//	if ls_appoggio=" where " then 
//		ls_and=""
//	else
//		ls_and=" and "
//	end if
//	
//	ls_a=dw_1.getitemstring(1, "a_articolo")
//	if ls_a>"" then 
//		ls_appoggio+=ls_and+" (articolo.codice >= '"+ls_da+ "' and articolo.codice <= '"+ls_a+"')"
//	else	
//		ls_appoggio+=ls_and+" (articolo.codice >= '"+ls_da+"')"
//	end if
//end if
//
//ll_id_tit=dw_1.getitemnumber(1, "da_titolo")
//if ll_id_tit>0 then
//	if ls_appoggio=" where " then 
//		ls_and=""
//	else
//		ls_and=" and "
//	end if
//	ls_appoggio+=ls_and+" (articolo.id_titolo = "+string(ll_id_tit)+")"
//	
//end if
////aggiunta
//ldt_data_ult_cambiamento=dw_1.getitemdatetime(1, "data_ora_ult_cambiamento")
//if ldt_data_ult_cambiamento > datetime("1900/01/01 23.59.00") then
//	if ls_appoggio=" where " then 
//		ls_and=""
//	else
//		ls_and=" and "
//	end if
//	ls_appoggio+=ls_and+" (articolo.data_ora_ult_cambiamento <= datetime('"+string(ldt_data_ult_cambiamento, "yyyy/mm/dd hh:mm:ss")+"'))"
//end if
//ldt_data_ult_cambiamento2=dw_1.getitemdatetime(1, "data_ora_ult_cambiamento2")
//if ldt_data_ult_cambiamento2 > datetime("1900/01/01 23.59.00") then
//	if ls_appoggio=" where " then 
//		ls_and=""
//	else
//		ls_and=" and "
//	end if
//	ls_appoggio+=ls_and+" (articolo.data_ora_ult_cambiamento >= datetime('"+string(ldt_data_ult_cambiamento2, "yyyy/mm/dd hh:mm:ss")+"'))"
//end if
//
//ll_id_cat_cod=dw_1.getitemnumber(1, "id_cat_codifica")
//if ll_id_cat_cod>0 then
//	if ls_appoggio=" where " then 
//		ls_and=""
//	else
//		ls_and=" and "
//	end if
//	ls_appoggio+=ls_and+" (articolo.id_cat_codifica = "+string(ll_id_cat_cod)+")"
//end if
//
//
//LS_LIKE=dw_1.getitemSTRING(1, "LIKE")
//IF ls_like> "" then
//	if ls_appoggio=" where " then 
//		ls_and=""
//	else
//		ls_and=" and "
//	end if
//	ls_appoggio+=ls_and+" "+ls_like+ " "	
//end if
//
//ls_campo[9]="cat_com_articolo.codice"
//ls_campo[11]="cat_merceologica.codice"
//ls_campo[13]="cat_fiscale.codice"
//ls_campo[15]="gruppo_articoli.codice"
//
//
//
//for i= 9 to 16 step 2
//	ls_da=dw_1.getitemstring(1, i)
//	ls_a=dw_1.getitemstring(1, i+1)
//	if ls_da>"" then
//		ls_campo[i+1]= left(ls_campo[i], pos(ls_campo[i], ".") - 1)
//		is_cond_sql+=", "+ls_campo[i+1]
//		if ls_appoggio=" where " then 
//			ls_and=""
//		else
//			ls_and=" and "
//		end if
//		if ls_a>"" then 
//			ls_appoggio+=ls_and+" ("+ ls_campo[i]+" >= '"+ls_da+ "' and "+ls_campo[i]+" <= '"+ls_a+"')"
//		else	
//			ls_appoggio+=ls_and+" ("+ ls_campo[i]+" >= '"+ls_da+ "')"
//		end if
//		ls_appoggio+=" and  (articolo.id_"+ls_campo[i+1]+" = "+ls_campo[i+1]+".id_"+ls_campo[i+1]+")"
//	end if
//next
//ls_da=string(dw_1.getitemnumber(1, "da_fornitore"))
//if ls_da>"" then
//	if 	ls_appoggio=" where " then 
//		ls_and=""
//	else
//		ls_and=" and "
//	end if
//	ls_appoggio+=ls_and+" (articolo.id_sog_commerciale = "+ls_da+ ")"
//end if
//ls_da=string(dw_1.getitemdecimal(1, "da_peso"))
//ls_a=string(dw_1.getitemdecimal(1, "a_peso"))
//if ls_da>"" then
//	ls_da=f_cambia_virgola_in_punto(ls_da)
//	if 	ls_appoggio=" where " then 
//		ls_and=""
//	else
//		ls_and=" and "
//	end if
//	if pos(is_cond_sql, "unita_confezione") <= 0 then
//		is_cond_sql+=", unita_confezione "
//		ls_appoggio+=ls_and+" (articolo.id_articolo = unita_confezione.id_articolo)"
//		ls_and=" and "
//	end if
//	if ls_a>"" then
//		ls_a=f_cambia_virgola_in_punto(ls_a)
//		ls_appoggio+=ls_and+" (unita_confezione.peso_netto>="+ls_da+" and " +&
//						"unita_confezione.peso_netto<="+ls_a+")"
//	else
//		ls_appoggio+=ls_and+" (unita_confezione.peso_netto>="+ls_da+")"
//	end if
//end if
//ls_da=string(dw_1.getitemdecimal(1, "da_prezzo"))
//ls_a=string(dw_1.getitemdecimal(1, "a_prezzo"))
//if ls_da>"" then
//	ls_da=f_cambia_virgola_in_punto(ls_da)
//	if 	ls_appoggio=" where " then 
//		ls_and=""
//	else
//		ls_and=" and "
//	end if
//	if pos(is_cond_sql, "unita_confezione") <= 0 then
//		is_cond_sql+=", unita_confezione "
//		ls_appoggio+=ls_and+" (articolo.id_articolo = unita_confezione.id_articolo)"
//		ls_and=" and "
//	end if
//	if pos(is_cond_sql,"prezzo")<=0 then
//		is_cond_sql+=", prezzo "
//		ls_appoggio+=ls_and+" (unita_confezione.id_unita_confezione=prezzo.id_unita_confezione)"+&
//						 " and (prezzo.id_variazione="+string(ll_id_var)+")"		
//		ls_and=" and "
//	end if
//	
//	if ls_a>"" then
//		ls_a=f_cambia_virgola_in_punto(ls_a)
//		ls_appoggio+=ls_and+" (prezzo.prezzo_manifattura>="+ls_da+" and " +&
//						"prezzo.prezzo_manifattura<="+ls_a+")"
//	else
//		ls_appoggio+=ls_and+" (prezzo.prezzo_manifattura>="+ls_da+")"
//	end if
//end if
//ll_righe=dw_5.rowcount()
//if ll_righe>0 then
//	if ls_appoggio=" where " then 
//		ls_and=""
//	else
//		ls_and=" and "
//	end if
//	is_cond_sql+=", distinta "
//	ls_appoggio+=ls_and+ " articolo.id_articolo=distinta.id_articolo "
//	for i=1 to ll_righe
//		
//		ll_id_art=dw_5.getitemnumber(i, "id_articolo")
//		is_cond_sql+=", riga_distinta as riga_dis_"+string(i)
//		ls_appoggio+= " and distinta.id_distinta=riga_dis_"+string(i)+".id_distinta"+&
//						" and riga_dis_"+string(i)+".id_articolo="+string(ll_id_art)
//	next
//end if
//
//if ls_appoggio=" where " then ls_appoggio=""
//is_cond_sql+=ls_appoggio
//
//
end event

type cb_inserisci from commandbutton within w_cerca_articoli
integer x = 1513
integer y = 1000
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;long ll_riga
ll_riga=dw_2.trigger event ue_insert(0)
end event

type cb_cancella from commandbutton within w_cerca_articoli
integer x = 1513
integer y = 1156
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
ll_riga_da_cancellare=dw_1.getrow()
dw_2.trigger event ue_delete(ll_riga_da_cancellare)	
end event

type cb_salva from commandbutton within w_cerca_articoli
integer x = 1513
integer y = 1312
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;//dw_1.trigger event ue_update()
end event

type dw_2 from udw_001 within w_cerca_articoli
integer x = 59
integer y = 984
integer width = 1435
integer height = 1108
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_codart_dddw"
end type

