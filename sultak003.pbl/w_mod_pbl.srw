forward
global type w_mod_pbl from w_base
end type
type sle_path from singlelineedit within w_mod_pbl
end type
type cb_libex from commandbutton within w_mod_pbl
end type
type dw_1 from datawindow within w_mod_pbl
end type
type st_path from statictext within w_mod_pbl
end type
type lb_files from listbox within w_mod_pbl
end type
type rte_log from richtextedit within w_mod_pbl
end type
type cb_ok from commandbutton within w_mod_pbl
end type
end forward

global type w_mod_pbl from w_base
integer width = 2821
integer height = 1828
sle_path sle_path
cb_libex cb_libex
dw_1 dw_1
st_path st_path
lb_files lb_files
rte_log rte_log
cb_ok cb_ok
end type
global w_mod_pbl w_mod_pbl

type variables

end variables

forward prototypes
public subroutine f_no_comment (string ls_path, string ls_file, string ls_newdir)
end prototypes

public subroutine f_no_comment (string ls_path, string ls_file, string ls_newdir);string ls_dati
integer i, li_items, li_Fileread, li_filewrite, li_fine
integer li_pos_aster, li_pos_barra, li_pos_aster_fine

li_Fileread=FILEOPEN(ls_path+"\"+ls_file, linemode!, 	read!)
rte_log.replacetext(ls_path+"\"+ls_file+"~r~n")
li_fine=fileread(li_Fileread, ls_dati)
li_filewrite=FILEOPEN(ls_path+ls_newdir+ls_file, linemode!, write!, shared!, replace!)
do while li_fine<>-100 
	li_pos_aster=pos(ls_dati,"/*")
	if li_pos_aster=0 or isnull(li_pos_aster) then li_pos_aster=30000
	li_pos_barra=pos(ls_dati, "//")
	if li_pos_barra=0 or isnull(li_pos_barra) then li_pos_barra=30000
	if li_pos_barra < li_pos_aster then
		if li_pos_barra>0 then
			rte_log.replacetext(ls_dati+"~r~n")
			ls_dati=left(ls_dati, li_pos_barra - 1)
			if ls_dati="" then ls_dati="&&&_%%_???"
		end if
	elseif li_pos_aster < li_pos_barra then
		rte_log.replacetext(ls_dati+"~r~n")
		li_pos_aster_fine=pos(ls_dati,"*/", li_pos_aster+1)
		if left(ls_dati, li_pos_aster - 1)>"" then
			filewrite(li_filewrite, left(ls_dati, li_pos_aster - 1))
		end if
		do while not li_pos_aster_fine>0 
			li_fine=fileread(li_fileread, ls_dati)
			rte_log.replacetext(ls_dati+"~r~n")
			li_pos_aster_fine=pos(ls_dati,"*/")
		loop
	
		ls_dati=right(ls_dati, len(ls_dati) - (li_pos_aster_fine+1))
		if ls_dati="" then ls_dati="&&&_%%_???"
	end if
	if ls_dati<>"&&&_%%_???" then
		filewrite(li_filewrite, ls_dati)
	end if
	li_fine=fileread(li_fileread, ls_dati)
loop
fileclose(li_fileread)
fileclose(li_filewrite)

//messagebox("E", "Finito!")
end subroutine

on w_mod_pbl.create
int iCurrent
call super::create
this.sle_path=create sle_path
this.cb_libex=create cb_libex
this.dw_1=create dw_1
this.st_path=create st_path
this.lb_files=create lb_files
this.rte_log=create rte_log
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_path
this.Control[iCurrent+2]=this.cb_libex
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_path
this.Control[iCurrent+5]=this.lb_files
this.Control[iCurrent+6]=this.rte_log
this.Control[iCurrent+7]=this.cb_ok
end on

on w_mod_pbl.destroy
call super::destroy
destroy(this.sle_path)
destroy(this.cb_libex)
destroy(this.dw_1)
destroy(this.st_path)
destroy(this.lb_files)
destroy(this.rte_log)
destroy(this.cb_ok)
end on

event open;call super::open;sle_path.text="C:\DATI\lavoro\modlib"
end event

type sle_path from singlelineedit within w_mod_pbl
integer x = 549
integer y = 28
integer width = 1033
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type cb_libex from commandbutton within w_mod_pbl
integer x = 2299
integer y = 20
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Export"
end type

event clicked;string ls_path

string ls_lib, ls_suffisso, ls_dati, ls_w_export
string ls_sintax, ls_errore, ls_est
integer li_items, i, a, e, j, li_filewrite, li_giri, li_test
long ll_file_len, ll_start
libdirtype l_dir_tipo
libexporttype l_exp_tipo


ls_path=sle_path.text
ls_suffisso="\*.pbl"

If DirectoryExists (ls_path) Then
	lb_files.dirlist(ls_path+ls_suffisso, 0, st_path)
else
	lb_files.reset()
end if
li_items=lb_files.totalitems()
for j=1 to 5
	choose case j
		case 1
			ls_est=".srw~r~n" //window
			l_dir_tipo=dirwindow!
			l_exp_tipo=ExportWindow!
		case 2
			ls_est=".srf~r~n" //funzioni
			l_dir_tipo=DirFunction! 
			l_exp_tipo=ExportFunction! 
		case 3
			ls_est=".sru~r~n" //user object
			l_dir_tipo=DirUserObject! 
			l_exp_tipo=ExportUserObject!
		case 4
			ls_est=".sra~r~n" //applicazione
			l_dir_tipo=DirApplication!
			l_exp_tipo=ExportApplication!
		case 5
			ls_est=".srm~r~n" //menu
			l_dir_tipo=DirMenu!
			l_exp_tipo=ExportMenu!
	end choose
	for i= 1 to li_items
		ls_lib=lb_files.text(i)
		ls_dati=librarydirectory(ls_path+"\"+ls_lib, l_dir_tipo)//dirwindow!)
		dw_1.reset()
		dw_1.importstring(ls_dati)
		for a=1 to dw_1.rowcount()
			ls_w_export=dw_1.getitemstring(a, "nome")
			ls_sintax=libraryexport(ls_path+"\"+ls_lib, ls_w_export, l_exp_tipo) //ExportWindow!)
			ls_sintax="$PBExportHeader$"+ls_w_export+ls_est+ls_sintax
			li_filewrite=FILEOPEN(ls_path+"\"+ls_w_export+left(ls_est, len(ls_est) - 2), streammode!, write!, shared!, replace!)
			ll_file_len=len(ls_sintax)//filelength(ls_path+"\"+ls_w_export+".srw")
			if ll_file_len>32765 THEN
			  IF Mod(ll_file_len, 32765) = 0 THEN
					li_giri = ll_file_len/32765
			  ELSE
				  li_giri = (ll_file_len/32765) + 1
			  END IF
			else
				li_giri=1
			end if
			ll_start=1
			for e= 1 to li_giri
				filewrite(li_filewrite, mid(ls_sintax, ll_start,32765))
				ll_start+=32765
			next
			fileclose(li_filewrite)
			li_test=createdirectory(ls_path+"\"+left(ls_lib, len(ls_lib) - 4)+"\")
			
			f_no_comment(ls_path, ls_w_export+left(ls_est, len(ls_est) - 2), "\"+left(ls_lib, len(ls_lib) - 4)+"\")
				
		next
			
	next
next
end event

type dw_1 from datawindow within w_mod_pbl
integer x = 933
integer y = 252
integer width = 1783
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "d_ogg_export"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_path from statictext within w_mod_pbl
integer x = 32
integer y = 168
integer width = 1070
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type lb_files from listbox within w_mod_pbl
integer x = 41
integer y = 244
integer width = 722
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type rte_log from richtextedit within w_mod_pbl
integer x = 23
integer y = 668
integer width = 2715
integer height = 844
integer taborder = 20
boolean init_hscrollbar = true
boolean init_vscrollbar = true
boolean init_toolbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_ok from commandbutton within w_mod_pbl
integer x = 87
integer y = 24
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Vai"
end type

event clicked;string  ls_path
string  ls_suffisso="\*.srw"
string ls_file, ls_dati
integer i, li_items, li_Fileread, li_filewrite, li_fine
integer li_pos_aster, li_pos_barra, li_pos_aster_fine

ls_path=sle_path.text
If DirectoryExists (ls_path) Then
	lb_files.dirlist(ls_path+ls_suffisso, 0, st_path)
else
	lb_files.reset()
end if
li_items=lb_files.totalitems()
for i= 1 to li_items
	LS_FILE=lb_files.text(i)
	li_Fileread=FILEOPEN(ls_path+"\"+ls_file, linemode!, 	read!)
	rte_log.replacetext(ls_path+"\"+ls_file+"~r~n")
	li_fine=fileread(li_Fileread, ls_dati)
	li_filewrite=FILEOPEN(ls_path+"\new\"+ls_file, linemode!, write!, shared!, replace!)
	do while li_fine<>-100 
		li_pos_aster=pos(ls_dati,"/*")
		if li_pos_aster=0 or isnull(li_pos_aster) then li_pos_aster=30000
		li_pos_barra=pos(ls_dati, "//")
		if li_pos_barra=0 or isnull(li_pos_barra) then li_pos_barra=30000
		if li_pos_barra < li_pos_aster then
			if li_pos_barra>0 then
				rte_log.replacetext(ls_dati+"~r~n")
				ls_dati=left(ls_dati, li_pos_barra - 1)
				if ls_dati="" then ls_dati="&&&_%%_???"
			end if
		elseif li_pos_aster < li_pos_barra then
			rte_log.replacetext(ls_dati+"~r~n")
			li_pos_aster_fine=pos(ls_dati,"*/", li_pos_aster+1)
			do while not li_pos_aster_fine>0 
				li_fine=fileread(li_fileread, ls_dati)
				rte_log.replacetext(ls_dati+"~r~n")
				li_pos_aster_fine=pos(ls_dati,"*/")
			loop
		
			ls_dati=right(ls_dati, len(ls_dati) - (li_pos_aster_fine+1))
			if ls_dati="" then ls_dati="&&&_%%_???"
		end if
		if ls_dati<>"&&&_%%_???" then
			filewrite(li_filewrite, ls_dati)
		end if
		li_fine=fileread(li_fileread, ls_dati)
	loop
	fileclose(li_fileread)
	fileclose(li_filewrite)
next

messagebox("E", "Finito!")
end event

