HA$PBExportHeader$step1_seasons.sru
$PBExportComments$
forward
global type step1_seasons from bcv_step
end type
type uo_seasons from step1_seasons_obj within step1_seasons
end type
type st_info from statictext within step1_seasons
end type
type gb_1 from groupbox within step1_seasons
end type
end forward

global type step1_seasons from bcv_step
integer width = 2021
integer height = 1488
uo_seasons uo_seasons
st_info st_info
gb_1 gb_1
end type
global step1_seasons step1_seasons

forward prototypes
public subroutine of_stepadded ()
public function boolean of_next ()
end prototypes

public subroutine of_stepadded ();uo_seasons.dw.retrieve()
end subroutine

public function boolean of_next ();// We must have at least one season
	if uo_seasons.dw.rowcount() = 0 then
		MessageBox(gs_app_name, trn(708))
		return false
	else
		return true
	end if
end function

on step1_seasons.create
int iCurrent
call super::create
this.uo_seasons=create uo_seasons
this.st_info=create st_info
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_seasons
this.Control[iCurrent+2]=this.st_info
this.Control[iCurrent+3]=this.gb_1
end on

on step1_seasons.destroy
call super::destroy
destroy(this.uo_seasons)
destroy(this.st_info)
destroy(this.gb_1)
end on

event constructor;call super::constructor;st_info.text = trn(707)
end event

type uo_seasons from step1_seasons_obj within step1_seasons
integer x = 41
integer y = 356
integer taborder = 50
end type

on uo_seasons.destroy
call step1_seasons_obj::destroy
end on

type st_info from statictext within step1_seasons
integer x = 82
integer y = 80
integer width = 1861
integer height = 196
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "info"
boolean focusrectangle = false
end type

type gb_1 from groupbox within step1_seasons
integer x = 41
integer y = 32
integer width = 1938
integer height = 292
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

