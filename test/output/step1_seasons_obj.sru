HA$PBExportHeader$step1_seasons_obj.sru
$PBExportComments$
forward
global type step1_seasons_obj from ucv_buttons_dw
end type
end forward

global type step1_seasons_obj from ucv_buttons_dw
integer width = 1938
boolean ib_selection = true
string is_formwin = "w_misth_zpxrisi_form"
string is_tablename = "misth_zpxrisi"
boolean ib_sort = true
end type
global step1_seasons_obj step1_seasons_obj

forward prototypes
protected subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_reset_struct ()
end prototypes

protected subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_zpxrisi.kodxrisi = adw.object.kodxrisi[row]
gsc_misth_zpxrisi.descxrisi = adw.object.descxrisi[row]
gsc_misth_zpxrisi.startdate = adw.object.startdate[row]
gsc_misth_zpxrisi.enddate = adw.object.enddate[row]
end subroutine

protected subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodxrisi[row] = gsc_misth_zpxrisi.kodxrisi
adw.object.descxrisi[row] = gsc_misth_zpxrisi.descxrisi
adw.object.startdate[row] = gsc_misth_zpxrisi.startdate
adw.object.enddate[row] = gsc_misth_zpxrisi.enddate
end subroutine

protected subroutine of_reset_struct ();setnull(gsc_misth_zpxrisi.kodxrisi)
setnull(gsc_misth_zpxrisi.descxrisi)
setnull(gsc_misth_zpxrisi.startdate)
setnull(gsc_misth_zpxrisi.enddate)
end subroutine

on step1_seasons_obj.create
call super::create
end on

on step1_seasons_obj.destroy
call super::destroy
end on

type dw from ucv_buttons_dw`dw within step1_seasons_obj
integer width = 1929
string dataobject = "dw_misth_zpxrisi_list"
end type

type pb_delete from ucv_buttons_dw`pb_delete within step1_seasons_obj
integer x = 1819
end type

type pb_edit from ucv_buttons_dw`pb_edit within step1_seasons_obj
integer x = 1701
end type

type pb_add from ucv_buttons_dw`pb_add within step1_seasons_obj
integer x = 1582
end type

