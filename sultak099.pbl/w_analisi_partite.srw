forward
global type w_analisi_partite from w_semplice_cx
end type
type dw_2 from udw_000 within w_analisi_partite
end type
end forward

global type w_analisi_partite from w_semplice_cx
integer width = 3954
integer height = 2216
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_2 dw_2
end type
global w_analisi_partite w_analisi_partite

on w_analisi_partite.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_analisi_partite.destroy
call super::destroy
destroy(this.dw_2)
end on

event open;call super::open;dw_2.settransobject(sqlca)
dw_2.insertrow(1)

dw_1.retrieve()
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_analisi_partite
integer x = 914
integer y = 1484
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_analisi_partite
integer x = 1490
integer y = 1412
end type

type cb_primo from w_semplice_cx`cb_primo within w_analisi_partite
integer x = 928
integer y = 1420
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_analisi_partite
integer x = 1344
integer y = 1420
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_analisi_partite
integer x = 1257
integer y = 1420
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_analisi_partite
integer x = 1385
integer y = 1420
end type

type dw_1 from w_semplice_cx`dw_1 within w_analisi_partite
integer y = 36
integer width = 3744
integer height = 1820
string dataobject = "d_partite_analisi"
boolean vscrollbar = true
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_analisi_partite
integer x = 59
integer y = 1648
end type

type cb_salva from w_semplice_cx`cb_salva within w_analisi_partite
integer x = 343
integer y = 1648
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_analisi_partite
integer x = 631
integer y = 1648
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_analisi_partite
integer x = 1765
integer y = 1652
end type

type cb_ok from w_semplice_cx`cb_ok within w_analisi_partite
integer x = 2053
integer y = 1652
end type

type dw_2 from udw_000 within w_analisi_partite
integer x = 1321
integer y = 1896
integer width = 690
integer height = 172
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_scegli_conto"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string ls_filtro

if data> " " then
	ls_filtro="conto_codice='"+data+"'"
	dw_1.setfilter(ls_filtro)
	dw_1.filter()
	
end if
end event

