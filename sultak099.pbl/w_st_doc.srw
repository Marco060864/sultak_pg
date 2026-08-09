forward
global type w_st_doc from w_stampa
end type
type cb_mail from commandbutton within w_st_doc
end type
type cbx_prezzo_ddt from checkbox within w_st_doc
end type
type cb_1 from commandbutton within w_st_doc
end type
type cbx_1 from checkbox within w_st_doc
end type
type cbx_vedi_saldi from checkbox within w_st_doc
end type
type pb_2 from picturebutton within w_st_doc
end type
type cbx_importo from checkbox within w_st_doc
end type
type cbx_ordina from checkbox within w_st_doc
end type
end forward

global type w_st_doc from w_stampa
integer width = 3461
integer height = 1820
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_mail cb_mail
cbx_prezzo_ddt cbx_prezzo_ddt
cb_1 cb_1
cbx_1 cbx_1
cbx_vedi_saldi cbx_vedi_saldi
pb_2 pb_2
cbx_importo cbx_importo
cbx_ordina cbx_ordina
end type
global w_st_doc w_st_doc

type variables
long il_id_doc
string is_dw_stampa, is_tipo_doc, is_tipo_ae
integer il_ult_pg_no_footer
date idt_inizio_esercizio


end variables

forward prototypes
public subroutine wf_crea_mail (string as_allegato, string as_oggetto)
public subroutine wf_vedi_importo ()
end prototypes

public subroutine wf_crea_mail (string as_allegato, string as_oggetto);string ls_ret
long ll_row, ll_id_ana
string ls_destinatario, ls_des_prof,ls_azienda, ls_testo
string ls_indirizzo_e_mail, s_id


mailSession mSes
//
mailReturnCode mRet
//
mailMessage mMsg
//
//mailFileDescription m_attach
integer n, i, li_pos
long c_row

// Crea una sessione di posta

mSes = create mailSession

// Log on to the session

mRet = mSes.mailLogon(mailNewSession!)

IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail", 'Logon failed.')
		RETURN
END IF

this.height*=2.14

//select p.descrizione, a.rag_soc_1, az.rag_soc_1, a.id_anagrafica
//into :ls_des_prof, :ls_destinatario, :ls_azienda, :ll_id_ana
//from prof_documento p, documento d, sog_commerciale s, anagrafica a, azienda az
//where a.id_anagrafica=s.id_anagrafica
//and s.id_sog_commerciale=d.id_sog_commerciale
//and p.id_prof_documento=d.id_prof_documento
//and d.id_documento=:il_id_doc
//and az.id_azienda=d.id_azienda;

ls_testo="Spett. "+ls_destinatario+"~r~nin allegato alla presente E-MAIL inviamo "+&
ls_des_prof+"~r~ndi cui all'oggetto in formato di documento PDF."+&
"~r~nLa stampa di tale documento costituirà a tutti gli effetti "+&
"~r~nsupporto cartaceo contabile fiscalmente valido."+&
"~r~nDistinti saluti~r~n"+ls_azienda

//select num_riferimento
//into :ls_indirizzo_e_mail
//from telefono
//where tipo='E'
//and id_anagrafica=:ll_id_ana;

if ls_indirizzo_e_mail='' or isnull(ls_indirizzo_e_mail) then
	mSes.mailAddress (mMsg)
	if upperbound(mMsg.Recipient) >0 then
		ls_indirizzo_e_mail=mMsg.Recipient[1].name
	end if
else
	mMsg.Recipient[1].name=ls_indirizzo_e_mail
end if
mSes.mailLogoff()

DESTROY mSes

//dw_1.insertrow(1)
//dw_1.setitem(1, "destinatario", ls_indirizzo_e_mail)
//dw_1.setitem(1, "oggetto", as_oggetto)
//dw_1.setitem(1, "allegati", as_allegato)
//dw_1.setitem(1, "testo", ls_testo)
//

end subroutine

public subroutine wf_vedi_importo ();cbx_importo.checked=true
cbx_importo.triggerevent("clicked")
end subroutine

