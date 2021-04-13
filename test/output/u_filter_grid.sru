HA$PBExportHeader$u_filter_grid.sru
$PBExportComments$
forward
global type u_filter_grid from u_grid
end type
type pb_savefilter from picturebutton within u_filter_grid
end type
type pb_loadfilter from picturebutton within u_filter_grid
end type
end forward

global type u_filter_grid from u_grid
integer width = 2601
pb_savefilter pb_savefilter
pb_loadfilter pb_loadfilter
end type
global u_filter_grid u_filter_grid

type variables
w_filter		iw_parent
end variables

forward prototypes
public function boolean of_check4required (ref datawindow adw, long row)
end prototypes

public function boolean of_check4required (ref datawindow adw, long row);string	lstring	

// field
	lstring = adw.object.field[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(164))
		adw.setfocus()
		adw.setcolumn("field")
		return false
	end if
	
// operator
	lstring = adw.object.operator[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(165))
		adw.setfocus()
		adw.setcolumn("operator")
		return false
	end if
	
// value
	lstring = adw.object.value[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(183))
		adw.setfocus()
		adw.setcolumn("value")
		return false
	end if
	
// ¸ëåã÷ïò ïñèüôçôáò
	if not iw_parent.fn_isvaluevalid(row) then return false
	
// ¼ëá åíôÜîåé
	return true
	
end function

on u_filter_grid.create
int iCurrent
call super::create
this.pb_savefilter=create pb_savefilter
this.pb_loadfilter=create pb_loadfilter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_savefilter
this.Control[iCurrent+2]=this.pb_loadfilter
end on

on u_filter_grid.destroy
call super::destroy
destroy(this.pb_savefilter)
destroy(this.pb_loadfilter)
end on

event ie_checkbuttons;call super::ie_checkbuttons;// Áí äåí õðÜñ÷ïõí åããñáöÝò áðåíåñãïðïßçóç ôçò áðïèÞêåõóçò
	long	ll_rows
	ll_rows = dw.rowcount()

	if ll_rows < 2 then
		pb_savefilter.enabled = false
	else
		pb_savefilter.enabled = true
	end if

end event

type pb_selectall from u_grid`pb_selectall within u_filter_grid
integer x = 2336
end type

type pb_selectrow from u_grid`pb_selectrow within u_filter_grid
integer x = 2222
end type

type pb_new from u_grid`pb_new within u_filter_grid
integer x = 2057
end type

type pb_last from u_grid`pb_last within u_filter_grid
integer x = 1934
end type

type pb_next from u_grid`pb_next within u_filter_grid
integer x = 1819
end type

type pb_previous from u_grid`pb_previous within u_filter_grid
integer x = 1705
end type

type pb_first from u_grid`pb_first within u_filter_grid
integer x = 1591
boolean map3dcolors = true
end type

type pb_delete from u_grid`pb_delete within u_filter_grid
integer x = 2501
end type

type dw from u_grid`dw within u_filter_grid
integer width = 2601
string dataobject = "edw_filter"
end type

type pb_savefilter from picturebutton within u_filter_grid
integer x = 1303
integer width = 101
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom008!"
alignment htextalign = left!
string powertiptext = ""//trn(101)
end type

event clicked;// ¸ëåã÷ïò êáôá÷ùñÞóåùí
	if not if_update() then return
	
// ÅëÝã÷ïõìå áí äþóáìå óýíäåóç ãéá üëåò ôéò åããñáöÝò - åêôþò áðü ôçí ôåëåõôáßá
// (äåí åëÝã÷åôáé áðü ôçí of_check4required)
	long	ll_rows, i
	string	ls_join
	ll_rows = dw.rowcount()
	for i = 1 to ll_rows - 2 // ü÷é ôçí êåíÞ êáé ôçí ôåëåõôáßá
		ls_join = dw.object.join[i]
		if isnull(ls_join) or ls_join = "" then
			MessageBox(trn(218), trn(199))
			dw.setfocus()
			dw.setrow(i)
			dw.SetColumn("join")
			return
		end if
	next

// ¢íïéãìá ôïõ w_savefilter ãéá ôï is_tablename ôïõ parent
// ¼ëá ãßíïíôáé óôï w_savefilter
	OpenWithParm(w_savefilter, iw_parent)
	

end event

type pb_loadfilter from picturebutton within u_filter_grid
integer x = 1422
integer width = 101
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom007!"
alignment htextalign = left!
string powertiptext = ""//trn(676)
end type

event clicked;// ¢íïéãìá ôïõ w_loadfilter ìå ðáñÜìåôñï ôï iw_parent
// ¼ëåò ïé åíÝñãåéåò ãßíïíôáé óôï w_loadfilter
	OpenWithParm(w_loadfilter, iw_parent)

end event

