forward
global type w_st_scheda_lav from w_stampa
end type
type p_1 from picture within w_st_scheda_lav
end type
end forward

global type w_st_scheda_lav from w_stampa
integer width = 4037
integer height = 1968
p_1 p_1
end type
global w_st_scheda_lav w_st_scheda_lav

forward prototypes
public function integer wf_trova_ris (string as_h_v, string as_nome_imm)
public subroutine wf_carica_foto ()
end prototypes

public function integer wf_trova_ris (string as_h_v, string as_nome_imm);integer li_res
//ole_imm.object.printsize=6
//ole_imm.object.delimage=true
//ole_imm.object.loadimage=as_nome_imm
//if as_h_v='V' then
//	li_res=ole_imm.object.imageYDpi
//else
//	li_res=ole_imm.object.imageXDpi
//end if
//
return li_res
end function

public subroutine wf_carica_foto ();long li_altezza_foto, li_larghezza_foto, li_res_h, li_res_v, li_h_fissa, li_h_max, li_w_max
long li_altezza_foto1, li_larghezza_foto1
string ls_imm, ls_cod_art, ls_path,ls_h, ls_w
boolean lb_taglia
decimal ldc_coef,ldc_coef_horz,ldc_coef_vert
		li_h_max=19000
		li_w_max=19000
		ls_path="c:\sultak\foto"
		//ls_imm= dw_1.getitemstring(i, "art_foto")
		ls_cod_art =dw_1.getitemstring(1, "distinta_codice")
		ls_imm= ls_cod_art+".jpg"
		if pos(ls_imm, "\")=0 then
			ls_imm=ls_path+"\"+ls_imm
		end if
		if not(fileexists(ls_imm)) then messagebox("Attenzione!", "Foto NON trovata!")
		p_1.picturename=ls_imm
		li_altezza_foto1=p_1.height
		li_larghezza_foto1=p_1.width
		
		ldc_coef_horz=6.746
		ldc_coef_vert=5.855
		li_altezza_foto1*=ldc_coef_vert
		li_larghezza_foto1*=ldc_coef_horz
		dw_1.modify("p_1.filename='"+ls_imm+"'")
		
//		li_res_h=wf_trova_ris('V', ls_imm)
//		li_res_v=wf_trova_ris('H', ls_imm)
		
//		ldc_coef_horz=li_res_h/2540  //4
//		ldc_coef_vert=li_res_v/2540		
		
//		li_altezza_foto=unitstopixels(dw_1.object.p_1.height, YUnitsToPixels!)
//		li_larghezza_foto=unitstopixels(dw_1.object.p_1.width, XUnitsToPixels!)
		ls_h=dw_1.describe("p_1.height")
		ls_w=dw_1.describe("p_1.width")
		li_altezza_foto=li_altezza_foto1
		li_larghezza_foto=li_larghezza_foto1
		
		
		
//		li_altezza_foto /=ldc_coef_vert
//		li_larghezza_foto /=ldc_coef_horz
//		
//		ls_h=dw_1.describe("p_1.height")
//		ls_w=dw_1.describe("p_1.width")
//		li_altezza_foto=integer(ls_h)
//		li_larghezza_foto=integer(ls_w)
		if li_larghezza_foto> li_w_max then
			li_larghezza_foto=li_w_max
			li_altezza_foto=li_larghezza_foto*li_altezza_foto1/li_larghezza_foto1
		end if
		if li_altezza_foto>li_h_max then
			li_altezza_foto=li_h_max
			li_larghezza_foto=li_larghezza_foto1*li_altezza_foto/li_altezza_foto1
		end if
//		li_altezza_foto/=2.54
//		li_larghezza_foto/=2.54
		ls_h=string(li_altezza_foto)
		ls_w=string(li_larghezza_foto)
		dw_1.modify("p_1.height="+ls_h+"")
		dw_1.modify("p_1.width="+ls_w+"")
		
//		li_w_max
		
		 
		//messagebox(ls_h, ls_w)
end subroutine

on w_st_scheda_lav.create
int iCurrent
call super::create
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
end on

on w_st_scheda_lav.destroy
call super::destroy
destroy(this.p_1)
end on

event open;call super::open;s_distinta_mag s_dis
long ll_righe
integer i

s_dis=message.powerobjectparm


dw_1.settransobject(sqlca)
ll_righe=dw_1.retrieve(s_dis.id_distinta)
for i =1 to ll_righe
	dw_1.setitem(i, "a_qta", s_dis.qta)	
next
wf_carica_foto()
if s_dis.nota>" " then
	dw_1.object.t_nota.text=s_dis.nota
	dw_1.object.t_nota.visible=true
end if



//		li_altezza_foto=0
//		li_larghezza_foto=0
//		//ls_imm= dw_1.getitemstring(i, "art_foto")
//		ls_imm= adwc.getitemstring(i, 3)
//		//ls_cod_art =dw_1.getitemstring(i, "art_codice")
//		ls_cod_art =adwc.getitemstring(i, 1)
//		//da mettere a posto subito riportando il campo nella dw e shared
//		select ruota
//		into :li_ruota
//		from dba.art
//		where art_codice=:ls_cod_art
//		;
//		if isnull(li_ruota) then li_ruota=0
//		
//		if pos(ls_imm, "\")=0 then
//			ls_imm=is_path+"\"+ls_imm
//		end if
//		ls_nome=string(i)
//		ls_visible='"1~tif(getrow()='+string(i)+', 1, 0)"'
//		
//		if not(fileexists(ls_imm)) then continue
//		if li_ruota=1 then
//			wf_ruota_imm(ls_imm)
//		end if
//		p_1.picturename=ls_imm
//		
//		li_res_h=wf_trova_ris('V', ls_imm)
//		li_res_v=wf_trova_ris('H', ls_imm)
//		//la datawindow deve avere come unità di misura i cm/1000
//		ldc_coef_horz=li_res_h/2540  //4
//		ldc_coef_vert=li_res_v/2540		
//		
//		li_altezza_foto=unitstopixels(p_1.height, YUnitsToPixels!)
//		li_larghezza_foto=unitstopixels(p_1.width, XUnitsToPixels!)
//		
//		li_altezza_foto /=ldc_coef_vert
//		li_larghezza_foto /=ldc_coef_horz
//		
//		
//		if is_foto.h_fissa>0 then 
//			ls_h=string(is_foto.h_fissa)
//			ls_w=string(round((p_1.width/p_1.height)*is_foto.h_fissa,0))
//			if integer(ls_w)>is_foto.w_max then
//				if is_foto.taglia=1 then
//					ls_w=string(is_foto.w_max)
//				else
//					ls_w=string(is_foto.w_max)
//					ls_h=string(round((p_1.height/p_1.width)*is_foto.w_max,0))
//				end if
//			end if
//		else
//		
//			if li_altezza_foto>=li_larghezza_foto then
//				if li_altezza_foto > is_foto.h_max then
//					ls_h=string(is_foto.h_max)
//					ls_w=string(round((p_1.width/p_1.height)*is_foto.h_max,0))
//					if integer(ls_w)>is_foto.w_max then
//						ls_w=string(is_foto.w_max)
//						ls_h=string(round((p_1.height/p_1.width)*is_foto.w_max,0))
//					end if
//				else
//					ls_h=string(li_altezza_foto)
//					ls_w=string(li_larghezza_foto)
//					if integer(ls_w)>is_foto.w_max then
//						ls_w=string(is_foto.w_max)
//						ls_h=string(round((p_1.height/p_1.width)*is_foto.w_max,0))
//					end if
//				end if
//					
//			else
//				if li_larghezza_foto > is_foto.w_max then
//					ls_w=string(is_foto.w_max)
//					ls_h=string(round((p_1.height/p_1.width)*is_foto.w_max,0))
//					if integer(ls_h) > is_foto.h_max then
//						ls_h=string(is_foto.h_max)
//						ls_w=string(round((p_1.width/p_1.height)*is_foto.h_max,0))
//					end if
//				else
//					ls_w=string(li_larghezza_foto)
//					if li_altezza_foto > is_foto.h_max then
//						ls_h=string(is_foto.h_max)
//						ls_w=string(round((p_1.width/p_1.height)*is_foto.h_max,0))
//					else
//						ls_h=string(li_altezza_foto)
//					end if
//				end if
//				
//			end if
//		end if
//		
//		if integer(ls_w) <= is_foto.w_max and is_foto.centra=1 then
//			//li_centra_imm=(il_larghezza_disponibile - integer(ls_w))/2
//			is_foto.x_1=(il_larghezza_disponibile - integer(ls_w))/2
////		else
////			li_centra_imm=0
//		end if
//																					//+li_centra_imm
//		modstring = 'create bitmap(band=detail x="'+string(is_foto.x_1)+'" y="'+string(is_foto.y_1)+&
//						'" height="'+ls_h +'" width="'+ ls_w+'" '+&
//						'filename="'+ls_imm+'" border="0"  name=p_'+ls_nome+ &
//						' visible='+ls_visible+&
//						' resizeable=1  moveable=1  )'
//		//row_in_detail='+string(b+1)+'
//			
//		ls_ret=adwc.Modify(modstring)
//		if ls_ret<>"" then 
//			messagebox("ERRORE!", ls_ret)
//		end if
//		
//		//inserisco il rettangolo di contorno alla foto
//		ls_h=string(long(ls_h) + 100)
//		ls_w=string(long(ls_w)+ 100)
//		modstring_rect = 'create rectangle(band=detail x="'+string(is_foto.x_1+li_centra_imm - 50)+'" y="'+string(is_foto.y_1 - 50)+&
//				+ '" visible='+ls_visible &
//				+' height="'+ls_h +'" width="'+ls_w +'"  name=r_'+ls_nome+' brush.hatch="7"'&
//				+' brush.color="553648127" pen.style="0" pen.width="5"'& 
//				+' pen.color="0"  background.mode="1" background.color="0"'+ &
//				' resizeable=1  moveable=1 )'
//		ls_ret=adwc.Modify(modstring_rect)
//		if ls_ret<>"" then 
//			messagebox("ERRORE!", ls_ret)
//		end if
end event

type pb_1 from w_stampa`pb_1 within w_st_scheda_lav
end type

type cb_preview from w_stampa`cb_preview within w_st_scheda_lav
end type

type dw_1 from w_stampa`dw_1 within w_st_scheda_lav
integer width = 3872
string dataobject = "d_scheda_lav"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_scheda_lav
end type

type pb_stampa from w_stampa`pb_stampa within w_st_scheda_lav
end type

type sle_pg from w_stampa`sle_pg within w_st_scheda_lav
end type

type st_1 from w_stampa`st_1 within w_st_scheda_lav
end type

type st_2 from w_stampa`st_2 within w_st_scheda_lav
end type

type sle_copie from w_stampa`sle_copie within w_st_scheda_lav
end type

type sle_zoom from w_stampa`sle_zoom within w_st_scheda_lav
end type

type cb_7 from w_stampa`cb_7 within w_st_scheda_lav
end type

type cb_6 from w_stampa`cb_6 within w_st_scheda_lav
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_scheda_lav
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_scheda_lav
end type

type cb_esci from w_stampa`cb_esci within w_st_scheda_lav
end type

type p_1 from picture within w_st_scheda_lav
boolean visible = false
integer x = 370
integer y = 1664
integer width = 329
integer height = 176
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

