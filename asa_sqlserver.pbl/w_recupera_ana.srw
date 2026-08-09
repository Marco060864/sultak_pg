forward
global type w_recupera_ana from window
end type
type cb_cancella from commandbutton within w_recupera_ana
end type
type cb_trovadoppi from commandbutton within w_recupera_ana
end type
type cb_salva from commandbutton within w_recupera_ana
end type
type cb_copia from commandbutton within w_recupera_ana
end type
type dw_2 from udw_000 within w_recupera_ana
end type
type dw_1 from udw_000 within w_recupera_ana
end type
end forward

global type w_recupera_ana from window
integer width = 3438
integer height = 1732
boolean titlebar = true
string title = "Recupero anagrafiche Domus"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_cancella cb_cancella
cb_trovadoppi cb_trovadoppi
cb_salva cb_salva
cb_copia cb_copia
dw_2 dw_2
dw_1 dw_1
end type
global w_recupera_ana w_recupera_ana

type variables
transaction iS_trans_dest, iS_trans_part
string is_odbc_destinazione, is_odbc_pARTENZA
end variables

on w_recupera_ana.create
this.cb_cancella=create cb_cancella
this.cb_trovadoppi=create cb_trovadoppi
this.cb_salva=create cb_salva
this.cb_copia=create cb_copia
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_cancella,&
this.cb_trovadoppi,&
this.cb_salva,&
this.cb_copia,&
this.dw_2,&
this.dw_1}
end on

on w_recupera_ana.destroy
destroy(this.cb_cancella)
destroy(this.cb_trovadoppi)
destroy(this.cb_salva)
destroy(this.cb_copia)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;			
		is_odbc_pARTENZA="domus"
		iS_trans_part = CREATE transaction
		iS_trans_part.DBMS = "ODBC"
		iS_trans_part.DBParm ="ConnectString ='DSN="+is_odbc_pARTENZA+";UID=bw;PWD=BwPwd@01'"
		iS_trans_part.Database = ""
		CONNECT USING iS_trans_part;
		dw_1.settransobject(iS_trans_part)
		dw_1.retrieve()
		
		
		
		
		is_odbc_destinazione="sultakabic"
		iS_trans_dest = CREATE transaction
		iS_trans_dest.DBMS = "ODBC"
		iS_trans_dest.DBParm ="ConnectString ='DSN="+is_odbc_destinazione+";UID=DBA;PWD=SQL'"
		iS_trans_dest.Database = ""
		CONNECT USING iS_trans_dest;
		dw_2.settransobject(iS_trans_dest)
		
		
		
				
		
end event

event close;disCONNECT USING iS_trans_dest;
disCONNECT USING iS_trans_part;
end event

type cb_cancella from commandbutton within w_recupera_ana
integer x = 2062
integer y = 1404
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;dw_2.deleterow(dw_2.getrow())
end event

type cb_trovadoppi from commandbutton within w_recupera_ana
integer x = 1531
integer y = 1404
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Trova Doppi"
end type

event clicked;long i, ll_riga_trovata, ll_righe, ll_cancellate
string ls_ana
dw_2.sort()
ll_righe=dw_2.rowcount()
ll_cancellate=0
for i=1 to ll_righe - 1
	if i>=dw_2.rowcount() then exit
	ls_ana=upper(dw_2.getitemstring(i, "ana_rag_sociale"))
	ll_riga_trovata=dw_2.find("upper(ana_rag_sociale)='"+ls_ana+"'", i+1, ll_righe - ll_cancellate)
	if ll_riga_trovata>0 then
		dw_2.ScrollToRow(ll_riga_trovata)
		dw_2.selectrow(ll_riga_trovata, true)
		cb_cancella.triggerevent(clicked!)
		ll_cancellate ++
		//return
//	else
//		ls_ana=upper(ls_ana)
//		ll_riga_trovata=dw_2.find("ana_rag_sociale='"+ls_ana+"'", i+1, ll_righe)
//		if ll_riga_trovata>0 then
//			dw_2.ScrollToRow(ll_riga_trovata)
//			dw_2.selectrow(ll_riga_trovata, true)
//			cb_cancella.triggerevent(clicked!)
//			ll_righe --
//			//return
		end if
//	end if
	
next
end event

type cb_salva from commandbutton within w_recupera_ana
integer x = 873
integer y = 1400
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;if dw_2.update()=1 then
	messagebox("OK", "Salvataggio riuscito")
	commit;
else
	messagebox("AHI!", "Salvataggio FALLITO!")
	rollback;
end if
end event

type cb_copia from commandbutton within w_recupera_ana
integer x = 210
integer y = 1396
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copia"
end type

event clicked;long i, a, ll_righe_dw2, ll_esiste
string ls_nome
integer li_pos
dw_2.reset()
ll_righe_dw2=dw_2.retrieve()
for i=1 to dw_1.rowcount()
	ls_nome=dw_1.getitemstring(i, "nome")
	li_pos=pos(ls_nome, "'")
	if li_pos>0 then
		ls_nome=replace(ls_nome, li_pos, 1, "_")
	end if
	ls_nome=upper(ls_nome)
	
		
	ll_esiste=dw_2.find("upper(ana_rag_sociale)='"+ls_nome+"'", 1, ll_righe_dw2)
	if ll_esiste<0 then
		messagebox(string(i), ls_nome)
	end if
		
	if ll_esiste>0 then continue

	a=dw_2.insertrow(0)
	dw_2.setitem(a,	"ana_rag_sociale",	ls_nome)
	dw_2.setitem(a, 	"ana_indirizzo",  	dw_1.getitemstring(i, "indirizzo"))
	dw_2.setitem(a,	"ana_localita",   	dw_1.getitemstring(i, "localita"))
	dw_2.setitem(a,	"ana_cap",       	 	dw_1.getitemstring(i, "cap"))
	dw_2.setitem(a,	"ana_provincia",  	dw_1.getitemstring(i, "provincia"))
	dw_2.setitem(a,	"ana_c_f",  			dw_1.getitemstring(i, "codfisc"))
next
if a>0 then a= a - ll_righe_dw2
messagebox("Nuove Anagrafiche", "Trovate "+string(a)+ " nuove anagrafiche!")
end event

type dw_2 from udw_000 within w_recupera_ana
integer x = 41
integer y = 604
integer width = 3314
integer height = 708
integer taborder = 20
string dataobject = "d_ana_sultak"
boolean hscrollbar = true
end type

type dw_1 from udw_000 within w_recupera_ana
integer x = 41
integer y = 40
integer width = 3314
integer height = 528
string dataobject = "d_rec_anagrafiche"
boolean hscrollbar = true
end type

