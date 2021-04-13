HA$PBExportHeader$u_grid.sru
$PBExportComments$
forward
global type u_grid from userobject
end type
type pb_selectall from picturebutton within u_grid
end type
type pb_selectrow from picturebutton within u_grid
end type
type pb_new from picturebutton within u_grid
end type
type pb_last from picturebutton within u_grid
end type
type pb_next from picturebutton within u_grid
end type
type pb_previous from picturebutton within u_grid
end type
type pb_first from picturebutton within u_grid
end type
type pb_delete from picturebutton within u_grid
end type
type dw from datawindow within u_grid
end type
end forward

global type u_grid from userobject
integer width = 2048
integer height = 1008
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ie_checkbuttons ( )
pb_selectall pb_selectall
pb_selectrow pb_selectrow
pb_new pb_new
pb_last pb_last
pb_next pb_next
pb_previous pb_previous
pb_first pb_first
pb_delete pb_delete
dw dw
end type
global u_grid u_grid

type variables
protected boolean	ib_edit, &
						ib_newrec
						
// Alternative row coloring
protected long		il_rowcolor  = rgb(255,255,255) 
protected long		il_rowrcolor = rgb(255,255,128)

// autoupdate - Áí åßíáé true update when row changing
protected boolean	ib_autoupdate	

// Sorting	
protected boolean ib_sort = true

// ¸ëåã÷ïò äéêáéùìÜôùí
protected string	is_tablename


end variables

forward prototypes
public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor)
public subroutine of_initrow (ref datawindow adw, long row)
public function boolean of_check4required (ref datawindow adw, long row)
public function boolean of_checkdelete (ref datawindow adw, long row)
public subroutine of_postinitrow (ref datawindow adw, long row)
public subroutine if_checkmodified (long row)
public subroutine if_insertrow ()
public function boolean if_update ()
public subroutine of_setmasks ()
end prototypes

event ie_checkbuttons();long	ll_nrows, ll_row

// Óýíïëï åããñáöþí êáé ôñÝ÷ïõóá åããñáöÞ
	ll_nrows = dw.rowcount()
	ll_row = dw.getrow()
	
// ÅðáíáöÝñïõìå üëá óå åíåñãü êáôÜóôáóç êáé áðåíåñãïðïéïýìå áíÜëïãá
	pb_delete.enabled = true
	pb_selectrow.enabled = true
	pb_selectall.enabled = true
		
	pb_first.enabled = true
	pb_previous.enabled = true
	pb_next.enabled = true
	pb_last.enabled = true
	pb_new.enabled = true
	

// Áí äåí õðÜñ÷ïõí åããñáöÝò ðáñÜ ìüíï ç íÝá
	if ll_nrows = 1 then
		pb_delete.enabled = false
		pb_selectrow.enabled = false
		pb_selectall.enabled = false
		pb_first.enabled = false
		pb_previous.enabled = false
		pb_next.enabled = false
		pb_last.enabled = false
		pb_new.enabled = false
		return
	end if
		
// Åßìáóôå óôçí ôåëåõôáßá åããñáöÞ (íÝá) áëëÜ õðÜñ÷ïõí êáé Üëëåò
	if ll_row = ll_nrows and ll_nrows > 1 then
		pb_selectrow.enabled = false
		pb_new.enabled = false
		pb_next.enabled = false
		pb_delete.enabled = false
		return
	end if	
	
// Åßìáóôå óôçí ðñþôç åããñáöÞ êáé õðÜñ÷ïõí êáé Üëëåò
	if ll_row = 1 and ll_nrows > 1 then
		pb_first.enabled = false
		pb_previous.enabled = false
		
		// Áí åßíáé êáé ç ìïíáäéêÞ åããñáöÞ (ðñïôåëåõôáßá)
		if ll_row = ll_nrows - 1 then
			pb_last.enabled = false
		end if
		
		return
	end if
	
// Áí åßìáóôå óôçí ðñïôåëåõôáßá (ðñéí ôçí íÝá)
	if ll_row = ll_nrows - 1 then
		pb_last.enabled = false
		return
	end if
	
end event

public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor);// Set alternate colors
end subroutine

public subroutine of_initrow (ref datawindow adw, long row);// Initialize new row
end subroutine

