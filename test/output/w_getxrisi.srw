HA$PBExportHeader$w_getxrisi.srw
$PBExportComments$
forward
global type w_getxrisi from w_response
end type
type dw from datawindow within w_getxrisi
end type
end forward

global type w_getxrisi from w_response
integer width = 2011
integer height = 1352
string title = "title"
string icon = "res\xrisi.ico"
dw dw
end type
global w_getxrisi w_getxrisi

on w_getxrisi.create
int iCurrent
call super::create
this.dw=create dw
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw
end on

on w_getxrisi.destroy
call super::destroy
destroy(this.dw)
end on

event open;call super::open;// Initialize dw
	dw.SetTransObject(sqlca)
	dw.retrieve()
	
// Áí äåí õðÜñ÷ïõí ÷ñÞóåéò Üíïéãìá ôïõ w_createxrisi (wiz_setup)
	if dw.rowcount() = 0 then
		//Open(wiz_setup)
		Open(w_createxrisi)
		if Message.DoubleParm = 1 then
			dw.retrieve()
		else
			HALT CLOSE
		end if
	end if
	
// make tab sequence 0
	dw.Object.kodxrisi.TabSequence='0'
	dw.Object.descxrisi.TabSequence='0'
	dw.Object.startdate.TabSequence='0'
	dw.Object.enddate.TabSequence='0'
	
// translate
	title = trn(327)
	cb_ok.text = trn(315)
	
end event

type cb_cancel from w_response`cb_cancel within w_getxrisi
integer x = 1659
integer y = 1120
end type

type cb_ok from w_response`cb_ok within w_getxrisi
integer x = 1303
integer y = 1120
string text = "OK"
end type

event cb_ok::clicked;// Åíçìåñþíïõìå ôéò êáèïëéêÝò ìåôáâëçôÝò ÷ñÞóçò
// ÅëÝã÷ïõìå áí ç ôñÝ÷ïõóá çì/íßá åßíáé óôá üñéá ôçò åðéëåãìÝíçò ÷ñÞóçò
// êáé åìöáíßæïõìå ìÞíõìá
	long	ll_row
	ll_row = dw.getrow()
	if ll_row = 0 then 
		MessageBox(gs_app_name, trn(206))
		return
	end if
	
	gs_kodxrisi = dw.object.kodxrisi[ll_row]
	gs_descxrisi = dw.object.descxrisi[ll_row]
	gd_startdate = dw.object.startdate[ll_row]
	gd_enddate = dw.object.enddate[ll_row]
	
	if today() < gd_startdate or today() > gd_enddate then
		Messagebox(gs_app_name, trn(572) + "! " + trn(360))
	end if
	
// Êëåßóéìï ðáñáèýñïõ
	CloseWithReturn(GetParent(),1)
	
	
end event

type dw from datawindow within w_getxrisi
integer x = 37
integer y = 28
integer width = 1929
integer height = 1048
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_misth_zpxrisi_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanging;this.SelectRow(currentrow, false)
this.SelectRow(newrow, true)
end event

event retrieveend;// Select last row
	this.SetRow(rowcount)
	this.ScrollToRow(rowcount)
end event

event doubleclicked;cb_ok.TriggerEvent(clicked!)
end event

