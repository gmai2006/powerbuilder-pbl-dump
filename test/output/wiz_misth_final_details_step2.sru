HA$PBExportHeader$wiz_misth_final_details_step2.sru
$PBExportComments$
forward
global type wiz_misth_final_details_step2 from bcv_step
end type
type dw_misth_ypal from datawindow within wiz_misth_final_details_step2
end type
type st_1 from statictext within wiz_misth_final_details_step2
end type
type gb_1 from groupbox within wiz_misth_final_details_step2
end type
end forward

global type wiz_misth_final_details_step2 from bcv_step
integer width = 2930
integer height = 1376
dw_misth_ypal dw_misth_ypal
st_1 st_1
gb_1 gb_1
end type
global wiz_misth_final_details_step2 wiz_misth_final_details_step2

forward prototypes
public subroutine of_stepadded ()
public function boolean of_next ()
public subroutine of_postactivate ()
end prototypes

public subroutine of_stepadded ();// init datawindow
	dw_misth_ypal.SetTransObject(sqlca)
	dw_misth_ypal.retrieve(gs_kodxrisi)
	dw_misth_ypal.setrow(1)
	dw_misth_ypal.selectrow(1, true)
	






end subroutine

public function boolean of_next ();// ÅëÝã÷ïò áí Ý÷åé åðéëåãåß õðÜëëçëïò

	long		ll_row
	
	ll_row = dw_misth_ypal.getrow()
	if ll_row = 0 then 
		MessageBox("gs_app_name", trn(201))
		return false
	end if
	
// everything ok
	return true
	
	
end function

public subroutine of_postactivate ();dw_misth_ypal.setfocus()
end subroutine

on wiz_misth_final_details_step2.create
int iCurrent
call super::create
this.dw_misth_ypal=create dw_misth_ypal
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_misth_ypal
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.gb_1
end on

on wiz_misth_final_details_step2.destroy
call super::destroy
destroy(this.dw_misth_ypal)
destroy(this.st_1)
destroy(this.gb_1)
end on

event constructor;call super::constructor;// translation
	st_1.text = trn(313)
end event

type dw_misth_ypal from datawindow within wiz_misth_final_details_step2
integer x = 23
integer y = 224
integer width = 2880
integer height = 1136
integer taborder = 20
string title = "none"
string dataobject = "dw_misth_ypal_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanging;this.SelectRow(currentrow, false)
this.Selectrow(newrow, true)
end event

type st_1 from statictext within wiz_misth_final_details_step2
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

type gb_1 from groupbox within wiz_misth_final_details_step2
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

