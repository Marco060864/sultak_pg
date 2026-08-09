forward
global type uo_transobject from transaction
end type
end forward

global type uo_transobject from transaction
end type
global uo_transobject uo_transobject

on uo_transobject.create
call transaction::create
TriggerEvent( this, "constructor" )
end on

on uo_transobject.destroy
call transaction::destroy
TriggerEvent( this, "destructor" )
end on

