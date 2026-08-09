forward
global type w_cat_st from w_semplice_cx
end type
type dw_2 from udw_000 within w_cat_st
end type
type dw_3 from udw_000 within w_cat_st
end type
type cb_scegli from commandbutton within w_cat_st
end type
type cb_dw from commandbutton within w_cat_st
end type
type cb_st_dw_1 from commandbutton within w_cat_st
end type
type cb_cat from commandbutton within w_cat_st
end type
type p_1 from picture within w_cat_st
end type
end forward

global type w_cat_st from w_semplice_cx
integer width = 5266
integer height = 1872
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_2 dw_2
dw_3 dw_3
cb_scegli cb_scegli
cb_dw cb_dw
cb_st_dw_1 cb_st_dw_1
cb_cat cb_cat
p_1 p_1
end type
global w_cat_st w_cat_st

type variables
long al_lista_id
string as_path
end variables

forward prototypes
public subroutine wf_filtra (string as_id, string as_tipo)
public subroutine wf_carica_immagini (integer ai_flag)
public function integer wf_trova_ris_jpg (string as_nomefile)
end prototypes

public subroutine wf_filtra (string as_id, string as_tipo);string ls_filtro

if as_tipo='C' then
	if isnull(as_id) then 
		ls_filtro=""
	else
		ls_filtro="conto_id="+as_id
	end if
	dw_1.setfilter(ls_filtro)
	dw_1.filter()
elseif as_tipo="L" then
	if isnull(as_id) then 
		dw_1.retrieve(0)
	else
		dw_1.retrieve(as_id)
	END IF
end if

end subroutine

public subroutine wf_carica_immagini (integer ai_flag);integer i, li_h, li_w, li_w_max
decimal ldc_dim_rapporto 
string ls_imm, modstring, ls_visible, ls_nome
string ls_ret

if ai_flag=2 then
	SETREDRAW(FALSE)
	select h_max_preview, w_max_preview
	into :li_h, :li_w_max
	from val_base;
	if isnull(li_h) or li_h<=0 then li_h=300
	
	
	for i= 1 to dw_1.rowcount()
		ls_imm=dw_1.getitemstring(i, "cat_art_foto")
		if ls_imm>"" then
			if pos(ls_imm, "\") <=0 then ls_imm=as_path+"\"+ls_imm
				p_1.picturename=ls_imm
				ldc_dim_rapporto=p_1.width/p_1.height
				li_w=ldc_dim_rapporto*li_h
				if li_w>li_w_max then
					li_w=li_w_max
					li_h=1/ldc_dim_rapporto*li_w
				end if		
				ls_visible='"1~tif(getrow()='+string(i)+', 1, 0)"'	
				//inserire ciclo per determinare la x della  bitmap 
				//se l'utente avesse allargato qualche campo ... il 3330 di ora andrà ad essere dinamico // 121011: provo 4480
				modstring = 'create bitmap(band=detail x="4480" y="10"'+&
							' height="'+string(li_h)+'" width="'+ string(li_w)+'" '+&
							'filename="'+ls_imm+'" border="1"  name=p_'+string(i)+ &
							' visible='+ls_visible+&
							' resizeable=1  moveable=1  )'
			
				
			ls_ret=dw_1.Modify(modstring)
			if ls_ret<>"" then 
				messagebox("ERRORE!", ls_ret)
			end if
		end if
	next
else
	for i= 1 to dw_1.rowcount()
		modstring="destroy p_"+string(i)
		dw_1.modify(modstring)
	next
end if
dw_1.modify("datawindow.detail.height.autosize=yes")
SETREDRAW(TRUE)
//dw_cust.Modify("destroy logo")

end subroutine

public function integer wf_trova_ris_jpg (string as_nomefile);//
integer li_FileNum
string ls_Emp_Input
integer li_res, li_res1, li_res2

li_FileNum = FileOpen(as_nomefile, streamMode!, read!, LockWrite!, Replace!)
FileSeek(li_FileNum, 15, FromBeginning!)
FileRead(li_FileNum, ls_Emp_Input)
li_res1=asc(left(ls_Emp_Input, 1))
FileSeek(li_FileNum, 16, FromBeginning!)
FileRead(li_FileNum, ls_Emp_Input)
li_res2=asc(ls_Emp_Input)
li_res2*=256
li_res=li_res1 + li_res2
fileclose(li_FileNum)
return li_res
end function

event resize;call super::resize;
CONSTANT INTEGER ci_spazio_y=224

dw_1.width=newwidth - 105
dw_1.height=newheight - 292 - 450
dw_2.y=dw_1.y+dw_1.height + 20
dw_2.x= dw_1.x 
dw_3.y=dw_2.y+dw_2.height + 20
dw_3.x=dw_1.x 

cb_cat.y=newheight -ci_spazio_y
cb_cat.x= cb_ricerca.x 

cb_scegli.x=cb_inserisci.x + 918
cb_scegli.y=cb_inserisci.y

cb_dw.y=newheight - ci_spazio_y
cb_dw.x= cb_ANNULLA.x - cb_dw.width - 50

cb_st_dw_1.y=newheight - ci_spazio_y
cb_st_dw_1.x=cb_dw.x - cb_st_dw_1.width - 50
end event

on w_cat_st.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_scegli=create cb_scegli
this.cb_dw=create cb_dw
this.cb_st_dw_1=create cb_st_dw_1
this.cb_cat=create cb_cat
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_scegli
this.Control[iCurrent+4]=this.cb_dw
this.Control[iCurrent+5]=this.cb_st_dw_1
this.Control[iCurrent+6]=this.cb_cat
this.Control[iCurrent+7]=this.p_1
end on

on w_cat_st.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_scegli)
destroy(this.cb_dw)
destroy(this.cb_st_dw_1)
destroy(this.cb_cat)
destroy(this.p_1)
end on