on w_st_doc.create
int iCurrent
call super::create
this.cb_mail=create cb_mail
this.cbx_prezzo_ddt=create cbx_prezzo_ddt
this.cb_1=create cb_1
this.cbx_1=create cbx_1
this.cbx_vedi_saldi=create cbx_vedi_saldi
this.pb_2=create pb_2
this.cbx_importo=create cbx_importo
this.cbx_ordina=create cbx_ordina
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_mail
this.Control[iCurrent+2]=this.cbx_prezzo_ddt
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cbx_1
this.Control[iCurrent+5]=this.cbx_vedi_saldi
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.cbx_importo
this.Control[iCurrent+8]=this.cbx_ordina
end on

on w_st_doc.destroy
call super::destroy
destroy(this.cb_mail)
destroy(this.cbx_prezzo_ddt)
destroy(this.cb_1)
destroy(this.cbx_1)
destroy(this.cbx_vedi_saldi)
destroy(this.pb_2)
destroy(this.cbx_importo)
destroy(this.cbx_ordina)
end on

event open;call super::open;long ll_id_sog_com, ll_id_reg,ll_id_iva, ll_conto_id
string ls_num, ls_nome_file, ls_guida, ls_test, ls_path_stampe,ls_saldi_in_bolla, ls_ret
date ldt_data, ldt_data_doc
//datastore ds_stampa
string ls_printer, dwsyntax, ls_path_libreria,ls_tipo_reg, ls_dich
integer li_num_copie
s_st_doc st_doc

st_doc=message.powerobjectparm

il_id_doc=st_doc.sl_id_doc

is_doc_per_stampa=st_doc.ss_name
idt_inizio_esercizio=st_doc.dt_inizio_esercizio

select report_stampa,  guida_tipo_doc, tipo_documento_ae
into :is_dw_stampa, :is_tipo_doc, :is_tipo_ae
from dba.guida g, dba.doc d
where d.guida_id=g.guida_id
and doc_id=:il_id_doc
;
if isnull(is_dw_stampa) then is_dw_stampa="d_st_doc"


//if is_dw_stampa="d_st_doc" then
//cbx_prezzo_ddt.visible=true
//end if
if il_id_doc>0 then
	select dir_stampe
	into :ls_path_stampe
	from dba.val_base;
	if isnull(ls_path_stampe) then 
		ls_path_stampe=''
	elseif ls_path_stampe>'' then
		ls_path_stampe=ls_path_stampe+'\'
	end if
	dwsyntax = LibraryExport(ls_path_stampe+"sultak100.pbl", is_dw_stampa, ExportDataWindow!)
	IF dwsyntax>"" THEN
		dw_1.create(dwsyntax)
		dw_1.settransobject(sqlca)
		dw_1.retrieve(il_id_doc, st_doc.dt_inizio_esercizio)
		//prova 110511
//		dw_2.create(dwsyntax)
//		dw_2.settransobject(sqlca)
//		dw_2.retrieve(il_id_doc, st_doc.dt_inizio_esercizio)
		//fine prova
	else
		messagebox("Attenzione!", "Stampa non trovata! Controlla path stampe nei valori base!")
		return
	end if
else
	close(this)
end if

select num_copie 
into :li_num_copie
from dba.val_base
;
if li_num_copie<=0 or isnull(li_num_copie) then li_num_copie=1
sle_copie.text=string(li_num_copie)

select r.reg_tipo, d.doc_data, i.iva_id, c.conto_id
into :ls_tipo_reg, :ldt_data_doc, :ll_id_iva, :ll_conto_id
from dba.doc d, dba.registro r, dba.iva i, dba.conto c
where d.reg_id=r.reg_id
and d.doc_id=:il_id_doc
and i.iva_id=*c.iva_id
and d.doc_conto_id=c.conto_id
;
if ls_tipo_reg='IV'  then
	ls_dich=f_dich_intento(ll_conto_id, ldt_data_doc)
	ls_ret=dw_1.modify("t_dich_intento.text='"+ls_dich+"'")
	post wf_vedi_importo()
end if


//questo sotto è inutile: l'ho messo nella dw di stampa (d_st_doc)
//if ls_saldi_in_bolla='S' then dw_1.MODIFY("dw_5.visible=1")

