HA$PBExportHeader$w_afxptoseis_form.srw
$PBExportComments$
forward
global type w_afxptoseis_form from w_singleform
end type
end forward

global type w_afxptoseis_form from w_singleform
integer width = 1646
integer height = 612
string title = ""
end type
global w_afxptoseis_form w_afxptoseis_form

type variables
string	is_onom
end variables

forward prototypes
public subroutine of_open ()
public subroutine of_retrieve ()
end prototypes

public subroutine of_open ();// ÊñáôÜìå ôçí ïíïìáóôéêÞ
	is_onom = Message.StringParm
end subroutine

public subroutine of_retrieve ();long	ll_rows

ll_rows = dw_main.retrieve(is_onom)
if ll_rows = 0 then
	dw_main.insertrow(0)
	dw_main.object.onom[1] = is_onom
end if
end subroutine

on w_afxptoseis_form.create
call super::create
end on

on w_afxptoseis_form.destroy
call super::destroy
end on

event open;call super::open;// Set title
	this.title = trn(578) + " - [" + is_onom + "]"
end event

type cb_cancel from w_singleform`cb_cancel within w_afxptoseis_form
integer x = 1289
integer y = 384
end type

type cb_ok from w_singleform`cb_ok within w_afxptoseis_form
integer x = 933
integer y = 384
end type

type dw_main from w_singleform`dw_main within w_afxptoseis_form
integer x = 9
integer y = 8
integer width = 1614
integer height = 348
string dataobject = "dw_afxptoseis_form"
boolean border = false
borderstyle borderstyle = stylebox!
end type

