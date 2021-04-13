HA$PBExportHeader$wprn_final_atomiki_misth_arg.srw
$PBExportComments$
forward
global type wprn_final_atomiki_misth_arg from w_print_args_noform
end type
end forward

global type wprn_final_atomiki_misth_arg from w_print_args_noform
end type
global wprn_final_atomiki_misth_arg wprn_final_atomiki_misth_arg

type variables
long		il_kodfinal
long		il_kodypal
end variables

forward prototypes
public subroutine of_open ()
public subroutine of_retrieve ()
end prototypes

public subroutine of_open ();il_kodfinal = gsc_misth_final_ypal.kodfinal
il_kodypal = gsc_misth_final_ypal.kodypal
end subroutine

public subroutine of_retrieve ();dw.retrieve(string(il_kodfinal), string(il_kodypal), gs_kodxrisi)
end subroutine

on wprn_final_atomiki_misth_arg.create
call super::create
end on

on wprn_final_atomiki_misth_arg.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw.object.gb_1.text = trn(120)

title = trn(271) + " - " + trn(123)
end event

type dw from w_print_args_noform`dw within wprn_final_atomiki_misth_arg
string dataobject = "prn_final_atomiki_misth_arg"
end type

