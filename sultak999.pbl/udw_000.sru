forward
global type udw_000 from datawindow
end type
end forward

global type udw_000 from datawindow
integer width = 411
integer height = 432
string title = "none"
boolean maxbox = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_imp_iniziali pbm_custom01
event ue_stampa ( )
end type
global udw_000 udw_000

type variables
string is_asc
end variables

forward prototypes
public subroutine df_segna_obbligatori ()
end prototypes

public subroutine df_segna_obbligatori ();integer i, li_num_campi, li_test
string ls_nome_colonna, ls_nome_tabella, ls_test

ls_nome_tabella=this.object.datawindow.table.updatetable
if len(ls_nome_tabella)  > 2 then
	li_test=pos(ls_nome_tabella, ".")
	if li_test>0 then
		ls_nome_tabella=right(ls_nome_tabella, len(ls_nome_tabella) - li_test)
	end if
	li_num_campi=integer(object.datawindow.column.count)
	if getrow()>0 and  li_num_campi>0 then
		if describe("datawindow.querymode")='yes' then return
		for i = 2 to li_num_campi
			ls_nome_colonna=describe("#"+string(i)+".dbname")
			ls_nome_colonna=right(ls_nome_colonna, len(ls_nome_colonna) - len(ls_nome_tabella) -1)
			ls_test="Y"
			  SELECT "sys"."syscolumns"."nulls"  
			  into :ls_test
				 FROM "sys"."syscolumns"  
				WHERE ( creator = 'DBA' ) AND  
				 ( nulls = 'N' ) AND  
				 ( cname = :ls_nome_colonna ) AND  
				 ( tname = :ls_nome_tabella )    ;
			if ls_test ='N'  then
				modify("#"+string(i)+".background.color='12582911'")
				ls_test =''
			end if
		next
	end if
end if


end subroutine

on udw_000.create
end on

on udw_000.destroy
end on

event rowfocuschanged;modify("#1.background.color='0~tIf(getrow()=currentrow(),255,rgb(255,255,255))'")

df_segna_obbligatori()
end event

event getfocus;this.modify("datawindow.color = 10789024")
end event

event losefocus;string ls_seq
integer li_num_campi, i

li_num_campi=integer(object.datawindow.column.count)
if getrow()>0 and  li_num_campi>0 and describe("datawindow.querymode")<>'yes'then
	for i = 2 to li_num_campi
			modify("#"+string(i)+".border='5'")
	next
end if

this.modify("datawindow.color = 79741120")
end event

event itemchanged;string ls_colonna, ls_table, ls_test,ls_indice, ls_col_index
string  ls_dbcol, ls_data, ls_coltype, ls_ricerca
long ll_riga_trovata
integer li_len

ls_colonna=dwo.name


modify(ls_colonna+".color='0~tIf(isrowmodified(),12615680,0)'")


if getrow()>0 then
	if describe("datawindow.querymode")='yes' then return
	ls_dbcol=describe(ls_colonna+".dbname")
	li_len=pos(ls_dbcol, ".")
	ls_table=left(ls_dbcol, li_len - 1)
	ls_dbcol=right(ls_dbcol, len(ls_dbcol) - li_len)
	li_len=len(ls_dbcol)
	
	select iname, colnames
	into :ls_indice, :ls_col_index
	from sys.sysindexes
	where creator='DBA'
	and indextype='Unique'
	and  left(colnames, :li_len)= :ls_dbcol
	and tname=:ls_table
	;
	
	
	if ls_indice>"" and pos(ls_col_index, ",")<=0 then
		ls_coltype = Describe(ls_colonna+".ColType")
		if left(ls_coltype, 7)='decimal' then ls_coltype="decimal"
		choose case ls_coltype
			case "int", "long", "real", "ulong","number", "decimal"
				ls_ricerca=string(dwo.name)+"="+ data
			case "date"
				//da implementare (con le date non si scherza ...)
				return 0
			case else
				ls_ricerca=string(dwo.name)+"='"+ data+"'"
		end choose
		ll_riga_trovata=find(ls_ricerca, 1, rowcount())
		if ll_riga_trovata<=0 and left(ls_coltype, 4)="char" then
			ls_data=upper(data)
			ll_riga_trovata=find(string(dwo.name)+"='"+ ls_data+"'", 1, rowcount())
		end if
		if ll_riga_trovata>0 then
			Messagebox("Attenzione!", "Alla riga n. "+string(ll_riga_trovata)+&
						" esiste un valore uguale a quello digitato!")
			return 1
		end if
	end if
end if



end event

event rbuttondown;string ls_tip
integer li_len

if dwo.type="column" or  dwo.type="rectangle" or dwo.type="text" or dwo.type="compute" then
	if len(string(dwo.tag))>2 then
		ls_tip=dwo.name+"|"+dwo.tag
		openwithparm(w_tip, ls_tip)
	end if
end if
end event

event itemfocuschanged;string ls_seq
integer li_num_campi, i, li_test

li_num_campi=integer(object.datawindow.column.count)
if getrow()>0 and  li_num_campi>0 and describe("datawindow.querymode")<>'yes'then
	for i = 2 to li_num_campi
		modify("#"+string(i)+".border='5'")
	next
	modify(string(dwo.name)+".border='1'")
end if



end event

event updateend;integer i, li_num_colonne

li_num_colonne=integer(Describe("DataWindow.Column.Count"))
for i= 1 to li_num_colonne
	
	modify("#"+string(i)+".color=0")
next

modify("datawindow.HEADER.color =536870912")
end event

event doubleclicked;string ls_type, modstring

if dwo.type='column' then
	
//	ls_type=describe(dwo.name+".edit.style")
//	if ls_type='dddw' then
//		modstring='create compute(name='+dwo.name+'_compute moveable=1 resizeable=1 band=detail '+& 
//		' expression= "1" visible="1" )'
//		modify(modstring)
//	end if
	if is_asc='A' then
		is_asc='D'
	else
		is_asc='A'
	end if
	
	setsort(dwo.name+" "+is_asc)
	
	Setredraw(FALSE)
	sort()
	GroupCalc()
	SetRedraw(TRUE)
	
	
end if

//Lookupdisplay('+dwo.name+')
end event

event constructor;//postevent("ue_init")
end event

