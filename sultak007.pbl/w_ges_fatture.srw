forward
global type w_ges_fatture from w_semplice_cx
end type
type dw_2 from udw_001 within w_ges_fatture
end type
end forward

global type w_ges_fatture from w_semplice_cx
integer width = 3310
integer height = 1572
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_2 dw_2
end type
global w_ges_fatture w_ges_fatture

type variables
string is_sql
end variables

on w_ges_fatture.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_ges_fatture.destroy
call super::destroy
destroy(this.dw_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)


dw_2.insertrow(1)
dw_2.setitem(1, "da_data", date(string(year(today()))+"-01-01"))

dw_1.retrieve( date(string(year(today()))+"-01-01"), today())
end event

event resize;call super::resize;dw_1.height=newheight - (292 +250)

dw_2.x=dw_1.x+ dw_1.width - dw_2.width

dw_2.y= dw_1.height +50
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_ges_fatture
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_ges_fatture
end type

type cb_primo from w_semplice_cx`cb_primo within w_ges_fatture
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_ges_fatture
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_ges_fatture
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_ges_fatture
end type

type dw_1 from w_semplice_cx`dw_1 within w_ges_fatture
integer width = 3168
string dataobject = "d_ges_fatture"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::itemchanged;call super::itemchanged;decimal ldc_imp, ldc_tot_fattura
long ll_id_fattura

if dwo.name="imp_riscosso" then
	ldc_imp=dec(data)
	if ldc_imp>=0 then
		dw_1.setitem(row, "data_riscossione", today())
		ldc_tot_fattura=dw_1.getitemdecimal(row, "c_tot_fattura")
		ll_id_fattura=dw_1.getitemnumber(row, "id_fattura")
		if isnull(ll_id_fattura) or ll_id_fattura=0 then
			ll_id_fattura=dw_1.getitemnumber(row, "doc_id")
			dw_1.setitem(row, "id_fattura", ll_id_fattura)
			dw_1.setitemstatus(row, 0, primary!, newmodified!)
		end if
	end if
	
	
end if
end event

event dw_1::ue_key;long ll_riga

if keyflags=2 then
	CHOOSE CASE key
		
		CASE KeyS!
			trigger event ue_update()
		CASE KeyI!
			trigger event ue_insert(getrow())
		CASE  keyadd!
			ll_riga=dw_1.getrow()
			if isnull(ll_riga) or ll_riga<0 then ll_riga=0
			trigger event ue_insert(ll_riga)
		CASE KeyD!, keysubtract!
			trigger event ue_delete(getrow())
	END CHOOSE
end if
end event

event dw_1::ue_post_insert;call super::ue_post_insert;long ll_id_fattura, ll_riga
string ls_rag_sociale
//ll_riga=getrow()
//messagebox("D", ll_riga)
//ll_id_fattura=dw_1.getitemnumber(ll_riga, "id_fattura")
//dw_1.setitem(ll_riga, "id_fattura", ll_id_fattura)

ls_rag_sociale=dw_1.getitemstring(al_riga+1, "rag_sociale")
ll_id_fattura=dw_1.getitemnumber(al_riga+1, "id_fattura")


dw_1.setitem(al_riga, "id_fattura", ll_id_fattura)
dw_1.setitem(al_riga, "rag_sociale", ls_rag_sociale)



end event

event dw_1::updateend;call super::updateend;string ls_tipo

ls_tipo=dw_2.getitemstring(1, "iv_ia")
if isnull(ls_tipo) or ls_tipo="" then ls_tipo='IV'
dw_2.post event itemchanged(1, dw_2.object.iv_ia, ls_tipo)

//dw_1.post retrieve()
end event

type cb_inserisci from w_semplice_cx`cb_inserisci within w_ges_fatture
end type

event cb_inserisci::clicked;long ll_riga
ll_riga=dw_1.getrow()
ll_riga=dw_1.trigger event ue_insert(ll_riga)
end event

type cb_salva from w_semplice_cx`cb_salva within w_ges_fatture
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_ges_fatture
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_ges_fatture
string tag = "Carica nuove fatture."
string text = "Aggiorna"
end type

event cb_annulla::clicked;long ll_id_fattura,ll_riga


DECLARE rec_fatture CURSOR FOR        
select doc_id from dba.doc, dba.registro
where registro.reg_id=doc.reg_id and (registro.reg_tipo='IV' or registro.reg_tipo='IA' ) and doc.doc_data>date('2021/01/01')
;
open rec_fatture;
ll_id_fattura=1
do while ll_id_fattura>0
	ll_riga=0
	ll_id_fattura=0
	FETCH rec_fatture INTO :ll_id_fattura;
	if ll_id_fattura>0 then
		ll_riga=0
		ll_riga=dw_1.find("id_fattura="+string(ll_id_fattura), 1, 10000000)
		if ll_riga>0 then continue
		ll_riga=dw_1.insertrow(0)
		dw_1.setitem(ll_riga, "id_fattura", ll_id_fattura)
		dw_1.setitem(ll_riga, "data_riscossione", date('2000/01/01'))
		dw_1.setitem(ll_riga, "imp_riscosso", 0)
	else
		exit
	end if
loop
close rec_fatture;
end event

type cb_ok from w_semplice_cx`cb_ok within w_ges_fatture
end type

type dw_2 from udw_001 within w_ges_fatture
integer x = 78
integer y = 1236
integer width = 2359
integer height = 192
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_sel_rag_sociale"
end type

event itemchanged;call super::itemchanged;integer li_pos
string ls_rag_soc, ls_filter
date ldt_da_data, ldt_a_data
long ll_riga_trovata

if dwo.name="iv_ia" and  data> " " then
		ls_rag_soc=getitemstring(1, "rag_sociale")
		ldt_da_data=getitemdate(1, "da_data")
		ldt_a_data=getitemdate(1, "a_data")
		if ls_rag_soc> " " then
			li_pos= pos(ls_rag_soc, "-")
			if li_pos>0 then
				ls_rag_soc=left(ls_rag_soc, li_pos - 2)
			end if
			ls_filter=" and ana.ana_rag_sociale='"+ls_rag_soc+"'"	
		end if
	//	if ls_filter > " " then ls_filter+= " and "
	//	ls_filter+=" doc_data>= date('"+string(ldt_da_data, "yyyy/mm/dd" ) +"') and doc_data<= date('"+string(ldt_a_data, "yyyy/mm/dd" )+"') and registro_reg_tipo='"+data+"'"
		ls_filter+=" and registro.reg_tipo='"+data+"'"
		dw_1.is_sql=ls_filter
		dw_1.retrieve( ldt_da_data, ldt_a_data)
	//dw_1.setfilter(ls_filter)
	//dw_1.filter()
end if
end event