public function boolean of_check4required (ref datawindow adw, long row);/*
string	lstring	
long		llong	
date		ldate
time		ltime

if row = adw.rowcount() then return true

// string
	lstring = adw.object.xxx[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, ".....")
		adw.setfocus()
		adw.setcolumn("xxx")
		return false
	end if
	
	// ¸ëåã÷ïò áí ï êùäéêüò õðÜñ÷åé
		ll_found = adw.find("xxx = '" + lstring + "'", 1, adw.rowcount())
		if ll_found = row then ll_found = adw.find("xxx = '" + lstring + "'", ll_found + 1, adw.rowcount())
		if ll_found > 0 and ll_found <> row then
			MessageBox(gs_app_name, trn(133))
			adw.setfocus()
			adw.Setcolumn("xxx")
			return false
		end if		

// long
	llong	= adw.object.xxx[row]
	if isnull(llong) then
		Messagebox(gs_app_name, ".....")
		adw.setfocus()
		adw.setcolumn("xxx")
		return false
	end if
	
// date
	ldate	= adw.object.xxx[row]
	if isnull(ldate) then
		Messagebox(gs_app_name, ".....")
		adw.setfocus()
		adw.setcolumn("xxx")
		return false
	end if	
	
// time
	ltime	= adw.object.xxx[row]
	if isnull(ltime) then
		Messagebox(gs_app_name, ".....")
		adw.setfocus()
		adw.setcolumn("xxx")
		return false
	end if	

*/
	
// everything ok
	return true
end function

public function boolean of_checkdelete (ref datawindow adw, long row);// Check for delete rules for the current row

	return true
end function

public subroutine of_postinitrow (ref datawindow adw, long row);// Initialize row after edit has started
// usefull for autonumber
end subroutine

public subroutine if_checkmodified (long row);// Checks if row has been modified and sets ib_edit


// Check row status
	dwitemstatus	li_rowstatus
	dw.AcceptText()

	li_rowstatus = dw.GetItemStatus(row, 0, primary!)
	
// if row has been modified
	if li_rowstatus = DataModified! or li_rowstatus = NewModified! then
	
		// Set edit flag (for update to be allowed)
			ib_edit = true
	
		// if this is the last row add an empty one and set newrec flag
		// call of_postinitrow()
			if row = dw.rowcount() then
				of_postinitrow(dw, row)
				if_insertrow()
				ib_newrec = true
			end if	
			
	end if
end subroutine

public subroutine if_insertrow ();// Insert a new row at the end
	long	ll_newrow
	ll_newrow =	dw.Insertrow(0)
	
// Initialize but clear modified flag
	of_initrow(dw, ll_newrow)
	dw.SetItemStatus(ll_newrow, 0, Primary!, NotModified!)
	
	TriggerEvent("ie_checkbuttons")
end subroutine

public function boolean if_update ();// update dw (return true if succeded)
	long	ll_row
	integer	li_ret
	
// Update only when ib_edit = true
// Return true to allow row changing
	if not ib_edit then return true
		
	dw.AcceptText()

// Check for required field and update
	ll_row = dw.getrow()
	if ll_row > 0 and ll_row < dw.rowcount() then 
		if not of_check4required(dw, ll_row) then return false
	end if
	
	if ib_autoupdate then
		li_ret = dw.update()
		commit using sqlca;
		if li_ret <> 1 then return false
	end if
	
// Clear flags and commit
	ib_newrec = false
	
	
	return true
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

on u_grid.create
this.pb_selectall=create pb_selectall
this.pb_selectrow=create pb_selectrow
this.pb_new=create pb_new
this.pb_last=create pb_last
this.pb_next=create pb_next
this.pb_previous=create pb_previous
this.pb_first=create pb_first
this.pb_delete=create pb_delete
this.dw=create dw
this.Control[]={this.pb_selectall,&
this.pb_selectrow,&
this.pb_new,&
this.pb_last,&
this.pb_next,&
this.pb_previous,&
this.pb_first,&
this.pb_delete,&
this.dw}
end on

on u_grid.destroy
destroy(this.pb_selectall)
destroy(this.pb_selectrow)
destroy(this.pb_new)
destroy(this.pb_last)
destroy(this.pb_next)
destroy(this.pb_previous)
destroy(this.pb_first)
destroy(this.pb_delete)
destroy(this.dw)
end on

event constructor;// Initialize dw_main
	dw.SetTransObject(sqlca)
	
// Make selected row appear sunken
	string	ls_ncols
	integer	li_ncols, i
	ls_ncols = dw.Object.DataWindow.Column.Count
	li_ncols = integer(ls_ncols)
	for i = 1 to li_ncols
		dw.Modify("#"+ string(i) + ".Border='0~tif(getrow() = currentrow(), 5, 0)'")
	next
	
