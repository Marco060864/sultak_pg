forward
global type udw_001 from udw_000
end type
end forward

global type udw_001 from udw_000
event ue_delete ( integer al_riga_da_cancellare )
event type long ue_insert ( integer al_riga_precedente )
event ue_post_insert ( long al_riga )
event ue_key pbm_dwnkey
event type integer ue_update ( )
end type
global udw_001 udw_001

type variables
string is_sql
end variables

event ue_delete(integer al_riga_da_cancellare);//se al_riga_da_cancellare=0 allora devo cancellare tutte le righe
//la cancellazione dovrà essere confermata con un update
if al_riga_da_cancellare=0 then
	this.rowsmove(1, this.rowcount(), primary!, this, 1, delete!)
else
	this.deleterow(al_riga_da_cancellare)
end if

modify("datawindow.HEADER.color = 255")
end event

event type long ue_insert(integer al_riga_precedente);//inserimento da confermare con update
long ll_riga
ll_riga=this.insertrow(al_riga_precedente)

scrolltorow(ll_riga)
setcolumn(2)
post setfocus(this)

post event ue_post_insert(ll_riga)
return ll_riga
end event

event ue_key;if keyflags=2 then
	CHOOSE CASE key
		
		CASE KeyS!
			trigger event ue_update()
		CASE KeyI!
			trigger event ue_insert(getrow())
		CASE  keyadd!
			trigger event ue_insert(0)
		CASE KeyD!, keysubtract!
			trigger event ue_delete(getrow())
	END CHOOSE
end if
end event

event type integer ue_update();integer li_ret
//, li_ret2, li_ret3

accepttext()

li_ret=update()
//li_ret2=sqlca.sqlcode
//li_ret3=sqlca.sqlnrows
if li_ret=1 then
	commit;

else
	rollback;
	
	messagebox(  this.classname() +" - Salvataggio non riuscito!",sqlca.sqlerrtext)
end if
	
	
	
return li_ret
end event

on udw_001.create
call super::create
end on

on udw_001.destroy
call super::destroy
end on

event sqlpreview;call super::sqlpreview;string ls_sql, ls_sql_riaggiungi=""
long li_pos

if this.is_sql>" " and sqltype=PreviewSelect! then

	ls_sql=sqlsyntax
	
	li_pos=pos(ls_sql, "ORDER")   //20220823 prima era ll_pos=pos(ls_sql, "WHERE") non ricordo perché
	if li_pos>0 then
		ls_sql=left(ls_sql, li_pos - 1)
		ls_sql_riaggiungi= right(sqlsyntax, len(sqlsyntax) - li_pos)
	end if
	ls_sql+=this.is_sql +ls_sql_riaggiungi
	//messagebox("S", ls_sql)
	setsqlpreview(ls_sql)

end if
end event

