forward
global type w_foto_da_doc_2 from w_stampa
end type
type p_1 from picture within w_foto_da_doc_2
end type
type cb_mail from commandbutton within w_foto_da_doc_2
end type
type ole_imm from olecustomcontrol within w_foto_da_doc_2
end type
type cb_2 from commandbutton within w_foto_da_doc_2
end type
end forward

global type w_foto_da_doc_2 from w_stampa
integer width = 3465
integer height = 2572
p_1 p_1
cb_mail cb_mail
ole_imm ole_imm
cb_2 cb_2
end type
global w_foto_da_doc_2 w_foto_da_doc_2

type variables
integer il_num_col
string is_path
integer il_larghezza_disponibile

s_ds_per_foto is_foto
end variables

forward prototypes
public subroutine wf_ruota_imm (string as_nome_imm)
public subroutine wf_crea_foto ()
public subroutine wf_imposta_campi (datawindowchild adwc)
public function integer wf_trova_ris (string as_h_v, string as_nome_imm)
public subroutine wf_logo_testata (datawindowchild adw)
public subroutine wf_2_foto (datawindowchild adwc)
public subroutine wf_2_foto_dw (datawindow adwc)
public subroutine wf_imp_campi_dw (datawindow adwc)
end prototypes

public subroutine wf_ruota_imm (string as_nome_imm);long ll_format


ole_imm.object.printsize=6
ole_imm.object.delimage=true
ole_imm.object.loadimage=as_nome_imm
if ole_imm.object.ImageHeight > ole_imm.object.ImageWidth then
	ole_imm.object.Rotate = 270
	ll_format = ole_imm.object.FileType
	ole_imm.object.saveformat=ll_format
	ole_imm.object.saveimage=as_nome_imm
END IF


end subroutine

public subroutine wf_crea_foto ();integer i, a, b, LI_MAX_width, Li_TEST, LI_MAX_height
integer li_x, li_y, li_ruota, li_b
string ls_imm, modstring, ls_ret, ls_nome, ls_visible
string ls_h, ls_w, modstring_line,modstring_rect, ls_select
string ls_nuovo, dwsyntax, ls_nome_col_dw, ls_path
string ls_null, ls_cod_art
long ll_inizio, ll_fine, ll_esiste


dw_1.setredraw(false)


if isnull(is_foto.w_MAX) or is_foto.w_MAX=0 then is_foto.w_MAX=3240
if isnull(is_foto.h_max) or is_foto.h_max=0 then is_foto.h_max=1020
if isnull(is_foto.x_1) or is_foto.x_1=0 then is_foto.x_1=20
if isnull(is_foto.y_1) or is_foto.y_1=0 then is_foto.y_1=400

is_foto.y_1+= 500*(is_foto.n_righe - 1)

is_foto.w_MAX/=il_num_col 
is_foto.w_MAX -= 30*il_num_col




//if il_num_col>1 then il_MAX_height=3000

is_path=""
select dir_foto
into :is_path
from dba.val_base;
setnull(ls_null)

datawindowchild ldwc_col_1, ldwc_col_2, ldwc_col_3, ldwc_col_4
choose case il_num_col
	case 1 
		if right(is_foto.dw, 1)="5" then
			wf_2_foto_dw(DW_1)
		     wf_imp_campi_dw(dw_1)
		else
			dw_1.getchild("dw_1", ldwc_col_1)
			wf_2_foto(ldwc_col_1)
			wf_imposta_campi(ldwc_col_1)
		end if
		
	case 2
		dw_1.getchild("dw_1", ldwc_col_1)
		wf_2_foto(ldwc_col_1)
		wf_imposta_campi(ldwc_col_1)
		dw_1.getchild("dw_2", ldwc_col_2)
		wf_2_foto(ldwc_col_2)
		wf_imposta_campi(ldwc_col_2)
	case 3
		dw_1.getchild("dw_1", ldwc_col_1)
		wf_2_foto(ldwc_col_1)
		wf_imposta_campi(ldwc_col_1)
		dw_1.getchild("dw_2", ldwc_col_2)
		wf_2_foto(ldwc_col_2)
		wf_imposta_campi(ldwc_col_2)
		dw_1.getchild("dw_3", ldwc_col_3)
		wf_2_foto(ldwc_col_3)
		wf_imposta_campi(ldwc_col_3)
	case 4
		dw_1.getchild("dw_1", ldwc_col_1)
		wf_2_foto(ldwc_col_1)
		wf_imposta_campi(ldwc_col_1)
		dw_1.getchild("dw_2", ldwc_col_2)
		wf_2_foto(ldwc_col_2)
		wf_imposta_campi(ldwc_col_2)
		dw_1.getchild("dw_3", ldwc_col_3)
		wf_2_foto(ldwc_col_3)
		wf_imposta_campi(ldwc_col_3)
		dw_1.getchild("dw_4", ldwc_col_4)
		wf_2_foto(ldwc_col_4)
		wf_imposta_campi(ldwc_col_4)			
end choose
//wf_logo_testata()
dw_1.setredraw(true)

end subroutine

