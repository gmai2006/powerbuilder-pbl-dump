HA$PBExportHeader$w_misth_fylo_form_copy.srw
$PBExportComments$
forward
global type w_misth_fylo_form_copy from w_form
end type
type st_1 from statictext within w_misth_fylo_form_copy
end type
type gb_1 from groupbox within w_misth_fylo_form_copy
end type
end forward

global type w_misth_fylo_form_copy from w_form
integer width = 2089
integer height = 660
string title = "title"
string icon = "res\fylo.ico"
boolean ib_update = true
string is_tablename = "misth_fylo"
st_1 st_1
gb_1 gb_1
end type
global w_misth_fylo_form_copy w_misth_fylo_form_copy

type variables
string		is_kodfylo
end variables

forward prototypes
public function boolean of_check4required (ref datawindow adw, long row)
public subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_retrieve ()
protected subroutine of_storekey ()
public subroutine of_struct2dw (ref datawindow adw, long row)
end prototypes

public function boolean of_check4required (ref datawindow adw, long row);string	lstring	
long		llong	
long		ll_count

// kodfylo
	lstring = adw.object.kodfylo[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(188))
		adw.setfocus()
		adw.setcolumn("kodfylo")
		return false
	end if
	

	// ¸ëåã÷ïò áí ï êùäéêüò Ý÷åé êáôá÷ùñçèåß
		if lstring <> is_kodfylo or isnull(is_kodfylo) or is_kodfylo = "" then
			select count(kodfylo) into :ll_count from misth_fylo
			where kodfylo = :lstring and kodxrisi = :gs_kodxrisi;
			fn_sqlerror()
			if ll_count > 0 then
				Messagebox(gs_app_name, trn(466) + " '" + lstring + "' " + trn(658))
				adw.setfocus()
				adw.setcolumn("kodfylo")
				return false
			end if
		end if

	
// descfylo
	lstring = adw.object.descfylo[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(175))
		adw.setfocus()
		adw.setcolumn("descfylo")
		return false
	end if
	
	
// everything ok
	return true
end function

public subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_fylo.kodfylo = adw.object.kodfylo[row]
gsc_misth_fylo.kodxrisi = adw.object.kodxrisi[row]
gsc_misth_fylo.descfylo = adw.object.descfylo[row]
end subroutine

protected subroutine of_retrieve ();dw_main.retrieve(is_kodfylo, gs_kodxrisi)
end subroutine

protected subroutine of_storekey ();is_kodfylo = gsc_misth_fylo.kodfylo
end subroutine

public subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodfylo[row] = gsc_misth_fylo.kodfylo
adw.object.kodxrisi[row] = gsc_misth_fylo.kodxrisi
adw.object.descfylo[row] = gsc_misth_fylo.descfylo
end subroutine

on w_misth_fylo_form_copy.create
int iCurrent
call super::create
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.gb_1
end on

on w_misth_fylo_form_copy.destroy
call super::destroy
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;call super::open;// translation
	title = trn(83)
	st_1.text = trn(245)
	
end event

type cb_cancel from w_form`cb_cancel within w_misth_fylo_form_copy
integer x = 1719
integer y = 436
end type

type cb_ok from w_form`cb_ok within w_misth_fylo_form_copy
integer x = 1362
integer y = 436
end type

type dw_main from w_form`dw_main within w_misth_fylo_form_copy
integer x = 78
integer y = 160
integer width = 1947
integer height = 204
string dataobject = "dw_misth_fylo_form"
end type

type st_1 from statictext within w_misth_fylo_form_copy
integer x = 46
integer y = 36
integer width = 1833
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_misth_fylo_form_copy
integer x = 46
integer y = 108
integer width = 1989
integer height = 284
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 8388608
long backcolor = 67108864
end type

