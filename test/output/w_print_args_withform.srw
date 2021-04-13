HA$PBExportHeader$w_print_args_withform.srw
$PBExportComments$
forward
global type w_print_args_withform from w_print
end type
end forward

global type w_print_args_withform from w_print
string menuname = "m_main_print_args_withform"
event me_getargs ( )
end type
global w_print_args_withform w_print_args_withform

type variables
string		is_argwin
end variables

forward prototypes
public subroutine of_retrieve ()
public subroutine of_storeargs ()
public function boolean if_openargwin ()
end prototypes

event me_getargs();// ¢íïéãìá ôïõ ðáñáèýñïõ åðéëïãÞò ïñéóìÜôùí
// Ôá ïñßóìáôá óå globals
	if not if_openargwin() then return

// Äþóáìå êñéôÞñéá
	This.TriggerEvent("ie_retrieve")
	

end event

public subroutine of_retrieve ();// Override to pass retrieval arguments
end subroutine

public subroutine of_storeargs ();// Åêôåëåßôáé êáôÜ ôï Üíïéãìá
// ÁðïèÞêåõóç ôùí ïñéóìÜôùí óå ôïðéêÝò ìåôáâëçôÝò
// ðïõ ôéò Ý÷ïõìå äçëþóåé ðñéí
end subroutine

public function boolean if_openargwin ();// ¢íïéãìá ôïõ ðáñáèýñïõ åðéëïãÞò ïñéóìÜôùí

window		w_argwin
integer		li_ret

Open(w_argwin, is_argwin)
li_ret = Message.DoubleParm

if li_ret = 1 then
	of_storeargs()
	return true
else
	return false
end if

end function

on w_print_args_withform.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_main_print_args_withform" then this.MenuID = create m_main_print_args_withform
end on

on w_print_args_withform.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ie_retrieve;call super::ie_retrieve;// Wait cursor
	pointer oldpointer
	oldpointer = SetPointer(hourglass!)
	
dw.SetRedraw(false)	
of_retrieve()
dw.SetRedraw(true)

TriggerEvent("ie_checkmenu")

// restore cursor
	SetPointer(oldpointer)
	
end event

event open;call super::open;// Ìå ôï Üíïéãìá ðáñïõóéÜæïõìå ôçí öüñìá ãéá åéóáãùãÞ êñéôçñßùí
	this.TriggerEvent("me_getargs")

end event

type dw from w_print`dw within w_print_args_withform
end type

