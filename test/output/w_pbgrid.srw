HA$PBExportHeader$w_pbgrid.srw
$PBExportComments$
forward
global type w_pbgrid from window
end type
type dw_main from datawindow within w_pbgrid
end type
end forward

global type w_pbgrid from window
integer width = 2007
integer height = 1720
boolean titlebar = true
string menuname = "m_main_pbgrid"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event me_refresh ( )
event me_save ( )
event me_delrec ( )
event me_selrec ( )
event me_movetonew ( )
event me_movetofirst ( )
event me_movetolast ( )
event me_movetonext ( )
event me_movetoprev ( )
event me_selectall ( )
event me_cut ( )
event me_copy ( )
event me_paste ( )
event me_clear ( )
event me_undo ( )
event me_close ( )
event ie_exit ( )
event ie_checkmenu ( )
event me_find ( )
dw_main dw_main
end type
global w_pbgrid w_pbgrid

type variables
protected boolean	ib_edit, &
						ib_newrec
						
// Alternative row coloring
protected long		il_rowcolor  = rgb(255,255,255) 
protected long		il_rowrcolor = rgb(255,255,128)

// ¸ëåã÷ïò äéêáéùìÜôùí
protected string	is_tablename
end variables

forward prototypes
public subroutine of_initrow (ref datawindow adw, long row)
public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor)
public function boolean of_checkdelete (ref datawindow adw, long row)
public subroutine if_insertrow ()
public function long if_retrieve ()
public function boolean if_update ()
public subroutine of_postinitrow (ref datawindow adw, long row)
public subroutine if_checkmodified (long row)
public function boolean of_check4required (ref datawindow adw, long row)
public subroutine of_setmasks ()
public subroutine of_open ()
end prototypes

event me_refresh();dw_main.SetRedraw(false)
if_retrieve()
dw_main.SetRow(1)
dw_main.SelectRow(0, false)
dw_main.SelectRow(1, true)
dw_main.SetRedraw(true)
end event

event me_save();if_update()
end event

event me_delrec();// ÄéáãñáöÞ ôñÝ÷ïõóáò åããñáöÞò Þ üëùí ôùí åðéëåãìÝíùí

integer	li_ret
long		ll_currentrow, ll_firstselected, ll_nextselected, ll_nrows

// ¸ëåã÷ïò äéêáéùìÜôùí
	if not fn_perm(is_tablename, "delrec") then return

// ÁíáíÝùóç ôùí äåäïìÝíùí
	if_update()

// Ðáßñíïõìå ôçí ôñÝ÷ïõóá åããñáöÞ, ôï óýíïëï ôùí åããñáöþí êáé ôçí ðñþôç åðéëåãìÝíç
	ll_currentrow = dw_main.getrow()
	ll_firstselected = dw_main.GetSelectedRow(0)
	ll_nrows = dw_main.rowcount()
	
// -----------------------------------------------------------------------------
// Äåí õðÜñ÷ïõí åðéëåãìÝíåò åããñáöÝò - ÄéáãñáöÞ ôñÝ÷ïõóáò
// -----------------------------------------------------------------------------
	
	if ll_firstselected = 0 then
		
		// Áí äåí õðÜñ÷åé ôñÝ÷ïõóá åããñáöÞ Þ åßíáé ç ôåëåõôáßá (new record) 
		// äåí äéáãñÜöïõìå
		if ll_currentrow = 0 or ll_currentrow = ll_nrows then return
		
		// Check for delete rules
		if not of_checkdelete(dw_main, ll_currentrow) then return
		
		// ÅðáëÞèåõóç
		li_ret = MessageBox(trn(223), trn(456), Exclamation!, OKCancel!, 2)
		if not li_ret = 1 then return
		
		// ÄéáãñáöÞ ôñÝ÷ïõóáò åããñáöÞò (õðÜñ÷åé êáé äåí åßíáé ç ôåëåõôáßá)
		dw_main.SetRedraw(false)
		dw_main.deleterow(ll_currentrow)
		ib_edit = true		// to allow if_update() to proceed
		if_update()			// reset ib_newrec, ib_edit
		
		// ÅðéëïãÞ ðñïçãïýìåíçò
		ll_currentrow = ll_currentrow - 1
		if ll_currentrow = 0 then ll_currentrow = 1
		dw_main.SetRow(ll_currentrow)
		dw_main.ScrollToRow(ll_currentrow)
		
		// ÅðéóôñïöÞ
		dw_main.SetRedraw(true)
		
		this.TriggerEvent("ie_checkmenu")
		
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
	
	dw_main.SetRedraw(false)
	
	do while not ll_nextselected = 0
	
		// Áí åßíáé ç ôåëåõôáßá (new record) äåí ôçí äéáãñÜöïõìå
		// (÷ñçóéìïðïéïýìå ôçí rowcount() ãéá íá
		// åðáíáõðïëïãßæïõìå ìåôÜ áðü êÜèå äéáãñáöÞ)
		if ll_nextselected = dw_main.rowcount() then exit
		
		// Check for delete rules 
		// ÄéáêïðÞ ôçò äéáãñáöÞò óôçí ðñþôç åããñáöÞ üðïõ of_checkdelete() = false
		if not of_checkdelete(dw_main, ll_nextselected) then exit
		
		// ÄéáãñáöÞ ôñÝ÷ïõóáò åðéëïãÞò (õðÜñ÷åé êáé äåí åßíáé ç ôåëåõôáßá)
		dw_main.deleterow(ll_nextselected)
		ib_edit = true		// to allow if_update() to proceed
		if_update()			// reset ib_newrec, ib_edit
		
		// Ðáßñíïõìå ôçí åðüìåíç åðéëïãÞ 
		// (ðÜëé áðü ôçí áñ÷Þ)
		ll_nextselected = dw_main.GetSelectedRow(0)

	loop

