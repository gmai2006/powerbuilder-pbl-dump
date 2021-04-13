HA$PBExportHeader$w_about_template.srw
$PBExportComments$
forward
global type w_about_template from window
end type
type st_serial from statictext within w_about_template
end type
type st_db_version from statictext within w_about_template
end type
type p_1 from picture within w_about_template
end type
type st_address from statictext within w_about_template
end type
type cb_1 from commandbutton within w_about_template
end type
type st_copyright from statictext within w_about_template
end type
type st_version from statictext within w_about_template
end type
type st_app from statictext within w_about_template
end type
type gb_1 from groupbox within w_about_template
end type
type gb_2 from groupbox within w_about_template
end type
end forward

global type w_about_template from window
integer width = 1792
integer height = 868
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
string icon = "AppIcon!"
boolean center = true
st_serial st_serial
st_db_version st_db_version
p_1 p_1
st_address st_address
cb_1 cb_1
st_copyright st_copyright
st_version st_version
st_app st_app
gb_1 gb_1
gb_2 gb_2
end type
global w_about_template w_about_template

on w_about_template.create
this.st_serial=create st_serial
this.st_db_version=create st_db_version
this.p_1=create p_1
this.st_address=create st_address
this.cb_1=create cb_1
this.st_copyright=create st_copyright
this.st_version=create st_version
this.st_app=create st_app
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_serial,&
this.st_db_version,&
this.p_1,&
this.st_address,&
this.cb_1,&
this.st_copyright,&
this.st_version,&
this.st_app,&
this.gb_1,&
this.gb_2}
end on

on w_about_template.destroy
destroy(this.st_serial)
destroy(this.st_db_version)
destroy(this.p_1)
destroy(this.st_address)
destroy(this.cb_1)
destroy(this.st_copyright)
destroy(this.st_version)
destroy(this.st_app)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;/*
// ÅíçìÝñùóç text
	st_app.text = gs_app_name
	st_version.text = trn(267) +": " + gs_version_number + " (" + gs_version_date + ")"
	st_db_version.text = trn(269) + ": " + gs_dbver
	st_copyright.text = "Copyright " + gs_copyright_year + " - " + gs_copyright
	st_address.text = gs_company_address
	st_serial.text = "S/N: " + gs_serialnumber
	
*/

// Translation
	st_serial.text = trn(582)
	st_db_version.text = trn(268)
	cb_1.text = trn(699)
	st_copyright.text = trn(238)
	st_version.text = trn(267)
	st_app.text = trn(485)
	title = trn(624)
end event

type st_serial from statictext within w_about_template
integer x = 535
integer y = 348
integer width = 1166
integer height = 88
integer textsize = -9
integer weight = 700
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
long backcolor = 80269524
alignment alignment = center!
boolean focusrectangle = false
end type

type st_db_version from statictext within w_about_template
integer x = 535
integer y = 256
integer width = 1166
integer height = 88
integer textsize = -10
integer weight = 700
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 16711680
long backcolor = 80269524
alignment alignment = center!
boolean focusrectangle = false
end type

type p_1 from picture within w_about_template
integer x = 27
integer y = 44
integer width = 430
integer height = 428
string picturename = "D:\projects\share\res\ÕÐÏÓÔÇÑÉÎÇ.WMF"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_address from statictext within w_about_template
integer x = 544
integer y = 620
integer width = 1143
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 8388608
long backcolor = 80269524
string text = "Serres, phone: (2321)-41206"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_about_template
integer x = 27
integer y = 500
integer width = 430
integer height = 228
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "OK"
boolean cancel = true
boolean default = true
end type

event clicked;close(GetParent())
end event

type st_copyright from statictext within w_about_template
integer x = 544
integer y = 520
integer width = 1143
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 8388608
long backcolor = 80269524
alignment alignment = center!
boolean focusrectangle = false
end type

type st_version from statictext within w_about_template
integer x = 535
integer y = 164
integer width = 1166
integer height = 88
integer textsize = -12
integer weight = 700
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 16711680
long backcolor = 80269524
alignment alignment = center!
boolean focusrectangle = false
end type

type st_app from statictext within w_about_template
integer x = 535
integer y = 72
integer width = 1166
integer height = 88
integer textsize = -14
integer weight = 700
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
long backcolor = 80269524
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_about_template
integer x = 489
integer width = 1257
integer height = 456
integer taborder = 10
integer textsize = -14
integer weight = 700
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
long backcolor = 80269524
end type

type gb_2 from groupbox within w_about_template
integer x = 489
integer y = 444
integer width = 1257
integer height = 284
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long backcolor = 80269524
end type

