forward
global type w_agenda from w_padre_figlio_cx
end type
type dw_3 from udw_000 within w_agenda
end type
type cb_localita from commandbutton within w_agenda
end type
type mc_1 from monthcalendar within w_agenda
end type
type st_1 from statictext within w_agenda
end type
type cb_1 from commandbutton within w_agenda
end type
type cb_2 from commandbutton within w_agenda
end type
end forward

global type w_agenda from w_padre_figlio_cx
integer width = 3863
integer height = 2628
string title = "Agenda"
dw_3 dw_3
cb_localita cb_localita
mc_1 mc_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
end type
global w_agenda w_agenda

type variables
boolean ib_applica_filtro
end variables

forward prototypes
public subroutine wf_cerca_riga (long al_id, long al_row)
end prototypes

public subroutine wf_cerca_riga (long al_id, long al_row);long ll_id_ana, ll_riga
string ls_rag_soc, ls_indirizzo, LS_CITTA, ls_localita, ls_provincia
string  la_ana, ls_p_iva, ls_c_f, ls_cap


ll_id_ana=long(al_id)
if ll_id_ana>0 then
	ll_riga=dw_1.find("agenda_agenda_id_ana="+string(ll_id_ana), 1, dw_1.rowcount())
	if ll_riga>0 then
		dw_1.setcolumn(2)
		dw_1.scrolltorow(ll_riga)
		//dw_1.post deleterow(al_row)
	else
		dw_2.RESET()
		ll_riga=dw_1.trigger event ue_insert(0)
		select ana_rag_sociale, ana_indirizzo, ana_citta, ana_localita, ana_provincia, ana_cap,
				ana_p_iva, ana_c_f
		into :ls_rag_soc, :ls_indirizzo, :LS_CITTA, :ls_localita, :ls_provincia,  :ls_cap,
				:ls_p_iva, :ls_c_f
		from dba.ana
		where ana_id=:ll_id_ana
		;
		dw_1.setitem(ll_riga, "rag_sociale", ls_rag_soc)
		dw_1.setitem(ll_riga, "indirizzo", ls_indirizzo)
		dw_1.setitem(ll_riga, "cap", ls_cap)
		dw_1.setitem(ll_riga, "citta", ls_citta)
		dw_1.setitem(ll_riga, "provincia", ls_provincia)
		dw_1.setitem(ll_riga, "p_iva", ls_p_iva)
		dw_1.setitem(ll_riga, "c_f", ls_c_f)
		dw_1.setitem(ll_riga, "agenda_agenda_id_ana", ll_id_ana)
		
	end if
end if
end subroutine

on w_agenda.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.cb_localita=create cb_localita
this.mc_1=create mc_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.cb_localita
this.Control[iCurrent+3]=this.mc_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
end on