// Make alternative row coloring
	of_setrowcolors(il_rowcolor, il_rowrcolor)
	dw.Modify("DataWindow.Detail.Color= '536870912~tif(mod(getrow(), 2) = 1, " + string(il_rowcolor) + ", " + string(il_rowrcolor) + ")'")
	
// check buttons
	TriggerEvent("ie_checkbuttons")
	
// ¸ëåã÷ïò äéêáéùìÜôùí
	if not fn_perm(is_tablename, "editrec") then dw.enabled = false
	
// Set masks
	of_setmasks()
	
// Insert a new record at the end
	if_insertrow()
	
// reset flags	
	ib_edit = false
	ib_newrec = false
	
end event

type pb_selectall from picturebutton within u_grid
integer x = 1783
integer width = 101
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "SelectAll!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = ""//trn(322)
end type

event clicked;// ÅðéëïãÞ üëùí ôùí åããñáöþí
// åêôþò áðü ôçí ôåëåõôáßá
	dw.SetRedraw(false)

	dw.SelectRow(0, true)
	dw.SelectRow(dw.rowcount(), false)
	
	dw.SetRedraw(true)
end event

type pb_selectrow from picturebutton within u_grid
integer x = 1669
integer width = 101
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "SingleLineEdit!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = ""//trn(316)
end type

event clicked;// ÅðéëïãÞ ôçò ôñÝ÷ïõóáò åããñáöÞò
// (áðü åðéëïãÞ ôõ÷üí ðñïçãïýìåíçò)
	long	ll_currentrow
	ll_currentrow = dw.getrow()
	if ll_currentrow = 0 then return
	
	dw.SelectRow(0, false)
	dw.SelectRow(ll_currentrow, true)
end event

type pb_new from picturebutton within u_grid
integer x = 1504
integer width = 101
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "New!"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;// Ìåôáêßíçóç óå íÝá åããñáöÞ
	long	ll_newrow
	ll_newrow = dw.rowcount()
	
	dw.SelectRow(0, false)	// Êáèáñéóìüò åðéëïãÞò
	
	dw.SetRow(ll_newrow)
	dw.ScrolltoRow(ll_newrow)
	dw.SetColumn(1)
end event

type pb_last from picturebutton within u_grid
integer x = 1381
integer width = 110
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "VCRLast!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = ""//trn(633)
end type

event clicked;// Ìåôáêßíçóç óôçí ôåëåõôáßá åããñáöÞ
// (Óôçí ïõóßá åßíáé ç ðñïôåëåõôáßá áöïý ç ôåëåõôáßá åßíáé ç íÝá)
	
	long	ll_lastrow
	
	ll_lastrow = dw.rowcount() - 1
	
	dw.SelectRow(0, false)	// Êáèáñéóìüò åðéëïãÞò	
	
	dw.setrow(ll_lastrow)
	dw.ScrollToRow(ll_lastrow)
	

end event

type pb_next from picturebutton within u_grid
integer x = 1266
integer width = 101
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "VCRNext!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = ""//trn(331)
end type

event clicked;// Ìåôáêßíçóç óôçí åðüìåíç åããñáöÞ
// (áí äåí åßìáóôå óôçí ôåëåõôáßá)
	
	long	ll_row
	
	ll_row = dw.getrow()

	if ll_row = dw.rowcount() then return	// åßìáóôå óôçí ôåëåõôáßá
	
	dw.SelectRow(0, false)	// Êáèáñéóìüò åðéëïãÞò
	
	dw.SetRow(ll_row + 1)
	dw.ScrollToRow(ll_row + 1)
	

end event

type pb_previous from picturebutton within u_grid
integer x = 1152
integer width = 101
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "VCRPrior!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = ""//trn(562)
end type

event clicked;// Ìåôáêßíçóç óôçí ðñïçãïýìåíç åããñáöÞ
// (áí äåí åßìáóôå óôçí ðñþôç)

	long	ll_row
	
	ll_row = dw.getrow()
	
	if ll_row <= 1 then return		// åßìáóôå óôçí ðñþôç
	
	dw.SelectRow(0, false)	// Êáèáñéóìüò åðéëïãÞò	
	
	dw.setrow(ll_row - 1)
	dw.ScrollToRow(ll_row - 1)
end event

type pb_first from picturebutton within u_grid
integer x = 1038
integer width = 101
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "VCRFirst!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = ""//trn(577)
end type

event clicked;// Ìåôáêßíçóç óôçí ðñþôç åããñáöÞ

	dw.SelectRow(0, false)	// Êáèáñéóìüò åðéëïãÞò
	
	dw.SetRow(1)
	dw.ScrollToRow(1)
	
end event

