forward
global type w_partita_oro_gd from w_pop
end type
type dw_2 from udw_001 within w_partita_oro_gd
end type
type cb_annulla from uo_commandbutton within w_partita_oro_gd
end type
type cb_ok from uo_commandbutton within w_partita_oro_gd
end type
type dw_3 from udw_000 within w_partita_oro_gd
end type
end forward

global type w_partita_oro_gd from w_pop
integer width = 3950
integer height = 1660
boolean resizable = false
windowtype windowtype = response!
dw_2 dw_2
cb_annulla cb_annulla
cb_ok cb_ok
dw_3 dw_3
end type
global w_partita_oro_gd w_partita_oro_gd

type variables
s_partita_oro s_par
end variables

forward prototypes
public subroutine wf_scarica ()
public subroutine wf_aggiorna_fino_da_scaricare (decimal adc_da_scaricare)
end prototypes

public subroutine wf_scarica ();integer i
long ll_righe
ll_righe=dw_2.rowcount()

do
	if i=ll_righe then exit
	i++
	dw_2.trigger event clicked(5, 5, i, dw_2.object.datawindow)
loop while  s_par.dc_finocalo>0 
if  s_par.dc_finocalo>0 then
	 messagebox("Attenzione!", "Carico insufficiente!")
	//if messagebox("Attenzione!", "Carico insufficiente! Vuoi scaricare lo stesso?", stopsign!, yesno!)=1 then
		
	//end if
	
end if

end subroutine

public subroutine wf_aggiorna_fino_da_scaricare (decimal adc_da_scaricare);integer i

for i =1 to dw_2.rowcount()
	if dw_2.isselected(i) then
		dw_2.trigger event clicked(5, 5, i, dw_2.object.datawindow)
	end if
next
s_par.dc_finocalo=adc_da_scaricare*s_par.dc_coef_calo/1000

end subroutine

event open;call super::open;string ls_filtro, ls_chiudi_a_gr, ls_flag, ls_partite_a_legato
long ll_riga_trovata, ll_id_riga_apertura, ll_riga_inserita
long ll_id_aper_scarico[]
long ll_righe
integer i, a, b, li_pos
decimal ldc_da_reintegrare[], ldc_tot_scarico, ldc_chiudi_a_gr
s_par=message.powerobjectparm

dw_3.insertrow(1)
dw_3.SETFOCUS()

//select partite_a_legato into :ls_flag from dba.val_base;
//if ls_flag="S" then
//	dw_2.dataobject="d_partita_oro_a_legato_gd"
//	dw_3.setitem(1, "da_scaricare", s_par.dc_finocalo)
//else
	dw_3.setitem(1, "da_scaricare",s_par.dc_legato)   //20231123 metto direttamnete il legato che ora lo passo s_par.dc_finocalo/s_par.dc_coef_calo*1000)
//end if
//20231031 qui si insersce dopo aver controllato il flag su valori base la dwo="d_partita_ORO_A_LEGATO_GD"

dw_2.settransobject(sqlca)
ll_righe=dw_2.retrieve(s_par.s_tipo_partita, s_par.data_fine, s_par.l_conto, s_par.l_metallo, s_par.data_inizio_saldi, s_par.l_tit)

// recupero eventuali partite chiuse precedentemente da questa riga
ll_righe=dw_1.retrieve(s_par.l_id_riga_scarico)
//ls_filtro=" finoecalo_apertura > if(isnull(tot_scarico), 0, tot_scarico) "
//mm 030112 filtro migliore (mi tiene aperte le partite per 0.003!!!

select par_chiusa_residuo
into :ldc_chiudi_a_gr
from dba.val_base
;
if isnull(ldc_chiudi_a_gr) then ldc_chiudi_a_gr=0.1
ls_chiudi_a_gr=string(ldc_chiudi_a_gr)
li_pos=pos(ls_chiudi_a_gr, ",")
if li_pos>0 then
	ls_chiudi_a_gr=left(ls_chiudi_a_gr, li_pos - 1)+"."+right(ls_chiudi_a_gr, len(ls_chiudi_a_gr) - li_pos)
end if
ls_filtro="c_residuo > "+ls_chiudi_a_gr
for i =1 to ll_righe
	ll_id_aper_scarico[i]=dw_1.getitemnumber(i, "id_apertura")
	ls_filtro+= " or  rdoc_id = "+string(ll_id_aper_scarico[i]) 
	ldc_da_reintegrare[i]=dw_1.getitemdecimal(i, "scarico")
	dw_1.setitem(i, "scarico", 0)
next
dw_2.setfilter(ls_filtro)
dw_2.filter()
ll_righe=dw_2.rowcount()
////20231031 qui gestione partita a legato: il coef_calo è sempre =1000  (
//if ls_flag="S" then s_par.dc_coef_calo=1000
for b = 1 to ll_righe
	dw_2.setitem(b, "c_coef_calo", s_par.dc_coef_calo)
next

for a= 1 to i - 1
	ll_riga_trovata=dw_2.find("rdoc_id="+string(ll_id_aper_scarico[a]), 1 , dw_2.rowcount())
	if ll_riga_trovata>0 then
		ldc_tot_scarico= dw_2.getitemdecimal(ll_riga_trovata, "tot_scarico")
		ldc_tot_scarico -= ldc_da_reintegrare[a]
		dw_2.setitem(ll_riga_trovata, "tot_scarico", ldc_tot_scarico)
	else
		messagebox("ODDIO!", "MHA!")
	end if
next 
post wf_scarica()
end event

