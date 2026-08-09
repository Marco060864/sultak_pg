forward
global type w_mastrino_rpt from w_stampa
end type
end forward

global type w_mastrino_rpt from w_stampa
integer x = 23
integer y = 12
integer width = 3694
end type
global w_mastrino_rpt w_mastrino_rpt

type variables
s_sel_stampa isl_stampa
end variables

on w_mastrino_rpt.create
call super::create
end on

on w_mastrino_rpt.destroy
call super::destroy
end on

event open;call super::open;

isl_stampa=message.powerobjectparm

dw_1.settransobject(sqlca)



dw_1.retrieve(isl_stampa.s_da_data, isl_stampa.s_a_data)
end event

type pb_1 from w_stampa`pb_1 within w_mastrino_rpt
end type

type cb_preview from w_stampa`cb_preview within w_mastrino_rpt
end type

type dw_1 from w_stampa`dw_1 within w_mastrino_rpt
integer width = 3562
string title = "Registri IVA"
string dataobject = "d_mastrini_rpt"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql

if isl_stampa.s_cl_fo> " " then
	ls_sql=sqlsyntax
	//applico
	ls_sql+=" and (dba.conto.conto_codice= '"+ isl_stampa.s_cl_fo+"')"
	if setsqlpreview(ls_sql) <> 1 then messagebox("Errore!", "Filtro non applicato!")
end if

end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_mastrino_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_mastrino_rpt
end type

type sle_pg from w_stampa`sle_pg within w_mastrino_rpt
end type

type st_1 from w_stampa`st_1 within w_mastrino_rpt
end type

type st_2 from w_stampa`st_2 within w_mastrino_rpt
end type

type sle_copie from w_stampa`sle_copie within w_mastrino_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_mastrino_rpt
end type

type cb_7 from w_stampa`cb_7 within w_mastrino_rpt
end type

type cb_6 from w_stampa`cb_6 within w_mastrino_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_mastrino_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_mastrino_rpt
end type

type cb_esci from w_stampa`cb_esci within w_mastrino_rpt
end type

