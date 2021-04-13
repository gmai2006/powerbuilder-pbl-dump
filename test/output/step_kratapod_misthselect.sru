HA$PBExportHeader$step_kratapod_misthselect.sru
$PBExportComments$
forward
global type step_kratapod_misthselect from bcv_step
end type
type cb_selnone from commandbutton within step_kratapod_misthselect
end type
type cb_selall from commandbutton within step_kratapod_misthselect
end type
type st_1 from statictext within step_kratapod_misthselect
end type
type dw from datawindow within step_kratapod_misthselect
end type
end forward

global type step_kratapod_misthselect from bcv_step
integer width = 2601
integer height = 1260
cb_selnone cb_selnone
cb_selall cb_selall
st_1 st_1
dw dw
end type
global step_kratapod_misthselect step_kratapod_misthselect

type variables
string		is_select
end variables

forward prototypes
public function boolean of_next ()
public subroutine if_retrieve (string as_where)
end prototypes

public function boolean of_next ();// ¸ëåã÷ïò áí Ý÷ïõìå åðéëÝîåé ôïõëÜ÷éóôïí ìßá ìéóèïäïóßá

	boolean	lb_sel

	long	ll_rows, i
	
	ll_rows = dw.rowcount()
	
	lb_sel = false
	
// loop all rows
	integer li_issel
	for i = 1 to ll_rows
		li_issel = dw.object.cm_sel[i]
		if li_issel = 1 then return true
	next
	
// non selected
	MessageBox(trn(94), trn(553))
	return false

end function

public subroutine if_retrieve (string as_where);// get selected kratiseis from kratsel and retrieve

	string	ls_newselect
	
// Ç íÝá select ôáîéíïìçìÝíç êáôÜ çì/íßá
	string	ls_order
	ls_order = " order by misth_final.datefinal, misth_ypal.surname, misth_ypal.name, misth_ypal.fathername "
	ls_newselect = is_select + " " + as_where + " " + ls_order
	
	dw.Modify("DataWindow.Table.Select='" + ls_newselect + "'")
	dw.retrieve(gs_kodxrisi)
	



end subroutine

on step_kratapod_misthselect.destroy
call super::destroy
destroy(this.cb_selnone)
destroy(this.cb_selall)
destroy(this.st_1)
destroy(this.dw)
end on

event constructor;call super::constructor;dw.settransobject(sqlca)

// Initialize is_select 
// override to add where that is present always (xrisi for example)
// replace ' with ~'
	is_select = dw.GetSQLSelect()
	is_select = fn_replace_str(is_select, "'", "~~'")
	
// Translation
	cb_selnone.text = trn(386)
	cb_selall.text = trn(322)
	st_1.text = trn(314)
	
end event

on step_kratapod_misthselect.create
int iCurrent
call super::create
this.cb_selnone=create cb_selnone
this.cb_selall=create cb_selall
this.st_1=create st_1
this.dw=create dw
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selnone
this.Control[iCurrent+2]=this.cb_selall
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw
end on

type cb_selnone from commandbutton within step_kratapod_misthselect
integer x = 407
integer y = 1140
integer width = 375
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "Deselect all"
end type

event clicked;// Êáèáñéóìüò üëùí

	long	ll_rows, i
	
	ll_rows = dw.rowcount()
	
	for i = 1 to ll_rows
		dw.object.cm_sel[i] = 0
	next
end event

type cb_selall from commandbutton within step_kratapod_misthselect
integer y = 1140
integer width = 375
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "Select all"
end type

event clicked;// ÅðéëïãÞ üëùí

	long	ll_rows, i
	
	ll_rows = dw.rowcount()
	
	for i = 1 to ll_rows
		dw.object.cm_sel[i] = 1
	next
end event

type st_1 from statictext within step_kratapod_misthselect
integer x = 27
integer y = 36
integer width = 2537
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type dw from datawindow within step_kratapod_misthselect
integer y = 128
integer width = 2601
integer height = 988
integer taborder = 10
string title = "none"
string dataobject = "dw_step_kratapod_misthselect"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

