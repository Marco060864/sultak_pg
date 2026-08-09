forward
global type w_st_etichette from w_stampa
end type
type cb_1 from commandbutton within w_st_etichette
end type
end forward

global type w_st_etichette from w_stampa
cb_1 cb_1
end type
global w_st_etichette w_st_etichette

on w_st_etichette.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_st_etichette.destroy
call super::destroy
destroy(this.cb_1)
end on

type cb_preview from w_stampa`cb_preview within w_st_etichette
end type

type dw_1 from w_stampa`dw_1 within w_st_etichette
string dataobject = "d_label"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_etichette
end type

type pb_stampa from w_stampa`pb_stampa within w_st_etichette
end type

type sle_pg from w_stampa`sle_pg within w_st_etichette
end type

type st_1 from w_stampa`st_1 within w_st_etichette
end type

type st_2 from w_stampa`st_2 within w_st_etichette
end type

type sle_copie from w_stampa`sle_copie within w_st_etichette
end type

type sle_zoom from w_stampa`sle_zoom within w_st_etichette
end type

type cb_7 from w_stampa`cb_7 within w_st_etichette
end type

type cb_6 from w_stampa`cb_6 within w_st_etichette
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_etichette
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_etichette
end type

type cb_esci from w_stampa`cb_esci within w_st_etichette
end type

type cb_1 from commandbutton within w_st_etichette
integer x = 645
integer y = 1036
integer width = 512
integer height = 112
integer taborder = 38
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imposta etichetta"
end type

event clicked;//integer num_col, altezza, larghezza, dist_colonne, dist_righe, marg_sup, marg_sx
//
//
//dw_label.Reset ( )
//
//	SELECT "parametri_stampa_etichette"."numero_colonne", 
// 			"parametri_stampa_etichette"."larghezza_etichetta" ,   
//			"parametri_stampa_etichette"."altezza_etichetta" ,   
//			"parametri_stampa_etichette"."distanza_righe",   
//			"parametri_stampa_etichette"."distanza_colonne",
//			"parametri_stampa_etichette"."margine_superiore",
//			"parametri_stampa_etichette"."margine_sinistro"
//	into :num_col,:larghezza,:altezza,:dist_righe,:dist_colonne,:marg_sup,:marg_sx
//	FROM "parametri_stampa_etichette"  
//   WHERE "parametri_stampa_etichette"."nome_configurazione" = :configurazione_attuale     
//	;
//
//string ls_ret
//ls_ret=dw_label.modify('DataWindow.Label.Columns	 				= '+string(num_col))
//
//ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Rows						= 1')
//ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Columns.Spacing		= '+string(dist_colonne * 100))
//
//ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Rows.Spacing			= '+string(dist_righe * 100))
//ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Height					= '+string(altezza * 100))
//ls_ret=ls_ret+dw_label.modify('DataWindow.Label.Width					= '+string(larghezza * 100))
//if ls_ret<>"" then messagebox("error",ls_ret)
//
//
//
//dw_label.Object.DataWindow.Print.Margin.Top = (marg_sup * 100)
//dw_label.Object.DataWindow.Print.Margin.Left = (marg_sx * 100)
//
//if cbx_1.checked = true then
//	dw_label.modify('cornice.X	= '+ "200")	
//	dw_label.modify('cornice.y	= '+ "200")		
//	dw_label.modify('cornice.width	= '+ string(((larghezza*100)-400)))
//	dw_label.modify('cornice.Height	= '+ string(((altezza*100)-400)))
//	dw_label.modify('cornice.pen.style	= '+ "0")		
//	dw_label.modify('cornice.pen.width	= '+ "70")	
//
//else 
//	dw_label.modify('cornice.Visible	= '+ "0")	
//	dw_label.modify('cornice.pen.style	= '+ "5")
//end if
//
//
//if ls_ret<>"" then messagebox("error",ls_ret)
//
//
//string ls_nome, ls_font, ls_autosize
//integer ll_x, ll_y, ll_dim_campo, ll_dim_carattere, ll_alt_campo, ll_rotaz, ll_bold
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "codice"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('codice.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('codice.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('codice.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('codice.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('codice.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('codice.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('codice.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('codice.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('codice.Height.AutoSize		= No')			
//	end if
//		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('codice.font.escapement		= '+string(ll_rotaz*10))	
//	
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "descrizione"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('descrizione.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('descrizione.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('descrizione.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('descrizione.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('descrizione.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('descrizione.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('descrizione.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('descrizione.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('descrizione.Height.AutoSize		= No')			
//	end if
//		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('descrizione.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "des_valuta"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('des_valuta.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('des_valuta.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('des_valuta.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('des_valuta.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('des_valuta.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('des_valuta.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('des_valuta.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('des_valuta.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('des_valuta.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('des_valuta.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "prezzo"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('prezzo.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('prezzo.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('prezzo.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('prezzo.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('prezzo.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('prezzo.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('prezzo.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('prezzo.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('prezzo.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('prezzo.font.escapement		= '+string(ll_rotaz*10))
//
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "cod_barre"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('cod_barre.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('cod_barre.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('cod_barre.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('cod_barre.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('cod_barre.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('cod_barre.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('cod_barre.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('cod_barre.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('cod_barre.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "codice_t"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('codice_t.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('codice_t.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('codice_t.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('codice_t.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('codice_t.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('codice_t.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('codice_t.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('codice_t.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('codice_t.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('codice_t.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "descrizione_t"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('descrizione_t.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('descrizione_t.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('descrizione_t.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('descrizione_t.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('descrizione_t.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('descrizione_t.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('descrizione_t.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('descrizione_t.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('descrizione_t.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('descrizione_t.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "prezzo_t"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('prezzo_t.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('prezzo_t.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('prezzo_t.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('prezzo_t.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('prezzo_t.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('prezzo_t.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('prezzo_t.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('prezzo_t.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('prezzo_t.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('prezzo_t.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "cod_barre_t"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('cod_barre_t.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('cod_barre_t.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('cod_barre_t.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('cod_barre_t.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('cod_barre_t.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('cod_barre_t.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('cod_barre_t.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('cod_barre_t.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('cod_barre_t.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('cod_barre_t.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "pp_t"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('pp_t.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('pp_t.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('pp_t.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('pp_t.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('pp_t.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('pp_t.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('pp_t.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('pp_t.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('pp_t.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('pp_t.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "pc_t"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('pc_t.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('pc_t.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('pc_t.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('pc_t.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('pc_t.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('pc_t.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('pc_t.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('pc_t.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('pc_t.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('pc_t.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "prezzo_p"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('prezzo_p.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('prezzo_p.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('prezzo_p.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('prezzo_p.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('prezzo_p.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('prezzo_p.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('prezzo_p.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('prezzo_p.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('prezzo_p.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('prezzo_p.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "desc_uc"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('desc_uc.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('desc_uc.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('desc_uc.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('desc_uc.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('desc_uc.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('desc_uc.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('desc_uc.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('desc_uc.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('desc_uc.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('desc_uc.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "libero"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('libero.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('libero.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('libero.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('libero.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('libero.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('libero.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('libero.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('libero.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('libero.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('libero.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "libero2"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('libero2.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('libero2.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('libero2.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('libero2.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('libero2.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('libero2.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('libero2.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('libero2.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('libero2.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('libero2.font.escapement		= '+string(ll_rotaz*10))
//
//ll_x = 0
//ll_y = 0
//ll_dim_campo = 0
//ll_dim_carattere = 0
//ll_alt_campo = 0
//ll_rotaz = 0
//ll_bold = 0
//ls_font = ""
//ls_autosize='N'
//
//ls_nome = "simbolo"
//select x, y, dim_campo, dim_carattere, alt_campo, rotazione, grassetto, font, autosize
//into :ll_x, :ll_y, :ll_dim_campo, :ll_dim_carattere, :ll_alt_campo, :ll_rotaz, :ll_bold, :ls_font, :ls_autosize
//from formato_stampa_etichette
//where nome_formato = :ls_nome
//and nome_configurazione = :configurazione_attuale;
//if not isnull(ll_x) and ll_x <> 0 then dw_label.modify('simbolo.x		= '+string(ll_x*100))
//if not isnull(ll_y) and ll_y <> 0 then dw_label.modify('simbolo.y		= '+string(ll_y*100))
//if not isnull(ll_dim_carattere) and ll_dim_carattere <> 0 then dw_label.modify('simbolo.font.height		= '+string(ll_dim_carattere*100))
//if not isnull(ll_alt_campo) and ll_alt_campo <> 0 then dw_label.modify('simbolo.height		= '+string(ll_alt_campo*100))
//if not isnull(ll_dim_campo) and ll_dim_campo <> 0 then dw_label.modify('simbolo.Width		= '+string(ll_dim_campo*100))	
//if not isnull(ll_bold) and ll_bold <> 0 then dw_label.modify('simbolo.font.Weight		= '+string(ll_bold))	
//if not isnull(ls_font) and ls_font <> "" then dw_label.modify('simbolo.font.face		= "'+ ls_font + '"')	
//if not isnull(ls_autosize) and ls_autosize <> "" then 
//	if ls_autosize = 'S' then
//		dw_label.modify('simbolo.Height.AutoSize		= Yes')	
//	else
//		dw_label.modify('simbolo.Height.AutoSize		= No')			
//	end if		
//end if
//if not isnull(ll_rotaz) and ll_rotaz <> 0 then dw_label.modify('simbolo.font.escapement		= '+string(ll_rotaz*10))
//
//
//
//
end event

