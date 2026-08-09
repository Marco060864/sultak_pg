forward
global type w_partite_rpt from w_stampa
end type
type cbx_par_chiuse from checkbox within w_partite_rpt
end type
end forward

global type w_partite_rpt from w_stampa
integer width = 3561
cbx_par_chiuse cbx_par_chiuse
end type
global w_partite_rpt w_partite_rpt

on w_partite_rpt.create
int iCurrent
call super::create
this.cbx_par_chiuse=create cbx_par_chiuse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_par_chiuse
end on

on w_partite_rpt.destroy
call super::destroy
destroy(this.cbx_par_chiuse)
end on

event open;call super::open;s_sel_stampa s_st


s_st=message.powerobjectparm
dw_1.settransobject(sqlca)
dw_1.retrieve(s_st.id_conto, s_st.s_da_data, s_st.s_a_data) 
end event

type pb_1 from w_stampa`pb_1 within w_partite_rpt
integer x = 2843
end type

type cb_preview from w_stampa`cb_preview within w_partite_rpt
integer x = 1637
end type

type dw_1 from w_stampa`dw_1 within w_partite_rpt
integer width = 3401
string dataobject = "d_partita_oro_rpt"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean border = false
end type

event dw_1::doubleclicked;s_st_doc s_doc
integer li_anno

if row>0 then
	s_doc.sl_id_doc=getitemnumber(row, "doc_conto_id")
	li_anno=year(getitemdate(row, "doc_doc_data"))
	s_doc.dt_inizio_esercizio=date(string(li_anno)+"/01/01")
	
	openwithparm(w_scarichi_partite_rpt, s_doc)
	
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_partite_rpt
integer x = 2043
end type

type pb_stampa from w_stampa`pb_stampa within w_partite_rpt
integer x = 1833
end type

type sle_pg from w_stampa`sle_pg within w_partite_rpt
integer x = 1312
end type

type st_1 from w_stampa`st_1 within w_partite_rpt
integer x = 1033
end type

type st_2 from w_stampa`st_2 within w_partite_rpt
end type

type sle_copie from w_stampa`sle_copie within w_partite_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_partite_rpt
end type

type cb_7 from w_stampa`cb_7 within w_partite_rpt
end type

type cb_6 from w_stampa`cb_6 within w_partite_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_partite_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_partite_rpt
end type

type cb_esci from w_stampa`cb_esci within w_partite_rpt
end type

type cbx_par_chiuse from checkbox within w_partite_rpt
integer x = 2245
integer y = 44
integer width = 585
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
string text = "Vedi Partite chiuse"
end type

event clicked;IF CHECKED THEN
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.sort()
	dw_1.groupcalc()
else
	dw_1.setfilter(" rdoc_finoecalo >if(isnull(tot_scarico), 0,  tot_scarico )")
	dw_1.filter()
	dw_1.sort()
	dw_1.groupcalc()
end if
end event

