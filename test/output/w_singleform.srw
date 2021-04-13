HA$PBExportHeader$w_singleform.srw
$PBExportComments$
forward
global type w_singleform from w_response
end type
type dw_main from datawindow within w_singleform
end type
end forward

global type w_singleform from w_response
integer height = 1204
string title = "title"
dw_main dw_main
end type
global w_singleform w_singleform

forward prototypes
public subroutine of_open ()
public subroutine of_retrieve ()
public subroutine of_update ()
public subroutine of_accepttext ()
public function boolean of_check4required (ref datawindow adw, long row)
end prototypes

public subroutine of_open ();// ÁìÝóùò ìåôÜ ôï Üíïéãìá
end subroutine

public subroutine of_retrieve ();// Override áí áðáéôïýíôáé retrieval arguments
	dw_main.retrieve()
end subroutine

public subroutine of_update ();// Override if more dw's
	dw_main.update()
	commit using sqlca;
end subroutine

public subroutine of_accepttext ();dw_main.accepttext()
end subroutine

public function boolean of_check4required (ref datawindow adw, long row);/*
string	lstring	
long		llong	
date		ldate
time		ltime

// string
	lstring = adw.object.xxx[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, ".....")
		adw.setfocus()
		adw.setcolumn("xxx")
		return false
	end if

// long
	llong	= adw.object.xxx[row]
	if isnull(llong) then
		Messagebox(gs_app_name, ".....")
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

on w_singleform.create
int iCurrent
call super::create
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
end on

on w_singleform.destroy
call super::destroy
destroy(this.dw_main)
end on

event open;call super::open;of_open()

// Initialize dw_main
	dw_main.SetTransObject(SQLCA)

// retrieve
	of_retrieve()
	
// translation
	title = trn(503)
end event

type cb_cancel from w_response`cb_cancel within w_singleform
integer y = 972
end type

type cb_ok from w_response`cb_ok within w_singleform
integer y = 972
end type

event cb_ok::clicked;// Update dw_main & return
	of_accepttext()
	if not of_check4required(dw_main, 1) then return
	of_update()
	
	closeWithReturn(getparent(), 1)
end event

type dw_main from datawindow within w_singleform
integer x = 27
integer y = 28
integer width = 1408
integer height = 888
integer taborder = 10
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

