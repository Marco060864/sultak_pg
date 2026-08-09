forward
global type w_pd_cx from w_ra_padre_2_figli_cx
end type
type cb_ricerca from commandbutton within w_pd_cx
end type
type st_1 from statictext within w_pd_cx
end type
type st_2 from statictext within w_pd_cx
end type
end forward

global type w_pd_cx from w_ra_padre_2_figli_cx
integer y = 424
integer width = 3518
integer height = 2464
cb_ricerca cb_ricerca
st_1 st_1
st_2 st_2
end type
global w_pd_cx w_pd_cx

type variables
boolean ib_applica_filtro
string is_ultimo_campo
end variables

forward prototypes
public subroutine wf_recupera_importo (long al_righe)
end prototypes

public subroutine wf_recupera_importo (long al_righe);decimal ldc_importo, ldc_imp_riga
integer i

ldc_importo=dw_1.getitemdecimal(1, "importo")

for i= 1 to al_righe
	ldc_importo -= ldc_imp_riga
	dw_3.setitem(i, "c_importo", ldc_importo)
	ldc_imp_riga=dw_3.getitemdecimal(i, "c_tot_riga")
	
next
end subroutine

on w_pd_cx.create
int iCurrent
call super::create
this.cb_ricerca=create cb_ricerca
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ricerca
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
end on

on w_pd_cx.destroy
call super::destroy
destroy(this.cb_ricerca)
destroy(this.st_1)
destroy(this.st_2)
end on

type dw_2 from w_ra_padre_2_figli_cx`dw_2 within w_pd_cx
integer x = 55
integer y = 1331
integer width = 2951
integer height = 794
string title = "Partita Doppia"
string dataobject = "d_mov_pd_gd"
boolean vscrollbar = true
end type

event dw_2::ue_post_insert;call super::ue_post_insert;long ll_num_max


ll_num_max=getitemnumber(1, "c_max_numero")
if isnull(ll_num_max) then ll_num_max=0
setitem(al_riga, "numero", ll_num_max + 1)
end event

event dw_2::itemfocuschanged;call super::itemfocuschanged;//long ll_riga
//if is_ultimo_campo="importo" then
//	is_ultimo_campo=""
//	cb_inserisci.postevent (clicked!)
//else
//	is_ultimo_campo=dwo.name
//end if
string ls_des
if dwo.name="ultimo" then
	setcolumn("conto_id")
	cb_inserisci.triggerevent (clicked!)
	ls_des=getitemstring(row, "descrizione")
	setitem(rowcount(), "descrizione", ls_des)
end if

end event

event dw_2::getfocus;call super::getfocus;long ll_riga, ll_id_guida, ll_id_contropartita
decimal ldc_imponibile, ldc_imposta
long ll_num_max, ll_id_conto, ll_id_iva
decimal ldc_importo, ldc_parziale
string ls_des, ls_tipo_registro
integer li_ret

if dw_3.rowcount()> 0  and rowcount()<=0 then //è in ia, c'è iva ...
	//salvo la dw_3 (la sezione iva se non fosse salvata)
	li_ret=dw_3.trigger event ue_update()
	cb_inserisci.triggerevent (clicked!)
	ll_riga=getrow()
	ls_des=dw_1.getitemstring(1, "descrizione")
	setitem(ll_riga, "descrizione", ls_des)
	ll_id_conto=dw_1.getitemnumber(1, "conto_id")
	setitem(ll_riga, "conto_id", ll_id_conto)
	ldc_importo=dw_1.getitemdecimal(1, "importo")
	setitem(ll_riga, "importo", ldc_importo)
	setitem(ll_riga, "segno", '-')
////////	
	ldc_imponibile=dw_3.getitemdecimal(1, "c_imponibile")
	ldc_imposta=dw_3.getitemdecimal(1, "c_imposta")
	
	if ldc_imponibile>0 then
		cb_inserisci.triggerevent (clicked!)
		ll_riga=getrow()
		setitem(ll_riga, "segno", '+')
		setitem(ll_riga, "importo", ldc_imponibile)
		//trovo la contropartita per il conto 
		select contropartita_id
		into :ll_id_contropartita
		from dba.contropartita
		where conto_id=:ll_id_conto
		;
		if isnull(ll_id_contropartita) or ll_id_contropartita=0 then
			select conto_id_predefinita_contropartita 
			into :ll_id_contropartita
			from dba.val_base
			;
		end if
		setitem(ll_riga, "conto_id", ll_id_contropartita)
		setitem(ll_riga, "descrizione", ls_des)
	end if
	
	if ldc_imposta>0 then
		cb_inserisci.triggerevent (clicked!)
		ll_riga=getrow()
		setitem(ll_riga, "segno", '+')
		setitem(ll_riga, "importo", ldc_imposta)
		//recupero guida_pd_id e quindi il conto iva indicato
		ll_id_guida=dw_1.getitemnumber(1, "guida_pd_id")
		select conto_iva
		into :ll_id_iva
		from dba.guida_pd
		where id_guida_pd=:ll_id_guida
		;
		if ll_id_iva>0 then
			setitem(ll_riga, "conto_id", ll_id_iva)
		else
			ls_tipo_registro=dw_1.getitemstring(1, "c_tipo_registro")
			if ls_tipo_registro= "IV" then
				select conto_id_ven_contropartita
				into :ll_id_iva
				from dba.val_base;
			elseif ls_tipo_registro= "IA" then
				select conto_id_acq_contropartita
				into :ll_id_iva
				from dba.val_base;
			end if
			if ll_id_iva>0 then
				setitem(ll_riga, "conto_id", ll_id_iva)
			else
				messagebox("Attenzione!", "Non è stato trovato alcun conto IVA")
			end if
		end if
		ls_des=dw_1.getitemstring(1, "descrizione")
		setitem(ll_riga, "descrizione", ls_des)
		
	end if
elseif  dw_3.rowcount()= 0  and rowcount()=0 then
	
end if
end event

type dw_3 from w_ra_padre_2_figli_cx`dw_3 within w_pd_cx
integer x = 55
integer y = 701
integer width = 2951
integer height = 602
string dataobject = "d_mov_iva_gd"
boolean vscrollbar = true
end type

