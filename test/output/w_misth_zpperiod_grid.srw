HA$PBExportHeader$w_misth_zpperiod_grid.srw
$PBExportComments$
forward
global type w_misth_zpperiod_grid from w_pbgrid
end type
end forward

global type w_misth_zpperiod_grid from w_pbgrid
integer width = 2245
integer height = 1868
string title = "title"
string icon = "res\pinakes.ico"
string is_tablename = "misth_zpperiod"
end type
global w_misth_zpperiod_grid w_misth_zpperiod_grid

forward prototypes
public function boolean of_check4required (ref datawindow adw, long row)
public subroutine of_postinitrow (ref datawindow adw, long row)
public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor)
public function long if_retrieve ()
end prototypes

public function boolean of_check4required (ref datawindow adw, long row);string	lstring	
long		ll_found
long		llong	
date		ldate
time		ltime

// kodperiod
	lstring = adw.object.kodperiod[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(190))
		adw.setfocus()
		adw.setcolumn("kodperiod")
		return false
	end if
	
	// ¸ëåã÷ïò áí ï êùäéêüò õðÜñ÷åé
		ll_found = adw.find("kodperiod = '" + lstring + "'", 1, adw.rowcount())
		if ll_found = row then ll_found = adw.find("kodperiod = '" + lstring + "'", ll_found + 1, adw.rowcount())
		if ll_found > 0 and ll_found <> row then
			MessageBox(gs_app_name, trn(133))
			adw.setfocus()
			adw.Setcolumn("kodperiod")
			return false
		end if	
		
// descperiod
	lstring = adw.object.descperiod[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(179))
		adw.setfocus()
		adw.setcolumn("descperiod")
		return false
	end if
	
	// ¸ëåã÷ïò áí ç ðåñéãñáöÞ õðÜñ÷åé
		ll_found = adw.find("descperiod = '" + lstring + "'", 1, adw.rowcount())
		if ll_found = row then ll_found = adw.find("descperiod = '" + lstring + "'", ll_found + 1, adw.rowcount())
		if ll_found > 0 and ll_found <> row then
			MessageBox(gs_app_name, trn(130))
			adw.setfocus()
			adw.Setcolumn("descperiod")
			return false
		end if	
	
	
// everything ok
	return true
end function

public subroutine of_postinitrow (ref datawindow adw, long row);adw.object.kodxrisi[row] = gs_kodxrisi
adw.object.orderno[row] = fn_maxindw(adw, "orderno") + 1
end subroutine

public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor);al_rowrcolor = rgb(128,255,128)
end subroutine

public function long if_retrieve ();long	ll_nrows

ll_nrows = dw_main.retrieve(gs_kodxrisi)

return ll_nrows
end function

on w_misth_zpperiod_grid.create
call super::create
end on

on w_misth_zpperiod_grid.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;// translation
	title = trn(529)
	
end event

type dw_main from w_pbgrid`dw_main within w_misth_zpperiod_grid
integer width = 2213
integer height = 1668
string dataobject = "dw_misth_zpperiod_list"
end type

