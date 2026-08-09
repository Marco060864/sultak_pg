forward
global type w_listino_prezzi_cx from w_padre_figlio_nipote_cx
end type
type cb_rec_articoli from commandbutton within w_listino_prezzi_cx
end type
type cb_blocca from commandbutton within w_listino_prezzi_cx
end type
end forward

global type w_listino_prezzi_cx from w_padre_figlio_nipote_cx
integer width = 2971
integer height = 1716
cb_rec_articoli cb_rec_articoli
cb_blocca cb_blocca
end type
global w_listino_prezzi_cx w_listino_prezzi_cx

type prototypes
function boolean MoveFileA(ref string old, ref string new) Library "Kernel32.dll"
end prototypes

on w_listino_prezzi_cx.create
int iCurrent
call super::create
this.cb_rec_articoli=create cb_rec_articoli
this.cb_blocca=create cb_blocca
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_rec_articoli
this.Control[iCurrent+2]=this.cb_blocca
end on

on w_listino_prezzi_cx.destroy
call super::destroy
destroy(this.cb_rec_articoli)
destroy(this.cb_blocca)
end on

event resize;call super::resize;dw_3.x=dw_1.x
dw_3.y=dw_1.y+dw_1.height + 30
dw_3.width=this.width - 100
dw_1.width=this.width - 100 - dw_2.width - 30

dw_2.x=dw_1.x+ 30+ dw_1.width
dw_2.y=dw_1.y
dw_3.height=this.height - 470 - dw_1.height

cb_rec_articoli.x=cb_cancella.x + 261 +100
cb_rec_articoli.y=cb_cancella.y
 cb_blocca.x=cb_annulla.x - 380
 cb_blocca.y=cb_annulla.y
end event

event open;call super::open;long ll_id_vali
string ls_tipo_azienda

select tipo_azienda
into :ls_tipo_azienda
from dba.val_base;
choose case ls_tipo_azienda
	case 'N' 
		dw_3.dataobject="d_prezzo_negozio_gd"
		dw_3.settransobject(sqlca)
		ll_id_vali=dw_2.getitemnumber(dw_2.getrow(), "vali_id")
		dw_3.retrieve(ll_id_vali)
end choose
end event

type dw_3 from w_padre_figlio_nipote_cx`dw_3 within w_listino_prezzi_cx
integer x = 37
integer y = 656
integer width = 2866
integer height = 704
string dataobject = "d_prezzo_gd"
boolean vscrollbar = true
end type

type cb_ricerca from w_padre_figlio_nipote_cx`cb_ricerca within w_listino_prezzi_cx
integer x = 1742
integer y = 1400
end type

type dw_1 from w_padre_figlio_nipote_cx`dw_1 within w_listino_prezzi_cx
integer x = 37
integer width = 1897
integer height = 592
string dataobject = "d_listino_gd"
boolean vscrollbar = true
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;//
end event

type dw_2 from w_padre_figlio_nipote_cx`dw_2 within w_listino_prezzi_cx
integer x = 1966
integer y = 60
integer width = 928
integer height = 584
string dataobject = "d_validita_gd"
boolean vscrollbar = true
end type

type cb_inserisci from w_padre_figlio_nipote_cx`cb_inserisci within w_listino_prezzi_cx
integer x = 864
integer y = 1400
end type

type cb_salva from w_padre_figlio_nipote_cx`cb_salva within w_listino_prezzi_cx
integer x = 1152
integer y = 1400
end type

type cb_cancella from w_padre_figlio_nipote_cx`cb_cancella within w_listino_prezzi_cx
integer x = 1440
integer y = 1400
end type

type cb_annulla from w_padre_figlio_nipote_cx`cb_annulla within w_listino_prezzi_cx
integer x = 2034
integer y = 1396
end type

type cb_ok from w_padre_figlio_nipote_cx`cb_ok within w_listino_prezzi_cx
integer x = 2327
integer y = 1400
end type

type cb_rec_articoli from commandbutton within w_listino_prezzi_cx
integer x = 297
integer y = 1396
integer width = 507
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recupera Articoli"
end type

event clicked;DATASTORE ds_art
long ll_articoli, ll_id_art, ll_righe,ll_riga_trovata, i

ds_art=create datastore
ds_art.dataobject="d_art_gd"
ds_art.settransobject(sqlca)
ll_articoli=ds_art.retrieve()

ll_righe=dw_3.rowcount()

for i=1 to ll_articoli
	ll_id_art=ds_art.getitemnumber(i, "art_id")
	ll_riga_trovata=dw_3.find("art_id="+string(ll_id_art), 1, ll_righe)
	if ll_riga_trovata>0 then continue
	ll_riga_trovata=dw_3.trigger event ue_insert(0)
	dw_3.setitem(ll_riga_trovata, "art_id", ll_id_art)
	
	
next
	


end event

type cb_blocca from commandbutton within w_listino_prezzi_cx
integer x = 114
integer y = 1420
integer width = 320
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Blocca Tutto"
end type

event clicked;integer i
for i= 1 to dw_3.rowcount()
	dw_3.setitem(i, "ins_manuale", 1)	
	
next

end event

event rbuttondown;integer i
for i= 1 to dw_3.rowcount()
	dw_3.setitem(i, "ins_manuale", 0)	
	
next

end event

