HA$PBExportHeader$w_usrmembers_group_form.srw
$PBExportComments$
forward
global type w_usrmembers_group_form from w_form
end type
type gb_1 from groupbox within w_usrmembers_group_form
end type
end forward

global type w_usrmembers_group_form from w_form
integer width = 1947
integer height = 684
string title = "title"
string is_tablename = "usrusers"
gb_1 gb_1
end type
global w_usrmembers_group_form w_usrmembers_group_form

forward prototypes
public function boolean of_check4required (ref datawindow adw, long row)
public subroutine of_dw2struct (ref datawindow adw, long row)
public subroutine of_struct2dw (ref datawindow adw, long row)
end prototypes

public function boolean of_check4required (ref datawindow adw, long row);long		llong	

// koduser
	llong	= adw.object.koduser[row]
	if isnull(llong) then
		Messagebox(gs_app_name, trn(195))
		adw.setfocus()
		adw.setcolumn("koduser")
		return false
	end if
	
	
// everything ok
	return true
end function

public subroutine of_dw2struct (ref datawindow adw, long row);gsc_usrMembers.koduser = adw.object.koduser[row]
end subroutine

public subroutine of_struct2dw (ref datawindow adw, long row);adw.object.koduser[row] = gsc_usrMembers.koduser
end subroutine

on w_usrmembers_group_form.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on w_usrmembers_group_form.destroy
call super::destroy
destroy(this.gb_1)
end on

event open;call super::open;// translation
	title = trn(328)
end event

type cb_cancel from w_form`cb_cancel within w_usrmembers_group_form
integer x = 1577
integer y = 420
end type

type cb_ok from w_form`cb_ok within w_usrmembers_group_form
integer x = 1221
integer y = 420
end type

type dw_main from w_form`dw_main within w_usrmembers_group_form
integer x = 41
integer y = 68
integer width = 1829
integer height = 272
string dataobject = "edw_usrmembers_group_form"
end type

event dw_main::itemchanged;call super::itemchanged;string	ls_fullname
integer	li_isactive
long		ll_koduser

this.AcceptText()


choose case dwo.name
		
	case "koduser"
		ll_koduser = this.object.koduser[1]
		select fullname, isactive into :ls_fullname, :li_isactive
		from   usrusers where koduser = :ll_koduser;
		fn_sqlerror()
		
		this.object.fullname[1] = ls_fullname
		this.object.isactive[1] = li_isactive
		
		
end choose
end event

type gb_1 from groupbox within w_usrmembers_group_form
integer x = 23
integer width = 1870
integer height = 372
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

