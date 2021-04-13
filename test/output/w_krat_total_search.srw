HA$PBExportHeader$w_krat_total_search.srw
$PBExportComments$
forward
global type w_krat_total_search from window
end type
type pb_period_none from picturebutton within w_krat_total_search
end type
type pb_period_all from picturebutton within w_krat_total_search
end type
type pb_krat_all from picturebutton within w_krat_total_search
end type
type pb_krat_none from picturebutton within w_krat_total_search
end type
type st_2 from statictext within w_krat_total_search
end type
type st_1 from statictext within w_krat_total_search
end type
type dw_period from datawindow within w_krat_total_search
end type
type dw_krat from datawindow within w_krat_total_search
end type
type uo_plirdate from u_dates within w_krat_total_search
end type
type uo_datefinal from u_dates within w_krat_total_search
end type
type cb_cancel from commandbutton within w_krat_total_search
end type
type cb_ok from commandbutton within w_krat_total_search
end type
end forward

global type w_krat_total_search from window
integer width = 2103
integer height = 1728
boolean titlebar = true
string title = "title"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "res\print.ico"
boolean center = true
pb_period_none pb_period_none
pb_period_all pb_period_all
pb_krat_all pb_krat_all
pb_krat_none pb_krat_none
st_2 st_2
st_1 st_1
dw_period dw_period
dw_krat dw_krat
uo_plirdate uo_plirdate
uo_datefinal uo_datefinal
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_krat_total_search w_krat_total_search

type variables
boolean		ib_includewhere
end variables

forward prototypes
protected function string of_createwhere ()
public subroutine of_setmasks ()
public function boolean if_check4required ()
public function boolean if_krat_selected ()
end prototypes

protected function string of_createwhere ();string	ls_where

string	lstring
long		llong	 
date		ldate
time		ltime
integer	li_hour, li_minute
double	ldouble


// datefinal --------------------------------------------------------------------
	string	ls_where_datefinal

// datefinal - from 
	ldate = uo_datefinal.uf_getdatefrom()
	if not isnull(ldate) then
		ls_where_datefinal = ls_where_datefinal + " AND misth_final.datefinal >= ~~'" + fn_date2string(ldate) + "~~'"
	end if	
	
// datefinal - to
	ldate = uo_datefinal.uf_getdateto()
	if not isnull(ldate) then
		ls_where_datefinal = ls_where_datefinal + " AND misth_final.datefinal <= ~~'" + fn_date2string(ldate) + "~~'"
	end if	
	
// Áöáßñåóç ôïõ áñ÷éêïý AND áí Ý÷ïõìå äþóåé êÜðïéá çì/íßá
	if not isnull(ls_where_datefinal) and ls_where_datefinal <> "" then
		ls_where_datefinal = right(ls_where_datefinal, Len(ls_where_datefinal) - 5)
		ls_where_datefinal = "(" + ls_where_datefinal + ")"
	end if

// plirdate --------------------------------------------------------------------
	string	ls_where_plirdate

// plirdate - from 
	ldate = uo_plirdate.uf_getdatefrom()
	if not isnull(ldate) then
		ls_where_plirdate = ls_where_plirdate + " AND misth_final_ypal.plirdate >= ~~'" + fn_date2string(ldate) + "~~'"
	end if	
	
// plirdate - to
	ldate = uo_plirdate.uf_getdateto()
	if not isnull(ldate) then
		ls_where_plirdate = ls_where_plirdate + " AND misth_final_ypal.plirdate <= ~~'" + fn_date2string(ldate) + "~~'"
	end if	
	
// Áöáßñåóç ôïõ áñ÷éêïý AND áí Ý÷ïõìå äþóåé êÜðïéá çì/íßá
	if not isnull(ls_where_plirdate) and ls_where_plirdate <> "" then
		ls_where_plirdate = right(ls_where_plirdate, Len(ls_where_plirdate) - 5)
		ls_where_plirdate = "(" + ls_where_plirdate + ")"
	end if


// ÅðéëåãìÝíåò êñáôÞóåéò ----------------------------------------------------------------
	
	string	ls_where_krat

// count rows
	long			ll_rows
	ll_rows = dw_krat.rowcount()
	
// for each selected krat add to where
	long	i
	
	for i = 1 to ll_rows
		if dw_krat.object.issel[i] = 1 then
			ls_where_krat = ls_where_krat + " OR misth_zpkrat.kodkrat = ~~'" + string(dw_krat.object.kodkrat[i]) + "~~'"
		end if
	next

