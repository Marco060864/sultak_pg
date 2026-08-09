forward
global type w_art_barcode_cx from w_semplice_cx
end type
type cb_crea_cod_barre from commandbutton within w_art_barcode_cx
end type
end forward

global type w_art_barcode_cx from w_semplice_cx
integer width = 2651
integer height = 1556
cb_crea_cod_barre cb_crea_cod_barre
end type
global w_art_barcode_cx w_art_barcode_cx

forward prototypes
public function string wf_crea_ean8 (string barcode)
end prototypes

public function string wf_crea_ean8 (string barcode);string result
integer  Left_A, Left_B, Right, First_Flag, Second_Flag, Check_char,FFC, i
char A_o_B[10,5]

A_o_B[1,1] = "A"
A_o_B[1,2] = "A"
A_o_B[1,3] = "A"
A_o_B[1,4] = "A"
A_o_B[1,5] = "A"

A_o_B[2,1] = "A"
A_o_B[2,2] = "B"
A_o_B[2,3] = "A"
A_o_B[2,4] = "B"
A_o_B[2,5] = "B"

A_o_B[3,1] = "A"
A_o_B[3,2] = "B"
A_o_B[3,3] = "B"
A_o_B[3,4] = "A"
A_o_B[3,5] = "B"

A_o_B[4,1] = "A"
A_o_B[4,2] = "B"
A_o_B[4,3] = "B"
A_o_B[4,4] = "B"
A_o_B[4,5] = "A"

A_o_B[5,1] = "B"
A_o_B[5,2] = "A"
A_o_B[5,3] = "A"
A_o_B[5,4] = "B"
A_o_B[5,5] = "B"

A_o_B[6,1] = "B"
A_o_B[6,2] = "B"
A_o_B[6,3] = "A"
A_o_B[6,4] = "A"
A_o_B[6,5] = "B"

A_o_B[7,1] = "B"
A_o_B[7,2] = "B"
A_o_B[7,3] = "B"
A_o_B[7,4] = "A"
A_o_B[7,5] = "A"

A_o_B[8,1] = "B"
A_o_B[8,2] = "A"
A_o_B[8,3] = "B"
A_o_B[8,4] = "A"
A_o_B[8,5] = "B"

A_o_B[9,1] = "B"
A_o_B[9,2] = "A"
A_o_B[9,3] = "B"
A_o_B[9,4] = "B"
A_o_B[9,5] = "A"

A_o_B[10,1] = "B"
A_o_B[10,2] = "B"
A_o_B[10,3] = "A"
A_o_B[10,4] = "B"
A_o_B[10,5] = "A"

Left_A = 48
Left_B = 64
Right = 80
First_Flag = 33
Second_Flag = 96
Check_char = 112
Result = ""


if (Len(barcode)<> 8) or (not(IsNumber(barcode))) then
	messageBox("Alert", "Il codice non è un numero di 8 cifre")
	return Result
end if

FFC = integer(Mid(barCode,1,1))


result  = result + char(FFC + second_flag)

for i = 2 to 4
	
	if  A_o_B[FFC, i ]  =  "A" then
		
		result  = result + char(integer(Mid(barCode,i,1)) + Left_A)
	else
		
		result  = result + char(integer(Mid(barCode,i,1)) + Left_A)
	end if


next

result = result + "|"

for i = 5 to 7
	result  = result + char(integer(Mid(barCode,i,1)) + Right)
next

result  = result + char(integer(Mid(barCode,8,1)) + Check_char)
return Result
end function

on w_art_barcode_cx.create
int iCurrent
call super::create
this.cb_crea_cod_barre=create cb_crea_cod_barre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_crea_cod_barre
end on

on w_art_barcode_cx.destroy
call super::destroy
destroy(this.cb_crea_cod_barre)
end on

event resize;dw_1.width=newwidth - 105
dw_1.height=newheight - 292

