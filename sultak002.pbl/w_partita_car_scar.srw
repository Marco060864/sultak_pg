forward
global type w_partita_car_scar from w_semplice_cx
end type
type dw_2 from udw_001 within w_partita_car_scar
end type
end forward

global type w_partita_car_scar from w_semplice_cx
integer width = 3113
integer height = 1368
boolean maxbox = true
boolean resizable = true
dw_2 dw_2
end type
global w_partita_car_scar w_partita_car_scar

type variables
s_partita_oro s_par

end variables

event open;call super::open;string ls_filtro
long ll_riga_trovata, ll_id_riga_apertura, ll_riga_inserita
long ll_id_aper_scarico[]
long ll_righe
integer i, a
decimal ldc_da_reintegrare[], ldc_tot_scarico
s_par=message.powerobjectparm

dw_2.settransobject(sqlca)
dw_2.retrieve(s_par.s_tipo_partita, s_par.data_fine,   s_par.l_conto, s_par.l_metallo, s_par.data_inizio_saldi)
// recupero eventuali partite chiuse precedentemente da questa riga
//ll_righe=dw_1.retrieve(s_par.l_id_riga_scarico)
//ls_filtro=" finoecalo_apertura > if(isnull(tot_scarico), 0, tot_scarico) "
//for i =1 to ll_righe
//	ll_id_aper_scarico[i]=dw_1.getitemnumber(i, "id_apertura")
//	ls_filtro+= " or  rdoc_id = "+string(ll_id_aper_scarico[i]) 
//	ldc_da_reintegrare[i]=dw_1.getitemdecimal(i, "scarico")
//	dw_1.setitem(i, "scarico", 0)
//next
//dw_2.setfilter(ls_filtro)
//dw_2.filter()

//for a= 1 to i - 1
//	ll_riga_trovata=dw_2.find("rdoc_id="+string(ll_id_aper_scarico[a]), 1 , dw_2.rowcount())
//	if ll_riga_trovata>0 then
//		ldc_tot_scarico= dw_2.getitemdecimal(ll_riga_trovata, "tot_scarico")
//		ldc_tot_scarico -= ldc_da_reintegrare[a]
//		dw_2.setitem(ll_riga_trovata, "tot_scarico", ldc_tot_scarico)
//	else
//		messagebox("ODDIO!", "MHA!")
//	end if
//next 




//ll_riga_trovata=dw_1.find("rdoc_id_scarico=0", 1, dw_1.rowcount())
//if ll_riga_trovata>0 then
//	dw_1.setitem(ll_riga_trovata, "rdoc_finoecalo_scarico", s_par.dc_finocalo)
//lb_found = FALSE
//ll_breakrow = 0
//
//DO WHILE NOT (lb_found)
//
//    ll_breakrow = dw_1.FindGroupChange(ll_breakrow, 1)
//
//    // If no breaks are found, exit.
//
//    IF ll_breakrow <= 0 THEN EXIT
//	 li_num=DW_1.getitemnumber(ll_breakrow, "c_max_numero") + 1
//	 if isnull(li_num) then li_num=1
//	 ldc_fino_residuo=dw_1.getitemdecimal(ll_breakrow, "c_residuo")
//	 ll_riga_inserita=dw_1.insertrow(0)
//	 dw_1.setitem(ll_riga_inserita, "numero", li_num)
//	 ll_id_riga_apertura=dw_1.getitemnumber(ll_breakrow, "partita_oro_id_apertura")
//	 if ldc_fino_residuo>= s_par.dc_finocalo then
//		dw_1.setitem(ll_riga_inserita, "scarico", s_par.dc_finocalo)
//		dw_1.setitem(ll_riga_inserita, "finoecalo_riga_scarico", s_par.dc_finocalo)
//		dw_1.setitem(ll_riga_inserita, "id_apertura", ll_id_riga_apertura)
//		dw_1.setitem(ll_riga_inserita, "partita_oro_id_apertura", ll_id_riga_apertura)
//		dw_1.setitem(ll_riga_inserita, "id_scarico", s_par.l_id_riga_scarico)
////		dw_1.setitem(ll_riga_inserita, "chiusa", 'N')
//		dw_1.sort()
//		dw_1.groupcalc()
//		lb_found=true
//	else
//		dw_1.setitem(ll_riga_inserita, "scarico", ldc_fino_residuo )	
//		dw_1.setitem(ll_riga_inserita, "finoecalo_riga_scarico", ldc_fino_residuo)
//		dw_1.setitem(ll_riga_inserita, "id_apertura", ll_id_riga_apertura)
//		dw_1.setitem(ll_riga_inserita, "partita_oro_id_apertura", ll_id_riga_apertura)
//
//		dw_1.setitem(ll_riga_inserita, "id_scarico", s_par.l_id_riga_scarico)
//		//occorre chiudere la partita .....
//		//quindi segno l'id_apertura in un vettore, poi nel updateend, se tutto è andato bene
//		//faccio l'update opportuno
////		il_id_apertura[upperbound(il_id_apertura)+1]=
//		//decremento il fino del residuo
//		s_par.dc_finocalo -= ldc_fino_residuo
//		dw_1.sort()
//		dw_1.groupcalc()
//	end if
//    // Increment starting row to find next break
//
//    ll_breakrow = ll_breakrow + 2
//
//LOOP
//
//
//
//
//
//	
//	
//	
//
end event

on w_partita_car_scar.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_partita_car_scar.destroy
call super::destroy
destroy(this.dw_2)
end on

type cb_stampa from w_semplice_cx`cb_stampa within w_partita_car_scar
integer x = 878
integer y = 1104
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_partita_car_scar
integer x = 1454
integer y = 1032
end type

type cb_primo from w_semplice_cx`cb_primo within w_partita_car_scar
integer x = 891
integer y = 1040
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_partita_car_scar
integer x = 1307
integer y = 1040
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_partita_car_scar
integer x = 1221
integer y = 1040
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_partita_car_scar
integer x = 1349
integer y = 1040
end type

type dw_1 from w_semplice_cx`dw_1 within w_partita_car_scar
integer x = 1714
integer y = 36
integer width = 1307
integer height = 940
string dataobject = "d_partita_scar_new_ra_gd"
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_partita_car_scar
integer x = 23
integer y = 1024
end type

type cb_salva from w_semplice_cx`cb_salva within w_partita_car_scar
integer x = 306
integer y = 1024
end type

event cb_salva::clicked;call super::clicked;dw_2.trigger event ue_update()
end event

type cb_cancella from w_semplice_cx`cb_cancella within w_partita_car_scar
integer x = 594
integer y = 1024
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_partita_car_scar
integer x = 1728
integer y = 1028
end type

type cb_ok from w_semplice_cx`cb_ok within w_partita_car_scar
integer x = 2016
integer y = 1028
end type

type dw_2 from udw_001 within w_partita_car_scar
integer x = 18
integer y = 32
integer width = 1682
integer height = 940
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_car_partita_gd"
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_id_apertura

if currentrow>0 then
	ll_id_apertura=getitemnumber(currentrow, "rdoc_id")
	dw_1.retrieve(ll_id_apertura)
	
end if
end event

