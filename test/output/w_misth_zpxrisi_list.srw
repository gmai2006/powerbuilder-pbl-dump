HA$PBExportHeader$w_misth_zpxrisi_list.srw
$PBExportComments$
forward
global type w_misth_zpxrisi_list from w_list
end type
end forward

global type w_misth_zpxrisi_list from w_list
integer width = 1979
integer height = 1440
string title = "title"
string menuname = "m_misth_zpxrisi_list"
string icon = "res\xrisi.ico"
string is_tablename = "misth_zpxrisi"
string is_formwin = "w_misth_zpxrisi_form"
boolean ib_editwithkey = true
boolean ib_retrieve = true
boolean ib_includewhere = true
boolean ib_noview = true
boolean ib_nofilter = true
end type
global w_misth_zpxrisi_list w_misth_zpxrisi_list

forward prototypes
public subroutine of_deleterow (ref datawindow adw, long row)
protected subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_reset_struct ()
protected subroutine of_struct2dw (ref datawindow adw, long row)
end prototypes

public subroutine of_deleterow (ref datawindow adw, long row);string	ls_kodxrisi

ls_kodxrisi = adw.object.kodxrisi[row]

delete from misth_zpxrisi where kodxrisi = :ls_kodxrisi;
fn_sqlerror()
commit;
end subroutine

protected subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_zpxrisi.kodxrisi = adw.object.kodxrisi[row]
gsc_misth_zpxrisi.descxrisi = adw.object.descxrisi[row]
gsc_misth_zpxrisi.startdate = adw.object.startdate[row]
gsc_misth_zpxrisi.enddate = adw.object.enddate[row]
end subroutine

protected subroutine of_reset_struct ();setnull(gsc_misth_zpxrisi.kodxrisi)
setnull(gsc_misth_zpxrisi.descxrisi)
setnull(gsc_misth_zpxrisi.startdate)
setnull(gsc_misth_zpxrisi.enddate)
end subroutine

protected subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodxrisi[row] = gsc_misth_zpxrisi.kodxrisi
adw.object.descxrisi[row] = gsc_misth_zpxrisi.descxrisi
adw.object.startdate[row] = gsc_misth_zpxrisi.startdate
adw.object.enddate[row] = gsc_misth_zpxrisi.enddate
end subroutine

on w_misth_zpxrisi_list.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_misth_zpxrisi_list" then this.MenuID = create m_misth_zpxrisi_list
end on

on w_misth_zpxrisi_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;title = trn(682)

end event

type dw from w_list`dw within w_misth_zpxrisi_list
integer width = 1934
integer height = 1216
string dataobject = "dw_misth_zpxrisi_list"
end type

