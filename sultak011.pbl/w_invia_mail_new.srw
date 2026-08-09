forward
global type w_invia_mail_new from w_pop
end type
type cb_1 from commandbutton within w_invia_mail_new
end type
type dw_2 from udw_001 within w_invia_mail_new
end type
type cbx_logfile from checkbox within w_invia_mail_new
end type
type cbx_debugviewer from checkbox within w_invia_mail_new
end type
type lb_attachments from listbox within w_invia_mail_new
end type
type cbx_sendhtml from checkbox within w_invia_mail_new
end type
type cb_inserisci from commandbutton within w_invia_mail_new
end type
type cb_salva from commandbutton within w_invia_mail_new
end type
type cb_cancella from commandbutton within w_invia_mail_new
end type
type cb_allegati from commandbutton within w_invia_mail_new
end type
type cb_canc_allegati from commandbutton within w_invia_mail_new
end type
type dw_3 from udw_001 within w_invia_mail_new
end type
type rb_solo_mail from radiobutton within w_invia_mail_new
end type
type rb_solo_pec from radiobutton within w_invia_mail_new
end type
type rb_entrambe from radiobutton within w_invia_mail_new
end type
type cb_mailsend from commandbutton within w_invia_mail_new
end type
type cb_2 from commandbutton within w_invia_mail_new
end type
end forward

global type w_invia_mail_new from w_pop
integer width = 3287
integer height = 1828
boolean resizable = false
windowtype windowtype = response!
cb_1 cb_1
dw_2 dw_2
cbx_logfile cbx_logfile
cbx_debugviewer cbx_debugviewer
lb_attachments lb_attachments
cbx_sendhtml cbx_sendhtml
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
cb_allegati cb_allegati
cb_canc_allegati cb_canc_allegati
dw_3 dw_3
rb_solo_mail rb_solo_mail
rb_solo_pec rb_solo_pec
rb_entrambe rb_entrambe
cb_mailsend cb_mailsend
cb_2 cb_2
end type
global w_invia_mail_new w_invia_mail_new

type prototypes

end prototypes

type variables
n_smtp gn_smtp
string is_tipo_ae
long il_id_doc
end variables

forward prototypes
public function string of_replace_all (string as_oldstring, string as_findstr, string as_replace)
public function string wf_rec_dati_server (string ls_dato_richiesto)
public function string of_getreg (string as_entry, string as_default)
end prototypes

public function string of_replace_all (string as_oldstring, string as_findstr, string as_replace);String ls_newstring
Long ll_findstr, ll_replace, ll_pos

// get length of strings
ll_findstr = Len(as_findstr)
ll_replace = Len(as_replace)

// find first occurrence
ls_newstring = as_oldstring
ll_pos = Pos(ls_newstring, as_findstr)

Do While ll_pos > 0
	// replace old with new
	ls_newstring = Replace(ls_newstring, ll_pos, ll_findstr, as_replace)
	// find next occurrence
	ll_pos = Pos(ls_newstring, as_findstr, (ll_pos + ll_replace))
Loop

Return ls_newstring
end function

public function string wf_rec_dati_server (string ls_dato_richiesto);string ls_return
long ll_riga_corrente

ll_riga_corrente=dw_2.getrow()
ls_return=dw_2.getitemstring(ll_riga_corrente, ls_dato_richiesto)
return ls_return
end function

public function string of_getreg (string as_entry, string as_default);String ls_regkey, ls_regvalue

ls_regkey = "HKEY_CURRENT_USER\Software\TopWiz\EmailSMTP"

RegistryGet(ls_regkey, as_entry, ls_regvalue)
If ls_regvalue = "" Then
	ls_regvalue = as_default
End If

Return ls_regvalue

end function

on w_invia_mail_new.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_2=create dw_2
this.cbx_logfile=create cbx_logfile
this.cbx_debugviewer=create cbx_debugviewer
this.lb_attachments=create lb_attachments
this.cbx_sendhtml=create cbx_sendhtml
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_allegati=create cb_allegati
this.cb_canc_allegati=create cb_canc_allegati
this.dw_3=create dw_3
this.rb_solo_mail=create rb_solo_mail
this.rb_solo_pec=create rb_solo_pec
this.rb_entrambe=create rb_entrambe
this.cb_mailsend=create cb_mailsend
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cbx_logfile
this.Control[iCurrent+4]=this.cbx_debugviewer
this.Control[iCurrent+5]=this.lb_attachments
this.Control[iCurrent+6]=this.cbx_sendhtml
this.Control[iCurrent+7]=this.cb_inserisci
this.Control[iCurrent+8]=this.cb_salva
this.Control[iCurrent+9]=this.cb_cancella
this.Control[iCurrent+10]=this.cb_allegati
this.Control[iCurrent+11]=this.cb_canc_allegati
this.Control[iCurrent+12]=this.dw_3
this.Control[iCurrent+13]=this.rb_solo_mail
this.Control[iCurrent+14]=this.rb_solo_pec
this.Control[iCurrent+15]=this.rb_entrambe
this.Control[iCurrent+16]=this.cb_mailsend
this.Control[iCurrent+17]=this.cb_2
end on

on w_invia_mail_new.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.cbx_logfile)
destroy(this.cbx_debugviewer)
destroy(this.lb_attachments)
destroy(this.cbx_sendhtml)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_allegati)
destroy(this.cb_canc_allegati)
destroy(this.dw_3)
destroy(this.rb_solo_mail)
destroy(this.rb_solo_pec)
destroy(this.rb_entrambe)
destroy(this.cb_mailsend)
destroy(this.cb_2)
end on

event open;call super::open;s_e_mail ls_mail
integer i
long ll_riga


dw_1.insertrow(1)

dw_2.settransobject(sqlca)
dw_2.retrieve()

dw_3.settransobject(sqlca)

ls_mail=message.powerobjectparm
if isvalid(ls_mail) then
	for i= 1 to upperbound(ls_mail.s_allegato)
		lb_attachments.AddItem ( ls_mail.s_allegato[i])
	next
	is_tipo_ae=ls_mail.s_tipo_ae
	il_id_doc=ls_mail.l_id_doc
end if


if ls_mail.s_email_1> " " then
	dw_1.setitem(1, "destinatario", ls_mail.s_email_1)
