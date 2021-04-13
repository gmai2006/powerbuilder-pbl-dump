HA$PBExportHeader$ucv_buttons_dw.sru
$PBExportComments$
forward
global type ucv_buttons_dw from userobject
end type
type dw from datawindow within ucv_buttons_dw
end type
type pb_delete from picturebutton within ucv_buttons_dw
end type
type pb_edit from picturebutton within ucv_buttons_dw
end type
type pb_add from picturebutton within ucv_buttons_dw
end type
end forward

global type ucv_buttons_dw from userobject
integer width = 2190
integer height = 1100
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ie_checkbuttons ( )
event ue_update ( )
event ue_retrieve ( )
event ue_settrans ( )
dw dw
pb_delete pb_delete
pb_edit pb_edit
pb_add pb_add
end type
global ucv_buttons_dw ucv_buttons_dw

type variables
// Áí åßíáé true åðéôñÝðïíôáé ç åðéëïãÝò ãñáììþí óôï idw_dw
	boolean	ib_selection
	
// Áí åßíáé true autoupdate is on
	boolean	ib_update
	
// Ôï ðáñÜèõñï åðåîåñãáóßáò
	string		is_formwin
	
// Áí åßíáé true ç öüñìá åðåîåñãáóßáò áíïßãåé ìå -1 (retrieve)
	boolean	ib_editwithkey
	
// Ôï tag äéêáéùìÜôùí	
	string		is_tablename
	
// Áí true åðéôñÝðåôáé ç ôáîéíüìçóç ìå êëéê óôï header
	boolean  ib_sort
	
// Alternative row coloring
	protected long		il_rowcolor  = rgb(255,255,255) 
	protected long		il_rowrcolor = rgb(255,255,128)

end variables

forward prototypes
protected subroutine of_init_struct ()
protected subroutine of_reset_struct ()
protected function boolean of_checkdelete (ref datawindow adw, long row)
protected subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_struct2dw (ref datawindow adw, long row)
protected function boolean if_openform (long param)
public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor)
public subroutine of_afterinsert (ref datawindow adw, long row)
public subroutine of_afterdelete (ref datawindow adw, long row)
public subroutine of_afterupdate (ref datawindow adw, long row)
end prototypes

event ie_checkbuttons;// Åíåñãïðïßçóç - áðåíåñãïðïßçóç êïõìðéþí
	long ll_row
	ll_row = dw.getrow()

if ll_row = 0 then
	pb_edit.enabled = false
	pb_delete.enabled = false
else 
	pb_edit.enabled = true
	pb_delete.enabled = true
end if
end event

event ue_update();dw.update()
commit using sqlca;
end event

event ue_retrieve();dw.retrieve()
end event

event ue_settrans();dw.SetTransObject(sqlca)
end event

protected subroutine of_init_struct ();// Default ôéìÝò ãéá íÝá åããñáöÞ
// Override in descenant
end subroutine

protected subroutine of_reset_struct ();// Êáèáñéóìüò ôçò ó÷åôéêÞò structure (global)
// Override in descenant
end subroutine

protected function boolean of_checkdelete (ref datawindow adw, long row);// ¸ëåã÷ïò ãéá äéÜöïñá êñéôÞñéá ðñéí ôç äéáãñáöÞ

	return true
end function

protected subroutine of_dw2struct (ref datawindow adw, long row);// ÌåôáöïñÜ óôïé÷åßùí áðü ôï idw_dw óôçí êáèïëéêÞ structure
// Override in descenant
end subroutine

protected subroutine of_struct2dw (ref datawindow adw, long row);// ÌåôáöïñÜ óôïé÷åßùí áðü ôçí êáèïëéêÞ structure óôï idw_dw
// Override in descenant
end subroutine

protected function boolean if_openform (long param);// ¢íïéãìá ôïõ ðáñáèýñïõ ãéá ðñïóèÞêç - åðåîåñãáóßá
// Áí åðéóôñÝøáìå ìå cancel åðéóôñÝøåé false
// param: 	   0 -> íÝá åããñáöÞ
//				  -1 -> Åðåîåñãáóßá - ôá äåäïìÝíá óôçí global structure
//				   1 -> Åðåîåñãáóßá - retrieve (To id óôçí structure)

window	w_formwindow

OpenWithParm(w_formwindow, param, is_formwin)

if Message.DoubleParm = 1 then
	return true