event open;call super::open;integer li_MAX_width, li_MAX_height, li_x, li_y
string mod_string

dw_2.settransobject(sqlca)
dw_2.insertrow(1)
dw_3.settransobject(sqlca)
dw_3.insertrow(1)
//dw_4.settransobject(sqlca)
//dw_4.insertrow(1)

dw_3.setitem(1, "cat_imp", "Obbligatorio")

dw_2.setitem(1, "dw", "d_composite_col_1")

select L_max_foto, h_max_foto, x_foto, y_foto
into :li_MAX_width, :li_MAX_height, :li_x, :li_y
from dba.val_base
;
dw_2.setitem(1, "h_max", li_MAX_height)
dw_2.setitem(1, "w_max", li_MAX_width)
dw_2.setitem(1, "x_1", li_x)
dw_2.setitem(1, "y_1", li_y)
dw_2.setitem(1, "dw","d_cat_ff_1")

select dir_foto 
into :as_path
from val_base
;







end event

type cb_stampa from w_semplice_cx`cb_stampa within w_cat_st
boolean visible = false
integer x = 2414
integer y = 980
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_cat_st
boolean visible = false
end type

type cb_primo from w_semplice_cx`cb_primo within w_cat_st
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_cat_st
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_cat_st
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_cat_st
end type

