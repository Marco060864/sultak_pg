forward
global type w_st_documenti from w_stampa
end type
type dw_2 from udw_000 within w_st_documenti
end type
type cbx_pdf from checkbox within w_st_documenti
end type
end forward

global type w_st_documenti from w_stampa
integer height = 2592
dw_2 dw_2
cbx_pdf cbx_pdf
end type
global w_st_documenti w_st_documenti

type variables
s_sel_stampa is_selezione
end variables

event open;call super::open;integer i
long li_id_doc
string ls_dw_stampa, dwsyntax, ls_path_stampe, ls_num_doc, ls_numero
date ldt_data_doc


dw_2.settransobject(sqlca)

is_selezione=message.powerobjectparm

dw_2.retrieve(is_selezione.s_da_data, is_selezione.s_a_data)


end event

on w_st_documenti.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cbx_pdf=create cbx_pdf
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cbx_pdf
end on

on w_st_documenti.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cbx_pdf)
end on

event resize;//
end event

type pb_1 from w_stampa`pb_1 within w_st_documenti
end type

type cb_preview from w_stampa`cb_preview within w_st_documenti
end type

type dw_1 from w_stampa`dw_1 within w_st_documenti
end type

event dw_1::sqlpreview;call super::sqlpreview;//s_selezione.cat_codifica=dw_1.getitemstring(1, "cl_fo")
//is_selezione.s_tipo_stampa= dw_1.getitemstring(1, "tipo_stampa")
//is_selezione.s_da_data= dw_1.getitemdate(1, "da_data")
//is_selezione.s_a_data= dw_1.getitemdate(1, "a_data")
//is_selezione.s_data_inizio=f_trova_inizio_esercizio(s_selezione.s_da_data)
////is_selezione.s_id_magazzino=dw_1.getitemnumber(1, "per_magazzino")
////is_selezione.s_id_articolo=dw_1.getitemnumber(1, "per_articolo")
////is_selezione.s_id_titolo=dw_1.getitemnumber(1, "per_titolo")
////is_selezione.s_id_metallo=dw_1.getitemnumber(1, "per_metallo")
//is_selezione.s_id_registro=dw_1.getitemnumber(1, "id_registro")
//is_selezione.s_tipo_registro= dw_1.getitemstring(1, "reg_tipo")
//is_selezione.s_evasi_no_tutti=dw_1.getitemstring(1, "evasi_no_tutti")
//
//if dw_1.getitemnumber(1, "per_causale")>0 then
//	is_selezione.s_id_causale[1]=dw_1.getitemnumber(1, "per_causale")
//end if

string ls_sql
integer i

ls_sql=sqlsyntax
//s_selezione.cat_codifica è l'id del conto intestatario del doc
if is_selezione.cat_codifica>0 then
	ls_sql+=" and (dba.doc.conto_id= "+string(is_selezione.cat_codifica)+")"
	
end if

//if is_sel.s_id_magazzino >0 then
//	ls_sql+=" and (dba.magazzino.maga_id= "+string(is_sel.s_id_magazzino)+")"
//end if
//if is_sel.s_id_articolo >0 then
//	ls_sql+=" and (dba.rdoc.rdoc_art_id= "+string(is_sel.s_id_articolo)+")"
//end if
//if is_sel.s_id_titolo >0 then
//	ls_sql+=" and (dba.titolo.tit_id= "+string(is_sel.s_id_titolo)+")"
//end if
//if is_sel.s_id_metallo >0 then
//	ls_sql+=" and (dba.metallo.met_id= "+string(is_sel.s_id_metallo)+")"
//end if
//
//if is_sel.s_tipo_registro >"" then
//	ls_sql+=" and (dba.registro.reg_tipo= '"+is_sel.s_tipo_registro+"')"
//end if
//
//if is_sel.s_id_registro >0 then
//	ls_sql+=" and (dba.registro.reg_id= "+string(is_sel.s_id_registro)+")"
//end if
//
//if is_sel.s_evasi_no_tutti = 'E' then
//	ls_sql+=" and (dba.rdoc.rdoc_peso_evaso >=  dba.rdoc.rdoc_peso) and "+&
//				" (dba.rdoc.rdoc_qta_evasa >=  dba.rdoc.rdoc_qta) "
//			
//end if
//
//if is_sel.s_evasi_no_tutti = 'I' then
//	ls_sql+=" and (dba.rdoc.rdoc_peso_evaso <  dba.rdoc.rdoc_peso) and "+&
//				" (dba.rdoc.rdoc_qta_evasa <  dba.rdoc.rdoc_qta) "
//end if
//
////nuovi filtri 260308
//if is_sel.cat_codifica > 0 then
//	ls_sql+=" and (dba.art.art_id_codifica= "+string(is_sel.cat_codifica)+")"
//end if
//if upperbound(is_sel.s_id_causale[]) > 0 then
//	for i=1 to upperbound(is_sel.s_id_causale[])
//		if i=1 then
//			ls_sql+=" and (dba.rdoc.causale_id= "+string(is_sel.s_id_causale[i])
//		else
//			ls_sql+=" or dba.rdoc.causale_id= "+string(is_sel.s_id_causale[i])
//		end if
//	next
//	ls_sql+=") "
//end if
//if is_sel.da_articolo>"" then
//	ls_sql+=" and (dba.art.art_codice >= '"+ is_sel.da_articolo+"') "
//	if isnull(is_sel.ad_articolo) then
//		is_sel.ad_articolo="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
//	end if
//	ls_sql+=" and (dba.art.art_codice <= '"+ is_sel.ad_articolo+"') "
//	
//end if
//
//
////applico
if ls_sql>sqlsyntax then
	if setsqlpreview(ls_sql) <> 1 then messagebox("Errore!", "Filtro non applicato!")
end if
//
//
//
//
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_documenti
end type

type pb_stampa from w_stampa`pb_stampa within w_st_documenti
end type

