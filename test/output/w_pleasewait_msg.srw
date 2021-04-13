HA$PBExportHeader$w_pleasewait_msg.srw
$PBExportComments$
forward
global type w_pleasewait_msg from w_pleasewait
end type
type st_message from statictext within w_pleasewait_msg
end type
end forward

global type w_pleasewait_msg from w_pleasewait
integer height = 264
st_message st_message
end type
global w_pleasewait_msg w_pleasewait_msg

on w_pleasewait_msg.create
int iCurrent
call super::create
this.st_message=create st_message
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_message
end on

on w_pleasewait_msg.destroy
call super::destroy
destroy(this.st_message)
end on

type st_1 from w_pleasewait`st_1 within w_pleasewait_msg
integer y = 32
end type

type st_message from statictext within w_pleasewait_msg
integer x = 37
integer y = 144
integer width = 795
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 8388608
long backcolor = 16777215
boolean border = true
boolean focusrectangle = false
end type