type dw_1 from w_semplice_cx`dw_1 within w_cat_st
integer width = 5161
string title = ""
string dataobject = "d_riga_catalogo_gd"
end type

event dw_1::ue_post_insert;call super::ue_post_insert;long ll_id_catalogo
integer i
string ls_catalogo

if al_riga>1 then
	ll_id_catalogo=getitemnumber(al_riga - 1, "id_catalogo")
	if isnull(ll_id_catalogo) or ll_id_catalogo=0 then
		open(w_nome_catalogo_pop)
		ll_id_catalogo=message.doubleparm
	end if
else
	open(w_nome_catalogo_pop)
	ll_id_catalogo=message.doubleparm
end if
setitem(al_riga, "id_catalogo", ll_id_catalogo)

if getitemnumber(1, "c_somma_id") <> ll_id_catalogo*rowcount() then
	for i= 1 to rowcount()
		setitem(i, "id_catalogo", ll_id_catalogo)
	next
end if

	
end event

event dw_1::itemchanged;call super::itemchanged;long ll_id_art
string ls_des_art, ls_foto
decimal ldc_peso, ldc_misura


choose case string(dwo.name)
	//QUANDO SI CARICA L'ARTICOLO OCCORRE CARICARE NELL CAMPO OPPURTUNO L'ID_ART
	case "cat_art_codice"
		select art_id, art_descrizione, peso, misura
		into :ll_id_art, :ls_des_art, :ldc_peso, :ldc_misura
		from dba.art
		where art_codice=:data;
		if ll_id_art>0 then
			setitem(row, "cat_art_id", ll_id_art)
			//e occorre caricare anche gli attributi dell'articolo
			setitem(row, "cat_art_descrizione", ls_des_art)
			setitem(row, "cat_art_peso", ldc_peso)
			setitem(row, "cat_art_misura", ldc_misura)
			select  art_foto
			into :ls_foto
			from dba.art_foto
			where art_id=:ll_id_art
			and conto_id=0
			;
			setitem(row, "cat_art_foto", ls_foto)
		end if
end choose
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;string ls_imm
integer li_vedi_foto
setrowfocusindicator(hand!)

if currentrow>0 then
	ls_imm=getitemstring(currentrow, "cat_art_foto")
	if dw_2.getrow()>0 then
		li_vedi_foto=dw_2.getitemnumber(1, "vedi_foto")
		if ls_imm>"" and li_vedi_foto=1 then
			if isvalid(w_mostra_immagine) then
				w_mostra_immagine.wf_mostra(ls_imm)
			else
				openwithparm(w_mostra_immagine, ls_imm, parent)
			end if
		end if
	end if
end if
end event

type cb_inserisci from w_semplice_cx`cb_inserisci within w_cat_st
end type

type cb_salva from w_semplice_cx`cb_salva within w_cat_st
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_cat_st
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_cat_st
end type

type cb_ok from w_semplice_cx`cb_ok within w_cat_st
end type

type dw_2 from udw_000 within w_cat_st
integer x = 69
integer y = 1176
integer width = 3867
integer height = 196
integer taborder = 100
boolean bringtotop = true
string title = ""
string dataobject = "d_new_scegli_stampa"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;long i
integer li_null

setnull(li_null)

choose case string(dwo.name)
	case 'tutte' 
		for i = 1 to dw_1.rowcount()
			dw_1.setitem(i, "c_scegli", data)	
		next
	case 'lista_id'
		//post wf_filtra(data, "L")
		setitem(1, "conto_id", li_null)
		al_lista_id=long(data)
		if isnull(al_lista_id) then al_lista_id=0
		dw_1.is_sql='WHERE ( "art_foto"."art_id" = "art"."art_id" ) and (LISTA_ART_ID ='+STRING(al_lista_id)+")"
		dw_1.retrieve(0)
		
	case 'conto_id'
		post wf_filtra(data, "C")
		setitem(1, "lista_id", 0)
	CASE "dw"
		choose case right(data, 1)
			case '4' 
				setitem(1, "y_1", 1800)
				setitem(1, "x_1", 100)
				setitem(1, "n_righe", 3)
			case '3'
				setitem(1, "y_1", 1480)
				setitem(1, "n_righe", 2)
			case '2'
				setitem(1, "y_1", 1480)
				setitem(1, "n_righe", 2)
			case '1'
				setitem(1, "y_1", 170)
				setitem(1, "n_righe", 1)
		end choose	
	case "vedi_foto"
		wf_carica_immagini(integer(data))
	end choose


end event

type dw_3 from udw_000 within w_cat_st
integer x = 78
integer y = 1368
integer width = 2299
integer height = 220
integer taborder = 130
boolean bringtotop = true
string title = "Selezioni"
string dataobject = "d_sel_cat_semplice"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;integer i
		long ll_id_lista, ll_id_art
		string ls_codice_lista
		datastore ds_lista_figlio, ds_lista
		datawindowchild dwc_lista
choose case  dwo.name
	case 'p_lista'
			
		dw_3.accepttext()
		
		ls_codice_lista=dw_3.getitemstring(1, "codice")
		if ls_codice_lista>"" then
			//wf_salva_lista(ls_codice_lista)
		else
			messagebox("Attenzione!", "Inserire il codice da assegnare alla lista!")
		end if
		
end choose
end event

