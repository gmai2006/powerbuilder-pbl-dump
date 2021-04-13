HA$PBExportHeader$wiz_kratapod.srw
$PBExportComments$
forward
global type wiz_kratapod from w_wizmain
end type
end forward

global type wiz_kratapod from w_wizmain
integer height = 1556
string title = "title"
string icon = "res\kratapod.ico"
string is_nextstr = ""
string is_prevstr = ""
string is_finishstr = ""
string is_cancelstr = ""
end type
global wiz_kratapod wiz_kratapod

forward prototypes
protected subroutine of_addsteps ()
protected function boolean of_finish ()
end prototypes

protected subroutine of_addsteps ();addstep("step_kratapod_kratselect", "kratsel")
addstep("step_kratapod_misthselect", "misthsel")
addstep("step_kratapod_form", "form")
end subroutine

protected function boolean of_finish ();// Ðáßñíïõìå üëá ôá steps
	step_kratapod_kratselect	lcv_kratsel
	step_kratapod_misthselect	lcv_misthsel
	step_kratapod_form			lcv_form
	
	lcv_kratsel = getstep("kratsel")
	lcv_misthsel = getstep("misthsel")
	lcv_form = getstep("form")

// Ðáßñíïõìå ôçí çì/íßá áðüäïóçò êáé ôçí ðåñéãñáöÞ
	date		ld_apoddate
	string	ls_desckratapod

	ld_apoddate = lcv_form.dw.object.apoddate[1]
	ls_desckratapod = lcv_form.dw.object.desckratapod[1]
	
// ÅéóÜãïõìå ôá óôïé÷åßá óôïí ðßíáêá misth_kratapod
	long	ll_kodkratapod
	
	ll_kodkratapod = fn_getkey("misth_kratapod")
	
	insert into misth_kratapod(
		kodkratapod,
		kodxrisi,
		desckratapod,
		apoddate)
	values (
		:ll_kodkratapod,
		:gs_kodxrisi,
		:ls_desckratapod,
		:ld_apoddate);
		
	fn_sqlerror()

// Ãéá êÜèå åðéëåãìÝíç ìéóèïäïóßá
// update kodkratapod
	datawindow	ldw_misth
	integer		li_rows, i
	
	ldw_misth = lcv_misthsel.dw
	li_rows = ldw_misth.rowcount()
	
	for i = 1 to li_rows
		if ldw_misth.object.cm_sel[i] = 1 then
			ldw_misth.object.misth_final_ypal_krat_kodkratapod[i] = ll_kodkratapod
		end if
	next
	
	ldw_misth.update()
	commit;
	
// ÌåôáöïñÜ óôïé÷åßùí óôçí gsc_misth_kratapod
	gsc_misth_kratapod.kodkratapod = ll_kodkratapod
	gsc_misth_kratapod.kodxrisi = gs_kodxrisi
	gsc_misth_kratapod.desckratapod = ls_desckratapod
	gsc_misth_kratapod.apoddate = ld_apoddate
	
// ÅðéóôñïöÞ
	return true
	
	
end function

on wiz_kratapod.create
call super::create
end on

on wiz_kratapod.destroy
call super::destroy
end on

event open;call super::open;// Translation
	title = trn(94)

	
end event

type ucv_step from w_wizmain`ucv_step within wiz_kratapod
integer width = 2601
integer height = 1260
end type

type cb_cancel from w_wizmain`cb_cancel within wiz_kratapod
integer x = 2222
integer y = 1320
end type

type cb_prev from w_wizmain`cb_prev within wiz_kratapod
integer x = 1298
integer y = 1320
end type

type cb_next from w_wizmain`cb_next within wiz_kratapod
integer x = 1760
integer y = 1320
end type

