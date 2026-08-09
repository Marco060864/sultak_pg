//objectcomments Generated Application Object
forward
global type sultak125 from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type sultak125 from application
string appname = "sultak125"
end type
global sultak125 sultak125

on sultak125.create
appname="sultak125"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on sultak125.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;Open (w_mdi)

end event

