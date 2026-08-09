forward
global type w_scadenza_gd from w_semplice_gd
end type
type dw_2 from udw_000 within w_scadenza_gd
end type
type cb_crea_distinta from commandbutton within w_scadenza_gd
end type
type dw_3 from udw_001 within w_scadenza_gd
end type
type r_1 from rectangle within w_scadenza_gd
end type
end forward

global type w_scadenza_gd from w_semplice_gd
integer x = 1056
integer y = 484
integer width = 4443
integer height = 2570
boolean maxbox = false
boolean resizable = false
dw_2 dw_2
cb_crea_distinta cb_crea_distinta
dw_3 dw_3
r_1 r_1
end type
global w_scadenza_gd w_scadenza_gd

forward prototypes
public subroutine wf_ricerca ()
end prototypes

public subroutine wf_ricerca ();string ls_filtro, ls_pagato, ls_conto, ls_data, ls_tipo_reg,ls_vedi
date ld_da_data, ld_a_data
integer li_pos

ld_da_data=dw_2.getitemdate(1, "da_data")
if isnull(ld_da_data) then ld_da_data=date("1900/01/01")
ls_data=string(ld_da_data)
ls_filtro="scad_data>= date('"+ls_data+"')"

ld_a_data=dw_2.getitemdate(1, "a_data")
if isnull(ld_a_data) then ld_a_data=date("01-01-2100")
ls_data=string(ld_a_data)
ls_filtro+=" and scad_data<= date('"+ls_data+"')"
//
ls_pagato=dw_2.getitemstring(1, "pagato")
if ls_pagato="S" then
	ls_filtro+=" and scad_pagato='N'"
end if

ls_conto=dw_2.getitemstring(1, "conto")
if ls_conto>"" then
	ls_filtro+=" and conto_codice='"+ls_conto+"'"
end if
ls_tipo_reg=dw_2.getitemstring(1, "tipo_reg")
if ls_tipo_reg>"" then
	ls_filtro+=" and registro_reg_tipo='"+ls_tipo_reg+"'"
end if

ls_vedi= dw_2.getitemstring(1, "vedi") 
	
if ls_vedi="T" then
	li_pos=pos(ls_filtro, "and isnull(distinta_banca_numero)")
	if li_pos>0 then
		ls_filtro=left(ls_filtro, li_pos - 1)+mid(ls_filtro, li_pos+33)
	end if
else
	ls_filtro+=" and isnull(distinta_banca_numero) "
end if




dw_1.setfilter(ls_filtro)
dw_1.filter()

end subroutine

on w_scadenza_gd.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_crea_distinta=create cb_crea_distinta
this.dw_3=create dw_3
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_crea_distinta
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.r_1
end on

on w_scadenza_gd.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_crea_distinta)
destroy(this.dw_3)
destroy(this.r_1)
end on

event open;call super::open;long ll_id_ese, ll_max_numero, ll_id_banca_azienda

dw_2.insertrow(1)
datawindowchild dwc_sog, dwc_tipo_reg

integer rtncode

rtncode = dw_2.GetChild('conto', dwc_sog)


IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")


rtncode = dw_2.GetChild('tipo_reg', dwc_tipo_reg)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_sog.SetTransObject(SQLCA)
dwc_tipo_reg.SetTransObject(SQLCA)

// Populate with values for eastern states

dwc_sog.Retrieve()
dwc_tipo_reg.Retrieve()

wf_ricerca()
// Set transaction object for main DW and retrieve

dw_3.settransobject(sqlca)
dw_3.insertrow(1)
select ese_id
into :ll_id_ese
from dba.esercizio
where ese_data_inizio<= today()
and  ese_data_fine>= today()
;
dw_3.setitem(1, "id_esercizio", ll_id_ese)
dw_3.setitem(1, "data", today())

select max(numero)
into :ll_max_numero
from dba.distinta_banca;
if isnull(ll_max_numero) then ll_max_numero=0
ll_max_numero++
dw_3.setitem(1, "numero",ll_max_numero)
select  id_banca_azienda
into :ll_id_banca_azienda
from dba.az_banca
where preferita='S'
;
if ll_id_banca_azienda>0 then
	dw_3.setitem(1, "id_banca_ditta",ll_id_banca_azienda)
end if

post wf_ricerca()


end event

event resize;//
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_scadenza_gd
integer x = 4085
integer y = 2298
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_scadenza_gd
boolean visible = false
end type