on w_agenda.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.cb_localita)
destroy(this.mc_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;dw_3.settransobject(sqlca)
dw_3.post retrieve(today())
//dw_3.object.datawindow.print.preview='yes'

title=String(today(), "dd/mm/yyyy")

end event

type cb_ricerca from w_padre_figlio_cx`cb_ricerca within w_agenda
boolean visible = false
integer taborder = 90
end type

type dw_1 from w_padre_figlio_cx`dw_1 within w_agenda
integer x = 27
integer y = 32
integer width = 2112
integer height = 1068
string dataobject = "d_agenda"
boolean livescroll = false
end type

event dw_1::clicked;call super::clicked;s_ricerca s_ric
w_new_ricerca_sw w_ric_sw
long ll_id, ll_riga

if dwo.name="p_ricerca" then
	s_ric.dataobject='d_sog_sw'
	s_ric.titolo_finestra="Ricerca Soggetti"
	dw_1.accepttext()
//	if dw_1.rowcount()<1 then
//		cb_inserisci.triggerevent(clicked!)
//	end if
//	if ib_applica_filtro=true then
//		s_ric.filtro[1]=dw_1.getitemstring(1, "ana_rag_sociale")
//		s_ric.colonna_filtro[1]="ana_ana_rag_sociale"
//		ib_applica_filtro=false
//	end if
	
	openwithparm(w_ric_sw, s_ric)
	if isvalid(message) then ll_id=message.doubleparm
	
	wf_cerca_riga(ll_id, row)
//	if ll_riga>0 then
//		dw_1.trigger event rowfocuschanged(ll_riga)
//	else
//		cb_inserisci.triggerevent(clicked!)
//	end if
end if

end event

event dw_1::ue_delete;call super::ue_delete;if dw_1.rowcount()>0 then
	scrolltorow(1)
end if
end event

type dw_2 from w_padre_figlio_cx`dw_2 within w_agenda
integer x = 23
integer y = 1116
integer width = 3762
integer height = 828
boolean titlebar = true
string title = "Visite"
string dataobject = "d_visite"
boolean vscrollbar = true
end type

event dw_2::updateend;call super::updateend;integer li_riga

sort()
li_riga=dw_1.getrow()
dw_3.retrieve(today())
dw_1.scrolltorow(li_riga)
dw_2.scrolltorow(dw_2.rowcount())
end event

event dw_2::ue_post_insert;call super::ue_post_insert;decimal ldc_costo_ora, ldc_costo_viaggio

if rowcount()>1 then
	ldc_costo_ora=getitemdecimal(al_riga - 1, "visite_costo_ora")
	setitem(al_riga, "visite_costo_ora", ldc_costo_ora)
	ldc_costo_viaggio=getitemdecimal(al_riga - 1, "visite_costo_viaggio")
	setitem(al_riga, "visite_costo_viaggio", ldc_costo_viaggio)
	
end if
end event

event dw_2::ue_key;call super::ue_key;string ls_file
integer li_riga
long ll_id_riga

if key=keyF2! then
	li_riga=getrow()
	if li_riga>0 then
		ll_id_riga=getitemnumber(li_riga, "visite_id")
		if ll_id_riga>0 then
			ls_file="DOC_"+string(getitemnumber(li_riga, "visite_id"))+".rtf"
			openwithparm(w_doc_agenda, ls_file)
		end if
	end if
end if
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;string ls_dir, ls_file

if currentrow>0 then
	select dir_pdf
	into :ls_dir
	from dba.val_base
	;
	if isnull(ls_dir) then ls_dir='c:\'
	if right(ls_dir,1)<>"\" then ls_dir+="\"
	ls_file="DOC_"+string(getitemnumber(currentrow, "visite_id"))+".rtf"
	if fileexists(ls_dir+ls_file) then
		setitem(currentrow, "visite_giudizio", "N")
		
	end if
end if
end event

type cb_inserisci from w_padre_figlio_cx`cb_inserisci within w_agenda
integer x = 64
integer y = 2284
integer taborder = 40
end type

type cb_salva from w_padre_figlio_cx`cb_salva within w_agenda
integer x = 352
integer y = 2284
integer taborder = 50
end type

type cb_cancella from w_padre_figlio_cx`cb_cancella within w_agenda
integer x = 654
integer y = 2284
integer taborder = 80
end type

type cb_annulla from w_padre_figlio_cx`cb_annulla within w_agenda
integer x = 2994
integer y = 2276
integer taborder = 60
end type

type cb_ok from w_padre_figlio_cx`cb_ok within w_agenda
integer x = 3287
integer y = 2276
integer taborder = 70
end type

type dw_3 from udw_000 within w_agenda
integer x = 2162
integer y = 28
integer width = 1618
integer height = 1076
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Appuntamenti in scadenza"
string dataobject = "d_scad_visite"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_id_ana, ll_id_visite
integer li_riga
if currentrow >0 then
	ll_id_ana=getitemnumber(currentrow, "ana_id")
	if ll_id_ana>0 then
		li_riga=dw_1.find("agenda_agenda_id_ana="+string(ll_id_ana), 1, dw_1.rowcount())
		if Li_riga>0 then
			dw_1.scrolltorow(li_riga)
			ll_id_visite=getitemnumber(currentrow, "visite_id")
			li_riga=dw_2.find("visite_id="+string(ll_id_visite), 1, dw_2.rowcount())
			dw_2.scrolltorow(li_riga)
		
		end if
	end if
end if
end event

event clicked;call super::clicked;if row>0 then
	trigger event rowfocuschanged(row)
end if
end event

type cb_localita from commandbutton within w_agenda
integer x = 1083
integer y = 2284
integer width = 585
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Elenco per Località"
end type

event clicked;open(w_el_per_localita)
end event

type mc_1 from monthcalendar within w_agenda
integer x = 1751
integer y = 1952
integer width = 782
integer height = 524
integer taborder = 90
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long titletextcolor = 134217742
long trailingtextcolor = 134217745
long monthbackcolor = 1073741824
long titlebackcolor = 16711680
integer maxselectcount = 31
integer scrollrate = 1
boolean border = true
boolean autosize = true
end type

event doubleclicked;integer li_return

Date seldate

 

li_return = mc_1.GetSelectedDate(seldate)

//messagebox("W", string(seldate))
dw_3.retrieve(seldate)
end event

type st_1 from statictext within w_agenda
integer x = 50
integer y = 1968
integer width = 1499
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "F2 sulle righe di Visite per aprire il documento collegato."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_agenda
integer x = 3305
integer y = 1964
integer width = 549
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa visite"
end type

event clicked;dw_2.print(true, true)
end event

type cb_2 from commandbutton within w_agenda
integer x = 2830
integer y = 1964
integer width = 402
integer height = 112
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva in.."
end type

event clicked;dw_2.saveas()
end event

