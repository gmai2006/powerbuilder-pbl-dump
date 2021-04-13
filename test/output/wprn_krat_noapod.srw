HA$PBExportHeader$wprn_krat_noapod.srw
$PBExportComments$
forward
global type wprn_krat_noapod from w_print_args_noform
end type
end forward

global type wprn_krat_noapod from w_print_args_noform
end type
global wprn_krat_noapod wprn_krat_noapod

forward prototypes
public subroutine of_retrieve ()
end prototypes

public subroutine of_retrieve ();dw.retrieve(gs_kodxrisi)
end subroutine

on wprn_krat_noapod.create
call super::create
end on

on wprn_krat_noapod.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;title = trn(271) + " - " + trn(414)
end event

type dw from w_print_args_noform`dw within wprn_krat_noapod
string dataobject = "prn_krat_noapod"
end type

