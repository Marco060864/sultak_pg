forward
global type w_genera_listino_cx from w_semplice_cx
end type
type dw_2 from udw_001 within w_genera_listino_cx
end type
type cb_procedi from commandbutton within w_genera_listino_cx
end type
type cb_azione from commandbutton within w_genera_listino_cx
end type
type dw_3 from udw_000 within w_genera_listino_cx
end type
type cb_1 from commandbutton within w_genera_listino_cx
end type
end forward

global type w_genera_listino_cx from w_semplice_cx
integer width = 3209
integer height = 2104
dw_2 dw_2
cb_procedi cb_procedi
cb_azione cb_azione
dw_3 dw_3
cb_1 cb_1
end type
global w_genera_listino_cx w_genera_listino_cx

on w_genera_listino_cx.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_procedi=create cb_procedi
this.cb_azione=create cb_azione
this.dw_3=create dw_3
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_procedi
this.Control[iCurrent+3]=this.cb_azione
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_1
end on

on w_genera_listino_cx.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_procedi)
destroy(this.cb_azione)
destroy(this.dw_3)
destroy(this.cb_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_2.insertrow(1)
end event

event resize;call super::resize;//dw_1.width=newwidth - 105
dw_1.height=newheight - 292 - 360
//dw_2.width=newwidth - 105

end event

type cb_stampa from w_semplice_cx`cb_stampa within w_genera_listino_cx
integer x = 914
integer y = 1892
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_genera_listino_cx
integer x = 1490
integer y = 1820
end type

type cb_primo from w_semplice_cx`cb_primo within w_genera_listino_cx
integer x = 928
integer y = 1828
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_genera_listino_cx
integer x = 1344
integer y = 1828
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_genera_listino_cx
integer x = 1257
integer y = 1828
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_genera_listino_cx
integer x = 1385
integer y = 1828
end type

type dw_1 from w_semplice_cx`dw_1 within w_genera_listino_cx
integer x = 27
integer y = 400
integer width = 3122
integer height = 1376
string dataobject = "d_prezzo_gd"
boolean vscrollbar = true
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_genera_listino_cx
integer x = 59
integer y = 1812
end type

type cb_salva from w_semplice_cx`cb_salva within w_genera_listino_cx
integer x = 343
integer y = 1812
end type

event cb_salva::clicked;long ll_righe, ll_id_art,ll_id_vali_dest, i, ll_test,ll_riga
decimal ldc_pr_pezzo, ldc_pr_peso


ll_righe=dw_1.rowcount()
if ll_righe>0 then
		ll_id_vali_dest=dw_2.getitemnumber(1, "validita_destinazione")
		
		for i= 1 to ll_righe
			ll_id_art=dw_1.getitemnumber(i, "art_id")
			ldc_pr_pezzo=dw_1.getitemdecimal(i, "pr_pezzo")
			ldc_pr_peso=dw_1.getitemdecimal(i, "pr_peso")
			ll_test=f_salva_prezzo(ll_id_vali_dest, ll_id_art, ldc_pr_pezzo,'N')
			if ll_test=0 then
				ll_riga=dw_3.insertrow(0)
				dw_3.setitem(ll_riga, 1, "Art. "+string(ll_id_art)+" prezzo al pezzo ("+string(ldc_pr_pezzo)+") non salvato!")
			end if
			ll_test=f_salva_prezzo(ll_id_vali_dest, ll_id_art, ldc_pr_peso,'P')
			if ll_test=0 then
				ll_riga=dw_3.insertrow(0)
				dw_3.setitem(ll_riga, 1, "Art. "+string(ll_id_art)+" prezzo a peso ("+string(ldc_pr_peso)+") non salvato!")
			end if
		next
	end if
end event

type cb_cancella from w_semplice_cx`cb_cancella within w_genera_listino_cx
integer x = 631
integer y = 1812
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_genera_listino_cx
integer x = 1765
integer y = 1816
end type

type cb_ok from w_semplice_cx`cb_ok within w_genera_listino_cx
integer x = 2053
integer y = 1816
end type

type dw_2 from udw_001 within w_genera_listino_cx
integer x = 27
integer y = 24
integer width = 2752
integer height = 352
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_validita_ext"
end type

type cb_procedi from commandbutton within w_genera_listino_cx
integer x = 2807
integer y = 28
integer width = 366
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "VAI"
end type

event clicked;long ll_id_vali_origine, ll_righe,ll_id_vali_dest
integer i

ll_id_vali_origine=dw_2.getitemnumber(1, "validita_origine")
if ll_id_vali_origine>0 then
	ll_righe=dw_1.retrieve(ll_id_vali_origine)
	
end if
end event

type cb_azione from commandbutton within w_genera_listino_cx
integer x = 2807
integer y = 148
integer width = 366
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Applica Azione"
end type

event clicked;string ls_test
decimal ldc_percentuale, ldc_importo, ldc_prezzo_attuale
integer i
long ll_blocco, ll_art_id,ll_vali_id

dw_2.accepttext()

ldc_percentuale=dw_2.getitemdecimal(1, "percentuale")
ldc_importo=dw_2.getitemdecimal(1, "importo")
ls_test=dw_2.getitemstring(1, "azione")
ll_vali_id=dw_2.getitemnumber(1, "validita_destinazione")
choose case ls_test
	case 'N'  //nessuna azione
		
	case 'A' //aumento
		for i = 1 to dw_1.rowcount()
//			ll_blocco=dw_1.getitemnumber(i, "ins_manuale")
//			if ll_blocco=1 then continue
			ll_art_id=dw_1.getitemnumber(i, "art_id")
			select ins_manuale
			into :ll_blocco
			from dba.prezzo
			where vali_id=:ll_vali_id and art_id=:ll_art_id;
			if ll_blocco= 1 then continue
			ldc_prezzo_attuale=dw_1.getitemdecimal(i, "pr_pezzo")
			if ldc_percentuale>0 then
				dw_1.setitem(i, "pr_pezzo", ldc_prezzo_attuale + ldc_prezzo_attuale*ldc_percentuale/100)
			end if
			if ldc_importo>0 then
				dw_1.setitem(i, "pr_pezzo", ldc_prezzo_attuale + ldc_importo)
			end if
		next
	case 'S' //sconto
		for i = 1 to dw_1.rowcount()
//			ll_blocco=dw_1.getitemnumber(i, "ins_manuale")
//			if ll_blocco=1 then continue
			ldc_prezzo_attuale=dw_1.getitemdecimal(i, "pr_pezzo")
			if ldc_percentuale>0 then
				dw_1.setitem(i, "pr_pezzo", ldc_prezzo_attuale - ldc_prezzo_attuale*ldc_percentuale/100)
			end if
			if ldc_importo>0 then
				dw_1.setitem(i, "pr_pezzo", ldc_prezzo_attuale - ldc_importo)
			end if
		next
end choose
end event

type dw_3 from udw_000 within w_genera_listino_cx
boolean visible = false
integer x = 3017
integer y = 352
integer width = 151
integer height = 136
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_log_ext"
end type

type cb_1 from commandbutton within w_genera_listino_cx
integer x = 2807
integer y = 268
integer width = 366
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa Errori"
end type

event clicked;
dw_3.print(true, true)
end event