type cb_primo from w_semplice_gd`cb_primo within w_scadenza_gd
integer x = 51
integer y = 1194
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_scadenza_gd
integer x = 464
integer y = 1194
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_scadenza_gd
integer x = 208
integer y = 1194
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_scadenza_gd
integer x = 336
integer y = 1194
end type

type dw_1 from w_semplice_gd`dw_1 within w_scadenza_gd
integer x = 22
integer y = 29
integer width = 4345
integer height = 1456
string dataobject = "d_scadenza_ges_ff"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_scadenza_gd
integer x = 33
integer y = 2298
end type

type cb_salva from w_semplice_gd`cb_salva within w_scadenza_gd
integer x = 315
integer y = 2298
end type

event cb_salva::clicked;call super::clicked;//dw_2.postevent(itemchanged!)
end event

type cb_cancella from w_semplice_gd`cb_cancella within w_scadenza_gd
integer x = 603
integer y = 2298
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_scadenza_gd
integer x = 3485
integer y = 2298
end type

type cb_ok from w_semplice_gd`cb_ok within w_scadenza_gd
integer x = 3781
integer y = 2298
end type

type dw_2 from udw_000 within w_scadenza_gd
integer x = 29
integer y = 1504
integer width = 1503
integer height = 755
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "Ricerca Per"
string dataobject = "d_cerca_scadenza_sw"
boolean border = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;

	post wf_ricerca()



end event

type cb_crea_distinta from commandbutton within w_scadenza_gd
integer x = 2264
integer y = 1642
integer width = 453
integer height = 90
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea Righe Distinta"
end type

event clicked;//giro sulle righe prendo le scelte , creo la distinta (chiedo data, banca presentazione)
//inserisco le righe una ad una 
integer i, li_test
long ll_id_scadenza, ll_id_dis_banca, ll_riga_inserita, ll_test


if dw_3.trigger event ue_update()=1 then
	

	datastore ds_riga_banca
	
	ds_riga_banca=create datastore
	ds_riga_banca.dataobject="d_riga_dis_banca"
	ds_riga_banca.settransobject(sqlca)
	
	
	ll_id_dis_banca=dw_3.getitemnumber(1, "id_dist_banca")
	for i = 1 to dw_1.rowcount()
		li_test=dw_1.getitemnumber(i, "c_scegli")
		if li_test=1 then
			ll_id_scadenza=dw_1.getitemnumber(i, "scadenza_id_scadenza")
			ll_test=f_scadenza_in_dis_banca(ll_id_scadenza) //funzione che rimanda l'id_distinta dell'eventuale distinta legata alla scadenza
			if ll_test = 0 or isnull(ll_test) then
				ll_riga_inserita=ds_riga_banca.insertrow(0)
				ds_riga_banca.setitem(ll_riga_inserita, "riga_dis_banca_id_distinta_banca", ll_id_dis_banca)
				ds_riga_banca.setitem(ll_riga_inserita, "riga_dis_banca_id_scadenza", ll_id_scadenza)
				ds_riga_banca.setitem(ll_riga_inserita, "riga_dis_banca_num_riga", ll_riga_inserita )
				
				if ds_riga_banca.update()= 1 then
					commit;
				else
					rollback;
					messagebox("Attenzione!", "Errore salvataggio "+string(i)+" NON riuscito!")
				end if
			else
				messagebox("Attenzione!", "Errore salvataggio "+string(i)+" NON riuscito! La scadenza "+string(ll_id_scadenza) +" è già in un'altra distinta! (id_dist: "+string(ll_test))
			
			end if
		end if
		
	next
	destroy ds_riga_banca
else
	messagebox("Attenzione!", "Salvataggio Distinta non riuscito!")
end if
end event

type dw_3 from udw_001 within w_scadenza_gd
integer x = 2732
integer y = 1517
integer width = 1609
integer height = 707
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "Distinta Banca"
string dataobject = "d_distinta_banca"
end type

type r_1 from rectangle within w_scadenza_gd
integer linethickness = 3
long fillcolor = 8421504
integer x = 2245
integer y = 1498
integer width = 2121
integer height = 752
end type

type cb_stampa1 from commandbutton within w_scadenza_gd
integer x = 2528
integer y = 1160
integer width = 530
integer height = 152
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;ulong li_job

li_job = PrintOpen("Scadenze", true)
printdatawindow(li_job, dw_1) 
printclose(li_job)

end event

