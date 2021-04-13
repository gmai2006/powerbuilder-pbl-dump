HA$PBExportHeader$wiz_misth_final_details_step1.sru
$PBExportComments$
forward
global type wiz_misth_final_details_step1 from bcv_step
end type
type dw_misth_final from datawindow within wiz_misth_final_details_step1
end type
type st_1 from statictext within wiz_misth_final_details_step1
end type
type gb_1 from groupbox within wiz_misth_final_details_step1
end type
type gb_2 from groupbox within wiz_misth_final_details_step1
end type
end forward

global type wiz_misth_final_details_step1 from bcv_step
integer width = 2930
integer height = 1376
dw_misth_final dw_misth_final
st_1 st_1
gb_1 gb_1
gb_2 gb_2
end type
global wiz_misth_final_details_step1 wiz_misth_final_details_step1

forward prototypes
public subroutine of_stepadded ()
public function boolean of_next ()
public subroutine of_postactivate ()
end prototypes

public subroutine of_stepadded ();// init datawindow
	dw_misth_final.SetTransObject(sqlca)
	dw_misth_final.insertrow(0)
	fn_retrievechild(dw_misth_final, "kodkat", gs_kodxrisi)
	fn_retrievechild(dw_misth_final, "kodperiod", gs_kodxrisi)
	
// init data
	long		ll_aa
	
	select max(aa) into :ll_aa from misth_final
	where kodxrisi = :gs_kodxrisi;
	fn_sqlerror()
	if isnull(ll_aa) then ll_aa = 0

	dw_misth_final.object.kodfinal[1] = fn_getkey("misth_final")
	dw_misth_final.object.aa[1] = ll_aa + 1
	dw_misth_final.object.kodxrisi[1] = gs_kodxrisi
	dw_misth_final.object.datefinal[1] = today()









end subroutine

public function boolean of_next ();// check for required

dw_misth_final.AcceptText()

string		lstring	
long		llong	
long		ll_count
date		ldate

// aa
	llong	= dw_misth_final.object.aa[1]
	if isnull(llong) then
		Messagebox(gs_app_name, trn(157))
		dw_misth_final.setfocus()
		dw_misth_final.setcolumn("aa")
		return false
	end if
	
	// ¸ëåã÷ïò áí ï êùäéêüò Ý÷åé êáôá÷ùñçèåß
		select count(aa) into :ll_count from misth_final
		where kodfinal = :llong and kodxrisi = :gs_kodxrisi;
		fn_sqlerror()
		if ll_count > 0 then
			Messagebox(gs_app_name, trn(353) + " '" + string(llong) + "' " + trn(658))
			dw_misth_final.setfocus()
			dw_misth_final.setcolumn("aa")
			return false
		end if
		
// kodkat
	lstring = dw_misth_final.object.kodkat[1]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(171))
		dw_misth_final.setfocus()
		dw_misth_final.setcolumn("kodkat")
		return false
	end if

// datefinal
	ldate	= dw_misth_final.object.datefinal[1]
	if isnull(ldate) then
		Messagebox(gs_app_name, trn(170))
		dw_misth_final.setfocus()
		dw_misth_final.setcolumn("datefinal")
		return false
	end if	
	
// descfinal
	lstring = dw_misth_final.object.descfinal[1]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(177))
		dw_misth_final.setfocus()
		dw_misth_final.setcolumn("descfinal")
		return false
	end if

// everything ok
	return true
	
	
end function

public subroutine of_postactivate ();dw_misth_final.setfocus()
end subroutine

on wiz_misth_final_details_step1.create
int iCurrent
call super::create
this.dw_misth_final=create dw_misth_final
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_misth_final
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.gb_2
end on

on wiz_misth_final_details_step1.destroy
call super::destroy
destroy(this.dw_misth_final)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event constructor;call super::constructor;// translation
	st_1.text = trn(244)
end event

type dw_misth_final from datawindow within wiz_misth_final_details_step1
integer x = 55
integer y = 276
integer width = 2821
integer height = 360
integer taborder = 20
string title = "none"
string dataobject = "dw_misth_final_form"
boolean border = false
boolean livescroll = true
end type

type st_1 from statictext within wiz_misth_final_details_step1
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

type gb_1 from groupbox within wiz_misth_final_details_step1
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

type gb_2 from groupbox within wiz_misth_final_details_step1
integer x = 23
integer y = 200
integer width = 2880
integer height = 480
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

