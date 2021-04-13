HA$PBExportHeader$w_printer.srw
$PBExportComments$
forward
global type w_printer from window
end type
type cbx_1 from checkbox within w_printer
end type
type st_4 from statictext within w_printer
end type
type ddlb_pages from dropdownlistbox within w_printer
end type
type cb_3 from commandbutton within w_printer
end type
type cb_2 from commandbutton within w_printer
end type
type cb_1 from commandbutton within w_printer
end type
type sle_1 from singlelineedit within w_printer
end type
type mle_1 from multilineedit within w_printer
end type
type rb_3 from radiobutton within w_printer
end type
type rb_2 from radiobutton within w_printer
end type
type rb_1 from radiobutton within w_printer
end type
type em_1 from editmask within w_printer
end type
type st_3 from statictext within w_printer
end type
type st_2 from statictext within w_printer
end type
type st_1 from statictext within w_printer
end type
type gb_2 from groupbox within w_printer
end type
type gb_1 from groupbox within w_printer
end type
end forward

global type w_printer from window
integer x = 837
integer y = 612
integer width = 1993
integer height = 1148
boolean titlebar = true
string title = "Printer"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
string icon = "res\print.ico"
boolean center = true
cbx_1 cbx_1
st_4 st_4
ddlb_pages ddlb_pages
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
sle_1 sle_1
mle_1 mle_1
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
em_1 em_1
st_3 st_3
st_2 st_2
st_1 st_1
gb_2 gb_2
gb_1 gb_1
end type
global w_printer w_printer

type variables
datawindow idw_requestor

end variables

on w_printer.create
this.cbx_1=create cbx_1
this.st_4=create st_4
this.ddlb_pages=create ddlb_pages
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_1=create sle_1
this.mle_1=create mle_1
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.em_1=create em_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cbx_1,&
this.st_4,&
this.ddlb_pages,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.sle_1,&
this.mle_1,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.em_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.gb_2,&
this.gb_1}
end on

on w_printer.destroy
destroy(this.cbx_1)
destroy(this.st_4)
destroy(this.ddlb_pages)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.mle_1)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;idw_requestor = Message.PowerObjectParm

// Add items into ddlb_pages
	ddlb_pages.Additem(trn(480))
	ddlb_pages.Additem(trn(352))
	ddlb_pages.Additem(trn(451))

// ÅíçìÝñùóç ðáñáèýñïõ
	st_2.Text = idw_requestor.Object.DataWindow.Printer
	ddlb_pages.Text = trn(480)
	
	em_1.SetFocus( )
	em_1.SelectText(1,Len(em_1.Text))

end event

event close;// translation
	cbx_1.text = trn(697)
	st_4.text = trn(271) + ":"
	cb_3.text = trn(19) + "..."
	cb_2.text = trn(1)
	cb_1.text = trn(699)
	mle_1.text = trn(536)
	rb_3.text = trn(44) + ":"
	rb_2.text = trn(648)
	rb_1.text = trn(468)
	st_3.text = trn(81) + ":"
	st_1.text = trn(277) + ":"
	gb_2.text = trn(533)
	gb_1.text = trn(277)
end event

type cbx_1 from checkbox within w_printer
integer x = 1307
integer y = 664
integer width = 539
integer height = 76
integer taborder = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
string text = "ÓõññáöÞ"
boolean checked = true
end type

type st_4 from statictext within w_printer
integer x = 55
integer y = 940
integer width = 251
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
string text = "Åêôýðùóç"
boolean focusrectangle = false
end type

type ddlb_pages from dropdownlistbox within w_printer
integer x = 343
integer y = 936
integer width = 859
integer height = 292
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_printer
integer x = 1376
integer y = 500
integer width = 416
integer height = 96
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&ÅêôõðùôÞò"
end type

event clicked;If PrintSetup( ) = 1 Then 
	st_2.Text = idw_requestor.Object.DataWindow.Printer
	// Îáíáêáèïñßæïõìå ôïõò ðáñáìÝôñïõò åêôýðùóçò
end if

end event

type cb_2 from commandbutton within w_printer
integer x = 1376
integer y = 392
integer width = 416
integer height = 96
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "¢êõñï"
boolean cancel = true
end type

event clicked;Close(getparent())
end event

type cb_1 from commandbutton within w_printer
integer x = 1376
integer y = 284
integer width = 416
integer height = 96
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
boolean default = true
end type

event clicked;string	ls_range, ls_curpage
boolean	lb_passed
integer	li_page, li_include
long		ll_job
double	ldbl_copies


If rb_1.Checked Then
	idw_requestor.Object.DataWindow.Print.Page.Range = ''
	lb_passed = True
Else
	If rb_2.Checked Then
		ls_curpage = idw_requestor.Describe ("evaluate ('Page()', 1)")
		idw_requestor.Object.DataWindow.Print.Page.Range = ls_curpage
		lb_passed = True
	Else
		If rb_3.Checked Then
			ls_range = Trim(sle_1.Text)
			If IsNull(ls_range) Or ls_range = '' Then
				MessageBox('ERROR : Print Range','This is not a valid print range.',Exclamation!)
				lb_passed = False
			Else
				idw_requestor.Object.DataWindow.Print.Page.Range = Trim(sle_1.Text)
				lb_passed = True
			End If
		End If
	End If
End If

If lb_passed Then
	If cbx_1.Checked Then
		idw_requestor.Object.DataWindow.Print.Collate = True
	Else
		idw_requestor.Object.DataWindow.Print.Collate = False
	End If
	
	Choose Case Trim(ddlb_pages.Text)
		Case trn(480)
			li_include = 0
		Case trn(352)
			li_include = 1
		Case trn(451)
			li_include = 2
	End Choose
	idw_requestor.Object.DataWindow.Print.Quality = 0
	idw_requestor.Object.DataWindow.Print.Page.RangeInclude = li_include
	em_1.GetData(ldbl_copies)
	idw_requestor.Object.DataWindow.Print.Copies = string(ldbl_copies)
	idw_requestor.Print( )
End If

Close(getparent())

end event

type sle_1 from singlelineedit within w_printer
integer x = 434
integer y = 644
integer width = 722
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event getfocus;rb_3.Checked = True
end event

type mle_1 from multilineedit within w_printer
integer x = 128
integer y = 744
integer width = 1024
integer height = 120
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean border = false
end type

type rb_3 from radiobutton within w_printer
integer x = 128
integer y = 644
integer width = 288
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
end type

event clicked;sle_1.SetFocus( )
end event

event getfocus;sle_1.SetFocus( )
end event

type rb_2 from radiobutton within w_printer
integer x = 128
integer y = 552
integer width = 494
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
end type

type rb_1 from radiobutton within w_printer
integer x = 128
integer y = 460
integer width = 251
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean checked = true
end type

type em_1 from editmask within w_printer
integer x = 347
integer y = 268
integer width = 247
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
string text = "1"
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean spin = true
string displaydata = "~r"
double increment = 1
end type

type st_3 from statictext within w_printer
integer x = 59
integer y = 272
integer width = 279
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
long bordercolor = 79741120
boolean focusrectangle = false
end type

type st_2 from statictext within w_printer
integer x = 485
integer y = 116
integer width = 1376
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_1 from statictext within w_printer
integer x = 174
integer y = 116
integer width = 274
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_printer
integer x = 55
integer y = 384
integer width = 1147
integer height = 516
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 79741120
end type

type gb_1 from groupbox within w_printer
integer x = 59
integer y = 44
integer width = 1847
integer height = 184
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 79741120
end type

