forward
global type w_distinta_ff from w_ra_padre_figlio_cx
end type
end forward

global type w_distinta_ff from w_ra_padre_figlio_cx
integer width = 3017
integer height = 2072
end type
global w_distinta_ff w_distinta_ff

on w_distinta_ff.create
call super::create
end on

on w_distinta_ff.destroy
call super::destroy
end on

type cb_ricerca from w_ra_padre_figlio_cx`cb_ricerca within w_distinta_ff
integer x = 955
integer y = 1848
end type

event cb_ricerca::clicked;s_ricerca s_ric
w_new_ricerca_sw w_ric_sw

s_ric.dataobject='d_distinta_sw'
s_ric.titolo_finestra="Ricerca Distinta"

openwithparm(w_ric_sw, s_ric)

Super::EVENT Clicked()
end event

type dw_1 from w_ra_padre_figlio_cx`dw_1 within w_distinta_ff
integer x = 50
integer y = 56
integer width = 2798
integer height = 584
string dataobject = "d_distinta_ff"
end type

event dw_1::itemchanged;call super::itemchanged;long ll_id_art
string  ls_cod, ls_des
s_distinta_mag s_dis

if dwo.name='art_id' then
	ll_id_art=long(data)
	if ll_id_art>0 then
		select art_codice, art_descrizione into :ls_cod, :ls_des
		from dba.art where art_id=:ll_id_art
		;
		setitem(row, "descrizione",ls_des)
		setitem(row, "codice",ls_cod)
	end if
	
end if

if dwo.name='c_qta' then
	s_dis.id_distinta=getitemnumber(1, "distinta_id")
	s_dis.qta=long(data)
	s_dis.nota=getitemstring(1, "nota")
	openwithparm(w_st_scheda_lav, s_dis)
	
end if
end event

type dw_2 from w_ra_padre_figlio_cx`dw_2 within w_distinta_ff
integer x = 50
integer y = 676
integer width = 2798
integer height = 1132
string dataobject = "d_riga_distinta_tb"
boolean vscrollbar = true
end type

type cb_inserisci from w_ra_padre_figlio_cx`cb_inserisci within w_distinta_ff
integer x = 78
integer y = 1848
end type

type cb_salva from w_ra_padre_figlio_cx`cb_salva within w_distinta_ff
integer x = 366
integer y = 1848
end type

type cb_cancella from w_ra_padre_figlio_cx`cb_cancella within w_distinta_ff
integer x = 654
integer y = 1848
end type

type cb_annulla from w_ra_padre_figlio_cx`cb_annulla within w_distinta_ff
integer x = 1248
integer y = 1844
end type

type cb_ok from w_ra_padre_figlio_cx`cb_ok within w_distinta_ff
integer x = 1541
integer y = 1848
end type

