forward
global type w_st_visite from w_stampa
end type
type cbx_1 from checkbox within w_st_visite
end type
type cbx_2 from checkbox within w_st_visite
end type
end forward

global type w_st_visite from w_stampa
integer height = 1896
cbx_1 cbx_1
cbx_2 cbx_2
end type
global w_st_visite w_st_visite

type variables
s_sel_stampa is_sel
end variables

on w_st_visite.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_2
end on

on w_st_visite.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_2)
end on

event open;call super::open;date ld_data_inizio

is_sel=message.powerobjectparm

//dw_1.dataobject=is_sel.s_tipo_stampa
dw_1.settransobject(sqlca)
if isnull(is_sel.s_evasi_no_tutti) then is_sel.s_evasi_no_tutti='T'

dw_1.retrieve(is_sel.s_da_data,is_sel.s_a_data,is_sel.s_evasi_no_tutti)
end event

event close;call super::close;if isvalid(w_doc_ff) then
	close(w_doc_ff)
end if
end event

type pb_1 from w_stampa`pb_1 within w_st_visite
integer x = 2789
integer y = 20
end type

type cb_preview from w_stampa`cb_preview within w_st_visite
integer x = 2176
integer y = 20
integer taborder = 110
end type

type dw_1 from w_stampa`dw_1 within w_st_visite
integer y = 208
integer height = 1560
integer taborder = 170
string dataobject = "d_st_visite"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i
ls_sql=sqlsyntax

if is_sel.s_cl_fo>"" then
	ls_sql+= ' and ("dba"."conto"."conto_codice"='+"'"+is_sel.s_cl_fo+"')"
	
end if

if is_sel.s_evasi_no_tutti <>"T" then
	ls_sql+= ' and ("dba"."visite"."visite_riscosso"='+"'"+is_sel.s_evasi_no_tutti+"')"
	
end if


if is_sel.s_da_data> date('1900-01-01') then
	ls_sql+=" and (dba.visite.visite_data >= '"+ string(is_sel.s_da_data, "yyyy-mm-dd")+"') "
	if isnull(is_sel.s_a_data) then
		is_sel.s_a_data=date("2099-01-01")
	end if
	ls_sql+=" and (dba.visite.visite_data <= '"+string(is_sel.s_a_data,"yyyy-mm-dd" )+"') "
	
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

event dw_1::rbuttondown;call super::rbuttondown;if object.c_dati_doc.visible="1" then 
	object.c_dati_doc.visible="0"
else
	object.c_dati_doc.visible="1" 
end if

	
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_visite
integer x = 2583
integer y = 20
integer taborder = 120
end type

type pb_stampa from w_stampa`pb_stampa within w_st_visite
integer x = 2373
integer y = 20
integer taborder = 140
end type

type sle_pg from w_stampa`sle_pg within w_st_visite
integer taborder = 90
end type

type st_1 from w_stampa`st_1 within w_st_visite
integer taborder = 80
end type

type st_2 from w_stampa`st_2 within w_st_visite
integer taborder = 30
end type

type sle_copie from w_stampa`sle_copie within w_st_visite
integer taborder = 40
end type

type sle_zoom from w_stampa`sle_zoom within w_st_visite
integer taborder = 60
end type

type cb_7 from w_stampa`cb_7 within w_st_visite
integer taborder = 50
end type

type cb_6 from w_stampa`cb_6 within w_st_visite
integer taborder = 70
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_visite
integer taborder = 20
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_visite
integer taborder = 10
end type

type cb_esci from w_stampa`cb_esci within w_st_visite
end type

type cbx_1 from checkbox within w_st_visite
boolean visible = false
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

event clicked;if checked then
	dw_1.Modify("DataWindow.Trailer.3.Height=124")
else
	dw_1.Modify("DataWindow.Trailer.3.Height=0")
end if
end event

type cbx_2 from checkbox within w_st_visite
boolean visible = false
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

