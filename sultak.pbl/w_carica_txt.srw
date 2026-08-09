forward
global type w_carica_txt from w_semplice_gd
end type
type cb_1 from commandbutton within w_carica_txt
end type
end forward

global type w_carica_txt from w_semplice_gd
integer width = 2875
integer height = 1676
cb_1 cb_1
end type
global w_carica_txt w_carica_txt

on w_carica_txt.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_carica_txt.destroy
call super::destroy
destroy(this.cb_1)
end on

event open;call super::open;//dw_1.settransobject(sqlca)
end event

type cb_ricerca from w_semplice_gd`cb_ricerca within w_carica_txt
end type

type cb_primo from w_semplice_gd`cb_primo within w_carica_txt
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_carica_txt
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_carica_txt
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_carica_txt
end type

type dw_1 from w_semplice_gd`dw_1 within w_carica_txt
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_carica_txt
end type

type cb_salva from w_semplice_gd`cb_salva within w_carica_txt
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_carica_txt
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_carica_txt
end type

type cb_ok from w_semplice_gd`cb_ok within w_carica_txt
end type

type cb_1 from commandbutton within w_carica_txt
integer x = 2016
integer y = 1092
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;integer i=0
string null_str

SetNull(null_str)

messagebox("W", i)
//la dw deve essere caricata e deve essere fata in modo che i campi abbiano lo stesso formato
//dei dati (altrimenti puoi:
/*
1) caricare il file di testo con driver odbc TXT:

// Construct the style options
ls_style = "style(type=tabular) datawindow(units=3 ) "
// Create the DW syntax from the select
ls_dw_err = ""
//potresti avere una select pronta da utiilzzare o te la costruisci su dw_1."sql_sel_dati"
ls_sql_syntax=dw_1.getitemstring(al_row, "sql_sel_dati")
If ls_sql_syntax = "" Then
	MessageBox("Errore!", "Select non trovata")
	return
Else
	ls_dw_syntax = SyntaxFromSQL(itrans_source, ls_sql_syntax, ls_style, ls_dw_err)
	if ls_dw_err <> "" then
		MessageBox("Errore!", ls_dw_err)
		return
	end if
End If

tab_1.tabpage_2.dw_3.create(ls_dw_syntax)
tab_1.tabpage_2.dw_3.settransobject(itrans_source)
tab_1.tabpage_2.dw_3.retrieve()

*/
i=dw_1.ImportFile(null_str)
//i=dw_1.ImportFile("C:\DATI\date_acq.csv")
messagebox("W", i)
end event

