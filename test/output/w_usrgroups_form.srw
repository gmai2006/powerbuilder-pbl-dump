HA$PBExportHeader$w_usrgroups_form.srw
$PBExportComments$
forward
global type w_usrgroups_form from w_form_tab
end type
type uo_users from u_usrmembers_group_list within page1
end type
type dw_perm from datawindow within page2
end type
end forward

global type w_usrgroups_form from w_form_tab
integer width = 2053
integer height = 1676
boolean ib_update = true
string is_tablename = "usrusers"
end type
global w_usrgroups_form w_usrgroups_form

type variables
long		il_kodgroup

datawindow	idw_users
datawindow	idw_perm
end variables

forward prototypes
protected subroutine of_open ()
protected subroutine of_storekey ()
protected subroutine of_update ()
protected subroutine of_retrieve ()
protected subroutine of_settransactions ()
public subroutine of_struct2dw (ref datawindow adw, long row)
public subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_accepttext ()
public function boolean of_check4required (ref datawindow adw, long row)
public subroutine of_disabledws ()
protected subroutine of_insertrows ()
end prototypes

protected subroutine of_open ();idw_main = tab1.page1.dw_main
idw_users = tab1.page1.uo_users.dw
idw_perm = tab1.page2.dw_perm

// parent window
	tab1.page1.uo_users.iw_parent = this
end subroutine

protected subroutine of_storekey ();il_kodgroup = gsc_usrGroups.kodgroup
end subroutine

protected subroutine of_update ();idw_main.update()
idw_users.update()
idw_perm.update()

COMMIT USING SQLCA;
end subroutine

protected subroutine of_retrieve ();idw_main.retrieve(string(il_kodgroup))
idw_users.retrieve(string(il_kodgroup))

// Áí ôï dw_perm äåí Ý÷åé åããñáöÝò, ðñïóèÝôïõìå áðü ôïí usrActions
	long	ll_rows, i, ll_newrow
	datastore	lds_usrActions
	
	ll_rows = idw_perm.retrieve(string(il_kodgroup))
	
	if ll_rows = 0 then
		lds_usrActions = fn_createds("dw_usrActions_list")
		ll_rows = lds_usrActions.retrieve()
		for i = 1 to ll_rows
			ll_newrow = idw_perm.insertrow(0)
			idw_perm.object.kodgroup[ll_newrow] = il_kodgroup
			idw_perm.object.kodaction[ll_newrow] = lds_usrActions.object.kodaction[i]
			idw_perm.object.editrec[ll_newrow] = 0
			idw_perm.object.addrec[ll_newrow] = 0
			idw_perm.object.delrec[ll_newrow] = 0
			idw_perm.object.openlist[ll_newrow] = 0
			idw_perm.object.openform[ll_newrow] = 0
			idw_perm.object.usrActions_descaction[ll_newrow] = lds_usrActions.object.descaction[i]
			idw_perm.object.usrApps_descapp[ll_newrow] = lds_usrActions.object.usrApps_descapp[i]
		next
	end if
	
	destroy lds_usrActions
end subroutine

protected subroutine of_settransactions ();idw_main.SetTransObject(SQLCA)
idw_users.SetTransObject(SQLCA)
idw_perm.SetTransObject(SQLCA)
end subroutine

public subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodgroup[row] = gsc_usrGroups.kodgroup
adw.object.descgroup[row] = gsc_usrGroups.descgroup
end subroutine

public subroutine of_dw2struct (ref datawindow adw, long row);gsc_usrGroups.kodgroup = adw.object.kodgroup[row]
gsc_usrGroups.descgroup = adw.object.descgroup[row] 
end subroutine

protected subroutine of_accepttext ();idw_main.AcceptText()
idw_users.AcceptText()
idw_perm.AcceptText()
end subroutine

public function boolean of_check4required (ref datawindow adw, long row);string	lstring	

