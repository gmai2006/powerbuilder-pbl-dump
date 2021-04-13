HA$PBExportHeader$wiz_misth_final_details.srw
$PBExportComments$
forward
global type wiz_misth_final_details from w_wizmain
end type
end forward

global type wiz_misth_final_details from w_wizmain
integer width = 2999
integer height = 1712
string title = "title"
string icon = "res\final.ico"
string is_nextstr = ""
string is_prevstr = ""
string is_finishstr = ""
string is_cancelstr = ""
end type
global wiz_misth_final_details wiz_misth_final_details

forward prototypes
protected subroutine of_addsteps ()
protected function boolean of_finish ()
end prototypes

protected subroutine of_addsteps ();addstep("wiz_misth_final_details_step1", "step1")
addstep("wiz_misth_final_details_step2", "step2")
addstep("wiz_misth_final_details_step3", "step3")
addstep("wiz_misth_final_details_step4", "step4")
end subroutine

protected function boolean of_finish ();// Get step object
	wiz_misth_final_details_step1		uo_step1
	wiz_misth_final_details_step2		uo_step2
	wiz_misth_final_details_step3		uo_step3
	wiz_misth_final_details_step4		uo_step4
	
	uo_step1 = getstep("step1")
	uo_step2 = getstep("step2")
	uo_step3 = getstep("step3")
	uo_step4 = getstep("step4")

// Get kodfinal and update dw_misth_final (step1)
	long	ll_kodfinal
	ll_kodfinal = uo_step1.dw_misth_final.object.kodfinal[1]
	uo_step1.dw_misth_final.update()	

// Get selected ypal (step2)
// and insert into misth_final_ypal
	long	ll_kodypal
	long	ll_row
	ll_row = uo_step2.dw_misth_ypal.getrow()
	ll_kodypal = uo_step2.dw_misth_ypal.object.kodypal[ll_row]
	
	insert into misth_final_ypal (
						kodfinal,
						kodypal,
						kodxrisi)
	values (
						:ll_kodfinal,
						:ll_kodypal,
						:gs_kodxrisi);
	fn_sqlerror()
	commit;

// give kodfinal and kodypal into dw_epidom & dw_krat
// of step3 and step4
	long i, ll_rows
	datawindow	idw_epidom, idw_krat
	
	idw_epidom = uo_step3.uo_epidom.dw
	idw_krat = uo_step4.uo_krat.dw
	
	ll_rows = idw_epidom.rowcount()
	for i = 1 to ll_rows - 1		// not the last new row
		idw_epidom.object.kodfinal[i] = ll_kodfinal
		idw_epidom.object.kodypal[i] = ll_kodypal
	next
	
	ll_rows = idw_krat.rowcount()
	for i = 1 to ll_rows - 1				// not the last new row
		idw_krat.object.kodfinal[i] = ll_kodfinal
		idw_krat.object.kodypal[i] = ll_kodypal
	next
	
// update dw_epidom & dw_krat
	idw_epidom.update()
	idw_krat.update()
	commit;
	
// ÌåôáöïñÜ óôïé÷åßùí óôçí gsc_misth_final_ypal
	gsc_misth_final_ypal.kodfinal = ll_kodfinal
	gsc_misth_final_ypal.kodypal = ll_kodypal
	gsc_misth_final_ypal.kodxrisi = gs_kodxrisi
	
	
// close wizard	
	return true	
end function

on wiz_misth_final_details.create
call super::create
end on

on wiz_misth_final_details.destroy
call super::destroy
end on

event open;call super::open;// translation
	title = trn(470)
end event

type ucv_step from w_wizmain`ucv_step within wiz_misth_final_details
integer width = 2930
integer height = 1376
end type

type cb_cancel from w_wizmain`cb_cancel within wiz_misth_final_details
integer x = 2551
integer y = 1460
end type

type cb_prev from w_wizmain`cb_prev within wiz_misth_final_details
integer x = 1627
integer y = 1460
end type

type cb_next from w_wizmain`cb_next within wiz_misth_final_details
integer x = 2089
integer y = 1460
end type

