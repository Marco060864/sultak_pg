forward
global type w_art_gd from w_semplice_gd
end type
type cb_foto from commandbutton within w_art_gd
end type
end forward

global type w_art_gd from w_semplice_gd
integer width = 4846
integer height = 1628
cb_foto cb_foto
end type
global w_art_gd w_art_gd

on w_art_gd.create
int iCurrent
call super::create
this.cb_foto=create cb_foto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_foto
end on

on w_art_gd.destroy
call super::destroy
destroy(this.cb_foto)
end on

event resize;call super::resize;cb_foto.y=newheight - 224
cb_foto.x=cb_ricerca.x - 285
end event

event open;string ls_tipo_azienda

select tipo_azienda
into :ls_tipo_azienda
from dba.val_base
;
if ls_tipo_azienda='N' then
	dw_1.dataobject="d_art_negozio_gd"
	
	
end if
dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_art_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_art_gd
integer x = 2112
integer y = 1240
end type

type cb_primo from w_semplice_gd`cb_primo within w_art_gd
integer x = 1234
integer y = 1256
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_art_gd
integer x = 1650
integer y = 1256
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_art_gd
integer x = 1394
integer y = 1256
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_art_gd
integer x = 1522
integer y = 1256
end type

type dw_1 from w_semplice_gd`dw_1 within w_art_gd
integer x = 23
integer y = 28
integer width = 4754
integer height = 1172
string dataobject = "d_art_gd"
boolean hscrollbar = true
end type

event dw_1::ue_post_insert;call super::ue_post_insert;long ll_id_codifica

select cat_codifica_articolo
into :ll_id_codifica
from dba.val_base
;
setitem(al_riga, "art_id_codifica", ll_id_codifica)
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_art_gd
integer x = 55
integer y = 1240
end type

type cb_salva from w_semplice_gd`cb_salva within w_art_gd
integer x = 338
integer y = 1240
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_art_gd
integer x = 626
integer y = 1240
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_art_gd
integer x = 2775
integer y = 1232
end type

type cb_ok from w_semplice_gd`cb_ok within w_art_gd
integer x = 3067
integer y = 1232
end type

type cb_foto from commandbutton within w_art_gd
string tag = "Memorizza il nome dell~'immagine associata all~'articolo usando il codice dello stesso."
integer x = 2427
integer y = 1240
integer width = 270
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mem. Foto"
end type

event clicked;long i, ll_righe, ll_id_art, ll_riga_trovata, ll_righe_lista
string ls_cod_art, ls_st_in_catalogo
datastore ds_foto, ds_lista_figlio
boolean lb_aggiorna

ds_lista_figlio=create datastore
ds_lista_figlio.dataobject="d_lista_art_figlio"
ds_lista_figlio.settransobject(sqlca)
ll_righe_lista=ds_lista_figlio.retrieve(0)

if ll_righe_lista <=0 then
	insert into dba.lista_art (lista_art_id, codice) 
	values (0, 'OBBLIGATORIA')
	;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		//Messagebox("Errore!", sqlca.sqlerrtext)
	end if
end if


ds_foto=create datastore
ds_foto.dataobject="d_art_foto_gd"
ds_foto.settransobject(sqlca)
ll_righe=ds_foto.retrieve()
if messagebox("Attenzione!", "Aggiornare i nomi immagine esistenti?", stopsign!, yesno!)=1 then
	lb_aggiorna=true
else
	lb_aggiorna=false
end if

for i = 1 to dw_1.rowcount()
	ll_id_art=dw_1.getitemnumber(i, "art_id")
	ls_st_in_catalogo=dw_1.getitemstring(i, "st_in_catalogo")
	ll_riga_trovata=ds_lista_figlio.find("art_id="+string(ll_id_art)+" and lista_art_id=0", 1, ll_righe_lista)
	if ll_riga_trovata>0 then
		if ls_st_in_catalogo<>'S' then
			ds_lista_figlio.deleterow(ll_riga_trovata)
		end if
	else
		ds_lista_figlio.insertrow(1)
		ds_lista_figlio.setitem(1, "lista_art_id", 0)
		ds_lista_figlio.setitem(1, "art_id", ll_id_art)
		
	end if
	ls_cod_art=dw_1.getitemstring(i, "art_codice")
	ll_riga_trovata=ds_foto.find("art_id="+string(ll_id_art), 1, ll_righe)
	if ll_riga_trovata>0 then
		if lb_aggiorna then ds_foto.setitem(ll_riga_trovata, "art_foto", ls_cod_art+".jpg")
	else
		ll_riga_trovata=ds_foto.insertrow(0)
		ds_foto.setitem(ll_riga_trovata, "art_foto", ls_cod_art+".jpg")
		ds_foto.setitem(ll_riga_trovata, "conto_id", 0)
		ds_foto.setitem(ll_riga_trovata, "art_id", ll_id_art)
		ds_foto.setitem(ll_riga_trovata, "priorita", 1)
	end if
	
	
next
if ds_lista_figlio.update()<>1 then
	messagebox("Errore Lista!", "Lista non salvata")
	rollback;
else
	commit;
	//messagebox("OK!", "Salvataggio riuscito!")
end if
destroy(ds_lista_figlio)


if ds_foto.update()<>1 then
	messagebox("Errore nome foto!", "nome foto non salvato")
	rollback;
else
	commit;
	messagebox("OK!", "Salvataggio riuscito!")
end if
destroy(ds_foto)
end event

