forward
global type w_st_lista_documenti from w_stampa
end type
type cbx_2 from checkbox within w_st_lista_documenti
end type
type cbx_vedi_doc from checkbox within w_st_lista_documenti
end type
type cbx_no_righe from checkbox within w_st_lista_documenti
end type
type cbx_ordina_prog from checkbox within w_st_lista_documenti
end type
end forward

global type w_st_lista_documenti from w_stampa
integer width = 3569
integer height = 2064
cbx_2 cbx_2
cbx_vedi_doc cbx_vedi_doc
cbx_no_righe cbx_no_righe
cbx_ordina_prog cbx_ordina_prog
end type
global w_st_lista_documenti w_st_lista_documenti

type variables
s_sel_stampa is_sel
end variables

on w_st_lista_documenti.create
int iCurrent
call super::create
this.cbx_2=create cbx_2
this.cbx_vedi_doc=create cbx_vedi_doc
this.cbx_no_righe=create cbx_no_righe
this.cbx_ordina_prog=create cbx_ordina_prog
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_2
this.Control[iCurrent+2]=this.cbx_vedi_doc
this.Control[iCurrent+3]=this.cbx_no_righe
this.Control[iCurrent+4]=this.cbx_ordina_prog
end on

on w_st_lista_documenti.destroy
call super::destroy
destroy(this.cbx_2)
destroy(this.cbx_vedi_doc)
destroy(this.cbx_no_righe)
destroy(this.cbx_ordina_prog)
end on

event open;call super::open;date ld_data_inizio

is_sel=message.powerobjectparm

dw_1.dataobject=is_sel.s_tipo_stampa
dw_1.settransobject(sqlca)

dw_1.retrieve(is_sel.s_da_data, is_sel.s_a_data, is_sel.s_data_inizio)
end event

event close;call super::close;//if isvalid(w_doc_ff) then
//	close(w_doc_ff)
//end if
end event

type pb_1 from w_stampa`pb_1 within w_st_lista_documenti
integer x = 2838
end type

type cb_preview from w_stampa`cb_preview within w_st_lista_documenti
integer x = 2231
integer taborder = 100
end type

type dw_1 from w_stampa`dw_1 within w_st_lista_documenti
integer y = 208
integer width = 3430
integer height = 1667
integer taborder = 160
string dataobject = "d_st_documenti"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i

ls_sql=sqlsyntax

if is_sel.s_cl_fo>"" then
	ls_sql+= ' and ("dba"."conto"."conto_codice"='+"'"+is_sel.s_cl_fo+"')"
	
end if
if is_sel.s_id_magazzino >0 then
	ls_sql+=" and (dba.magazzino.maga_id= "+string(is_sel.s_id_magazzino)+")"
end if
if is_sel.s_id_articolo >0 then
	ls_sql+=" and (dba.rdoc.rdoc_art_id= "+string(is_sel.s_id_articolo)+")"
end if
if is_sel.s_id_titolo >0 then
	ls_sql+=" and (dba.titolo.tit_id= "+string(is_sel.s_id_titolo)+")"
end if
if is_sel.s_id_metallo >0 then
	ls_sql+=" and (dba.metallo.met_id= "+string(is_sel.s_id_metallo)+")"
end if

if is_sel.s_tipo_registro >"" then
	ls_sql+=" and (dba.registro.reg_tipo= '"+is_sel.s_tipo_registro+"')"
end if

if is_sel.s_id_registro >0 then
	ls_sql+=" and (dba.registro.reg_id= "+string(is_sel.s_id_registro)+")"
end if

if is_sel.s_evasi_no_tutti = 'E' then
	ls_sql+=" and (dba.rdoc.rdoc_peso_evaso >=  dba.rdoc.rdoc_peso) and "+&
				" (dba.rdoc.rdoc_qta_evasa >=  dba.rdoc.rdoc_qta) "
			
end if

if is_sel.s_evasi_no_tutti = 'I' then
	ls_sql+=" and (dba.rdoc.rdoc_peso_evaso <  dba.rdoc.rdoc_peso or  dba.rdoc.rdoc_peso=0 ) and "+&
				" (dba.rdoc.rdoc_qta_evasa <  dba.rdoc.rdoc_qta) "
end if

//nuovi filtri 260308
if is_sel.cat_codifica > 0 then
	ls_sql+=" and (dba.art.art_id_codifica= "+string(is_sel.cat_codifica)+")"
end if
if upperbound(is_sel.s_id_causale[]) > 0 then
	for i=1 to upperbound(is_sel.s_id_causale[])
		if i=1 then
			ls_sql+=" and (dba.rdoc.causale_id= "+string(is_sel.s_id_causale[i])
		else
			ls_sql+=" or dba.rdoc.causale_id= "+string(is_sel.s_id_causale[i])
		end if
	next
	ls_sql+=") "
end if
if is_sel.da_articolo>"" then
	ls_sql+=" and (dba.art.art_codice >= '"+ is_sel.da_articolo+"') "
	if isnull(is_sel.ad_articolo) then
		is_sel.ad_articolo="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
	end if
	ls_sql+=" and (dba.art.art_codice <= '"+ is_sel.ad_articolo+"') "
	
end if


//applico
if ls_sql>sqlsyntax then
	if setsqlpreview(ls_sql) <> 1 then messagebox("Errore!", "Filtro non applicato!")
end if
end event

event dw_1::doubleclicked;call super::doubleclicked;long ll_id_doc

if row>0 then
	ll_id_doc=dw_1.getitemnumber(row, "doc_doc_id")

	if ll_id_doc>0 then
		OpenWithParm(w_doc_ff, ll_id_doc)
	end if
end if
end event

event dw_1::rbuttondown;call super::rbuttondown;//if object.c_dati_doc.visible="1" then 
//	object.c_dati_doc.visible="0"
//	GroupCalc()
//else
//	object.c_dati_doc.visible="1" 
//	GroupCalc()
//end if

end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_lista_documenti
integer x = 2637
end type

type pb_stampa from w_stampa`pb_stampa within w_st_lista_documenti
integer x = 2428
integer taborder = 130
end type

