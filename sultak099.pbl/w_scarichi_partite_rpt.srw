forward
global type w_scarichi_partite_rpt from w_stampa
end type
end forward

global type w_scarichi_partite_rpt from w_stampa
integer x = 22
integer y = 13
integer width = 4338
end type
global w_scarichi_partite_rpt w_scarichi_partite_rpt

on w_scarichi_partite_rpt.create
call super::create
end on

on w_scarichi_partite_rpt.destroy
call super::destroy
end on

event open;call super::open;s_st_doc s_doc
date ldt_a_data

s_doc=message.powerobjectparm

ldt_a_data=date(string(year(s_doc.dt_inizio_esercizio))+"/12/31")

dw_1.settransobject(sqlca)
dw_1.retrieve(s_doc.sl_id_doc, s_doc.dt_inizio_esercizio, ldt_a_data)


end event

type pb_1 from w_stampa`pb_1 within w_scarichi_partite_rpt
end type

type cb_preview from w_stampa`cb_preview within w_scarichi_partite_rpt
end type

type dw_1 from w_stampa`dw_1 within w_scarichi_partite_rpt
integer width = 4197
string dataobject = "d_scarico_partite_rpt"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_scarichi_partite_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_scarichi_partite_rpt
end type

type sle_pg from w_stampa`sle_pg within w_scarichi_partite_rpt
end type

type st_1 from w_stampa`st_1 within w_scarichi_partite_rpt
end type

type st_2 from w_stampa`st_2 within w_scarichi_partite_rpt
end type

type sle_copie from w_stampa`sle_copie within w_scarichi_partite_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_scarichi_partite_rpt
end type

type cb_7 from w_stampa`cb_7 within w_scarichi_partite_rpt
end type

type cb_6 from w_stampa`cb_6 within w_scarichi_partite_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_scarichi_partite_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_scarichi_partite_rpt
end type

type cb_esci from w_stampa`cb_esci within w_scarichi_partite_rpt
end type