event dw_3::ue_post_insert;call super::ue_post_insert;integer i, li_ret
decimal{2} ldc_importo
long ll_id_pd

dw_1.accepttext()
ll_id_pd=dw_1.getitemnumber(1, "id_pd")
if ll_id_pd> 0 then
	dw_3.setitem(al_riga, "id_pd", ll_id_pd)
else
	li_ret=dw_1.trigger event ue_update()
	if li_ret= 1 then
		ll_id_pd=dw_1.getitemnumber(1, "id_pd")
		dw_3.setitem(al_RIGA, "id_pd", ll_id_pd)
	else
		messagebox("Attenzione!", "Registrazione Incompleta! Impossibile salvare!")
	end if
end if
ldc_importo=dw_1.getitemdecimal(1, "importo")
if al_riga> 1 then //c'è una riga precedente (prendo l'importo della riga precedente e lo tolgo al totale
	for i=1 to al_riga - 1
		ldc_importo -= getitemdecimal(i, "c_tot_riga")
	next
end if
setitem(al_riga, "c_importo", ldc_importo)


end event

event dw_3::itemchanged;call super::itemchanged;decimal ldc_importo, ldc_imponibile, ldc_imposta,ldc_aliquota, ldc_imp_parziale
long ll_iva

choose case dwo.name
	case "iva_id"
		ll_iva=long (data)
		select iva_aliquota
		into :ldc_aliquota
		from dba.iva
		where iva_id=:ll_iva;
		if ldc_aliquota>0 then
			ldc_importo=getitemdecimal(row, "c_importo")
			ldc_imponibile=dec(ldc_importo)/(1+ldc_aliquota/100)
			setitem(row, "imponibile", ldc_imponibile)
			setitem(row, "imposta",ldc_importo - ldc_imponibile)
		elseif ldc_aliquota=0 then
			ldc_imponibile=getitemdecimal(row, "c_importo")
			setitem(row, "imponibile", ldc_imponibile)
			setitem(row, "imposta",0)
		end if
	case "imponibile"
		ll_iva=getitemnumber(row, "iva_id")
		select iva_aliquota
		into :ldc_aliquota
		from dba.iva
		where iva_id=:ll_iva;
		if ldc_aliquota>=0 then
			ldc_imponibile=dec(data)
			setitem(row, "imposta", ldc_imponibile*ldc_aliquota/100)
		end if
		if row<rowcount() then
			ldc_importo=getitemdecimal(1, "c_importo")
			ldc_imp_parziale=getitemdecimal(ROW, "c_tot_controllo")
		end if