event pb_stampa::clicked;integer i
long li_id_doc
string ls_dw_stampa, dwsyntax, ls_path_stampe, ls_num_doc, ls_numero, ls_nome_file
date ldt_data_doc

if not(cbx_pdf.checked) then printsetup()
select dir_stampe
	into :ls_path_stampe
	from dba.val_base;
	if isnull(ls_path_stampe) then 
		ls_path_stampe=''
	elseif ls_path_stampe>'' then
		ls_path_stampe=ls_path_stampe+'\'
	end if
for i=1 to dw_2.rowcount()
	li_id_doc=dw_2.getitemnumber(i, "doc_id")
	ls_numero=dw_2.getitemstring(i, "doc_numero")
	ldt_data_doc=dw_2.getitemdate(i, "doc_data")
	
	select report_stampa
	into :ls_dw_stampa
	from dba.guida g, dba.doc d
	where d.guida_id=g.guida_id
	and doc_id=:li_id_doc
	;
	
	if isnull(ls_dw_stampa) then ls_dw_stampa="d_st_doc"

	
	dwsyntax = LibraryExport(ls_path_stampe+"sultak100.pbl", ls_dw_stampa, ExportDataWindow!)
	IF dwsyntax>"" THEN
		dw_1.create(dwsyntax)
		dw_1.settransobject(sqlca)
		dw_1.retrieve(li_id_doc, is_selezione.s_data_inizio)
		ls_num_doc="Doc_n_"+ls_numero+"_del_"+string(ldt_data_doc, "dd_mm_yy")
		dw_1.Modify("DataWindow.Print.DocumentName='"+ls_num_doc+"'")
		ls_nome_file="c:\sultak\pdf\"+ls_num_doc+".pdf"
		dw_1.Modify("DataWindow.Print.FileName='"+ls_num_doc+"'")
		if cbx_pdf.checked then
			dw_1.Modify ('DataWindow.Printer="Sybase DataWindow PS" ')
			dw_1.Modify("Export.PDF.Method = Distill!")
			dw_1.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
			dw_1.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
			
			dw_1.SaveAs(ls_nome_file, PDF!, FALSE)
		else
			dw_1.print()
		end if
	end if
			
		
	
next


end event

type sle_pg from w_stampa`sle_pg within w_st_documenti
end type

type st_1 from w_stampa`st_1 within w_st_documenti
end type

type st_2 from w_stampa`st_2 within w_st_documenti
end type

type sle_copie from w_stampa`sle_copie within w_st_documenti
end type

type sle_zoom from w_stampa`sle_zoom within w_st_documenti
end type

type cb_7 from w_stampa`cb_7 within w_st_documenti
end type

type cb_6 from w_stampa`cb_6 within w_st_documenti
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_documenti
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_documenti
end type

type cb_esci from w_stampa`cb_esci within w_st_documenti
end type

type dw_2 from udw_000 within w_st_documenti
integer x = 32
integer y = 1596
integer width = 1989
integer height = 860
integer taborder = 18
boolean bringtotop = true
string dataobject = "d_id_doc"
end type

event sqlpreview;call super::sqlpreview;string ls_sql

ls_sql=sqlsyntax

if is_selezione.s_id_registro>0 then
	ls_sql+= ' and ("dba"."doc"."reg_id"='+string(is_selezione.s_id_registro)+')'
	
end if

if  is_selezione.id_conto>0 then
	ls_sql+= ' and ("dba"."doc"."doc_conto_id"='+string(is_selezione.id_conto)+')'
end if
//if is_selezione.s_id_causale[1]>0 then
//	ls_sql+= ' and ("dba"."doc"."conto_id"='+string(is_selezione.s_id_causale[1])+')'
//end if

//applico
if ls_sql>sqlsyntax then
	if setsqlpreview(ls_sql) <> 1 then messagebox("Errore!", "Filtro non applicato!")
end if
	
end event

type cbx_pdf from checkbox within w_st_documenti
integer x = 2720
integer y = 52
integer width = 320
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "PDF"
boolean checked = true
end type

