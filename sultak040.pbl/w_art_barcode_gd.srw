forward
global type w_art_barcode_gd from w_semplice_gd
end type
type cb_crea_barcode from commandbutton within w_art_barcode_gd
end type
type cbx_seleziona from checkbox within w_art_barcode_gd
end type
type cb_st_barcode from commandbutton within w_art_barcode_gd
end type
type cbx_a4 from checkbox within w_art_barcode_gd
end type
end forward

global type w_art_barcode_gd from w_semplice_gd
integer width = 3401
cb_crea_barcode cb_crea_barcode
cbx_seleziona cbx_seleziona
cb_st_barcode cb_st_barcode
cbx_a4 cbx_a4
end type
global w_art_barcode_gd w_art_barcode_gd

on w_art_barcode_gd.create
int iCurrent
call super::create
this.cb_crea_barcode=create cb_crea_barcode
this.cbx_seleziona=create cbx_seleziona
this.cb_st_barcode=create cb_st_barcode
this.cbx_a4=create cbx_a4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_crea_barcode
this.Control[iCurrent+2]=this.cbx_seleziona
this.Control[iCurrent+3]=this.cb_st_barcode
this.Control[iCurrent+4]=this.cbx_a4
end on

on w_art_barcode_gd.destroy
call super::destroy
destroy(this.cb_crea_barcode)
destroy(this.cbx_seleziona)
destroy(this.cb_st_barcode)
destroy(this.cbx_a4)
end on

event resize;call super::resize;cb_crea_barcode.y=newheight - 224
cb_crea_barcode.x=cb_ricerca.x - 285

cbx_seleziona.y=cb_annulla.y + 100
cbx_seleziona.x=cb_annulla.x 

cbx_a4.x=cbx_seleziona.x - 250
cbx_a4.y=cbx_seleziona.y 
cb_st_barcode.y=cb_cancella.y 
cb_st_barcode.x=cb_cancella.x + 655


end event

type cb_stampa from w_semplice_gd`cb_stampa within w_art_barcode_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_art_barcode_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_art_barcode_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_art_barcode_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_art_barcode_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_art_barcode_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_art_barcode_gd
integer width = 3278
string dataobject = "d_art_barcode_gd"
end type

event dw_1::updatestart;call super::updatestart;long i , ll_righe, ll_test
string ls_barcode

ll_righe=rowcount()

for i = 1 to ll_righe - 1
	ls_barcode=getitemstring(i, "barcode")
	if ls_barcode> " " then
		ll_test=find("barcode='"+ls_barcode+"'", i+1, ll_righe)
		if ll_test>0 then
			messagebox("Attenzione!", "Il barcode= '"+ls_barcode+"' presente alla riga "+string(i)+" esiste anche alla riga "+string(ll_test))
		end if
	end if
next
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_art_barcode_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_art_barcode_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_art_barcode_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_art_barcode_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_art_barcode_gd
end type

type cb_crea_barcode from commandbutton within w_art_barcode_gd
integer x = 1417
integer y = 980
integer width = 261
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Barcode"
end type

event clicked;integer i, li_test, li_prog,ll_righe
string ls_fornitore, ls_max_barcode, ls_stato, ls_progressivo,ls_check,ls_test
datastore ds_prog

ls_stato='80'
select cod_fo_ean13
into :ls_fornitore
from dba.val_base
;
if isnull(ls_fornitore) then
	ls_fornitore="55555"
end if
do while  len(ls_fornitore) < 5 
	ls_fornitore="0"+ls_fornitore
loop
ds_prog=create datastore
ds_prog.dataobject="ds_prog_barcode_art"
ds_prog.settransobject(sqlca)
ll_righe=ds_prog.retrieve()
ls_max_barcode=ds_prog.getitemstring(ll_righe, "c_prog_art")
li_prog=long(ls_max_barcode)
if isnull(li_prog) then
	li_prog= 0
end if


for i = 1 to dw_1.rowcount()
	li_test=dw_1.getitemnumber(i, "scelto")
	if li_test=1 then
		ls_test=""
		ls_test=dw_1.getitemstring(i, "barcode")
		if len(ls_test)=13 then continue
		
		li_prog++
		ls_progressivo=string(li_prog)
		do while  len(ls_progressivo) < 5 
			ls_progressivo="0"+ls_progressivo
		loop
		ls_max_barcode= ls_stato+ls_fornitore+ls_progressivo
		ls_check=string(f_check_digit(ls_max_barcode, 13))
		ls_max_barcode+=ls_check
		dw_1.setitem(i, "barcode", ls_max_barcode)

	end if
next
cb_salva.triggerevent(Clicked!)
end event

type cbx_seleziona from checkbox within w_art_barcode_gd
integer x = 1760
integer y = 1096
integer width = 507
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleziona Tutti"
end type

event clicked;integer i

if checked then
	for i= 1 to dw_1.rowcount()
		dw_1.setitem(i, "scelto", 1)
	next
else
	for i= 1 to dw_1.rowcount()
		dw_1.setitem(i, "scelto", 0)
	next
end if
end event

type cb_st_barcode from commandbutton within w_art_barcode_gd
integer x = 439
integer y = 1228
integer width = 320
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ST. Barcode"
end type

event clicked;s_sel_stampa s_stampa

s_stampa.s_dw=dw_1
if cbx_a4.checked then
	S_STAMPA.s_cl_fo="A4"
end if
openwithparm(w_barcode_st, s_stampa)
end event

type cbx_a4 from checkbox within w_art_barcode_gd
integer x = 1760
integer y = 1180
integer width = 215
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "A4"
end type

