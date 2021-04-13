HA$PBExportHeader$w_misth_final_ypal_plirdate.srw
$PBExportComments$
forward
global type w_misth_final_ypal_plirdate from w_response
end type
type dw_final from datawindow within w_misth_final_ypal_plirdate
end type
type dw_plirdate from datawindow within w_misth_final_ypal_plirdate
end type
type cb_all from commandbutton within w_misth_final_ypal_plirdate
end type
type gb_1 from groupbox within w_misth_final_ypal_plirdate
end type
end forward

global type w_misth_final_ypal_plirdate from w_response
integer width = 2930
integer height = 2028
string title = "title"
string icon = "res\final.ico"
dw_final dw_final
dw_plirdate dw_plirdate
cb_all cb_all
gb_1 gb_1
end type
global w_misth_final_ypal_plirdate w_misth_final_ypal_plirdate

on w_misth_final_ypal_plirdate.create
int iCurrent
call super::create
this.dw_final=create dw_final
this.dw_plirdate=create dw_plirdate
this.cb_all=create cb_all
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_final
this.Control[iCurrent+2]=this.dw_plirdate
this.Control[iCurrent+3]=this.cb_all
this.Control[iCurrent+4]=this.gb_1
end on

on w_misth_final_ypal_plirdate.destroy
call super::destroy
destroy(this.dw_final)
destroy(this.dw_plirdate)
destroy(this.cb_all)
destroy(this.gb_1)
end on

event open;call super::open;// get kodfinal
	long		ll_kodfinal
	ll_kodfinal = Message.DoubleParm
	
// set transactions
	dw_final.SetTransObject(SQLCA)
	dw_plirdate.SetTransObject(SQLCA)

// alternative row coloring of dw_plirdate
	long	ll_rowrcolor, ll_rowcolor
	ll_rowcolor = rgb(255,255,255)
	ll_rowrcolor = rgb(128,255,128)
	dw_plirdate.Modify("DataWindow.Detail.Color= '536870912~tif(mod(getrow(), 2) = 1, " + string(ll_rowcolor) + ", " + string(ll_rowrcolor) + ")'")

// set edit mask for plirdate of dw_plirdate
	fn_seteditmask(dw_plirdate, "misth_final_ypal_plirdate", fn_param_maskdate_e())

// retrieve both dw's
	dw_final.retrieve(string(ll_kodfinal), gs_kodxrisi)
	dw_plirdate.retrieve(string(ll_kodfinal), gs_kodxrisi)
	
// retrieve child
	fn_retrievechild(dw_final, "kodperiod", gs_kodxrisi)
	fn_retrievechild(dw_final, "kodkat", gs_kodxrisi)

// set focus to dw_plirdate
	dw_plirdate.setfocus()
	
// translation
	title = trn(546)
	cb_all.text = trn(39)
	
end event

type cb_cancel from w_response`cb_cancel within w_misth_final_ypal_plirdate
integer x = 2569
integer y = 1808
integer taborder = 50
end type

type cb_ok from w_response`cb_ok within w_misth_final_ypal_plirdate
integer x = 2213
integer y = 1808
integer taborder = 30
end type

event cb_ok::clicked;dw_plirdate.update()
commit;

CloseWithReturn(GetParent(), 1)
end event

type dw_final from datawindow within w_misth_final_ypal_plirdate
integer x = 73
integer y = 76
integer width = 2757
integer height = 356
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "dw_misth_final_form"
boolean border = false
boolean livescroll = true
end type

type dw_plirdate from datawindow within w_misth_final_ypal_plirdate
integer x = 32
integer y = 512
integer width = 2839
integer height = 1248
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_misth_final_ypal_plirdate_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanging;this.selectrow(currentrow, false)
this.selectrow(newrow, true)
end event

event retrieveend;if rowcount > 0 then
	this.setrow(1)
	this.selectrow(1, true)
end if

end event

type cb_all from commandbutton within w_misth_final_ypal_plirdate
integer x = 32
integer y = 1804
integer width = 649
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "All"
end type

event clicked;date		ldt_plirdate
string	ls_plirdate

Open(w_getdate)

ls_plirdate = Message.StringParm
if isnull(ls_plirdate) or ls_plirdate = "" then return

// update all rows where plirdate is null
	long	ll_rows
	long	i
	
	ll_rows = dw_plirdate.rowcount()
	
	for i = 1 to ll_rows
		
		ldt_plirdate = dw_plirdate.object.misth_final_ypal_plirdate[i]
		
		if isnull(ldt_plirdate) then
			dw_plirdate.object.misth_final_ypal_plirdate[i] = date(ls_plirdate)
		end if
		
	next
end event

type gb_1 from groupbox within w_misth_final_ypal_plirdate
integer x = 32
integer y = 12
integer width = 2839
integer height = 464
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 33554432
long backcolor = 67108864
end type

