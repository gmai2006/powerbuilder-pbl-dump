HA$PBExportHeader$wprn_final_nopaid_ana_ypal.srw
$PBExportComments$
forward
global type wprn_final_nopaid_ana_ypal from w_print_args_noform
end type
end forward

global type wprn_final_nopaid_ana_ypal from w_print_args_noform
end type
global wprn_final_nopaid_ana_ypal wprn_final_nopaid_ana_ypal

forward prototypes
public subroutine of_retrieve ()
end prototypes

public subroutine of_retrieve ();dw.retrieve(gs_kodxrisi)
end subroutine

on wprn_final_nopaid_ana_ypal.create
call super::create
end on

on wprn_final_nopaid_ana_ypal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;title = trn(271) + " - " + trn(89)
end event

type dw from w_print_args_noform`dw within wprn_final_nopaid_ana_ypal
string dataobject = "prn_final_nopaid_ana_ypal"
end type