//if rb_stampa.checked then
//		printsetup()
//		dwsyntax = LibraryExport(ls_path_libreria, is_dw_stampa, ExportDataWindow!)
//		IF dwsyntax>"" THEN
//			ds_stampa=create datastore
//			ds_stampa.create(dwsyntax)
//			ds_stampa.settransobject(sqlca)
//			ds_stampa.retrieve(il_id_doc)
//			//qui devo prendere il numero di copie, il nome del pdf se il caso
//			li_num_copie=integer(sle_copie.text)
//			if li_num_copie<=0 or isnull(li_num_copie) then li_num_copie=1
//			ds_stampa.Modify("DataWindow.Print.copies = "+ string(li_num_copie))			
//		else
//			messagebox("Errore!", "Dw di stampa "+is_dw_stampa+" non trovata!")
//			
//			return -1	
//		end if
//		ds_stampa.print()
//		destroy(ds_stampa)
//		return -1
//	elseif rb_mail.checked then
//			//si manda l'e-mail, va prima creato il pdf
//			//e poi aperta la posta con il messaggio già pronto da spedire
//			//cerco dati per nome pdf
//			dwsyntax = LibraryExport(ls_path_libreria, is_dw_stampa, ExportDataWindow!)
//			IF dwsyntax>"" THEN
//				ds_stampa=create datastore
//				ds_stampa.create(dwsyntax)
//				ds_stampa.settransobject(sqlca)
//				ds_stampa.retrieve(il_id_doc)
//			else
//				messagebox("Errore!", "Dw di stampa "+is_dw_stampa+" non trovata!")
//				return -1	
//			end if
//			select g.guida_codice, d.doc_numero, d.doc_data
//			into :ls_guida, :ls_num, :ldt_data
//			from dba.guida g, dba.doc d
//			where d.guida_id=g.guida_id
//			and d.doc_id=:il_id_doc;
//			//imposto il nome e il path del file pdf
//			select dir_pdf
//			into :ls_nome_file
//			from dba.val_base;
//			if isnull(ls_nome_file) or ls_nome_file="" then
//				messagebox("Attenzione!", "Specificare la directory di output nei parametri di sistema!")
//				return -1
//			end if
//			if right(ls_nome_file, 1)<>"\" then ls_nome_file+="\"
//			ls_nome_file+=ls_guida+ls_num+".pdf"
//			ls_test=ds_stampa.Modify("DataWindow.Print.filename = '"+ls_nome_file+"'")
//			if ls_test="" then 
//				ds_stampa.print()
//				wf_crea_mail(ls_nome_file, ls_guida+" n. "+ls_num+" del "+string(ldt_data))
//			else
//				messagebox("Errore!", "File PDF non generato!")	
//			end if
//			destroy(ds_stampa)
//			return -100
//	else//stampa a video
////		s_dati_doc.ls_dw_sintax=lower(is_dw_stampa)
////		s_dati_doc.il_id_doc=il_id_doc
////		openwithparm(w_catalogo_foto, s_dati_doc)
////		return -1
//	end if
////end if
//
end event

event ue_postopen;call super::ue_postopen;string  ls_caus_partita, ls_vedi_saldi, ls_codice_az
long ll_righe

ll_righe= dw_1. getrow()
if ll_righe > 0 then
	ls_caus_partita=dw_1.getitemstring(ll_righe, "causale_caus_partita")
	select vedi_saldi_bolla
	into :ls_vedi_saldi
	from dba.val_base
	;
	if isnull(ls_vedi_saldi) then ls_vedi_saldi='N'
	if ls_caus_partita >" " and ls_vedi_saldi="S" then
		cbx_vedi_saldi.checked=true
	else
		cbx_vedi_saldi.checked=false
	end if
	select az_codice
	into :ls_codice_az
	from dba.azienda
	;
//	if ls_codice_az='PAK' then
//		sle_zoom.text='96'
//		sle_zoom.triggerevent(modified!)
//	end if
end if

	
	




end event

type pb_1 from w_stampa`pb_1 within w_st_doc
integer x = 2926
integer y = 12
integer weight = 700
end type

type cb_preview from w_stampa`cb_preview within w_st_doc
boolean visible = false
integer x = 2542
integer y = 12
end type