else
	return false
end if
end function

public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor);
end subroutine

public subroutine of_afterinsert (ref datawindow adw, long row);// Êáëåßôå ìåôÜ ôçí åéóáãùãÞ åããñáöÞò
end subroutine

public subroutine of_afterdelete (ref datawindow adw, long row);// Êáëåßôáé ìåôÜ ôçí äéáãñáöÞ åããñáöÞò
end subroutine

public subroutine of_afterupdate (ref datawindow adw, long row);// Êáëåßôáé ìåôÜ ôçí åíçìÝñùóç åããñáöÞò (edit)
end subroutine

on ucv_buttons_dw.create
this.dw=create dw
this.pb_delete=create pb_delete
this.pb_edit=create pb_edit
this.pb_add=create pb_add
this.Control[]={this.dw,&
this.pb_delete,&
this.pb_edit,&
this.pb_add}
end on

on ucv_buttons_dw.destroy
destroy(this.dw)
destroy(this.pb_delete)
destroy(this.pb_edit)
destroy(this.pb_add)
end on

event constructor;// Initialize dw
	dw.SetTransObject(sqlca)

// Make alternative row coloring
	of_setrowcolors(il_rowcolor, il_rowrcolor)
	dw.Modify("DataWindow.Detail.Color= '536870912~tif(mod(getrow(), 2) = 1, " + string(il_rowcolor) + ", " + string(il_rowrcolor) + ")'")

// CheckButtons
	this.TriggerEvent("ie_checkbuttons")
	
// Translation
	pb_delete.powertiptext = trn(222)
	pb_edit.powertiptext = trn(302)
	pb_add.powertiptext = trn(568)
end event

type dw from datawindow within ucv_buttons_dw
integer y = 124
integer width = 2190
integer height = 964
integer taborder = 40
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanging;// Áí åðéôñÝðåôáé ç åðéëïãÞ
// ÁëëáãÞ ôçò åðéëåãìÝíçò ãñáììÞò
if ib_selection then
	SelectRow(currentrow, false)
	SelectRow(newrow, true)
end if

end event

event doubleclicked;pb_edit.TriggerEvent(clicked!)
end event

event retrieveend;GetParent().TriggerEvent("ie_checkbuttons")
end event

event clicked;String	ls_old_sort, ls_column
char		lc_sort

// ¸ëåã÷ïò áí åðéôñÝðåôáé ç ôáîéíüìçóç
	if not ib_sort then return

// Check whether the user clicks on the column header
	if Right(dwo.name,2) = '_t' then
		ls_column = left(dwo.name, len(string(dwo.name))-2)
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
				this.SetSort(ls_column + " " + lc_sort)
			else
				this.SetSort(ls_column + " A")
			end if
		this.Sort()
		
		// Select firt row
			this.SelectRow(0,false)
			this.ScrollToRow(1)
			this.SelectRow(1,true)
	end if
end event

type pb_delete from picturebutton within ucv_buttons_dw
integer x = 2085
integer width = 101
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string picturename = "Custom094!"
vtextalign vtextalign = vcenter!
end type

event clicked;// ¸ëåã÷ïò äéêáéþìáôïò
	if not fn_perm(is_tablename, "delrec") then return

// Ðáßñíïõìå ôçí ôñÝ÷ïõóá ãñáììÞ ôïõ dw
	long	ll_row
	ll_row = dw.getrow()
	if ll_row = 0 then return
	
// ÓõíÜñôçóç ðïõ åëÝã÷åé äéÜöïñåò óõíèÞêåò (ð.÷. óõíäåäåìÝíïõò ðßíáêåò)
	if not of_checkdelete(dw, ll_row) then return
	
// ÅðáëÞèåõóç
	int	nRet
	nRet = MessageBox(trn(297), trn(454), Exclamation!, OKCancel!, 2)
	if nRet = 2 then return
	
// ÄéáãñáöÞ ôçò åðéëåãìÝíçò ãñáììÞò êáé åðéëïãÞ ôçò ðñïçãïýìåíçò
	dw.SetRedraw(false)
	dw.DeleteRow(ll_row)
	ll_row = ll_row - 1
	if ll_row > 0 then
		dw.SetRow(ll_row)
		dw.ScrollToRow(ll_row)
	else
		ll_row = 1
		dw.SetRow(ll_row)
	end if
	
