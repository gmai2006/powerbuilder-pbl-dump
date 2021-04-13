HA$PBExportHeader$w_ypal_sel.srw
$PBExportComments$
forward
global type w_ypal_sel from window
end type
type uo_sel from uo_misth_ypal_sel within w_ypal_sel
end type
type cb_cancel from commandbutton within w_ypal_sel
end type
type cb_ok from commandbutton within w_ypal_sel
end type
end forward

global type w_ypal_sel from window
integer width = 2633
integer height = 1260
boolean titlebar = true
string title = "title"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "res\print.ico"
boolean center = true
uo_sel uo_sel
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_ypal_sel w_ypal_sel

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

return ls_where



end function

public subroutine of_setmasks ();
end subroutine

public function boolean if_check4required ();// ¸ëåã÷ïò áí Ý÷ïõí åéóá÷èåß üëá ôá êñéôÞñéá

string	lstring	
long		llong	
long		ll_count


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

on w_ypal_sel.create
this.uo_sel=create uo_sel
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.uo_sel,&
this.cb_cancel,&
this.cb_ok}
end on

on w_ypal_sel.destroy
destroy(this.uo_sel)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;
uo_sel.dw_source.SetTransObject(sqlca)
uo_sel.dw_source.retrieve(gs_kodxrisi)

// translation
	title = trn(325)
	cb_cancel.text = trn(2)
	cb_ok.text = trn(699)
	
end event

type uo_sel from uo_misth_ypal_sel within w_ypal_sel
integer x = 27
integer y = 28
integer taborder = 50
end type

on uo_sel.destroy
call uo_misth_ypal_sel::destroy
end on

type cb_cancel from commandbutton within w_ypal_sel
integer x = 2235
integer y = 1012
integer width = 311
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "cancel"
boolean cancel = true
end type

event clicked;closewithreturn(getparent(), "")
end event

type cb_ok from commandbutton within w_ypal_sel
integer x = 1879
integer y = 1012
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

