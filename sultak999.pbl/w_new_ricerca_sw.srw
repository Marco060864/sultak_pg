//objectcomments le dw che crei per la ricerca dovranno avere l'id nella prima colonna (la primary key)
forward
global type w_new_ricerca_sw from w_base
end type
type mle_sql from multilineedit within w_new_ricerca_sw
end type
type cb_pulisci from uo_commandbutton within w_new_ricerca_sw
end type
type cb_ok from uo_commandbutton within w_new_ricerca_sw
end type
type cb_annulla from uo_commandbutton within w_new_ricerca_sw
end type
type cb_ricerca from uo_commandbutton within w_new_ricerca_sw
end type
type dw_1 from udw_000 within w_new_ricerca_sw
end type
end forward

global type w_new_ricerca_sw from w_base
integer width = 2715
integer height = 1572
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
mle_sql mle_sql
cb_pulisci cb_pulisci
cb_ok cb_ok
cb_annulla cb_annulla
cb_ricerca cb_ricerca
dw_1 dw_1
end type
global w_new_ricerca_sw w_new_ricerca_sw

type variables
string IS_FILTRO, is_sql_originale
integer ii_ordina_a_d
s_ricerca s_ric
end variables

forward prototypes
public subroutine wf_cerca (string as_colonna, string as_filtro)
end prototypes

public subroutine wf_cerca (string as_colonna, string as_filtro);cb_pulisci.triggerevent(clicked!)
dw_1.setitem(1, as_colonna, as_filtro)
cb_ricerca.triggerevent(clicked!)
end subroutine

event open;call super::open;integer li_num_colonne, i, li_size_dw, li_upperbound
string ls_coltype, ls_filtro


s_ric=message.powerobjectparm

DW_1.DATAOBJECT= s_ric.dataobject
dw_1.settransobject(sqlca)
dw_1.Modify("DataWindow.QueryMode=yes")

this.title=s_ric.titolo_finestra

li_num_colonne=integer(dw_1.describe("datawindow.column.count"))
for i = 1 to li_num_colonne
	if dw_1.describe("#"+string(i)+".width")>'0' then
		li_size_dw+=integer(dw_1.describe("#"+string(i)+".width"))
	end if
next
this.width=li_size_dw +300

dw_1.width=li_size_dw+200
dw_1.height=this.height - dw_1.y - 500 - 200 - cb_ricerca.height 
mle_sql.width=dw_1.width
mle_sql.x=dw_1.x
mle_sql.y=dw_1.y+dw_1.height+cb_ricerca.height +50
cb_ricerca.x=dw_1.x
cb_ricerca.y=dw_1.y+dw_1.height+20
cb_pulisci.x=cb_ricerca.x +cb_ricerca.width+ 30 
cb_pulisci.y=cb_ricerca.y

cb_ok.x=dw_1.x+ dw_1.width - cb_ok.width
cb_ok.y=cb_ricerca.y
cb_annulla.x=cb_ok.x - cb_ok.width - 30
cb_annulla.y=cb_ricerca.y
this.height=30+dw_1.height + cb_ricerca.height +50 +mle_sql.height+300

li_upperbound= upperbound(s_ric.filtro)
for i= 1 to li_upperbound
		
	DW_1.SETCOLUMN(S_RIC.COLONNA_FILTRO[i])
	ls_coltype = dw_1.Describe(S_RIC.COLONNA_FILTRO[i]+".ColType")
	choose case left(ls_coltype, 4)
		case "char", "stri", "varc"
			ls_filtro="LIKE '"+s_ric.filtro[i]+"%'"
		case "long", "inte"
			ls_filtro="= "+s_ric.filtro[i]
	end choose
	dw_1.SETTEXT(ls_filtro)
next
if li_upperbound>0 then
	cb_RICERCA.TRIGGERevent("clicked")
	if dw_1.rowcount()=1 then
		cb_ok.triggerevent(clicked!)
	elseif dw_1.rowcount()<=0 then
		cb_annulla.triggerevent(clicked!)
	end if
end if



end event

on w_new_ricerca_sw.create
int iCurrent
call super::create
this.mle_sql=create mle_sql
this.cb_pulisci=create cb_pulisci
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.cb_ricerca=create cb_ricerca
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_sql
this.Control[iCurrent+2]=this.cb_pulisci
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_annulla
this.Control[iCurrent+5]=this.cb_ricerca
this.Control[iCurrent+6]=this.dw_1
end on

on w_new_ricerca_sw.destroy
call super::destroy
destroy(this.mle_sql)
destroy(this.cb_pulisci)
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.cb_ricerca)
destroy(this.dw_1)
end on

