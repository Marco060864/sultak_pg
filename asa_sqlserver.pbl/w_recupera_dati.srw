forward
global type w_recupera_dati from window
end type
type cb_correggi from commandbutton within w_recupera_dati
end type
type cb_chiudi from commandbutton within w_recupera_dati
end type
type cb_carica from commandbutton within w_recupera_dati
end type
type dw_3 from udw_000 within w_recupera_dati
end type
type cb_cancella from commandbutton within w_recupera_dati
end type
type cb_ana from commandbutton within w_recupera_dati
end type
type cb_salva from commandbutton within w_recupera_dati
end type
type dw_2 from udw_000 within w_recupera_dati
end type
type dw_1 from udw_000 within w_recupera_dati
end type
end forward

global type w_recupera_dati from window
integer width = 3145
integer height = 1792
boolean titlebar = true
string title = "Recupero dati Domus"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_correggi cb_correggi
cb_chiudi cb_chiudi
cb_carica cb_carica
dw_3 dw_3
cb_cancella cb_cancella
cb_ana cb_ana
cb_salva cb_salva
dw_2 dw_2
dw_1 dw_1
end type
global w_recupera_dati w_recupera_dati

type variables
transaction iS_trans_dest, iS_trans_part
string is_odbc_destinazione, is_odbc_pARTENZA

end variables

on w_recupera_dati.create
this.cb_correggi=create cb_correggi
this.cb_chiudi=create cb_chiudi
this.cb_carica=create cb_carica
this.dw_3=create dw_3
this.cb_cancella=create cb_cancella
this.cb_ana=create cb_ana
this.cb_salva=create cb_salva
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_correggi,&
this.cb_chiudi,&
this.cb_carica,&
this.dw_3,&
this.cb_cancella,&
this.cb_ana,&
this.cb_salva,&
this.dw_2,&
this.dw_1}
end on

on w_recupera_dati.destroy
destroy(this.cb_correggi)
destroy(this.cb_chiudi)
destroy(this.cb_carica)
destroy(this.dw_3)
destroy(this.cb_cancella)
destroy(this.cb_ana)
destroy(this.cb_salva)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;		date ldt_data
		is_odbc_pARTENZA="domus"
		
		iS_trans_part = CREATE transaction
		iS_trans_part.DBMS = "ODBC"

		iS_trans_part.DBParm ="ConnectString ='DSN="+is_odbc_pARTENZA+";UID=bw;PWD=BwPwd@01'"
		iS_trans_part.Database = ""
		CONNECT USING iS_trans_part;
		dw_1.settransobject(iS_trans_part)
		
		
		
		
		
		is_odbc_destinazione="sultakabic"
		iS_trans_dest = CREATE transaction
		iS_trans_dest.DBMS = "ODBC"
		iS_trans_dest.DBParm ="ConnectString ='DSN="+is_odbc_destinazione+";UID=DBA;PWD=SQL'"
		iS_trans_dest.Database = ""
		CONNECT USING iS_trans_dest;
		dw_2.settransobject(iS_trans_dest)
//		dw_2.retrieve()

		select max(data_reg)
		into :ldt_data
		from dba.pnotaabic
		using iS_trans_dest;
		if isnull(ldt_data) then ldt_data=today()
		ldt_data=relativedate(ldt_data, 1)
		dw_3.insertrow(1)
		dw_3.setitem(1 ,"da_data", ldt_data)		
		dw_3.setitem(1 ,"a_data", today())		
		
end event

event close;disCONNECT USING iS_trans_dest;
disCONNECT USING iS_trans_part;
end event

type cb_correggi from commandbutton within w_recupera_dati
integer x = 1554
integer y = 16
integer width = 375
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Correggi"
end type

event clicked;LONG LL_RIGHE,  I, z,a
date Ldt_da_data, ldt_a_data, LDT_DATA_REG
decimal ldc_imp, ldc_ent
long ll_id_mov_domus

dw_3.accepttext()
ldt_da_data=dw_3.getitemdate(1, "da_data")
ldt_a_data=dw_3.getitemdate(1, "a_data")

dw_1.retrieve()
LL_RIGHE=dw_1.rowcount()

DW_2.RESET()

FOR i = 1 TO LL_RIGHE
	LDT_DATA_REG=date(DW_1.GETITEMDATETIME(I, 2))
	IF LDT_DATA_REG>=ldt_da_data and LDT_DATA_REG<=ldt_a_data then
		
		ll_id_mov_domus=DW_1.GETITEMNUMBER(I, "idmovi")
		
		ldc_imp=DW_1.GETITEMDECIMAL(I, "importoeuro")
		select entrate
		into :ldc_ent
		from dba.pnotaabic
		where id_mov_domus=:ll_id_mov_domus
		USING iS_trans_dest;
		
		if ldc_ent>0 then 
			if ldc_imp = ldc_ent then 
				continue
			else
				DW_2.retrieve(ll_id_mov_domus)
				dw_2.SETFILTER("id_mov_domus="+STRING(ll_id_mov_domus))
				DW_2.FILTER()
				DW_2.SETITEM(1, "ENTRATE", ldc_imp)	
				a++
				if dw_2.rowcount()=2 then DW_2.SETITEM(2, "uscite", ldc_imp)
			end if
		end if
	end if
NEXT
dw_2.SETFILTER("")
DW_2.FILTER()
if a=0 then
	Messagebox("Attenzione!", "Non ci sono movimenti da CORREGGERE nel periodo indicato!")
