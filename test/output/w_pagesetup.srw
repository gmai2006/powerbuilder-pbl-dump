HA$PBExportHeader$w_pagesetup.srw
$PBExportComments$
forward
global type w_pagesetup from w_response
end type
type st_1 from statictext within w_pagesetup
end type
type st_2 from statictext within w_pagesetup
end type
type st_3 from statictext within w_pagesetup
end type
type st_4 from statictext within w_pagesetup
end type
type em_left from editmask within w_pagesetup
end type
type em_right from editmask within w_pagesetup
end type
type em_top from editmask within w_pagesetup
end type
type em_bottom from editmask within w_pagesetup
end type
type cb_printer from commandbutton within w_pagesetup
end type
type cbx_rulers from checkbox within w_pagesetup
end type
type gb_1 from groupbox within w_pagesetup
end type
end forward

global type w_pagesetup from w_response
integer width = 1257
integer height = 784
string title = "Page setup"
string icon = "res\print.ico"
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
em_left em_left
em_right em_right
em_top em_top
em_bottom em_bottom
cb_printer cb_printer
cbx_rulers cbx_rulers
gb_1 gb_1
end type
global w_pagesetup w_pagesetup

type variables
datawindow		idw_dw
integer		ii_printer

end variables

forward prototypes
public subroutine fn_modify ()
public subroutine fn_describe ()
protected function boolean of_buttonok ()
end prototypes

public subroutine fn_modify ();// ÁëëÜæïõìå ôéò ñõèìßóåéò ôïõ dw óýìöùíá ìå ôéò íÝåò ôéìÝò
	
idw_dw.SetRedraw(false)

// Ðåñéèþñéá
	double	ld_tmp
	em_left.GetData(ld_tmp)
	idw_dw.Modify("DataWindow.Print.Margin.Left = " + string(ld_tmp))
	em_right.GetData(ld_tmp)
	idw_dw.Modify("DataWindow.Print.Margin.right = " + string(ld_tmp))
	em_top.GetData(ld_tmp)
	idw_dw.Modify("DataWindow.Print.Margin.top = " + string(ld_tmp))
	em_bottom.GetData(ld_tmp)
	idw_dw.Modify("DataWindow.Print.Margin.bottom = " + string(ld_tmp))
	
// ×Üñáêåò
	if cbx_rulers.checked then
		idw_dw.modify("DataWindow.Print.Preview.Rulers = yes")
	else
		idw_dw.modify("DataWindow.Print.Preview.Rulers = no")
	end if

// Áí ôñïðïðïéÞóáìå ôéò ðáñáìÝôñïõò ôïõ åêôõðùôÞ
// áëëÜæïõìå ôç äéÜôáîç êáé ôç óåëßäá
	if ii_printer = 1 then
		idw_dw.Modify("Datawindow.print.orientation = 0")
		idw_dw.Modify("Datawindow.print.paper.size = 0")
	end if
	
idw_dw.SetRedraw(true)

end subroutine

public subroutine fn_describe ();// Ðáßñíïõìå ôéò ñõèìßóåéò ôïõ idw_dw êáé åíçìåñþíïõìå ôï ðáñÜèõñï

// Ðåñéèþñéá
	em_left.text = idw_dw.Describe("DataWindow.Print.Margin.Left")
	em_right.text = idw_dw.Describe("DataWindow.Print.Margin.right")
	em_top.text = idw_dw.Describe("DataWindow.Print.Margin.top")
	em_bottom.text = idw_dw.Describe("DataWindow.Print.Margin.bottom")
	
// ×Üñáêåò
	string	ls_rulers
	ls_rulers = idw_dw.Describe("DataWindow.Print.Preview.Rulers")
	if ls_rulers = "yes" then
		cbx_rulers.checked = true
	else
		cbx_rulers.checked = false
	end if

end subroutine

protected function boolean of_buttonok ();fn_modify()
return true
end function

on w_pagesetup.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.em_left=create em_left
this.em_right=create em_right
this.em_top=create em_top
this.em_bottom=create em_bottom
this.cb_printer=create cb_printer
this.cbx_rulers=create cbx_rulers
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.em_left
this.Control[iCurrent+6]=this.em_right
this.Control[iCurrent+7]=this.em_top
this.Control[iCurrent+8]=this.em_bottom
this.Control[iCurrent+9]=this.cb_printer
this.Control[iCurrent+10]=this.cbx_rulers
this.Control[iCurrent+11]=this.gb_1
end on

on w_pagesetup.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.em_left)
destroy(this.em_right)
destroy(this.em_top)
destroy(this.em_bottom)
destroy(this.cb_printer)
destroy(this.cbx_rulers)
destroy(this.gb_1)
end on

event open;call super::open;// Áðïèçêåýïõìå ôï dw
	idw_dw = Message.PowerObjectParm
	
// set focus to em_top
	em_top.SetFocus()
	
// Current describe 
	fn_describe()


end event

event close;call super::close;// Áí áëëÜîáìå ôïí default åêôõðùôÞ ôïí åðáíáöÝñïõìå

// Translation
	title = trn(230)
	st_1.text = trn(21) + ":"
	st_2.text = trn(385) + ":"
	st_3.text = trn(9) + ":"
	st_4.text = trn(11) + ":"
	cb_printer.text = trn(19) + "..."
	cbx_rulers.text = trn(680)
	gb_1.text = trn(528)
end event

type cb_cancel from w_response`cb_cancel within w_pagesetup
integer x = 379
integer y = 564
integer taborder = 90
end type

type cb_ok from w_response`cb_ok within w_pagesetup
integer x = 23
integer y = 564
integer taborder = 80
end type

event cb_ok::clicked;fn_modify()
CloseWithReturn(GetParent(), 1)
end event

type st_1 from statictext within w_pagesetup
integer x = 41
integer y = 88
integer width = 251
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 16711680
long backcolor = 67108864
string text = "ÅðÜíù"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pagesetup
integer x = 41
integer y = 200
integer width = 251
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_3 from statictext within w_pagesetup
integer x = 41
integer y = 312
integer width = 251
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_4 from statictext within w_pagesetup
integer x = 41
integer y = 424
integer width = 251
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type em_left from editmask within w_pagesetup
integer x = 338
integer y = 304
integer width = 197
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type em_right from editmask within w_pagesetup
integer x = 338
integer y = 416
integer width = 197
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type em_top from editmask within w_pagesetup
integer x = 338
integer y = 80
integer width = 197
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type em_bottom from editmask within w_pagesetup
integer x = 338
integer y = 192
integer width = 197
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type cb_printer from commandbutton within w_pagesetup
integer x = 635
integer y = 28
integer width = 571
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
end type

event clicked;ii_printer = PrintSetup( )

end event

type cbx_rulers from checkbox within w_pagesetup
integer x = 635
integer y = 188
integer width = 402
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_pagesetup
integer width = 594
integer height = 524
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
long backcolor = 67108864
end type

