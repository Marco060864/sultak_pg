forward
global type w_doc_scontrino_cx from w_padre_figlio_cx
end type
type cb_ricerca_doc from uo_cmdbutton_for_tab within w_doc_scontrino_cx
end type
type cbx_ric_num_prog from checkbox within w_doc_scontrino_cx
end type
type cb_stampa from uo_commandbutton within w_doc_scontrino_cx
end type
type cb_salva_prezzi from commandbutton within w_doc_scontrino_cx
end type
end forward

global type w_doc_scontrino_cx from w_padre_figlio_cx
integer width = 4178
integer height = 2140
cb_ricerca_doc cb_ricerca_doc
cbx_ric_num_prog cbx_ric_num_prog
cb_stampa cb_stampa
cb_salva_prezzi cb_salva_prezzi
end type
global w_doc_scontrino_cx w_doc_scontrino_cx

type variables
string is_scorporo_iva
boolean ib_applica_filtro
end variables

forward prototypes
public subroutine wf_dati_articolo (long al_row, long al_art_id)
public subroutine wf_scorporo_iva (long al_id_guida)
public function integer wf_filtra_intestatari (string as_prefisso)
end prototypes

public subroutine wf_dati_articolo (long al_row, long al_art_id);string ls_des, ls_tipo, ls_um_tipo,ls_tipo_azienda
long ll_id_tit, ll_id_um, ll_id_vali, ll_id_listino, ll_id_conto, ll_reg_id
decimal ldc_c_calo, ldc_prezzo, ldc_null, ldc_peso_non_prezioso
date ldt_data_doc
long ll_id_taglia, ll_id_colore, ll_id_iva,ll_iva_soggetto,ll_id_causale

setnull(ldc_null)

select art_descrizione, art_tit_preferenziale, art_calo_preferenziale,  um_id, peso_non_prezioso,
			id_taglia, id_colore, iva_id
into :ls_des, :ll_id_tit, :ldc_c_calo, :ll_id_um, :ldc_peso_non_prezioso, :ll_id_taglia, :ll_id_colore,
		:ll_id_iva
from dba.art
where art_id= :al_art_id;

ll_id_conto=dw_1.getitemnumber(1, "doc_conto_id")
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
			dw_2.setitem(al_row, "iva_id", ll_id_iva)
		else
			messagebox("Attenzione!", "Specificare iva in valori base!")
		end if
	end if
end if

		

if ldc_peso_non_prezioso>0 then
	dw_2.setitem(al_row, "rdoc_non_prezioso", ldc_peso_non_prezioso)
end if

if ls_des>"" and not isnull(ls_Des) then
	dw_2.setitem(al_row, "rdoc_descrizione", ls_Des)
end if


if ll_id_taglia>0  then
	dw_2.setitem(al_row, "id_taglia", ll_id_taglia)
end if
if ll_id_colore>0  then
	dw_2.setitem(al_row, "id_colore", ll_id_colore)
end if


if ll_id_um>0  then
dw_2.setitem(al_row, "um_id", ll_id_um)
	ll_id_conto=dw_1.getitemnumber(1, "doc_conto_id")
	ldt_data_doc=dw_1.getitemdate(1, "doc_data")
//	ll_reg_id=dw_1.getitemnumber(1, "reg_id")
//	select reg_tipo
//	into :ls_tipo
//	from registro
//	where reg_id=:ll_reg_id
//	;
//	ls_tipo= right(ls_tipo, 1)
//	if ls_tipo='C' then ls_tipo='V'
	
	ll_id_causale=dw_2.getitemnumber(al_row, "causale_id")
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
			dw_2.setitem(al_row, "vali_id", ll_id_vali)
			if ls_um_tipo='P' then
				dw_2.setitem(al_row, "rdoc_pr_pezzo", ldc_null)
				if is_scorporo_iva='S' then
					dw_2.trigger event &
					itemchanged(al_row, dw_2.object.rdoc_pr_man, string(ldc_prezzo))
				else
					dw_2.setitem(al_row, "rdoc_pr_man", ldc_prezzo)
				end if
			else
				dw_2.setitem(al_row, "rdoc_pr_man", ldc_null)
				if is_scorporo_iva='S' then
					dw_2.trigger event &
					itemchanged(al_row, dw_2.object.rdoc_pr_pezzo, string(ldc_prezzo))
				else
					dw_2.setitem(al_row, "rdoc_pr_pezzo", ldc_prezzo)
				end if
			end if
		end if
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

