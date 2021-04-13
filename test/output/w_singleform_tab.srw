HA$PBExportHeader$w_singleform_tab.srw
$PBExportComments$
forward
global type w_singleform_tab from w_response
end type
type tab1 from tab within w_singleform_tab
end type
type page1 from userobject within tab1
end type
type dw_main from datawindow within page1
end type
type page1 from userobject within tab1
dw_main dw_main
end type
type tab1 from tab within w_singleform_tab
page1 page1
end type
end forward

global type w_singleform_tab from w_response
integer width = 2194
integer height = 1500
string title = ""
tab1 tab1
end type
global w_singleform_tab w_singleform_tab

type variables
datawindow		idw_main
end variables

forward prototypes
public subroutine of_open ()
public subroutine of_retrieve ()
public subroutine of_update ()
public subroutine of_accepttext ()
public function boolean of_check4required (ref datawindow adw, long row)
public subroutine of_settransactions ()
public subroutine of_sharedws ()
public subroutine of_setmasks ()
end prototypes

public subroutine of_open ();// ÁìÝóùò ìåôÜ ôï Üíïéãìá

	idw_main = tab1.page1.dw_main
end subroutine

public subroutine of_retrieve ();// Override áí áðáéôïýíôáé retrieval arguments
	idw_main.retrieve()
end subroutine

public subroutine of_update ();// Override if more dw's
	idw_main.update()
	commit using sqlca;
end subroutine

public subroutine of_accepttext ();idw_main.accepttext()
end subroutine

public function boolean of_check4required (ref datawindow adw, long row);/*
string	lstring	
long		llong	
date		ldate
time		ltime

// string
	lstring = adw.object.xxx[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, "....")
		adw.setfocus()
		adw.setcolumn("xxx")
		return false
	end if

// long
	llong	= adw.object.xxx[row]
	if isnull(llong) then
		Messagebox(gs_app_name, "....")
		adw.setfocus()
		adw.setcolumn("xxx")
		return false
	end if
	
// date
	ldate	= adw.object.xxx[row]
	if isnull(ldate) then
		Messagebox(gs_app_name, ".....")
		adw.setfocus()
		adw.setcolumn("xxx")
		return false
	end if	
	
// time
	ltime	= adw.object.xxx[row]
	if isnull(ltime) then
		Messagebox(gs_app_name, "....")
		adw.setfocus()
		adw.setcolumn("xxx")
		return false
	end if	

*/
	
// everything ok
	return true
end function

public subroutine of_settransactions ();idw_main.settransobject(sqlca)
end subroutine

public subroutine of_sharedws ();// shared datawindows go here
end subroutine

public subroutine of_setmasks ();// set edit masks

// 	example
//	fn_seteditmask(idw_main, "xxxxx", fn_param_maskdate_e())



end subroutine

on w_singleform_tab.create
int iCurrent
call super::create
this.tab1=create tab1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab1
end on

on w_singleform_tab.destroy
call super::destroy
destroy(this.tab1)
end on

event open;call super::open;of_open()

// Set transactions for all dw's
	of_settransactions()

// retrieve
	of_retrieve()
	
// set share
	of_sharedws()
	
// set edit masks
	
	
end event

type cb_cancel from w_response`cb_cancel within w_singleform_tab
integer x = 1833
integer y = 1268
end type

type cb_ok from w_response`cb_ok within w_singleform_tab
integer x = 1477
integer y = 1268
end type

event cb_ok::clicked;// Update dw_main & return
	of_accepttext()
	if not of_check4required(idw_main, 1) then return
	of_update()
	
	closeWithReturn(getparent(), 1)
end event

type tab1 from tab within w_singleform_tab
event create ( )
event destroy ( )
integer x = 23
integer y = 28
integer width = 2126
integer height = 1200
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
page1 page1
end type

on tab1.create
this.page1=create page1
this.Control[]={this.page1}
end on

on tab1.destroy
destroy(this.page1)
end on

type page1 from userobject within tab1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2089
integer height = 1080
long backcolor = 67108864
string text = "none"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
dw_main dw_main
end type

on page1.create
this.dw_main=create dw_main
this.Control[]={this.dw_main}
end on

on page1.destroy
destroy(this.dw_main)
end on

type dw_main from datawindow within page1
integer x = 46
integer y = 52
integer width = 1993
integer height = 992
integer taborder = 20
string title = "none"
boolean border = false
boolean livescroll = true
end type

