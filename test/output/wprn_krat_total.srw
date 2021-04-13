HA$PBExportHeader$wprn_krat_total.srw
$PBExportComments$
forward
global type wprn_krat_total from w_print_where_withform
end type
end forward

global type wprn_krat_total from w_print_where_withform
string is_select_form = "w_krat_total_search"
end type
global wprn_krat_total wprn_krat_total

forward prototypes
public subroutine of_retrieve ()
end prototypes

public subroutine of_retrieve ();dw.retrieve(gs_kodxrisi)
end subroutine

on wprn_krat_total.create
call super::create
end on

on wprn_krat_total.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;title = trn(271) + " - " + trn(613)
end event

type dw from w_print_where_withform`dw within wprn_krat_total
string dataobject = "prn_krat_total"
end type