public function integer wf_filtra_intestatari (string as_prefisso);datawindowchild ldw_conto, ldw_conto_1
integer rtncode

setredraw(false)
rtncode =dw_1.GetChild('doc_conto_id', ldw_conto)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild ldw_conto")			
ldw_conto.settransobject(sqlca)
rtncode = dw_1.GetChild('doc_conto_id_1', ldw_conto_1)
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

on w_doc_scontrino_cx.create
int iCurrent
call super::create
this.cb_ricerca_doc=create cb_ricerca_doc
this.cbx_ric_num_prog=create cbx_ric_num_prog
this.cb_stampa=create cb_stampa
this.cb_salva_prezzi=create cb_salva_prezzi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ricerca_doc
this.Control[iCurrent+2]=this.cbx_ric_num_prog
this.Control[iCurrent+3]=this.cb_stampa
this.Control[iCurrent+4]=this.cb_salva_prezzi
end on

on w_doc_scontrino_cx.destroy
call super::destroy
destroy(this.cb_ricerca_doc)
destroy(this.cbx_ric_num_prog)
destroy(this.cb_stampa)
destroy(this.cb_salva_prezzi)
end on

event open;long ll_id
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

i_dw_corrente=1


dw_1.trigger event ue_insert(0)
end event

event resize;call super::resize;dw_2.height= w_doc_scontrino_cx.height - dw_1.height - 450
dw_2.width= w_doc_scontrino_cx.width - 150
dw_1.width= w_doc_scontrino_cx.width - 150

cb_ricerca_doc.y=cb_annulla.y
cb_ricerca_doc.x=cb_annulla.x - 485
end event

type cb_ricerca from w_padre_figlio_cx`cb_ricerca within w_doc_scontrino_cx
boolean visible = false
integer x = 928
integer y = 1732
end type

type dw_1 from w_padre_figlio_cx`dw_1 within w_doc_scontrino_cx
integer x = 27
integer y = 24
integer width = 3762
integer height = 512
string dataobject = "d_doc_scontrino_ff"
end type

event dw_1::itemchanged;call super::itemchanged;long ll_guida_id, ll_num_prog
string ls_guida_reg_id, ls_prefisso, ls_tipo, ls_num_doc
long ll_num_registro, ll_id_reg, ll_num
date ld_data_prog, ld_data_doc

choose case string(dwo.name)
	case "guida_id"
		ll_guida_id=long (data)
		
		if ll_guida_id>0 then
			
			wf_scorporo_iva(ll_guida_id)
			
			select guida_reg_id, pref_conto
			into :ls_guida_reg_id, :ls_prefisso
			from dba.guida
			where guida_id= :ll_guida_id;
			
