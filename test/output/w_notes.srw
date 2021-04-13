HA$PBExportHeader$w_notes.srw
$PBExportComments$
forward
global type w_notes from w_response
end type
type dw_notes from datawindow within w_notes
end type
end forward

global type w_notes from w_response
integer width = 2245
integer height = 964
string title = "notes"
dw_notes dw_notes
end type
global w_notes w_notes

type variables
string	is_notes
end variables

on w_notes.create
int iCurrent
call super::create
this.dw_notes=create dw_notes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_notes
end on

on w_notes.destroy
call super::destroy
destroy(this.dw_notes)
end on

event open;call super::open;// Ðáßñíïõìå ôï initial string áðü Message
	is_notes = Message.StringParm
	
// Initialize dw_notes êáé åê÷þñçóç is_notes
	dw_notes.Insertrow(0)
	dw_notes.object.notes[1] = is_notes
	dw_notes.setfocus()
	
// translation
	title = trn(504)
end event

type cb_cancel from w_response`cb_cancel within w_notes
integer x = 1879
integer y = 720
end type

event cb_cancel::clicked;// ÅðéóôñïöÞ ""
	closewithreturn(getparent(), "")
end event

type cb_ok from w_response`cb_ok within w_notes
integer x = 1522
integer y = 720
end type

event cb_ok::clicked;// ÅðéóôñÝöïõìå ôéò óçìåéþóåéò ìÝóù Message
	dw_notes.accepttext()
	
	is_notes = dw_notes.object.notes[1]
	
	closewithreturn(getparent(), is_notes)
end event

type dw_notes from datawindow within w_notes
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

