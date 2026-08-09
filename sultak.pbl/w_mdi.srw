forward
global type w_mdi from w_base
end type
type mdi_1 from mdiclient within w_mdi
end type
type mditbb_1 from tabbedbar within w_mdi
end type
type mdirbb_1 from ribbonbar within w_mdi
end type
end forward

global type w_mdi from w_base
integer x = 73
integer y = 36
integer height = 1956
string title = "Sultak"
string menuname = "menu_mn"
boolean hscrollbar = true
boolean vscrollbar = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "d:\DATI\LAVORO\sultak10\sultak.ico"
mdi_1 mdi_1
mditbb_1 mditbb_1
mdirbb_1 mdirbb_1
end type
global w_mdi w_mdi

type variables
uo_transobject io_trans
string is_ric_sw
end variables

forward prototypes
public subroutine wf_carica_db ()
public subroutine controlla_utente ()
end prototypes

public subroutine wf_carica_db ();//connessione al DB tramite oggetto di transazione
string ls_odbc_destinazione, ls_ret, ls_pass, ls_controlla, ls_path, ls_nome_file, ls_solo_path
long ll_id_utente,ll_last_slash, ll_pos
string sl_file_ini, sl_result

//open(w_utente_ff)
ls_path=fill("*",256)

GetModuleFileNameA(0, ls_path, 256) 

//Routine intelligentissima ma utile che dato un path con nome di applicazione in fondo terminale ne estrae il nome
//privato del .exe
//es: uf_extract_exe_name("c:\mammiferi\bovini\camilla.exe") ritorna "camilla"

ll_last_slash = 1
ll_pos=1
DO
 	ll_pos = Pos(ls_path,"\",ll_pos+1)
	if ll_pos<>0 then
		ll_last_slash = ll_pos
	end if
	
LOOP UNTIL ll_pos=0

ls_nome_file= mid(ls_path,ll_last_slash+1, len(ls_path) - ll_last_slash - 4)


ll_last_slash = 1
ll_pos=1
DO
 	ll_pos = Pos(ls_path,"\",ll_pos+1)
	if ll_pos<>0 then
		ll_last_slash = ll_pos
	end if
	
LOOP UNTIL ll_pos=0

ls_solo_path= mid(ls_path,1,ll_last_slash)





//commento per ora (14092017
sl_file_ini = ls_solo_path+ls_nome_file+".ini"

//sl_file_ini="c:\sultak\sultak.ini"

ls_odbc_destinazione = ProfileString ( sl_file_ini, "Database", "Nome", "Error!" )

if ls_odbc_destinazione = "Error!" then
	OpenWithParm(w_ini_db,sl_file_ini)
	ls_odbc_destinazione = message.stringparm 
end if
sqlca.DBMS = "ODBC"
sqlca.DBParm ="ConnectString ='DSN="+ls_odbc_destinazione+";UID=DBA;PWD=SQL'"
sqlca.Database = "'"+ls_odbc_destinazione+"'"
CONNECT USING sqlca;
if sqlca.sqlcode<>0 then
	messagebox("Errore!", sqlca.sqlerrtext)	
end if
//
//select id_utente
//into :ll_id_utente
//from dba.utente
//where utente=:sultak.is_uid and pwd=:sultak.is_pwd
//;
//if ll_id_utente>0 then
//	title="SULTAK Il SuperVeloce - DB: "+ ls_odbc_destinazione
//	select controllo_scadenze
//	into :ls_controlla
//	from dba.val_base;
//	if ls_controlla='S' then post f_controlla_scadenze()
//else
//	messagebox("Attenzione!", "Utente Non riconosciuto!")
//	close(this)
//end if


//io_trans = CREATE uo_transobject
//io_trans.DBMS = "ODBC"
//io_trans.DBParm ="ConnectString ='DSN="+ls_odbc_destinazione+";UID="+sultak.is_uid+";PWD="+sultak.is_pwd+"'"
//io_trans.Database = ""
//CONNECT USING io_trans;
//if io_trans.sqlcode<>0 then
//	messagebox("Errore!", io_trans.sqlerrtext)
//	close(w_mdi)
//end if
//
//
//
end subroutine

public subroutine controlla_utente ();long ll_id_utente
string ls_controlla


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
	close(this)
end if

end subroutine

on w_mdi.create
int iCurrent
call super::create
if this.MenuName = "menu_mn" then this.MenuID = create menu_mn
this.mdi_1=create mdi_1
this.mditbb_1=create mditbb_1
this.mdirbb_1=create mdirbb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mdi_1
this.Control[iCurrent+2]=this.mditbb_1
this.Control[iCurrent+3]=this.mdirbb_1
end on

on w_mdi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.mditbb_1)
destroy(this.mdirbb_1)
end on

event open;time lt_time, lt_time1
string ls_controllo
long ll_id_utente
//open splash 
open (w_logo)
lt_time1=now()
lt_time1=relativetime(lt_time1, 1)
do
	lt_time=now()
loop while lt_time<=lt_time1

close (w_logo)
wf_carica_db()
SELECT controllo
into :ls_controllo
from dba.db
where db = 'sultak'
;
this.title=string(this.classname()) +  " - DB: "+sultak.is_db
if ls_controllo= 'S' then
	open(w_utente_ff)
	controlla_utente()
end if




end event

type mdi_1 from mdiclient within w_mdi
long BackColor=134217729
end type

type mditbb_1 from tabbedbar within w_mdi
int X=0
int Y=0
int Width=0
int Height=104
end type

type mdirbb_1 from ribbonbar within w_mdi
int X=0
int Y=0
int Width=0
int Height=596
end type

