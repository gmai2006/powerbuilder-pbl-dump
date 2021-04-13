HA$PBExportHeader$uo_misth_final_ypal_epidom_grid.sru
$PBExportComments$
forward
global type uo_misth_final_ypal_epidom_grid from u_grid
end type
end forward

global type uo_misth_final_ypal_epidom_grid from u_grid
integer width = 2167
integer height = 1068
boolean ib_sort = false
string is_tablename = "misth_final_epidom"
end type
global uo_misth_final_ypal_epidom_grid uo_misth_final_ypal_epidom_grid

type variables
w_misth_final_form_edit		iw_parent
end variables

forward prototypes
public subroutine of_postinitrow (ref datawindow adw, long row)
public function boolean of_check4required (ref datawindow adw, long row)
public subroutine uf_filter (long al_kodypal)
public subroutine of_setmasks ()
public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor)
end prototypes

public subroutine of_postinitrow (ref datawindow adw, long row);adw.object.kodfinal[row] = iw_parent.dw_main.object.kodfinal[1]
adw.object.kodxrisi[row] = gs_kodxrisi
adw.object.poso[row] = 0
adw.object.aa[row] = fn_maxindw(adw, "aa") + 1

// kodypal
	long		ll_row
	ll_row = iw_parent.dw_ypal.getrow()
	adw.object.kodypal[row] = iw_parent.dw_ypal.object.misth_final_ypal_kodypal[ll_row]
	
end subroutine

public function boolean of_check4required (ref datawindow adw, long row);string	lstring	
long		ll_found	
date		ldate
time		ltime

// Check if we are on the empty row (last)
	if row = adw.rowcount() then return true

// kodepidom
	lstring = adw.object.kodepidom[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(200))
		adw.setfocus()
		adw.setcolumn("kodepidom")
		return false
	end if
	
	// ¸ëåã÷ïò áí ï êùäéêüò õðÜñ÷åé
		ll_found = adw.find("kodepidom = '" + lstring + "'", 1, adw.rowcount())
		if ll_found = row then ll_found = adw.find("kodepidom = '" + lstring + "'", ll_found + 1, adw.rowcount())
		if ll_found > 0 and ll_found <> row then
			MessageBox(gs_app_name, trn(131))
			adw.setfocus()
			adw.Setcolumn("kodepidom")
			return false
		end if		

// everything ok
	return true
end function

public subroutine uf_filter (long al_kodypal);// ÖéëôñÜñéóìá ãéá ôïí õðÜëëçëï al_kodypal

dw.setredraw(false)
dw.setfilter("kodypal = " + string(al_kodypal))
dw.filter()
dw.setsort("aa")
dw.sort()

// Insert a new record at the end
	if_insertrow()
	
// reset flags	
	ib_edit = false
	ib_newrec = false

dw.setredraw(true)


end subroutine

public subroutine of_setmasks ();fn_seteditmask(dw, "poso", fn_param_maskposo_e())
end subroutine

public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor);al_rowrcolor = rgb(191,255,191)
end subroutine

on uo_misth_final_ypal_epidom_grid.create
call super::create
end on

on uo_misth_final_ypal_epidom_grid.destroy
call super::destroy
end on

type pb_selectall from u_grid`pb_selectall within uo_misth_final_ypal_epidom_grid
integer x = 1893
end type

type pb_selectrow from u_grid`pb_selectrow within uo_misth_final_ypal_epidom_grid
integer x = 1778
end type

type pb_new from u_grid`pb_new within uo_misth_final_ypal_epidom_grid
integer x = 1614
end type

type pb_last from u_grid`pb_last within uo_misth_final_ypal_epidom_grid
integer x = 1490
end type

type pb_next from u_grid`pb_next within uo_misth_final_ypal_epidom_grid
integer x = 1376
end type

type pb_previous from u_grid`pb_previous within uo_misth_final_ypal_epidom_grid
integer x = 1262
end type

type pb_first from u_grid`pb_first within uo_misth_final_ypal_epidom_grid
integer x = 1147
end type

type pb_delete from u_grid`pb_delete within uo_misth_final_ypal_epidom_grid
integer x = 2057
end type

type dw from u_grid`dw within uo_misth_final_ypal_epidom_grid
integer width = 2162
integer height = 952
string dataobject = "dw_misth_final_ypal_epidom_list"
end type

