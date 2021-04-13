HA$PBExportHeader$w_list.srw
$PBExportComments$
forward
global type w_list from window
end type
type dw from datawindow within w_list
end type
end forward

global type w_list from window
integer width = 2281
integer height = 1820
boolean titlebar = true
string menuname = "m_main_list"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 80269524
string icon = "AppIcon!"
event me_filter ( )
event ie_retrieve ( )
event ie_checkmenu ( )
event ie_sizedw ( )
event me_add ( )
event me_edit ( )
event me_delete ( )
event me_refresh ( )
event me_search ( )
event me_viewall ( )
event ie_exit ( )
event ie_close ( )
event me_prevwhere ( )
event me_nextwhere ( )
event me_clearhistory ( )
dw dw
end type
global w_list w_list

type variables
// Ôï üíïìá ôïõ ðßíáêá (êáôá÷ùñçìÝíï óôïí afxTable)
	public		string	is_tablename

// The dw's select clause, order by and recent where
	protected	string	is_select
	public 		string 	is_where, is_order

// Ôá ïíüìáôá ôùí ðáñáèýñùí åðåîåñãáóßáò, áíáæÞôçóçò êáé ößëôñïõ
	public 		string	is_formwin		
	public 		string	is_searchwin
	
// if true ôï update ãßíåôáé óôï dw
	protected	boolean	ib_update		
	
// Áí åßíáé true ç öüñìá åðåîåñãáóßáò áíïßãåé ìå 1 (retrieve)
	boolean	ib_editwithkey
	
// Áí åßíáé true retrieve ìåôÜ ôï Üíïéãìá
	protected	boolean	ib_retrieve
	
// Áí åßíáé true óõìðåñéëáìâÜíåôáé ç ëÝîç "WHERE" óôï ößëôñï
	protected	boolean 	ib_includewhere = false
	
// ÅðÝêôáóç ôïõ ðáñáèýñïõ óå üëç ôçí client area (if true)
	protected 	boolean	ib_xclient, &
									ib_yclient
								
// ÅðéôñÝðåé ôçí ôáîéíüìçóç ìå êëéê óôéò êåöáëßäåò
	protected 	boolean	ib_sort
	
// Áí åßíáé true áíáæÞôçóç óôï .ini ðáñáìÝôñùí äéáìüñöùóçò
	protected 	boolean	ib_useini
	
// Áí åßíáé true áðåíåñãïðïßçóç ôùí áíôßóôïé÷ùí menu
	protected boolean		ib_noview
	protected boolean		ib_nofilter
	
// Alternative row coloring
	protected 	long		il_rowcolor  = rgb(255,255,255) 
	protected 	long		il_rowrcolor = rgb(255,255,128)		
	
// History of where clauses (double linked list)
	public		uc_lnklist	ilst_history
	
end variables

forward prototypes
protected subroutine of_reset_struct ()
protected subroutine of_struct2dw (ref datawindow adw, long row)
protected function string if_opensearch ()
protected function boolean of_checkdelete (ref datawindow adw, long row)
protected subroutine of_init_struct ()
protected function string if_where4print ()
protected subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_open ()
public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor)
protected function boolean if_openform (long param)
public subroutine of_deleterow (ref datawindow adw, long row)
protected subroutine of_retrieve (ref datawindow adw)
public subroutine of_initsqlselect ()
public subroutine of_afterinsert (ref datawindow adw, long row)
public subroutine of_afterupdate (ref datawindow adw, long row)
public subroutine if_readini ()
public subroutine of_afterdelete (ref datawindow adw, long row)
protected subroutine if_setwhere (string as_where)
end prototypes

event me_filter();// ¢íïéãìá ôïõ ðáñáèýñïõ öéëôñáñßóìáôïò ãéá ôï tablename ôïõ ðßíáêá

string	ls_where

OpenWithParm(w_filter, is_tablename)

ls_where = Message.StringParm
if ls_where = "" or isnull(ls_where) then return

