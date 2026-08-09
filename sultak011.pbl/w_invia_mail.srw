forward
global type w_invia_mail from w_base
end type
type cb_invia from commandbutton within w_invia_mail
end type
type dw_1 from udw_001 within w_invia_mail
end type
end forward

global type w_invia_mail from w_base
integer width = 2099
integer height = 1056
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
cb_invia cb_invia
dw_1 dw_1
end type
global w_invia_mail w_invia_mail

forward prototypes
public subroutine wf_invia_mail ()
public function string wf_estrai_nome_file (string as_path)
end prototypes

public subroutine wf_invia_mail ();string ls_indirizzo_e_mail, ls_stampato, ls_mail_cc
long ll_righe
integer i


dw_1.accepttext()

mailsession lms_sess
mailmessage lm_mess
mailrecipient lm_recipient, lm_recipient2
mailFileDescription lmf_file
mailreturncode lmc_rc


lmf_file.FileType = mailAttach!

lmf_file.PathName = dw_1.getitemstring(1, "allegati")
lmf_file.FileName = wf_estrai_nome_file(lmf_file.PathName)

lm_mess.NoteText = dw_1.getitemstring(1, "testo")
lm_mess.Subject = dw_1.getitemstring(1, "oggetto")

ls_indirizzo_e_mail=dw_1.getitemstring(1, "destinatario")

lm_mess.Attachmentfile[1] = lmf_file

lm_recipient.Address = ls_indirizzo_e_mail
lm_recipient.Name = ls_indirizzo_e_mail
lm_recipient.RecipientType = mailTo!
lm_mess.Recipient[1] = lm_recipient


//ls_mail_cc=dw_1.getitemstring(1, "cc")
//if ls_mail_cc>" " then
//	lm_recipient2.Address = ls_mail_cc
//	lm_recipient2.Name = ls_mail_cc
//	lm_recipient2.RecipientType = mailCC!
//	lm_mess.Recipient[2] = lm_recipient2
//end if	
lms_sess = create mailsession
lmc_rc = lms_Sess.mailLogon()


lmc_rc = lms_Sess.mailSend(lm_mess)
IF lmc_rc <> mailReturnSuccess! THEN
   MessageBox("Error", "Error on Send")
else
//	f_sposta_in_mail(lmf_file.PathName)

END IF

lmc_rc = lms_sess.mailLogoff()
IF lmc_rc <> mailReturnSuccess! THEN
   MessageBox("Error", "Error on Close")
END IF
DESTROY lms_sess
 
 



//string ls_indirizzo_e_mail, ls_attach
//mailSession mSes
//
//mailReturnCode mRet
//
//mailMessage mMsg, mmsg_2
//
//mailFileDescription m_attach
//integer n, i, li_pos,ll_inizio
//long c_row
//
//// Crea una sessione di posta
//
//mSes = create mailSession
//
//// Log on to the session
//
//mRet = mSes.mailLogon(mailNewSession!)
//
//IF mRet <> mailReturnSuccess! THEN
//		MessageBox("Mail", 'Logon failed.')
//		RETURN
//END IF
//
//mMsg.Subject = dw_1.getitemstring(1, "oggetto")
//
//mMsg.NoteText = dw_1.getitemstring(1, "testo")
//
//ls_indirizzo_e_mail=dw_1.getitemstring(1, "destinatario")
//if ls_indirizzo_e_mail='' or isnull(ls_indirizzo_e_mail) then
//	mSes.mailAddress (mMsg)
//else
//	mMsg.Recipient[1].name=ls_indirizzo_e_mail
//end if
//
//
//ls_attach=dw_1.getitemstring(1, "allegati")
//DO 
//	ll_inizio=li_pos+1
//	i++
//	li_pos=pos(ls_attach, ";" ,ll_inizio) 
//	if li_pos>0 then
//		m_attach.pathname=mid(ls_attach, ll_inizio, li_pos - ll_inizio)
//		mMsg.AttachmentFile[i] = m_Attach
//	end if
//loop while li_pos>0
//mRet = mSes.mailSend(mMsg)
//
//
//
//IF mRet <> mailReturnSuccess! THEN
//		MessageBox("Mail", 'Mail non inviata!')
//		RETURN
//END IF
//
//mSes.mailLogoff()
//
//DESTROY mSes
end subroutine

public function string wf_estrai_nome_file (string as_path);string ls_nome_file
integer li_pos

li_pos=lastpos(as_path, "\")
if li_pos>0 then
	ls_nome_file=right(as_path, len(as_path) - li_pos)
else
	ls_nome_file=as_path
end if
return ls_nome_file
end function

on w_invia_mail.create
int iCurrent
call super::create
this.cb_invia=create cb_invia
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_invia
this.Control[iCurrent+2]=this.dw_1
end on

on w_invia_mail.destroy
call super::destroy
destroy(this.cb_invia)
destroy(this.dw_1)
end on

event open;call super::open;string ls_allegato
s_e_mail s_mail

dw_1.insertrow(0)

s_mail=message.powerobjectparm

//if upperbound( s_mail.s_allegato) >0 then
	dw_1.setitem(1, "allegati", s_mail.s_allegato[1])
//end if
dw_1.setitem(1, "testo", s_mail.s_testo)
dw_1.setitem(1, "destinatario", s_mail.s_email_1)
dw_1.setitem(1, "oggetto", s_mail.s_oggetto)
end event

type cb_invia from commandbutton within w_invia_mail
integer x = 1591
integer y = 83
integer width = 325
integer height = 93
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Invia"
end type

event clicked;wf_invia_mail()
close(parent)
end event

type dw_1 from udw_001 within w_invia_mail
integer x = 48
integer y = 61
integer width = 1997
integer height = 842
integer taborder = 10
string dataobject = "d_posta_ex"
end type

event clicked;call super::clicked;if dwo.name="destinatario_sw" then
mailSession mSes
//
mailReturnCode mRet
//
mailMessage mMsg
// Crea una sessione di posta
mSes = create mailSession
// Log on to the session
mRet = mSes.mailLogon(mailNewSession!)

IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail", 'Logon failed.')
		RETURN
END IF
	mSes.mailAddress(mMsg)
	if upperbound(mMsg.Recipient) >0 then
		dw_1.setitem(1, "destinatario", mMsg.Recipient[1].address)
	end if
mSes.mailLogoff()

DESTROY mSes
	
end if
end event

