forward
global type udw_003 from udw_000
end type
end forward

global type udw_003 from udw_000
event type integer ue_update ( )
event ue_delete ( long al_riga_da_cancellare )
event type long ue_insert ( long al_riga_precedente )
event type long ue_post_insert ( long al_riga )
event ue_key pbm_dwnkey
end type
global udw_003 udw_003

type variables
udw_003 i_dw_corrente
end variables

event type integer ue_update();integer li_ret

accepttext()

li_ret=update()
if sqlca.sqlnrows>0 then
	commit;
	li_ret=1
else
	rollback;
	li_ret=-1
	messagebox(  this.classname() +" - Salvataggio non riuscito!",sqlca.sqlerrtext)
end if
	
	
	
return li_ret
end event

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

on udw_003.create
call super::create
end on

on udw_003.destroy
call super::destroy
end on

event getfocus;call super::getfocus;i_dw_corrente=this
end event