// Ç ls_where åßíáé ôçò ìïñöÞò " AND ..."
// Áí ib_includewhere = true, áíôéêáôÜóôáóç ôïõ áñ÷éêïý " AND " ìå " WHERE "
	if ib_includewhere then
		ls_where = right(ls_where, len(ls_where) - 5)
		ls_where = " where " + ls_where
	end if

// Assign new where and retrieve
	if_setwhere(ls_where)
	


end event

event ie_retrieve();// Retrieve ìå ôá ôñÝ÷ïíôá where êáé order
	
	string	ls_newselect
	
// Ç íÝá select ôáîéíïìçìÝíç 
	ls_newselect = is_select + " " + is_where + " " + is_order
	
// Set redraw and pointer
	pointer	oldpointer
	dw.SetRedraw(false)
	oldpointer = SetPointer(HourGlass!)
	
	
	dw.Modify("DataWindow.Table.Select='" + ls_newselect + "'")
	of_retrieve(dw)
	
// Select first row
	dw.SelectRow(0, false)
	dw.SetRow(1)
	dw.SelectRow(1, true)

// Restore redraw and pointer
	dw.SetRedraw(true)
	SetPointer(oldpointer)

// Åíåñãïðïßçóç - áðåíåñãïðïßçóç menu
	this.TriggerEvent("ie_checkmenu")


end event

event ie_checkmenu;MenuID.EVENT TRIGGER DYNAMIC ie_checkmenu(dw)
end event

event ie_sizedw;dw.width = this.workspacewidth()
dw.Height = this.workspaceheight() 
dw.move(0,0)

end event

event me_add();// ÐñïóèÞêç ìéáò íÝáò åããñáöÞò

// ¸ëåã÷ïò äéêáéùìÜôùí
	if not fn_perm(is_tablename, "addrec") then return

// Êáèáñéóìüò ôçò áíÜëïãçò structure
	of_reset_struct()

// Default ôéìÝò ãéá íÝá åããñáöÞ
	of_init_struct()

// ¢íïéãìá ôçò öüñìáò åðåîåñãáóßáò êáé Ýëåã÷ïò áí ðáôÞóáìå ÏÊ Þ CANCEL (override function)
// parameter = 0 -> íÝá åããñáöÞ (for both updatable and no updateble)
	if not if_openform(0) then return

dw.SetRedraw(false)

// Áí ðáôÞóáìå ïê åéóÜãïõìå ìßá íÝá ãñáììÞ êáé ìåôáöÝñïõìå ôá óôïé÷åßá
	long	ll_row
	ll_row = dw.InsertRow(0)
	of_struct2dw(dw, ll_row)	

// ÅðéëÝãïõìå ôçí íÝá ãñáììÞ
	//dw.SetRow(1)
	dw.SelectRow(0, false)
	dw.ScrollToRow(ll_row)
	dw.SelectRow(ll_row, true)
	dw.SetFocus()
	
dw.SetRedraw(true)
	

// update áíÜëïãá ìå ôçí ib_update
	if ib_update then
		dw.update()
		COMMIT;
	end if
	
// check menu
	This.TriggerEvent("ie_checkmenu")

// Êáëïýìå ôçí of_afterinsert()
	of_afterinsert(dw, ll_row)
	


end event

event me_edit();// ¸ëåã÷ïò äéêáéùìÜôùí
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
	
// Êáëïýìå ôçí of_afterupdate()
	of_afterupdate(dw, ll_row)

end event

event me_delete();// ÄéáãñáöÞ ôçò åðéëåãìÝíçò åããñáöÞò

// ¸ëåã÷ïò äéêáéþìáôïò
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
	
// ÁëëáãÞ êÝñóïñá óå êëåøýäñá
	pointer	oldpointer
	oldpointer = setpointer(Hourglass!)

