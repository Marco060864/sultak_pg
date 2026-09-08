forward
global type w_mdi from w_base
end type
type mdi_1 from mdiclient within w_mdi
end type
type mdirbb_1 from ribbonbar within w_mdi
end type
type mditbb_1 from tabbedbar within w_mdi
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
mdirbb_1 mdirbb_1
mditbb_1 mditbb_1
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
//20260904 Ricerca dell'ini in tre passi, per non dipendere da CHI e' l'eseguibile
//in esecuzione. GetModuleFileNameA torna l'exe che gira davvero: con l'applicativo
//compilato e' sultak.exe e l'ini giusto gli sta accanto, ma lanciando dall'IDE e'
//PB250.exe, il cui PB250.ini non ha nessuna sezione [Database]. Prima in quel caso
//si finiva sempre sulla finestrella w_ini_db, che ACCODA una nuova sezione
//[Database] in fondo all'ini: ProfileString pero' legge sempre la PRIMA, quindi si
//restava collegati al database vecchio credendo di averlo cambiato.
sl_file_ini = ls_solo_path+ls_nome_file+".ini"
ls_odbc_destinazione = ProfileString ( sl_file_ini, "Database", "Nome", "Error!" )

//2) ini dell'applicativo a percorso fisso: e' questo che copre il caso IDE
if ls_odbc_destinazione = "Error!" then
	sl_file_ini = "C:\sultak\sultak.ini"
	ls_odbc_destinazione = ProfileString ( sl_file_ini, "Database", "Nome", "Error!" )
end if

//3) solo se non si e' trovato nulla si chiede all'utente
if ls_odbc_destinazione = "Error!" then
	OpenWithParm(w_ini_db,sl_file_ini)
	ls_odbc_destinazione = message.stringparm 
end if
ls_odbc_destinazione = trim(ls_odbc_destinazione)
if pos(ls_odbc_destinazione, "pg")>0 then
	// Profile sole_pg_ado
	sqlca.DBMS     = "ADO.Net"
	sqlca.Database = "sole"
	sqlca.LogId    = "postgres"
	sqlca.LogPass  = "Pippone@01"
	sqlca.DBParm   = "Provider='PostgreSQL',host='localhost',port='5432', PROVIDERSTRING='SSL Mode=Disable;'"
	sqlca.AutoCommit = TRUE //da togliere dopo aver trovato tutti gli errori di non rollback dopo sqlca.sqlcode<>0
	CONNECT USING sqlca;
	if sqlca.sqlcode<>0 then
		messagebox("Errore!", "Connessione a PostgreSQL non riuscita:~r~n"+sqlca.sqlerrtext)
	end if
else
	//20260907 DIAGNOSI TEMPORANEA: "TRACE ODBC" fa scrivere a PowerBuilder la SQL
	//esatta (UPDATE + WHERE con i valori) in dbtrace.log. Rimettere "ODBC" dopo.
	sqlca.DBMS = "TRACE ODBC"
	//per ASA Sybse 9-17
	sqlca.DBParm ="ConnectString ='DSN="+ls_odbc_destinazione+";UID=DBA;PWD=SQL'"
	//per postgres 
	//sqlca.DBParm ="ConnectString ='DSN="+ls_odbc_destinazione+";UID=postgres;PWD=Pippone@01'"
	sqlca.Database = "'"+ls_odbc_destinazione+"'"
	CONNECT USING sqlca;
	if sqlca.sqlcode<>0 then
		messagebox("Errore!", sqlca.sqlerrtext)	
	end if
end if
//20260904 deve essere sempre visibile A QUALE database si e' connessi e da quale
//ini e' stato deciso: senza, un ini sbagliato non si nota fino all'errore SQL.
if sqlca.sqlcode = 0 then
	this.title = "SULTAK - DB: "+ls_odbc_destinazione+"  ("+sqlca.DBMS+" - ini: "+sl_file_ini+")"
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
destroy(this.mdirbb_1)
destroy(this.mditbb_1)
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