type dw_1 from w_stampa`dw_1 within w_st_doc
integer y = 176
end type

event dw_1::rbuttondown;call super::rbuttondown;string ls_path_stampe, dwsyntax, ls_azienda

select az_codice
into :ls_azienda
from dba.azienda;
if il_id_doc>0 and ls_azienda="Marco Mozzorecchi" then
	select dir_stampe
	into :ls_path_stampe
	from dba.val_base;
	if isnull(ls_path_stampe) then 
		ls_path_stampe=''
	elseif ls_path_stampe>'' then
		ls_path_stampe=ls_path_stampe+'\'
	end if
	dwsyntax = LibraryExport(ls_path_stampe+"sultak100.pbl", "D_ST_RA_MIO", ExportDataWindow!)
	IF dwsyntax>"" THEN
		dw_1.create(dwsyntax)
		dw_1.settransobject(sqlca)
		dw_1.retrieve(il_id_doc)
		dw_1.object.datawindow.print.preview='yes'
	else
		close(parent)
	end if

end if
end event

event dw_1::printpage;call super::printpage;string ls_h_footer, ls_ultima_riga,ls_prima_riga
integer li_num_pagine
long ll_riga
if is_h_footer="nofooter" then
	li_num_pagine=dw_1.getitemnumber(dw_1.rowcount(), "tot_pagine")
//	ls_prima_riga=dw_1.Describe("DataWindow.LastRowOnPage")
//	ll_riga=long(ls_prima_riga)
//	dw_1.setitem(ll_riga, "n_pag", pagenumber)
	
	ls_h_footer=dw_1.describe("datawindow.footer.height")
	if ls_h_footer="5" then
		if pagenumber=li_num_pagine then
			il_ult_pg_no_footer=pagenumber -1
			//ls_prima_riga=dw_1.Describe("DataWindow.FirstRowOnPage")
			ls_ultima_riga = dw_1.Describe("DataWindow.LastRowOnPage")
			//ll_riga=long(ls_prima_riga)
			//dw_1.setitem(ll_riga, "n_pag", il_ult_pg_no_footer)
			
			dw_1.rowsmove(1, integer(ls_ultima_riga), primary!, dw_1, 1,  Delete!)
		//	dw_2.rowsmove(1, integer(ls_ultima_riga), primary!, dw_2, 1,  Delete!)
			//dw_1.rowsmove(integer(ls_prima_riga), integer(ls_ultima_riga), primary!, dw_1, 1,  Delete!)
			
			iudw_corrente.modify("datawindow.footer.height = "+is_h2_footer)
			
			return 1
		end if
	else
//		ls_prima_riga=dw_1.Describe("DataWindow.FirstRowOnPage")
//		ll_riga=long(ls_prima_riga)
//		dw_1.setitem(ll_riga, "n_pag", il_ult_pg_no_footer)
//		il_ult_pg_no_footer++
		if pagenumber<li_num_pagine and li_num_pagine>2 then 
			return 1
		end if
	end if
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_doc
integer x = 2510
integer y = 12
end type

type pb_stampa from w_stampa`pb_stampa within w_st_doc
integer x = 2738
integer y = 12
end type

event pb_stampa::rbuttondown;call super::rbuttondown;




//vecchia funzione per stampare righe fino fondo pagina (eliminava footer da tutte le pagine tranne l'ultima poi
//eseguiva calcoli sul numero di righe per creare correttamente lìultima pagina
//string ls_num_doc, ls_data, ld_dataobject
//long ll_job, ll_id_doc, ll_righe
//integer li_righe, li_num_copie, i
//
//li_num_copie=integer(sle_copie.text)
//if li_num_copie<=0 or isnull(li_num_copie) then li_num_copie=1
//iudw_corrente.Modify("DataWindow.Print.copies = "+ string(li_num_copie))
//li_righe=iudw_corrente.rowcount()
//if li_righe>0 then
//	
//	//stampo senza piede lo azzero (lo accinquo) in altezza!
//	is_h_footer="nofooter"
//	//prima metto il dw così comè in dw_2
//
//	
//	
//	
//	is_h2_footer=iudw_corrente.describe("datawindow.footer.height")
//
//	iudw_corrente.modify("datawindow.footer.height = 5")
//	
//		//Scegli stampante
//		ls_num_doc=parent.classname()
//		IF is_doc_per_stampa>" " then
//			ls_num_doc=	is_doc_per_stampa
//		else
//			ls_data=string(today(), "dd-mm-yy")
//			ls_num_doc+="_"+ls_data
//		end if
//		ll_job=printopen(ls_num_doc, true)
//		printdatawindow(ll_job, iudw_corrente)
//	
//	
//		iudw_corrente.modify("datawindow.footer.height = "+is_h2_footer)
//		//prova 110511
////		iudw_corrente.rowscopy(1, ll_righe, primary!, dw_2, 1, primary!)
////		ll_righe=dw_2.rowcount()
////		for i=1 to ll_righe
////			dw_2.setitem(i, "n_pag", il_ult_pg_no_footer)
////		next
////		dw_2.setredraw(true)
//		//fine prova
//		ll_righe=iudw_corrente.rowcount()
//		for i=1 to ll_righe
//			iudw_corrente.setitem(i, "n_pag", il_ult_pg_no_footer)
//		next
//		printdatawindow(ll_job, iudw_corrente)
//		//printdatawindow(ll_job, dw_2)
//		printclose(ll_job)		
//		//reinserisco le righe tolte per la stampa a tutta pg
//		dw_1.rowsmove(1, dw_1.deletedcount(), delete!, dw_1, 1,  primary!)
//		
//		
//		
//	else
//		messagebox("Attenzione!", "Non c'è nulla da stampare!")
//	end if
end event

