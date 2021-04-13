HA$PBExportHeader$w_about.srw
$PBExportComments$
forward
global type w_about from window
end type
type st_dbver_req from statictext within w_about
end type
type st_creator from statictext within w_about
end type
type st_app from statictext within w_about
end type
type st_copyright from statictext within w_about
end type
type st_address from statictext within w_about
end type
type st_serial from statictext within w_about
end type
type st_dbversion from statictext within w_about
end type
type st_version from statictext within w_about
end type
type cb_ok from commandbutton within w_about
end type
type gb_1 from groupbox within w_about
end type
type gb_2 from groupbox within w_about
end type
end forward

global type w_about from window
integer width = 1614
integer height = 1332
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_dbver_req st_dbver_req
st_creator st_creator
st_app st_app
st_copyright st_copyright
st_address st_address
st_serial st_serial
st_dbversion st_dbversion
st_version st_version
cb_ok cb_ok
gb_1 gb_1
gb_2 gb_2
end type
global w_about w_about

on w_about.create
this.st_dbver_req=create st_dbver_req
this.st_creator=create st_creator
this.st_app=create st_app
this.st_copyright=create st_copyright
this.st_address=create st_address
this.st_serial=create st_serial
this.st_dbversion=create st_dbversion
this.st_version=create st_version
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_dbver_req,&
this.st_creator,&
this.st_app,&
this.st_copyright,&
this.st_address,&
this.st_serial,&
this.st_dbversion,&
this.st_version,&
this.cb_ok,&
this.gb_1,&
this.gb_2}
end on

on w_about.destroy
destroy(this.st_dbver_req)
destroy(this.st_creator)
destroy(this.st_app)
destroy(this.st_copyright)
destroy(this.st_address)
destroy(this.st_serial)
destroy(this.st_dbversion)
destroy(this.st_version)
destroy(this.cb_ok)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;// ÅíçìÝñùóç text
	title =  trn(539)
	st_app.text = gs_app_name
	st_version.text = trn(267) + ": " + gs_version_number + " (" + gs_version_date + ")"
	st_dbver_req.text = trn(706) + ": " + gs_dbver_req
	st_dbversion.text = trn(269) + ": " + gs_dbver
	st_serial.text = "S/N: " + gs_serialnumber
	st_copyright.text = trn(237) + " - GPL"
	st_creator.text = trn(700) + ": " + trn(655)
	st_address.text = trn(588)
	
	
	cb_ok.text = trn(699)
end event

type st_dbver_req from statictext within w_about
integer x = 69
integer y = 264
integer width = 1431
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 16711680
long backcolor = 67108864
string text = "dbver_req"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_creator from statictext within w_about
integer x = 69
integer y = 788
integer width = 1431
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 80269524
string text = "Creator"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_app from statictext within w_about
integer x = 69
integer y = 72
integer width = 1431
integer height = 72
integer textsize = -12
integer weight = 700
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
long backcolor = 67108864
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_copyright from statictext within w_about
integer x = 69
integer y = 668
integer width = 1431
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 8388608
long backcolor = 80269524
string text = "Copyright"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_address from statictext within w_about
integer x = 69
integer y = 908
integer width = 1431
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 8388608
long backcolor = 80269524
string text = "Address"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_serial from statictext within w_about
integer x = 69
integer y = 456
integer width = 1431
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Unicode MS"
long textcolor = 128
long backcolor = 67108864
string text = "serial number"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_dbversion from statictext within w_about
integer x = 69
integer y = 360
integer width = 1431
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Unicode MS"
long textcolor = 16711680
long backcolor = 67108864
string text = "dbversion"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_version from statictext within w_about
integer x = 69
integer y = 168
integer width = 1431
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Unicode MS"
long textcolor = 16711680
long backcolor = 67108864
string text = "Version"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_about
integer x = 1179
integer y = 1092
integer width = 370
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "ÏÊ"
boolean cancel = true
boolean default = true
end type

event clicked;close(GetParent())
end event

type gb_1 from groupbox within w_about
integer x = 37
integer y = 12
integer width = 1513
integer height = 568
integer taborder = 10
integer textsize = -5
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Unicode MS"
long textcolor = 255
long backcolor = 67108864
end type

type gb_2 from groupbox within w_about
integer x = 37
integer y = 584
integer width = 1513
integer height = 444
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long backcolor = 80269524
end type

