HA$PBExportHeader$w_setadmin.srw
$PBExportComments$
forward
global type w_setadmin from w_singleform
end type
type gb_1 from groupbox within w_setadmin
end type
end forward

global type w_setadmin from w_singleform
integer width = 1765
integer height = 876
string title = ""
gb_1 gb_1
end type
global w_setadmin w_setadmin

forward prototypes
public function boolean of_check4required (ref datawindow adw, long row)
end prototypes

public function boolean of_check4required (ref datawindow adw, long row);string	lstring	
long		llong	

// username
	lstring = adw.object.username[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(185))
		adw.setfocus()
		adw.setcolumn("username")
		return false
	end if
	
	// ¸ëåã÷ïò áí ï ÷ñÞóôçò õðÜñ÷åé Þäç
		long	ll_count
		select count(koduser) into :ll_count from usrusers
		where koduser <> -1 and username = :lstring;
		if ll_count > 0 then
			Messagebox(gs_app_name, trn(467) + " '" + lstring + "' " + trn(658))
			adw.setfocus()
			adw.setcolumn("username")
			return false
		end if	
			
// password
	lstring = adw.object.password[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(189))
		adw.setfocus()
		adw.setcolumn("password")
		return false
	end if	
	
// everything ok
	return true
end function

on w_setadmin.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on w_setadmin.destroy
call super::destroy
destroy(this.gb_1)
end on

type cb_cancel from w_singleform`cb_cancel within w_setadmin
integer x = 1399
integer y = 628
end type

type cb_ok from w_singleform`cb_ok within w_setadmin
integer x = 1042
integer y = 628
end type

type dw_main from w_singleform`dw_main within w_setadmin
integer x = 73
integer y = 76
integer width = 1614
integer height = 456
string dataobject = "dw_usrusers_admin_form"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type gb_1 from groupbox within w_setadmin
integer x = 37
integer y = 16
integer width = 1678
integer height = 560
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

