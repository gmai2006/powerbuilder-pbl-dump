HA$PBExportHeader$w_print_args_noform.srw
$PBExportComments$
forward
global type w_print_args_noform from w_print
end type
end forward

global type w_print_args_noform from w_print
event doc_usage ( )
end type
global w_print_args_noform w_print_args_noform

forward prototypes
public subroutine of_retrieve ()
end prototypes

event doc_usage;// Äçëþíïõìå ìåôáâëçôÝò ãéá ôá ïñßóìáôá êáé ôéò åíçìåñþíïõìå áðü Message óôçí of_open()
// Override of_retrieve ãéá retriaval arguments
end event

public subroutine of_retrieve ();// Override to pass retrieval arguments
end subroutine

on w_print_args_noform.create
call super::create
end on

on w_print_args_noform.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ie_retrieve;call super::ie_retrieve;// Wait cursor
	pointer oldpointer
	oldpointer = SetPointer(hourglass!)
	
of_retrieve()

TriggerEvent("ie_checkmenu")

// restore cursor
	SetPointer(oldpointer)
	
end event

event open;call super::open;// Allways retrieve
	Triggerevent("ie_retrieve")
end event

type dw from w_print`dw within w_print_args_noform
end type