// ÅðéëÝãïõìå ôçí ðñïçãïýìåíç ìåôÜ ôçí ðñþôç åðéëåãìÝíç
		ll_currentrow = ll_firstselected - 1
		if ll_currentrow = 0 then ll_currentrow = 1
		dw_main.SetRow(ll_currentrow)
		dw_main.ScrollToRow(ll_currentrow)

// Êáèáñßæïõìå ôçí åðéëïãÞ (ßóùò ìåßíåé ç ôåëåõôáßá åðéëåãìÝíç)
	dw_main.SelectRow(0, false)
	dw_main.SetRedraw(true)
	
	this.TriggerEvent("ie_checkmenu")
	

	
end event

event me_selrec();// ÅðéëïãÞ ôçò ôñÝ÷ïõóáò åããñáöÞò
// (áðü åðéëïãÞ ôõ÷üí ðñïçãïýìåíçò)
	long	ll_currentrow
	ll_currentrow = dw_main.getrow()
	if ll_currentrow = 0 then return
	
	dw_main.SelectRow(0, false)
	dw_main.SelectRow(ll_currentrow, true)
	
	
end event

event me_movetonew();// Ìåôáêßíçóç óå íÝá åããñáöÞ
	long	ll_newrow
	ll_newrow = dw_main.rowcount()
	
	dw_main.SelectRow(0, false)	// Êáèáñéóìüò åðéëïãÞò
	
	dw_main.SetColumn(1)
	dw_main.ScrolltoRow(ll_newrow)
	
	

end event

event me_movetofirst();// Ìåôáêßíçóç óôçí ðñþôç åããñáöÞ

	dw_main.SelectRow(0, false)	// Êáèáñéóìüò åðéëïãÞò
	
	dw_main.SetColumn(1)
	dw_main.ScrolltoRow(1)
	

end event

event me_movetolast();// Ìåôáêßíçóç óôçí ôåëåõôáßá åããñáöÞ
// (Óôçí ïõóßá åßíáé ç ðñïôåëåõôáßá áöïý ç ôåëåõôáßá åßíáé ç íÝá)
	
	long	ll_lastrow
	
	ll_lastrow = dw_main.rowcount() - 1
	
	dw_main.SelectRow(0, false)	// Êáèáñéóìüò åðéëïãÞò
	
	dw_main.ScrolltoRow(ll_lastrow)
	

end event

event me_movetonext();// Ìåôáêßíçóç óôçí åðüìåíç åããñáöÞ
// (áí äåí åßìáóôå óôçí ôåëåõôáßá)
	
	long	ll_row
	
	ll_row = dw_main.getrow()

	if ll_row = dw_main.rowcount() then return	// åßìáóôå óôçí ôåëåõôáßá
	
	dw_main.SelectRow(0, false)	// Êáèáñéóìüò åðéëïãÞò
	
	dw_main.ScrolltoRow(ll_row + 1)
	

end event

event me_movetoprev();// Ìåôáêßíçóç óôçí ðñïçãïýìåíç åããñáöÞ
// (áí äåí åßìáóôå óôçí ðñþôç)

	long	ll_row
	
	ll_row = dw_main.getrow()
	
	if ll_row <= 1 then return		// åßìáóôå óôçí ðñþôç
	
	dw_main.SelectRow(0, false)	// Êáèáñéóìüò åðéëïãÞò
	
	dw_main.ScrolltoRow(ll_row - 1)

end event

