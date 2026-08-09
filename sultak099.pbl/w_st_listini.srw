forward
global type w_st_listini from w_stampa
end type
end forward

global type w_st_listini from w_stampa
end type
global w_st_listini w_st_listini

type variables
s_sel_stampa is_sel
end variables

event open;call super::open;is_sel=message.powerobjectparm

dw_1.dataobject=is_sel.s_tipo_stampa
dw_1.settransobject(sqlca)

dw_1.retrieve(is_sel.s_id_magazzino)

end event

on w_st_listini.create
call super::create
end on

on w_st_listini.destroy
call super::destroy
end on

type cb_preview from w_stampa`cb_preview within w_st_listini
integer x = 1934
end type

type dw_1 from w_stampa`dw_1 within w_st_listini
string dataobject = "d_listini"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i

ls_sql=sqlsyntax
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

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_listini
integer x = 2341
end type

type pb_stampa from w_stampa`pb_stampa within w_st_listini
integer x = 2130
end type

type sle_pg from w_stampa`sle_pg within w_st_listini
end type

type st_1 from w_stampa`st_1 within w_st_listini
end type

type st_2 from w_stampa`st_2 within w_st_listini
end type

type sle_copie from w_stampa`sle_copie within w_st_listini
end type

type sle_zoom from w_stampa`sle_zoom within w_st_listini
end type

type cb_7 from w_stampa`cb_7 within w_st_listini
end type

type cb_6 from w_stampa`cb_6 within w_st_listini
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_listini
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_listini
end type

type cb_esci from w_stampa`cb_esci within w_st_listini
end type

