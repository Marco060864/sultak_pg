forward
global type w_barcode_st from w_stampa
end type
end forward

global type w_barcode_st from w_stampa
end type
global w_barcode_st w_barcode_st

on w_barcode_st.create
call super::create
end on

on w_barcode_st.destroy
call super::destroy
end on

event open;call super::open;s_sel_stampa s_stampa
integer i, li_test
string ls_barcode, ls_check, ls_dw_oggetto, ls_tipo_stampa, ls_nome_azienda
long ll_riga_inserita, ll_id_art, ll_id_iva
decimal ldc_prezzo, ldc_iva
string ls_art

s_stampa=message.powerobjectparm
ls_dw_oggetto=s_stampa.s_dw.dataobject
if pos(ls_dw_oggetto, "art") >0 then
	if s_stampa.s_cl_fo="A4" then
		dw_1.dataobject="d_label_art_st"
		cb_preview.enabled=false
	else
		dw_1.dataobject="d_art_barcode_st"
	end if
	select rag_soc2
	into :ls_nome_azienda
	from dba.azienda
	;
	for i = 1 to s_stampa.s_dw.rowcount()
		li_test=s_stampa.s_dw.getitemnumber(i, "scelto")
		if li_test=1 then
			ls_barcode=s_stampa.s_dw.getitemstring(i, "barcode")
			if len(ls_barcode)=13 then
				ls_barcode=f_crea_ean13(ls_barcode)
				ll_riga_inserita=dw_1.insertrow(0)
				dw_1.setitem(ll_riga_inserita,"barcode", ls_barcode)
				if ls_nome_azienda>" " then
					dw_1.setitem(ll_riga_inserita,"nome_azienda", ls_nome_azienda)
					//recupera prezzo
					ll_id_art=s_stampa.s_dw.getitemnumber(i, "art_id")
					select pr_pezzo
					into :ldc_prezzo
					from prezzo p, validita v, listino l
					where l.listino_id=v.listino_id
					and v.vali_id=p.vali_id
					and l.list_tipo='V'
					and l.base='S'
					and v.vali_da_data<=today()
					and v.vali_a_data>=today()
					and p.art_id=:ll_id_art
					;
					dw_1.setitem(ll_riga_inserita,"prezzo", ldc_prezzo)
					//recupera iva e setta campo IVA in DW di stampa
					select iva_id
					into :ll_id_iva
					from dba.art
					where art_id=:ll_id_art;
					if ll_id_iva>0 then
						select iva_aliquota
						into :ldc_iva
						from dba.iva
						where iva_id=:ll_id_iva;
					else
						select iva_id
						into :ll_id_iva
						from dba.val_base;
						if isnull(ll_id_iva) then
							messagebox("Attenzioen!", "In valori di base deve essere indicata l'aliquota iva di base")
							return
						else
							select iva_aliquota
							into :ldc_iva
							from dba.iva
							where iva_id=:ll_id_iva;
						end if
					end if
					dw_1.setitem(ll_riga_inserita,"iva", ldc_iva)
				
					ls_art=s_stampa.s_dw.getitemstring(i, "art_codice")
					dw_1.setitem(ll_riga_inserita,"cod_art", ls_art)
				end if
			end if
		end if
	next

else
	dw_1.dataobject="d_ana_barcode_st"
	dw_1.settransobject(sqlca)
		for i = 1 to s_stampa.s_dw.rowcount()
		li_test=s_stampa.s_dw.getitemnumber(i, "scelto")
		if li_test=1 then
			ls_barcode=s_stampa.s_dw.getitemstring(i, "barcode")
			if len(ls_barcode)=13 then
				ls_barcode=f_crea_ean13(ls_barcode)
				ll_riga_inserita=dw_1.insertrow(0)
				dw_1.setitem(ll_riga_inserita,"barcode", ls_barcode)
			end if
		end if
	next
end if
	
end event

type pb_1 from w_stampa`pb_1 within w_barcode_st
end type

type cb_preview from w_stampa`cb_preview within w_barcode_st
end type

type dw_1 from w_stampa`dw_1 within w_barcode_st
string dataobject = "d_ean13_st"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_barcode_st
end type

type pb_stampa from w_stampa`pb_stampa within w_barcode_st
end type

type sle_pg from w_stampa`sle_pg within w_barcode_st
end type

type st_1 from w_stampa`st_1 within w_barcode_st
end type

type st_2 from w_stampa`st_2 within w_barcode_st
end type

type sle_copie from w_stampa`sle_copie within w_barcode_st
end type

type sle_zoom from w_stampa`sle_zoom within w_barcode_st
end type

type cb_7 from w_stampa`cb_7 within w_barcode_st
end type

type cb_6 from w_stampa`cb_6 within w_barcode_st
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_barcode_st
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_barcode_st
end type

type cb_esci from w_stampa`cb_esci within w_barcode_st
end type

