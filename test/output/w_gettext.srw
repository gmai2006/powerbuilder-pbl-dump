HA$PBExportHeader$w_gettext.srw
$PBExportComments$
forward
global type w_gettext from w_response
end type
type dw_notes from datawindow within w_gettext
end type
end forward

global type w_gettext from w_response
integer width = 2245
integer height = 964
string title = ""
dw_notes dw_notes
end type
global w_gettext w_gettext

type variables
string	is_title, &
			is_text
end variables

on w_gettext.create
int iCurrent
call super::create
this.dw_notes=create dw_notes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_notes
end on

on w_gettext.destroy
call super::destroy
destroy(this.dw_notes)
end on

event open;call super::open;// Ðáßñíïõìå ôï initial string áðü Message
// Êáé ôï êÜíïõìå ôßôëï óôï ðáñÜèõñï
	is_title = Message.StringParm
	this.title = is_title
	
// Initialize dw_notes êáé åê÷þñçóç is_notes
	dw_notes.Insertrow(0)
	dw_notes.setfocus()
end event

type cb_cancel from w_response`cb_cancel within w_gettext
integer x = 1879
integer y = 720
end type

event cb_cancel::clicked;// ÅðéóôñïöÞ ""
	closewithreturn(getparent(), "")
end event

type cb_ok from w_response`cb_ok within w_gettext
integer x = 1522
integer y = 720
end type

event cb_ok::clicked;// ÅðéóôñÝöïõìå ôéò óçìåéþóåéò ìÝóù Message
	dw_notes.accepttext()
	
	is_text = dw_notes.object.notes[1]
	
	closewithreturn(getparent(), is_text)
end event

type dw_notes from datawindow within w_gettext
integer x = 23
integer y = 16
integer width = 2185
integer height = 664
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "edw_notes"
boolean border = false
boolean livescroll = true
end type

