forward
global type w_lifo_rpt from w_stampa
end type
type cbx_no_righe from checkbox within w_lifo_rpt
end type
type cbx_excel from checkbox within w_lifo_rpt
end type
type dw_2 from udw_stampa within w_lifo_rpt
end type
type st_el_corso from statictext within w_lifo_rpt
end type
end forward

global type w_lifo_rpt from w_stampa
cbx_no_righe cbx_no_righe
cbx_excel cbx_excel
dw_2 dw_2
st_el_corso st_el_corso
end type
global w_lifo_rpt w_lifo_rpt

type variables
string is_sql
end variables

forward prototypes
public subroutine wf_escludi_giacenza_0 ()
end prototypes

public subroutine wf_escludi_giacenza_0 ();dw_1.setfilter("c_giacenza<>0")
dw_1.filter()
dw_1.groupcalc()
end subroutine

on w_lifo_rpt.create
int iCurrent
call super::create
this.cbx_no_righe=create cbx_no_righe
this.cbx_excel=create cbx_excel
this.dw_2=create dw_2
this.st_el_corso=create st_el_corso
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_no_righe
this.Control[iCurrent+2]=this.cbx_excel
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.st_el_corso
end on

on w_lifo_rpt.destroy
call super::destroy
destroy(this.cbx_no_righe)
destroy(this.cbx_excel)
destroy(this.dw_2)
destroy(this.st_el_corso)
end on

event open;call super::open;s_sel_stampa s_stampa
integer i
setredraw(false)
s_stampa=message.powerobjectparm

is_sql= " and art_codice>='"+string(s_stampa.da_articolo)+ "' " 
is_sql += "and art_codice<='"+string(s_stampa.ad_articolo)+ "' " 

if s_stampa.s_id_metallo>0 then
	is_sql += "and metallo.met_id='"+string(s_stampa.s_id_metallo)+ "' " 
end if
if s_stampa.cat_codifica>0 then
	is_sql += "and art.art_id_codifica='"+string(s_stampa.cat_codifica)+ "' " 
end if


for i=1 to 3
	dw_1.settransobject(sqlca)
	dw_1.retrieve(s_stampa.s_data_inizio, s_stampa.s_a_data)
	if s_stampa.s_evasi_no_tutti='S' then
		post wf_escludi_giacenza_0()
		
		
	end if
next
setredraw(true)
end event

event ue_post_open;call super::ue_post_open;//long ll_found, ll_qta, ll_qta_old, i, ll_righe
//string ls_segno, ls_UM_TIPO
//decimal ldc_peso, ldc_peso_old
//
//ll_righe=dw_1.RowCount()
//do 
//	//se ho girato tutte le righe di carico cerco un scarico nuovo
//	if i=ll_found then 
//		i=0
//	end if
//	i++
//	//se è il primo giro raccolgo i dati della vendita
//	if i=1 then 
//		//se la riga trovata nel giro precedente è l'ultima non ci sono più vendite
//		//lo controllo qui perché i carichi comunque li devo scaricare
//		if ll_found=ll_righe then exit
//		ll_found = dw_1.Find("causale_lifo = 'V'", ll_found+1, ll_righe)
//		if ll_found<=1 then exit
//		//prendo la qta  e il peso dello scarico che poi scarico dai carichi precedenti
//		ls_UM_TIPO=dw_1.getitemstring(ll_found, "um_tipo")
//		ldc_peso=dw_1.getitemnumber(ll_found, "cpeso")
//		ll_qta=dw_1.getitemnumber(ll_found, "sqta")
//	end if
//	//controllo che il segno della causale sia giusto (deve essere un carico (+)
//	ls_segno=dw_1.getitemstring(ll_found - i, "causale_lifo")
//	//se non è '+' salto la riga e prendo la precedente
//	if ls_segno<>'A' then continue
//	//recupero la qta e il peso del carico
//	ll_qta_old=dw_1.getitemnumber(ll_found - i, "sqta")
//	ldc_peso_old=dw_1.getitemnumber(ll_found - i, "cpeso")
//	//detraggo la qta e il peso venduta da carico
//	ll_qta_old=ll_qta_old - ll_qta 
//	ldc_peso_old=ldc_peso_old - ldc_peso
//	//se la qta de carico non basta memorizzo il resto su qta e azzero il carico
//	if ls_UM_TIPO='P' then
//		if ldc_peso_old<0 then
//			ldc_peso= -ldc_peso_old
//			dw_1.setitem(ll_found - i, "cpeso", 0)
//			//controllo: se non ci sono altri carichi mi fermo 
//			//(i=ll_found è controllato all'inizio dello script)
//			if ll_found - i <=1 then i=ll_found
//		else
//			//la qta del carico è sufficiente: lo scarico del venduto e passo alla vendita
//			//successiva (i=ll_found)
//			dw_1.setitem(ll_found - i, "cpeso", ldc_peso_old)
//			i=ll_found
//		end if
//	else
//		if ll_qta_old<0 then
//			ll_qta= -ll_qta_old
//			dw_1.setitem(ll_found - i, "sqta", 0)
//			//controllo: se non ci sono altri carichi mi fermo 
//			//(i=ll_found è controllato all'inizio dello script)
//			if ll_found - i <=1 then i=ll_found
//		else
//			//la qta del carico è sufficiente: lo scarico del venduto e passo alla vendita
//			//successiva (i=ll_found)
//			dw_1.setitem(ll_found - i, "sqta", ll_qta_old)
//			i=ll_found
//		end if
//	end if
//loop while ll_found>0 and ll_found<=ll_righe
end event