end if
if isnull(ls_mail.s_testo) or ls_mail.s_testo=" " then ls_mail.s_testo= "  " 
dw_1.setitem(1, "testo", ls_mail.s_testo)

if  ls_mail.s_oggetto> " " then
	dw_1.setitem(1, "oggetto", ls_mail.s_oggetto)
end if
ll_riga=dw_2.find("codice= 'MAIL'", 1, 1000000)
dw_2.scrolltorow(ll_riga)
end event

type dw_1 from w_pop`dw_1 within w_invia_mail_new
integer x = 50
integer y = 52
integer width = 2007
integer height = 704
string dataobject = "d_posta_ex_new"
end type

type cb_1 from commandbutton within w_invia_mail_new
boolean visible = false
integer x = 2807
integer y = 1604
integer width = 411
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Invia"
end type

event clicked;String ls_body, ls_server, ls_uid, ls_pwd, ls_invia_mail, ls_campo_mail, ls_oggetto, ls_testo
String ls_filename, ls_port, ls_encrypt, ls_errormsg,ls_destinatario
Integer li_idx, li_max, i, li_pos, a, b, li_pos_2, li_destinatari_selezionati
Boolean lb_html, lb_Return
UInt lui_port
datetime ldt_data_ora_invio
string ls_send_email, ls_send_nome, ls_mittente, ls_nome_mittente, ls_allegati
long ll_riga_testa, ll_riga_mail, ll_id_invio
SetPointer(HourGlass!)

rb_solo_mail.checked=true

rb_solo_mail.triggerevent (clicked!)
dw_1.accepttext()
ls_mittente=wf_rec_dati_server("mittente")
if messagebox("Attenzione!", ls_mittente+ " invierà la mail e i suoi allegati agli indirizzi selezionati, va bene?", Stopsign!, yesno!)=1 then

	ls_server=wf_rec_dati_server("smtp")
	If ls_server = "" Then
		MessageBox("Edit Error", &
			"You must specify Server on the Settings tab first!", StopSign!)
		Return
	End If
	
	ls_oggetto=dw_1.getitemstring(1, "oggetto")
	If ls_oggetto= "" or isnull(ls_oggetto) Then
		MessageBox("Edit Error", &
		"Il campo Oggetto non può essere vuoto!", StopSign!)
		Return
	End If
	if left(is_tipo_ae, 2)<> "TD" then
		ls_testo=dw_1.getitemstring(1, "testo")
		If ls_testo = "" or isnull(ls_testo) Then
			MessageBox("Edit Error", "Il testo è richiesto!", StopSign!)
			Return
		End If
	
	end if
	ls_mittente=wf_rec_dati_server("mittente")
	//ls_indirizzo_mittente=wf_rec_dati_server("user_id")
	ls_nome_mittente=wf_rec_dati_server("nome_mittente")
	If Not gn_smtp.of_ValidEmail(ls_mittente, ls_errormsg) Then
		//sle_from_email.SetFocus()
		MessageBox("Edit Error", ls_errormsg, StopSign!)
		Return
	End If
	
	
	If cbx_sendhtml.Checked Then
		ls_body  = "<html><body bgcolor='#FFFFFF' topmargin=8 leftmargin=8><h2>"
		ls_body += of_replace_all(ls_testo, "~r~n", "<br>") + "</h2>"
		ls_body += "</body></html>"
		lb_html = True
	Else
		ls_body = ls_testo
		lb_html = False
	End If
	
	lui_port= long(wf_rec_dati_server("porta"))
	
	// *** set email properties *********************
	gn_smtp.of_ResetAll()
	gn_smtp.of_SetPort(lui_port)
	gn_smtp.of_SetServer(ls_server)
	gn_smtp.of_SetLogFile(cbx_logfile.Checked, "smtp_logfile8.txt")
	gn_smtp.of_SetDebugViewer(cbx_debugviewer.Checked)
	gn_smtp.of_SetSubject(ls_oggetto)
	gn_smtp.of_SetBody(ls_body, lb_html)
	gn_smtp.of_SetFrom(ls_mittente, ls_nome_mittente)
	
	//mando la copia a me stesso per verifica
	gn_smtp.of_AddAddress(ls_mittente, ls_nome_mittente)
	If Not gn_smtp.of_ValidEmail(ls_mittente, ls_errormsg) Then
		//sle_send_email.SetFocus()
		MessageBox("Edit Error", ls_errormsg, StopSign!)
		Return
	End If
	ls_destinatario=dw_1.getitemstring(1, "destinatario")
	if is_tipo_ae> "TD" then //è un fat elettronica il destinatario è da recuperare in azienda, HUB_ae
		select hub_ae
		into :ls_destinatario
		from dba.azienda
		;
		if isnull(ls_destinatario) or ls_destinatario<" " then
			messagebox("Attenzione!", "Non è specificato a quale HUB inviare la Fat-elettronica. Campo HUB_ae tabella AZIENDA! Invio interrotto!")
			return
		end if
	end if
	//aggiungo testa alla dw che memorizza i dati invio
	ll_riga_testa=dw_3.insertrow(0)
	dw_3.setitem(ll_riga_testa, "mittente", ls_mittente)
	dw_3.setitem(ll_riga_testa, "data_ora", today())
	//ls_condominio=dw_3.getitemstring(dw_3.getrow(), "condominio")

	dw_3.setitem(ll_riga_testa, "destinatario", ls_destinatario)
	dw_3.trigger event ue_update()
	ll_id_invio=dw_3.getitemnumber(ll_riga_testa, "id_invio")
	if ll_id_invio>0 then
			ls_send_email=""
			ls_send_nome=""
			ls_send_nome=ls_destinatario
			ls_send_email=ls_destinatario
			li_pos=pos(ls_mittente, ";")
			if li_pos>0 then //ci sono più indirizzi mail indicati nel campo mail: devo dividerli
				a=1
				do while li_pos>0
					ls_invia_mail=mid(ls_send_email, a, li_pos  - a)
					gn_smtp.of_AddAddress(ls_invia_mail, ls_send_nome)
					If Not gn_smtp.of_ValidEmail(ls_invia_mail, ls_errormsg) Then
						//sle_send_email.SetFocus()
						MessageBox("Edit Error", ls_errormsg, StopSign!)
						Return
					End If
					//memorizzo mail, nome, data_ora per il report ricevuta
					ll_riga_mail=dw_3.insertrow(0)
					dw_3.setitem(ll_riga_testa, "id_invio", ll_id_invio)
					dw_3.setitem(ll_riga_testa, "mittente", ls_invia_mail)
					dw_3.setitem(ll_riga_testa, "destinatario", ls_send_nome)
					//dw_3.setitem(ll_riga_testa,"avviso", ls_body)
					a=li_pos+1
					li_pos=pos(ls_send_email, ";", a)
					if li_pos<=0 then
						li_pos_2=pos(ls_send_email, "@", a)
						if li_pos_2>0 then  //c'è un altro indirizzo, recuperiamolo
							ls_invia_mail=mid(ls_send_email, a, len(ls_send_email) - a +1)
							gn_smtp.of_AddAddress(ls_invia_mail, ls_send_nome)
							If Not gn_smtp.of_ValidEmail(ls_invia_mail, ls_errormsg) Then
								//sle_send_email.SetFocus()
								MessageBox("Edit Error", ls_errormsg, StopSign!)
								Return
							End If
							ll_riga_mail=dw_3.insertrow(0)
							dw_3.setitem(ll_riga_testa, "id_invio", ll_id_invio)
							dw_3.setitem(ll_riga_testa, "mittente", ls_invia_mail)
							dw_3.setitem(ll_riga_testa, "destinatario", ls_send_nome)
							//dw_3.setitem(ll_riga_testa,"avviso", ls_body)
						end if
					end if
				loop
				
			else
				//gn_smtp.of_AddAddress(sle_send_email.text, sle_send_name.text)
				gn_smtp.of_AddAddress(ls_send_email, ls_send_nome)
				If Not gn_smtp.of_ValidEmail(ls_send_email, ls_errormsg) Then
					//sle_send_email.SetFocus()
					MessageBox("Edit Error", ls_errormsg, StopSign!)
					Return
				End If
				//ll_riga_mail=dw_3.insertrow(0)
				dw_3.setitem(ll_riga_testa, "id_invio", ll_id_invio)
				dw_3.setitem(ll_riga_testa, "mittente", ls_send_email)
				dw_3.setitem(ll_riga_testa, "destinatario", ls_send_nome)
				//dw_3.setitem(ll_riga_testa,"avviso", ls_body)
			end if
			
	
		if dw_3.trigger event ue_update()<>1 then
			MessageBox("Attenzione!", "Errore nel salvataggio del report 'RICEVUTA LISTA'. Contattare l'assistenza!")
		end if

	dw_1.setfilter("")
	dw_1.filter()
	//fine 2016-05-11
	
	// *** set Userid/Password if required **********
	//If of_getreg("Auth", "N") = "Y" Then
	if wf_rec_dati_server("auth")= "Y" then
		ls_uid = wf_rec_dati_server("user_id")//of_getreg("Userid", "")
		ls_pwd =wf_rec_dati_server("password")// of_getreg("Password", "")
		gn_smtp.of_SetLogin(ls_uid, ls_pwd)
	End If
	
	// *** add any attachments **********************
	li_max = lb_attachments.TotalItems()
	For li_idx = 1 To li_max
		ls_filename = lb_attachments.Text(li_idx)
		gn_smtp.of_AddAttachment(ls_filename)
		ls_allegati+=ls_filename+";"
	Next
	dw_3.setitem(ll_riga_testa,"allegati", ls_allegati)
	// *** send the message *************************
	ls_encrypt = of_getreg("Encrypt", "None")
	ls_encrypt=wf_rec_dati_server("ssl")
	//guardo se la fat è già stata inviata
	if is_tipo_ae> "TD" then
		select data_ora_invio
		into :ldt_data_ora_invio
		from dba.FE_invio
		where doc_id=:il_id_doc
		;
		if string(ldt_data_ora_invio, "yyyy-mm-dd hh:mm")> string(datetime("2018-12-01"),"yyyy-mm-dd hh:mm")   then
			if messagebox("Attenzione!", "Il documento è stato già inviato una volta ("+ string(ldt_data_ora_invio, "yyyy-mm-dd hh:mm")+"). Vuoi inviarlo ancora lo stesso?", stopsign!, yesno!)=2 then
				return
			end if
		end if
	end if
	//fien controllo
	choose case ls_encrypt
		case "SSL"
			lb_Return = gn_smtp.of_SendSSLMail()
		case "TLS"
			lb_Return = gn_smtp.of_SendTLSMail()
		case else
			lb_Return = gn_smtp.of_SendMail()
	end choose
	
	If lb_Return Then
		MessageBox("SendMail", "Mail successfully sent!")
		dw_3.setitem(ll_riga_testa, "invio_ok", "S")
		//memorizzo oggetto e testo per riproporli la prossima volta
		//SetProfileString ( "ermes.ini", "Ultima_Mail", "Oggetto", ls_oggetto)
		//SetProfileString ( "ermes.ini", "Ultima_Mail", "Testo", ls_testo )
		//SE è una Fat. elettronica aggiorno il cntatore e salvo i dati nella FE_invio
		if is_tipo_ae> "TD" then
			f_salva_invio(il_id_doc)
			post close(parent)
		END IF
	Else
		MessageBox("SendMail Error", gn_smtp.of_GetLastError())
		dw_3.setitem(ll_riga_testa, "invio_ok", "N")
	End If
	if dw_3.trigger event ue_update()<>1 then
		MessageBox("Attenzione!", "Errore nel salvataggio ESITO INVIO. Contattare l'assistenza!")
	end if
	end if
else
	MessageBox("Attenzione!", "Errore nel salvataggio del report 'RICEVUTA'. Contattare l'assistenza!")
end if

end event

type dw_2 from udw_001 within w_invia_mail_new
integer x = 50
integer y = 1268
integer width = 3159
integer height = 276
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_dati_mail"
end type

type cbx_logfile from checkbox within w_invia_mail_new
integer x = 2094
integer y = 900
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Log File"
boolean checked = true
end type

type cbx_debugviewer from checkbox within w_invia_mail_new
integer x = 2400
integer y = 900
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Debug"
end type

type lb_attachments from listbox within w_invia_mail_new
integer x = 2094
integer y = 52
integer width = 1138
integer height = 704
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cbx_sendhtml from checkbox within w_invia_mail_new
integer x = 2683
integer y = 900
integer width = 242
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "HTLM"
boolean checked = true
end type

type cb_inserisci from commandbutton within w_invia_mail_new
integer x = 55
integer y = 1592
integer width = 411
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;long ll_riga
ll_riga=dw_2.trigger event ue_insert(0)
end event

type cb_salva from commandbutton within w_invia_mail_new
integer x = 617
integer y = 1592
integer width = 411
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_2.accepttext()
dw_2.trigger event ue_update()
end event

type cb_cancella from commandbutton within w_invia_mail_new
integer x = 1189
integer y = 1592
integer width = 411
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
ll_riga_da_cancellare=dw_2.getrow()
dw_2.trigger event ue_delete(ll_riga_da_cancellare)	
end event

type cb_allegati from commandbutton within w_invia_mail_new
integer x = 2103
integer y = 768
integer width = 370
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiungi"
end type

event clicked;String ls_pathname, ls_filename, ls_filter
Integer li_rc

ls_filter = "All files,*.*"

li_rc = GetFileOpenName("Select File to Attach", &
		ls_pathname, ls_filename, "", ls_filter)

If li_rc = 1 Then
	lb_attachments.AddItem(ls_pathname)
End If
end event

type cb_canc_allegati from commandbutton within w_invia_mail_new
integer x = 2853
integer y = 772
integer width = 370
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;// delete attachment

Integer li_row

li_row = lb_attachments.SelectedIndex()
If li_row > 0 Then
	lb_attachments.DeleteItem(li_row)
End If
end event

type dw_3 from udw_001 within w_invia_mail_new
integer x = 50
integer y = 772
integer width = 2021
integer height = 484
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_invio"
end type

type rb_solo_mail from radiobutton within w_invia_mail_new
integer x = 2094
integer y = 1036
integer width = 411
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mail"
boolean checked = true
end type

event clicked;long ll_riga

if checked=true then
	ll_riga=dw_2.find("codice= 'MAIL'", 1, 1000000)
	dw_2.scrolltorow(ll_riga)
end if
end event

type rb_solo_pec from radiobutton within w_invia_mail_new
integer x = 2395
integer y = 1036
integer width = 411
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pec"
end type

event clicked;long ll_riga

if checked=true then
	ll_riga=dw_2.find("codice= 'PEC'", 1, 1000000)
	dw_2.scrolltorow(ll_riga)
end if
end event

type rb_entrambe from radiobutton within w_invia_mail_new
integer x = 2683
integer y = 1032
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Entrambe"
end type

type cb_mailsend from commandbutton within w_invia_mail_new
boolean visible = false
integer x = 2304
integer y = 1604
integer width = 411
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Invia PEC"
end type

event clicked;String ls_body, ls_server, ls_uid, ls_pwd, ls_invia_mail, ls_campo_mail, ls_oggetto, ls_testo, ls_string_invio, ls_auth, ls_from_to, ls_allegati2
String ls_filename, ls_port, ls_encrypt, ls_errormsg,ls_destinatario
Integer li_idx, li_max, i, li_pos, a, b, li_pos_2, li_destinatari_selezionati
Boolean lb_html, lb_Return
UInt lui_port
datetime ldt_data_ora_invio
string ls_send_email, ls_send_nome, ls_mittente, ls_nome_mittente, ls_allegati
long ll_riga_testa, ll_riga_mail, ll_id_invio
SetPointer(HourGlass!)


rb_solo_pec.checked=true
rb_solo_pec.triggerevent (clicked!)
dw_1.accepttext()
ls_mittente=wf_rec_dati_server("mittente")
if messagebox("Attenzione!", ls_mittente+ " invierà la mail e i suoi allegati agli indirizzi selezionati, va bene?", Stopsign!, yesno!)=1 then

	ls_server=wf_rec_dati_server("smtp")
	If ls_server = "" Then
		MessageBox("Edit Error", &
			"You must specify Server on the Settings tab first!", StopSign!)
		Return
	End If
	
	ls_oggetto=dw_1.getitemstring(1, "oggetto")
	If ls_oggetto= "" or isnull(ls_oggetto) Then
		MessageBox("Edit Error", &
		"Il campo Oggetto non può essere vuoto!", StopSign!)
		Return
	End If
	if left(is_tipo_ae, 2)<> "TD" then
		ls_testo=dw_1.getitemstring(1, "testo")
		If ls_testo = "" or isnull(ls_testo) Then
			MessageBox("Edit Error", "Il testo è richiesto!", StopSign!)
			Return
		End If
	
	end if
//	ls_mittente=wf_rec_dati_server("mittente")
	//ls_indirizzo_mittente=wf_rec_dati_server("user_id")
	ls_nome_mittente=wf_rec_dati_server("nome_mittente")
	If Not gn_smtp.of_ValidEmail(ls_mittente, ls_errormsg) Then  //ls mittente è l'indirizzo mail
		//sle_from_email.SetFocus()
		MessageBox("Edit Error", ls_errormsg, StopSign!)
		Return
	End If
	
	
	If cbx_sendhtml.Checked Then
		ls_body  = "<html><body bgcolor='#FFFFFF' topmargin=8 leftmargin=8><h2>"
		ls_body += of_replace_all(ls_testo, "~r~n", "<br>") + "</h2>"
		ls_body += "</body></html>"
		lb_html = True
	Else
		ls_body = ls_testo
		lb_html = False
	End If
	
	lui_port= long(wf_rec_dati_server("porta"))
	
	// *** set email properties *********************
//	gn_smtp.of_ResetAll()
//	gn_smtp.of_SetPort(lui_port)
//	gn_smtp.of_SetServer(ls_server)
//	gn_smtp.of_SetLogFile(cbx_logfile.Checked, "smtp_logfile8.txt")
//	gn_smtp.of_SetDebugViewer(cbx_debugviewer.Checked)
//	gn_smtp.of_SetSubject(ls_oggetto)
//	gn_smtp.of_SetBody(ls_body, lb_html)
//	gn_smtp.of_SetFrom(ls_mittente, ls_nome_mittente)
	
	//mando la copia a me stesso per verifica
	//gn_smtp.of_AddAddress(ls_mittente, ls_nome_mittente)
//	If Not gn_smtp.of_ValidEmail(ls_mittente, ls_errormsg) Then
//		//sle_send_email.SetFocus()
//		MessageBox("Edit Error", ls_errormsg, StopSign!)
//		Return
//	End If
	ls_destinatario=dw_1.getitemstring(1, "destinatario")
	if is_tipo_ae> "TD" then //è un fat elettronica il destinatario è da recuperare in azienda, HUB_ae
		select hub_ae
		into :ls_destinatario
		from dba.azienda
		;
		if isnull(ls_destinatario) or ls_destinatario<" " then
			messagebox("Attenzione!", "Non è specificato a quale HUB inviare la Fat-elettronica. Campo HUB_ae tabella AZIENDA! Invio interrotto!")
			return
		end if
	end if
	//aggiungo testa alla dw che memorizza i dati invio
	ll_riga_testa=dw_3.insertrow(0)
	dw_3.setitem(ll_riga_testa, "mittente", ls_mittente)
	dw_3.setitem(ll_riga_testa, "data_ora", today())
	//ls_condominio=dw_3.getitemstring(dw_3.getrow(), "condominio")

	dw_3.setitem(ll_riga_testa, "destinatario", ls_destinatario)
	dw_3.trigger event ue_update()
	ll_id_invio=dw_3.getitemnumber(ll_riga_testa, "id_invio")
	if ll_id_invio>0 then
			ls_send_email=""
			ls_send_nome=""
			ls_send_nome=ls_destinatario
			ls_send_email=ls_destinatario
			li_pos=pos(ls_mittente, ";")
			if li_pos>0 then //ci sono più indirizzi mail indicati nel campo mail: devo dividerli
				a=1
				do while li_pos>0
					ls_invia_mail=mid(ls_send_email, a, li_pos  - a)
					gn_smtp.of_AddAddress(ls_invia_mail, ls_send_nome)
					If Not gn_smtp.of_ValidEmail(ls_invia_mail, ls_errormsg) Then
						//sle_send_email.SetFocus()
						MessageBox("Edit Error", ls_errormsg, StopSign!)
						Return
					End If
					//memorizzo mail, nome, data_ora per il report ricevuta
					ll_riga_mail=dw_3.insertrow(0)
					dw_3.setitem(ll_riga_testa, "id_invio", ll_id_invio)
					dw_3.setitem(ll_riga_testa, "mittente", ls_invia_mail)
					dw_3.setitem(ll_riga_testa, "destinatario", ls_send_nome)
					//dw_3.setitem(ll_riga_testa,"avviso", ls_body)
					a=li_pos+1
					li_pos=pos(ls_send_email, ";", a)
					if li_pos<=0 then
						li_pos_2=pos(ls_send_email, "@", a)
						if li_pos_2>0 then  //c'è un altro indirizzo, recuperiamolo
							ls_invia_mail=mid(ls_send_email, a, len(ls_send_email) - a +1)
							gn_smtp.of_AddAddress(ls_invia_mail, ls_send_nome)
							If Not gn_smtp.of_ValidEmail(ls_invia_mail, ls_errormsg) Then
								//sle_send_email.SetFocus()
								MessageBox("Edit Error", ls_errormsg, StopSign!)
								Return
							End If
							ll_riga_mail=dw_3.insertrow(0)
							dw_3.setitem(ll_riga_testa, "id_invio", ll_id_invio)
							dw_3.setitem(ll_riga_testa, "mittente", ls_invia_mail)
							dw_3.setitem(ll_riga_testa, "destinatario", ls_send_nome)
							//dw_3.setitem(ll_riga_testa,"avviso", ls_body)
						end if
					end if
				loop
				
			else
				//gn_smtp.of_AddAddress(sle_send_email.text, sle_send_name.text)
				gn_smtp.of_AddAddress(ls_send_email, ls_send_nome)
				If Not gn_smtp.of_ValidEmail(ls_send_email, ls_errormsg) Then
					//sle_send_email.SetFocus()
					MessageBox("Edit Error", ls_errormsg, StopSign!)
					Return
				End If
				//ll_riga_mail=dw_3.insertrow(0)
				dw_3.setitem(ll_riga_testa, "id_invio", ll_id_invio)
				dw_3.setitem(ll_riga_testa, "mittente", ls_send_email)
				dw_3.setitem(ll_riga_testa, "destinatario", ls_send_nome)
				//dw_3.setitem(ll_riga_testa,"avviso", ls_body)
			end if
			
	
		if dw_3.trigger event ue_update()<>1 then
			MessageBox("Attenzione!", "Errore nel salvataggio del report 'RICEVUTA LISTA'. Contattare l'assistenza!")
		end if

	dw_1.setfilter("")
	dw_1.filter()
	//fine 2016-05-11
	
	// *** set Userid/Password if required **********
	//If of_getreg("Auth", "N") = "Y" Then
	if wf_rec_dati_server("auth")= "Y" then
		ls_uid = wf_rec_dati_server("user_id")//of_getreg("Userid", "")
		ls_pwd =wf_rec_dati_server("password")// of_getreg("Password", "")
		gn_smtp.of_SetLogin(ls_uid, ls_pwd)
	End If
	
	// *** add any attachments **********************
	li_max = lb_attachments.TotalItems()
	For li_idx = 1 To li_max
		ls_filename = lb_attachments.Text(li_idx)
		gn_smtp.of_AddAttachment(ls_filename)
		ls_allegati2+=" -attach "+ls_filename
		ls_allegati+='"'+ls_filename+";"
	Next
	ls_allegati+='"'
	dw_3.setitem(ll_riga_testa,"allegati", ls_allegati)
	// *** send the message *************************
	ls_encrypt = of_getreg("Encrypt", "None")
	ls_encrypt=wf_rec_dati_server("ssl")
	//guardo se la fat è già stata inviata
	if is_tipo_ae> "TD" then
		select data_ora_invio
		into :ldt_data_ora_invio
		from dba.FE_invio
		where doc_id=:il_id_doc
		;
		if string(ldt_data_ora_invio, "yyyy-mm-dd hh:mm")> string(datetime("2018-12-01"),"yyyy-mm-dd hh:mm")   then
			if messagebox("Attenzione!", "Il documento è stato già inviato una volta ("+ string(ldt_data_ora_invio, "yyyy-mm-dd hh:mm")+"). Vuoi inviarlo ancora lo stesso?", stopsign!, yesno!)=2 then
				return
			end if
		end if
	end if
	//fien controllo
	choose case ls_encrypt
		case "SSL"
			ls_auth= " -ssl "
			//lb_Return = gn_smtp.of_SendSSLMail()
		case "TLS"
			ls_auth= " -starttsl "
			//lb_Return = gn_smtp.of_SendTLSMail()
		case else
			//lb_Return = gn_smtp.of_SendMail()
	end choose
	ls_auth+= " -port "+string(lui_port)
	ls_auth+=  " -smtp "+ls_server
	if wf_rec_dati_server("auth")= "Y" then ls_auth+=  " -auth "
	ls_auth+= " -user "+ls_uid+' -pass "'+ls_pwd+'"'
	ls_from_to=" -f "+ls_mittente+" -t "+ls_destinatario
	
	ls_allegati2=lower(ls_allegati2)  //valutare se tenerlo o meno ...
	//ls_string_invio="mailsend.exe -v "+ls_auth+ " -sub "+ls_oggetto +ls_from_to+ls_allegati2
	ls_string_invio="mailsend.exe -v "+ls_auth+ " -sub "+ls_oggetto +ls_from_to+ls_allegati2
					
	//ls_string_invio='mailsend -v  -ssl -port 465 -smtp smtp.libero.it -auth -user marco.mozzorecchi@libero.it -pass "pippone01" -sub ciao -f marco.mozzorecchi@libero.it'+&
				//		' -t luca.mozzorecchi@gmail.com -attach c:\dati\conoscenze_acquisite.pdf'
	run (ls_string_invio)
	
//	If lb_Return Then
//		MessageBox("SendMail", "Mail successfully sent!")
//		dw_3.setitem(ll_riga_testa, "invio_ok", "S")
//		//memorizzo oggetto e testo per riproporli la prossima volta
//		//SetProfileString ( "ermes.ini", "Ultima_Mail", "Oggetto", ls_oggetto)
//		//SetProfileString ( "ermes.ini", "Ultima_Mail", "Testo", ls_testo )
//		//SE è una Fat. elettronica aggiorno il cntatore e salvo i dati nella FE_invio
//		if is_tipo_ae> "TD" then
//			f_salva_invio(il_id_doc)
//			post close(parent)
//		END IF
//	Else
//		MessageBox("SendMail Error", gn_smtp.of_GetLastError())
//		dw_3.setitem(ll_riga_testa, "invio_ok", "N")
//	End If
//	if dw_3.trigger event ue_update()<>1 then
//		MessageBox("Attenzione!", "Errore nel salvataggio ESITO INVIO. Contattare l'assistenza!")
//	end if
	end if
else
	MessageBox("Attenzione!", "Errore nel salvataggio del report 'RICEVUTA'. Contattare l'assistenza!")
end if
//
end event

type cb_2 from commandbutton within w_invia_mail_new
integer x = 2094
integer y = 1140
integer width = 1115
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "INVIA MAIL"
end type

event clicked;String ls_body, ls_server, ls_uid, ls_pwd, ls_invia_mail, ls_campo_mail, ls_oggetto, ls_testo, ls_string_invio, ls_auth, ls_from_to, ls_allegati2
String ls_filename, ls_port, ls_encrypt, ls_errormsg,ls_destinatario, ls_file_log, ls_contenuto_file
Integer li_idx, li_max, i, li_pos, a, b, li_pos_2, li_destinatari_selezionati, li_FileNum
Boolean lb_html, lb_Return
UInt lui_port
datetime ldt_data_ora_invio
string ls_send_email, ls_send_nome, ls_mittente, ls_nome_mittente, ls_allegati, ls_allegati_ok[]
long ll_riga_testa, ll_riga_mail, ll_id_invio
SetPointer(HourGlass!)

//rb_solo_mail.checked=true
//
//rb_solo_mail.triggerevent (clicked!)
dw_1.accepttext()
ls_mittente=wf_rec_dati_server("mittente")
if messagebox("Attenzione!", ls_mittente+ " invierà la mail e i suoi allegati agli indirizzi selezionati, va bene?", Stopsign!, yesno!)=1 then

	ls_server=wf_rec_dati_server("smtp")
	If ls_server = "" Then
		MessageBox("Edit Error", &
			"You must specify Server on the Settings tab first!", StopSign!)
		Return
	End If
	
	ls_oggetto=dw_1.getitemstring(1, "oggetto")
	If ls_oggetto= "" or isnull(ls_oggetto) Then
		MessageBox("Edit Error", &
		"Il campo Oggetto non può essere vuoto!", StopSign!)
		Return
	End If
	if left(is_tipo_ae, 2)<> "TD" then
		ls_testo=dw_1.getitemstring(1, "testo")
		If ls_testo = "" or isnull(ls_testo) Then
			MessageBox("Edit Error", "Il testo è richiesto!", StopSign!)
			Return
		End If
	
	end if
//	ls_mittente=wf_rec_dati_server("mittente")
	//ls_indirizzo_mittente=wf_rec_dati_server("user_id")
	ls_nome_mittente=wf_rec_dati_server("nome_mittente")
	If Not gn_smtp.of_ValidEmail(ls_mittente, ls_errormsg) Then  //ls mittente è l'indirizzo mail
		//sle_from_email.SetFocus()
		MessageBox("Edit Error", ls_errormsg, StopSign!)
		Return
	End If
	
	
	If cbx_sendhtml.Checked Then
		ls_body  = "<html><body bgcolor='#FFFFFF' topmargin=8 leftmargin=8><h2>"
		ls_body += of_replace_all(ls_testo, "~r~n", "<br>") + "</h2>"
		ls_body += "</body></html>"
		lb_html = True
	Else
		ls_body = ls_testo
		lb_html = False
	End If
	
	lui_port= long(wf_rec_dati_server("porta"))
	
	// *** set email properties *********************
//	gn_smtp.of_ResetAll()
//	gn_smtp.of_SetPort(lui_port)
//	gn_smtp.of_SetServer(ls_server)
//	gn_smtp.of_SetLogFile(cbx_logfile.Checked, "smtp_logfile8.txt")
//	gn_smtp.of_SetDebugViewer(cbx_debugviewer.Checked)
//	gn_smtp.of_SetSubject(ls_oggetto)
//	gn_smtp.of_SetBody(ls_body, lb_html)
//	gn_smtp.of_SetFrom(ls_mittente, ls_nome_mittente)
	
	//mando la copia a me stesso per verifica
	//gn_smtp.of_AddAddress(ls_mittente, ls_nome_mittente)
//	If Not gn_smtp.of_ValidEmail(ls_mittente, ls_errormsg) Then
//		//sle_send_email.SetFocus()
//		MessageBox("Edit Error", ls_errormsg, StopSign!)
//		Return
//	End If
	ls_destinatario=dw_1.getitemstring(1, "destinatario")
	if is_tipo_ae> "TD" then //è un fat elettronica il destinatario è da recuperare in azienda, HUB_ae
		select hub_ae
		into :ls_destinatario
		from dba.azienda
		;
		if isnull(ls_destinatario) or ls_destinatario<" " then
			messagebox("Attenzione!", "Non è specificato a quale HUB inviare la Fat-elettronica. Campo HUB_ae tabella AZIENDA! Invio interrotto!")
			return
		end if
	end if
	//aggiungo testa alla dw che memorizza i dati invio
	ll_riga_testa=dw_3.insertrow(0)
	dw_3.setitem(ll_riga_testa, "mittente", ls_mittente)
	dw_3.setitem(ll_riga_testa, "data_ora", today())
	//ls_condominio=dw_3.getitemstring(dw_3.getrow(), "condominio")

	dw_3.setitem(ll_riga_testa, "destinatario", ls_destinatario)
	dw_3.trigger event ue_update()
	ll_id_invio=dw_3.getitemnumber(ll_riga_testa, "id_invio")
	if ll_id_invio>0 then
		ls_send_email=""
		ls_send_nome=""
		ls_send_nome=ls_destinatario
		ls_send_email=ls_destinatario
		li_pos=pos(ls_mittente, ";")
		if li_pos>0 then //ci sono più indirizzi mail indicati nel campo mail: devo dividerli
			a=1
			do while li_pos>0
				ls_invia_mail=mid(ls_send_email, a, li_pos  - a)
				gn_smtp.of_AddAddress(ls_invia_mail, ls_send_nome)
				If Not gn_smtp.of_ValidEmail(ls_invia_mail, ls_errormsg) Then
					//sle_send_email.SetFocus()
					MessageBox("Edit Error", ls_errormsg, StopSign!)
					Return
				End If
				//memorizzo mail, nome, data_ora per il report ricevuta
				ll_riga_mail=dw_3.insertrow(0)
				dw_3.setitem(ll_riga_testa, "id_invio", ll_id_invio)
				dw_3.setitem(ll_riga_testa, "mittente", ls_invia_mail)
				dw_3.setitem(ll_riga_testa, "destinatario", ls_send_nome)
				//dw_3.setitem(ll_riga_testa,"avviso", ls_body)
				a=li_pos+1
				li_pos=pos(ls_send_email, ";", a)
				if li_pos<=0 then
					li_pos_2=pos(ls_send_email, "@", a)
					if li_pos_2>0 then  //c'è un altro indirizzo, recuperiamolo
						ls_invia_mail=mid(ls_send_email, a, len(ls_send_email) - a +1)
						gn_smtp.of_AddAddress(ls_invia_mail, ls_send_nome)
						If Not gn_smtp.of_ValidEmail(ls_invia_mail, ls_errormsg) Then
							//sle_send_email.SetFocus()
							MessageBox("Edit Error", ls_errormsg, StopSign!)
							Return
						End If
						ll_riga_mail=dw_3.insertrow(0)
						dw_3.setitem(ll_riga_testa, "id_invio", ll_id_invio)
						dw_3.setitem(ll_riga_testa, "mittente", ls_invia_mail)
						dw_3.setitem(ll_riga_testa, "destinatario", ls_send_nome)
						//dw_3.setitem(ll_riga_testa,"avviso", ls_body)
					end if
				end if
			loop
		else
			//gn_smtp.of_AddAddress(sle_send_email.text, sle_send_name.text)
			gn_smtp.of_AddAddress(ls_send_email, ls_send_nome)
			If Not gn_smtp.of_ValidEmail(ls_send_email, ls_errormsg) Then
				//sle_send_email.SetFocus()
				MessageBox("Edit Error", ls_errormsg, StopSign!)
				Return
			End If
			//ll_riga_mail=dw_3.insertrow(0)
			dw_3.setitem(ll_riga_testa, "id_invio", ll_id_invio)
			dw_3.setitem(ll_riga_testa, "mittente", ls_send_email)
			dw_3.setitem(ll_riga_testa, "destinatario", ls_send_nome)
			//dw_3.setitem(ll_riga_testa,"avviso", ls_body)
		end if
		if dw_3.trigger event ue_update()<>1 then
			MessageBox("Attenzione!", "Errore nel salvataggio del report 'RICEVUTA LISTA'. Contattare l'assistenza!")
		end if

		dw_1.setfilter("")
		dw_1.filter()
	//fine 2016-05-11
	
	// *** set Userid/Password if required **********
	//If of_getreg("Auth", "N") = "Y" Then
		if wf_rec_dati_server("auth")= "Y" then
			ls_uid = wf_rec_dati_server("user_id")//of_getreg("Userid", "")
			ls_pwd =wf_rec_dati_server("password")// of_getreg("Password", "")
			gn_smtp.of_SetLogin(ls_uid, ls_pwd)
		End If
		
		// *** add any attachments **********************
		li_max = lb_attachments.TotalItems()
		For li_idx = 1 To li_max
			ls_filename = lb_attachments.Text(li_idx)
			gn_smtp.of_AddAttachment(ls_filename)
			ls_allegati2+=" -attach "+ls_filename
			//ls_allegati_ok[li_idx]=" -attach "+ls_filename
			ls_allegati+='"'+ls_filename+";"
		Next
//		ls_allegati+='"'
//		dw_3.setitem(ll_riga_testa,"allegati", ls_allegati)
		// *** send the message *************************
		//a=1
		
		ls_encrypt = of_getreg("Encrypt", "None")
		ls_encrypt=wf_rec_dati_server("ssl")
		//guardo se la fat è già stata inviata
		if is_tipo_ae> "TD" then
			select data_ora_invio
			into :ldt_data_ora_invio
			from dba.FE_invio
			where doc_id=:il_id_doc
			;
			if string(ldt_data_ora_invio, "yyyy-mm-dd hh:mm")> string(datetime("2018-12-01"),"yyyy-mm-dd hh:mm")   then
			if messagebox("Attenzione!", "Il documento è stato già inviato una volta ("+ string(ldt_data_ora_invio, "yyyy-mm-dd hh:mm")+"). Vuoi inviarlo ancora lo stesso?", stopsign!, yesno!)=2 then
				return
			end if
		end if
		end if									
		//fien controllo
		choose case ls_encrypt
			case "SSL"
				ls_auth= " -ssl "
				//lb_Return = gn_smtp.of_SendSSLMail()
			case "TLS"
				ls_auth= " -starttsl "
				//lb_Return = gn_smtp.of_SendTLSMail()
			case else
				//lb_Return = gn_smtp.of_SendMail()
		end choose
		ls_auth+= " -port "+string(lui_port)
		ls_auth+=  " -smtp "+ls_server
		if wf_rec_dati_server("auth")= "Y" then ls_auth+=  " -auth "
		ls_auth+= " -user "+ls_uid+' -pass "'+ls_pwd+'"'
		ls_from_to=" -f "+ls_mittente+" -t "+ls_destinatario
		
		ls_allegati2=lower(ls_allegati2)  //valutare se tenerlo o meno ...
		//ls_string_invio="mailsend.exe -v "+ls_auth+ " -sub "+ls_oggetto +ls_from_to+ls_allegati2
		//ls_string_invio="mailsend.exe -v "+ls_auth+ " -sub "+ls_oggetto +ls_from_to+ls_allegati2
					
	//ls_string_invio='mailsend -v  -ssl -port 465 -smtp smtp.libero.it -auth -user marco.mozzorecchi@libero.it -pass "pippone01" -sub ciao -f marco.mozzorecchi@libero.it'+&
				//		' -t luca.mozzorecchi@gmail.com -attach c:\dati\conoscenze_acquisite.pdf'
//	run (ls_string_invio)
		ls_file_log="c:\sultak\log\logmail.log"
		filedelete(ls_file_log)     //=false then MessageBox("Attenzione!", "File di log parziale NON cancellato!")
		if directoryexists("c:\sultak\log") = false then
			CreateDirectory ( "c:\sultak\log") 
		end if
		
		ls_string_invio="mailsend.exe -v "+ls_auth+ ' -sub "'+ ls_oggetto + '"' + ls_from_to +   ls_allegati2 +" -log " + ls_file_log
		run(ls_string_invio, Minimized!)
		sleep(1)
		do while li_FileNum<=0
			li_FileNum = FileOpen(ls_file_log, TextMode!)
			a++
			if a>100000 then 
				MessageBox("Attenzione!", ls_file_log+" NON trovato! Impossibile conoscere esito dell'invio della mail!")
				exit
			end if
		loop
		filereadex(li_FileNum, ls_contenuto_file)
		fileclose(li_FileNum)
	
			
		li_FileNum=FileOpen("c:\sultak\log\tuttologmail.log", TextMode!, Write!, LockWrite!, Append!)
		filewriteex(li_FileNum, ls_contenuto_file)
		fileclose(li_FileNum)
		if pos(ls_contenuto_file, "Mail sent successfully")>0 then
			lb_Return=true
		else
			lb_Return=false
		end if
				
				
		If lb_Return Then
			MessageBox("SendMail", "Mail successfully sent!")
			dw_3.setitem(ll_riga_testa, "invio_ok", "S")
			//memorizzo oggetto e testo per riproporli la prossima volta
			//SetProfileString ( "ermes.ini", "Ultima_Mail", "Oggetto", is_mail.s_oggetto)
			//SetProfileString ( "ermes.ini", "Ultima_Mail", "Testo", is_mail.s_testo )
			//SE è una Fat. elettronica aggiorno il cntatore e salvo i dati nella FE_invio
			if is_tipo_ae> "TD" then
				f_salva_invio(il_id_doc)
				post close(parent)
			END IF
		Else
			MessageBox("SendMail Error", "Vedi file c:\sultak\log\logmail.log")
			dw_3.setitem(ll_riga_testa, "invio_ok", "N")
		End If
		if dw_3.update()<>1 then
			MessageBox("Attenzione!", "Errore nel salvataggio ESITO INVIO. Contattare l'assistenza!")
			rollback;
		else
			commit;
		end if
	else
		MessageBox("Attenzione!", "Errore nel salvataggio del report di invio. Contattare l'assistenza!")
	end if
end if
//	else
//		rollback;
//		MessageBox("Attenzione!", "Errore nel salvataggio del report di invio. Contattare l'assistenza!")
//	end if
//fine aggiutn da nita	
	
	
//	If lb_Return Then
//		MessageBox("SendMail", "Mail successfully sent!")
//		dw_3.setitem(ll_riga_testa, "invio_ok", "S")
//		//memorizzo oggetto e testo per riproporli la prossima volta
//		//SetProfileString ( "ermes.ini", "Ultima_Mail", "Oggetto", ls_oggetto)
//		//SetProfileString ( "ermes.ini", "Ultima_Mail", "Testo", ls_testo )
//		//SE è una Fat. elettronica aggiorno il cntatore e salvo i dati nella FE_invio
//		if is_tipo_ae> "TD" then
//			f_salva_invio(il_id_doc)
//			post close(parent)
//		END IF
//	Else
//		MessageBox("SendMail Error", gn_smtp.of_GetLastError())
//		dw_3.setitem(ll_riga_testa, "invio_ok", "N")
//	End If
//	if dw_3.trigger event ue_update()<>1 then
//		MessageBox("Attenzione!", "Errore nel salvataggio ESITO INVIO. Contattare l'assistenza!")
//	end if
//	end if
//else
//	MessageBox("Attenzione!", "Errore nel salvataggio del report 'RICEVUTA'. Contattare l'assistenza!")
//end if
//
end event

