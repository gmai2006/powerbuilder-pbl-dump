HA$PBExportHeader$w_usrusers_form.srw
$PBExportComments$
forward
global type w_usrusers_form from w_form_tab
end type
type dw_perm from datawindow within page1
end type
type st_1 from statictext within page1
end type
type gb_1 from groupbox within page1
end type
type uo_groups from u_usrusers_groups_sel within page2
end type
end forward

global type w_usrusers_form from w_form_tab
integer width = 1893
integer height = 1788
boolean ib_update = true
string is_tablename = "usrusers"
end type
global w_usrusers_form w_usrusers_form

type variables
long					il_koduser

datawindow		idw_perm

end variables

forward prototypes
protected subroutine of_open ()
protected subroutine of_storekey ()
protected subroutine of_accepttext ()
public function boolean of_check4required (ref datawindow adw, long row)
public subroutine of_disabledws ()
public subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_insertrows ()
protected subroutine of_retrieve ()
protected subroutine of_settransactions ()
public subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_update ()
end prototypes

protected subroutine of_open ();idw_main = tab1.page1.dw_main
idw_perm = tab1.page1.dw_perm

tab1.page2.uo_groups.iw_parent = this

end subroutine

protected subroutine of_storekey ();il_koduser = gsc_usrusers.koduser
end subroutine

protected subroutine of_accepttext ();// Accept text for all dw's
	idw_main.AcceptText()
	idw_perm.AcceptText()

end subroutine

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
		where koduser <> :il_koduser and username = :lstring;
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

public subroutine of_disabledws ();idw_main.enabled = false
idw_perm.enabled = false
tab1.page2.uo_groups.enabled = false
end subroutine

public subroutine of_dw2struct (ref datawindow adw, long row);gsc_usrusers.koduser = adw.object.koduser[row]
gsc_usrusers.username = adw.object.username[row]
gsc_usrusers.fullname = adw.object.fullname[row]
gsc_usrusers.password = adw.object.password[row]
gsc_usrusers.isactive = adw.object.isactive[row]
gsc_usrusers.tomeas = adw.object.tomeas[row]
gsc_usrusers.idiotita = adw.object.idiotita[row]
end subroutine

protected subroutine of_insertrows ();// ÅéóáãùãÞ ãñáììþí óôá dw's
	idw_main.InsertRow(0)
	
// Óôï dw_perm åéóáãùãÞ üëùí ôùí åããñáöþí áðü usrApps
	long	ll_rows, i, ll_newrow
	datastore	lds_usrApps

	lds_usrApps = fn_createds("dw_usrApps_list")
	ll_rows = lds_usrApps.retrieve()
	
	for i = 1 to ll_rows
			ll_newrow = idw_perm.insertrow(0)
			idw_perm.object.kodapp[ll_newrow] = lds_usrApps.object.kodapp[i]
			idw_perm.object.koduser[ll_newrow] = il_koduser
			idw_perm.object.enable[ll_newrow] = 0
			idw_perm.object.usrapps_descapp[ll_newrow] = lds_usrApps.object.descapp[i]
	next
	
	destroy lds_usrApps

end subroutine

protected subroutine of_retrieve ();idw_main.retrieve(string(il_koduser))

// Áí ôï dw_perm äåí Ý÷åé åããñáöÝò, ðñïóèÝôïõìå áðü ôïí usrApps
	long	ll_rows, i, ll_newrow
	datastore	lds_usrApps
	
	ll_rows = idw_perm.retrieve(string(il_koduser))
	
	if ll_rows = 0 then
		lds_usrApps = fn_createds("dw_usrApps_list")
		ll_rows = lds_usrApps.retrieve()
		for i = 1 to ll_rows
			ll_newrow = idw_perm.insertrow(0)
			idw_perm.object.kodapp[ll_newrow] = lds_usrApps.object.kodapp[i]
			idw_perm.object.koduser[ll_newrow] = il_koduser
			idw_perm.object.enable[ll_newrow] = 0
			idw_perm.object.usrapps_descapp[ll_newrow] = lds_usrApps.object.descapp[i]
		next
	end if
	destroy lds_usrApps

end subroutine

protected subroutine of_settransactions ();// Set Transaction for all dw's
	idw_main.SetTransObject(SQLCA)
	idw_perm.SetTransObject(SQLCA)
end subroutine

public subroutine of_struct2dw (ref datawindow adw, long row);adw.object.koduser[row] = gsc_usrusers.koduser
adw.object.username[row] = gsc_usrusers.username
adw.object.fullname[row] = gsc_usrusers.fullname
adw.object.password[row] = gsc_usrusers.password
adw.object.isactive[row] = gsc_usrusers.isactive
adw.object.tomeas[row] = gsc_usrusers.tomeas
adw.object.idiotita[row] = gsc_usrusers.idiotita
end subroutine

protected subroutine of_update ();idw_main.update()
idw_perm.update()
tab1.page2.uo_groups.triggerevent("ie_update")

commit using sqlca;
end subroutine

on w_usrusers_form.create
int iCurrent
call super::create
end on

on w_usrusers_form.destroy
call super::destroy
end on

event open;call super::open;// ÐñïóáñìïãÞ ôßôëïõ
	string	ls_title
	if ib_newrec then
		ls_title = trn(463)
	else
		ls_title = trn(685) + ": " + idw_main.object.username[1]
	end if
	
	this.title = ls_title
	
// retrieve uo_groups
	tab1.page2.uo_groups.triggerevent("ie_retrieve")	
end event

type tab1 from w_form_tab`tab1 within w_usrusers_form
integer x = 18
integer width = 1838
integer height = 1488
integer textsize = -8
end type

type page1 from w_form_tab`page1 within tab1
integer y = 48
integer width = 1801
integer height = 1424
string text = ""
dw_perm dw_perm
st_1 st_1
gb_1 gb_1
end type

on page1.create
this.dw_perm=create dw_perm
this.st_1=create st_1
this.gb_1=create gb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_perm
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.gb_1
end on

on page1.destroy
call super::destroy
destroy(this.dw_perm)
destroy(this.st_1)
destroy(this.gb_1)
end on

type dw_main from w_form_tab`dw_main within page1
integer x = 46
integer y = 60
integer width = 1701
integer height = 460
string dataobject = "dw_usrusers_form"
end type

type page2 from w_form_tab`page2 within tab1
integer y = 48
integer width = 1801
integer height = 1424
string text = ""
uo_groups uo_groups
end type

on page2.create
this.uo_groups=create uo_groups
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_groups
end on

on page2.destroy
call super::destroy
destroy(this.uo_groups)
end on

type cb_cancel from w_form_tab`cb_cancel within w_usrusers_form
integer x = 1541
integer y = 1544
end type

type cb_ok from w_form_tab`cb_ok within w_usrusers_form
integer x = 1184
integer y = 1544
end type

type dw_perm from datawindow within page1
integer x = 18
integer y = 652
integer width = 1760
integer height = 692
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_usruserperm_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within page1
integer x = 18
integer y = 564
integer width = 507
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

type gb_1 from groupbox within page1
integer x = 18
integer y = 8
integer width = 1760
integer height = 532
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

type uo_groups from u_usrusers_groups_sel within page2
integer x = 18
integer y = 8
integer width = 1774
integer taborder = 40
end type

on uo_groups.destroy
call u_usrusers_groups_sel::destroy
end on

