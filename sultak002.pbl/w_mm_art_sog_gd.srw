forward
global type w_mm_art_sog_gd from w_semplice_gd
end type
type cb_rec_da_movimenti from commandbutton within w_mm_art_sog_gd
end type
end forward

global type w_mm_art_sog_gd from w_semplice_gd
integer width = 3602
cb_rec_da_movimenti cb_rec_da_movimenti
end type
global w_mm_art_sog_gd w_mm_art_sog_gd

on w_mm_art_sog_gd.create
int iCurrent
call super::create
this.cb_rec_da_movimenti=create cb_rec_da_movimenti
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_rec_da_movimenti
end on

on w_mm_art_sog_gd.destroy
call super::destroy
destroy(this.cb_rec_da_movimenti)
end on

event resize;call super::resize;cb_rec_da_movimenti.x=cb_ricerca.x - 550
cb_rec_da_movimenti.y=cb_ricerca.y
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_mm_art_sog_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_mm_art_sog_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_mm_art_sog_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_mm_art_sog_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_mm_art_sog_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_mm_art_sog_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_mm_art_sog_gd
integer x = 27
integer width = 3483
string dataobject = "d_mm_art_sog"
end type

event dw_1::itemchanged;call super::itemchanged;string ls_cod
long ll_id_art

if dwo.name="id_art" then
	ls_cod=getitemstring(row, "codice_art")
	if isnull(ls_cod) or ls_cod<=" " then
		ll_id_art=long (data)
		select art_codice
		into :ls_cod
		from dba.art
		where art_id= :ll_id_art
		;
		setitem(row, "codice_art", ls_cod)
	end if
end if
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_mm_art_sog_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_mm_art_sog_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_mm_art_sog_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_mm_art_sog_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_mm_art_sog_gd
end type

type cb_rec_da_movimenti from commandbutton within w_mm_art_sog_gd
integer x = 2400
integer y = 996
integer width = 530
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recupera da bolle"
end type

event clicked;datastore ds_rec_fo
date ldt_a_data, ldt_da_data
long i, ll_righe, ll_id_art, ll_id_conto,ll_riga_trovata,ll_riga_inserita
s_sel_stampa s_st
string ls_cod_art


open(w_sel_solo_date_ext, parent)
s_st=message.powerobjectparm
if isvalid(s_st) then
	if s_st.s_da_data>date("1900-01-01") and s_st.s_a_data> date("1900-01-01") then
		ds_rec_fo=create datastore
		ds_rec_fo.dataobject="d_ass_fo_art_gd"
		ds_rec_fo.settransobject(sqlca)
		ll_righe=ds_rec_fo.retrieve(s_st.s_da_data,s_st.s_a_data)
		for i= 1 to ll_righe
			ll_id_art=ds_rec_fo.getitemnumber(i, "art_id")
			ll_id_conto=ds_rec_fo.getitemnumber(i, "conto_id")	
			if ll_id_conto>0 and ll_id_art>0 then
				ll_riga_trovata=dw_1.find("id_sog ="+string(ll_id_conto)+" and id_art="+string(ll_id_art), 1, dw_1.rowcount())
				if ll_riga_trovata>0 then continue
				ll_riga_inserita=dw_1.trigger event ue_insert(0)
				dw_1.setitem(ll_riga_inserita, "id_sog", ll_id_conto)
				dw_1.setitem(ll_riga_inserita, "id_art", ll_id_art)
				select art_codice
				into :ls_cod_art
				from dba.art
				where art_id=:ll_id_art;
				dw_1.setitem(ll_riga_inserita, "codice_art", ls_cod_art)
			end if
		next
	else
		messagebox("Attenzione!", "Date non inserite")
	end if
end if
end event

