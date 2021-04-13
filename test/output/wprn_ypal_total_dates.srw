HA$PBExportHeader$wprn_ypal_total_dates.srw
$PBExportComments$
forward
global type wprn_ypal_total_dates from w_print_where_withform
end type
end forward

global type wprn_ypal_total_dates from w_print_where_withform
string is_select_form = "w_ypal_total_dates_search"
string is_order = " order by misth_ypal.surname, misth_ypal.name, misth_ypal.fathername "
end type
global wprn_ypal_total_dates wprn_ypal_total_dates

forward prototypes
public subroutine of_retrieve ()
end prototypes

public subroutine of_retrieve ();dw.retrieve(gs_kodxrisi, gdate1, gdate2)
end subroutine

on wprn_ypal_total_dates.create
call super::create
end on

on wprn_ypal_total_dates.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw.object.gb_1.text = trn(120)

title = trn(271) + " - " + trn(604)
end event

type dw from w_print_where_withform`dw within wprn_ypal_total_dates
string dataobject = "prn_ypal_total_dates"
end type

