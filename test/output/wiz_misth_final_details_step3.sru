HA$PBExportHeader$wiz_misth_final_details_step3.sru
$PBExportComments$
forward
global type wiz_misth_final_details_step3 from bcv_step
end type
type uo_epidom from uo_misth_final_ypal_epidom_noparent_grid within wiz_misth_final_details_step3
end type
type st_1 from statictext within wiz_misth_final_details_step3
end type
type gb_1 from groupbox within wiz_misth_final_details_step3
end type
end forward

global type wiz_misth_final_details_step3 from bcv_step
integer width = 2930
integer height = 1376
uo_epidom uo_epidom
st_1 st_1
gb_1 gb_1
end type
global wiz_misth_final_details_step3 wiz_misth_final_details_step3

forward prototypes
public function boolean of_next ()
public subroutine of_stepadded ()
public subroutine of_postactivate ()
end prototypes

public function boolean of_next ();// check for required or current uo_epidom row
	long	ll_row
	
	ll_row = uo_epidom.dw.getrow()
	if ll_row = 0 then return true
	
	return uo_epidom.of_check4required(uo_epidom.dw, ll_row)
	

	
	
end function

public subroutine of_stepadded ();// retrieve kodepidom
	fn_retrievechild(uo_epidom.dw, "kodepidom", gs_kodxrisi)
end subroutine

public subroutine of_postactivate ();uo_epidom.dw.setfocus()
end subroutine

on wiz_misth_final_details_step3.create
int iCurrent
call super::create
this.uo_epidom=create uo_epidom
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_epidom
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.gb_1
end on

on wiz_misth_final_details_step3.destroy
call super::destroy
destroy(this.uo_epidom)
destroy(this.st_1)
destroy(this.gb_1)
end on

event constructor;call super::constructor;// translation
	st_1.text = trn(310)
end event

type uo_epidom from uo_misth_final_ypal_epidom_noparent_grid within wiz_misth_final_details_step3
integer y = 216
integer taborder = 20
end type

on uo_epidom.destroy
call uo_misth_final_ypal_epidom_noparent_grid::destroy
end on

type st_1 from statictext within wiz_misth_final_details_step3
integer x = 55
integer y = 80
integer width = 2821
integer height = 64
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

type gb_1 from groupbox within wiz_misth_final_details_step3
integer x = 23
integer y = 16
integer width = 2880
integer height = 168
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

