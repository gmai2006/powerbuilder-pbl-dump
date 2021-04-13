HA$PBExportHeader$w_print_where_withform.srw
$PBExportComments$
forward
global type w_print_where_withform from w_print
end type
end forward

global type w_print_where_withform from w_print
string menuname = "m_main_print_where_withform"
event me_select ( )
event doc_usage ( )
event me_viewall ( )
end type
global w_print_where_withform w_print_where_withform

type variables
protected 	string	is_select_form		// Ôï üíïìá ôïõ ðáñáèýñïõ ãéá ôçí äçìéïõñãßá where clause
protected	string	is_select			// Original select of dw
protected	string 	is_where				// Where clause created by is_select_form
protected	string	is_order				// order clause initialized into descenant
end variables

forward prototypes
public function string if_openselect ()
public subroutine of_initsqlselect ()
public subroutine of_retrieve ()
end prototypes

event me_select();// ¢íïéãìá ôïõ ðáñáèýñïõ ó÷çìáôéóìïý where
	string ls_where
	ls_where = if_OpenSelect()

// Áí åðéóôñÝøáìå "" åðéóôñÝöïõìå
	if ls_where = "" then return

// Äþóáìå êñéôÞñéá
	is_where = ls_where
	This.TriggerEvent("ie_retrieve")

end event

event doc_usage;// Åêôýðùóç ìå ôïí ó÷çìáôéóìü where áðü Ýíá ó÷åôéêü ðáñÜèõñï
// Inherit this êáé ïñéóìüò ôïõ ðáñáèýñïõ ïñéóìÜôùí is_select_form
// Optionally assign where string into descenant
// Ôï is_select_form åðéóôñÝöåé Ýíá string ìå ôçí ó÷çìáôéóìÝíç where
// Inherit is_select_form from w_search or w_filter
end event

event me_viewall();// Êáôáñãïýìå ôï ößëôñï
	is_where = ""
	This.TriggerEvent("ie_retrieve")
end event

public function string if_openselect ();// ¢íïéãìá ôïõ ðáñáèýñïõ ó÷çìáôéóìïý ôçò where
	
window		w_selectwin

Open(w_selectwin, is_select_form)
return Message.StringParm
end function

public subroutine of_initsqlselect ();is_select = dw.GetSQLSelect()
is_select = fn_replace_str(is_select, "'", "~~'")
end subroutine

public subroutine of_retrieve ();// Override if arguments required
	dw.retrieve()
end subroutine

on w_print_where_withform.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_main_print_where_withform" then this.MenuID = create m_main_print_where_withform
end on

on w_print_where_withform.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;// Hold initial select of dw
	of_initsqlselect()

// Ìå ôï Üíïéãìá ðáñïõóéÜæïõìå ôçí öüñìá ãéá åéóáãùãÞ êñéôçñßùí
	this.postevent("me_select")
end event

event ie_retrieve;call super::ie_retrieve;// Retrieve ìå ôçí ôñÝ÷ïõóá is_where êáé is_order
// It was built with is_select_form
	
	string	ls_newselect
	
// Wait cursor
	pointer oldpointer
	oldpointer = SetPointer(hourglass!)

// Ç íÝá select 
	ls_newselect = is_select + " " + is_where + " " + is_order
	
	dw.SetRedraw(false)
	
	dw.Modify("DataWindow.Table.Select='" + ls_newselect + "'")
	
	of_retrieve()
 	 
	dw.SetRedraw(true)

// Åíåñãïðïßçóç - áðåíåñãïðïßçóç menu
	this.TriggerEvent("ie_checkmenu")
	
// Restore cursor
	SetPointer(oldpointer)


end event

type dw from w_print`dw within w_print_where_withform
end type