else
	Messagebox("Finito!", "Importazione riuscita: "+string(a)+ " movimenti importati!")
end if


end event

type cb_chiudi from commandbutton within w_recupera_dati
integer x = 2633
integer y = 148
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_carica from commandbutton within w_recupera_dati
integer x = 1111
integer y = 16
integer width = 416
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica"
end type

event clicked;LONG LL_RIGHE, A, I, z, ll_max, ll_num_matrice, ll_esiste
date Ldt_da_data, ldt_a_data, LDT_DATA_REG, ldt_oggi
string ls_des, ls_causale
decimal ldc_imp
long ll_id_mov_domus

dw_3.accepttext()
ldt_da_data=dw_3.getitemdate(1, "da_data")
ldt_a_data=dw_3.getitemdate(1, "a_data")

dw_1.retrieve()
LL_RIGHE=dw_1.rowcount()

dw_2.reset()

select max(num_prog)
into :ll_max
from dba.pnotaabic
 USING iS_trans_dest
;
ldt_oggi=today()
if isnull(ll_max) then ll_max=0
FOR i = 1 TO LL_RIGHE
	LDT_DATA_REG=date(DW_1.GETITEMDATETIME(I, 2))
	IF LDT_DATA_REG>=ldt_da_data and LDT_DATA_REG<=ldt_a_data then
		ll_num_matrice=DW_1.GETITEMNUMBER(I, 1)
		ll_id_mov_domus=DW_1.GETITEMNUMBER(I, "idmovi")
		ll_esiste=0
		select id_mov_domus
		into :ll_esiste
		from dba.pnotaabic
		where id_mov_domus=:ll_id_mov_domus
		USING iS_trans_dest;
		
		
		if ll_esiste>0 then continue
		ldc_imp=DW_1.GETITEMDECIMAL(I, "importoeuro")
		ls_des=DW_1.GETITEMSTRING(I, "nome")
		ls_causale=DW_1.GETITEMSTRING(I, "codcaus")
		
		z=DW_2.INSERTROW(0)
		
		DW_2.SETITEM(z, "id_mov_domus", ll_id_mov_domus)
		DW_2.SETITEM(z, 'importata', 'S')
		DW_2.SETITEM(z, 'num_prog', ll_max+z)
		DW_2.SETITEM(z, 'causale', ls_causale)	
		DW_2.SETITEM(z, "rif_matrice", ll_num_matrice)
		DW_2.SETITEM(z, "data_reg", ldt_oggi)
		DW_2.SETITEM(z, "data_doc", LDT_DATA_REG)
		DW_2.SETITEM(z, "descrizione", ls_des)
		DW_2.SETITEM(z, "entrate", ldc_imp)
		
		
		if dw_1.getitemstring(i,"codcaus")='RI' then
			z=DW_2.INSERTROW(0)
			DW_2.SETITEM(z, "id_mov_domus", ll_id_mov_domus)
			DW_2.SETITEM(z, 'importata', 'S')
			DW_2.SETITEM(z, 'num_prog', ll_max+z)
			DW_2.SETITEM(z, 'causale', ls_causale)
				
			DW_2.SETITEM(z, "rif_matrice", ll_num_matrice)
			DW_2.SETITEM(z, "data_reg", ldt_oggi)
			DW_2.SETITEM(z, "data_doc", LDT_DATA_REG)
			DW_2.SETITEM(z, "descrizione", ls_des)
			DW_2.SETITEM(z, "uscite", ldc_imp)
		end if
			
	end if
NEXT
if z=0 then
	Messagebox("Attenzione!", "Non ci sono movimenti da riportare nel periodo indicato!")
else
	Messagebox("Finito!", "Importazione riuscita: "+string(z)+ " movimenti importati!")
end if






end event

type dw_3 from udw_000 within w_recupera_dati
integer x = 18
integer y = 20
integer width = 1070
integer height = 248
integer taborder = 20
string dataobject = "d_date"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_cancella from commandbutton within w_recupera_dati
integer x = 1970
integer y = 148
integer width = 631
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

type cb_ana from commandbutton within w_recupera_dati
integer x = 1970
integer y = 16
integer width = 626
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recupera anagrafiche"
end type

event clicked;open (w_recupera_ana)
end event

type cb_salva from commandbutton within w_recupera_dati
integer x = 1111
integer y = 148
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

type dw_2 from udw_000 within w_recupera_dati
integer x = 23
integer y = 292
integer width = 3017
integer height = 1296
integer taborder = 20
string dataobject = "d_ana_pnotaabic"
boolean hscrollbar = true
end type

event retrievestart;call super::retrievestart;return 2
end event

type dw_1 from udw_000 within w_recupera_dati
boolean visible = false
integer x = 1545
integer width = 2373
integer height = 528
string dataobject = "d_rec_bollettine"
boolean hscrollbar = true
end type

event sqlpreview;call super::sqlpreview;integer i
string ls_sql

//
//ls_sql+=" and (string(dm04_datareg) >= '"+string(idt_da_data, "dd/mm/yyyy hh:mm:ss")+ &
//"'" 
////and dm04_datareg<= '" +string(idt_a_data,"yy/mm/dd hh:mm:ss")+"')"
////			
//	i=SetSQLPreview(sqlsyntax+ls_sql)
//if i<>1 then
//	messagebox("Errore!", "Filtro non applicato!")
//end if
//
end event

