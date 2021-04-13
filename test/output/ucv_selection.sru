HA$PBExportHeader$ucv_selection.sru
$PBExportComments$
forward
global type ucv_selection from userobject
end type
type st_target from statictext within ucv_selection
end type
type st_source from statictext within ucv_selection
end type
type cb_remove_all from commandbutton within ucv_selection
end type
type cb_remove_one from commandbutton within ucv_selection
end type
type cb_add_all from commandbutton within ucv_selection
end type
type cb_add_one from commandbutton within ucv_selection
end type
type dw_target from datawindow within ucv_selection
end type
type dw_source from datawindow within ucv_selection
end type
end forward

global type ucv_selection from userobject
integer width = 1783
integer height = 824
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ie_retrieve ( )
event ie_update ( )
st_target st_target
st_source st_source
cb_remove_all cb_remove_all
cb_remove_one cb_remove_one
cb_add_all cb_add_all
cb_add_one cb_add_one
dw_target dw_target
dw_source dw_source
end type
global ucv_selection ucv_selection

type variables
// Alternative row coloring
	protected 	long			il_rowcolor  = rgb(255,255,255) 
	protected 	long			il_rowrcolor = rgb(255,255,128)		

end variables

forward prototypes
public subroutine fn_initdw (string as_dwobject)
public function datawindow fn_getselecteddw ()
public subroutine of_source2target (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row)
public subroutine of_target2source (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row)
public function boolean of_match (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row)
public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor)
public subroutine of_retrieve_source (ref datawindow adw)
public subroutine of_retrieve_target (ref datawindow adw)
public subroutine of_update_target (ref datawindow adw)
public subroutine if_setbuttons ()
end prototypes

event ie_retrieve();// Set redraw to false for both dw's
	dw_source.setredraw(false)
	dw_target.setredraw(false)

// retrieve both dw's and fix rows 
	of_retrieve_source(dw_source)
	of_retrieve_target(dw_target)

// Set redraw to true
	dw_source.setredraw(true)
	dw_target.setredraw(true)
	
// Set buttons
	if_setbuttons()
			
end event

event ie_update();// call of_update to update target dw
	of_update_target(dw_target)
	commit using sqlca;
end event

public subroutine fn_initdw (string as_dwobject);// ÈÝôåé ôï dw object óôá äýï dw's 
// Starts transaction and retrieve into dw_source

/*

// DataObject
	dw_source.DataObject = as_dwobject
	dw_target.DataObject = as_dwobject
	
// Transaction
	dw_source.SetTransObject(SQLCA)
	dw_target.SetTransObject(SQLCA)
	
// retrieve
	dw_source.retrieve()
	
// Select first row
	dw_source.SetRow(1)
	dw_source.SelectRow(1, true)
	
// ÊáôÜóôáóç êïõìðéþí 
	fn_setbuttons()
	
	
*/
end subroutine

public function datawindow fn_getselecteddw ();// ÅðéóôñÝöåé ôï dw_selected
	
	return dw_target
end function

public subroutine of_source2target (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row);// transfer data from source dw to target
// for the selected row on both
end subroutine

public subroutine of_target2source (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row);// ÌåôáöïñÜ äåäïìÝíùí áðü dw_target ðßóù óôï dw_source
end subroutine

public function boolean of_match (ref datawindow source_dw, long source_row, ref datawindow target_dw, long target_row);// ÅðéóôñÝöåé true áí ïé äýï åããñáöÝò (arguments)
// åßíáé ßäéåò.
// ÐåñéÝ÷åé ôïí Ýëåã÷ï ãéá íá åßíáé ßäéåò ïé åããñáöÝò
// (åëÝã÷åé ôéò ôéìÝò ôùí êëåéäéþí)

return false
end function

public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor);// set row colors (for alternative coloring)
end subroutine

public subroutine of_retrieve_source (ref datawindow adw);// Retrieve source dw
// override for retrieval arguments
	adw.retrieve()
end subroutine

public subroutine of_retrieve_target (ref datawindow adw);// retrieve target dw
// override for retrieval arguments
	adw.retrieve()
end subroutine

public subroutine of_update_target (ref datawindow adw);// update target dw
// override if we don't want to update
	adw.update()

end subroutine

public subroutine if_setbuttons ();// Êáèïñßæåé ôçí êáôÜóôáóç ôùí ðëÞêôñùí
// áíÜëïãá ìå ôéò äéáèÝóéìåò åããñáöÝò


// Âñßóêïõìå ôïí áñéèìü ôùí åããñáöþí óôá äýï dw's
	long	ll_source_rows, ll_target_rows
	ll_source_rows = dw_source.RowCount()
	ll_target_rows  = dw_target.RowCount()
	
// ÊïõìðéÜ ìåôáöïñÜò óôï dw_target
	if ll_source_rows = 0 then
		cb_add_one.enabled = false
		cb_add_all.enabled = false
	else
		cb_add_one.enabled = true
		cb_add_all.enabled = true
	end if
		
