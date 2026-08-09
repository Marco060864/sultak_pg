forward
global type w_utente_ff from w_base
end type
type cb_ok from commandbutton within w_utente_ff
end type
type dw_1 from udw_001 within w_utente_ff
end type
end forward

global type w_utente_ff from w_base
integer width = 1755
integer height = 896
windowtype windowtype = response!
cb_ok cb_ok
dw_1 dw_1
end type
global w_utente_ff w_utente_ff

forward prototypes
public subroutine wf_carica_db ()
end prototypes

public subroutine wf_carica_db ();//connessione al DB tramite oggetto di transazione

sqlca.DBMS = "ODBC"
sqlca.DBParm ="ConnectString ='DSN=SULTAK;UID=DBA;PWD=SQL'"
//sqlca.Database = ""
CONNECT USING sqlca;
if sqlca.sqlcode<>0 then
	messagebox("Errore!", sqlca.sqlerrtext)	
end if


end subroutine

on w_utente_ff.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.dw_1
end on

on w_utente_ff.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;string sl_file_ini,ls_odbc_destinazione

dw_1.settransobject(sqlca)



dw_1.insertrow(1)

sl_file_ini="c:\sultak\sultak.ini"
//GetModuleFileNameA(0,ls_path,255)


ls_odbc_destinazione = ProfileString ( sl_file_ini, "Database", "Nome", "Error!" )


//dw_1.setitem(1, "utente", "DBA")
//dw_1.setitem(1, "pwd", "SQL")
dw_1.setitem(1, "db", ls_odbc_destinazione)
end event

type cb_ok from commandbutton within w_utente_ff
integer x = 1211
integer y = 595
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
boolean default = true
end type

event clicked;long ll_id_utente
string ls_controlla

dw_1.accepttext()
sultak.is_uid=dw_1.getitemstring(1, "utente")
if sultak.is_uid="" or isnull(sultak.is_uid) then
	messagebox("Attenzione!" , "Specificare Utente!")
	return
end if
sultak.is_pwd=dw_1.getitemstring(1, "pwd")
if sultak.is_pwd="" or isnull(sultak.is_pwd) then
	messagebox("Attenzione!" , "Password NON inserita!")
	return
end if
sultak.is_db=dw_1.getitemstring(1, "db")
select id_utente
into :ll_id_utente
from dba.utente
where utente=:sultak.is_uid and pwd=:sultak.is_pwd
;
if ll_id_utente>0 then
	title="SULTAK Il SuperVeloce - DB: "+ sultak.is_db
	select controllo_scadenze
	into :ls_controlla
	from dba.val_base;
	if ls_controlla='S' then post f_controlla_scadenze()
else
	messagebox("Attenzione!", "Utente Non riconosciuto!")
	return
end if



close(parent)

end event

type dw_1 from udw_001 within w_utente_ff
integer x = 40
integer y = 35
integer width = 1631
integer height = 515
string dataobject = "d_utente_ff"
boolean livescroll = false
end type