// Áí åðéôñÝðåôáé ç åðéëïãÞ (ib_selection) åðéëÝãïõìå ôçí íÝá ãñáììÞ
	if ib_selection then
		dw.SelectRow(0, false)
		dw.SelectRow(ll_row, true)
	end if
	
	dw.SetRedraw(true)	
	
// Áí åßíáé update áíáíåþíïõìå
	if ib_update then
		dw.update()
		COMMIT USING SQLCA;
	end if
	
// ÐëÞêôñá
	GetParent().TriggerEvent("ie_checkbuttons")
	dw.setfocus()
	
// Êáëïýìå ôçí of_afterdelete()
	of_afterdelete(dw, ll_row)
end event

type pb_edit from picturebutton within ucv_buttons_dw
integer x = 1966
integer width = 101
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
boolean originalsize = true
string picturename = "DosEdit!"
vtextalign vtextalign = vcenter!
end type

event clicked;// ¸ëåã÷ïò äéêáéùìÜôùí
	if not fn_perm(is_tablename, "openform") then return
	
// Ðáßñíïõìå ôçí ôñÝ÷ïõóá ãñáììÞ ôïõ dw
	long	ll_row
	ll_row = dw.getrow()
	if ll_row = 0 then return

// Êáèáñéóìüò ôçò êáèïëéêÞò structure (override function)
	of_reset_struct()

// ÌåôáöïñÜ ôùí äåäïìÝùí óôçí ó÷åôéêÞ structure (override function)
	of_dw2struct(dw, ll_row)
	
// ¢íïéãìá ôçò öüñìáò åðåîåñãáóßáò êáé Ýëåã÷ïò áí ðáôÞóáìå ÏÊ Þ CANCEL (override function)
// Áí ib_update = true parameter = -1 (ôá äåäïìÝíá ôá ðáßñíïõìå áðü structure)
// Áí ib_update = false parameter = 1 (the key of record into structure)
	boolean 	ib_ret
	if ib_editwithkey then
		ib_ret = if_openform(1)
	else
		ib_ret = if_openform(-1)
	end if
	if not ib_ret then return

// Ôá íÝá äåäïìÝíá áðü ôçí sturcture óôï dw
	of_struct2dw(dw, ll_row)
	
// update áíÜëïãá ìå ôçí ib_update
	if ib_update then
		dw.update()
		COMMIT USING SQLCA;
	end if

dw.setfocus()

// Êáëïýìå ôçí of_afterupdate()
	of_afterupdate(dw, ll_row)
end event

type pb_add from picturebutton within ucv_buttons_dw
integer x = 1847
integer width = 101
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string picturename = "SelectScript!"
vtextalign vtextalign = vcenter!
end type

event clicked;// ÐñïóèÞêç ìéáò íÝáò åããñáöÞò óôï dw

// ¸ëåã÷ïò äéêáéùìÜôùí
	if not fn_perm(is_tablename, "addrec") then return

// Êáèáñéóìüò ôçò áíÜëïãçò structure
	of_reset_struct()

// Default ôéìÝò ãéá íÝá åããñáöÞ
	of_init_struct()

// ¢íïéãìá ôçò öüñìáò åðåîåñãáóßáò êáé Ýëåã÷ïò áí ðáôÞóáìå ÏÊ Þ CANCEL (override function)
	if not if_openform(0) then return

// Áí ðáôÞóáìå ïê åéóÜãïõìå ìßá íÝá ãñáììÞ êáé ìåôáöÝñïõìå ôá óôïé÷åßá
	long	ll_row
	ll_row = dw.InsertRow(0)
	of_struct2dw(dw, ll_row)	

// Áí åðéôñÝðïíôáé ïé åðéëïãÝò åðéëÝãïõìå ôçí íÝá ãñáììÞ
	if ib_selection then
		dw.SetRedraw(false)
		dw.SelectRow(0, false)
		dw.ScrollToRow(ll_row)
		dw.SelectRow(ll_row, true)
		dw.SetRedraw(true)
	end if	
	
// Áí åßíáé update áíáíåþíïõìå
	if ib_update then
		dw.update()
		COMMIT USING SQLCA;
	end if
	
// ÐëÞêôñá
	GetParent().TriggerEvent("ie_checkbuttons")
	dw.setfocus()
	
// Êáëïýìå ôçí of_afterinsert()
	of_afterinsert(dw, ll_row)
end event

