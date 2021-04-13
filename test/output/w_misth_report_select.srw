HA$PBExportHeader$w_misth_report_select.srw
$PBExportComments$
forward
global type w_misth_report_select from w_singleform
end type
end forward

global type w_misth_report_select from w_singleform
integer width = 2011
integer height = 1532
string icon = "res\report.ico"
end type
global w_misth_report_select w_misth_report_select

forward prototypes
public subroutine of_retrieve ()
public subroutine of_update ()
end prototypes

public subroutine of_retrieve ();dw_main.retrieve(gs_kodxrisi)
end subroutine

public subroutine of_update ();// no update
end subroutine

on w_misth_report_select.create
call super::create
end on

on w_misth_report_select.destroy
call super::destroy
end on

event open;call super::open;title = trn(320)

end event

type cb_cancel from w_singleform`cb_cancel within w_misth_report_select
integer x = 1632
integer y = 1292
end type

type cb_ok from w_singleform`cb_ok within w_misth_report_select
integer x = 1275
integer y = 1292
end type

event cb_ok::clicked;// ÅðéóôñïöÞ ôïõ kodreport óôçí gstring

// Ðáßñíïõìå ôçí åðéëåãìÝíç åããñáöÞ
	long		ll_row

	ll_row = dw_main.getrow()
	if ll_row = 0 then return
	gstring = dw_main.object.kodreport[ll_row]
	
// ÅðéóôñïöÞ
	closeWithReturn(getparent(), 1)
end event

type dw_main from w_singleform`dw_main within w_misth_report_select
integer width = 1915
integer height = 1208
string dataobject = "pick_misth_report_xrisi"
end type

event dw_main::rowfocuschanging;call super::rowfocuschanging;this.SelectRow(currentrow, false)
this.Selectrow(newrow, true)
		
end event

