HA$PBExportHeader$w_ypal_total_dates_search.srw
$PBExportComments$
forward
global type w_ypal_total_dates_search from window
end type
type uo_sel from uo_misth_ypal_sel within w_ypal_total_dates_search
end type
type uo_dates from u_dates within w_ypal_total_dates_search
end type
type cb_cancel from commandbutton within w_ypal_total_dates_search
end type
type cb_ok from commandbutton within w_ypal_total_dates_search
end type
end forward

global type w_ypal_total_dates_search from window
integer width = 2615
integer height = 1464
boolean titlebar = true
string title = "title"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "res\print.ico"
boolean center = true
uo_sel uo_sel
uo_dates uo_dates
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_ypal_total_dates_search w_ypal_total_dates_search

type variables
boolean		ib_includewhere
end variables

forward prototypes
protected function string of_createwhere ()
public subroutine of_setmasks ()
public function boolean if_check4required ()
end prototypes

protected function string of_createwhere ();string	ls_where

string	lstring
long		llong	
date		ldate
time		ltime
integer	li_hour, li_minute
double	ldouble

// create where for selected ypal
// dates are kept to global helpers gdate1, gdate2

// Get target_dw
	datawindow	ldw_ypal
	ldw_ypal = uo_sel.dw_target

// count rows (selected ypal)
	long		ll_rows
	ll_rows = ldw_ypal.rowcount()
	
// for each ypal add to where
	long	i
	
	for i = 1 to ll_rows
		ls_where = ls_where + " OR kodypal = " + string(ldw_ypal.object.kodypal[i])
	next

// give dates to global helpers
	gdate1 = uo_dates.uf_getdatefrom()
	gdate2 = uo_dates.uf_getdateto()

return ls_where



end function

public subroutine of_setmasks ();// Edit Mask & display Mask


// maskdate, maskdateedit
	fn_seteditmask(uo_dates.dw, "datefrom", fn_param_maskdate_e())
	fn_seteditmask(uo_dates.dw, "dateto", fn_param_maskdate_e())	

end subroutine

public function boolean if_check4required ();// ¸ëåã÷ïò áí Ý÷ïõí åéóá÷èåß üëá ôá êñéôÞñéá

string	lstring	
long		llong	
long		ll_count
date		ldate

// fromdate
	ldate	= uo_dates.uf_getdatefrom()
	if isnull(ldate) then
		Messagebox(gs_app_name, trn(166))
		uo_dates.setfocus()
		uo_dates.dw.setcolumn("datefrom")
		return false
	end if	
	
// todate
	ldate	= uo_dates.uf_getdateto()
	if isnull(ldate) then
		Messagebox(gs_app_name, trn(174))
		uo_dates.setfocus()
		uo_dates.dw.setcolumn("dateto")
		return false
	end if	

// ¸ëåã÷ïò áí Ý÷ïõìå åðéëÝîåé ôïõëÜ÷éóôïí Ýíáí õðÜëëçëï
	llong = uo_sel.dw_target.rowcount()
	if llong = 0 then
		Messagebox(gs_app_name, trn(551))
		uo_sel.setfocus()
		return false
	end if	
	


// ¼ëá ÏÊ
	return true
end function

on w_ypal_total_dates_search.create
this.uo_sel=create uo_sel
this.uo_dates=create uo_dates
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.uo_sel,&
this.uo_dates,&
this.cb_cancel,&
this.cb_ok}
end on

on w_ypal_total_dates_search.destroy
destroy(this.uo_sel)
destroy(this.uo_dates)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;uo_dates.dw.setfocus()
uo_dates.uf_setcaption(trn(372))

uo_sel.dw_source.SetTransObject(sqlca)
uo_sel.dw_source.retrieve(gs_kodxrisi)

// translation
	title = trn(417)
	cb_cancel.text = trn(2)
	cb_ok.text = trn(699)
	
end event

type uo_sel from uo_misth_ypal_sel within w_ypal_total_dates_search
integer x = 27
integer y = 264
integer taborder = 50
end type

on uo_sel.destroy
call uo_misth_ypal_sel::destroy
end on

type uo_dates from u_dates within w_ypal_total_dates_search
integer x = 553
integer y = 16
integer taborder = 40
end type

on uo_dates.destroy
call u_dates::destroy
end on

type cb_cancel from commandbutton within w_ypal_total_dates_search
integer x = 2235
integer y = 1236
integer width = 311
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "Cancel"
boolean cancel = true
end type

event clicked;closewithreturn(getparent(), "")
end event

type cb_ok from commandbutton within w_ypal_total_dates_search
integer x = 1879
integer y = 1236
integer width = 311
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "OK"
boolean default = true
end type

event clicked;string	ls_where

if not if_check4required() then return

ls_where = of_createwhere()


// Áöáßñåóç ôïõ áñ÷éêïý OR (4 ÷áñáêôÞñåò ìå ôá 2 êåíÜ)
// êáé ðñïóèÞêç ðáñåíèÝóåùí
	ls_where = right(ls_where, Len(ls_where)-4)
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

