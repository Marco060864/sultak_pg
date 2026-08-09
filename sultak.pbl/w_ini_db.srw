forward
global type w_ini_db from w_pop
end type
type cb_1 from commandbutton within w_ini_db
end type
end forward

global type w_ini_db from w_pop
integer x = 1056
integer y = 484
integer width = 1434
integer height = 762
boolean resizable = false
windowtype windowtype = response!
cb_1 cb_1
end type
global w_ini_db w_ini_db

on w_ini_db.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ini_db.destroy
call super::destroy
destroy(this.cb_1)
end on

event open;call super::open;dw_1.insertrow(1)
dw_1.setitem(1, "db", "sultak")
end event

event close;call super::close;message.stringparm=dw_1.getitemstring(1, "db")
end event

type dw_1 from w_pop`dw_1 within w_ini_db
integer width = 1221
string dataobject = "d_inserisci_db"
end type

type cb_1 from commandbutton within w_ini_db
integer x = 468
integer y = 531
integer width = 413
integer height = 106
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;// se il file non esiste viene creato
string returnValue
integer li_FileNum

li_FileNum = FileOpen("c:\sultak\sultak.ini", StreamMode!, Write!)
integer il_res
string sl_INI_text
sl_INI_text = "[Database]~r~nNome = "+dw_1.getitemstring(1, "db")+"~r~n"
il_res = FileWrite(li_FileNum, sl_INI_text)
if il_res=-1 then
	MessageBox("Alert","Errore nella scrittura")
	returnValue = ""
end if

il_res = FileClose(li_FileNum)
if il_res=-1 then
	MessageBox("Alert","Errore nella chiusura del file")
	returnValue = ""
end if

returnValue = dw_1.getitemstring(1, "db")
close(parent)


end event