event pb_stampa::clicked;call super::clicked;//
end event

type sle_pg from w_stampa`sle_pg within w_st_doc
integer x = 1815
integer y = 20
integer width = 439
integer height = 72
end type

type st_1 from w_stampa`st_1 within w_st_doc
integer x = 1641
integer y = 20
integer width = 192
string text = "St. Pgg."
end type

type st_2 from w_stampa`st_2 within w_st_doc
boolean visible = true
integer x = 622
integer width = 146
end type

type sle_copie from w_stampa`sle_copie within w_st_doc
boolean visible = true
integer x = 773
integer y = 28
integer width = 169
end type

type sle_zoom from w_stampa`sle_zoom within w_st_doc
integer x = 169
integer y = 28
integer width = 123
end type

type cb_7 from w_stampa`cb_7 within w_st_doc
integer x = 41
integer y = 28
end type

type cb_6 from w_stampa`cb_6 within w_st_doc
integer x = 302
integer y = 28
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_doc
integer x = 535
integer y = 28
integer width = 82
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_doc
integer x = 443
integer y = 28
integer width = 82
end type

type cb_esci from w_stampa`cb_esci within w_st_doc
integer x = 3122
integer y = 28
integer width = 210
end type

type cb_mail from commandbutton within w_st_doc
integer x = 2272
integer y = 12
integer width = 219
integer height = 60
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "E-Mail"
end type

event clicked;integer i, li_ret
string ls_ret, ls_path, ls_st_pdf, ls_testo, ls_tipo_doc,ls_destinatario, ls_azienda
s_e_mail s_mail
string ls_allegato
//ls_filename, 


//CREARE UN CAMPO DIR_pdf IN VAL BASE
select dir_pdf
into :ls_path
from VAL_BASE
;

if ls_path>"" then 
	if right(ls_path, 1)<>'\' then ls_path+='\'
else
	ls_path="c:\"
end if

//ls_tipo_doc=
ls_ret=dw_1.Modify("DataWindow.Print.DocumentName = '"+is_doc_per_stampa+"'")
if ls_ret<>"" then messagebox("Errore", ls_ret)
ls_allegato=ls_path+is_doc_per_stampa+".pdf"
ls_ret=dw_1.Modify("DataWindow.Print.filename = '"+ls_allegato+"'")
if ls_ret<>"" then messagebox("Errore", ls_ret)

dw_1.Modify("Export.PDF.Method = Distill!")
dw_1.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
dw_1.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
li_ret=dw_1.SaveAs(ls_allegato, PDF!, FALSE)
IF LI_RET<> 1 THEN
	messagebox("Errore!", "File PDF non generato!")	
end if


select ana_rag_sociale, e_mail_1, e_mail_2
into :ls_destinatario, :s_mail.s_email_1, :s_mail.s_email_2
from dba.doc d, ana a, conto c
where d.doc_id=:il_id_doc
and d.doc_conto_id=c.conto_id
and c.ana_id=a.ana_id
;