type sle_pg from w_stampa`sle_pg within w_st_lista_documenti
integer taborder = 70
end type

type st_1 from w_stampa`st_1 within w_st_lista_documenti
end type

type st_2 from w_stampa`st_2 within w_st_lista_documenti
integer taborder = 30
end type

type sle_copie from w_stampa`sle_copie within w_st_lista_documenti
integer taborder = 40
end type

type sle_zoom from w_stampa`sle_zoom within w_st_lista_documenti
integer taborder = 60
end type

type cb_7 from w_stampa`cb_7 within w_st_lista_documenti
integer taborder = 50
end type

type cb_6 from w_stampa`cb_6 within w_st_lista_documenti
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_lista_documenti
integer taborder = 20
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_lista_documenti
integer taborder = 10
end type

type cb_esci from w_stampa`cb_esci within w_st_lista_documenti
integer x = 3094
end type

type cbx_2 from checkbox within w_st_lista_documenti
integer x = 55
integer y = 128
integer width = 505
integer height = 80
integer taborder = 150
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Totali"
boolean checked = true
end type

event clicked;if checked then
	dw_1.Modify("DataWindow.Trailer.1.Height=308")
else
	dw_1.Modify("DataWindow.Trailer.1.Height=0")
end if
end event

type cbx_vedi_doc from checkbox within w_st_lista_documenti
integer x = 508
integer y = 128
integer width = 505
integer height = 80
integer taborder = 150
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Info Documenti"
end type

event clicked;if checked then
	dw_1.Modify("DataWindow.header.1.Height=84")
	dw_1.Modify("DataWindow.header.Height=116")

else
	dw_1.Modify("DataWindow.header.1.Height=0")
	dw_1.Modify("DataWindow.header.Height=188")
end if

end event

type cbx_no_righe from checkbox within w_st_lista_documenti
integer x = 1057
integer y = 128
integer width = 505
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
string text = "No righe"
end type

event clicked;if checked then
	dw_1.object.datawindow.detail.height.autosize='no'
else
	dw_1.object.datawindow.detail.height.autosize='yes'
end if
end event

type cbx_ordina_prog from checkbox within w_st_lista_documenti
integer x = 1408
integer y = 128
integer width = 592
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
string text = "Ordina per N. Prog."
end type

event clicked;if checked then
	dw_1.setsort("doc_doc_num_prog")
	dw_1.sort()
else
	dw_1.SetSort("doc_doc_data, doc_doc_numero")
	dw_1.sort()
end if


end event

