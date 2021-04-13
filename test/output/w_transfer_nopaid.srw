HA$PBExportHeader$w_transfer_nopaid.srw
$PBExportComments$
forward
global type w_transfer_nopaid from w_response
end type
type dw from datawindow within w_transfer_nopaid
end type
end forward

global type w_transfer_nopaid from w_response
integer width = 1915
integer height = 992
string title = "title"
string icon = "res\transfer.ico"
dw dw
end type
global w_transfer_nopaid w_transfer_nopaid

forward prototypes
public function boolean if_check4required ()
public subroutine if_transfer ()
end prototypes

public function boolean if_check4required ();// kodxrisi
	string	ls_fromxrisi
	ls_fromxrisi = dw.object.fromxrisi[1]
	if isnull(ls_fromxrisi) or ls_fromxrisi = "" then
		Messagebox(gs_app_name, trn(194))
		dw.setfocus()
		dw.setcolumn("fromxrisi")
		return false
	end if
	
// kodperiod
	string	ls_kodperiod
	ls_kodperiod = dw.object.kodperiod[1]
	if isnull(ls_kodperiod) or ls_kodperiod = "" then
		Messagebox(gs_app_name, trn(193))
		dw.setfocus()
		dw.setcolumn("kodperiod")
		return false
	end if


// ¼ëá OK
	return true
	
end function

public subroutine if_transfer ();// ÌåôáöïñÜ ôùí óôïé÷åßùí

// Ðáßñíïõìå ôçí åðéëåãìÝíç ÷ñÞóç
	string	ls_fromxrisi
	string	ls_kodperiod
	
	ls_fromxrisi = dw.object.fromxrisi[1]
	ls_kodperiod = dw.object.kodperiod[1]

	
	fn_transfer_nopaid(ls_fromxrisi, gs_kodxrisi, ls_kodperiod)
	

end subroutine

on w_transfer_nopaid.create
int iCurrent
call super::create
this.dw=create dw
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw
end on

on w_transfer_nopaid.destroy
call super::destroy
destroy(this.dw)
end on

event open;// init dw
	dw.insertrow(0)
	fn_retrievechild(dw, "fromxrisi", gs_kodxrisi)
	fn_retrievechild(dw, "kodperiod", gs_kodxrisi)

// translation
	title = trn(438)
	
end event

type cb_cancel from w_response`cb_cancel within w_transfer_nopaid
integer x = 1536
integer y = 752
end type

type cb_ok from w_response`cb_ok within w_transfer_nopaid
integer x = 1179
integer y = 752
end type

event cb_ok::clicked;dw.accepttext()

// ¸ëåã÷ïò óôïé÷åßùí
	if not if_check4required() then return

// ÌåôáöïñÜ
	if_transfer()

	
// ÅðéóôñïöÞ
	CloseWithReturn(GetParent(), 1)


end event

type dw from datawindow within w_transfer_nopaid
integer width = 1897
integer height = 736
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_transfer_nopaid"
boolean border = false
boolean livescroll = true
end type