s_mail.s_testo="Spettabile "+ls_destinatario+",~r~n"+&
"in allegato trasmettiamo "+ is_tipo_doc+" in oggetto in formato PDF.~r~n"+ &
"QUESTA STAMPA È PRIVA DI VALENZA GIURIDICO-FISCALE AI SENSI DELL’ARTICOLO 21 DPR 633/72."+&
"Per visualizzare l'allegato è necessario utilizzare Acrobat Reader (gratuitamente scaricabile presso "+&
"questo indirizzo:~r~nhttp://www.adobe.it/products/acrobat/readstep2.html).~r~n"+&
"Porgendo distinti saluti e ringraziando per la fiducia accordata, restiamo a completa "+&
"disposizione per ogni ulteriore informazione.~r~n~r~n"+&
ls_azienda+"~r~n"+&
"~r~n"+&
"~r~n"+&
"~r~n"+&
"Informativa Privacy: Ai sensi del D.Lgs n. 196/2003 (Codice Privacy)~r~n"+&
"si precisa che le informazioni contenute in questo messaggio~r~n"+&
"sono riservate e ad uso esclusivo del destinatario. ~r~n"+&
"Qualora il messaggio in parola Le fosse pervenuto per errore, ~r~n"+&
"La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,~r~n"+&
"dandocene gentilmente comunicazione. ~r~n"+&
"Grazie."
s_mail.s_allegato[1]=ls_path+is_doc_per_stampa+".pdf"
s_mail.s_oggetto=is_doc_per_stampa
openwithparm(w_invia_mail_new, s_mail )

end event

event rbuttondown;integer i, li_ret
string ls_ret, ls_path, ls_st_pdf, ls_testo, ls_tipo_doc,ls_destinatario, ls_azienda
s_e_mail s_mail
string ls_allegato
//ls_filename, 
/* devi creare un pdf cercando la stampante adatta e poi creare una mail con allegato
il pdf*/

//CREARE UN CAMPO DIR_pdf IN VAL BASE
select dir_pdf
into :ls_path
from VAL_BASE
;

if ls_path>"" then 
	if right(ls_path, 1)<>'\' then ls_path+='\'
else
	ls_path="c:\"
end if


ls_ret=dw_1.Modify("DataWindow.Print.DocumentName = '"+is_doc_per_stampa+"'")
if ls_ret<>"" then messagebox("Errore", ls_ret)
ls_allegato=ls_path+is_doc_per_stampa+".pdf"
ls_ret=dw_1.Modify("DataWindow.Print.filename = '"+ls_allegato+"'")
if ls_ret<>"" then messagebox("Errore", ls_ret)

dw_1.Modify("Export.PDF.Method = Distill!")
dw_1.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
dw_1.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
li_ret=dw_1.SaveAs(ls_allegato, PDF!, FALSE)
IF LI_RET<> 1 THEN
	messagebox("Errore!", "File PDF non generato!")	
end if


select ana_rag_sociale, e_mail_1, e_mail_2
into :ls_destinatario, :s_mail.s_email_1, :s_mail.s_email_2
from dba.doc d, ana a, conto c
where d.doc_id=:il_id_doc
and d.doc_conto_id=c.conto_id
and c.ana_id=a.ana_id
;

s_mail.s_testo="Spettabile "+ls_destinatario+",~r~n"+&
"in allegato trasmettiamo "+ ls_tipo_doc+" in oggetto in formato PDF.~r~n"+ &
"Come da precedenti accordi, e nel rispetto delle disposizioni di Legge, non verrà spedita alcuna copia cartacea.~r~n"+&
"La fattura allegata va stampata e conservata per tutti i necessari adempimenti di Legge, come disposto dal DPR 633/72 "+&
"(succ. modifiche) e dalla risoluzione del Ministero delle Finanze PROT.450217 del 30 Luglio 1990.~r~n"+&
"Per visualizzare l'allegato è necessario utilizzare Acrobat Reader (gratuitamente scaricabile presso "+&
"questo indirizzo:~r~nhttp://www.adobe.it/products/acrobat/readstep2.html).~r~n"+&
"Porgendo distinti saluti e ringraziando per la fiducia accordata, restiamo a completa "+&
"disposizione per ogni ulteriore informazione.~r~n~r~n"+&
ls_azienda+"~r~n"+&
"~r~n"+&
"~r~n"+&
"~r~n"+&
"Informativa Privacy: Ai sensi del D.Lgs n. 196/2003 (Codice Privacy)~r~n"+&
"si precisa che le informazioni contenute in questo messaggio~r~n"+&
"sono riservate e ad uso esclusivo del destinatario. ~r~n"+&
"Qualora il messaggio in parola Le fosse pervenuto per errore, ~r~n"+&
"La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,~r~n"+&
"dandocene gentilmente comunicazione. ~r~n"+&
"Grazie."
s_mail.s_allegato[1]=ls_path+is_doc_per_stampa+".pdf"
s_mail.s_oggetto=is_doc_per_stampa
s_mail.l_id_doc=il_id_doc
s_mail.s_tipo_ae=is_tipo_ae
openwithparm(w_invia_mail_new, s_mail )
end event

