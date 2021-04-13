HA$PBExportHeader$w_response.srw
$PBExportComments$
forward
global type w_response from window
end type
type cb_cancel from commandbutton within w_response
end type
type cb_ok from commandbutton within w_response
end type
end forward

global type w_response from window
integer width = 1495
integer height = 1224
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_response w_response

type variables

end variables

on w_response.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.cb_cancel,&
this.cb_ok}
end on

on w_response.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;cb_ok.text = trn(699)
cb_cancel.text = trn(2)
end event

type cb_cancel from commandbutton within w_response
integer x = 1120
integer y = 964
integer width = 311
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "Cancel" //trn(2)
boolean cancel = true
end type

event clicked;CloseWithReturn(GetParent(), 0)


end event

type cb_ok from commandbutton within w_response
integer x = 763
integer y = 964
integer width = 311
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "&ÏÊ" 
boolean default = true
end type

event clicked;CloseWithReturn(GetParent(), 1)


end event

