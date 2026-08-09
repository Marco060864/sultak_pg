forward
global type w_web_ins_art_immagini from w_semplice_cx
end type
type cb_creatxt from commandbutton within w_web_ins_art_immagini
end type
type cb_retrieve from commandbutton within w_web_ins_art_immagini
end type
type cb_reset from commandbutton within w_web_ins_art_immagini
end type
type cbx_sel_tutti from checkbox within w_web_ins_art_immagini
end type
type cbx_vedi from checkbox within w_web_ins_art_immagini
end type
type cb_connetti from commandbutton within w_web_ins_art_immagini
end type
type uo_remote from u_panel_remote within w_web_ins_art_immagini
end type
type cb_http from commandbutton within w_web_ins_art_immagini
end type
type lb_msgbox from listbox within w_web_ins_art_immagini
end type
type uo_local from u_panel_local within w_web_ins_art_immagini
end type
type sle_dir_web from singlelineedit within w_web_ins_art_immagini
end type
type st_1 from statictext within w_web_ins_art_immagini
end type
type st_2 from statictext within w_web_ins_art_immagini
end type
type sle_dir_locale from singlelineedit within w_web_ins_art_immagini
end type
type st_3 from statictext within w_web_ins_art_immagini
end type
type sle_est from singlelineedit within w_web_ins_art_immagini
end type
type cb_mail from commandbutton within w_web_ins_art_immagini
end type
type cb_diametro from commandbutton within w_web_ins_art_immagini
end type
end forward

global type w_web_ins_art_immagini from w_semplice_cx
integer width = 4886
integer height = 2067
boolean maxbox = true
cb_creatxt cb_creatxt
cb_retrieve cb_retrieve
cb_reset cb_reset
cbx_sel_tutti cbx_sel_tutti
cbx_vedi cbx_vedi
cb_connetti cb_connetti
uo_remote uo_remote
cb_http cb_http
lb_msgbox lb_msgbox
uo_local uo_local
sle_dir_web sle_dir_web
st_1 st_1
st_2 st_2
sle_dir_locale sle_dir_locale
st_3 st_3
sle_est sle_est
cb_mail cb_mail
cb_diametro cb_diametro
end type
global w_web_ins_art_immagini w_web_ins_art_immagini

type variables
boolean ib_stopaction
end variables

forward prototypes
public subroutine wf_addmsg (string as_msg)
public function string wf_copia_imm_in_web (string as_path_file)
end prototypes

public subroutine wf_addmsg (string as_msg);lb_msgbox.InsertItem(as_msg,1)

Yield()

lb_msgbox.SetRedraw(True)

end subroutine

public function string wf_copia_imm_in_web (string as_path_file);string ls_directory, ls_remotefile,ls_solo_file
integer li_pos, i, li_pos_ok

li_pos=0

ls_directory="/www.foma52ar.com/wp/wp-content/uploads/2016/01/"

