HA$PBExportHeader$w_print_direct.srw
$PBExportComments$
forward
global type w_print_direct from w_print
end type
end forward

global type w_print_direct from w_print
end type
global w_print_direct w_print_direct

on w_print_direct.create
call super::create
end on

on w_print_direct.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw.SetTransObject(SQLCA)
Open(w_pleasewait)
dw.retrieve()
TriggerEvent("ie_checkmenu")
close(w_pleasewait)
end event

type dw from w_print`dw within w_print_direct
end type