// ÊïõìðéÜ ìåôáöïñÜò ðßóù óôï dw_source
	if ll_target_rows = 0 then
		cb_remove_one.enabled = false
		cb_remove_all.enabled = false
	else
		cb_remove_one.enabled = true
		cb_remove_all.enabled = true
	end if

end subroutine

on ucv_selection.create
this.st_target=create st_target
this.st_source=create st_source
this.cb_remove_all=create cb_remove_all
this.cb_remove_one=create cb_remove_one
this.cb_add_all=create cb_add_all
this.cb_add_one=create cb_add_one
this.dw_target=create dw_target
this.dw_source=create dw_source
this.Control[]={this.st_target,&
this.st_source,&
this.cb_remove_all,&
this.cb_remove_one,&
this.cb_add_all,&
this.cb_add_one,&
this.dw_target,&
this.dw_source}
end on

on ucv_selection.destroy
destroy(this.st_target)
destroy(this.st_source)
destroy(this.cb_remove_all)
destroy(this.cb_remove_one)
destroy(this.cb_add_all)
destroy(this.cb_add_one)
destroy(this.dw_target)
destroy(this.dw_source)
end on

event constructor;// Initialize dw's
	dw_source.SetTransObject(sqlca)
	dw_target.SetTransObject(sqlca)

// Make alternative row coloring
	of_setrowcolors(il_rowcolor, il_rowrcolor)
	dw_source.Modify("DataWindow.Detail.Color= '536870912~tif(mod(getrow(), 2) = 1, " + string(il_rowcolor) + ", " + string(il_rowrcolor) + ")'")
	dw_target.Modify("DataWindow.Detail.Color= '536870912~tif(mod(getrow(), 2) = 1, " + string(il_rowcolor) + ", " + string(il_rowrcolor) + ")'")

// CheckButtons
	if_setbuttons()	
end event

type st_target from statictext within ucv_selection
integer x = 1070
integer y = 20
integer width = 663
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
long backcolor = 67108864
string text = "target"
boolean focusrectangle = false
end type

type st_source from statictext within ucv_selection
integer x = 23
integer y = 20
integer width = 663
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
long backcolor = 67108864
string text = "source"
boolean focusrectangle = false
end type

type cb_remove_all from commandbutton within ucv_selection
integer x = 763
integer y = 612
integer width = 247
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "<<"
end type

event clicked;// ÌåôáöïñÜ üëùí áðü ôï dw_target óôï dw_source
	
// Set redraw false for both dw's
	dw_source.SetRedraw(false)
	dw_target.SetRedraw(false)

// ÐñïóèÝôïõìå üëåò ôéò åããñáöÝò ôïõ dw_source óôï dw_target
	long	ll_target_rows, &
			i
	
	ll_target_rows = dw_target.rowcount()
	
	for i = 1 to ll_target_rows
		
		// Set row and trigger event cb_add_one
			dw_target.setrow(i)
			cb_remove_one.Triggerevent(clicked!)
			
	next

// Set redraw true for both dw's
	dw_source.SetRedraw(true)
	dw_target.SetRedraw(true)

end event

type cb_remove_one from commandbutton within ucv_selection
integer x = 763
integer y = 460
integer width = 247
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "<"
end type

event clicked;// ÄéáãñÜöåé ôçí åðéëïãÞ óôï dw_target êáé ôçí ðñïóèÝôåé óôï dw_source
	
// Set redraw false for both dw's
	dw_source.SetRedraw(false)
	dw_target.SetRedraw(false)

// Âñßóêïõìå ôçí åðéëåãìÝíç åããñáöÞ ôïõ dw_target
	long	ll_target_row
	ll_target_row = dw_target.GetRow()
	if ll_target_row = 0 then return

// ÐñïóèÝôïõìå ìßá åããñáöÞ óôï dw_source
	long	ll_source_row
	ll_source_row = dw_source.InsertRow(0)
	
// ÌåôáöïñÜ äåäïìÝíùí
	of_target2source(dw_source, ll_source_row, dw_target, ll_target_row)
	
// ÄéáãñáöÞ ôçò åðéëåãìÝíçò ãñáììÞò óôï dw_target
// êáé åðéëïãÞ ôçò ðñïçãïýìåíçò
	dw_target.Deleterow(ll_target_row)
	ll_target_row = ll_target_row - 1
	if ll_target_row = 0 then ll_target_row = 1
	dw_target.SetRow(ll_target_row)
	dw_target.ScrollToRow(ll_target_row)
	dw_target.Selectrow(ll_target_row, true)
	
// ÅðéëïãÞ ôçò íÝáò ãñáììÞò óôï dw_source
	dw_source.Setrow(ll_target_row)
	dw_source.Selectrow(0, false)
	dw_source.ScrollToRow(ll_target_row)
	dw_source.SelectRow(ll_target_row, true)
	
// Set redraw to true for both
	dw_source.SetRedraw(true)
	dw_target.SetRedraw(true)
	
// Êáèïñßæïõìå ôçí êáôÜóôáóç ôùí ðëÞêôñùí
	if_setbuttons()

end event