end choose
end event

event dw_3::retrieveend;call super::retrieveend;decimal ldc_importo, ldc_imp_riga
integer i

wf_recupera_importo(rowcount)

end event

event dw_3::rowfocuschanged;call super::rowfocuschanged;decimal ldc_importo

if currentrow>1 then
	ldc_importo=getitemdecimal(currentrow, "c_importo")
	if ldc_importo = 0 or isnull(ldc_importo) then
		wf_recupera_importo(rowcount())		
	end if
end if
end event

event dw_3::itemfocuschanged;call super::itemfocuschanged;long ll_riga
if is_ultimo_campo="c_importo" then
	is_ultimo_campo=""
	cb_inserisci.postevent (clicked!)
	setcolumn("iva_id")
else
	is_ultimo_campo=dwo.name
end if
end event

type dw_1 from w_ra_padre_2_figli_cx`dw_1 within w_pd_cx
integer height = 637
string dataobject = "d_pd_ff"
end type

event dw_1::itemchanged;call super::itemchanged;long ll_guida_id, ll_num_registro, ll_id_reg, ll_num_prog, ll_num
string ls_tipo_numero, ls_tipo, ls_num_doc, ls_segno_iva

choose case dwo.name
	case "num_registrazione"
		ib_applica_filtro=true
	case "data_registrazione"
			setitem (row, "data_comp_iva", date(data))
			setitem (row, "data_competenza", date(data))
	case "guida_pd_id"
			ll_guida_id=long(data)
			select reg_tipo_numero, segno_iva
			into :ls_tipo_numero, :ls_segno_iva
			from dba.guida_pd
			where id_guida_pd= :ll_guida_id;
//			
			setitem(1, "segno_iva", ls_segno_iva)
//			wf_filtra_intestatari(ls_prefisso)
//			
			if ls_tipo_numero > " " then
				
				ls_tipo=left(ls_tipo_numero, 2)
				setitem(1, "c_tipo_registro", ls_tipo)
				ll_num_registro=integer(right(ls_tipo_numero, len(ls_tipo_numero) - 2))
							
				select reg_id
				into :ll_id_reg
				from dba.registro, dba.esercizio
				where reg_tipo= :ls_tipo
				and reg_numero=:ll_num_registro
				and reg_ese_id = ese_id
				and ese_data_inizio<=today()
				and ese_data_fine>=today();
						
				setitem (row, "reg_id", ll_id_reg)
				post event itemchanged(row, object.reg_id, string(ll_id_reg))
				dw_1.setcolumn("num_documento")
				
				
			end if
			
		case "reg_id"
			ll_id_reg=long (data)
			ll_guida_id=getitemnumber(row, "guida_pd_id")
			select reg_tipo_numero
			into :ls_tipo_numero
			from dba.guida_pd
			where id_guida_pd= :ll_guida_id;
			ls_tipo=left(ls_tipo_numero, 2)
			
			select max(num_registrazione)
				into :ll_num_prog
				from dba.partita_doppia
				where reg_id = :ll_id_reg;
				if isnull(ll_num_prog) then ll_num_prog=0
				setitem (row, "num_registrazione", ll_num_prog + 1)
				
				if right(ls_tipo, 1) = "V" or right(ls_tipo, 1) = "N" then
					select num_documento
					into :ls_num_doc
					from dba.partita_doppia
					where reg_id = :ll_id_reg
					and num_registrazione=:ll_num_prog;
					
					ll_num=long(ls_num_doc)
					if isnull(ll_num) or ll_num<1 then ll_num=0
					//controllo se non è numerico il num_doc (da fare????)
					setitem (row, "num_documento", string(ll_num + 1))
				else
					setitem (row, "num_documento","")
				
				end if 
			
				
				
					
			
				
				
//				
end choose
end event

event dw_1::ue_post_insert;call super::ue_post_insert;long ll_id_valuta


select val_id
into :ll_id_valuta
from dba.val_base
;
if ll_id_valuta>0 then
	setitem(al_riga, "val_id", ll_id_valuta)
end if

end event

event dw_1::updatestart;call super::updatestart;decimal ldc_tot, ldc_tot_iva, ldc_tot_pn

IF dw_2.ROWCOUNT()>0 AND DW_3.ROWCOUNT()>0 THEN
	ldc_tot=round(dw_1.getitemdecimal(1, "importo"), 2)
	ldc_tot_iva=round(dw_3.getitemdecimal(1, "c_tot_controllo"), 2)
	ldc_tot_pn=round(dw_2.getitemdecimal(1, "c_tot_controllo"), 2)
	
	if ldc_tot_iva<>ldc_tot then
		messagebox("Attenzione!", "Il totale IVA è diverso dal totale del Documento!")
		return 1
	end if
	if ldc_tot_pn<> 0 then
		messagebox("Attenzione!", "Il totale della Prima Nota è diverso da 0!")
		return 1
	end if
END IF

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;date ldt_data_doc
string ls_num_doc

if dwo.name> " " then
	is_ultimo_campo=dwo.name
end if

if dwo.name="descrizione" then
	if getitemstring(row, "c_tipo_registro") ='IA' then
		ls_num_doc=	getitemstring(	row, "num_documento")
		ldt_data_doc=getitemdate(	row, "data_documento")
		post setitem(row, "descrizione", "Fattura n. "+ls_num_doc+" del "+string(ldt_data_doc, "dd/mm/yy"))
	end if
	
end if
end event

event dw_1::losefocus;call super::losefocus;string ls_tipo_registro, ls_des
long ll_riga_inserita

ls_tipo_registro= getitemstring(1, "c_tipo_registro")
if is_ultimo_campo="importo" and (ls_tipo_registro="IA" or (ls_tipo_registro="IV")) then
	if dw_2.rowcount()>=0 then
		i_dw_corrente=dw_3
		cb_inserisci.trigger event clicked()
		dw_3.setfocus()
		dw_3.setcolumn("iva_id")
	end if
elseif left(ls_tipo_registro, 2)='PN' and  is_ultimo_campo="descrizione" then
		if dw_2.rowcount()>=0 then
			i_dw_corrente=dw_2
			cb_inserisci.trigger event clicked()
			ll_riga_inserita=dw_2.rowcount()
			accepttext()
			ls_des=getitemstring(1, "descrizione")
			dw_2.setitem(ll_riga_inserita, "descrizione", ls_des)
			
			dw_2.setfocus()
			dw_2.post setcolumn("conto_id")
		end if
	else
end if
end event

type cb_inserisci from w_ra_padre_2_figli_cx`cb_inserisci within w_pd_cx
integer x = 88
integer y = 2170
end type

