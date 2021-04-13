HA$PBExportHeader$wprn_ypal_newklimakio.srw
$PBExportComments$
forward
global type wprn_ypal_newklimakio from w_print_args_noform
end type
end forward

global type wprn_ypal_newklimakio from w_print_args_noform
end type
global wprn_ypal_newklimakio wprn_ypal_newklimakio

forward prototypes
public subroutine of_retrieve ()
end prototypes

public subroutine of_retrieve ();dw.retrieve(gs_kodxrisi, today())
end subroutine

on wprn_ypal_newklimakio.create
call super::create
end on

on wprn_ypal_newklimakio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;title = trn(271) + " - " + trn(65)
end event

type dw from w_print_args_noform`dw within wprn_ypal_newklimakio
string dataobject = "prn_ypal_newklimakio"
end type

