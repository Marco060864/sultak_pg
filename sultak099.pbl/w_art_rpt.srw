forward
global type w_art_rpt from w_stampa
end type
end forward

global type w_art_rpt from w_stampa
integer width = 3562
integer height = 2058
end type
global w_art_rpt w_art_rpt

type variables
string is_sql
end variables

on w_art_rpt.create
call super::create
end on

on w_art_rpt.destroy
call super::destroy
end on

event open;call super::open;s_sel_stampa s_stampa

s_stampa=message.powerobjectparm
if s_stampa.s_tipo_stampa="LISTA" then
	is_sql= "WHERE art_codice>='"+string(s_stampa.da_articolo)+ "' " 
	is_sql += "and art_codice<='"+string(s_stampa.ad_articolo)+ "' " 
	dw_1.settransobject(sqlca)
	dw_1.retrieve()
else
	dw_1.dataobject=s_stampa.s_tipo_stampa
	dw_1.settransobject(sqlca)
	dw_1.retrieve(s_stampa.s_a_data)
end if


end event

type pb_1 from w_stampa`pb_1 within w_art_rpt
integer x = 2714
end type

type cb_preview from w_stampa`cb_preview within w_art_rpt
integer x = 2121
end type

type dw_1 from w_stampa`dw_1 within w_art_rpt
string dataobject = "d_art_rpt"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
long ll_pos

if parent.is_sql>" " and sqltype=PreviewSelect! then

	ls_sql=sqlsyntax
	
	
	ls_sql+=parent.is_sql
	//messagebox("S", ls_sql)
	setsqlpreview(ls_sql)

end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_art_rpt
integer x = 2527
end type

type pb_stampa from w_stampa`pb_stampa within w_art_rpt
integer x = 2319
end type

type sle_pg from w_stampa`sle_pg within w_art_rpt
end type

type st_1 from w_stampa`st_1 within w_art_rpt
end type

type st_2 from w_stampa`st_2 within w_art_rpt
end type

type sle_copie from w_stampa`sle_copie within w_art_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_art_rpt
end type

type cb_7 from w_stampa`cb_7 within w_art_rpt
end type

type cb_6 from w_stampa`cb_6 within w_art_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_art_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_art_rpt
end type

type cb_esci from w_stampa`cb_esci within w_art_rpt
end type