type cbx_prezzo_ddt from checkbox within w_st_doc
integer x = 965
integer y = 4
integer width = 315
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No Prezzo"
end type

event clicked;if checked then
	dw_1.modify("c_prezzo.visible=0")
else
	dw_1.modify("c_prezzo.visible=1")
end if
end event

type cb_1 from commandbutton within w_st_doc
integer x = 2272
integer y = 76
integer width = 219
integer height = 68
integer taborder = 18
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Busta"
end type

event clicked;//stampa la busta con l'indirizzo dell'intestatario
string ls_path_stampe, dwsyntax
long ll_id_ana


if il_id_doc>0 then
	select dir_stampe
	into :ls_path_stampe
	from dba.val_base;
	if isnull(ls_path_stampe) then 
		ls_path_stampe=''
	elseif ls_path_stampe>'' then
		ls_path_stampe=ls_path_stampe+'\'
	end if
	select ana_id
	into :ll_id_ana
	from dba.doc, dba.conto
	where doc_id=:il_id_doc
	and doc.doc_conto_id=conto.conto_id
	;
	
	dwsyntax = LibraryExport(ls_path_stampe+"sultak100.pbl", "d_ana_lettere", ExportDataWindow!)
	IF dwsyntax>"" THEN
		messagebox("J", dwsyntax)
		dw_1.create(dwsyntax)
		dw_1.settransobject(sqlca)
		dw_1.retrieve(ll_id_ana)
		dw_1.object.datawindow.print.preview='yes'
	else
		close(parent)
	end if
else
	close(parent)
end if
end event

type cbx_1 from checkbox within w_st_doc
integer x = 965
integer y = 84
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
string text = "Tutta Pg"
end type

event clicked;string ls_path_stampe, dwsyntax
date ldt_data_inizio_saldi

select dir_stampe, data_inizio_saldi
	into :ls_path_stampe, :ldt_data_inizio_saldi
	from dba.val_base;
	if isnull(ls_path_stampe) then 
		ls_path_stampe=''
	elseif ls_path_stampe>'' then
		ls_path_stampe=ls_path_stampe+'\'
	end if

if checked then
	dwsyntax = LibraryExport(ls_path_stampe+"sultak100.pbl", is_dw_stampa+"_sum", ExportDataWindow!)
	IF dwsyntax>"" THEN
		dw_1.create(dwsyntax)
		dw_1.settransobject(sqlca)
		dw_1.retrieve(il_id_doc, ldt_data_inizio_saldi)
	else
		messagebox("Attenzione!", "Stampa non trovata! Controlla path stampe nei valori base o forse non hai la stampa "+is_dw_stampa+ "_sum")
	end if
else
	dwsyntax = LibraryExport(ls_path_stampe+"sultak100.pbl", is_dw_stampa, ExportDataWindow!)
	IF dwsyntax>"" THEN
		dw_1.create(dwsyntax)
		dw_1.settransobject(sqlca)
		dw_1.retrieve(il_id_doc, ldt_data_inizio_saldi)
	else
		messagebox("Attenzione!", "Stampa non trovata! Controlla path stampe nei valori base o forse non hai: "+is_dw_stampa)
	end if
end if
	


end event

type cbx_vedi_saldi from checkbox within w_st_doc
integer x = 1280
integer y = 12
integer width = 329
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
string text = "Vedi Saldi"
end type

event clicked;if checked then
	dw_1.MODIFY("dw_5.visible=1")
else
	dw_1.MODIFY("dw_5.visible=0")
end if


end event

type pb_2 from picturebutton within w_st_doc
integer x = 1998
integer y = 92
integer width = 265
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F.E."
boolean originalsize = true
vtextalign vtextalign = vcenter!
long backcolor = 65535
end type

