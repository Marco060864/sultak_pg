forward
global type w_pnota_st from w_stampa
end type
end forward

global type w_pnota_st from w_stampa
integer width = 3538
end type
global w_pnota_st w_pnota_st

on w_pnota_st.create
call super::create
end on

on w_pnota_st.destroy
call super::destroy
end on

event open;call super::open;UDW_001 LDW
decimal ldc_tot_entrate, ldc_tot_uscite

dw_1.settransobject(sqlca)
LDW=MESSAGE.POWEROBJECTPARM
LDW.RowsCopy(LDW.GetRow(), LDW.RowCount(), Primary!, dw_1, 1, Primary!)

ldw.setfilter("")
ldw.filter()
ldc_tot_entrate=ldw.getitemdecimal(1, "c_tot_entrate")
ldc_tot_uscite=ldw.getitemdecimal(1, "c_tot_uscite")

dw_1.object.t_entrate.text=string(ldc_tot_entrate, "#,0.00")
dw_1.object.t_uscite.text=string(ldc_tot_uscite, "#,0.00")
dw_1.object.t_saldo.text=string(ldc_tot_entrate - ldc_tot_uscite, "#,0.00")
end event

type cb_preview from w_stampa`cb_preview within w_pnota_st
end type

type dw_1 from w_stampa`dw_1 within w_pnota_st
integer width = 3401
string title = "Stampa Scritture"
string dataobject = "d_pnota_st"
end type

event dw_1::sqlpreview;call super::sqlpreview;//
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_pnota_st
end type

type pb_stampa from w_stampa`pb_stampa within w_pnota_st
end type

type sle_pg from w_stampa`sle_pg within w_pnota_st
end type

type st_1 from w_stampa`st_1 within w_pnota_st
end type

type st_2 from w_stampa`st_2 within w_pnota_st
end type

type sle_copie from w_stampa`sle_copie within w_pnota_st
end type

type sle_zoom from w_stampa`sle_zoom within w_pnota_st
end type

type cb_7 from w_stampa`cb_7 within w_pnota_st
end type

type cb_6 from w_stampa`cb_6 within w_pnota_st
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_pnota_st
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_pnota_st
end type

type cb_esci from w_stampa`cb_esci within w_pnota_st
end type

