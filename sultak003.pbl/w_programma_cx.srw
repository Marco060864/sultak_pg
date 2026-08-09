forward
global type w_programma_cx from w_ra_padre_figlio_cx
end type
type dw_3 from udw_001 within w_programma_cx
end type
end forward

global type w_programma_cx from w_ra_padre_figlio_cx
integer width = 4869
integer height = 1920
dw_3 dw_3
end type
global w_programma_cx w_programma_cx

on w_programma_cx.create
int iCurrent
call super::create
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
end on

on w_programma_cx.destroy
call super::destroy
destroy(this.dw_3)
end on

event open;call super::open;long ll_righe
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

i_dw_corrente=1
ll_righe=dw_1.retrieve()
if ll_righe>0 then
	dw_1.trigger event rowfocuschanged(1)
end if
end event

event resize;cb_inserisci.y=newheight - 224
cb_inserisci.x=dw_1.x
cb_cancella.y=newheight - 224
cb_salva.y=newheight - 224
cb_salva.x=cb_inserisci.x + 285
cb_cancella.x=cb_salva.x + 285
//cb_primo.y=newheight - 208
//cb_primo.x=cb_inserisci.x + 918
//cb_indietro.y=newheight - 208
//cb_indietro.x=cb_primo.x + 160
//cb_avanti.y=newheight - 208
//cb_avanti.x=cb_indietro.x + 160
//cb_ultimo.y=newheight - 208
//cb_ultimo.x=cb_avanti.x + 128
cb_ok.y=newheight - 224
cb_ok.x=newwidth - cb_ok.width - 100
cb_ricerca.y=newheight - 224
cb_ricerca.x=cb_ok.x - 285
cb_annulla.y=newheight - 224
cb_annulla.x=cb_ricerca.x - 285
dw_1.width=this.width - 150
dw_2.width=dw_1.width /2 -10
dw_2.y=dw_1.y + dw_1.height + 20
dw_2.height=this.height - (dw_1.y + dw_1.height + 20) - 280 - cb_ok.height
dw_3.width=dw_1.width /2 -10
dw_3.y=dw_1.y + dw_1.height + 20
dw_3.height=this.height - (dw_1.y + dw_1.height + 20) - 280 - cb_ok.height
dw_3.x=dw_1.width /2 + 5
end event

type cb_ricerca from w_ra_padre_figlio_cx`cb_ricerca within w_programma_cx
end type

type dw_1 from w_ra_padre_figlio_cx`dw_1 within w_programma_cx
integer width = 3378
string dataobject = "d_programma"
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;dw_2.sharedata(dw_3)
end event

type dw_2 from w_ra_padre_figlio_cx`dw_2 within w_programma_cx
integer x = 69
integer y = 512
integer width = 1627
string dataobject = "d_prog_intervento_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_2::ue_post_insert;call super::ue_post_insert;
long ll_num_intervento


ll_num_intervento=getitemnumber(al_riga, "c_num_intervento")
if isnull(ll_num_intervento) then ll_num_intervento=1
setitem(al_riga, "num_intervento", ll_num_intervento)
end event

type cb_inserisci from w_ra_padre_figlio_cx`cb_inserisci within w_programma_cx
end type

type cb_salva from w_ra_padre_figlio_cx`cb_salva within w_programma_cx
end type

type cb_cancella from w_ra_padre_figlio_cx`cb_cancella within w_programma_cx
end type

type cb_annulla from w_ra_padre_figlio_cx`cb_annulla within w_programma_cx
end type

type cb_ok from w_ra_padre_figlio_cx`cb_ok within w_programma_cx
end type

type dw_3 from udw_001 within w_programma_cx
integer x = 1746
integer y = 512
integer width = 1710
integer height = 1088
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_prog_intervento_tb"
end type