li_pos=pos(as_path_file, "\", li_pos+1)
do while li_pos>0
	li_pos_ok=li_pos
	li_pos=pos(as_path_file, "\", li_pos+1)
loop
ls_solo_file=right(as_path_file, len(as_path_file) - li_pos_ok)

ls_remotefile=ls_directory+ls_solo_file

If Not gn_ftp.of_ftp_SetCurrentDirectory(ls_directory) Then
	MessageBox("SetCurrentDirectory Error " + String(gn_ftp.LastErrorNbr), gn_ftp.LastErrorMsg, StopSign!)
End If
//settaggi per copiare immagine nel sito
gn_ftp.of_Ftp_GetCurrentDirectory(ls_directory)


If Not gn_ftp.of_Ftp_WriteFile(as_path_file, ls_remotefile, Handle(gw_frame), 1025) Then
	gw_frame.wf_addmsg(gn_ftp.LastErrorMsg)
	MessageBox("WriteFile Error " + String(gn_ftp.LastErrorNbr), gn_ftp.LastErrorMsg, StopSign!)
	Return ls_solo_file
End If
return ls_solo_file
end function

on w_web_ins_art_immagini.create
int iCurrent
call super::create
this.cb_creatxt=create cb_creatxt
this.cb_retrieve=create cb_retrieve
this.cb_reset=create cb_reset
this.cbx_sel_tutti=create cbx_sel_tutti
this.cbx_vedi=create cbx_vedi
this.cb_connetti=create cb_connetti
this.uo_remote=create uo_remote
this.cb_http=create cb_http
this.lb_msgbox=create lb_msgbox
this.uo_local=create uo_local
this.sle_dir_web=create sle_dir_web
this.st_1=create st_1
this.st_2=create st_2
this.sle_dir_locale=create sle_dir_locale
this.st_3=create st_3
this.sle_est=create sle_est
this.cb_mail=create cb_mail
this.cb_diametro=create cb_diametro
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_creatxt
this.Control[iCurrent+2]=this.cb_retrieve
this.Control[iCurrent+3]=this.cb_reset
this.Control[iCurrent+4]=this.cbx_sel_tutti
this.Control[iCurrent+5]=this.cbx_vedi
this.Control[iCurrent+6]=this.cb_connetti
this.Control[iCurrent+7]=this.uo_remote
this.Control[iCurrent+8]=this.cb_http
this.Control[iCurrent+9]=this.lb_msgbox
this.Control[iCurrent+10]=this.uo_local
this.Control[iCurrent+11]=this.sle_dir_web
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.sle_dir_locale
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.sle_est
this.Control[iCurrent+17]=this.cb_mail
this.Control[iCurrent+18]=this.cb_diametro
end on

on w_web_ins_art_immagini.destroy
call super::destroy
destroy(this.cb_creatxt)
destroy(this.cb_retrieve)
destroy(this.cb_reset)
destroy(this.cbx_sel_tutti)
destroy(this.cbx_vedi)
destroy(this.cb_connetti)
destroy(this.uo_remote)
destroy(this.cb_http)
destroy(this.lb_msgbox)
destroy(this.uo_local)
destroy(this.sle_dir_web)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_dir_locale)
destroy(this.st_3)
destroy(this.sle_est)
destroy(this.cb_mail)
destroy(this.cb_diametro)
end on

event resize;call super::resize;cb_creatxt.x=cb_stampa.x + 285
cb_creatxt.y=cb_salva.y

cb_retrieve.x=cb_creatxt.x + 285
cb_retrieve.y=cb_salva.y

cb_reset.x=cb_retrieve.x + 285
cb_reset.y=cb_salva.y

cb_diametro.x=cb_reset.x + cb_reset.width + 50
cb_diametro.y=cb_salva.y
cb_mail.x=cb_diametro.x +cb_diametro.width + 20
cb_mail.y=cb_salva.y


dw_1.y=200

dw_1.height=newheight - (292+dw_1.y)



end event

event open;call super::open;datawindowchild dwc_metallo, dwc_categoria, dwc_tubo


integer rtncode

rtncode = dw_1.GetChild('id_titolo', dwc_metallo)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild metallo")

rtncode = dw_1.GetChild( 'id_web_categoria', dwc_categoria)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild categoria")
// Establish the connection
rtncode = dw_1.GetChild( 'web_art_id_tubo', dwc_tubo)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild tubo")


CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_metallo.SetTransObject(SQLCA)

// Populate with values for eastern states
dwc_metallo.setfilter("metallo='M'")
dwc_metallo.filter()
dwc_metallo.Retrieve()

dwc_categoria.SetTransObject(SQLCA)

// Populate with values for eastern states
dwc_categoria.setfilter("metallo='C')")
dwc_categoria.filter()
dwc_categoria.Retrieve()
// Set transaction object for main DW and retrieve
dwc_tubo.SetTransObject(SQLCA)

// Populate with values for eastern states
dwc_tubo.setfilter("metallo='T'")
dwc_tubo.filter()
dwc_tubo.Retrieve()

end event

type cb_stampa from w_semplice_cx`cb_stampa within w_web_ins_art_immagini
integer x = 3438
integer y = 1802
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_web_ins_art_immagini
integer x = 987
integer y = 1808
end type

type cb_primo from w_semplice_cx`cb_primo within w_web_ins_art_immagini
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_web_ins_art_immagini
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_web_ins_art_immagini
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_web_ins_art_immagini
end type

type dw_1 from w_semplice_cx`dw_1 within w_web_ins_art_immagini
integer x = 44
integer y = 224
integer width = 4784
integer height = 1510
string dataobject = "d_web_art_immagine"
boolean vscrollbar = true
end type

event dw_1::itemchanged;call super::itemchanged;string ls_path, ls_est

if dwo.name="codice" then
//	select web_path_imm, web_est_imm
//	into :ls_path, :ls_est
//	from dba.val_base
//	;
	ls_est=sle_est.text
	ls_path=	sle_dir_locale.text
	if ls_path> " " then
		post setitem(row, "path_imm", ls_path+data+"."+ls_est)
	end if
end if
end event

type cb_inserisci from w_semplice_cx`cb_inserisci within w_web_ins_art_immagini
integer y = 1802
end type

type cb_salva from w_semplice_cx`cb_salva within w_web_ins_art_immagini
integer y = 1802
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_web_ins_art_immagini
integer y = 1802
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_web_ins_art_immagini
integer x = 3109
integer y = 1808
end type

type cb_ok from w_semplice_cx`cb_ok within w_web_ins_art_immagini
integer x = 3749
integer y = 1805
end type

type cb_creatxt from commandbutton within w_web_ins_art_immagini
integer x = 1306
integer y = 1805
integer width = 260
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea TXT"
end type

event clicked;integer i, li_FileNum, li_scelto
string ls_codice,ls_des, ls_path, ls_riga, ls_nome_file, ls_cartella_web
string ls_errmsg, ls_directory, ls_dir, ls_file_remote, ls_file_imm,ls_nome_imm
decimal ldc_prezzo, ldc_peso, ldc_misura
long ll_id_categoria, ll_id_cat_metallo, ll_id_titolo, ll_id_cat_tubo
boolean lb_result

select web_file_txt
into :ls_nome_file
from dba.val_base
;
if ls_nome_file> " " then
	if right(ls_nome_file, 1)<>"\" then ls_nome_file+="\"
	ls_file_remote="ART"+string(today(),"dd_mm_yyyy_hh_mm")+".txt"
	ls_nome_file+="ART"+string(today(),"dd_mm_yyyy_hh_mm")+".txt"
	li_FileNum = FileOpen(ls_nome_file, LineMode!, Write!, LockWrite!, Replace!)
	if li_FileNum>0 then
		ls_cartella_web=sle_dir_web.text
		if isnull(ls_cartella_web) or ls_cartella_web="" then
			messagebox( "Attenzione!", "Manca il valore della cartella WEB!" )
			return
		end if
		for i = 1 to dw_1.rowcount()
			li_scelto=dw_1.getitemnumber(i, "c_scelto")
			if li_scelto=1 then
				ls_codice=dw_1.getitemstring(i, "codice")
				ls_des=dw_1.getitemstring(i, "descrizione")
				if isnull(ls_des) then ls_des=""
				ll_id_categoria=dw_1.getitemnumber(i, "id_web_categoria")
				if isnull(ll_id_categoria) then ll_id_categoria=0
				ldc_peso=dw_1.getitemdecimal(i, "peso")
				if isnull(ldc_peso) then ldc_peso=0
				ldc_misura=dw_1.getitemdecimal(i, "misura")
				if isnull(ldc_misura) then ldc_misura=0
				ldc_prezzo=dw_1.getitemdecimal(i, "prezzo")
				if isnull(ldc_prezzo) then ldc_prezzo=0
				ls_path=dw_1.getitemstring(i, "path_imm")
				ll_id_cat_metallo=dw_1.getitemnumber(i, "id_titolo")
				if isnull(ll_id_cat_metallo) then ll_id_cat_metallo=0
				ll_id_cat_tubo=dw_1.getitemnumber(i, "web_art_id_tubo")
				if isnull(ll_id_cat_tubo) then ll_id_cat_tubo=0
				//copio il file immagine (la foto) sul sito web
				ls_file_imm=left(ls_path, len(ls_path) - 4)+"-600x600"+right(ls_path, 4)
				ls_nome_imm=wf_copia_imm_in_web(ls_file_imm)
				ls_riga=ls_codice+";"+ls_des+";"+string(ll_id_categoria)+";"+string(ldc_peso)+";"+string(ldc_misura)+&
				";"+string(ldc_prezzo)+";"+ls_cartella_web+ls_nome_imm+";"+string(ll_id_cat_metallo)+";"+string(ll_id_cat_tubo)
				filewrite(li_FileNum, ls_riga)
				dw_1.setitem(i, "passato", "S")
			end if
		next
		fileclose(li_FileNum)
		messagebox( "OK!", "Creato file: "+ls_nome_file )
		dw_1.trigger event ue_update()
	//connessione e copia del file nel sito foma
		lb_result = gn_ftp.of_Ftp_InternetConnect("ftp.foma52ar.com", "5364718@aruba.it", "pippone01",  0, true)
		If lb_result = False Then
			ls_errmsg = "Connect Error " + String(gn_ftp.LastErrorNbr)
			//gw_frame.wf_addmsg(ls_errmsg + ": " + gn_ftp.LastErrorMsg)
			MessageBox(ls_errmsg, gn_ftp.LastErrorMsg, StopSign!)
		End If
		ls_directory="/www.foma52ar.com/art/"
		
		If Not gn_ftp.of_ftp_SetCurrentDirectory(ls_directory) Then
			MessageBox("SetCurrentDirectory Error " + String(gn_ftp.LastErrorNbr), gn_ftp.LastErrorMsg, StopSign!)
		End If
		gn_ftp.of_Ftp_GetCurrentDirectory(ls_dir)
		//MessageBox(ls_dir, ls_dir, StopSign!)
		If Not gn_ftp.of_Ftp_WriteFile(ls_nome_file,ls_file_remote, Handle(gw_frame), 1025) Then
			MessageBox("WriteFile Error " + String(gn_ftp.LastErrorNbr), gn_ftp.LastErrorMsg, StopSign!)
		end if
		
		
		
	end if
else
	messagebox("Attenzione!", "Manca web_file_txt nei valori base!")
end if
end event

type cb_retrieve from commandbutton within w_web_ins_art_immagini
integer x = 1971
integer y = 1808
integer width = 260
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retrieve"
end type

event clicked;if messagebox("Attenzione!", "Sei sicuro di voler cancellare il contenuto di questa finestra?", stopsign!, yesno!)=1 then
	dw_1.retrieve()
end if
end event

type cb_reset from commandbutton within w_web_ins_art_immagini
integer x = 1664
integer y = 1808
integer width = 260
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "RESET"
end type

event clicked;if messagebox("Attenzione!", "Sei sicuro di voler cancellare il contenuto di questa finestra?", stopsign!, yesno!)=1 then
	dw_1.reset()
end if
end event

type cbx_sel_tutti from checkbox within w_web_ins_art_immagini
integer x = 3836
integer y = 138
integer width = 432
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleziona Tutti"
boolean lefttext = true
end type

event clicked;long i

if checked then
	for i= 1 to dw_1.rowcount()
		dw_1.setitem(i, "c_scelto", 1)
	next
else
	for i= 1 to dw_1.rowcount()
		dw_1.setitem(i, "c_scelto", 0)
	next
end if
end event

type cbx_vedi from checkbox within w_web_ins_art_immagini
integer x = 55
integer y = 115
integer width = 1137
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostro SOLO articoli da passare"
boolean checked = true
boolean threestate = true
end type

event clicked;if checked and  thirdstate=false then
	dw_1.setfilter("passato='N'")
	text="Mostro SOLO articoli da passare"
elseif thirdstate=true then
	dw_1.setfilter("passato='S'")
	text="Mostro SOLO gli articoli passati"
else
	dw_1.setfilter("")
	text="Mostro TUTTI gli articoli"
end if
dw_1.filter()
end event

type cb_connetti from commandbutton within w_web_ins_art_immagini
boolean visible = false
integer x = 2586
integer y = 1808
integer width = 413
integer height = 106
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Connetti"
end type

event clicked;string ls_server, ls_userid, ls_password, ls_errmsg
boolean lb_result, lb_passive
uint lui_port

ls_server="ftp.foma52ar.com"
ls_userid="5364718@aruba.it"  
ls_password="pippone01"
lui_port=0
lb_passive=true
lb_result = gn_ftp.of_Ftp_InternetConnect(ls_server, ls_userid, ls_password, lui_port, lb_passive)

If lb_result = False Then
	ls_errmsg = "Connect Error " + String(gn_ftp.LastErrorNbr)
	//gw_frame.wf_addmsg(ls_errmsg + ": " + gn_ftp.LastErrorMsg)
	MessageBox(ls_errmsg, gn_ftp.LastErrorMsg, StopSign!)
End If
//gw_frame.wf_addmsg("Session connected")




//gw_frame.wf_addmsg("Disconnecting existing session")
//gn_ftp.of_SessionClose()
//gw_frame.wf_addmsg("Session disconnected")


end event

type uo_remote from u_panel_remote within w_web_ins_art_immagini
boolean visible = false
integer x = 3961
integer y = 928
integer width = 377
integer height = 189
integer taborder = 20
boolean bringtotop = true
end type

on uo_remote.destroy
call u_panel_remote::destroy
end on

type cb_http from commandbutton within w_web_ins_art_immagini
boolean visible = false
integer x = 95
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
string text = "http connect"
end type

event clicked;n_wininet lo_n_wininet

if lo_n_wininet.of_Http_InternetConnect("8.8.8.8", 80)=false then
	messagebox("ATT", "NO connection")
end if

if lo_n_wininet.of_Http_OpenRequest("http://www.foma52ar.com", "FOMA", false)=false then
	messagebox("ATT", "NO OR")
end if





end event

type lb_msgbox from listbox within w_web_ins_art_immagini
boolean visible = false
integer x = 3866
integer y = 698
integer width = 494
integer height = 170
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type uo_local from u_panel_local within w_web_ins_art_immagini
boolean visible = false
integer x = 4041
integer y = 387
integer width = 263
integer height = 163
integer taborder = 30
boolean bringtotop = true
end type

on uo_local.destroy
call u_panel_local::destroy
end on

type sle_dir_web from singlelineedit within w_web_ins_art_immagini
integer x = 1573
integer y = 106
integer width = 1324
integer height = 83
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "2016/01/"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_web_ins_art_immagini
integer x = 955
integer y = 115
integer width = 614
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cartella immagini WEB:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_web_ins_art_immagini
integer x = 955
integer y = 19
integer width = 614
integer height = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cartella immagini Locale:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_dir_locale from singlelineedit within w_web_ins_art_immagini
integer x = 1573
integer y = 10
integer width = 1324
integer height = 83
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "c:\sultak\foto\"
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_web_ins_art_immagini
integer x = 2955
integer y = 26
integer width = 373
integer height = 54
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo Immagini: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_est from singlelineedit within w_web_ins_art_immagini
integer x = 3324
integer y = 10
integer width = 197
integer height = 83
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "jpg"
borderstyle borderstyle = stylelowered!
end type

type cb_mail from commandbutton within w_web_ins_art_immagini
integer x = 2461
integer y = 1862
integer width = 260
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Invia Mail"
end type

event clicked;integer li_scelto, i, a=0
s_e_mail ls_mail
string ls_immagine, ls_azienda

select az_codice
into :ls_azienda
from dba.azienda
;

for i = 1 to dw_1.rowcount()
	li_scelto=dw_1.getitemnumber(i, "c_scelto")
	if li_scelto=1 then
		a++
		if ls_azienda="FOMA" then
			ls_immagine=dw_1.getitemstring(i, "path_imm")
			ls_mail.s_allegato[a]=left(ls_immagine, len(ls_immagine) - 4) +"-1200x1200"+right(ls_immagine, 4)
		else
			ls_mail.s_allegato[a]=dw_1.getitemstring(i, "path_imm")
		end if
	end if
next

openwithparm(w_invia_mail_new, ls_mail)
end event

type cb_diametro from commandbutton within w_web_ins_art_immagini
integer x = 2256
integer y = 1792
integer width = 260
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Metti Ø"
end type

event clicked;integer i, li_scelto
decimal ldc_misura
string ls_des

for i= 1 to dw_1.rowcount()
	li_scelto=dw_1.getitemnumber(i, "c_scelto")
		if li_scelto=1 then
			ldc_misura=dw_1.getitemdecimal(i, "misura")
			if ldc_misura>0 then
				ls_des=dw_1.getitemstring(i, "descrizione")
				ls_des+= " - Ø "+ string(ldc_misura)
				dw_1.setitem(i, "descrizione", ls_des)
			end if
		end if
next
	
end event