event itemchanged;call super::itemchanged;
//messagebox("W", "W")
choose case dwo.name
	case "catalogo"
		dw_1.is_sql=" where riga_catalogo.id_catalogo="+data+" "
		dw_1.retrieve()
		
	case "codice" //ovvero lista
		
end choose
end event

type cb_scegli from commandbutton within w_cat_st
integer x = 768
integer y = 1596
integer width = 343
integer height = 100
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Scegli"
end type

event clicked;long i, ll_riga
string ls_cod_art
s_dw_risultati s_risultati

open(w_cerca_articoli)

if isvalid(message.powerobjectparm) then
	s_risultati=message.powerobjectparm
	
	for i= 1 to s_risultati.ds.rowcount()
		ls_cod_art=s_risultati.ds.getitemstring(i, "art_codice")
		
		ll_riga=dw_1.trigger event ue_insert(0)
		dw_1.setitem(ll_riga, "cat_art_CODICE", ls_cod_art)
		dw_1.trigger event itemchanged(ll_riga, dw_1.object.cat_art_codice, ls_cod_art)
	next
end if
end event

type cb_dw from commandbutton within w_cat_st
integer x = 1216
integer y = 1596
integer width = 261
integer height = 96
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;s_ds_per_foto s_foto
integer li_test, i, li_ret

dw_1.accepTtext()
dw_2.acceptText()



s_foto.ds_dati_doc=create datastore
s_foto.ds_dati_doc.dataobject="d_riga_catalogo_gd"
s_foto.ds_dati_doc.settransobject(sqlca)
for i= 1 to dw_1.rowcount()
	if dw_1.getitemstring(i, "c_scegli")="1" then
		li_ret=dw_1.rowscopy(i, i, primary!, s_foto.ds_dati_doc, s_foto.ds_dati_doc.rowcount()+1, primary!)
	end if
next
s_foto.dw=dw_2.getitemstring(1, "dw")
if pos(s_foto.dw, "composite") >0 then
	s_foto.dwchild='S' 
else
	s_foto.dwchild='N'
end if
s_foto.titolo=dw_2.getitemstring(1, "titolo")
s_foto.h_max=dw_2.getitemnumber(1, "h_max")
s_foto.w_max=dw_2.getitemnumber(1, "w_max")
s_foto.x_1=dw_2.getitemnumber(1, "x_1")
s_foto.y_1=dw_2.getitemnumber(1, "y_1")
s_foto.centra=dw_2.getitemnumber(1, "centra")
s_foto.h_fissa=dw_2.getitemnumber(1, "h_fissa")
s_foto.taglia=dw_2.getitemnumber(1, "taglia")
s_foto.cat_imp=dw_3.getitemstring(1, "cat_imp")
s_foto.n_righe=dw_2.getitemnumber(1, "n_righe")
//aggiunto 041011
s_foto.w_pagina=dw_2.getitemnumber(1, "w_pagina")
s_foto.h_pagina=dw_2.getitemnumber(1, "h_pagina")
openwithparm(w_cat_rpt, s_foto)
end event

type cb_st_dw_1 from commandbutton within w_cat_st
string tag = "Stampa la lista che vedi qui sopra come la vedi."
integer x = 1545
integer y = 1592
integer width = 343
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "St. Lista"
end type

event clicked;integer i

printsetup()
dw_1.modify("art_foto.visible=0")
dw_1.modify("c_scegli.visible=0")
for i=1 to dw_1.rowcount()
	dw_1.modify("p_"+string(i)+".x=2460")
next
dw_1.print()
dw_1.modify("art_foto.visible=1")
dw_1.modify("c_scegli.visible=1")
end event

type cb_cat from commandbutton within w_cat_st
boolean visible = false
integer x = 1961
integer y = 1588
integer width = 311
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampaold"
end type

event clicked;long Job, ll_alto, ll_sinistra,ll_larghezza, ll_altezza
long ll_MmX, ll_MmY, prnDC
integer li_ret, li_row, i, li_ris, li_num_pag
string ls_immagine, ls_carattere, ls_st_intestazione, ls_st_pie_di_pagina
long ll_marg_sx, ll_marg_dx,  ll_marg_sup, ll_marg_inf
long ll_dis_imm_orizzontale, ll_dis_imm_verticale, ll_alt_max
long ll_spessore_linea_ret, ll_dist_ret_foto
long ll_altezza_testi, ll_dist_linea_intest_foto
boolean lb_corsivo, lb_sottolineato, lb_rettangolo
integer li_grassetto //400 =normale; 700 = grassetto
integer li_corpo
long ll_intestazione, ll_pie_di_pagina