// ÄéáãñáöÞ êáé åðéëïãÞ ôçò áìÝóùò ðñïçãïýìåíçò ãñáììÞò
	dw.SetRedraw(false)
	of_deleterow(dw, ll_row)
	dw.DeleteRow(ll_row)		// ÄéáãñáöÞ óôï dw ÷ùñßò update
	
	ll_row = ll_row - 1
	if ll_row = 0 then ll_row = 1
	dw.SetRow(ll_row)
	dw.ScrollToRow(ll_row)
	dw.SelectRow(0, false)
	dw.SelectRow(ll_row, true)
	dw.SetFocus()
	
	dw.SetRedraw(true)	

// check menu	
	this.TriggerEvent("ie_checkmenu")
	
// Êáëïýìå ôçí of_afterdelete()
	of_afterupdate(dw, ll_row)	
	
// ÅðáíáöïñÜ êÝñóïñá
	setpointer(oldpointer)

end event

event me_refresh;// ÁíáíÝùóç ðåñéå÷ïìÝíùí (ìå ôçí ßäéá select)
	This.TriggerEvent("ie_retrieve")

end event

event me_search();// ¢íïéãìá ôïõ ðáñáèýñïõ áíáæÞôçóçò
	string ls_where
	ls_where = if_OpenSearch()

// Áí åðéóôñÝøáìå "" åðéóôñÝöïõìå
	if ls_where = "" then return
	
// Äþóáìå êñéôÞñéá
	if_setwhere(ls_where)

end event

event me_viewall();// Êáôáñãïýìå ôï ößëôñï
// (Äåí ðñïóôÞèåôå ôï is_history)
	is_where = ""
	This.TriggerEvent("ie_retrieve")
end event

event ie_exit;close(parentwindow())
end event

event ie_close();// Áêýñùóç ôïõ áíïßãìáôïò
	close(this)
end event

event me_prevwhere();// Show previous where 
	
// Áí åðéôý÷åé ç moveprev
	if ilst_history.moveprev() then
		is_where = ilst_history.getposdata()	
		this.triggerevent("ie_retrieve")
	end if
end event

event me_nextwhere();// Show next where 
	
// Áí åðéôý÷åé ç movenext
	if ilst_history.movenext() then
		is_where = ilst_history.getposdata()	
		this.triggerevent("ie_retrieve")
	end if
end event

event me_clearhistory();// ÄéáãñÜöïõìå üëá åêôþò áðü ôçí ôñÝ÷ïõóá ðñïâïëÞ

// ÊñáôÜìå ôçí ôñÝ÷ïõóá where
	string	ls_curwhere
	ls_curwhere = ilst_history.getposdata()
	
// ¢äåéáóìá ëßóôáò êáé ðñïóèÞêç ôçò ôñÝ÷ïõóáò where
	ilst_history.emptylist()
	ilst_history.addtail(ls_curwhere)

	This.TriggerEvent("ie_checkmenu")
	

end event

protected subroutine of_reset_struct ();// Override to clear the relative structure
end subroutine

protected subroutine of_struct2dw (ref datawindow adw, long row);// Åíçìåñþíåôáé ç åðéëåãìÝíç åããñáöÞ ìå ôá óôïé÷åßá ôçò structure
// Override in descentant
end subroutine

protected function string if_opensearch ();
// ¢íïéãìá ôïõ ðáñáèýñïõ áíáæÞôçóçò êáé åðéóôñïöÞ ôçò where
	
window		w_searchwin

Open(w_searchwin, is_searchwin)
return Message.StringParm

end function

protected function boolean of_checkdelete (ref datawindow adw, long row);// Åäþ ðñïóèÝôïõìå Ýîôñá åëÝã÷ïõò ðñéí ãßíåé ç äéáãñáöÞ
// ð.÷. óõíäåäåìÝíïõò ðßíáêåò ê.ë.ð.
// Áí åðéóôñÝøåé false äåí ðñï÷ùñÜ ç äéáãñáöÞ

return true
end function

protected subroutine of_init_struct ();// Default ôéìÝò ãéá íÝåò åããñáöÝò (override function)
end subroutine

protected function string if_where4print ();// compines is_where, is_order
	