// descgroup
	lstring = adw.object.descgroup[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(178))
		adw.setfocus()
		adw.setcolumn("descgroup")
		return false
	end if
	
	// ¸ëåã÷ïò áí ôï descgroup õðÜñ÷åé (unique index)
		long	ll_count
		select count(kodgroup) into :ll_count from usrgroups
		where kodgroup <> :il_kodgroup and descgroup = :lstring;
		fn_sqlerror()
		if ll_count > 0 then
			Messagebox(gs_app_name, trn(354) + " '" + lstring + "' " + trn(658))
			adw.setfocus()
			adw.setcolumn("descgroup")
			return false
		end if			


// everything ok
	return true
end function

public subroutine of_disabledws ();idw_main.enabled = false
idw_users.enabled = false
idw_perm.enabled = false
end subroutine

protected subroutine of_insertrows ();idw_main.InsertRow(0)

// ÐñïóèÝôïõìå åããñáöÝò óôï idw_perm áðü usrActions
	
	long	ll_rows, i, ll_newrow
	datastore	lds_usrActions
	

	lds_usrActions = fn_createds("dw_usrActions_list")
	
	ll_rows = lds_usrActions.retrieve()
	
	for i = 1 to ll_rows
		ll_newrow = idw_perm.insertrow(0)
		idw_perm.object.kodgroup[ll_newrow] = il_kodgroup
		idw_perm.object.kodaction[ll_newrow] = lds_usrActions.object.kodaction[i]
		idw_perm.object.editrec[ll_newrow] = 0
		idw_perm.object.addrec[ll_newrow] = 0
		idw_perm.object.delrec[ll_newrow] = 0
		idw_perm.object.openlist[ll_newrow] = 0
		idw_perm.object.openform[ll_newrow] = 0
		idw_perm.object.usrActions_descaction[ll_newrow] = lds_usrActions.object.descaction[i]
		idw_perm.object.usrApps_descapp[ll_newrow] = lds_usrActions.object.usrApps_descapp[i]
	next

	
	destroy lds_usrActions
end subroutine

on w_usrgroups_form.create
int iCurrent
call super::create
end on

on w_usrgroups_form.destroy
call super::destroy
end on

event open;call super::open;// ÐñïóáñìïãÞ ôßôëïõ
	string	ls_title
	if ib_newrec then
		ls_title = trn(462)
	else
		ls_title = trn(481) + ": " + idw_main.object.descgroup[1]
	end if
	
	this.title = ls_title
end event

type tab1 from w_form_tab`tab1 within w_usrgroups_form
integer x = 23
integer width = 1989
integer height = 1368
end type

type page1 from w_form_tab`page1 within tab1
integer y = 48
integer width = 1952
integer height = 1304
string text = ""
uo_users uo_users
end type

on page1.create
this.uo_users=create uo_users
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_users
end on

on page1.destroy
call super::destroy
destroy(this.uo_users)
end on

type dw_main from w_form_tab`dw_main within page1
integer width = 1934
integer height = 96
string dataobject = "dw_usrgroups_form"
end type

type page2 from w_form_tab`page2 within tab1
integer y = 48
integer width = 1952
integer height = 1304
string text = ""
dw_perm dw_perm
end type

on page2.create
this.dw_perm=create dw_perm
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_perm
end on

on page2.destroy
call super::destroy
destroy(this.dw_perm)
end on

type cb_cancel from w_form_tab`cb_cancel within w_usrgroups_form
integer x = 1701
integer y = 1412
end type

type cb_ok from w_form_tab`cb_ok within w_usrgroups_form
integer x = 1344
integer y = 1412
end type

type uo_users from u_usrmembers_group_list within page1
integer x = 23
integer y = 152
integer taborder = 50
boolean bringtotop = true
end type

on uo_users.destroy
call u_usrmembers_group_list::destroy
end on

type dw_perm from datawindow within page2
integer x = 23
integer y = 28
integer width = 1902
integer height = 1188
integer taborder = 30
string title = "none"
string dataobject = "dw_usrgroupperm_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

