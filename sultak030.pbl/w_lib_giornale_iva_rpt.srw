forward
global type w_lib_giornale_iva_rpt from w_stampa
end type
end forward

global type w_lib_giornale_iva_rpt from w_stampa
integer x = 23
integer y = 12
end type
global w_lib_giornale_iva_rpt w_lib_giornale_iva_rpt

on w_lib_giornale_iva_rpt.create
call super::create
end on

on w_lib_giornale_iva_rpt.destroy
call super::destroy
end on

event open;call super::open;s_sel_stampa sl_stampa

sl_stampa=message.powerobjectparm

dw_1.settransobject(sqlca)

dw_1.retrieve(sl_stampa.s_da_data, sl_stampa.s_a_data, sl_stampa.s_id_magazzino)
end event

type pb_1 from w_stampa`pb_1 within w_lib_giornale_iva_rpt
end type

type cb_preview from w_stampa`cb_preview within w_lib_giornale_iva_rpt
end type

type dw_1 from w_stampa`dw_1 within w_lib_giornale_iva_rpt
string title = "Registri IVA"
string dataobject = "d_libro_giornale_rpt"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_lib_giornale_iva_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_lib_giornale_iva_rpt
end type

type sle_pg from w_stampa`sle_pg within w_lib_giornale_iva_rpt
end type

type st_1 from w_stampa`st_1 within w_lib_giornale_iva_rpt
end type

type st_2 from w_stampa`st_2 within w_lib_giornale_iva_rpt
end type

type sle_copie from w_stampa`sle_copie within w_lib_giornale_iva_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_lib_giornale_iva_rpt
end type

type cb_7 from w_stampa`cb_7 within w_lib_giornale_iva_rpt
end type

type cb_6 from w_stampa`cb_6 within w_lib_giornale_iva_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_lib_giornale_iva_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_lib_giornale_iva_rpt
end type

type cb_esci from w_stampa`cb_esci within w_lib_giornale_iva_rpt
end type

