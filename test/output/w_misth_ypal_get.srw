HA$PBExportHeader$w_misth_ypal_get.srw
$PBExportComments$
forward
global type w_misth_ypal_get from w_singleform
end type
end forward

global type w_misth_ypal_get from w_singleform
string icon = "res\ypal.ico"
end type
global w_misth_ypal_get w_misth_ypal_get

forward prototypes
public subroutine of_retrieve ()
end prototypes

public subroutine of_retrieve ();dw_main.retrieve(gs_kodxrisi)
end subroutine

on w_misth_ypal_get.create
call super::create
end on

on w_misth_ypal_get.destroy
call super::destroy
end on

event open;call super::open;title = trn(304)

end event

type cb_cancel from w_singleform`cb_cancel within w_misth_ypal_get
end type

type cb_ok from w_singleform`cb_ok within w_misth_ypal_get
end type

event cb_ok::clicked;// Ðáßñíïõìå ôïí åðéëåãìÝíï õðÜëëçëï
	long	ll_kodypal
	long	ll_row
	
	ll_row = dw_main.getrow()
	
	if ll_row = 0 then
		MessageBox(tr("ÅðéëïãÞ õðáëëÞëïõ"), trn(202))
		return
	end if
	
	ll_kodypal = dw_main.object.kodypal[ll_row]
	
// ÅðéóôñïöÞ ìå ôïí åðéëåãìÝíï õðÜëëçëï
	closeWithReturn(getparent(), ll_kodypal)
	
end event

type dw_main from w_singleform`dw_main within w_misth_ypal_get
string dataobject = "pick_misth_ypal_xrisi"
boolean vscrollbar = true
end type

event dw_main::rowfocuschanging;call super::rowfocuschanging;this.SelectRow(currentrow, false)
this.Selectrow(newrow, true)
end event

