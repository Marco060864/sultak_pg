forward
global type w_st_scheda_cl_fo from w_stampa
end type
type cbx_1 from checkbox within w_st_scheda_cl_fo
end type
type cbx_2 from checkbox within w_st_scheda_cl_fo
end type
type cbx_vedi_tot_doc from checkbox within w_st_scheda_cl_fo
end type
type cbx_vedi_righe from checkbox within w_st_scheda_cl_fo
end type
end forward

global type w_st_scheda_cl_fo from w_stampa
integer width = 3890
integer height = 1900
cbx_1 cbx_1
cbx_2 cbx_2
cbx_vedi_tot_doc cbx_vedi_tot_doc
cbx_vedi_righe cbx_vedi_righe
end type
global w_st_scheda_cl_fo w_st_scheda_cl_fo

type variables
s_sel_stampa is_sel
end variables

on w_st_scheda_cl_fo.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_vedi_tot_doc=create cbx_vedi_tot_doc
this.cbx_vedi_righe=create cbx_vedi_righe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_2
this.Control[iCurrent+3]=this.cbx_vedi_tot_doc
this.Control[iCurrent+4]=this.cbx_vedi_righe
end on

on w_st_scheda_cl_fo.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_vedi_tot_doc)
destroy(this.cbx_vedi_righe)
end on

event open;call super::open;date ld_data_inizio

is_sel=message.powerobjectparm

dw_1.dataobject=is_sel.s_tipo_stampa
dw_1.settransobject(sqlca)

dw_1.retrieve(is_sel.s_da_data, is_sel.s_a_data, is_sel.s_data_inizio)
end event

type pb_1 from w_stampa`pb_1 within w_st_scheda_cl_fo
integer x = 2784
integer y = 20
string text = ""
end type

type cb_preview from w_stampa`cb_preview within w_st_scheda_cl_fo
integer x = 2176
integer y = 20
integer taborder = 110
end type

type dw_1 from w_stampa`dw_1 within w_st_scheda_cl_fo
integer y = 208
integer width = 3698
integer height = 1564
integer taborder = 170
string dataobject = "d_st_scheda_cl_fo"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i
ls_sql=sqlsyntax

if is_sel.s_cl_fo>"" then
	ls_sql+= ' and ("dba"."conto"."conto_codice"='+"'"+is_sel.s_cl_fo+"')"
	
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
if is_sel.s_id_metallo>0 then
	ls_sql+= " and (dba.metallo.met_id="+string(is_sel.s_id_metallo)+") "
end if
if is_sel.s_id_titolo>0 then
	ls_sql+= " and (dba.rdoc.tit_id="+string(is_sel.s_id_titolo)+") "
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

event dw_1::rbuttondown;call super::rbuttondown;string ls_test,ls_test2

ls_test=describe("c_dati_doc.visible")
if ls_test="0" then
	ls_test2=describe("c_f_n.visible")
	modify("c_dati_doc.visible= "+ls_test2)
else
	object.c_dati_doc.visible="0"	
end if 



//if object.c_dati_doc.visible="1" then 
//	object.c_dati_doc.visible="0"
//else
////	object.c_dati_doc.visible=" '1 ~t if( doc_doc_data >= da_data, 1, 0)' " 
//	modify("c_dati_doc.visible= '1 ~t If(doc_doc_data>=~~'da_data~~',1,0)'")
//end if

	
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_scheda_cl_fo
integer x = 2583
integer y = 20
integer taborder = 120
end type

type pb_stampa from w_stampa`pb_stampa within w_st_scheda_cl_fo
integer x = 2373
integer y = 20
integer taborder = 140
end type

type sle_pg from w_stampa`sle_pg within w_st_scheda_cl_fo
integer taborder = 90
end type

type st_1 from w_stampa`st_1 within w_st_scheda_cl_fo
integer taborder = 80
end type

type st_2 from w_stampa`st_2 within w_st_scheda_cl_fo
integer taborder = 30
end type

type sle_copie from w_stampa`sle_copie within w_st_scheda_cl_fo
integer taborder = 40
end type

type sle_zoom from w_stampa`sle_zoom within w_st_scheda_cl_fo
integer taborder = 60
end type

type cb_7 from w_stampa`cb_7 within w_st_scheda_cl_fo
integer taborder = 50
end type

type cb_6 from w_stampa`cb_6 within w_st_scheda_cl_fo
integer taborder = 70
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_scheda_cl_fo
integer taborder = 20
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_scheda_cl_fo
integer taborder = 10
end type

type cb_esci from w_stampa`cb_esci within w_st_scheda_cl_fo
end type

type cbx_1 from checkbox within w_st_scheda_cl_fo
integer x = 41
integer y = 128
integer width = 503
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
string text = "Vedi Documenti"
end type

event clicked;//if checked then
//	dw_1.Modify("DataWindow.Trailer.3.Height=124")
//else
//	dw_1.Modify("DataWindow.Trailer.3.Height=0")
//end if

string ls_test,ls_test2

ls_test=dw_1.describe("c_dati_doc.visible")
if ls_test="0" then
	ls_test2=dw_1.describe("c_f_n.visible")
	dw_1.modify("c_dati_doc.visible= "+ls_test2)
else
	dw_1.object.c_dati_doc.visible="0"	
end if 
end event

type cbx_2 from checkbox within w_st_scheda_cl_fo
integer x = 581
integer y = 128
integer width = 503
integer height = 80
integer taborder = 160
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
	dw_1.Modify("DataWindow.Trailer.2.Height=396")
else
	dw_1.Modify("DataWindow.Trailer.2.Height=0")
end if
end event

type cbx_vedi_tot_doc from checkbox within w_st_scheda_cl_fo
integer x = 1019
integer y = 124
integer width = 503
integer height = 80
integer taborder = 160
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Tot. Doc."
end type

event clicked;if checked then
	dw_1.Modify("DataWindow.Trailer.3.Height.autosize=yes")
else
	dw_1.Modify("DataWindow.Trailer.3.Height.autosize=no")
	dw_1.Modify("DataWindow.Trailer.3.Height=0")
end if
end event

type cbx_vedi_righe from checkbox within w_st_scheda_cl_fo
integer x = 1536
integer y = 124
integer width = 503
integer height = 80
integer taborder = 160
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
boolean checked = true
end type

event clicked;if checked then
	dw_1.Modify("DataWindow.detail.Height.autosize=yes")

else
	dw_1.Modify("DataWindow.detail.Height.autosize=no")
	dw_1.Modify("DataWindow.detail.Height=0")


end if
end event