cb_inserisci.y=newheight - 224
cb_inserisci.x=dw_1.x
cb_cancella.y=newheight - 224
cb_salva.y=newheight - 224
cb_salva.x=cb_inserisci.x + 285
cb_cancella.x=cb_salva.x + 282





cb_ok.y=newheight - 224
cb_ok.x=dw_1.x + dw_1.width - cb_ok.width
cb_ricerca.y=newheight - 224
cb_ricerca.x=cb_ok.x - 285
cb_annulla.y=newheight - 224
cb_annulla.x=cb_ok.x  - cb_annulla.width
cb_ricerca.y=newheight - 224
cb_ricerca.x=cb_annulla.x - 285
cb_stampa.x=cb_cancella.x + 285
cb_stampa.y=cb_salva.y

cb_primo.y=newheight - 208
cb_primo.x=cb_stampa.x + 280
cb_indietro.y=newheight - 208
cb_indietro.x=cb_primo.x + 160
cb_avanti.y=newheight - 208
cb_avanti.x=cb_indietro.x + 128
cb_ultimo.y=newheight - 208
cb_ultimo.x=cb_avanti.x + 150
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_art_barcode_cx
integer x = 745
integer y = 1088
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_art_barcode_cx
end type

type cb_primo from w_semplice_cx`cb_primo within w_art_barcode_cx
boolean visible = true
integer x = 1189
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_art_barcode_cx
boolean visible = true
integer x = 1550
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_art_barcode_cx
boolean visible = true
integer x = 1330
end type

event cb_indietro::clicked;call super::clicked;integer ll_riga_corrente
ll_riga_corrente=dw_1.getrow()
if ll_riga_corrente>1 then
	dw_1.scrolltorow(ll_riga_corrente - 1)
end if

end event

type cb_avanti from w_semplice_cx`cb_avanti within w_art_barcode_cx
boolean visible = true
integer x = 1440
end type

event cb_avanti::clicked;call super::clicked;integer ll_riga_corrente
ll_riga_corrente=dw_1.getrow()
if ll_riga_corrente<dw_1.rowcount() then
	dw_1.scrolltorow(ll_riga_corrente + 1)
end if
end event

type dw_1 from w_semplice_cx`dw_1 within w_art_barcode_cx
integer width = 2565
string dataobject = "d_art_barcode_ff"
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_art_barcode_cx
integer x = 32
end type

type cb_salva from w_semplice_cx`cb_salva within w_art_barcode_cx
integer x = 315
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_art_barcode_cx
integer x = 603
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_art_barcode_cx
end type

type cb_ok from w_semplice_cx`cb_ok within w_art_barcode_cx
end type

type cb_crea_cod_barre from commandbutton within w_art_barcode_cx
integer x = 114
integer y = 812
integer width = 439
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Codice a Barre"
end type

event clicked;string ls_stato, ls_fornitore, ls_progressivo, ls_check, ls_codice, ls_codice_ok


long ll_id_art


select max(art_id)

into :ll_id_art
from dba.art
;
if isnull(ll_id_art) then ll_id_art=0
ll_id_art+=1
dw_1.SETITEM(dw_1.getrow(), "num_per_barcode", ll_id_art)

ls_stato='80'
ls_fornitore="55555"
//ls_fornitore=""
ls_progressivo=string(ll_id_art)
do while len(ls_progressivo)<5 
	ls_progressivo="0"+ls_progressivo
loop

ls_codice= ls_stato+ls_fornitore+ls_progressivo
ls_check=string(f_check_digit(ls_codice, 13))
//ls_check=string(wf_check_digit(ls_codice, 8))
ls_codice= ls_stato+ls_fornitore+ls_progressivo+ls_check
ls_codice_ok=f_crea_ean13(ls_codice)
//ls_codice_ok=wf_crea_ean8(ls_codice)

dw_1.setitem(dw_1.getrow(), "barcode",ls_codice_ok)
end event

