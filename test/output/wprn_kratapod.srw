HA$PBExportHeader$wprn_kratapod.srw
$PBExportComments$
forward
global type wprn_kratapod from w_print_args_noform
end type
end forward

global type wprn_kratapod from w_print_args_noform
end type
global wprn_kratapod wprn_kratapod

type variables
long		il_kodkratapod
end variables

forward prototypes
public subroutine of_open ()
public subroutine of_retrieve ()
end prototypes

public subroutine of_open ();il_kodkratapod = Message.Doubleparm
end subroutine

public subroutine of_retrieve ();dw.retrieve(string(il_kodkratapod), gs_kodxrisi)
end subroutine

on wprn_kratapod.create
call super::create
end on

on wprn_kratapod.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;title = trn(271) + " - " + trn(94)
end event

type dw from w_print_args_noform`dw within wprn_kratapod
string dataobject = "prn_kratapod"
end type

