//objectcomments 536870912 questo è il valore per il colore trasparente
forward
global type udw_002 from udw_000
end type
end forward

global type udw_002 from udw_000
event ue_delete ( long al_riga_da_cancellare )
event type long ue_insert ( long al_riga_precedente )
event ue_post_insert ( integer al_riga )
event ue_key pbm_dwnkey
event type integer ue_update ( )
end type
global udw_002 udw_002

type variables

end variables

event ue_delete(long al_riga_da_cancellare);//se al_riga_da_cancellare=0 allora devo cancellare tutte le righe
//la cancellazione dovrà essere confermata con un update
if al_riga_da_cancellare=0 then
	this.rowsmove(1, this.rowcount(), primary!, this, 1, delete!)
else
	this.deleterow(al_riga_da_cancellare)
end if

modify("datawindow.HEADER.color = 255")
end event

event type long ue_insert(long al_riga_precedente);//inserimento da confermare con update
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
string ls_messaggio

accepttext()
li_ret=update()
//if sqlca.sqlnrows>0 then
IF LI_RET=1 THEN
	commit;
	li_ret=1
else
	rollback;
		li_ret= -1
		if isnull(sqlca.sqlerrtext) then 
			ls_messaggio="Messaggio sqlca NULLO!"
		else
			ls_messaggio=sqlca.sqlerrtext
		end if
	messagebox( this.classname() +" - Salvataggio non riuscito!", ls_messaggio)
end if
	
	
	
return li_ret
end event

on udw_002.create
call super::create
end on

on udw_002.destroy
call super::destroy
end on

