HA$PBExportHeader$uo_misth_fylo_ypal_sel.sru
$PBExportComments$
forward
global type uo_misth_fylo_ypal_sel from ucv_selection
end type
end forward

global type uo_misth_fylo_ypal_sel from ucv_selection
integer width = 2537
integer height = 944
end type
global uo_misth_fylo_ypal_sel uo_misth_fylo_ypal_sel

type variables
w_misth_fylo_form		iw_parent
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

ll_target_kodypal = target_dw.object.misth_fylo_ypal_kodypal[target_row]
ls_target_kodxrisi = target_dw.object.misth_fylo_ypal_kodxrisi[target_row]

if 	ll_source_kodypal = ll_target_kodypal and &
	ls_source_kodxrisi = ls_target_kodxrisi then
		return true
else
	return false
end if
end function

public subroutine of_retrieve_source (ref datawindow adw);adw.retrieve(gs_kodxrisi)
end subroutine

public subroutine of_retrieve_target (ref datawindow adw);string		ls_kodfylo

ls_kodfylo = iw_parent.idw_main.object.kodfylo[1]

adw.retrieve(ls_kodfylo, gs_kodxrisi)
end subroutine

public subroutine of_source2target (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row);target_dw.object.misth_fylo_ypal_kodypal[target_row] = source_dw.object.kodypal[source_row]
target_dw.object.misth_fylo_ypal_kodxrisi[target_row] = source_dw.object.kodxrisi[source_row]
target_dw.object.misth_fylo_ypal_kodfylo[target_row] = iw_parent.idw_main.object.kodfylo[1]

target_dw.object.misth_ypal_surname[target_row] = source_dw.object.surname[source_row]
target_dw.object.misth_ypal_name[target_row] = source_dw.object.name[source_row]
target_dw.object.misth_ypal_fathername[target_row] = source_dw.object.fathername[source_row]
end subroutine

public subroutine of_target2source (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row);source_dw.object.kodypal[source_row] = target_dw.object.misth_fylo_ypal_kodypal[target_row]
source_dw.object.kodxrisi[source_row] = target_dw.object.misth_fylo_ypal_kodxrisi[target_row]

source_dw.object.surname[source_row] = target_dw.object.misth_ypal_surname[target_row] 
source_dw.object.name[source_row] = target_dw.object.misth_ypal_name[target_row]
source_dw.object.fathername[source_row] = target_dw.object.misth_ypal_fathername[target_row]
end subroutine

on uo_misth_fylo_ypal_sel.create
call super::create
end on

on uo_misth_fylo_ypal_sel.destroy
call super::destroy
end on

event constructor;call super::constructor;// translation
	st_target.text = trn(309)
	st_source.text = trn(657)
	
end event

type st_target from ucv_selection`st_target within uo_misth_fylo_ypal_sel
integer x = 1454
end type

type st_source from ucv_selection`st_source within uo_misth_fylo_ypal_sel
end type

type cb_remove_all from ucv_selection`cb_remove_all within uo_misth_fylo_ypal_sel
integer x = 1147
end type

type cb_remove_one from ucv_selection`cb_remove_one within uo_misth_fylo_ypal_sel
integer x = 1147
end type

type cb_add_all from ucv_selection`cb_add_all within uo_misth_fylo_ypal_sel
integer x = 1147
end type

type cb_add_one from ucv_selection`cb_add_one within uo_misth_fylo_ypal_sel
integer x = 1147
end type

type dw_target from ucv_selection`dw_target within uo_misth_fylo_ypal_sel
integer x = 1445
integer width = 1074
integer height = 816
string dataobject = "dw_misth_fylo_ypal_list"
end type

type dw_source from ucv_selection`dw_source within uo_misth_fylo_ypal_sel
integer width = 1074
integer height = 816
string dataobject = "pick_misth_ypal_xrisi"
end type

