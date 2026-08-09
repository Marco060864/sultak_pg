forward
global type w_semplice_cx from w_base
end type
type cb_stampa from uo_commandbutton within w_semplice_cx
end type
type cb_ricerca from uo_commandbutton within w_semplice_cx
end type
type cb_primo from uo_commandbutton within w_semplice_cx
end type
type cb_ultimo from uo_commandbutton within w_semplice_cx
end type
type cb_indietro from uo_commandbutton within w_semplice_cx
end type
type cb_avanti from uo_commandbutton within w_semplice_cx
end type
type dw_1 from udw_001 within w_semplice_cx
end type
type cb_inserisci from uo_commandbutton within w_semplice_cx
end type
type cb_salva from uo_commandbutton within w_semplice_cx
end type
type cb_cancella from uo_commandbutton within w_semplice_cx
end type
type cb_annulla from uo_commandbutton within w_semplice_cx
end type
type cb_ok from uo_commandbutton within w_semplice_cx
end type
end forward

global type w_semplice_cx from w_base
integer width = 2386
integer height = 1284
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 80269524
cb_stampa cb_stampa
cb_ricerca cb_ricerca
cb_primo cb_primo
cb_ultimo cb_ultimo
cb_indietro cb_indietro
cb_avanti cb_avanti
dw_1 dw_1
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_semplice_cx w_semplice_cx

type variables

end variables

on w_semplice_cx.create
int iCurrent
call super::create
this.cb_stampa=create cb_stampa
this.cb_ricerca=create cb_ricerca
this.cb_primo=create cb_primo
this.cb_ultimo=create cb_ultimo
this.cb_indietro=create cb_indietro
this.cb_avanti=create cb_avanti
this.dw_1=create dw_1
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stampa
this.Control[iCurrent+2]=this.cb_ricerca
this.Control[iCurrent+3]=this.cb_primo
this.Control[iCurrent+4]=this.cb_ultimo
this.Control[iCurrent+5]=this.cb_indietro
this.Control[iCurrent+6]=this.cb_avanti
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cb_inserisci
this.Control[iCurrent+9]=this.cb_salva
this.Control[iCurrent+10]=this.cb_cancella
this.Control[iCurrent+11]=this.cb_annulla
this.Control[iCurrent+12]=this.cb_ok
end on

on w_semplice_cx.destroy
call super::destroy
destroy(this.cb_stampa)
destroy(this.cb_ricerca)
destroy(this.cb_primo)
destroy(this.cb_ultimo)
destroy(this.cb_indietro)
destroy(this.cb_avanti)
destroy(this.dw_1)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;call super::open;dw_1.settransobject(sqlca)


end event

event resize;call super::resize;dw_1.width=newwidth - 105
dw_1.height=newheight - 292

cb_inserisci.y=newheight - 224
cb_inserisci.x=dw_1.x
cb_cancella.y=newheight - 224
cb_salva.y=newheight - 224
cb_salva.x=cb_inserisci.x + 285
cb_cancella.x=cb_salva.x + 285



cb_ultimo.x=cb_avanti.x + 128

cb_ok.y=newheight - 224
cb_ok.x=dw_1.x + dw_1.width - cb_ok.width
cb_ricerca.y=newheight - 224
cb_ricerca.x=cb_ok.x - 285
cb_annulla.y=newheight - 224
cb_annulla.x=cb_ricerca.x - 285
cb_ricerca.y=newheight - 224
cb_ricerca.x=cb_annulla.x - 285
cb_stampa.x=cb_cancella.x + 285
cb_stampa.y=cb_salva.y

cb_primo.y=newheight - 208
cb_primo.x=cb_stampa.x + 261
cb_indietro.y=newheight - 208
cb_indietro.x=cb_primo.x + 160
cb_avanti.y=newheight - 208
cb_avanti.x=cb_indietro.x + 160
cb_ultimo.y=newheight - 208
end event

type cb_stampa from uo_commandbutton within w_semplice_cx
integer x = 923
integer y = 1064
integer width = 261
integer height = 96
integer taborder = 50
integer textsize = -8
string text = "Stampa"
end type

