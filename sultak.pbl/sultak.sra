forward
global type sultak from application
end type
global uo_transobject sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
n_application gn_app
n_wininet gn_ftp
w_web_ins_art_immagini gw_frame

end variables

global type sultak from application
string appname = "sultak"
string microhelpdefault = "MICROHELP"
string dwmessagetitle = "DWMESsAGETITLE"
string displayname = "Sultak"
integer highdpimode = 0
string appruntimeversion = "25.1.0.6430"
end type
global sultak sultak

type prototypes
//public function long PRP_GetDC (long job) library "pbvm90.dll"
Function long  GetDeviceCaps (  Long hdc, long nIndex) library  "GDI32"    
Function long DeleteDC(long dc) library "GDI32"
Public FUNCTION long  PRP_GetDC10 (Long printjob) library "PBSHR100.dll" alias for "PRP_GetDC"
function ulong GetModuleFileNameA(ulong module, ref string buffer, ulong lenght) Library "Kernel32.dll" ALIAS FOR "GetModuleFileNameA;ansi"
function int GetModuleHandleA (string as_ModuleName) library "kernel32.dll"

function  int CreateFileA(string lpFileName, ulong   dwDesiredAccess, ulong  dwShareMode, int  lpSecurityAttributes, ulong  dwCreationDisposition, ulong  dwFlagsAndAttributes, ulong  hTemplateFile) library "kernel32.dll"

function BOOLean WriteFile(int  hFile, ref string lpBuffer, int nNumberOfBytesToWrite, ulong lpOverlapped, ulong lpCompletionRoutine)   library "kernel32.dll"
function BOOLean WriteFileex(int  hFile, ref string lpBuffer, int nNumberOfBytesToWrite, ulong lpOverlapped, ulong lpCompletionRoutine)   library "kernel32.dll"
function BOOLean  CloseHandle(int hObject) library "kernel32.dll"

function long GetFileSizeEx(int hFile, ref ulong lpFileSize)  library "kernel32.dll"

Public Function string invia_pec(string ls_smtp) Library "clmm32.dll" Alias For "invia_pec;ansi"
Function string Encrypt(string ls_smtp) Library "pec.dll" Alias For "Encrypt;ansi"
FUNCTION boolean CryptBinaryToStringW(blob pbBinary, ulong cbBinary, ulong dwFlags, ref string pszString, ref ulong pcchString) LIBRARY "crypt32.dll"

FUNCTION ulong GetLastError() LIBRARY "kernel32.dll"

//PUBLIC SUBROUTINE invia_pec(string ls_smtp) LIBRARY "MYDLL.DLL" ALIAS FOR "sayHelloA"


//function ulong GetTempPathA ( ulong cchBuffer, ref char lpszTempPath[255]) library  "Kernel32.dll"  
//Function uint  GetTempFileNameA ( ref char DriveLetter[255], ref char PrefixString[255], uint Unique, ref char TempFileName[255]) library  "Kernel32.dll"    
//Function long SetTextColor(long dc, long color) library "GDI32"
//Function long CreatePen(integer stile, integer spessore, long color) library "GDI32"
//Function long SelectObject (long dc, long object) library "GDI32"
//Function Integer DeleteObject(long object) library "GDI32"
//function ulong GetDC( ulong hWnd1 )  Library "USER32.DLL"
//function long ReleaseDC(ulong hWnd1, long hDC) Library "USER32.DLL"
//function boolean TextOutA( ulong hdc,long nXStart, &
//long nYStart, ref string lpString, &
//long cbString ) Library "GDI32.DLL"
//function ulong CreateFontA( long nHeight, &
//long nWidth,  long nEscapement, &
//long nOrientation, long fnWeight, &
//ulong fdwItalic,ulong fdwUnderline, ulong fdwStrikeOut, &
//ulong fdwCharSet, ulong fdwOutputPrecision, &
//ulong fdwClipPrecision, ulong fdwQuality, &
//ulong fdwPitchAndFamily, ref string lpszFace ) Library "GDI32.dll"
//function boolean MoveFileA(ref string old, ref string new) Library "Kernel32.dll"
//function ulong GetModuleFileNameA(ulong module, ref string buffer, ulong lenght) Library "Kernel32.dll"
//
end prototypes

type variables
string is_uid, is_pwd, is_db
end variables

on sultak.create
appname="sultak"
message=create message
sqlca=create uo_transobject
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on sultak.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;// Open MDI frame window
Open (w_mdi)




end event

