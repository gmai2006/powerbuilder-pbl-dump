HA$PBExportHeader$step_kratapod_form.sru
$PBExportComments$
forward
global type step_kratapod_form from bcv_step
end type
type st_1 from statictext within step_kratapod_form
end type
type dw from datawindow within step_kratapod_form
end type
end forward

global type step_kratapod_form from bcv_step
integer width = 2601
integer height = 1100
st_1 st_1
dw dw
end type
global step_kratapod_form step_kratapod_form

forward prototypes
public subroutine of_stepadded ()
public function boolean of_next ()
end prototypes

public subroutine of_stepadded ();dw.object.apoddate[1] = today()
end subroutine

public function boolean of_next ();// check for required data

date		ldate
string	lstring

dw.accepttext()

// apoddate
	ldate	= dw.object.apoddate[1]
	if isnull(ldate) then
		Messagebox(trn(94), trn(167))
		dw.setfocus()
		dw.setcolumn("apoddate")
		return false
	end if	
	
// desckratapod
	lstring = dw.object.desckratapod[1]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(176))
		dw.setfocus()
		dw.setcolumn("desckratapod")
		return false
	end if
	
// Everything OK
	return true
end function

on step_kratapod_form.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw=create dw
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw
end on

on step_kratapod_form.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw)
end on

event constructor;call super::constructor;fn_seteditmask(dw, "apoddate", fn_param_maskdate_e())

// translation
	st_1.text = trn(243)
	
end event

type st_1 from statictext within step_kratapod_form
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

type dw from datawindow within step_kratapod_form
integer x = 27
integer y = 144
integer width = 2537
integer height = 328
integer taborder = 10
string title = "none"
string dataobject = "dw_misth_kratapod_form"
boolean border = false
boolean livescroll = true
end type

event constructor;dw.insertrow(0)
end event