on w_partita_oro_gd.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_3
end on

on w_partita_oro_gd.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_3)
end on

type dw_1 from w_pop`dw_1 within w_partita_oro_gd
integer x = 2738
integer y = 1108
integer width = 1157
integer height = 448
string dataobject = "d_partita_scarico_ra_gd"
boolean vscrollbar = true
end type

type dw_2 from udw_001 within w_partita_oro_gd
integer x = 41
integer y = 20
integer width = 3849
integer height = 1072
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_partita_oro_gd"
boolean controlmenu = true
boolean minbox = true
boolean hscrollbar = true
end type

event clicked;call super::clicked;decimal ldc_fino_residuo
long ll_id_riga_apertura, ll_riga_inserita, ll_riga_trovata
integer li_max_num

if row>0 then
	SelectRow(row, not(isselected(row)))
	 ll_id_riga_apertura=dw_2.getitemnumber(row, "rdoc_id")
	if isselected(row) then
		//se il fino non è stato scaricato
		if s_par.dc_finocalo>0 then
			 ldc_fino_residuo=dw_2.getitemdecimal(row, "c_residuo")	
			 //controllo se esiste già lo scarico
			ll_riga_trovata= dw_1.find("id_apertura= "+string(ll_id_riga_apertura) +" and id_scarico = "+string(s_par.l_id_riga_scarico), 1, dw_1.rowcount())
			if ll_riga_trovata>0 then
				ll_riga_inserita= ll_riga_trovata
			else
				//altrimenti inserisco la riga di scarico
				ll_riga_inserita=dw_1.insertrow(0)
			end if
			dw_1.setitem(ll_riga_inserita, "id_apertura", ll_id_riga_apertura)
			li_max_num=dw_1.getitemnumber(ll_riga_inserita, "c_max_numero")
			if isnull(li_max_num) then li_max_num=0
			dw_1.setitem(ll_riga_inserita, "numero", li_max_num + 1)
			dw_1.setitem(ll_riga_inserita, "id_scarico", s_par.l_id_riga_scarico)
			 //se la partita è sufficiente per il fino da scaricare
			 if ldc_fino_residuo>= s_par.dc_finocalo then
				dw_2.setitem(row, "C_scarico", s_par.dc_finocalo)	
				dw_1.setitem(ll_riga_inserita, "scarico", s_par.dc_finocalo)
				s_par.dc_finocalo=0
			else //la partita da sè non basta, occorre ricorrere ad un'altra (se c'è) 
				//scarico la partita fino a chiuderla 
				dw_2.setitem(row, "C_scarico", ldc_fino_residuo)	
				dw_1.setitem(ll_riga_inserita, "scarico", ldc_fino_residuo)
				//decremento il fino dello scaricato
				s_par.dc_finocalo -= ldc_fino_residuo
			end if
		else //il fino è già stato scaricato non permetto ulteriore selezione
			SelectRow(row, false)
		end if
	else //deseleziona riga, annulla scelta, devo reintegrare fino 
		//e rimettere a 0 lo scarico e cancellare lo carico dalla dw_scarico (dw_1)
		s_par.dc_finocalo += dw_2.getitemdecimal(row, "c_scarico")
		dw_2.setitem(row, "c_scarico", 0)
		ll_riga_trovata=dw_1.find("id_apertura= "+string(ll_id_riga_apertura), 1, dw_1.rowcount())
		if ll_riga_trovata>0 then
			dw_1.deleterow(ll_riga_trovata)
		else
			messagebox("ERRORE", "Riga scarico non trovata!")
		end if
	end if
end if
	

end event

type cb_annulla from uo_commandbutton within w_partita_oro_gd
string tag = "Chiude senza salvare nulla."
integer x = 1655
integer y = 1140
integer width = 261
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
string text = "Annulla"
end type

event clicked;closewithreturn(parent, 0)
end event

type cb_ok from uo_commandbutton within w_partita_oro_gd
string tag = "Chiude salvando le modifiche."
integer x = 2080
integer y = 1140
integer width = 261
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
string text = "Ok"
end type

event clicked;decimal ldc_somma_scarico, ldc_da_scaricare, ldc_legato_scaricato

if dw_2.rowcount()>0 and dw_2.GetSelectedRow(0)>0 then
	//if messagebox("Salvare?", "Salvare i dati prima di chiudere?", stopsign!, yesno!)=1 then
	
		dw_1.trigger event ue_update()
	//end if
	ldc_somma_scarico=dw_2.getitemdecimal(1, "c_somma_scarico")
	ldc_legato_scaricato=dw_2.getitemdecimal(1, "c_scarico_legato")
	ldc_da_scaricare=dw_3.getitemdecimal(1, "da_scaricare")
	if abs( ldc_da_scaricare -  ldc_legato_scaricato)  < 0.2 then
		ldc_legato_scaricato=ldc_da_scaricare
	else
		if messagebox("Attenzione!", "Scaricare la quantità richiesta anche se il carico non è sufficiente?", stopsign!, yesno!)=1 then
			ldc_legato_scaricato=ldc_da_scaricare
		end if
	end if
end if
//ldc_somma_scarico= ldc_somma_scarico / s_par.dc_coef_calo *1000

closewithreturn(parent, ldc_legato_scaricato )
end event

type dw_3 from udw_000 within w_partita_oro_gd
integer x = 37
integer y = 1116
integer width = 704
integer height = 188
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_da_scaricare_partita"
end type

event itemchanged;call super::itemchanged;post wf_aggiorna_fino_da_scaricare(dec(data))
post wf_scarica()
end event

