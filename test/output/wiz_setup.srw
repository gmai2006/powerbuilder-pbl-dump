HA$PBExportHeader$wiz_setup.srw
$PBExportComments$
forward
global type wiz_setup from w_wizmain
end type
type p_1 from picture within wiz_setup
end type
end forward

global type wiz_setup from w_wizmain
integer width = 3077
p_1 p_1
end type
global wiz_setup wiz_setup

forward prototypes
protected subroutine of_addsteps ()
protected function boolean of_finish ()
end prototypes

protected subroutine of_addsteps ();addstep("step1_seasons", "seasons")
end subroutine

protected function boolean of_finish ();// update seasons
	step1_seasons	uo_seasons
	uo_seasons = getstep("seasons")
	uo_seasons.uo_seasons.dw.update()
	commit;
	
	
// Close wizard
	return true
end function

on wiz_setup.create
int iCurrent
call super::create
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
end on

on wiz_setup.destroy
call super::destroy
destroy(this.p_1)
end on

event open;call super::open;this.title = trn(709)	// Payroll setup wizard
end event

type ucv_step from w_wizmain`ucv_step within wiz_setup
integer x = 997
integer width = 2021
integer height = 1488
end type

type cb_cancel from w_wizmain`cb_cancel within wiz_setup
integer x = 2619
end type

type cb_prev from w_wizmain`cb_prev within wiz_setup
integer x = 1696
end type

type cb_next from w_wizmain`cb_next within wiz_setup
integer x = 2158
end type

type p_1 from picture within wiz_setup
integer x = 37
integer y = 20
integer width = 905
integer height = 1488
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