// ÓõíäõÜæïõìå where êáé order
	string	ls_where, ls_order
	
// Áí óôçí where êáé óôçí order õðÜñ÷ïõí ' ôá áëëÜæïïõìå óå ~'
	ls_where = is_where
	ls_order = is_order 
	
	ls_where = fn_replace_str(is_where, "'", "~'")
	ls_order = fn_replace_str(is_order, "'", "~'")
	
	return " " + ls_where + " " + ls_order + " "
	
// åêôýðùóç þò åîÞò (óôï menu event ôïõ descenant
	//OpenSheetWithParm(wprn_cust_labels, fn_where4print(), w_main, 0, Original!)	

end function

protected subroutine of_dw2struct (ref datawindow adw, long row);// ÌåôáöïñÜ ôùí ðåäßùí áðü ôï dw óôçí ó÷åôéêÞ structure
// Override in descentant
end subroutine

protected subroutine of_open ();// Åêôåëåßôáé áêñéâþò ìåôÜ ôï Üíïéãìá


end subroutine

public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor);// Êáèïñéóìüò åíáëëáêôéêþí ÷ñùìÜôùí
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

public subroutine of_deleterow (ref datawindow adw, long row);// override to delete selected row with embended sql
end subroutine

protected subroutine of_retrieve (ref datawindow adw);// Override if arguments required
	dw.retrieve()
end subroutine

public subroutine of_initsqlselect ();// Initialize is_select 
// override to add where that is present always (xrisi for example)
// replace ' with ~'
	is_select = dw.GetSQLSelect()
	is_select = fn_replace_str(is_select, "'", "~~'")
end subroutine

public subroutine of_afterinsert (ref datawindow adw, long row);// Êáëåßôáé ìåôÜ ôçí ðñïóèÞêç íÝáò åããñáöÞò

end subroutine

public subroutine of_afterupdate (ref datawindow adw, long row);// Êáëåßôå ìåôÜ ôçí åðåîåñãáóßá (edit)
end subroutine

public subroutine if_readini ();// ÁíáæÞôçóç óôï .ini ðáñáìÝôñùí äéáìüñöùóçò ôïõ ðáñáèýñïõ
// use ini only if ib_useini = true

	if not ib_useini then return
	
// ÌåôáâëçôÝò ðáñáìÝôñùí
	integer	li_retrieve, &
				li_xclient, &
				li_yclient, &
				li_sort, &
				li_width, &
				li_height
	string	ls_order
	
// ÁíÜãíùóç
	li_retrieve = ProfileInt(gs_ini_file, is_tablename, "retrieve", -1) 
	li_xclient = ProfileInt(gs_ini_file, is_tablename, "xclient", -1)
	li_yclient = ProfileInt(gs_ini_file, is_tablename, "yclient", -1)
	li_sort = ProfileInt(gs_ini_file, is_tablename, "sort", -1)
	li_width = ProfileInt(gs_ini_file, is_tablename, "width", -1)
	li_height = ProfileInt(gs_ini_file, is_tablename, "height", -1)
	ls_order = ProfileString(gs_ini_file, is_tablename, "order", "")
	

// Åê÷þñçóç ôéìþí
	
	// retrieve
		if li_retrieve <> -1 then 
			if li_retrieve = 1 then
				ib_retrieve = true
			else 
				ib_retrieve = false
			end if
		end if
		
	// xclient
		if li_xclient <> -1 then
			if li_xclient = 1 then
				ib_xclient = true
			else
				ib_xclient = false
			end if
		end if
		
	// yclient
		if li_yclient <> -1 then
			if li_yclient = 1 then
				ib_yclient = true
			else
				ib_yclient = false
			end if
		end if
	
	// sort
		if li_sort <> -1 then
			if li_sort = 1 then
				ib_sort = true
			else
				ib_sort = false
			end if
		end if
		
	// width
		if li_width <> -1 then this.width = li_width
		
	// height
		if li_height <> -1 then this.height = li_height
		
	// order
		if ls_order <> "" then is_order = ls_order
		
		

		
		
	
	
			