type pb_delete from picturebutton within u_grid
integer x = 1947
integer width = 101
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = ""//trn(222)
end type

event clicked;// ÄéáãñáöÞ ôñÝ÷ïõóáò åããñáöÞò Þ üëùí ôùí åðéëåãìÝíùí

integer	li_ret
long		ll_currentrow, ll_firstselected, ll_nextselected, ll_nrows

// ¸ëåã÷ïò äéêáéùìÜôùí	
	if not fn_perm(is_tablename, "DELETE") then return

// ÁíáíÝùóç ôùí äåäïìÝíùí
	if_update()

// Ðáßñíïõìå ôçí ôñÝ÷ïõóá åããñáöÞ, ôï óýíïëï ôùí åããñáöþí êáé ôçí ðñþôç åðéëåãìÝíç
	ll_currentrow = dw.getrow()
	ll_firstselected = dw.GetSelectedRow(0)
	ll_nrows = dw.rowcount()
	
// -----------------------------------------------------------------------------
// Äåí õðÜñ÷ïõí åðéëåãìÝíåò åããñáöÝò - ÄéáãñáöÞ ôñÝ÷ïõóáò
// -----------------------------------------------------------------------------
	
	if ll_firstselected = 0 then
		
		// Áí äåí õðÜñ÷åé ôñÝ÷ïõóá åããñáöÞ Þ åßíáé ç ôåëåõôáßá (new record) 
		// äåí äéáãñÜöïõìå
		if ll_currentrow = 0 or ll_currentrow = ll_nrows then return
		
		// Check for delete rules
		if not of_checkdelete(dw, ll_currentrow) then return
		
		// ÅðáëÞèåõóç
		li_ret = MessageBox(trn(223), trn(456), Exclamation!, OKCancel!, 2)
		if not li_ret = 1 then return
		
		// ÄéáãñáöÞ ôñÝ÷ïõóáò åããñáöÞò (õðÜñ÷åé êáé äåí åßíáé ç ôåëåõôáßá)
		dw.SetRedraw(false)
		dw.deleterow(ll_currentrow)
		ib_edit = true		// to allow if_update() to proceed
		if_update()			// reset ib_newrec, ib_edit
		
		// ÅðéëïãÞ ðñïçãïýìåíçò
		ll_currentrow = ll_currentrow - 1
		if ll_currentrow = 0 then ll_currentrow = 1
		dw.SetRow(ll_currentrow)
		dw.ScrollToRow(ll_currentrow)
		
		// ÅðéóôñïöÞ
		dw.SetRedraw(true)
		
		getparent().TriggerEvent("ie_checkbuttons")
		
		return
		
	end if	// if ll_firstselected = 0

// -----------------------------------------------------------------------------
// ÕðÜñ÷ïõí åðéëåãìÝíåò åããñáöÝò - ÄéáãñáöÞ üëùí
// -----------------------------------------------------------------------------
	
	ll_nextselected = ll_firstselected
	
	// Ôï ìýíçìá åðáëÞèåõóçò åìöáíßæåôáé ìßá öïñÜ ãéá üëåò ôéò åðéëåãìÝíåò åããñáöÝò
	// Áí ç ðñþôç åðéëåãìÝíç åããñáöÞ åßíáé ç ôåëåõôáßá (new record)
	// äåí äéáãñÜöåôáé ïýôå åìöáíßæåôáé ôï ìÞíõìá
	if ll_nextselected = ll_nrows then return
	li_ret = MessageBox(trn(224), trn(457), Exclamation!, OKCancel!, 2)
	if not li_ret = 1 then return	
	
	dw.SetRedraw(false)
	
	do while not ll_nextselected = 0
	
		// Áí åßíáé ç ôåëåõôáßá (new record) äåí ôçí äéáãñÜöïõìå
		// (÷ñçóéìïðïéïýìå ôçí rowcount() ãéá íá
		// åðáíáõðïëïãßæïõìå ìåôÜ áðü êÜèå äéáãñáöÞ)
		if ll_nextselected = dw.rowcount() then exit
		
		// Check for delete rules 
		// ÄéáêïðÞ ôçò äéáãñáöÞò óôçí ðñþôç åããñáöÞ üðïõ of_checkdelete() = false
		if not of_checkdelete(dw, ll_nextselected) then exit
		
		// ÄéáãñáöÞ ôñÝ÷ïõóáò åðéëïãÞò (õðÜñ÷åé êáé äåí åßíáé ç ôåëåõôáßá)
		dw.deleterow(ll_nextselected)
		ib_edit = true		// to allow if_update() to proceed
		if_update()			// reset ib_newrec, ib_edit
		
		// Ðáßñíïõìå ôçí åðüìåíç åðéëïãÞ 
		// (ðÜëé áðü ôçí áñ÷Þ)
		ll_nextselected = dw.GetSelectedRow(0)

	loop

