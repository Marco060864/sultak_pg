forward
global type w_ins_conto_gd from w_semplice_gd
end type
end forward

global type w_ins_conto_gd from w_semplice_gd
integer width = 3010
end type
global w_ins_conto_gd w_ins_conto_gd

on w_ins_conto_gd.create
call super::create
end on

on w_ins_conto_gd.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_ins_conto_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_ins_conto_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_ins_conto_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_ins_conto_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_ins_conto_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_ins_conto_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_ins_conto_gd
integer width = 2889
string dataobject = "d_conto_contabilita_gd"
end type

event dw_1::itemchanged;call super::itemchanged;string ls_row, ls_cod1, ls_cod2
long ll_id_sottomastro
integer i, li_len

if dwo.name="sottomastro_id" then
	ll_id_sottomastro=long(data)
	select m.mastro_codice+s.sottomastro_codice
	into :ls_cod1
	from dba.mastro m, dba.sottomastro s
	where m.mastro_id=s.mastro_id
	and sottomastro_id=:ll_id_sottomastro;
	
	//ls_row=string(row)
	
	//ls_cod1=dw_1.describe("Evaluate('lookupdisplay(sottomastro_id) '," +ls_row+")")
	select max(conto_codice)
	into :ls_cod2
	from dba.conto
	where left(conto_codice, 4)= :ls_cod1
	;
	ls_cod2=right(ls_cod2, 4)
	ls_cod2=string(integer(ls_cod2)+1)
	if isnull(ls_cod2) or ls_cod2="" then ls_cod2= "0001"
	li_len=len(ls_cod2)
	for i = 1 to 4 - li_len
		ls_cod2="0"+ls_cod2
	next
	dw_1.setitem(row, "conto_codice", ls_cod1+ls_cod2)
end if
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_ins_conto_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_ins_conto_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_ins_conto_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_ins_conto_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_ins_conto_gd
end type

