HA$PBExportHeader$uo_misth_report_ypal_sel.sru
$PBExportComments$
forward
global type uo_misth_report_ypal_sel from ucv_selection
end type
end forward

global type uo_misth_report_ypal_sel from ucv_selection
integer width = 2272
integer height = 820
end type
global uo_misth_report_ypal_sel uo_misth_report_ypal_sel

type variables
w_misth_report_form		iw_parent
end variables

forward prototypes
public function boolean of_match (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row)
public subroutine of_retrieve_source (ref datawindow adw)
public subroutine of_retrieve_target (ref datawindow adw)
public subroutine of_source2target (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row)
public subroutine of_target2source (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row)
end prototypes

public function boolean of_match (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row);// ÅðéóôñÝöåé true áí ïé äýï åããñáöÝò (arguments)
// åßíáé ßäéåò.
// ÐåñéÝ÷åé ôïí Ýëåã÷ï ãéá íá åßíáé ßäéåò ïé åããñáöÝò
// (åëÝã÷åé ôéò ôéìÝò ôùí êëåéäéþí)

long		ll_source_kodypal, ll_target_kodypal
string		ls_source_kodxrisi, ls_target_kodxrisi

ll_source_kodypal = source_dw.object.kodypal[source_row]
ls_source_kodxrisi = source_dw.object.kodxrisi[source_row]

ll_target_kodypal = target_dw.object.misth_report_ypal_kodypal[target_row]
ls_target_kodxrisi = target_dw.object.misth_report_ypal_kodxrisi[target_row]

if 	ll_source_kodypal = ll_target_kodypal and &
	ls_source_kodxrisi = ls_target_kodxrisi then
		return true
else
	return false
end if
end function

public subroutine of_retrieve_source (ref datawindow adw);adw.retrieve(gs_kodxrisi)
end subroutine

public subroutine of_retrieve_target (ref datawindow adw);string		ls_kodreport

ls_kodreport = iw_parent.idw_main.object.kodreport[1]

adw.retrieve(ls_kodreport, gs_kodxrisi)
end subroutine

public subroutine of_source2target (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row);target_dw.object.misth_report_ypal_kodypal[target_row] = source_dw.object.kodypal[source_row]
target_dw.object.misth_report_ypal_kodxrisi[target_row] = source_dw.object.kodxrisi[source_row]
target_dw.object.misth_report_ypal_kodreport[target_row] = iw_parent.idw_main.object.kodreport[1]

target_dw.object.misth_ypal_surname[target_row] = source_dw.object.surname[source_row]
target_dw.object.misth_ypal_name[target_row] = source_dw.object.name[source_row]
target_dw.object.misth_ypal_fathername[target_row] = source_dw.object.fathername[source_row]
end subroutine

public subroutine of_target2source (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row);source_dw.object.kodypal[source_row] = target_dw.object.misth_report_ypal_kodypal[target_row]
source_dw.object.kodxrisi[source_row] = target_dw.object.misth_report_ypal_kodxrisi[target_row]

source_dw.object.surname[source_row] = target_dw.object.misth_ypal_surname[target_row] 
source_dw.object.name[source_row] = target_dw.object.misth_ypal_name[target_row]
source_dw.object.fathername[source_row] = target_dw.object.misth_ypal_fathername[target_row]
end subroutine

on uo_misth_report_ypal_sel.create
call super::create
end on

on uo_misth_report_ypal_sel.destroy
call super::destroy
end on

event constructor;call super::constructor;st_target.text = trn(309)
st_source.text = trn(657)

end event

type st_target from ucv_selection`st_target within uo_misth_report_ypal_sel
integer x = 1266
string text = ""
end type

type st_source from ucv_selection`st_source within uo_misth_report_ypal_sel
string text = ""
end type

type cb_remove_all from ucv_selection`cb_remove_all within uo_misth_report_ypal_sel
integer x = 1056
integer width = 160
end type

type cb_remove_one from ucv_selection`cb_remove_one within uo_misth_report_ypal_sel
integer x = 1056
integer width = 160
end type

type cb_add_all from ucv_selection`cb_add_all within uo_misth_report_ypal_sel
integer x = 1056
integer width = 160
end type

type cb_add_one from ucv_selection`cb_add_one within uo_misth_report_ypal_sel
integer x = 1056
integer width = 160
end type

type dw_target from ucv_selection`dw_target within uo_misth_report_ypal_sel
integer x = 1253
integer width = 997
integer height = 708
string dataobject = "pick_misth_report_ypal"
end type

type dw_source from ucv_selection`dw_source within uo_misth_report_ypal_sel
integer width = 997
integer height = 708
string dataobject = "pick_misth_ypal_xrisi"
end type

