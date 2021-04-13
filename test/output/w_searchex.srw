HA$PBExportHeader$w_searchex.srw
$PBExportComments$
forward
global type w_searchex from window
end type
type cb_cancel from commandbutton within w_searchex
end type
type cb_ok from commandbutton within w_searchex
end type
type dw from datawindow within w_searchex
end type
end forward

global type w_searchex from window
integer width = 1737
integer height = 1088
boolean titlebar = true
string title = "title"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_ok cb_ok
dw dw
end type
global w_searchex w_searchex

type variables
boolean		ib_includewhere
end variables

forward prototypes
protected function string of_createwhere ()
public subroutine of_setmasks ()
end prototypes

protected function string of_createwhere ();string	ls_where

string	lstring
long		llong	
date		ldate
time		ltime
integer	li_hour, li_minute
double	ldouble

/*

// string
	lstring = dw.object.xxx[1]
	if not isnull(lstring) and lstring <> "" then
		ls_where = ls_where + " AND xxx LIKE ~~'" + lstring + "%~~'"
	end if
	
// long
	llong = dw.object.xxx[1]
	if not isnull(llong) then
		ls_where = ls_where + " AND xxx = " + string(llong)
	end if
	
// double
	ldouble = dw.object.xxx[1]
	if not isnull(ldouble) then
		ls_where = ls_where + " AND xxx = " + fn_double2string(ldouble)
	end if

	
// ldate
	ldate = dw.object.xxx[1]
	if not isnull(ldate) then
		ls_where = ls_where + " AND xxx = ~~'" + fn_date2string(ldate) + "~~'"
	end if	
	
// ltime
	ltime = dw.object.xxx[1]
	li_hour = hour(ltime)
	li_minute = minute(ltime)
	if not isnull(ltime) then
		ls_where = ls_where + " AND hour(xxx) = " + string(li_hour) + &
									 "	AND minute(xxx) = " + string(li_minute)
	end if	
	
*/

return ls_where



end function

public subroutine of_setmasks ();// Edit Mask & display Mask

/*

// maskdate, maskdateedit
	fn_seteditmask(dw, "xxxxx", fn_param_maskdateedit())
	fn_setformatmask(dw, "xxxxx", fn_param_maskdate())

// maskposo, maskposoedit
	fn_seteditmask(dw, "xxxxx", fn_param_maskposoedit())
	fn_setformatmask(dw, "xxxxx", fn_param_maskposo())
	
// maskposotita, maskposotitaedit
	fn_seteditmask(dw, "xxxxx", fn_param_maskposotitaedit())
	fn_setformatmask(dw, "xxxxx", fn_param_maskposotita())

// masktime, masktimeedit
	fn_seteditmask(dw, "xxxxx", fn_param_masktimeedit())
	fn_setformatmask(dw, "xxxxx", fn_param_masktime())

*/
end subroutine

on w_searchex.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw=create dw
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.dw}
end on

on w_searchex.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw)
end on

event open;dw.SetTransObject(SQLCA)
dw.insertrow(0)

// translation
	title = trn(68)
	cb_ok.text = trn(699)
	cb_cancel.text = trn(2)

end event

type cb_cancel from commandbutton within w_searchex
integer x = 1385
integer y = 864
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

type cb_ok from commandbutton within w_searchex
integer x = 1047
integer y = 864
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

dw.AcceptText()

ls_where = of_createwhere()

// Áí  äåí äþóáìå êñéôÞñéá äåí óõíå÷ßæïõìå
	if ls_where = "" or isnull(ls_where) then
		MessageBox(gs_app_name, trn(698))
		return
	end if

// Áöáßñåóç ôïõ áñ÷éêïý AND (5 ÷áñáêôÞñåò ìå ôá 2 êåíÜ)
// êáé ðñïóèÞêç ðáñåíèÝóåùí
	ls_where = right(ls_where, Len(ls_where)-5)
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

type dw from datawindow within w_searchex
integer x = 27
integer y = 32
integer width = 1669
integer height = 788
integer taborder = 10
string title = "none"
boolean border = false
boolean livescroll = true
end type

