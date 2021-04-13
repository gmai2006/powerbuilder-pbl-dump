HA$PBExportHeader$w_misth_zpxrisi_form.srw
$PBExportComments$
forward
global type w_misth_zpxrisi_form from w_form
end type
type gb_1 from groupbox within w_misth_zpxrisi_form
end type
end forward

global type w_misth_zpxrisi_form from w_form
integer width = 1509
integer height = 816
string title = "title"
string icon = "res\xrisi.ico"
boolean ib_update = true
string is_tablename = "misth_zpxrisi"
gb_1 gb_1
end type
global w_misth_zpxrisi_form w_misth_zpxrisi_form

type variables
string	is_kodxrisi
end variables

forward prototypes
protected subroutine of_storekey ()
public function boolean of_check4required (ref datawindow adw, long row)
public subroutine of_dw2struct (ref datawindow adw, long row)
public subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_retrieve ()
end prototypes

protected subroutine of_storekey ();is_kodxrisi = gsc_misth_zpxrisi.kodxrisi
end subroutine

public function boolean of_check4required (ref datawindow adw, long row);string	lstring	
long		llong	
date		ldate
time		ltime
long		ll_count

// kodxrisi
	lstring = adw.object.kodxrisi[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(188))
		adw.setfocus()
		adw.setcolumn("kodxrisi")
		return false
	end if
	
	// ¸ëåã÷ïò áí ï êùäéêüò Ý÷åé êáôá÷ùñçèåß
		if lstring <> is_kodxrisi or isnull(is_kodxrisi) or is_kodxrisi = "" then
			select count(kodxrisi) into :ll_count from misth_zpxrisi
			where kodxrisi = :lstring;
			fn_sqlerror()
			if ll_count > 0 then
				Messagebox(gs_app_name, tr("Ï Êùäéêüò") + " '" + lstring + "' " + trn(658))
				adw.setfocus()
				adw.setcolumn("kodxrisi")
				return false
			end if
		end if

// descxrisi
	lstring = adw.object.descxrisi[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(175))
		adw.setfocus()
		adw.setcolumn("descxrisi")
		return false
	end if
	
	
// startdate
	ldate	= adw.object.startdate[row]
	if isnull(ldate) then
		Messagebox(gs_app_name, trn(168))
		adw.setfocus()
		adw.setcolumn("startdate")
		return false
	end if	
	
// enddate
	ldate	= adw.object.enddate[row]
	if isnull(ldate) then
		Messagebox(gs_app_name, trn(169))
		adw.setfocus()
		adw.setcolumn("enddate")
		return false
	end if		
	

// everything ok
	return true
end function

public subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_zpxrisi.kodxrisi = adw.object.kodxrisi[row]
gsc_misth_zpxrisi.descxrisi = adw.object.descxrisi[row]
gsc_misth_zpxrisi.startdate = adw.object.startdate[row]
gsc_misth_zpxrisi.enddate = adw.object.enddate[row]
end subroutine

public subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodxrisi[row] = gsc_misth_zpxrisi.kodxrisi
adw.object.descxrisi[row] = gsc_misth_zpxrisi.descxrisi
adw.object.startdate[row] = gsc_misth_zpxrisi.startdate
adw.object.enddate[row] = gsc_misth_zpxrisi.enddate
end subroutine

protected subroutine of_retrieve ();dw_main.retrieve(is_kodxrisi)
end subroutine

on w_misth_zpxrisi_form.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on w_misth_zpxrisi_form.destroy
call super::destroy
destroy(this.gb_1)
end on

event open;call super::open;title = trn(600)

end event

type cb_cancel from w_form`cb_cancel within w_misth_zpxrisi_form
integer x = 1152
integer y = 576
end type

type cb_ok from w_form`cb_ok within w_misth_zpxrisi_form
integer x = 795
integer y = 576
end type

type dw_main from w_form`dw_main within w_misth_zpxrisi_form
integer x = 55
integer y = 68
integer width = 1376
integer height = 424
string dataobject = "dw_misth_zpxrisi_form"
end type

type gb_1 from groupbox within w_misth_zpxrisi_form
integer x = 32
integer width = 1431
integer height = 532
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