// ÅðéëÝãïõìå ôçí ðñïçãïýìåíç ìåôÜ ôçí ðñþôç åðéëåãìÝíç
		ll_currentrow = ll_firstselected - 1
		if ll_currentrow = 0 then ll_currentrow = 1
		dw.SetRow(ll_currentrow)
		dw.ScrollToRow(ll_currentrow)

// Êáèáñßæïõìå ôçí åðéëïãÞ (ßóùò ìåßíåé ç ôåëåõôáßá åðéëåãìÝíç)
	dw.SelectRow(0, false)
	dw.SetRedraw(true)
	
	getparent().TriggerEvent("ie_checkbuttons")
	

	
end event

type dw from datawindow within u_grid
event ue_keydown pbm_dwnkey
event ue_lbuttonup pbm_dwnlbuttonup
integer y = 112
integer width = 2057
integer height = 896
integer taborder = 10
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;long	ll_row

choose case key
		
	case KeyEscape!	// Áí åßìáóôå óå íÝá åããñáöÞ äéáãñáöÞ ôçò
		ll_row = this.getrow()
		if ib_newrec then
			this.deleterow(ll_row)
			ib_newrec = false
			ib_edit = false
			getparent().TriggerEvent("ie_checkbuttons")
		end if
				
end choose
end event

event ue_lbuttonup;// Check if row has been modified
	this.AcceptText()		
	if_checkmodified(row)
end event

event clicked;// Êáèáñéóìüò åðéëåãìÝíùí åããñáöþí
// Áí åßíáé ðáôçìÝíï ôï ctrl ðïëëáðëÞ åðéëïãÞ
// Äåí åðéëÝãïõìå ôçí ôåëåõôáßá (íÝá) åããñáöÞ
// Áí ç åããñáöÞ åßíáé Þäç åðéëåãìÝíç ôçí áðïåðéëÝãïõìå
	if keydown(KeyControl!) then 
		if row < dw.rowcount() then
			if dw.IsSelected(row) then
				dw.SelectRow(row, false)
			else
				dw.SelectRow(row, true)
			end if
		end if
	else
		dw.SelectRow(0, false)
	end if
	
	
// ----------------------------------------------------------------------	
// Ôáîéíüìçóç
// ----------------------------------------------------------------------	

String	ls_old_sort, ls_column
char		lc_sort

// ¸ëåã÷ïò áí åðéôñÝðåôáé ç ôáîéíüìçóç
	if not ib_sort then return

// Check whether the user clicks on the column header
	if Right(dwo.name,2) = '_t' then
		ls_column = left(dwo.name, len(string(dwo.name))-2)
		
		// delete the last empty row (new rec)
		// to not be included in sorting
			dw.SetRedraw(false)
			dw.DeleteRow(dw.rowcount())
		
		// Get old sort, if any
			ls_old_sort = dw.Describe("Datawindow.Table.sort")
			
		// Check whether previously sorted columhn and currently clicked
		// column are same or not. If both are same then check for the sort
		// order of previously sorted column (A - Asc, D - Desc) and change it.
		// If both are not same then simply sort it by Ascending order
			if ls_column = left(ls_old_sort, len(ls_old_sort)-2) then
				lc_sort = right(ls_old_sort,1)
				if lc_sort = 'A' then 
					lc_sort = 'D'
				else
					lc_sort = 'A'
				end if
				dw.SetSort(ls_column + " " + lc_sort)
			else
				dw.SetSort(ls_column + " A")
			end if
		dw.Sort()
		
		// Select firt row
			dw.SetRow(1)
			dw.ScrollToRow(1)
			
		// Insert the deleted new row again
			if_insertrow()
			dw.SetRedraw(true)

	end if
end event

event editchanged;if_checkmodified(row)
end event

event retrieveend;// Insert a new record at the end
	if_insertrow()
	
// reset flags	
	ib_edit = false
	ib_newrec = false
end event

event rowfocuschanging;// update - if failed prevent row changing
	
	if not if_update() then
		dw.setfocus()
		return 1
	else
		selectrow(currentrow, false)
		selectrow(newrow, true)
	end if
	
end event

event rowfocuschanged;getparent().TriggerEvent("ie_checkbuttons")
end event

event itemchanged;if_checkmodified(row)
end event