constant integer HorzRes = 8	
constant integer VertRes = 10	
constant integer HorzSize = 4	
constant integer VertSize = 6  


printsetup()
Job = PrintOpen( )
//trovo il device context della stampante impiegata
prnDC=PRP_GetDC10(job)
//trovo la risoluzione della stampante ... forse non serve più
//ll_PixelX = getdevicecaps(prnDC,HorzRes) 
//ll_PixelY = getdevicecaps(prnDC,VertRes) 
//... e le dimensioni IN MM (non in decimi di mm) della pagina da stampare
ll_MmX = getdevicecaps(prnDC,HorzSize) 
ll_MmY = getdevicecaps(prnDC,VertSize) 
//trasformo in millesimi di inch
ll_MmX*=3.937*10 //per 10 perché sono mm non decimi di mm
ll_MmY*=3.937*10
//prendo i margini della pagina:
//e trasformo i decimi di mm in millesimi di inches
//per far questo basta moltiplicare * il coef. 3,937
//infatti: 1 cm = 0,3937 inches (1 inches = 2,54 cm)

ll_marg_sx=100*3.937
ll_marg_dx=100*3.937
ll_marg_sup=100*3.937
ll_marg_inf=150*3.937
//tolgo i margini dallo spazio stampabile
ll_MmX -=ll_marg_dx
ll_MmY -=ll_marg_inf
//controllo se devo stampare intestazione e pie di pagina
ls_st_intestazione='P' //P= solo prima pagina, N=nessuna pagina 
ls_st_pie_di_pagina='T'//T= tutte le pagine
ll_intestazione=200*3.937
ll_pie_di_pagina=200*3.937
//se devo stampare su tutte tolgo lo spazio del pie di pagina da quello disponibile
if ls_st_pie_di_pagina='T' then ll_MmY -= ll_pie_di_pagina
if  ls_st_intestazione='N' then ll_intestazione=0
if ls_st_pie_di_pagina='N' then ll_pie_di_pagina=0
//stabilire se stampare il rettangolo
lb_rettangolo=true
ll_spessore_linea_ret=0.5*3.937
ll_dist_ret_foto=20*3.937
//ridefinire la posizione della foto se c'è il rettangolo
if lb_rettangolo then
	ll_sinistra=ll_marg_sx+ll_dist_ret_foto
	ll_alto=ll_marg_sup+ll_dist_ret_foto
end if
//distanza delle immagini fra loro
ll_dis_imm_orizzontale=20*3.937
ll_dis_imm_verticale=20*3.937

ll_alt_max=0

//ora occorre recuperare i testi e calcolarne l'altezza
ll_altezza_testi=200*3.937

//stabilire quale carattere usare
ls_carattere="Arial"
lb_corsivo=false
lb_sottolineato=false
li_grassetto=400 //400 =normale; 700 = grassetto
li_corpo= -8  //con segno - valore in punti, senza in millesimi di inch

ll_dist_linea_intest_foto=30*3.937