event clicked;call super::clicked;string ls_data, ls_num_doc

ls_num_doc=parent.classname()
		
ls_data=string(today(), "dd-mm-yy")
ls_num_doc+="_"+ls_data
	
dw_1.Modify("DataWindow.Print.DocumentName='"+ls_num_doc+"'")
dw_1.print(true, true)
end event

type cb_ricerca from uo_commandbutton within w_semplice_cx
string tag = "Propone la griglia per ricercare per ogni campo visibile."
integer x = 1499
integer y = 992
integer width = 261
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
string text = "Ricerca"
end type

event clicked;long ll_id, ll_riga

if text='Ricerca' then
	dw_1.modify("datawindow.querymode=yes")
	text='Trova'
else
	text='Ricerca'
	dw_1.accepttext()
	dw_1.Modify("DataWindow.QueryMode=no")
	ll_riga=dw_1.retrieve()
end if
end event

type cb_primo from uo_commandbutton within w_semplice_cx
boolean visible = false
integer x = 937
integer y = 1000
integer width = 128
integer height = 68
integer taborder = 40
integer weight = 700
string text = "<<"
end type

event clicked;
IF DW_1.ROWCOUNT()>0 THEN
	dw_1.SCROLLTOROW(1)
END IF
end event

type cb_ultimo from uo_commandbutton within w_semplice_cx
boolean visible = false
integer x = 1353
integer y = 1000
integer width = 128
integer height = 68
integer taborder = 70
string text = ">>"
end type

event clicked;

IF DW_1.ROWCOUNT()>0 THEN
	dw_1.SCROLLTOROW(DW_1.ROWCOUNT())
END IF
end event

type cb_indietro from uo_commandbutton within w_semplice_cx
boolean visible = false
integer x = 1266
integer y = 1000
integer width = 96
integer height = 68
integer taborder = 60
string text = "<"
end type

event clicked;
//dw_1.record_precedente()
end event

type cb_avanti from uo_commandbutton within w_semplice_cx
boolean visible = false
integer x = 1394
integer y = 1000
integer width = 96
integer height = 68
integer taborder = 50
string text = ">"
end type

event clicked;
//dw_1.record_successivo()
end event

type dw_1 from udw_001 within w_semplice_cx
integer x = 32
integer y = 32
integer width = 2281
integer height = 916
boolean bringtotop = true
end type

event clicked;call super::clicked;string ls_tag, ls_type
if dwo.type="column" then
	ls_tag=dwo.tag
	w_mdi.setmicrohelp( ls_tag)
end if

end event

type cb_inserisci from uo_commandbutton within w_semplice_cx
string tag = "Inserisce una nuova riga nella finestra che ha il fuoco."
integer x = 69
integer y = 984
integer width = 261
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
string text = "Inserisci"
end type

event clicked;long ll_riga
ll_riga=dw_1.trigger event ue_insert(0)

end event

type cb_salva from uo_commandbutton within w_semplice_cx
string tag = "Salva la finestra che ha il fuoco. Se essa è figlia, salva anche la finestra madre."
integer x = 352
integer y = 984
integer width = 261
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string text = "Salva"
end type

event clicked;dw_1.trigger event ue_update()

end event

type cb_cancella from uo_commandbutton within w_semplice_cx
string tag = "Cancella la riga selezionata nella finestra che ha il fuoco. Richiede il salvataggio successivo per perfezionare la cancellazione."
integer x = 640
integer y = 984
integer width = 261
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
ll_riga_da_cancellare=dw_1.getrow()
dw_1.trigger event ue_delete(ll_riga_da_cancellare)		

end event

type cb_annulla from uo_commandbutton within w_semplice_cx
string tag = "Chiude senza salvare nulla."
integer x = 1774
integer y = 988
integer width = 261
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_ok from uo_commandbutton within w_semplice_cx
string tag = "Chiude salvando le modifiche."
integer x = 2062
integer y = 988
integer width = 261
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
string text = "Ok"
end type

event clicked;if messagebox("Salvare?", "Salvare i dati prima di chiudere?", stopsign!, yesno!)=1 then
	dw_1.trigger event ue_update()
end if
close(parent)
end event