type mle_sql from multilineedit within w_new_ricerca_sw
integer x = 41
integer y = 916
integer width = 2496
integer height = 500
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_pulisci from uo_commandbutton within w_new_ricerca_sw
string tag = "Cancella eventuali risultati di una precedente ricerca e prepara la griglia ov specificare i criteri. Supporta le parole chiave: AND, OR e i simboli > < =. Usando più righe si possono specificare condizioni complesse."
integer x = 498
integer y = 788
integer taborder = 70
string text = "Pulisci"
boolean cancel = true
end type

event clicked;dw_1.Modify("DataWindow.Queryclear=yes")
//dw_1.reset()
//dw_1.insertrow(1)
dw_1.Modify("DataWindow.QueryMode=yes")
this.default=true
cb_ok.default=false


end event

type cb_ok from uo_commandbutton within w_new_ricerca_sw
string tag = "Chiude la finestra e riporta il risultato selezionato."
integer x = 2126
integer y = 772
integer taborder = 60
boolean bringtotop = true
string text = "Ok"
end type

event clicked;long ll_id, ll_riga
//le dw dovranno essere create con la chiave id come prima colonna!!!!
if dw_1.describe("DataWindow.QueryMode")='yes' then
	
else
	ll_riga=dw_1.getrow()
	if ll_riga>0 then
		ll_id=dw_1.getitemnumber(ll_riga, 1)
		closewithreturn(parent, ll_id)
	else
		Messagebox("Attenzione!", "Non è stata scelta alcuna riga!")
	end if
end if
end event

type cb_annulla from uo_commandbutton within w_new_ricerca_sw
string tag = "Chiude la finestra senza riportare alcun risultato."
integer x = 1682
integer y = 776
integer taborder = 50
boolean bringtotop = true
string text = "Chiudi"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_ricerca from uo_commandbutton within w_new_ricerca_sw
string tag = "Applica i cirteri specificati nella griglia di ricerca e mostra le righe che soddisfano tali criteri."
integer x = 59
integer y = 788
integer taborder = 20
string text = "Ricerca"
boolean default = true
end type

event clicked;call super::clicked;dw_1.accepttext()

dw_1.Modify("DataWindow.QueryMode=no")
dw_1.retrieve()
this.default=false
cb_ok.default=true

end event

type dw_1 from udw_000 within w_new_ricerca_sw
integer x = 41
integer y = 32
integer width = 2496
integer height = 736
integer taborder = 10
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;mle_sql.text=this.object.datawindow.table.select










//string ls_inizio, ls_valore, ls_tipo_colonna, ls_describe, ls_nome_colonna_db
//integer li_pos, li_pos_fine
//date ld_data
//
//
//ls_describe=dwo.name+".ColType"
//ls_tipo_colonna= dw_1.Describe(ls_describe)
//li_pos=pos(is_filtro, dwo.name, 1)
//if li_pos>0 then
//	li_pos_fine=pos(is_filtro, "AND", li_pos+1)
//	if li_pos_fine>0 then
//		is_filtro=left(is_filtro, li_pos - 1)+ right(is_filtro, len(is_filtro) - li_pos_fine - 4 )
//	else
//		is_filtro=left(is_filtro, li_pos - 8)
//	end if	
//end if
//if pos(IS_FILTRO, "WHERE") >0 then ls_inizio= "  AND  " else ls_inizio= " WHERE "
//if data="" or isnull(data) then
//
//else
//	choose case left(ls_tipo_colonna, 4)
//		case "char"
//			ls_valore="'"+data+"'"
//		case "numb", "long", "int"
//			ls_valore=data
//		case "date"
//			ld_data=date(data)
//			ls_valore="'"+string(ld_data, "yyyy/mm/dd")+"'"
//	end choose
//	ls_nome_colonna_db=Describe(dwo.name+".dbName")
//	 IS_FILTRO+= ls_inizio +ls_nome_colonna_db +" = "+ls_valore+ " "
//	 
//end if
	





		 
		
end event

event doubleclicked;string ls_ordina, ls_asc_desc
if right(dwo.name,2)="_t" then
	ls_ordina=left(dwo.name, len(string(dwo.name)) - 2)
	if ii_ordina_a_d=0 then 
		ls_asc_desc='d'
		ii_ordina_a_d=1
	else
		ii_ordina_a_d=0
		ls_asc_desc='a'
	end if
	dw_1.setsort(ls_ordina+ " "+ls_asc_desc)
	dw_1.setredraw(false)
	dw_1.sort()
	dw_1.groupcalc()
	dw_1.setredraw(true)
else
	cb_ok.triggerevent("clicked")
end if
end event