li_num_pag=1
li_row=dw_1.rowcount()
for i= 1 to li_row
	//se non è scelto lo salto
	if dw_1.getitemnumber(i, "c_scegli")= 0 then continue

	if (ls_st_intestazione='P'  and i=1) or (ls_st_intestazione='T') then
		printline(job, ll_marg_sx, ll_intestazione+ll_marg_sup - ll_dist_linea_intest_foto, &
		ll_Mmx, ll_intestazione + ll_marg_sup - ll_dist_linea_intest_foto, 30)
	end if
	if (ls_st_pie_di_pagina='P' and i=1) or (ls_st_pie_di_pagina='T') and i=1 then
		if ls_st_pie_di_pagina='P' then
			ll_MmY -= ll_pie_di_pagina
		end if
		printline(job, ll_marg_sx, ll_mmY  - ll_dist_linea_intest_foto, &
		ll_Mmx, ll_mmY -ll_dist_linea_intest_foto, 30)
	end if
	
	ls_immagine=dw_1.getitemstring(i, "art_foto")
	if isnull(ls_immagine) or ls_immagine="" then continue
	p_1.picturename = ls_immagine
	ll_larghezza=unitstopixels(p_1.width, XUnitsToPixels!)
	ll_altezza=unitstopixels(p_1.height, YUnitsToPixels!)
	//trovo la risoluzione dell'immagine
	li_ris=wf_trova_ris_jpg(ls_immagine)
	//se non trovo la risoluzione allora per ora salto la foto
	if li_ris<=0 then continue
	//Larghezza e altezza della foto in millesimi di inch
	ll_larghezza=ll_larghezza/li_ris*1000
	ll_altezza=ll_altezza/li_ris*1000
	//controllo se non entra in una pag. A4 (stabilisco misure max: 18cm x 26cm
	do while ll_larghezza> 1800*3.937 or ll_altezza> 2600*3.937 
		ll_larghezza *=4/5
		ll_altezza *=4/5
	loop	
	//controllo se la foto entra nella riga
	if ll_sinistra + ll_larghezza > ll_MmX then
		//se non entra vado a capo colonna nuova
		ll_sinistra=ll_marg_sx+ll_dist_ret_foto
		ll_alto+=ll_alt_max+ll_dist_ret_foto+ll_altezza_testi
		//quindi controllo se entra una nuova colonna nella pagina
		if ll_alto + ll_altezza > ll_MmY then
			//se non entra stampo e vado a pagina nuova
			printpage(job)
			li_num_pag++
			ll_alto=ll_marg_sup+ll_dist_ret_foto
			ll_alt_max=0
			if ls_st_intestazione='T' then
				printline(job, ll_marg_sx, ll_intestazione+ll_marg_sup - ll_dist_linea_intest_foto, &
				ll_Mmx, ll_intestazione + ll_marg_sup - ll_dist_linea_intest_foto, 30)
			end if
			if ls_st_intestazione='P' and li_num_pag=2  then 
				ll_intestazione=0
			end if
			if ls_st_pie_di_pagina='T' then
				printline(job, ll_marg_sx, ll_mmY  - ll_dist_linea_intest_foto, &
				ll_Mmx, ll_mmY -ll_dist_linea_intest_foto, 30)
			end if
			if ls_st_pie_di_pagina='P' and li_num_pag=2  then 
				ll_MmY += ll_pie_di_pagina
				ll_pie_di_pagina=0
			end if
		else
			//entra qundi creo una colonna nuova
			ll_alto+= ll_dis_imm_verticale + ll_dist_ret_foto
			ll_alt_max=0
		end if
	end if
	
	if lb_rettangolo then 
		PrintRect(Job, ll_sinistra - ll_dist_ret_foto, ll_alto+ll_intestazione&
		- ll_dist_ret_foto, ll_larghezza+ll_dist_ret_foto*2, ll_altezza+ll_altezza_testi&
		+ll_dist_ret_foto*2, ll_spessore_linea_ret)
	end if
	
	PrintBitmap(Job, ls_immagine, ll_sinistra, ll_alto + ll_intestazione, &
	ll_larghezza, ll_altezza)
	//carico il font e stampo i testi
	PrintDefineFont(Job, 1, ls_carattere, li_corpo ,li_grassetto, Default!, &
	AnyFont!, lb_corsivo, lb_sottolineato)
	//stampo il testo
	PrintText(Job, "Articolo", ll_sinistra, ll_alto + ll_intestazione + ll_altezza+50, 1)
	//aggiorno i dati per la posizione della prossima foto
	if ll_alt_max < ll_altezza then ll_alt_max = ll_altezza 
	ll_sinistra+=ll_larghezza + ll_dis_imm_orizzontale + ll_dist_ret_foto*2
	
next

PrintClose(Job)
li_ret=DeleteDc(prndc)
p_1.picturename = ""



end event

type p_1 from picture within w_cat_st
boolean visible = false
integer x = 3355
integer y = 760
integer width = 192
integer height = 168
boolean bringtotop = true
boolean originalsize = true
boolean border = true
boolean focusrectangle = false
end type