event ue_postopen;call super::ue_postopen;//long ll_found, ll_qta, ll_qta_old, i, ll_righe
//string ls_segno, ls_UM_TIPO
//decimal ldc_peso, ldc_peso_old
//
//
//st_el_corso.visible=true
//this.enabled=false
//ll_righe=dw_1.RowCount()
//do 
//	//se ho girato tutte le righe di carico cerco un scarico nuovo
//	if i=ll_found then 
//		i=0
//	end if
//	i++
//	//se è il primo giro raccolgo i dati della vendita
//	if i=1 then 
//		//se la riga trovata nel giro precedente è l'ultima non ci sono più vendite
//		//lo controllo qui perché i carichi comunque li devo scaricare
//		if ll_found=ll_righe then exit
//		ll_found = dw_1.Find("causale_lifo = 'V'", ll_found+1, ll_righe)
//		if ll_found<=1 then exit
//		//prendo la qta  e il peso dello scarico che poi scarico dai carichi precedenti
//		ls_UM_TIPO=dw_1.getitemstring(ll_found, "um_tipo")
//		ldc_peso=dw_1.getitemnumber(ll_found, "cpeso")
//		ll_qta=dw_1.getitemnumber(ll_found, "sqta")
//	end if
//	//controllo che il segno della causale sia giusto (deve essere un carico (+)
//	ls_segno=dw_1.getitemstring(ll_found - i, "causale_lifo")
//	//se non è '+' salto la riga e prendo la precedente
//	if ls_segno<>'A' then continue
//	//recupero la qta e il peso del carico
//	ll_qta_old=dw_1.getitemnumber(ll_found - i, "sqta")
//	ldc_peso_old=dw_1.getitemnumber(ll_found - i, "cpeso")
//	//detraggo la qta e il peso venduta da carico
//	ll_qta_old=ll_qta_old - ll_qta 
//	ldc_peso_old=ldc_peso_old - ldc_peso
//	//se la qta de carico non basta memorizzo il resto su qta e azzero il carico
//	if ls_UM_TIPO='P' then
//		if ldc_peso_old<0 then
//			ldc_peso= -ldc_peso_old
//			dw_1.setitem(ll_found - i, "cpeso", 0)
//			//controllo: se non ci sono altri carichi mi fermo 
//			//(i=ll_found è controllato all'inizio dello script)
//			if ll_found - i <=1 then i=ll_found
//		else
//			//la qta del carico è sufficiente: lo scarico del venduto e passo alla vendita
//			//successiva (i=ll_found)
//			dw_1.setitem(ll_found - i, "cpeso", ldc_peso_old)
//			i=ll_found
//		end if
//	else
//		if ll_qta_old<0 then
//			ll_qta= -ll_qta_old
//			dw_1.setitem(ll_found - i, "sqta", 0)
//			//controllo: se non ci sono altri carichi mi fermo 
//			//(i=ll_found è controllato all'inizio dello script)
//			if ll_found - i <=1 then i=ll_found
//		else
//			//la qta del carico è sufficiente: lo scarico del venduto e passo alla vendita
//			//successiva (i=ll_found)
//			dw_1.setitem(ll_found - i, "sqta", ll_qta_old)
//			i=ll_found
//		end if
//	end if
//loop while ll_found>0 and ll_found<=ll_righe
//this.enabled=true
//st_el_corso.visible=false
end event

