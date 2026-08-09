forward
global type w_st_scheda_magazzino from w_stampa
end type
type cbx_doc from checkbox within w_st_scheda_magazzino
end type
type cbx_totali from checkbox within w_st_scheda_magazzino
end type
type st_3 from statictext within w_st_scheda_magazzino
end type
type cbx_righe from checkbox within w_st_scheda_magazzino
end type
type cbx_solo_doc from checkbox within w_st_scheda_magazzino
end type
type dw_2 from udw_000 within w_st_scheda_magazzino
end type
end forward

global type w_st_scheda_magazzino from w_stampa
integer x = 22
integer y = 13
integer height = 1900
cbx_doc cbx_doc
cbx_totali cbx_totali
st_3 st_3
cbx_righe cbx_righe
cbx_solo_doc cbx_solo_doc
dw_2 dw_2
end type
global w_st_scheda_magazzino w_st_scheda_magazzino

type variables
s_sel_stampa is_sel

end variables

on w_st_scheda_magazzino.create
int iCurrent
call super::create
this.cbx_doc=create cbx_doc
this.cbx_totali=create cbx_totali
this.st_3=create st_3
this.cbx_righe=create cbx_righe
this.cbx_solo_doc=create cbx_solo_doc
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_doc
this.Control[iCurrent+2]=this.cbx_totali
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.cbx_righe
this.Control[iCurrent+5]=this.cbx_solo_doc
this.Control[iCurrent+6]=this.dw_2
end on

on w_st_scheda_magazzino.destroy
call super::destroy
destroy(this.cbx_doc)
destroy(this.cbx_totali)
destroy(this.st_3)
destroy(this.cbx_righe)
destroy(this.cbx_solo_doc)
destroy(this.dw_2)
end on

event open;call super::open;date ld_data_inizio

is_sel=message.powerobjectparm

dw_1.dataobject=is_sel.s_tipo_stampa
dw_1.settransobject(sqlca)
if is_sel.s_tipo_stampa="d_st_scheda_magazzino_negozio" then
	cbx_doc.visible=false
	cbx_totali.visible=false
	cbx_righe.visible=true
else
	//cbx_righe.visible=false
end if
dw_1.retrieve(is_sel.s_da_data, is_sel.s_a_data, is_sel.s_data_inizio)

dw_2.settransobject(sqlca)
dw_2.insertrow(1)
end event

event close;call super::close;if isvalid(w_doc_ff) then
	close(w_doc_ff)
end if
end event

type pb_1 from w_stampa`pb_1 within w_st_scheda_magazzino
integer x = 2738
end type

type cb_preview from w_stampa`cb_preview within w_st_scheda_magazzino
integer x = 2144
integer y = 20
integer taborder = 100
end type

type dw_1 from w_stampa`dw_1 within w_st_scheda_magazzino
integer y = 208
integer height = 1564
integer taborder = 160
string dataobject = "d_st_scheda_magazzino"
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
if is_sel.fiscale="S" then
	ls_sql+= " and (dba.causale.caus_fiscale='S')"
end if
if is_sel.cat_codifica>0 then
	ls_sql+= ' and ("dba"."art"."art_id_codifica"='+string(is_sel.cat_codifica)+')'
end if

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

event dw_1::rbuttondown;call super::rbuttondown;if object.c_dati_doc.visible="1" then 
	object.c_dati_doc.visible="if( doc_doc_data >= da_data, 1, 0) "
	object.datawindow.detail.height.autosize='yes'
else
	object.c_dati_doc.visible="1" 
	object.datawindow.detail.height.autosize='yes'
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_scheda_magazzino
integer x = 2551
integer y = 20
end type

type pb_stampa from w_stampa`pb_stampa within w_st_scheda_magazzino
integer x = 2341
integer y = 20
integer taborder = 130
end type

type sle_pg from w_stampa`sle_pg within w_st_scheda_magazzino
integer x = 1042
integer taborder = 70
end type

type st_1 from w_stampa`st_1 within w_st_scheda_magazzino
integer x = 763
end type

type st_2 from w_stampa`st_2 within w_st_scheda_magazzino
integer taborder = 30
end type

type sle_copie from w_stampa`sle_copie within w_st_scheda_magazzino
integer taborder = 40
end type

type sle_zoom from w_stampa`sle_zoom within w_st_scheda_magazzino
integer x = 430
integer taborder = 60
end type

type cb_7 from w_stampa`cb_7 within w_st_scheda_magazzino
integer x = 293
integer taborder = 50
end type

type cb_6 from w_stampa`cb_6 within w_st_scheda_magazzino
integer x = 585
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_scheda_magazzino
integer taborder = 20
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_scheda_magazzino
integer taborder = 10
end type

type cb_esci from w_stampa`cb_esci within w_st_scheda_magazzino
end type

type cbx_doc from checkbox within w_st_scheda_magazzino
integer x = 41
integer y = 128
integer width = 503
integer height = 80
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Doc."
end type

event clicked;if checked then
	dw_1.Modify("DataWindow.header.2.Height=124")
else
	dw_1.Modify("DataWindow.header.2.Height=0")
end if
end event

type cbx_totali from checkbox within w_st_scheda_magazzino
integer x = 407
integer y = 128
integer width = 384
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

type st_3 from statictext within w_st_scheda_magazzino
integer x = 1586
integer y = 140
integer width = 1815
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217857
long backcolor = 67108864
string text = "Per Informazioni Documenti tasto destro del mouse dentro la finestra!"
boolean focusrectangle = false
end type

type cbx_righe from checkbox within w_st_scheda_magazzino
integer x = 786
integer y = 128
integer width = 389
integer height = 80
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Righe"
end type

event clicked;if checked then
	dw_1.Modify("DataWindow.detail.Height=92")
	//cbx_solo_doc.checked=false
	//dw_1.Modify("DataWindow.header.1.Height=72")
else
	dw_1.Modify("DataWindow.detail.Height=0")

	//dw_1.Modify("DataWindow.header.1.Height=0")
end if
end event

type cbx_solo_doc from checkbox within w_st_scheda_magazzino
integer x = 1179
integer y = 128
integer width = 485
integer height = 80
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Solo DOC"
end type

event clicked;if checked then
	dw_1.Modify("DataWindow.detail.Height=0")
	dw_1.Modify("DataWindow.trailer.2.Height=80")
//	cbx_righe.checked=false
else
	//dw_1.Modify("DataWindow.detail.Height=92")
//	cbx_righe.checked=true
	dw_1.Modify("DataWindow.trailer.2.Height=0")
	//dw_1.Modify("DataWindow.header.1.Height=0")
end if
end event

type dw_2 from udw_000 within w_st_scheda_magazzino
integer x = 1445
integer y = 28
integer width = 439
integer height = 80
integer taborder = 23
boolean bringtotop = true
string dataobject = "d_ext_codifica"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;


if data> "0" then
	is_sel.cat_codifica=long(data)
	dw_1.retrieve(is_sel.s_da_data, is_sel.s_a_data, is_sel.s_data_inizio)
end if
end event