//			wf_filtra_intestatari(ls_prefisso)
			
			if ls_guida_reg_id > " " then
				
				ls_tipo=left(ls_guida_reg_id, 2)
				ll_num_registro=integer(right(ls_guida_reg_id, len(ls_guida_reg_id) - 2))
							
				select reg_id
				into :ll_id_reg
				from dba.registro, dba.esercizio
				where reg_tipo= :ls_tipo
				and reg_numero=:ll_num_registro
				and reg_ese_id = ese_id
				and ese_data_inizio<=today()
				and ese_data_fine>=today();
						
				setitem (row, "reg_id", ll_id_reg)
				
				select max(doc_num_prog)
				into :ll_num_prog
				from dba.doc
				where reg_id = :ll_id_reg;
				if right(ls_tipo, 1) <> "A" then
				
					select doc_numero
					into :ls_num_doc
					from dba.doc
					where reg_id = :ll_id_reg
					and doc_num_prog=:ll_num_prog;
					ll_num=long(ls_num_doc)
				elseif right(ls_tipo, 1) <> "V" then
				
				end if 
			//controllo se non è numerico il num_doc (da fare)
				if ll_num_prog > 0 then
					setitem (row, "doc_num_prog", ll_num_prog+1)
					if right(ls_tipo, 1) <> "A" then
						setitem (row, "doc_numero", string(ll_num + 1))
					else
						setitem (row, "doc_numero", "")	
					end if
				else
					setitem (row, "doc_num_prog", 1)
					if right(ls_tipo, 1) <> "A" then
						setitem (row, "doc_numero",  string(1))
					else
						setitem (row, "doc_numero", "")	
					end if
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
	case "doc_num_prog"
		if long(data)>0 and cbx_ric_num_prog.checked then
				ib_applica_filtro=true
				cb_ricerca_doc.postevent(clicked!)
			end if
end choose
end event

type dw_2 from w_padre_figlio_cx`dw_2 within w_doc_scontrino_cx
integer x = 27
integer y = 548
integer width = 4082
integer height = 1176
string dataobject = "d_rdoc_scontrino_gd"
boolean vscrollbar = true
end type

event dw_2::itemchanged;call super::itemchanged;long ll_art_id
choose case dwo.name
case "rdoc_art_id", "rdoc_art_id_1"
		ll_art_id= long (data)
		wf_dati_articolo(row, ll_art_id)
	
		
end choose
end event

event dw_2::ue_post_insert;call super::ue_post_insert;integer li_max
long ll_id_doc, ll_caus_id, ll_id_guida, ll_mag_id, ll_id_conto,ll_iva_id
decimal ldc_qta_prop

if al_riga>0 then
	li_max=dw_2.getitemnumber(al_riga, "c_max_num")
	if isnull(li_max) then li_max=0
	setitem(al_riga, "rdoc_numero", li_max+1)
	ll_id_doc=dw_1.getitemnumber(1, "doc_id")
	if ll_id_doc>0 then
		setitem(al_riga, "rdoc_doc_id", ll_id_doc)
	else
		i_dw_corrente=1
		cb_salva.triggerevent("clicked")
		i_dw_corrente=2
		ll_id_doc=dw_1.getitemnumber(1, "doc_id")
		if ll_id_doc>0 then
			setitem(al_riga, "rdoc_doc_id", ll_id_doc)
		else
			messagebox("Attenzione!", "Riempire correttamente la testa prima di inserire le righe!")
		end if
	end if
	ll_id_guida=dw_1.getitemnumber(1, "guida_id")
	select guida_caus_id, guida_id_magazzino
	into :ll_caus_id, :ll_mag_id
	from dba.guida
	where guida_id=:ll_id_guida
	;
	
	this.setitem(al_riga, "causale_id", ll_caus_id)
	this.setitem(al_riga, "mag_id", ll_mag_id)
	ll_id_conto=dw_1.getitemnumber(1, "doc_conto_id")
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
	
	select qta_riga_doc_proposta
	into :ldc_qta_prop
	from dba.val_base
	;
	if ldc_qta_prop>0 then
		setitem(al_riga, "rdoc_qta", ldc_qta_prop)
	end if
	
	
end if
end event

type cb_inserisci from w_padre_figlio_cx`cb_inserisci within w_doc_scontrino_cx
integer x = 50
integer y = 1732
end type

event cb_inserisci::clicked;long ll_riga,ll_test
dwitemstatus ls_status

if i_dw_corrente=1 then
	if dw_1.rowcount()>0 then
		ls_status=dw_1.getitemstatus(1, 0, primary!)
		if ls_status=datamodified! then
			ll_test=dw_1.trigger event ue_update()
			if ll_test=1 then 
				dw_1.reset()
				ll_riga=dw_1.trigger event ue_insert(0)
			end if
				
		else
			dw_1.reset()
			ll_riga=dw_1.trigger event ue_insert(0)	
		end if
	else
		ll_riga=dw_1.trigger event ue_insert(0)
	end if
