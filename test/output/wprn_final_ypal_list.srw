HA$PBExportHeader$wprn_final_ypal_list.srw
$PBExportComments$
forward
global type wprn_final_ypal_list from w_print_args_noform
end type
end forward

global type wprn_final_ypal_list from w_print_args_noform
end type
global wprn_final_ypal_list wprn_final_ypal_list

type variables
long		il_kodfinal
end variables

forward prototypes
public subroutine of_open ()
public subroutine of_retrieve ()
end prototypes

public subroutine of_open ();il_kodfinal = Message.DoubleParm
end subroutine

public subroutine of_retrieve ();dw.retrieve(string(il_kodfinal), gs_kodxrisi)
end subroutine

on wprn_final_ypal_list.create
call super::create
end on

on wprn_final_ypal_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;title = trn(271) + " - " + trn(621)
end event

type dw from w_print_args_noform`dw within wprn_final_ypal_list
string dataobject = "prn_final_ypal_list"
end type

