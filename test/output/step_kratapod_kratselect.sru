HA$PBExportHeader$step_kratapod_kratselect.sru
$PBExportComments$
forward
global type step_kratapod_kratselect from bcv_step
end type
type st_1 from statictext within step_kratapod_kratselect
end type
type uo_krat from uo_misth_zpkrat_sel within step_kratapod_kratselect
end type
end forward

global type step_kratapod_kratselect from bcv_step
integer width = 2601
integer height = 1100
st_1 st_1
uo_krat uo_krat
end type
global step_kratapod_kratselect step_kratapod_kratselect

type variables
protected	string		is_where
end variables

forward prototypes
public subroutine of_stepadded ()
public function boolean of_next ()
public function string if_createwhere ()
end prototypes

public subroutine of_stepadded ();uo_krat.TriggerEvent("ie_retrieve")
end subroutine

public function boolean of_next ();// ¸ëåã÷ïò áí åðéëÝîáìå ôïõëÜ÷éóôïí ìßá êñÜôçóç
	long		llong
	
	llong = uo_krat.dw_target.rowcount()
	if llong = 0 then
		Messagebox(trn(94), trn(552))
		uo_krat.setfocus()
		return false
	end if	
	
// ¢í Ý÷åé áëëÜîåé ç ôñÝ÷ïõóá where 
// retrieve step_kratapod_misthselect
	string	ls_where
	ls_where = if_createwhere()
	step_kratapod_misthselect		lcv_misth
	
	if ls_where <> is_where then
		is_where = ls_where
		lcv_misth = iw_parent.getstep("misthsel")
		lcv_misth.if_retrieve(ls_where)
	end if
	

// ¼ëá åíôÜîç
	return true
end function

public function string if_createwhere ();// Create where from selected kratiseis

	string	ls_where

// Get target_dw
	datawindow	ldw_krat
	ldw_krat = uo_krat.dw_target

// count rows (selected krat)
	long			ll_rows
	ll_rows = ldw_krat.rowcount()
	
// for each krat add to where
	long	i
	
	for i = 1 to ll_rows
		ls_where = ls_where + " OR misth_final_ypal_krat.kodkrat = ~~'" + string(ldw_krat.object.kodkrat[i]) + "~~'"
	next

// Áöáßñåóç ôïõ áñ÷éêïý OR (4 ÷áñáêôÞñåò ìå ôá 2 êåíÜ)
// êáé ðñïóèÞêç ðáñåíèÝóåùí êáé "AND
	ls_where = right(ls_where, Len(ls_where)-4)
	ls_where = " AND (" + ls_where + ")"
	
	return ls_where
end function

on step_kratapod_kratselect.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_krat=create uo_krat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_krat
end on

on step_kratapod_kratselect.destroy
call super::destroy
destroy(this.st_1)
destroy(this.uo_krat)
end on

event constructor;call super::constructor;// translation
	st_1.text = trn(311)
	
end event

type st_1 from statictext within step_kratapod_kratselect
integer x = 27
integer y = 36
integer width = 2537
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_krat from uo_misth_zpkrat_sel within step_kratapod_kratselect
integer x = 27
integer y = 128
integer taborder = 30
end type

on uo_krat.destroy
call uo_misth_zpkrat_sel::destroy
end on

