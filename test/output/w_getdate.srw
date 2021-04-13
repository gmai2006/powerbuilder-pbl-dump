HA$PBExportHeader$w_getdate.srw
$PBExportComments$
forward
global type w_getdate from w_response
end type
type em_date from editmask within w_getdate
end type
type st_1 from statictext within w_getdate
end type
end forward

global type w_getdate from w_response
integer width = 782
integer height = 412
em_date em_date
st_1 st_1
end type
global w_getdate w_getdate

on w_getdate.create
int iCurrent
call super::create
this.em_date=create em_date
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_date
this.Control[iCurrent+2]=this.st_1
end on

on w_getdate.destroy
call super::destroy
destroy(this.em_date)
destroy(this.st_1)
end on

event open;call super::open;title = trn(263)
st_1.text = trn(361) + ":"
end event

type cb_cancel from w_response`cb_cancel within w_getdate
integer x = 402
integer y = 188
end type

event cb_cancel::clicked;// ÅðéóôñïöÞ ìå ""
	CloseWithReturn(getparent(), "")
end event

type cb_ok from w_response`cb_ok within w_getdate
integer x = 46
integer y = 188
end type

event cb_ok::clicked;// ÌåôáôñïðÞ ôçò çì/íßáò óå string êáé åðéóôñïöÞ
date	ld_date
em_date.getdata(ld_date)
if isnull(ld_date) then
	Messagebox(gs_app_name, trn(160))
	return
end if
CloseWithReturn(getparent(), string(ld_date))
end event

type em_date from editmask within w_getdate
integer x = 366
integer y = 36
integer width = 352
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
string text = "none"
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_1 from statictext within w_getdate
integer x = 37
integer y = 48
integer width = 265
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