// Áöáßñåóç ôïõ áñ÷éêïý OR áí Ý÷ïõìå äþóåé êÜðïéá êñÜôçóç
	if not isnull(ls_where_krat) and ls_where_krat <> "" then
		ls_where_krat = right(ls_where_krat, Len(ls_where_krat) - 4)
		ls_where_krat = "(" + ls_where_krat + ")"
	end if
	
// --------------------------------------------------------------------------

// ÅðéëåãìÝíåò ðåñßïäïé ----------------------------------------------------------------
	
	string	ls_where_period

// count rows
	ll_rows = dw_period.rowcount()
	
// for each selected period add to where
	
	for i = 1 to ll_rows
		if dw_period.object.issel[i] = 1 then
			ls_where_period = ls_where_period + " OR misth_final.kodperiod = ~~'" + string(dw_period.object.kodperiod[i]) + "~~'"
		end if
	next

// Áöáßñåóç ôïõ áñ÷éêïý OR áí Ý÷ïõìå äþóåé êÜðïéá êñÜôçóç
	if not isnull(ls_where_period) and ls_where_period <> "" then
		ls_where_period = right(ls_where_period, Len(ls_where_period) - 4)
		ls_where_period = "(" + ls_where_period + ")"
	end if
	
// --------------------------------------------------------------------------



// Óõíäõáóìüò ls_where_datefinal, ls_where_plirdate, ls_where_krat, ls_where_period
	if not isnull(ls_where_datefinal) and ls_where_datefinal <> "" then
		ls_where = ls_where + " AND " + ls_where_datefinal
	end if
	
	if not isnull(ls_where_plirdate) and ls_where_plirdate <> "" then
		ls_where = ls_where + " AND " + ls_where_plirdate
	end if
	
	if not isnull(ls_where_krat) and ls_where_krat <> "" then
		ls_where = ls_where + " AND " + ls_where_krat
	end if

	if not isnull(ls_where_period) and ls_where_period <> "" then
		ls_where = ls_where + " AND " + ls_where_period
	end if



return ls_where



end function

public subroutine of_setmasks ();// Edit Mask & display Mask


// maskdate, maskdateedit
	fn_seteditmask(uo_datefinal.dw, "datefrom", fn_param_maskdate_e())
	fn_seteditmask(uo_datefinal.dw, "dateto", fn_param_maskdate_e())	

end subroutine

public function boolean if_check4required ();// ¸ëåã÷ïò áí Ý÷ïõí åéóá÷èåß üëá ôá êñéôÞñéá

string	lstring	
long		llong	
long		ll_count
date		ldate

// ¸ëåã÷ïò áí Ý÷ïõìå åðéëÝîåé ôïõëÜ÷éóôïí ìßá êñÜôçóç
	if not if_krat_selected() then
		Messagebox(gs_app_name, trn(552))
		dw_krat.setfocus()
		return false
	end if	

// ¼ëá ÏÊ
	return true
end function

public function boolean if_krat_selected ();// ¸ëåã÷ïò áí åðéëÝ÷èçêå ôïõëÜ÷éóôïí ìßá êñÜôçóç

	integer	i, rows
	
	rows = dw_krat.rowcount()
	
	for i = 1 to rows
		if dw_krat.object.issel[i] = 1 then return true
	next
	
	return false
end function

on w_krat_total_search.create
this.pb_period_none=create pb_period_none
this.pb_period_all=create pb_period_all
this.pb_krat_all=create pb_krat_all
this.pb_krat_none=create pb_krat_none
this.st_2=create st_2
this.st_1=create st_1
this.dw_period=create dw_period
this.dw_krat=create dw_krat
this.uo_plirdate=create uo_plirdate
this.uo_datefinal=create uo_datefinal
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.pb_period_none,&
this.pb_period_all,&
this.pb_krat_all,&
this.pb_krat_none,&
this.st_2,&
this.st_1,&
this.dw_period,&
this.dw_krat,&
this.uo_plirdate,&
this.uo_datefinal,&
this.cb_cancel,&
this.cb_ok}
end on

on w_krat_total_search.destroy
destroy(this.pb_period_none)
destroy(this.pb_period_all)
destroy(this.pb_krat_all)
destroy(this.pb_krat_none)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_period)
destroy(this.dw_krat)
destroy(this.uo_plirdate)
destroy(this.uo_datefinal)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;uo_datefinal.dw.setfocus()
uo_datefinal.uf_setcaption(trn(367))
uo_plirdate.uf_setcaption(trn(372))