elseif  i_dw_corrente=2 then
	ll_riga=dw_2.trigger event ue_insert(0)
end if


end event

type cb_salva from w_padre_figlio_cx`cb_salva within w_doc_scontrino_cx
integer x = 338
integer y = 1732
end type

type cb_cancella from w_padre_figlio_cx`cb_cancella within w_doc_scontrino_cx
integer x = 626
integer y = 1732
end type

type cb_annulla from w_padre_figlio_cx`cb_annulla within w_doc_scontrino_cx
integer x = 1221
integer y = 1728
end type

type cb_ok from w_padre_figlio_cx`cb_ok within w_doc_scontrino_cx
integer x = 1518
integer y = 1732
end type

type cb_ricerca_doc from uo_cmdbutton_for_tab within w_doc_scontrino_cx
string tag = "apre la finestra di ricerca dei documenti."
integer x = 901
integer y = 1868
integer width = 389
integer taborder = 30
boolean bringtotop = true
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
//		cbx_in_derivazione.checked=false
		ll_id_guida=dw_1.getitemnumber(dw_1.getrow(), "guida_id")
		select  pref_conto
		into :ls_prefisso
		from dba.guida
		where guida_id= :ll_id_guida;
		wf_filtra_intestatari(ls_prefisso)
		if ll_riga>0 then
			dw_1.trigger event rowfocuschanged(ll_riga)
			//ll_conto=dw_1.getitemnumber(dw_1.getrow(), "doc_conto_id")
//			wf_carica_destinazioni(ll_conto)
			//wf_carica_banca(ll_conto)
		else
			cb_inserisci.triggerevent(clicked!)
		end if
	end if
end if


end event

type cbx_ric_num_prog from checkbox within w_doc_scontrino_cx
integer x = 1806
integer y = 360
integer width = 914
integer height = 80
boolean bringtotop = true
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

type cb_stampa from uo_commandbutton within w_doc_scontrino_cx
integer x = 1367
integer y = 1876
integer width = 261
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
string text = "Stampa"
end type

event clicked;date ldt_data
s_st_doc st_doc

cb_salva.triggerevent(clicked!)
st_doc.sl_id_doc=dw_1.getitemnumber(dw_1.getrow(), "doc_id")
ldt_data=dw_1.getitemdate(dw_1.getrow(), "doc_data")
st_doc.ss_name=dw_1.getitemstring(dw_1.getrow(), "doc_numero")
st_doc.ss_name="DOC_n_"+st_doc.ss_name+ "_del_"+ string(ldt_data, "dd-mm-yyyy")
st_doc.dt_inizio_esercizio=f_trova_inizio_esercizio(ldt_data)

openwithparm(w_st_doc, st_doc, parent)


end event

type cb_salva_prezzi from commandbutton within w_doc_scontrino_cx
integer x = 2862
integer y = 336
integer width = 640
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva Prezzi in Listino"
end type

event clicked;integer i
long ll_id_art, ll_vali_id, ll_id_um, ll_id_reg, ll_id_listino, ll_id_sog, ll_id_listino_base
decimal ldc_prezzo
string ls_tipo, ls_tipo_reg, ls_tipo_lis, ls_data
long ll_vali_id_base
date ldt_data

if messagebox("Attenzione!", "Vuoi davvero salvare i prezzi di questo documento nel listino?", stopsign!, yesno!)=1 then
	//guardo il registro se il documento è di vendita (uscita tipo_registro finisce con "V) o acquisto(finisce con "A")
	ll_id_reg=dw_1.getitemnumber(1, "reg_id")
	select reg_tipo
	into :ls_tipo_reg
	from dba.registro
	where reg_id=:ll_id_reg
	;
	ls_tipo_lis=right(ls_tipo_reg, 1)
	//cerco se l'intestatario del doc ha un listino
	ll_id_sog=dw_1.getitemnumber(1, "doc_conto_id")
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



end event

