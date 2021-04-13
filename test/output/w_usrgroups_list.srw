HA$PBExportHeader$w_usrgroups_list.srw
$PBExportComments$
forward
global type w_usrgroups_list from w_list
end type
end forward

global type w_usrgroups_list from w_list
integer width = 1550
integer height = 1504
string title = "title"
string is_tablename = "usrusers"
string is_formwin = "w_usrGroups_form"
boolean ib_editwithkey = true
boolean ib_retrieve = true
boolean ib_includewhere = true
boolean ib_sort = true
boolean ib_noview = true
end type
global w_usrgroups_list w_usrgroups_list

forward prototypes
protected subroutine of_struct2dw (ref datawindow adw, long row)
public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor)
protected subroutine of_reset_struct ()
protected subroutine of_init_struct ()
protected subroutine of_dw2struct (ref datawindow adw, long row)
public subroutine of_deleterow (ref datawindow adw, long row)
end prototypes

protected subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodgroup[row] = gsc_usrGroups.kodgroup
adw.object.descgroup[row] = gsc_usrGroups.descgroup
end subroutine

public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor);al_rowrcolor = rgb(221,238,238)
end subroutine

protected subroutine of_reset_struct ();setnull(gsc_usrGroups.kodgroup)
setnull(gsc_usrGroups.descgroup)
end subroutine

protected subroutine of_init_struct ();gsc_usrGroups.kodgroup = fn_getkey("usrGroups")
end subroutine

protected subroutine of_dw2struct (ref datawindow adw, long row);gsc_usrGroups.kodgroup = adw.object.kodgroup[row]
gsc_usrGroups.descgroup = adw.object.descgroup[row]
end subroutine

public subroutine of_deleterow (ref datawindow adw, long row);long		ll_kodgroup
ll_kodgroup = adw.object.kodgroup[row]

// ÄéáãñáöÞ óôïí usrGroups
	
	delete from usrgroups where kodgroup = :ll_kodgroup;
	fn_sqlerror()
	
// ÄéáãñáöÞ óôïõò óõíäåäåìÝíïõò ðßíáêåò
	
	delete from usrMembers where kodgroup = :ll_kodgroup;
	fn_sqlerror()
	
	delete from usrgroupPerm where kodgroup = :ll_kodgroup;
	fn_sqlerror()
	
	commit using sqlca;
end subroutine

on w_usrgroups_list.create
call super::create
end on

on w_usrgroups_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;// translation
	title = trn(482)
end event

type dw from w_list`dw within w_usrgroups_list
integer width = 1509
integer height = 1292
string dataobject = "dw_usrgroups_list"
end type