event me_selectall();// ÅðéëïãÞ üëùí ôùí åããñáöþí
// åêôþò áðü ôçí ôåëåõôáßá
	dw_main.SetRedraw(false)

	dw_main.SelectRow(0, true)
	dw_main.SelectRow(dw_main.rowcount(), false)
	
	dw_main.SetRedraw(true)
	
end event

event me_cut();// ÁðïêïðÞ

	dw_main.cut()
end event

event me_copy();// ÁíôéãñáöÞ

	dw_main.copy()
end event

event me_paste();// Åðéêüëëçóç

	dw_main.paste()
end event

event me_clear();// Êáèáñéóìüò (äéáãñáöÞ)
	
	dw_main.clear()
end event

event me_undo();// Áíáßñåóç

	dw_main.undo()
end event

event me_close();// Êëåßóéìï ðáñáèýñïõ

	close(this)
end event

event ie_exit();// terminate the application

	close(parentwindow())
end event

event ie_checkmenu();// Enable - disable menu items based on current record

	MenuID.EVENT TRIGGER DYNAMIC ie_checkmenu(dw_main)
end event

event me_find();// Åýñåóç êåéìÝíïõ

// ¢íïéãìá ôïõ w_gridfind ìå ôï dw_main óáí ðáñÜìåôñï
	OpenWithParm(w_gridfind, dw_main)
end event

public subroutine of_initrow (ref datawindow adw, long row);// Initialize new row
end subroutine

public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor);// Set alternate colors

end subroutine

public function boolean of_checkdelete (ref datawindow adw, long row);// Check for delete rules for the current row

	return true
end function

public subroutine if_insertrow ();// Insert a new row at the end
	long	ll_newrow
	ll_newrow =	dw_main.Insertrow(0)
	
// Initialize but clear modified flag
	of_initrow(dw_main, ll_newrow)
	dw_main.SetItemStatus(ll_newrow, 0, Primary!, NotModified!)
	
	this.triggerevent("ie_checkmenu")
	
	
end subroutine

public function long if_retrieve ();// Override if retrieval arguments required
// returns the number of rows
	
	long	ll_nrows
	
	ll_nrows = dw_main.retrieve()
	
	return ll_nrows
end function

public function boolean if_update ();// update dw_main (return true if succeded)
	long	ll_row
	integer	li_ret
	
// Update only when ib_edit = true
// Return true to allow row changing
	if not ib_edit then return true
		
	dw_main.AcceptText()

// Check for required field and update
	ll_row = dw_main.getrow()
	if ll_row > 0 and ll_row < dw_main.rowcount() then 
		if not of_check4required(dw_main, ll_row) then return false
	end if
	li_ret = dw_main.update()
	if li_ret <> 1 then return false
	
// Clear flags and commit
	ib_newrec = false
	commit using sqlca;
	
	return true
end function

public subroutine of_postinitrow (ref datawindow adw, long row);// Initialize row after edit has started
// usefull for autonumber
end subroutine

public subroutine if_checkmodified (long row);// Checks if row has been modified and sets ib_edit

// Check row status
	dwitemstatus	li_rowstatus
	dw_main.AcceptText()

	li_rowstatus = dw_main.GetItemStatus(row, 0, primary!)
	
// if row has been modified
	if li_rowstatus = DataModified! or li_rowstatus = NewModified! then
	
		// Set edit flag (for update to be allowed)
			ib_edit = true
	
		// if this is the last row add an empty one and set newrec flag
		// call of_postinitrow()
			if row = dw_main.rowcount() then
				of_postinitrow(dw_main, row)
				if_insertrow()
				ib_newrec = true
			end if	
			
	end if
end subroutine

public function boolean of_check4required (ref datawindow adw, long row);/*
string	lstring	
long		ll_fount
long		llong	
date		ldate
time		ltime

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
			MessageBox(gs_app_name, "Code exists")
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

public subroutine of_setmasks ();// Edit Mask & display Mask

/*

// maskdate, maskdateedit
	fn_seteditmask(dw_main, "xxxxx", fn_param_maskdateedit())
	fn_setformatmask(dw_main, "xxxxx", fn_param_maskdate())

// maskposo, maskposoedit
	fn_seteditmask(dw_main, "xxxxx", fn_param_maskposoedit())
	fn_setformatmask(dw_main, "xxxxx", fn_param_maskposo())
	
// maskposotita, maskposotitaedit
	fn_seteditmask(dw_main, "xxxxx", fn_param_maskposotitaedit())
	fn_setformatmask(dw_main, "xxxxx", fn_param_maskposotita())

// masktime, masktimeedit
	fn_seteditmask(dw_main, "xxxxx", fn_param_masktimeedit())
	fn_setformatmask(dw_main, "xxxxx", fn_param_masktime())

*/
end subroutine