dw_krat.SetTransObject(sqlca)
dw_period.SetTransObject(sqlca)
dw_krat.retrieve(gs_kodxrisi)
dw_period.retrieve(gs_kodxrisi)

ib_includewhere = false

// translation
	title = trn(417)
	pb_period_none.powertiptext = trn(99)
	pb_period_all.powertiptext = trn(322)
	pb_krat_all.powertiptext = trn(322)
	pb_krat_none.powertiptext = trn(99)
	st_2.text = trn(324)
	st_1.text =trn(321)
	cb_cancel.text = trn(2)
	cb_ok.text = trn(699)
	
	

end event

type pb_period_none from picturebutton within w_krat_total_search
integer x = 1179
integer y = 1532
integer width = 101
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string picturename = "Custom094!"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;integer	i, rows
rows = dw_period.rowcount()

for i = 1 to rows
	dw_period.object.issel[i] = 0
next
end event

type pb_period_all from picturebutton within w_krat_total_search
integer x = 1061
integer y = 1532
integer width = 101
integer height = 88
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string picturename = "Custom038!"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;integer	i, rows
rows = dw_period.rowcount()

for i = 1 to rows
	dw_period.object.issel[i] = 1
next
end event

type pb_krat_all from picturebutton within w_krat_total_search
integer x = 27
integer y = 1532
integer width = 101
integer height = 88
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string picturename = "Custom038!"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;integer	i, rows
rows = dw_krat.rowcount()

for i = 1 to rows
	dw_krat.object.issel[i] = 1
next
end event

type pb_krat_none from picturebutton within w_krat_total_search
integer x = 146
integer y = 1532
integer width = 101
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string picturename = "Custom094!"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;integer	i, rows
rows = dw_krat.rowcount()

for i = 1 to rows
	dw_krat.object.issel[i] = 0
next
end event

type st_2 from statictext within w_krat_total_search
integer x = 1061
integer y = 524
integer width = 498
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_1 from statictext within w_krat_total_search
integer x = 27
integer y = 528
integer width = 539
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_period from datawindow within w_krat_total_search
integer x = 1061
integer y = 608
integer width = 987
integer height = 908
integer taborder = 40
string title = "none"
string dataobject = "sel_misth_zpperiod_xrisi"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_krat from datawindow within w_krat_total_search
integer x = 27
integer y = 608
integer width = 987
integer height = 908
integer taborder = 40
string title = "none"
string dataobject = "sel_misth_zpkrat_xrisi"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_plirdate from u_dates within w_krat_total_search
integer x = 23
integer y = 272
integer taborder = 30
end type

on uo_plirdate.destroy
call u_dates::destroy
end on

type uo_datefinal from u_dates within w_krat_total_search
integer x = 23
integer y = 12
integer taborder = 40
end type

on uo_datefinal.destroy
call u_dates::destroy
end on

type cb_cancel from commandbutton within w_krat_total_search
integer x = 1737
integer y = 172
integer width = 311
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
boolean cancel = true
end type

event clicked;closewithreturn(getparent(), "")
end event

type cb_ok from commandbutton within w_krat_total_search
integer x = 1737
integer y = 32
integer width = 311
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
boolean default = true
end type

event clicked;string	ls_where

if not if_check4required() then return

ls_where = of_createwhere()

// Áöáßñåóç ôïõ áñ÷éêïý AND (5 ÷áñáêôÞñåò ìå ôá 2 êåíÜ)
// êáé ðñïóèÞêç ðáñåíèÝóåùí
	ls_where = right(ls_where, Len(ls_where) - 5)
	ls_where = "(" + ls_where + ")"


// Áí ib_includewhere = true, ðñïóèÞêç " WHERE "
// Áí åßíáé false ðñïóèÞêç " AND "
// (Ôï " AND " áöáéñÝèçêå ðñïçãïõìÝíùò ãéá íá ìðïõí ðáñåíèÝóåéò)
	if ib_includewhere then
		ls_where = " WHERE " + ls_where
	else
		ls_where = " AND " + ls_where
	end if
	
// ÅðéóôñïöÞ ôïõ ls_where
	closewithreturn(getparent(), ls_where)		
	
	



end event