event clicked;integer i, li_ret
string ls_ret, ls_path, ls_st_pdf, ls_testo, ls_tipo_doc,ls_destinatario, ls_azienda, ls_file_fe
s_e_mail s_mail
string ls_allegato
//ls_filename, 
/* devi creare un pdf cercando la stampante adatta e poi creare una mail con allegato
il pdf*/

//CREARE UN CAMPO DIR_pdf IN VAL BASE
select dir_pdf
into :ls_path
from VAL_BASE
;

if ls_path>"" then 
	if right(ls_path, 1)<>'\' then ls_path+='\'
else
	ls_path="c:\"
end if


ls_ret=dw_1.Modify("DataWindow.Print.DocumentName = '"+is_doc_per_stampa+"'")
if ls_ret<>"" then messagebox("Errore", ls_ret)
ls_allegato=ls_path+is_doc_per_stampa+".pdf"
ls_ret=dw_1.Modify("DataWindow.Print.filename = '"+ls_allegato+"'")
if ls_ret<>"" then messagebox("Errore", ls_ret)

dw_1.Modify("Export.PDF.Method = Distill!")
dw_1.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
dw_1.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
li_ret=dw_1.SaveAs(ls_allegato, PDF!, FALSE)
IF LI_RET<> 1 THEN
	messagebox("Errore!", "File PDF non generato!")	
end if


select ana_rag_sociale, e_mail_1, e_mail_2
into :ls_destinatario, :s_mail.s_email_1, :s_mail.s_email_2
from dba.doc d, ana a, conto c
where d.doc_id=:il_id_doc
and d.doc_conto_id=c.conto_id
and c.ana_id=a.ana_id
;
ls_file_fe=f_crea_fat_e(il_id_doc)

	
s_mail.s_testo=""
/*"Spettabile "+ls_destinatario+",~r~n"+&
"in allegato trasmettiamo "+ ls_tipo_doc+" in oggetto in formato PDF.~r~n"+ &
"Come da precedenti accordi, e nel rispetto delle disposizioni di Legge, non verrà spedita alcuna copia cartacea.~r~n"+&
"La fattura allegata va stampata e conservata per tutti i necessari adempimenti di Legge, come disposto dal DPR 633/72 "+&
"(succ. modifiche) e dalla risoluzione del Ministero delle Finanze PROT.450217 del 30 Luglio 1990.~r~n"+&
"Per visualizzare l'allegato è necessario utilizzare Acrobat Reader (gratuitamente scaricabile presso "+&
"questo indirizzo:~r~nhttp://www.adobe.it/products/acrobat/readstep2.html).~r~n"+&
"Porgendo distinti saluti e ringraziando per la fiducia accordata, restiamo a completa "+&
"disposizione per ogni ulteriore informazione.~r~n~r~n"+&
ls_azienda+"~r~n"+&
"~r~n"+&
"~r~n"+&
"~r~n"+&
"Informativa Privacy: Ai sensi del D.Lgs n. 196/2003 (Codice Privacy)~r~n"+&
"si precisa che le informazioni contenute in questo messaggio~r~n"+&
"sono riservate e ad uso esclusivo del destinatario. ~r~n"+&
"Qualora il messaggio in parola Le fosse pervenuto per errore, ~r~n"+&
"La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,~r~n"+&
"dandocene gentilmente comunicazione. ~r~n"+&
"Grazie."*/
//s_mail.s_allegato[1]=ls_path+is_doc_per_stampa+".pdf"
s_mail.s_allegato[1]=ls_file_fe
s_mail.s_oggetto=is_doc_per_stampa
s_mail.l_id_doc=il_id_doc
s_mail.s_tipo_ae=is_tipo_ae
openwithparm(w_invia_mail_new, s_mail)
end event

type cbx_importo from checkbox within w_st_doc
integer x = 1280
integer y = 84
integer width = 315
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sì Importo"
end type

event clicked;if checked then
	dw_1.modify("c_imp_riga.visible=1")
else
	dw_1.modify("c_imp_riga.visible=0")
end if
end event

type cbx_ordina from checkbox within w_st_doc
integer x = 1595
integer y = 92
integer width = 375
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
string text = "Ord. Cod. Art."
end type

event clicked;if checked then
	dw_1.setsort("art_art_codice, rdoc_rdoc_numero")
else
	dw_1.setsort("rdoc_rdoc_numero")
end if
dw_1.sort()
end event