end subroutine

public subroutine of_afterdelete (ref datawindow adw, long row);// Êáëåßôå ìåôÜ ôçí äéáãñáöÞ
end subroutine

protected subroutine if_setwhere (string as_where);// set the where clause to local variable
// insert into ilst_history

	is_where = as_where
	ilst_history.addpos(as_where)
	
	this.TriggerEvent("ie_retrieve")
	
	

end subroutine

on w_list.create
if this.MenuName = "m_main_list" then this.MenuID = create m_main_list
this.dw=create dw
this.Control[]={this.dw}
end on

on w_list.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw)
end on

event open;of_open()

// .ini configuration
	if_readini()

// Start transaction 
// and get initial select clause
	dw.SetTransObject(SQLCA)
	of_initsqlselect()
	
// ÄéáóôÜóåéò ôïõ ðáñáèýñïõ áíÜëïãá ìå 
// ib_xClient, ib_yClient
	w_main lw_parent
	lw_parent = parentwindow()
	if ib_xClient then this.width = lw_parent.mdi_1.Width
	if ib_yClient then this.height = lw_parent.mdi_1.height

// Size dw and check menu
	TriggerEvent("ie_sizedw")
	TriggerEvent("ie_checkmenu")
	
// Retrieve áí ib_retrieve åßíáé true
	if ib_retrieve then TriggerEvent("ie_retrieve")

// ¢íïéãìá óôçí êïñõöÞ
	move(0,0)
	
// Ðáßñíïõìå ôïí ôßôëï áðü afxTable ìå âÜóç ôï is_tablename
	string	ls_title
	select tabledesc into :ls_title from dba.afxTable where tablename = :is_tablename;
	if not isnull(ls_title) and not ls_title = "" then this.title = ls_title
	
// Make alternative row coloring
	of_setrowcolors(il_rowcolor, il_rowrcolor)
	dw.Modify("DataWindow.Detail.Color= '536870912~tif(mod(getrow(), 2) = 1, " + string(il_rowcolor) + ", " + string(il_rowrcolor) + ")'")
	
// Áðåíåñãïðïßçóç åðéëïãþí Menu
	if ib_noview then MenuID.TriggerEvent("ie_noview")
	if ib_nofilter then MenuID.TriggerEvent("ie_nofilter")
	

end event

event resize;This.TriggerEvent("ie_sizedw")
end event

type dw from datawindow within w_list
integer width = 2235
integer height = 1400
integer taborder = 10
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanging;this.SelectRow(currentrow, false)
this.Selectrow(newrow, true)
		
end event

event doubleclicked;GetParent().TriggerEvent("me_edit")
end event

event clicked;String	ls_old_sort, ls_column
char		lc_sort

// ¸ëåã÷ïò áí åðéôñÝðåôáé ç ôáîéíüìçóç
	if not ib_sort then return
	if right(dwo.name, 2) <> '_t' then return 
	
// The user have clicked on a column - sort
	
	SetRedraw(false)

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
			dw.SetSort(ls_column + " " + lc_sort)
		else
			dw.SetSort(ls_column + " A")
		end if
	dw.Sort()
	
	// Select firt row
		dw.SelectRow(0,false)
		dw.ScrollToRow(1)
		dw.SelectRow(1,true)
	
setredraw(true)
end event

event rbuttondown;// Áí ç íÝá åããñáöÞ åßíáé äéáöïñåôéêÞ áðü ôçí 
// ðñïçãïýìåíç, ôçí åðéëÝãïõìå
	long	ll_oldrow
	ll_oldrow = this.getrow()
	if ll_oldrow <> row and row <> 0 then 
		this.Setrow(row)
		this.SelectRow(ll_oldrow, false)
		this.SelectRow(row, true)
	end if

// popup
	m_main_list		menu
	menu = menuid
	menu.m_popup.PopMenu(parentwindow().pointerx(), parentwindow().pointery())
end event

