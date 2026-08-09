//objectcomments padre di tutti
forward
global type w_base from window
end type
end forward

global type w_base from window
integer x = 1056
integer y = 484
integer width = 2569
integer height = 1516
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event ue_postopen ( )
end type
global w_base w_base

forward prototypes
public function string wf_window_name ()
end prototypes

event ue_postopen();//
end event

public function string wf_window_name ();string ls_name
ls_name= this.classname()
 return ls_name
end function

on w_base.create
end on

on w_base.destroy
end on

event rbuttondown;messagebox("Informazioni!", ClassName())
end event

event open;this.title=string(this.classname())
postevent("ue_postopen")

end event

