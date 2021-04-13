HA$PBExportHeader$u_usrusers_groups_sel.sru
$PBExportComments$
forward
global type u_usrusers_groups_sel from ucv_selection
end type
end forward

global type u_usrusers_groups_sel from ucv_selection
integer height = 1352
end type
global u_usrusers_groups_sel u_usrusers_groups_sel

type variables
w_usrusers_form		iw_parent
end variables

forward prototypes
public function boolean of_match (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row)
public subroutine of_retrieve_target (ref datawindow adw)
public subroutine of_source2target (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row)
public subroutine of_target2source (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row)
end prototypes

public function boolean of_match (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row);if source_dw.object.kodgroup[source_row] = target_dw.object.kodgroup[target_row] then
	return true
else
	return false
end if
end function

public subroutine of_retrieve_target (ref datawindow adw);adw.retrieve(string(iw_parent.il_koduser))
end subroutine

public subroutine of_source2target (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row);long	ll_kodgroup
ll_kodgroup = source_dw.object.kodgroup[source_row]

// Ðáßñíïõìå êáé ôçí ðåñéãñáöÞ
	string	ls_descgroup
	select descgroup into :ls_descgroup
	from   usrgroups where kodgroup = :ll_kodgroup;
	fn_sqlerror()
	
target_dw.object.kodgroup[target_row] = source_dw.object.kodgroup[source_row]
target_dw.object.usrgroups_descgroup[target_row] = ls_descgroup
target_dw.object.koduser[target_row] = iw_parent.il_koduser

end subroutine

public subroutine of_target2source (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row);long	ll_kodgroup
ll_kodgroup = target_dw.object.kodgroup[target_row]

// Ðáßñíïõìå êáé ôçí ðåñéãñáöÞ
	string	ls_descgroup
	select descgroup into :ls_descgroup
	from   usrgroups where kodgroup = :ll_kodgroup;
	fn_sqlerror()
	

source_dw.object.kodgroup[source_row] = target_dw.object.kodgroup[target_row]
source_dw.object.descgroup[source_row] = ls_descgroup
end subroutine

on u_usrusers_groups_sel.create
call super::create
end on

on u_usrusers_groups_sel.destroy
call super::destroy
end on

type st_target from ucv_selection`st_target within u_usrusers_groups_sel
string text = trn(315)
end type

type st_source from ucv_selection`st_source within u_usrusers_groups_sel
string text = trn(482)
end type

type cb_remove_all from ucv_selection`cb_remove_all within u_usrusers_groups_sel
end type

type cb_remove_one from ucv_selection`cb_remove_one within u_usrusers_groups_sel
end type

type cb_add_all from ucv_selection`cb_add_all within u_usrusers_groups_sel
end type

type cb_add_one from ucv_selection`cb_add_one within u_usrusers_groups_sel
end type

type dw_target from ucv_selection`dw_target within u_usrusers_groups_sel
integer height = 1244
string dataobject = "dw_usrmembers_user_list"
end type

type dw_source from ucv_selection`dw_source within u_usrusers_groups_sel
integer height = 1244
string dataobject = "pick_usrgroups"
end type

