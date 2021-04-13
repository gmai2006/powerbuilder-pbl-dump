HA$PBExportHeader$w_usrusers_list.srw
$PBExportComments$
forward
global type w_usrusers_list from w_list
end type
end forward

global type w_usrusers_list from w_list
integer width = 2304
integer height = 1616
string title = "title"
string is_tablename = "usrusers"
string is_formwin = "w_usrusers_form"
boolean ib_editwithkey = true
boolean ib_retrieve = true
boolean ib_sort = true
boolean ib_noview = true
end type
global w_usrusers_list w_usrusers_list

forward prototypes
protected subroutine of_reset_struct ()
protected subroutine of_init_struct ()
protected subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_dw2struct (ref datawindow adw, long row)
public subroutine of_deleterow (ref datawindow adw, long row)
public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor)
end prototypes

protected subroutine of_reset_struct ();setnull(gsc_usrusers.koduser)
setnull(gsc_usrusers.username)
setnull(gsc_usrusers.fullname)
setnull(gsc_usrusers.password)
setnull(gsc_usrusers.isactive)
setnull(gsc_usrusers.tomeas)
setnull(gsc_usrusers.idiotita)
end subroutine

protected subroutine of_init_struct ();gsc_usrusers.koduser = fn_getkey("usrusers")
gsc_usrusers.isactive = 1
end subroutine

protected subroutine of_struct2dw (ref datawindow adw, long row);adw.object.koduser[row] = gsc_usrusers.koduser
adw.object.username[row] = gsc_usrusers.username
adw.object.fullname[row] = gsc_usrusers.fullname
adw.object.password[row] = gsc_usrusers.password
adw.object.isactive[row] = gsc_usrusers.isactive
adw.object.tomeas[row] = gsc_usrusers.tomeas
adw.object.idiotita[row] = gsc_usrusers.idiotita
end subroutine

protected subroutine of_dw2struct (ref datawindow adw, long row);gsc_usrusers.koduser = adw.object.koduser[row]
gsc_usrusers.username = adw.object.username[row]
gsc_usrusers.fullname = adw.object.fullname[row]
gsc_usrusers.password = adw.object.password[row]
gsc_usrusers.isactive = adw.object.isactive[row]
gsc_usrusers.tomeas = adw.object.tomeas[row]
gsc_usrusers.idiotita = adw.object.idiotita[row]
end subroutine

public subroutine of_deleterow (ref datawindow adw, long row);long	ll_koduser
ll_koduser = adw.object.koduser[row]

// ÄéáãñáöÞ óôïí usrusers
	delete from usrusers where koduser = :ll_koduser;
	fn_sqlerror()

// ÄéáãñáöÞ óå óõíäåäåìÝíïõò ðßíáêåò
	delete from usrmembers where koduser = :ll_koduser;
	fn_sqlerror()
	delete from usruserperm where koduser = :ll_koduser;
	fn_sqlerror()
end subroutine

public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor);al_rowrcolor = rgb(232,255,232)
end subroutine

on w_usrusers_list.create
call super::create
end on

on w_usrusers_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;// translation
	title = trn(684)
end event

type dw from w_list`dw within w_usrusers_list
integer width = 2267
string dataobject = "dw_usrusers_list"
end type

