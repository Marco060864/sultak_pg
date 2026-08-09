forward
global type udw_stampa from datawindow
end type
end forward

global type udw_stampa from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global udw_stampa udw_stampa

type variables
integer ii_zoom=100, ii_num_pagine
string is_asc
end variables

on udw_stampa.create
end on

on udw_stampa.destroy
end on

event doubleclicked;string ls_type, modstring

if dwo.type='column' then
	
//	ls_type=describe(dwo.name+".edit.style")
//	if ls_type='dddw' then
//		modstring='create compute(name='+dwo.name+'_compute moveable=1 resizeable=1 band=detail '+& 
//		' expression= "1" visible="1" )'
//		modify(modstring)
//	end if
	if is_asc='A' then
		is_asc='D'
	else
		is_asc='A'
	end if
	setsort(dwo.name+ " "+is_asc)
	setredraw(false)
	sort()
	groupcalc()
	setredraw(true)
	
end if

//Lookupdisplay('+dwo.name+')
end event

