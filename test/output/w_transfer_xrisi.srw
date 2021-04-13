HA$PBExportHeader$w_transfer_xrisi.srw
$PBExportComments$
forward
global type w_transfer_xrisi from w_response
end type
type dw from datawindow within w_transfer_xrisi
end type
end forward

global type w_transfer_xrisi from w_response
integer width = 1765
integer height = 788
string title = "title"
string icon = "res\xrisi.ico"
dw dw
end type
global w_transfer_xrisi w_transfer_xrisi

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
	


// ¼ëá OK
	return true
	
end function

public subroutine if_transfer ();// ÌåôáöïñÜ ôùí óôïé÷åßùí

// Ðáßñíïõìå ôçí åðéëåãìÝíç ÷ñÞóç
	string	ls_fromxrisi
	
	ls_fromxrisi = dw.object.fromxrisi[1]

	
	open(w_pleasewait_msg)


// ----------------------------------------------
// zp tables
// ----------------------------------------------

	// misth_zpxrisi - ÐáñÜìåôñïé åöáñìïãÞò
		w_pleasewait_msg.st_message.text = trn(502)
		fn_transfer_param(ls_fromxrisi, gs_kodxrisi)		

	// misth_zpepidom
		w_pleasewait_msg.st_message.text = trn(307)
		fn_transfer_table("misth_zpepidom", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_zpidikot
		w_pleasewait_msg.st_message.text = trn(251)
		fn_transfer_table("misth_zpidikot", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_zpkat
		w_pleasewait_msg.st_message.text = trn(399)
		fn_transfer_table("misth_zpkat", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_zpkrat
		w_pleasewait_msg.st_message.text = trn(411)
		fn_transfer_table("misth_zpkrat", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_zpoikog
		w_pleasewait_msg.st_message.text = trn(474)
		fn_transfer_table("misth_zpoikog", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_zpperiod
		w_pleasewait_msg.st_message.text = trn(529)
		fn_transfer_table("misth_zpperiod", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_zpstath
		w_pleasewait_msg.st_message.text = trn(590)
		fn_transfer_table("misth_zpstath", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_zptamio
		w_pleasewait_msg.st_message.text = trn(118)
		fn_transfer_table("misth_zptamio", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_zpthesi
		w_pleasewait_msg.st_message.text = trn(377)
		fn_transfer_table("misth_zpthesi", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_zptmima
		w_pleasewait_msg.st_message.text = trn(644)
		fn_transfer_table("misth_zptmima", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_zpyvar
		w_pleasewait_msg.st_message.text = trn(433)
		fn_transfer_table("misth_zpyvar", ls_fromxrisi, gs_kodxrisi)	
			
	

// ------------------------------------------------
// other
// ------------------------------------------------

	// misth_ypal
		w_pleasewait_msg.st_message.text = trn(657)
		fn_transfer_table("misth_ypal", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_ypal_yvar
		w_pleasewait_msg.st_message.text = trn(657)
		fn_transfer_table("misth_ypal_yvar", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_fylo
		w_pleasewait_msg.st_message.text = trn(678)
		fn_transfer_table("misth_fylo", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_fylo_epidom
		w_pleasewait_msg.st_message.text = trn(678)
		fn_transfer_table("misth_fylo_epidom", ls_fromxrisi, gs_kodxrisi)		

	// misth_fylo_krat
		w_pleasewait_msg.st_message.text = trn(678)
		fn_transfer_table("misth_fylo_krat", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_fylo_ypal
		w_pleasewait_msg.st_message.text = trn(678)
		fn_transfer_table("misth_fylo_ypal", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_report
		w_pleasewait_msg.st_message.text = trn(393)
		fn_transfer_table("misth_report", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_report_cols
		w_pleasewait_msg.st_message.text = trn(393)
		fn_transfer_table("misth_report_cols", ls_fromxrisi, gs_kodxrisi)		
	
	// misth_report_ypal
		w_pleasewait_msg.st_message.text = trn(393)
		fn_transfer_table("misth_report_ypal", ls_fromxrisi, gs_kodxrisi)		
	
	
close(w_pleasewait_msg)

end subroutine

on w_transfer_xrisi.create
int iCurrent
call super::create
this.dw=create dw
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw
end on

on w_transfer_xrisi.destroy
call super::destroy
destroy(this.dw)
end on

event open;// init dw
	dw.insertrow(0)
	fn_retrievechild(dw, "fromxrisi", gs_kodxrisi)

// translation
	title = trn(442)
	
end event

type cb_cancel from w_response`cb_cancel within w_transfer_xrisi
integer x = 1394
integer y = 556
end type

type cb_ok from w_response`cb_ok within w_transfer_xrisi
integer x = 1038
integer y = 556
end type

event cb_ok::clicked;dw.accepttext()

// ¸ëåã÷ïò óôïé÷åßùí
	if not if_check4required() then return

// ÌåôáöïñÜ
	if_transfer()
	
// ÅðéóôñïöÞ
	CloseWithReturn(GetParent(), 1)


end event

type dw from datawindow within w_transfer_xrisi
integer width = 1733
integer height = 528
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_transfer_xrisi"
boolean border = false
boolean livescroll = true
end type