event cb_inserisci::clicked;call super::clicked;dw_2.post setcolumn("conto_id")
end event

type cb_salva from w_ra_padre_2_figli_cx`cb_salva within w_pd_cx
integer x = 377
integer y = 2170
end type

type cb_cancella from w_ra_padre_2_figli_cx`cb_cancella within w_pd_cx
integer x = 662
integer y = 2170
end type

type cb_annulla from w_ra_padre_2_figli_cx`cb_annulla within w_pd_cx
integer x = 1148
integer y = 2173
end type

type cb_ok from w_ra_padre_2_figli_cx`cb_ok within w_pd_cx
integer x = 1441
integer y = 2170
end type

type cb_ricerca from commandbutton within w_pd_cx
integer x = 3050
integer y = 51
integer width = 344
integer height = 99
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricerca"
end type

event clicked;long ll_id, ll_riga

s_ricerca s_ric
w_new_ricerca_sw w_ric_sw

s_ric.dataobject='d_pd_sw'
s_ric.titolo_finestra="Ricerca scritture contabili"
dw_1.accepttext()
if dw_1.rowcount()<1 then
	cb_inserisci.triggerevent(clicked!)
end if
if ib_applica_filtro=true then
	s_ric.filtro[1]=string(dw_1.getitemnumber(1, "num_registrazione"))
	s_ric.colonna_filtro[1]="num_registrazione"
	ib_applica_filtro=false
end if

openwithparm(w_ric_sw, s_ric)
if isvalid(message) then ll_id=message.doubleparm


ll_riga=dw_1.retrieve(ll_id)
if ll_riga>0 then
	dw_1.trigger event rowfocuschanged(ll_riga)
else
	cb_inserisci.triggerevent(clicked!)
end if
dw_1.setcolumn("num_documento")
end event

type st_1 from statictext within w_pd_cx
integer x = 3039
integer y = 1334
integer width = 336
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prima Nota"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pd_cx
integer x = 3013
integer y = 710
integer width = 336
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sezione IVA"
boolean focusrectangle = false
end type

