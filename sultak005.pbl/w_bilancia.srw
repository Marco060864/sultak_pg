forward
global type w_bilancia from w_base
end type
type ole_1 from olecustomcontrol within w_bilancia
end type
end forward

global type w_bilancia from w_base
boolean visible = false
integer width = 649
integer height = 540
ole_1 ole_1
end type
global w_bilancia w_bilancia

forward prototypes
public function decimal f_rendi_peso ()
end prototypes

public function decimal f_rendi_peso ();string Buffer, buffer2, ls_bilancia
integer li_pos, li_pos_2
decimal ldc_peso_netto
string ls_peso
boolean lb_test
//' Open the serial port


ls_bilancia = ProfileString ( "sultak.ini", "PC", "Bilancia", "Error!" )

choose case ls_bilancia
	case "radwag"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "9600,N,8,1"
		OLE_1.object.PortOpen = True           //' Required, might lock port
		sleep(1)
		Buffer = OLE_1.object.Input //' Read data
		 
		OLE_1.object.PortOpen = False
		
		ls_peso=mid(buffer,7, 9)  

		li_pos=pos(ls_peso, ".")
		ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
		ldc_peso_netto=dec(ls_peso)
	case "mettler"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "9600,E,7,1"
		OLE_1.object.PortOpen = True           //' Required, might lock port
		sleep(1)
		Buffer = OLE_1.object.Input //' Read data
		 
		OLE_1.object.PortOpen = False
		li_pos=pos(buffer, "S")
		ls_peso=mid(buffer, li_pos+2, 10)  

		li_pos=pos(ls_peso, ".")
		ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
		ldc_peso_netto=dec(ls_peso)
		
	case "sartorius gp6100"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "1200,O,7,1"  //' Set UART parameters

		OLE_1.object.PortOpen = True           //' Required, might lock port
 
		sleep(1)
  //MsComm1.Output = "Text string"    ' Send data
		Buffer = OLE_1.object.Input //' Read data
 
		OLE_1.object.PortOpen = False
		if len(buffer)>30 then
			li_pos=pos(Buffer, "+", 16)
		else
			li_pos=pos(Buffer, "+", 1)
		end if
	  ls_peso=mid(buffer, li_pos, 11)
	  ls_peso=left(ls_peso, 10)
	  ls_peso=right(ls_peso, 9)
		ls_peso=trim(ls_peso)
		li_pos=pos(ls_peso, ".")
		ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
		ldc_peso_netto=dec(ls_peso)
		
		
	case "sartorius"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "1200,N,7,1"  //' Set UART parameters

		OLE_1.object.PortOpen = True           //' Required, might lock port
 
		sleep(1)
  //MsComm1.Output = "Text string"    ' Send data
		Buffer = OLE_1.object.Input //' Read data
 
		OLE_1.object.PortOpen = False
		if len(buffer)>30 then
			li_pos=pos(Buffer, "+", 16)
		else
			li_pos=pos(Buffer, "+", 1)
		end if
	  ls_peso=mid(buffer, li_pos, 11)
	  ls_peso=left(ls_peso, 10)
	  ls_peso=right(ls_peso, 9)
		ls_peso=trim(ls_peso)
		li_pos=pos(ls_peso, ".")
		ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
		ldc_peso_netto=dec(ls_peso)
		
	case "strumenta"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "4800,N,8,1"  //' Set UART parameters

		OLE_1.object.PortOpen = True           //' Required, might lock port
 
		sleep(1)
  //MsComm1.Output = "Text string"    ' Send data
		Buffer = OLE_1.object.Input //' Read data
		OLE_1.object.PortOpen = False
		LI_POS=POS(buffer, "GS", 1)
		 //messagebox("inizio", li_pos)
		if li_pos>0 then
			li_pos_2=POS(buffer, "g", li_pos)
			//messagebox("Fine", li_pos_2)
			ls_peso=mid(buffer, li_pos+3, 9)
			li_pos=pos(ls_peso, ".")
			ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
			ls_peso=trim(ls_peso)
			ldc_peso_netto=dec(ls_peso)
		else
			messagebox("Attenzione!", "Errore Strumenta, GS non trovato!")
		end if
	case "strumenta2"
		OLE_1.object.CommPort = 1  //' Set the port number 

		OLE_1.object.Settings = "9600,N,8,1"  //' Set UART parameters

		OLE_1.object.PortOpen = True           //' Required, might lock port
 
		sleep(1)
  //MsComm1.Output = "Text string"    ' Send data
		Buffer = OLE_1.object.Input //' Read data
		OLE_1.object.PortOpen = False
		//messagebox("W", buffer)
		LI_POS=POS(buffer, "GS", 1)
		 //messagebox("inizio", li_pos)
		if li_pos>0 then
			li_pos_2=POS(buffer, "g", li_pos)
			//messagebox("Fine", li_pos_2)
			ls_peso=mid(buffer, li_pos+3, 9)
			li_pos=pos(ls_peso, ".")
			ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
			ls_peso=trim(ls_peso)
			ldc_peso_netto=dec(ls_peso)
		else
			messagebox("Attenzione!", "Errore Strumenta2, GS non trovato!")
		end if
end choose
//messagebox("A", string(ldc_peso_netto, "#,0.00"))
return ldc_peso_netto
end function

on w_bilancia.create
int iCurrent
call super::create
this.ole_1=create ole_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
end on

on w_bilancia.destroy
call super::destroy
destroy(this.ole_1)
end on

type ole_1 from olecustomcontrol within w_bilancia
event oncomm ( )
boolean visible = false
integer x = 37
integer y = 32
integer width = 174
integer height = 152
integer taborder = 10
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "w_bilancia.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

