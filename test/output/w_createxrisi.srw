HA$PBExportHeader$w_createxrisi.srw
$PBExportComments$
forward
global type w_createxrisi from w_response
end type
type dw from datawindow within w_createxrisi
end type
type gb_1 from groupbox within w_createxrisi
end type
end forward

global type w_createxrisi from w_response
integer width = 1499
integer height = 788
string title = "title"
string icon = "res\xrisi.ico"
dw dw
gb_1 gb_1
end type
global w_createxrisi w_createxrisi

forward prototypes
public function boolean if_check4required (ref datawindow adw, long row)
end prototypes

public function boolean if_check4required (ref datawindow adw, long row);string	lstring	
date		ldate

// kodxrisi
	lstring = adw.object.kodxrisi[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(188))
		adw.setfocus()
		adw.setcolumn("kodxrisi")
		return false
	end if

// descxrisi
	lstring = adw.object.descxrisi[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(181))
		adw.setfocus()
		adw.setcolumn("descxrisi")
		return false
	end if

// startdate
	ldate	= adw.object.startdate[row]
	if isnull(ldate) then
		Messagebox(gs_app_name, trn(168))
		adw.setfocus()
		adw.setcolumn("startdate")
		return false
	end if	
	
// enddate
	ldate	= adw.object.enddate[row]
	if isnull(ldate) then
		Messagebox(gs_app_name, trn(169))
		adw.setfocus()
		adw.setcolumn("enddate")
		return false
	end if	
	
// ¼ëá åíôÜîåé
	return true
end function

on w_createxrisi.create
int iCurrent
call super::create
this.dw=create dw
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw
this.Control[iCurrent+2]=this.gb_1
end on

on w_createxrisi.destroy
call super::destroy
destroy(this.dw)
destroy(this.gb_1)
end on

event open;call super::open;// Initialize dw
	dw.SetTransObject(sqlca)
	dw.InsertRow(0)
	dw.SetFocus()

// translation
	title = trn(219)
	
end event

type cb_cancel from w_response`cb_cancel within w_createxrisi
integer x = 1147
integer y = 556
end type

type cb_ok from w_response`cb_ok within w_createxrisi
integer x = 791
integer y = 556
end type

event cb_ok::clicked;// Check4Required
	dw.AcceptText()
	if not if_check4required(dw, 1) then return
	
// update dw êáé åðéóôñïöÞ ìå 1
	dw.update()
	commit using sqlca;
	closewithreturn(getparent(), 1)
end event

type dw from datawindow within w_createxrisi
integer x = 55
integer y = 60
integer width = 1376
integer height = 448
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_misth_zpxrisi_form"
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_createxrisi
integer x = 37
integer width = 1422
integer height = 516
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 33554432
long backcolor = 67108864
end type

