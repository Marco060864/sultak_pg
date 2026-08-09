forward
global type w_carica_art_csv from w_semplice_gd
end type
end forward

global type w_carica_art_csv from w_semplice_gd
integer width = 4645
end type
global w_carica_art_csv w_carica_art_csv

on w_carica_art_csv.create
call super::create
end on

on w_carica_art_csv.destroy
call super::destroy
end on

event open;dw_1.settransobject(sqlca)
//dw_1.retrieve()
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_carica_art_csv
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_carica_art_csv
integer width = 247
string text = "Imp. CSV"
end type

event cb_ricerca::clicked;//

dw_1.importfile(TEXT!, "c:\sultak\imp\art_txt.txt", 2, 100000)

//dw_employee.ImportFile(XML!,"D:\TMP\EMPLOYEE.XML", 1, 200, 0, 0, 5)
end event

type cb_primo from w_semplice_gd`cb_primo within w_carica_art_csv
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_carica_art_csv
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_carica_art_csv
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_carica_art_csv
end type

type dw_1 from w_semplice_gd`dw_1 within w_carica_art_csv
integer x = 14
integer y = 40
integer width = 4489
integer height = 920
string title = "w_carica_art_csv"
string dataobject = "d_imp_art_csv"
boolean hscrollbar = true
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_carica_art_csv
end type

type cb_salva from w_semplice_gd`cb_salva within w_carica_art_csv
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_carica_art_csv
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_carica_art_csv
string text = "Prepara"
end type

event cb_annulla::clicked;long i, ll_id_titolo, ll_null, ll_id_codifica
string ls_metallo
decimal ldc_titolo

setnull(ll_null)

select first(id_cat_codifica) into :ll_id_codifica from dba.codifica;

for i= 1 to dw_1.rowcount()
	ls_metallo=dw_1.getitemstring(i, "metallo")
	ldc_titolo=dw_1.getitemnumber(i, "art_tit_preferenziale")
	select tit_id into :ll_id_titolo
	from dba.metallo m, dba.titolo t where m.met_id=tit_met_id
	and met_metallo=:ls_metallo and tit_titolo=:ldc_titolo
	;
	if ll_id_titolo> 0 then
		dw_1.setitem(i, "art_tit_preferenziale",ll_id_titolo )
	else
		dw_1.setitem(i, "art_tit_preferenziale",ll_null )
	end if
	dw_1.setitem(i, "art_id_codifica", ll_id_codifica )
	dw_1.setitem(i, "art_creato", today() )
	dw_1.setitem(i, "art_modificato", today() )
	dw_1.setitem(i, "barcode",ll_null )
next
end event

type cb_ok from w_semplice_gd`cb_ok within w_carica_art_csv
end type

