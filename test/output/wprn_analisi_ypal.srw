HA$PBExportHeader$wprn_analisi_ypal.srw
$PBExportComments$
forward
global type wprn_analisi_ypal from w_print_where_withform
end type
end forward

global type wprn_analisi_ypal from w_print_where_withform
string is_select_form = "w_ypal_sel"
string is_order = " order by misth_ypal.surname, misth_ypal.name, misth_ypal.fathername "
end type
global wprn_analisi_ypal wprn_analisi_ypal

forward prototypes
public subroutine of_retrieve ()
end prototypes

public subroutine of_retrieve ();dw.retrieve(gs_kodxrisi)
end subroutine

on wprn_analisi_ypal.create
call super::create
end on

on wprn_analisi_ypal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw.object.gb_1.text = trn(120)

title = trn(271) + " - " + trn(75)
end event

type dw from w_print_where_withform`dw within wprn_analisi_ypal
string dataobject = "prn_analisi_ypal"
end type