type pb_1 from w_stampa`pb_1 within w_lifo_rpt
integer x = 2853
end type

type cb_preview from w_stampa`cb_preview within w_lifo_rpt
integer x = 2258
end type

event cb_preview::clicked;setredraw(false)
if dw_2.visible=true then
	if dw_2.object.datawindow.print.preview='no' then
		
		dw_2.object.datawindow.print.preview='yes'
		dw_2.object.datawindow.print.preview.rulers='yes'
	else
		
		dw_2.object.datawindow.print.preview='no'
	//	dw_1.object.datawindow.print.preview.rulers='no'
	end if
else
	Super::EVENT Clicked()
end if
setredraw(true)
end event

type dw_1 from w_stampa`dw_1 within w_lifo_rpt
integer y = 176
integer height = 1380
string title = ""
string dataobject = "d_lifo"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql, ls_sql1, ls_sql2
long ll_pos

if parent.is_sql>" " and sqltype=PreviewSelect! then

	ls_sql=sqlsyntax
	ll_pos=pos(ls_sql, "GROUP BY")
	ls_sql1=left(ls_sql, ll_pos - 1)
	ls_sql2=right(ls_sql, len(ls_sql) - ll_pos +1)
	ls_sql=ls_sql1+" "+parent.is_sql+" "+ls_sql2
	//messagebox("S", ls_sql)
	setsqlpreview(ls_sql)

end if
end event

event dw_1::retrieveend;call super::retrieveend;long ll_found, ll_qta, ll_qta_old, i, ll_righe
string ls_segno, ls_UM_TIPO
decimal ldc_peso, ldc_peso_old


st_el_corso.visible=true
this.enabled=false
ll_righe=rowcount
do 
	//se ho girato tutte le righe di carico cerco un scarico nuovo
	if i=ll_found then 
		i=0
	end if
	i++
	//se è il primo giro raccolgo i dati della vendita
	if i=1 then 
		//se la riga trovata nel giro precedente è l'ultima non ci sono più vendite
		//lo controllo qui perché i carichi comunque li devo scaricare
		if ll_found=ll_righe then exit
		ll_found = dw_1.Find("causale_lifo = 'V'", ll_found+1, ll_righe)
		if ll_found<=1 then exit
		//prendo la qta  e il peso dello scarico che poi scarico dai carichi precedenti
		ls_UM_TIPO=dw_1.getitemstring(ll_found, "um_tipo")
		// azzero la variabile che uso (non si sa mai)
		ldc_peso=0
		ll_qta=0
		ldc_peso=dw_1.getitemnumber(ll_found, "cpeso")
		ll_qta=dw_1.getitemnumber(ll_found, "sqta")
	end if
	//controllo che il segno della causale sia giusto (deve essere un acquisto (A)
	ls_segno=dw_1.getitemstring(ll_found - i, "causale_lifo")
	//se non è 'A' salto la riga e prendo la precedente
	if ls_segno<>'A' then continue
	//recupero la qta e il peso del carico
	//ma prima azzero la variabile che uso (non si sa mai: infatti a Verona altrimenti fa danno!!!)
	ll_qta_old=0
	ldc_peso_old=0
	ll_qta_old=dw_1.getitemnumber(ll_found - i, "sqta")
	ldc_peso_old=dw_1.getitemnumber(ll_found - i, "cpeso")
	//detraggo la qta e il peso venduta da carico
	ll_qta_old=ll_qta_old - ll_qta 
	ldc_peso_old=ldc_peso_old - ldc_peso
	//se la qta de carico non basta memorizzo il resto su qta e azzero il carico
	if ls_UM_TIPO='P' then
		if ldc_peso_old<0 then
			ldc_peso= -ldc_peso_old
			dw_1.setitem(ll_found - i, "cpeso", 0)
			//controllo: se non ci sono altri carichi mi fermo 
			//(i=ll_found è controllato all'inizio dello script)
			if ll_found - i <=1 then i=ll_found
		else
			//la qta del carico è sufficiente: lo scarico del venduto e passo alla vendita
			//successiva (i=ll_found)
			dw_1.setitem(ll_found - i, "cpeso", ldc_peso_old)
			i=ll_found
		end if
	else
		if ll_qta_old<0 then
			ll_qta= -ll_qta_old
			dw_1.setitem(ll_found - i, "sqta", 0)
			//controllo: se non ci sono altri carichi mi fermo 
			//(i=ll_found è controllato all'inizio dello script)
			if ll_found - i <=1 then i=ll_found
		else
			//la qta del carico è sufficiente: lo scarico del venduto e passo alla vendita
			//successiva (i=ll_found)
			dw_1.setitem(ll_found - i, "sqta", ll_qta_old)
			i=ll_found
		end if
	end if
loop while ll_found>0 and ll_found<=ll_righe
groupcalc()
this.enabled=true
st_el_corso.visible=false

end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_lifo_rpt
integer x = 2665
end type

type pb_stampa from w_stampa`pb_stampa within w_lifo_rpt
integer x = 2455
end type