public subroutine wf_imposta_campi (datawindowchild adwc);datastore ds_campi_visibili
integer li_righe, i, li_visibile
string ls_campo, ls_string


if is_foto.cat_imp>"" then
	ds_campi_visibili=create datastore
	ds_campi_visibili.dataobject="ds_campi_visibili"
	ds_campi_visibili.settransobject(sqlca)
	li_righe=ds_campi_visibili.retrieve(is_foto.cat_imp)
	for i= 1 to li_righe
		ls_campo=ds_campi_visibili.getitemstring(i, "campo")
		li_visibile=ds_campi_visibili.getitemnumber(i, "visibile")
		ls_string=ls_campo+".visible="+string(li_visibile)
		adwc.modify(ls_string)
		ls_string=ls_campo+"_t.visible="+string(li_visibile)
		adwc.modify(ls_string)
	next
	
	destroy(ds_campi_visibili)
end if
//dw_1.Modify("emp_status.Visible=0")

end subroutine

public function integer wf_trova_ris (string as_h_v, string as_nome_imm);//
integer li_res
ole_imm.object.printsize=6
ole_imm.object.delimage=true
ole_imm.object.loadimage=as_nome_imm
if as_h_v='V' then
	li_res=ole_imm.object.imageYDpi
else
	li_res=ole_imm.object.imageXDpi
end if

return li_res
end function

public subroutine wf_logo_testata (datawindowchild adw);//carico il logo e lo stampo in una bitmap di 2,5 x 7 cm
//string modstring, ls_nome, ls_imm,ls_h, ls_w,ls_visible, ls_ret
//integer li_x1, li_y1
//
//li_y1=200
//li_x1=500
//ls_w=string(7000)
//ls_h=string(2500)
//ls_nome="logo"
//ls_imm="C:\DATI\LAVORO\sultak10\sultak.bmp"
//ls_visible="1"
//
//modstring = 'create bitmap(band=header x="'+string(li_x1)+'" y="'+string(li_y1)+&
//						'" height="'+ls_h +'" width="'+ ls_w+'" '+&
//						'filename="'+ls_imm+'" border="0"  name=p_'+ls_nome+ &
//						' visible='+ls_visible+&
//						' resizeable=1  moveable=1  )'
//						
//ls_ret=dw_1.Modify(modstring)
//if ls_ret<>"" then 
//	messagebox("ERRORE!", ls_ret)
//end if
//
//
//
//
//
//
//
//
//						
end subroutine

public subroutine wf_2_foto (datawindowchild adwc);integer i, li_ruota, Li_TEST, li_centra_imm
string ls_imm, ls_cod_art, ls_visible, ls_nome,ls_ret
string modstring, modstring_rect, modstring_line
string ls_h, ls_w
integer li_res_h, li_res_v, li_altezza_foto, li_larghezza_foto
decimal ldc_coef_horz, ldc_coef_vert


