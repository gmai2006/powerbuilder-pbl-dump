HA$PBExportHeader$w_loadfilter.srw
$PBExportComments$
forward
global type w_loadfilter from w_singleform
end type
type cb_delete from commandbutton within w_loadfilter
end type
end forward

global type w_loadfilter from w_singleform
string title = ""
event ie_checkbuttons ( )
cb_delete cb_delete
end type
global w_loadfilter w_loadfilter

type variables
w_filter		iw_filter
end variables

forward prototypes
public subroutine of_open ()
public subroutine of_retrieve ()
end prototypes

event ie_checkbuttons();long	ll_row
ll_row = dw_main.getrow()

if ll_row = 0 then
	cb_ok.enabled = false
	cb_delete.enabled = false
else
	cb_ok.enabled = true
	cb_delete.enabled = true
end if

// Translation
	title = trn(80)
	cb_delete.text = trn(222)
	cb_ok.text = trn(315)
end event

public subroutine of_open ();iw_filter = Message.PowerObjectParm
end subroutine

public subroutine of_retrieve ();dw_main.retrieve(iw_filter.is_tablename)
end subroutine

on w_loadfilter.create
int iCurrent
call super::create
this.cb_delete=create cb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete
end on

on w_loadfilter.destroy
call super::destroy
destroy(this.cb_delete)
end on

type cb_cancel from w_singleform`cb_cancel within w_loadfilter
end type

type cb_ok from w_singleform`cb_ok within w_loadfilter
string text = "OK"
end type

event cb_ok::clicked;// Áí äåí õðÜñ÷åé ãñáììÞ åðéóôñÝöïõìå 
	long	ll_row
	ll_row = dw_main.getrow()
	if ll_row = 0 then return

// set redraw to false
	iw_filter.idw_filter.setredraw(false)

// Ðáßñïõìå ôïí êùäéêü ôïõ ößëôñïõ
	long	ll_kodfilter
	ll_kodfilter = dw_main.object.kodfilter[ll_row]

// Êáèáñßæïõìå ôá äåäïìÝíá ôïõ iw_parent.idw_filter
	long	ll_rows, i
	ll_rows = iw_filter.idw_filter.rowcount()
	for i = 1 to ll_rows
		iw_filter.idw_filter.SetRow(1)
		iw_filter.idw_filter.deleterow(0)
	next
		
// Äçìéïõñãßá datastore ìå ôá äåäïìÝíá ôïõ dw_afxfilterd_list
// ãéá ôï åðéëåãìÝíï ößëôñï (ll_kodfilter)
	datastore	lds_filterd
	lds_filterd = create datastore
	lds_filterd.DataObject = "dw_afxfilterd_list"
	lds_filterd.SetTransObject(SQLCA)
	ll_rows = lds_filterd.retrieve(string(ll_kodfilter))

// Öïñôþíïõìå ôá äåäïìÝíá áðü ôï lds_filterd óôï iw_filter.idw_filter
	for i = 1 to ll_rows
		ll_row = iw_filter.idw_filter.insertrow(0)
		iw_filter.idw_filter.object.field[ll_row] = lds_filterd.object.pedio[i]
		iw_filter.idw_filter.object.operator[ll_row] = lds_filterd.object.telestis[i]
		iw_filter.idw_filter.object.value[ll_row] = lds_filterd.object.timi[i]
		iw_filter.idw_filter.object.join[ll_row] = lds_filterd.object.joint[i]
	next
	
// Insert a new empty row (for new record)
	iw_filter.uo_filter.if_insertrow()

// destroy datastore
	destroy lds_filterd
	
// set redraw to true
	iw_filter.idw_filter.setredraw(true)
	
// close window
	close(getparent())


end event

type dw_main from w_singleform`dw_main within w_loadfilter
string dataobject = "dw_afxfilter_list"
end type

event dw_main::retrieveend;call super::retrieveend;this.SetRow(1)
this.SelectRow(1, true)

getparent().TriggerEvent("ie_checkbuttons")
end event

event dw_main::rowfocuschanging;call super::rowfocuschanging;this.SelectRow(currentrow, false)
this.SelectRow(newrow, true)
end event

event dw_main::doubleclicked;call super::doubleclicked;cb_ok.TriggerEvent(clicked!)
end event

type cb_delete from commandbutton within w_loadfilter
integer x = 27
integer y = 964
integer width = 311
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "Delete"
end type

event clicked;// ÄéáãñáöÞ ôïõ åðéëåãìÝíïõ ößëôñïõ
// Ãßíåôáé cascade delete óôï afxFilterD

// ÅðáëÞèåõóç
	int	nRet
	nRet = MessageBox(trn(226), trn(453), Exclamation!, OKCancel!, 2)
	if nRet = 2 then return

dw_main.Setredraw(false)

// ÄéáãñáöÞ
	long	ll_row
	ll_row = dw_main.getrow()
	if ll_row = 0 then return
	
	dw_main.deleterow(ll_row)
	dw_main.update()
	COMMIT USING SQLCA;
	
// ÅðéëïãÞ ðñïçãïýìåíçò ãñáììÞò
	ll_row = ll_row - 1
	if ll_row = 0 then ll_row = 1
	dw_main.Setrow(ll_row)
	dw_main.Scrolltorow(ll_row)
	dw_main.Selectrow(0, false)
	dw_main.Selectrow(ll_row, true)
	
dw_main.Setredraw(true)

getparent().TriggerEvent("ie_checkbuttons")
	

end event