type cb_add_all from commandbutton within ucv_selection
integer x = 763
integer y = 308
integer width = 247
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = ">>"
end type

event clicked;// ÌåôáöïñÜ üëùí áðü ôï dw_source óôï dw_target
	
// Set redraw false for both dw's
	dw_source.SetRedraw(false)
	dw_target.SetRedraw(false)

// ÐñïóèÝôïõìå üëåò ôéò åããñáöÝò ôïõ dw_source óôï dw_target
	long	ll_source_rows, &
			i
	
	ll_source_rows = dw_source.rowcount()
	
	for i = 1 to ll_source_rows
		
		// Set row and trigger event cb_add_one
			dw_source.setrow(i)
			cb_add_one.Triggerevent(clicked!)
			
	next

// Set redraw true for both dw's
	dw_source.SetRedraw(true)
	dw_target.SetRedraw(true)

end event

type cb_add_one from commandbutton within ucv_selection
integer x = 763
integer y = 156
integer width = 247
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = ">"
end type

event clicked;// ÄéáãñÜöåé ôçí åðéëïãÞ óôï dw_source êáé ôçí ðñïóèÝôåé óôï dw_target
	
// Set redraw false for both dw's
	dw_source.SetRedraw(false)
	dw_target.SetRedraw(false)

// Âñßóêïõìå ôçí åðéëåãìÝíç åããñáöÞ ôïõ dw_source
	long	ll_source_row
	ll_source_row = dw_source.GetRow()
	if ll_source_row = 0 then return

// ÐñïóèÝôïõìå ìßá åããñáöÞ óôï dw_target 
	long	ll_target_row
	ll_target_row = dw_target.InsertRow(0)
	
// ÌåôáöïñÜ äåäïìÝíùí
	of_source2target(dw_source, ll_source_row, dw_target, ll_target_row)
	
// ÄéáãñáöÞ ôçò åðéëåãìÝíçò ãñáììÞò óôï dw_source
// êáé åðéëïãÞ ôçò ðñïçãïýìåíçò
	dw_source.Deleterow(ll_source_row)
	ll_source_row = ll_source_row - 1
	if ll_source_row = 0 then ll_source_row = 1
	dw_source.SetRow(ll_source_row)
	dw_source.ScrollToRow(ll_source_row)
	dw_source.Selectrow(ll_source_row, true)
	
// ÅðéëïãÞ ôçò íÝáò ãñáììÞò óôï dw_target
	dw_target.Setrow(ll_target_row)
	dw_target.Selectrow(0, false)
	dw_target.ScrollToRow(ll_target_row)
	dw_target.SelectRow(ll_target_row, true)
	
// Set redraw to true for both
	dw_source.SetRedraw(true)
	dw_target.SetRedraw(true)
	
// Êáèïñßæïõìå ôçí êáôÜóôáóç ôùí ðëÞêôñùí
	if_setbuttons()

end event

type dw_target from datawindow within ucv_selection
integer x = 1070
integer y = 100
integer width = 677
integer height = 684
integer taborder = 10
string title = "none"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanging;this.SelectRow(currentrow, false)
this.SelectRow(newrow, true)
end event

event doubleclicked;// Ðñïóïìïßùóç cb_remove_one
	if row > 0 then cb_remove_one.TriggerEvent(clicked!)
end event

event retrieverow;
// Áí ç íÝá åããñáöÞ õðÜñ÷åé óôï dw_source (of_match)
// ôüôå ôçí äéáãñÜöïõìå áðü ôï dw_source
// Õðïôßèåôáé üôé ôï retrieve óôï dw_source Ý÷åé ãßíåé (óôï ie_retrieve)

// Ðáßñíïõìå ôïí áñéèìü ôùí åããñáöþí ôïõ dw_source
	long	ll_source_rows
	ll_source_rows = dw_source.rowcount()
	
// ¸ëåã÷ïò ôçò íÝáò retrieved åããñáöÝò ìå üëåò ôïõ dw_source
// êáé äéáãñáöÞ áí õðÜñ÷åé. ÌåôÜ ôçí äéáãñáöÞ äåí óõíå÷ßæïõìå
// ìå ôçí åîÝôáóç ôùí åðïìÝíùí (ìßá ìüíï åããñáöÞ õðÜñ÷åé)
	long	i
	for i = 1 to ll_source_rows
		if of_match(dw_source, i, dw_target, row) then
			dw_source.deleterow(i)
			return
		end if
	next
	

end event

event retrieveend;if rowcount > 0 then
	this.SetRow(1)
	this.Selectrow(1, true)
end if
end event

type dw_source from datawindow within ucv_selection
integer x = 23
integer y = 100
integer width = 677
integer height = 684
integer taborder = 10
string title = "none"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanging;this.SelectRow(currentrow, false)
this.SelectRow(newrow, true)
end event

event doubleclicked;// Ðñïóïìïßùóç cb_add_one
	if row > 0 then cb_add_one.TriggerEvent(clicked!)
end event

event retrieveend;if rowcount > 0 then
	this.SetRow(1)
	this.Selectrow(1, true)
end if
end event