type sle_pg from w_stampa`sle_pg within w_lifo_rpt
integer x = 1806
integer width = 352
end type

type st_1 from w_stampa`st_1 within w_lifo_rpt
integer x = 1522
integer y = 52
integer height = 80
end type

type st_2 from w_stampa`st_2 within w_lifo_rpt
end type

type sle_copie from w_stampa`sle_copie within w_lifo_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_lifo_rpt
end type

type cb_7 from w_stampa`cb_7 within w_lifo_rpt
end type

type cb_6 from w_stampa`cb_6 within w_lifo_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_lifo_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_lifo_rpt
end type

type cb_esci from w_stampa`cb_esci within w_lifo_rpt
integer x = 3081
end type

type cbx_no_righe from checkbox within w_lifo_rpt
integer x = 1074
integer y = 16
integer width = 503
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Dettaglio"
end type

event clicked;if checked then
	dw_1.object.datawindow.detail.height.autosize='yes'
	dw_1.Modify("DataWindow.header.1.Height=76")
else
	dw_1.object.datawindow.detail.height.autosize='no'
	dw_1.Modify("DataWindow.header.1.Height=0")
end if


end event

type cbx_excel from checkbox within w_lifo_rpt
integer x = 1074
integer y = 88
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "St. Sintetica"
end type

event clicked;boolean lb_found
long ll_breakrow, ll_riga_inserita
setredraw(false)
if checked then 
	lb_found = FALSE
	ll_breakrow = 0
	dw_2.reset() //altrimenti se lo premono più volte raddoppia, triplica ....
	DO WHILE NOT (lb_found)
		 ll_breakrow = dw_1.FindGroupChange(ll_breakrow, 1)
		 // If no breaks are found, exit.
		 IF ll_breakrow <= 0 THEN EXIT
			ll_riga_inserita=dw_2.insertrow(0)
		
		dw_2.setitem(ll_riga_inserita, "articolo", dw_1.getitemstring(ll_breakrow,"art_art_codice"))
		dw_2.setitem(ll_riga_inserita, "quantita", dw_1.getitemdecimal(ll_breakrow,"c_giacenza"))
		dw_2.setitem(ll_riga_inserita, "um", dw_1.getitemstring(ll_breakrow,"u_misura_um_codice"))
		dw_2.setitem(ll_riga_inserita, "valore", dw_1.getitemdecimal(ll_breakrow,"c_val_articolo"))
		dw_2.setitem(ll_riga_inserita, "valore_metallo", dw_1.getitemdecimal(ll_breakrow,"c_tot_val_metallo"))
		dw_2.setitem(ll_riga_inserita, "valore_totale", dw_1.getitemdecimal(ll_breakrow,"c_val_totale"))
		dw_2.setitem(ll_riga_inserita, "quotazione_media", dw_1.getitemdecimal(ll_breakrow,"c_quot_media"))
		dw_2.setitem(ll_riga_inserita, "valore_medio", dw_1.getitemdecimal(ll_breakrow,"c_val_medio"))
		
	
		ll_breakrow = ll_breakrow + 1
	LOOP
	dw_1.visible=false
	dw_2.visible=true
	iudw_corrente=dw_2 
	//w_lifo_rpt.triggerevent(resize!)
else 
	iudw_corrente=dw_1
	dw_2.visible=false
	dw_1.visible=true
	//w_lifo_rpt.triggerevent(resize!)
end if
setredraw(true)
end event

type dw_2 from udw_stampa within w_lifo_rpt
boolean visible = false
integer x = 37
integer y = 176
integer width = 3314
integer height = 1400
integer taborder = 28
string dataobject = "d_lifo_excel"
boolean vscrollbar = true
boolean resizable = true
end type

type st_el_corso from statictext within w_lifo_rpt
boolean visible = false
integer x = 846
integer y = 576
integer width = 1787
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
string text = "Attendere! Elaborazione in corso!"
alignment alignment = center!
boolean focusrectangle = false
end type

