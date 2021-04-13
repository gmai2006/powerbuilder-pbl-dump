HA$PBExportHeader$w_print_where.srw
$PBExportComments$
forward
global type w_print_where from w_print
end type
end forward

global type w_print_where from w_print
event doc_usege ( )
end type
global w_print_where w_print_where

type variables
protected	string	is_select	// initial select of dw
protected 	string	is_where		// where clause
protected	string	is_order		// order clause - initiallized into descenant
end variables

event doc_usege;// ÄÝ÷åôá Ýíá string áðü Message ï ïðïßï åßíáé ç where clause
// Optionally set order into descenant
// Ðñïóï÷Þ þóôå ôï dw íá ìçí Ý÷åé where êáé order
end event

on w_print_where.create
call super::create
end on

on w_print_where.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;// Get where from message
	is_where = Message.StringParm
	
// Hold initial select of dw
// Replace ' with ~'
	is_select = dw.GetSQLSelect()
	is_select = fn_replace_str(is_select, "'", "~~'")
	
// Retrieve áí ib_retrieve åßíáé true
	TriggerEvent("ie_retrieve")


end event

event ie_retrieve;call super::ie_retrieve;// Retrieve ìå ôçí ôñÝ÷ïõóá is_where (optionally with order)
	
	string	ls_newselect
	
// Wait cursor
	pointer oldpointer
	oldpointer = SetPointer(hourglass!)

// Ç íÝá select 
	if isnull(is_select) then is_select = ""
	if isnull(is_where) then is_where = ""
	if isnull(is_order) then is_order = ""
	
	ls_newselect = is_select + " " + is_where + " " + is_order
	
	dw.SetRedraw(false)
	
	dw.Modify("DataWindow.Table.Select='" + ls_newselect + "'")
	
	open(w_pleasewait)
	dw.retrieve()
	close(w_pleasewait)
	
	dw.SetRedraw(true)

// Åíåñãïðïßçóç - áðåíåñãïðïßçóç menu
	this.TriggerEvent("ie_checkmenu")

// restore pointer
	SetPointer(oldpointer)

end event

type dw from w_print`dw within w_print_where
end type

