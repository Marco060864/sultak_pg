forward
global type w_anag_clfo from w_stampa
end type
end forward

global type w_anag_clfo from w_stampa
integer x = 22
integer y = 13
end type
global w_anag_clfo w_anag_clfo

type variables
string is_sql
end variables

on w_anag_clfo.create
call super::create
end on

on w_anag_clfo.destroy
call super::destroy
end on

event open;call super::open;s_sel_stampa s_stampa
string ls_filtro

s_stampa=message.powerobjectparm
is_sql=""
is_sql= "WHERE ana.ana_rag_sociale>='"+string(s_stampa.da_articolo)+ "' " 
is_sql += "and ana.ana_rag_sociale<='"+string(s_stampa.ad_articolo)+ "' " 

dw_1.settransobject(sqlca)
dw_1.retrieve()

if s_stampa.s_tipo_stampa="C"  then
	ls_filtro="pos(c_tipo_conto, 'C')>0"
elseif  s_stampa.s_tipo_stampa="F"  then
		ls_filtro="pos(c_tipo_conto, 'F')>0"
else
	ls_filtro=""
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

type pb_1 from w_stampa`pb_1 within w_anag_clfo
integer x = 2747
end type

type cb_preview from w_stampa`cb_preview within w_anag_clfo
integer x = 2144
end type

type dw_1 from w_stampa`dw_1 within w_anag_clfo
string dataobject = "d_anag_clfo"
end type

event dw_1::sqlpreview;call super::sqlpreview;//inserire qui
string ls_sql
long ll_pos

if parent.is_sql>" " and sqltype=PreviewSelect! then

	ls_sql=sqlsyntax
	
	
	ls_sql+=parent.is_sql
	//messagebox("S", ls_sql)
	setsqlpreview(ls_sql)

end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_anag_clfo
integer x = 2551
end type

type pb_stampa from w_stampa`pb_stampa within w_anag_clfo
integer x = 2341
end type

type sle_pg from w_stampa`sle_pg within w_anag_clfo
end type

type st_1 from w_stampa`st_1 within w_anag_clfo
end type

type st_2 from w_stampa`st_2 within w_anag_clfo
end type

type sle_copie from w_stampa`sle_copie within w_anag_clfo
end type

type sle_zoom from w_stampa`sle_zoom within w_anag_clfo
end type

type cb_7 from w_stampa`cb_7 within w_anag_clfo
end type

type cb_6 from w_stampa`cb_6 within w_anag_clfo
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_anag_clfo
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_anag_clfo
end type

type cb_esci from w_stampa`cb_esci within w_anag_clfo
end type