for i=1 to adwc.rowcount()
		li_altezza_foto=0
		li_larghezza_foto=0
		//ls_imm= dw_1.getitemstring(i, "art_foto")
		ls_imm= adwc.getitemstring(i, 3)
		//ls_cod_art =dw_1.getitemstring(i, "art_codice")
		ls_cod_art =adwc.getitemstring(i, 1)
		//da mettere a posto subito riportando il campo nella dw e shared
		select ruota
		into :li_ruota
		from dba.art
		where art_codice=:ls_cod_art
		;
		if isnull(li_ruota) then li_ruota=0
		
		if pos(ls_imm, "\")=0 then
			ls_imm=is_path+"\"+ls_imm
		end if
		ls_nome=string(i)
		ls_visible='"1~tif(getrow()='+string(i)+', 1, 0)"'
		
		if not(fileexists(ls_imm)) then continue
		if li_ruota=1 then
			wf_ruota_imm(ls_imm)
		end if
		p_1.picturename=ls_imm
		
		li_res_h=wf_trova_ris('V', ls_imm)
		li_res_v=wf_trova_ris('H', ls_imm)
		//la datawindow deve avere come unità di misura i cm/1000
		ldc_coef_horz=li_res_h/2540  //4
		ldc_coef_vert=li_res_v/2540		
		
		li_altezza_foto=unitstopixels(p_1.height, YUnitsToPixels!)
		li_larghezza_foto=unitstopixels(p_1.width, XUnitsToPixels!)
		
		li_altezza_foto /=ldc_coef_vert
		li_larghezza_foto /=ldc_coef_horz
		
		
		if is_foto.h_fissa>0 then 
			ls_h=string(is_foto.h_fissa)
			ls_w=string(round((p_1.width/p_1.height)*is_foto.h_fissa,0))
			if integer(ls_w)>is_foto.w_max then
				if is_foto.taglia=1 then
					ls_w=string(is_foto.w_max)
				else
					ls_w=string(is_foto.w_max)
					ls_h=string(round((p_1.height/p_1.width)*is_foto.w_max,0))
				end if
			end if
		else
		
			if li_altezza_foto>=li_larghezza_foto then
				if li_altezza_foto > is_foto.h_max then
					ls_h=string(is_foto.h_max)
					ls_w=string(round((p_1.width/p_1.height)*is_foto.h_max,0))
					if integer(ls_w)>is_foto.w_max then
						ls_w=string(is_foto.w_max)
						ls_h=string(round((p_1.height/p_1.width)*is_foto.w_max,0))
					end if
				else
					ls_h=string(li_altezza_foto)
					ls_w=string(li_larghezza_foto)
					if integer(ls_w)>is_foto.w_max then
						ls_w=string(is_foto.w_max)
						ls_h=string(round((p_1.height/p_1.width)*is_foto.w_max,0))
					end if
				end if
					
			else
				if li_larghezza_foto > is_foto.w_max then
					ls_w=string(is_foto.w_max)
					ls_h=string(round((p_1.height/p_1.width)*is_foto.w_max,0))
					if integer(ls_h) > is_foto.h_max then
						ls_h=string(is_foto.h_max)
						ls_w=string(round((p_1.width/p_1.height)*is_foto.h_max,0))
					end if
				else
					ls_w=string(li_larghezza_foto)
					if li_altezza_foto > is_foto.h_max then
						ls_h=string(is_foto.h_max)
						ls_w=string(round((p_1.width/p_1.height)*is_foto.h_max,0))
					else
						ls_h=string(li_altezza_foto)
					end if
				end if
				
			end if
		end if
		
		if integer(ls_w) <= is_foto.w_max and is_foto.centra=1 then
			//li_centra_imm=(il_larghezza_disponibile - integer(ls_w))/2
			is_foto.x_1=(il_larghezza_disponibile - integer(ls_w))/2
//		else
//			li_centra_imm=0
		end if
																					//+li_centra_imm
		modstring = 'create bitmap(band=detail x="'+string(is_foto.x_1)+'" y="'+string(is_foto.y_1)+&
						'" height="'+ls_h +'" width="'+ ls_w+'" '+&
						'filename="'+ls_imm+'" border="0"  name=p_'+ls_nome+ &
						' visible='+ls_visible+&
						' resizeable=1  moveable=1  )'
		//row_in_detail='+string(b+1)+'
			
		ls_ret=adwc.Modify(modstring)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
		
		//inserisco il rettangolo di contorno alla foto
		ls_h=string(long(ls_h) + 100)
		ls_w=string(long(ls_w)+ 100)
		modstring_rect = 'create rectangle(band=detail x="'+string(is_foto.x_1+li_centra_imm - 50)+'" y="'+string(is_foto.y_1 - 50)+&
				+ '" visible='+ls_visible &
				+' height="'+ls_h +'" width="'+ls_w +'"  name=r_'+ls_nome+' brush.hatch="7"'&
				+' brush.color="553648127" pen.style="0" pen.width="5"'& 
				+' pen.color="0"  background.mode="1" background.color="0"'+ &
				' resizeable=1  moveable=1 )'
		ls_ret=adwc.Modify(modstring_rect)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
		
		//inserisco una riga di divisione con il record successivo
		if is_foto.h_fissa>0 then 
			ls_h=string(is_foto.h_fissa + is_foto.y_1 + 300)
		else
			ls_h=string(long(ls_h) + is_foto.y_1+ 300)
		end if
		Li_TEST=INTEGER(DW_1.DESCRIBE("NOME_IMMAGINE_1.Y"))+integer(DW_1.describe("NOME_IMMAGINE_1.height"))
		if li_test>integer(ls_h) then ls_h=string(li_test+60) 
		modstring_line='create line(name=l_'+ls_nome+' moveable=1 resizeable=1 band=detail background.mode="2"'& 
			+' background.color="16777215" pen.style="0" pen.width="15" pen.color="0"'+&
			' visible='+ls_visible+&
			+' x1="21" y1="'+ls_h+'" x2="'+string(il_larghezza_disponibile)+'" y2="'+ls_h+'" )'
		ls_ret=adwc.Modify(modstring_line)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
		
	next

//richiama autosize detail
//dw_1.modify("datawindow.detail.height.autosize=yes")
adwc.modify("datawindow.detail.height.autosize=yes")
//ldwc_col_2.modify("datawindow.detail.height.autosize=yes")




end subroutine

public subroutine wf_2_foto_dw (datawindow adwc);integer i, li_ruota, Li_TEST, li_centra_imm
string ls_imm, ls_cod_art, ls_visible, ls_nome,ls_ret
string modstring, modstring_rect, modstring_line
string ls_h, ls_w
integer li_res_h, li_res_v, li_altezza_foto, li_larghezza_foto
decimal ldc_coef_horz, ldc_coef_vert


for i=1 to adwc.rowcount()
		li_altezza_foto=0
		li_larghezza_foto=0
		//ls_imm= dw_1.getitemstring(i, "art_foto")
		ls_imm= adwc.getitemstring(i, 3)
		//ls_cod_art =dw_1.getitemstring(i, "art_codice")
		ls_cod_art =adwc.getitemstring(i, 1)
		//da mettere a posto subito riportando il campo nella dw e shared
		select ruota
		into :li_ruota
		from dba.art
		where art_codice=:ls_cod_art
		;
		if isnull(li_ruota) then li_ruota=0
		
		if pos(ls_imm, "\")=0 then
			ls_imm=is_path+"\"+ls_imm
		end if
		ls_nome=string(i)
		ls_visible='"1~tif(getrow()='+string(i)+', 1, 0)"'
		
		if not(fileexists(ls_imm)) then continue
		if li_ruota=1 then
			wf_ruota_imm(ls_imm)
		end if
		p_1.picturename=ls_imm
		
		li_res_h=wf_trova_ris('V', ls_imm)
		li_res_v=wf_trova_ris('H', ls_imm)
		//la datawindow deve avere come unità di misura i cm/1000
		ldc_coef_horz=li_res_h/2540  //4
		ldc_coef_vert=li_res_v/2540		
		
		li_altezza_foto=unitstopixels(p_1.height, YUnitsToPixels!)
		li_larghezza_foto=unitstopixels(p_1.width, XUnitsToPixels!)
		
		li_altezza_foto /=ldc_coef_vert
		li_larghezza_foto /=ldc_coef_horz
		
		
		if is_foto.h_fissa>0 then 
			ls_h=string(is_foto.h_fissa)
			ls_w=string(round((p_1.width/p_1.height)*is_foto.h_fissa,0))
			if integer(ls_w)>is_foto.w_max then
				if is_foto.taglia=1 then
					ls_w=string(is_foto.w_max)
				else
					ls_w=string(is_foto.w_max)
					ls_h=string(round((p_1.height/p_1.width)*is_foto.w_max,0))
				end if
			end if
		else
		
			if li_altezza_foto>=li_larghezza_foto then
				if li_altezza_foto > is_foto.h_max then
					ls_h=string(is_foto.h_max)
					ls_w=string(round((p_1.width/p_1.height)*is_foto.h_max,0))
					if integer(ls_w)>is_foto.w_max then
						ls_w=string(is_foto.w_max)
						ls_h=string(round((p_1.height/p_1.width)*is_foto.w_max,0))
					end if
				else
					ls_h=string(li_altezza_foto)
					ls_w=string(li_larghezza_foto)
					if integer(ls_w)>is_foto.w_max then
						ls_w=string(is_foto.w_max)
						ls_h=string(round((p_1.height/p_1.width)*is_foto.w_max,0))
					end if
				end if
					
			else
				if li_larghezza_foto > is_foto.w_max then
					ls_w=string(is_foto.w_max)
					ls_h=string(round((p_1.height/p_1.width)*is_foto.w_max,0))
					if integer(ls_h) > is_foto.h_max then
						ls_h=string(is_foto.h_max)
						ls_w=string(round((p_1.width/p_1.height)*is_foto.h_max,0))
					end if
				else
					ls_w=string(li_larghezza_foto)
					if li_altezza_foto > is_foto.h_max then
						ls_h=string(is_foto.h_max)
						ls_w=string(round((p_1.width/p_1.height)*is_foto.h_max,0))
					else
						ls_h=string(li_altezza_foto)
					end if
				end if
				
			end if
		end if
		
		if integer(ls_w) <= is_foto.w_max and is_foto.centra=1 then
			//li_centra_imm=(il_larghezza_disponibile - integer(ls_w))/2
			is_foto.x_1=(il_larghezza_disponibile - integer(ls_w))/2
//		else
//			li_centra_imm=0
		end if
																					//+li_centra_imm
		modstring = 'create bitmap(band=detail x="'+string(is_foto.x_1)+'" y="'+string(is_foto.y_1)+&
						'" height="'+ls_h +'" width="'+ ls_w+'" '+&
						'filename="'+ls_imm+'" border="0"  name=p_'+ls_nome+ &
						' visible='+ls_visible+&
						' resizeable=1  moveable=1  )'
		//row_in_detail='+string(b+1)+'
			
		ls_ret=adwc.Modify(modstring)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
		
		//inserisco il rettangolo di contorno alla foto
		ls_h=string(long(ls_h) + 100)
		ls_w=string(long(ls_w)+ 100)
		modstring_rect = 'create rectangle(band=detail x="'+string(is_foto.x_1+li_centra_imm - 50)+'" y="'+string(is_foto.y_1 - 50)+&
				+ '" visible='+ls_visible &
				+' height="'+ls_h +'" width="'+ls_w +'"  name=r_'+ls_nome+' brush.hatch="7"'&
				+' brush.color="553648127" pen.style="0" pen.width="5"'& 
				+' pen.color="0"  background.mode="1" background.color="0"'+ &
				' resizeable=1  moveable=1 )'
		ls_ret=adwc.Modify(modstring_rect)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
		
		//inserisco una riga di divisione con il record successivo
		if is_foto.h_fissa>0 then 
			ls_h=string(is_foto.h_fissa + is_foto.y_1 + 300)
		else
			ls_h=string(long(ls_h) + is_foto.y_1+ 300)
		end if
		Li_TEST=INTEGER(DW_1.DESCRIBE("NOME_IMMAGINE_1.Y"))+integer(DW_1.describe("NOME_IMMAGINE_1.height"))
		if li_test>integer(ls_h) then ls_h=string(li_test+60) 
		modstring_line='create line(name=l_'+ls_nome+' moveable=1 resizeable=1 band=detail background.mode="2"'& 
			+' background.color="16777215" pen.style="0" pen.width="15" pen.color="0"'+&
			' visible='+ls_visible+&
			+' x1="21" y1="'+ls_h+'" x2="'+string(il_larghezza_disponibile)+'" y2="'+ls_h+'" )'
		ls_ret=adwc.Modify(modstring_line)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
		
	next

//richiama autosize detail
//dw_1.modify("datawindow.detail.height.autosize=yes")
adwc.modify("datawindow.detail.height.autosize=yes")
//ldwc_col_2.modify("datawindow.detail.height.autosize=yes")
end subroutine

public subroutine wf_imp_campi_dw (datawindow adwc);datastore ds_campi_visibili
integer li_righe, i, li_visibile
string ls_campo, ls_string


if is_foto.cat_imp>"" then
	ds_campi_visibili=create datastore
	ds_campi_visibili.dataobject="ds_campi_visibili"
	ds_campi_visibili.settransobject(sqlca)
	li_righe=ds_campi_visibili.retrieve(is_foto.cat_imp)
	for i= 1 to li_righe
		ls_campo=ds_campi_visibili.getitemstring(i, "campo")
		li_visibile=ds_campi_visibili.getitemnumber(i, "visibile")
		ls_string=ls_campo+".visible="+string(li_visibile)
		adwc.modify(ls_string)
		ls_string=ls_campo+"_t.visible="+string(li_visibile)
		adwc.modify(ls_string)
	next
	
	destroy(ds_campi_visibili)
end if

end subroutine

on w_foto_da_doc_2.create
int iCurrent
call super::create
this.p_1=create p_1
this.cb_mail=create cb_mail
this.ole_imm=create ole_imm
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.cb_mail
this.Control[iCurrent+3]=this.ole_imm
this.Control[iCurrent+4]=this.cb_2
end on

on w_foto_da_doc_2.destroy
call super::destroy
destroy(this.p_1)
destroy(this.cb_mail)
destroy(this.ole_imm)
destroy(this.cb_2)
end on

event open;call super::open;string  ls_rag_soc, ls_codice, ls_imm, ls_indirizzo,ls_logo, ls_rag
integer i 
long ll_id_sog, ll_id_riga, ll_riga_inserita
date ldt_data

integer li_w_max, li_h_max, li_altezza_foto, li_larghezza_foto
integer li_res_h, li_res_v
string ls_h, ls_w
decimal ldc_coef_horz, ldc_coef_vert

is_foto=message.PowerObjectParm
dw_1.dataobject=is_foto.dw



il_num_col=integer(right(is_foto.dw, 1))
if isnull(il_num_col) or il_num_col=0 then il_num_col=1

datawindowchild ldwc_col_1, ldwc_col_2, ldwc_col_3, ldwc_col_4
choose case il_num_col
	case 1
		il_larghezza_disponibile=is_foto.w_max
		dw_1.getchild("dw_1", ldwc_col_1)
		is_foto.ds_dati_doc.rowscopy(1, is_foto.ds_dati_doc.rowcount() , primary!, ldwc_col_1, 1, primary!)
	
	
	case 2
		il_larghezza_disponibile=(is_foto.w_max/2) - 60
		dw_1.getchild("dw_1", ldwc_col_1)
		dw_1.getchild("dw_2", ldwc_col_2)
		for i= 1 to is_foto.ds_dati_doc.rowcount() step 2
			is_foto.ds_dati_doc.rowscopy(i, i, primary!, ldwc_col_1, ldwc_col_1.rowcount()+1, primary!)
			is_foto.ds_dati_doc.rowscopy(i+1, i+1, primary!, ldwc_col_2, ldwc_col_2.rowcount()+1, primary!)
		next 
	case 3
		il_larghezza_disponibile=(is_foto.w_max/3) - 120
		dw_1.getchild("dw_1", ldwc_col_1)
		dw_1.getchild("dw_2", ldwc_col_2)
		dw_1.getchild("dw_3", ldwc_col_3)
		for i= 1 to is_foto.ds_dati_doc.rowcount() step 3
			is_foto.ds_dati_doc.rowscopy(i, i, primary!, ldwc_col_1, ldwc_col_1.rowcount()+1, primary!)
			is_foto.ds_dati_doc.rowscopy(i+1, i+1, primary!, ldwc_col_2, ldwc_col_2.rowcount()+1, primary!)
			is_foto.ds_dati_doc.rowscopy(i+2, i+2, primary!, ldwc_col_3, ldwc_col_3.rowcount()+1, primary!)
		next 
	case 4
		il_larghezza_disponibile=(is_foto.w_max/4) - 180
		dw_1.getchild("dw_1", ldwc_col_1)
		dw_1.getchild("dw_2", ldwc_col_2)
		dw_1.getchild("dw_3", ldwc_col_3)
		dw_1.getchild("dw_4", ldwc_col_4)
		for i= 1 to is_foto.ds_dati_doc.rowcount() step 4
			is_foto.ds_dati_doc.rowscopy(i, i, primary!, ldwc_col_1, ldwc_col_1.rowcount()+1, primary!)
			is_foto.ds_dati_doc.rowscopy(i+1, i+1, primary!, ldwc_col_2, ldwc_col_2.rowcount()+1, primary!)
			is_foto.ds_dati_doc.rowscopy(i+2, i+2, primary!, ldwc_col_3, ldwc_col_3.rowcount()+1, primary!)
			is_foto.ds_dati_doc.rowscopy(i+3, i+3, primary!, ldwc_col_4, ldwc_col_4.rowcount()+1, primary!)
		next 
	CASE 5
		il_larghezza_disponibile=is_foto.w_max
		is_foto.ds_dati_doc.rowscopy(1, is_foto.ds_dati_doc.rowcount() , primary!, DW_1, 1, primary!)
		cb_preview.enabled=true
		
end choose
//RIPORTO RAG_SOC DELLA DITTA E INDIRIZZO
//solo se sono state richieste il logo e le scritte
if il_num_col<5 then
	select isnull(az_indirizzo, ' ')+
	+'~r~n'+' '+isnull(az_localita, ' ')+' - ' +isnull(az_citta, ' ')+
	' - '+isnull(az_cap, ' ')+' - ('+isnull(az_provincia, ' ')+') - Italy~r~n'
	+'Tel. '+isnull(az_tel, ' ')+ ' - '+'Fax: '+isnull(az_fax, ' ')+'~r~n'
	+'E-Mail: '+isnull(az_email, ' '), az_logo, az_rag_sociale
	into :ls_indirizzo, :ls_logo, :ls_rag
	from dba.azienda
	;
	dw_1.object.t_indirizzo.text=ls_indirizzo
	if is_foto.titolo>" " then
		dw_1.object.t_rag_soc.text=is_foto.titolo
	else
		dw_1.object.t_rag_soc.text=ls_rag
	end if
	//ora il logo
	dw_1.object.p_1.fileName = ls_logo

	if fileexists(ls_logo) then
		p_1.picturename=ls_logo
		
		li_res_h=wf_trova_ris('V', ls_logo)
		li_res_v=wf_trova_ris('H', ls_logo)
		//la datawindow deve avere come unità di misura i cm/1000
		ldc_coef_horz=li_res_h/2540  //4
		ldc_coef_vert=li_res_v/2540		
		
		li_altezza_foto=unitstopixels(p_1.height, YUnitsToPixels!)
		li_larghezza_foto=unitstopixels(p_1.width, XUnitsToPixels!)
		
		//inserisco un controllo perché dalla Laura mi dà div by 0!!!!!
		if ldc_coef_vert=0 then ldc_coef_vert=1
		if ldc_coef_horz=0 then ldc_coef_horz=1
		li_altezza_foto /=ldc_coef_vert
		li_larghezza_foto /=ldc_coef_horz
		
		select h_max_logo, w_max_logo
		into :li_h_max, :li_w_max
		from dba.val_base
		;
		
		if isnull(li_w_max) or li_w_max=0 then li_w_max=9000
		if isnull(li_h_max) or li_h_max=0 then li_h_max=2500
		
		
		//if li_altezza_foto >= li_larghezza_foto then
		//	if li_altezza_foto > li_h_max then
		//		ls_h=string(li_h_max)
		//		ls_w=string(round((p_1.width/p_1.height)*li_w_max,0))
		//		if integer(ls_w)>li_w_max then
		//			ls_w=string(li_w_max)
		//			ls_h=string(round((p_1.height/p_1.width)*li_w_max,0))
		//		end if
		//	else
		//		ls_h=string(li_altezza_foto)
		//		ls_w=string(li_larghezza_foto)
		//		if integer(ls_w)>li_w_max then
		//			ls_w=string(li_w_max)
		//			ls_h=string(round((p_1.height/p_1.width)*li_w_max,0))
		//		end if
		//	end if
		//		
		//else
		//	if li_larghezza_foto > li_w_max then
		//		ls_w=string(li_w_max)
		//		ls_h=string(round((p_1.height/p_1.width)*li_w_max,0))
		//		if integer(ls_h) > li_h_max then
		//			ls_h=string(is_foto.h_max)
		//			ls_w=string(round((p_1.width/p_1.height)*li_h_max,0))
		//		end if
		//	else
		//		ls_w=string(li_larghezza_foto)
		//		if li_altezza_foto > li_h_max then
		//			ls_h=string(li_h_max)
		//			ls_w=string(round((p_1.width/p_1.height)*li_h_max,0))
		//		else
		//			ls_h=string(li_altezza_foto)
		//		end if
		//	end if
		//	
		//end if
		
		ls_h=string(li_h_max)
		ls_w=string(round((p_1.width/p_1.height)*li_h_max,0))
		if integer(ls_w)>li_w_max then
			ls_w=string(li_w_max)
			ls_h=string(round((p_1.height/p_1.width)*li_w_max,0))
		end if
		
		
		dw_1.object.p_1.width=ls_w
		dw_1.object.p_1.height=ls_h
	end if
else
	il_num_col=1
end if

wf_crea_foto()


end event

type cb_preview from w_stampa`cb_preview within w_foto_da_doc_2
string tag = "Preview"
integer x = 2226
boolean enabled = false
string picturename = ""
string disabledname = "Preview!"
end type

type dw_1 from w_stampa`dw_1 within w_foto_da_doc_2
integer width = 3323
integer height = 1644
end type

event dw_1::clicked;call super::clicked;//long i, ll_righe, ll_row
//
//if row>0 then
//	if KeyDown(KeyShift!) then
//		ll_righe=RowCount()
//		for i= 1 to ll_righe
//			if IsSelected(i) then 
//				ll_row=i
//				exit
//			end if
//		next
//		if ll_row>0 then
//			for i=ll_row+1 to row
//				selectrow(i, true) 
//			next
//		else
//			messagebox("Attenzione!", "Occorre selezionare la riga iniziale delle selezione multipla!")
//		end if
//	elseif KeyDown(KeyControl!) then
//		 selectrow(row, not IsSelected(row))
//	else
//		for i=1 to rowcount()
//			selectrow(i, false) 
//		next
//	 	selectrow(row, true)
//	end if
//end if	
//
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_foto_da_doc_2
integer x = 2633
end type

type pb_stampa from w_stampa`pb_stampa within w_foto_da_doc_2
integer x = 2423
end type

type sle_pg from w_stampa`sle_pg within w_foto_da_doc_2
integer x = 1518
integer width = 361
end type

type st_1 from w_stampa`st_1 within w_foto_da_doc_2
integer x = 1239
end type

type st_2 from w_stampa`st_2 within w_foto_da_doc_2
end type

type sle_copie from w_stampa`sle_copie within w_foto_da_doc_2
end type

type sle_zoom from w_stampa`sle_zoom within w_foto_da_doc_2
integer x = 658
end type

type cb_7 from w_stampa`cb_7 within w_foto_da_doc_2
integer x = 809
end type

type cb_6 from w_stampa`cb_6 within w_foto_da_doc_2
integer x = 544
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_foto_da_doc_2
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_foto_da_doc_2
end type

type cb_esci from w_stampa`cb_esci within w_foto_da_doc_2
end type

type p_1 from picture within w_foto_da_doc_2
boolean visible = false
integer x = 919
integer y = 1728
integer width = 1801
integer height = 2148
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type cb_mail from commandbutton within w_foto_da_doc_2
integer x = 946
integer y = 36
integer width = 224
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mail"
end type

event clicked;integer i
string ls_ret, ls_filename, ls_path

/* devi creare un pdf cercando la stampante adatta e poi creare una mail con allegato
il pdf*/

//CREARE UN CAMPO DIR_pdf IN VAL BASE
select dir_pdf
into :ls_path
from VAL_BASE
;

if ls_path>"" then 
	if right(ls_path, 1)<>'\' then ls_path+='\'
else
	ls_path="c:\"
end if
//TROVARE IL SISTEMA DI DARE UN NOME SIGNIFICATIVO PER ORA è FISSO "CAT_MAIL"
ls_filename=ls_path+"cat_mail"+string(today(), "dd-mm-yy hh_mm_ss")

long job

job = PrintOpen( )

// Each DataWindow starts printing on a new page.

ls_ret=dw_1.Modify("DataWindow.Print.printername = 'CutePDF Writer'")
ls_ret=dw_1.Modify("DataWindow.Print.documentname = '"+ls_filename+"'")

PrintDataWindow(job, dw_1)

PrintClose(job)

openwithparm(w_invia_mail, ls_filename+".pdf")


//openwithparm(w_invia_mail, ls_attach)



//for i= 1 to dw_1.rowcount()
//	ls_attach[i,1]=dw_1.getitemstring(i,"nome_immagine")
//	ls_attach[i,2]=dw_1.getitemstring(i,"cod_articolo")
//	
//	
//next
end event

type ole_imm from olecustomcontrol within w_foto_da_doc_2
event paintevent ( )
event selectevent ( long lplleft,  long lpltop,  long lplright,  long lplbottom )
event statusevent ( long lppercent )
event click ( )
event dblclick ( )
event keydown ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event keyup ( integer keycode,  integer shift )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event scroll ( long scrolltype )
event errorevent ( integer nerrcount )
event thumbnail ( string filename,  long page )
event tag ( integer tagid,  integer tagtype,  long tagsize,  integer wordval,  long longval,  string strval )
event thumbtitle ( string title,  integer page )
boolean visible = false
integer x = 73
integer y = 1440
integer width = 457
integer height = 200
integer taborder = 140
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_foto_da_doc_2.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_2 from commandbutton within w_foto_da_doc_2
boolean visible = false
integer x = 174
integer y = 272
integer width = 402
integer height = 112
integer taborder = 28
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "per n up"
end type

event clicked;integer i, a, b, LI_MAX_width, Li_TEST, LI_MAX_height
integer li_x, li_y, li_ruota, li_b
string ls_imm, modstring, ls_ret, ls_nome, ls_visible
string ls_h, ls_w, modstring_line,modstring_rect, ls_select
string ls_nuovo, dwsyntax, ls_nome_col_dw, ls_path
string ls_null, ls_cod_art
long ll_inizio, ll_fine, ll_esiste

select L_max_foto, h_max_foto, x_foto, y_foto
into :LI_MAX_width, :LI_MAX_height, :li_x, :li_y
from dba.val_base
;

if isnull(LI_MAX_width) or LI_MAX_width=0 then LI_MAX_width=3100
if isnull(LI_MAX_height) or LI_MAX_height=0 then LI_MAX_height=1020
if isnull(li_x) or li_x=0 then li_x=20
if isnull(li_y) or li_y=0 then li_y=400

LI_MAX_width/=il_num_col
if il_num_col>1 then LI_MAX_height=6500
li_b=LI_MAX_width

ls_path=""
select dir_foto
into :ls_path
from dba.val_base;
setnull(ls_null)

for i=1 to dw_1.rowcount()
	a++
	if a=il_num_col and il_num_col>1 then 
		a=0
		continue
	elseif a>1 and a < il_num_col then
		continue
	end if
	for b=0 to il_num_col - 1
		if i+b > dw_1.rowcount() then exit
		
		//ls_imm= dw_1.getitemstring(i, "art_foto")
		ls_imm= dw_1.getitemstring(i+b, 3)
		//ls_cod_art =dw_1.getitemstring(i, "art_codice")
		ls_cod_art =dw_1.getitemstring(i+b, 1)
		//da mettere a posto subito riportando il campo nella dw e shared
		select ruota
		into :li_ruota
		from dba.art
		where art_codice=:ls_cod_art
		;
		if isnull(li_ruota) then li_ruota=0
		
		if pos(ls_imm, "\")=0 then
			ls_imm=ls_path+"\"+ls_imm
		end if
		ls_nome=string(i)
		ls_visible='"1~tif(getrow()='+string(i)+', 1, 0)"'
		
		if not(fileexists(ls_imm)) then continue
		if li_ruota=1 then
			wf_ruota_imm(ls_imm)
		end if
		p_1.picturename=ls_imm
		
		if p_1.height>=p_1.width then
			if p_1.height > LI_MAX_height then
				ls_h=string(LI_MAX_height)
				ls_w=string(round((p_1.width/p_1.height)*LI_MAX_height,0))
			else
				ls_h=string(p_1.height)
				ls_w=string(p_1.width)
			end if
				
		else
			if p_1.width > LI_MAX_width then
				ls_w=string(LI_MAX_width)
				ls_h=string(round((p_1.height/p_1.width)*LI_MAX_width,0))
				if integer(ls_h) > LI_MAX_height then
					ls_h=string(LI_MAX_height)
					ls_w=string(round((p_1.width/p_1.height)*LI_MAX_height,0))
				end if
			else
				ls_w=string(p_1.width)
				if p_1.height > LI_MAX_height then
					ls_h=string(LI_MAX_height)
					ls_w=string(round((p_1.width/p_1.height)*LI_MAX_height,0))
				else
					ls_h=string(p_1.height)
				end if
			end if
			
		end if
		
		modstring = 'create bitmap(band=detail x="'+string((li_x+li_b)*b)+'" y="'+string(li_y)+&
						'" height="'+ls_h +'" width="'+ ls_w+'" '+&
						'filename="'+ls_imm+'" border="0"  name=p_'+ls_nome+ &
						' visible='+ls_visible+&
						' resizeable=1  moveable=1  )'
		//row_in_detail='+string(b+1)+'
			
		ls_ret=dw_1.Modify(modstring)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
		
		//inserisco il rettangolo di contorno alla foto
		ls_h=string(long(ls_h) + 20)
		ls_w=string(long(ls_w)+20)
		modstring_rect = 'create rectangle(band=detail x="'+string(li_x - 10)+'" y="'+string(li_y - 10)+&
				+ '" visible='+ls_visible &
				+' height="'+ls_h +'" width="'+ls_w +'"  name=r_'+ls_nome+' brush.hatch="7"'&
				+' brush.color="553648127" pen.style="0" pen.width="5"'& 
				+' pen.color="0"  background.mode="1" background.color="0"'+ &
				' resizeable=1  moveable=1 )'
		ls_ret=dw_1.Modify(modstring_rect)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
		
		//inserisco una riga di divisione con il record successivo
		ls_h=string(long(ls_h) + li_y+ 30)
		Li_TEST=INTEGER(DW_1.DESCRIBE("NOME_IMMAGINE_1.Y"))+integer(DW_1.describe("NOME_IMMAGINE_1.height"))
		if li_test>integer(ls_h) then ls_h=string(li_test+60) 
		modstring_line='create line(name=l_'+ls_nome+' moveable=1 resizeable=1 band=detail background.mode="2"'& 
			+' background.color="16777215" pen.style="0" pen.width="15" pen.color="0"'+&
			' visible='+ls_visible+&
			+' x1="21" y1="'+ls_h+'" x2="3290" y2="'+ls_h+'" )'
		ls_ret=dw_1.Modify(modstring_line)
		if ls_ret<>"" then 
			messagebox("ERRORE!", ls_ret)
		end if
		
	next
next
//richiama autosize detail
dw_1.modify("datawindow.detail.height.autosize=yes")

end event

