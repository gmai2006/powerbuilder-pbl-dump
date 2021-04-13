HA$PBExportHeader$w_pleasewait.srw
$PBExportComments$
forward
global type w_pleasewait from window
end type
type st_1 from statictext within w_pleasewait
end type
end forward

global type w_pleasewait from window
integer width = 882
integer height = 256
windowtype windowtype = popup!
long backcolor = 67108864
boolean center = true
st_1 st_1
end type
global w_pleasewait w_pleasewait

on w_pleasewait.create
this.st_1=create st_1
this.Control[]={this.st_1}
end on

on w_pleasewait.destroy
destroy(this.st_1)
end on

event open;// translation
	st_1.text = trn(498) + "..."
end event

type st_1 from statictext within w_pleasewait
integer x = 78
integer y = 88
integer width = 718
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
long backcolor = 67108864
string text = "Please wait..."
boolean focusrectangle = false
end type

