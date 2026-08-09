forward
global type w_prova from w_base
end type
type ole_1 from olecontrol within w_prova
end type
type cb_3 from commandbutton within w_prova
end type
type cb_2 from commandbutton within w_prova
end type
type cb_1 from commandbutton within w_prova
end type
end forward

global type w_prova from w_base
integer x = 1056
integer y = 484
ole_1 ole_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_prova w_prova

on w_prova.create
int iCurrent
call super::create
this.ole_1=create ole_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
end on

on w_prova.destroy
call super::destroy
destroy(this.ole_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type ole_1 from olecontrol within w_prova
event queryinterface ( oleobject riid,  ref pointer ppvobj )
event addref ( )
event release ( )
event selectionchange ( oleobject target )
event beforedoubleclick ( oleobject target,  boolean cancel )
event beforerightclick ( oleobject target,  boolean cancel )
event activate ( )
event deactivate ( )
event calculate ( )
event change ( oleobject target )
event followhyperlink ( oleobject target )
event pivottableupdate ( oleobject target )
integer x = 77
integer y = 333
integer width = 2370
integer height = 986
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_prova.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type cb_3 from commandbutton within w_prova
integer x = 260
integer y = 112
integer width = 413
integer height = 106
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;
integer li_ret
string ls_path, ls_file, ls_name
long ll_rigains, ll_max
	
getfileopenname("Cerca file excel", ls_path, ls_name)
if  not(trim(ls_name)="" or isnull(ls_name)) then
	ole_1.open(ls_path)
	ole_1.object.activesheet.cells(2,1).value="pippo" 
	ls_file=left(ls_path, len(ls_path) - 3)+"_M.xls"
	ole_1.object.activesheet.saveas(ls_file)
//	dw_4.reset()
//	dw_4.importfile(Text!,ls_file)

	ole_1.object.close(False)
end if	 

end event

type cb_2 from commandbutton within w_prova
integer x = 2088
integer y = 150
integer width = 413
integer height = 106
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;int li_rtn
string ls_range
long ll_excel_rows

oleobject lole_excel, lole_workbook, lole_worksheet, lole_range
lole_excel = create oleobject
li_rtn = lole_excel.ConnectToNewObject("excel.application")
if li_rtn <> 0 then
      MessageBox( "Error", 'Error running MS Excel api.')
      destroy lole_Excel
else
  lole_excel.WorkBooks.Open("C:\dati\prova.xlt") 

  lole_workbook = lole_excel.application.workbooks(1)
  lole_worksheet = lole_workbook.worksheets(1)

  // Set the cell value
  lole_worksheet.cells(2,2).value = "2,A" //it is cells(line, column)

  //example to work on a range of cells
  ls_range = "A1:F1"+string(ll_excel_rows)
  lole_range = lole_worksheet.Range(ls_range)
  lole_range.Select
  lole_range.Locked = True

  // Save
 // lole_workbook.save("c:\start\spediz\prova111.xls")
  lole_workbook.SaveCopyAs("c:\start\pippo.xlt")
  // Quit
  lole_excel.application.quit()
  lole_excel.DisconnectObject()

  destroy lole_Excel
end if	 
end event

type cb_1 from commandbutton within w_prova
integer x = 1426
integer y = 109
integer width = 413
integer height = 106
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;any ioo_objTblColSeps[]
OLEObject ioo_objTblColSepsOLE[], ioo_objTable, ioo_objDesktop

long ll_p

ioo_objTable = ioo_objDesktop.getcurrentcomponent().getTextTables().getByIndex(0)
ioo_objTblColSeps = ioo_objTable.TableColumnSeparators //the any array here does the trick

//recover the any elements and put them on a OLEObject Array
for ll_p = 1 to  upperbound(ioo_objTblColSeps)
   ioo_objTblColSepsOLE[ll_p] = ioo_objTblColSeps[ll_p]
next

//Rem Change the positions of the two separators.
ioo_objTblColSepsOLE[1].Position = 7000 //this would give an error if the any array was used here
ioo_objTblColSepsOLE[2].Position = 9000
//REM You must assign the array back
ioo_objTable.TableColumnSeparators = ioo_objTblColSeps
end event

