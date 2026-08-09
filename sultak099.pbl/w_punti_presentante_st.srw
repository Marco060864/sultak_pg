forward
global type w_punti_presentante_st from w_stampa
end type
end forward

global type w_punti_presentante_st from w_stampa
end type
global w_punti_presentante_st w_punti_presentante_st

type variables
long al_id_conto_presentante
end variables

on w_punti_presentante_st.create
call super::create
end on

on w_punti_presentante_st.destroy
call super::destroy
end on

event open;call super::open;s_sel_stampa ls_dati

ls_dati=message.powerobjectparm
al_id_conto_presentante=ls_dati.id_conto
dw_1.settransobject(sqlca)
dw_1.retrieve(ls_dati.percentuale, ls_dati.s_da_data, ls_dati.s_a_data)
end event

type pb_1 from w_stampa`pb_1 within w_punti_presentante_st
end type

type cb_preview from w_stampa`cb_preview within w_punti_presentante_st
end type

type dw_1 from w_stampa`dw_1 within w_punti_presentante_st
string dataobject = "d_punti_presentante"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql

if al_id_conto_presentante>0 then
	ls_sql=sqlsyntax
	ls_sql+=" and lega_conto_a_presentante.id_conto_presentante= "+&
				 string(al_id_conto_presentante)+" "
	if setsqlpreview(ls_sql) <> 1 then 
		messagebox("Errore!", "Filtro non applicato!")
	end if
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_punti_presentante_st
end type

type pb_stampa from w_stampa`pb_stampa within w_punti_presentante_st
end type

type sle_pg from w_stampa`sle_pg within w_punti_presentante_st
end type

type st_1 from w_stampa`st_1 within w_punti_presentante_st
end type

type st_2 from w_stampa`st_2 within w_punti_presentante_st
end type

type sle_copie from w_stampa`sle_copie within w_punti_presentante_st
end type

type sle_zoom from w_stampa`sle_zoom within w_punti_presentante_st
end type

type cb_7 from w_stampa`cb_7 within w_punti_presentante_st
end type

type cb_6 from w_stampa`cb_6 within w_punti_presentante_st
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_punti_presentante_st
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_punti_presentante_st
end type

type cb_esci from w_stampa`cb_esci within w_punti_presentante_st
end type