public subroutine of_open ();// Åêôåëåßôáé áìÝóùò ìåôÜ ôï Üíïéãìá
end subroutine

on w_pbgrid.create
if this.MenuName = "m_main_pbgrid" then this.MenuID = create m_main_pbgrid
this.dw_main=create dw_main
this.Control[]={this.dw_main}
end on

on w_pbgrid.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_main)
end on

event open;// open 
	of_open()

// Initialize dw_main
	dw_main.SetTransObject(sqlca)
	if_retrieve()
	Move(0,0)
	
/*
// Make selected row appear sunken
	string	ls_ncols
	integer	li_ncols, i
	ls_ncols = dw_main.Object.DataWindow.Column.Count
	li_ncols = integer(ls_ncols)
	for i = 1 to li_ncols
		dw_main.Modify("#"+ string(i) + ".Border='0~tif(getrow() = currentrow(), 5, 0)'")
	next
*/

// Make alternative row coloring
	of_setrowcolors(il_rowcolor, il_rowrcolor)
	dw_main.Modify("DataWindow.Detail.Color= '536870912~tif(mod(getrow(), 2) = 1, " + string(il_rowcolor) + ", " + string(il_rowrcolor) + ")'")
	
// ¸ëåã÷ïò äéêáéùìÜôùí
	if not fn_perm(is_tablename, "UPDATE") then dw_main.enabled = false
	
// Set masks
	of_setmasks()
	
end event

event closequery;// update dw_main (if failed prevent closing)
	if not if_update() then 
		dw_main.setfocus()
		return 1
	end if
end event

event resize;dw_main.width = this.WorkSpaceWidth()
dw_main.Height = this.WorkSpaceHeight()
end event

type dw_main from datawindow within w_pbgrid
event ue_keydown pbm_dwnkey
event ue_lbuttonup pbm_dwnlbuttonup
integer width = 1961
integer height = 1480
integer taborder = 10
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
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
			getparent().TriggerEvent("ie_checkmenu")
		end if
				
end choose
end event

event ue_lbuttonup;// Check if row has been modified
	this.AcceptText()		
	if_checkmodified(row)
end event

event retrieveend;// Insert a new record at the end
	if_insertrow()
	
// reset flags	
	ib_edit = false
	ib_newrec = false
end event

event editchanged;if_checkmodified(row)
		
end event

event rowfocuschanging;// update - if failed prevent row changing
	
	if not if_update() then
		dw_main.setfocus()
		return 1
	else	
		selectrow(currentrow, false)
		selectrow(newrow, true)
	
	end if
	
end event

event clicked;// Êáèáñéóìüò åðéëåãìÝíùí åããñáöþí
// Áí åßíáé ðáôçìÝíï ôï ctrl ðïëëáðëÞ åðéëïãÞ
// Äåí åðéëÝãïõìå ôçí ôåëåõôáßá (íÝá) åããñáöÞ
// Áí ç åããñáöÞ åßíáé Þäç åðéëåãìÝíç ôçí áðïåðéëÝãïõìå
	if keydown(KeyControl!) then 
		if row < dw_main.rowcount() then
			if dw_main.IsSelected(row) then
				dw_main.SelectRow(row, false)
			else
				dw_main.SelectRow(row, true)
			end if
		end if
	else
		dw_main.SelectRow(0, false)
	end if
	
	
// ----------------------------------------------------------------------	
// Ôáîéíüìçóç
// ----------------------------------------------------------------------	

String	ls_old_sort, ls_column
char		lc_sort

// ¸ëåã÷ïò áí åðéôñÝðåôáé ç ôáîéíüìçóç
	//if not ib_sort then return

// Check whether the user clicks on the column header
	if Right(dwo.name,2) = '_t' then
		ls_column = left(dwo.name, len(string(dwo.name))-2)
		
		// delete the last empty row (new rec)
		// to not be included in sorting
			dw_main.SetRedraw(false)
			dw_main.DeleteRow(dw_main.rowcount())
		
		// Get old sort, if any
			ls_old_sort = dw_main.Describe("Datawindow.Table.sort")
			
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
				dw_main.SetSort(ls_column + " " + lc_sort)
			else
				dw_main.SetSort(ls_column + " A")
			end if
		dw_main.Sort()
		
		// Select firt row
			dw_main.SetRow(1)
			dw_main.ScrollToRow(1)
			
		// Insert the deleted new row again
			if_insertrow()
			dw_main.SetRedraw(true)

	end if
end event

event rowfocuschanged;// check menu
	
	getparent().TriggerEvent("ie_checkmenu")
end event

event itemchanged;if_checkmodified(row)
end event

