HA$PBExportHeader$w_afxptoseis_grid.srw
$PBExportComments$
forward
global type w_afxptoseis_grid from w_pbgrid
end type
end forward

global type w_afxptoseis_grid from w_pbgrid
integer width = 2729
integer height = 1964
string is_tablename = "afxptoseis"
end type
global w_afxptoseis_grid w_afxptoseis_grid

forward prototypes
public function boolean of_check4required (ref datawindow adw, long row)
end prototypes

public function boolean of_check4required (ref datawindow adw, long row);string	lstring	
long		ll_found

// onom
	lstring = adw.object.onom[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(554))
		adw.setfocus()
		adw.setcolumn("onom")
		return false
	end if
	
	// ¸ëåã÷ïò áí  õðÜñ÷åé
		ll_found = adw.find("onom = '" + lstring + "'", 1, adw.rowcount())
		if ll_found = row then ll_found = adw.find("onom = '" + lstring + "'", ll_found + 1, adw.rowcount())
		if ll_found > 0 and ll_found <> row then
			MessageBox(gs_app_name, trn(132))
			adw.setfocus()
			adw.Setcolumn("onom")
			return false
		end if	
	
// everything ok
	return true
end function

on w_afxptoseis_grid.create
call super::create
end on

on w_afxptoseis_grid.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;title = trn(578)
end event

type dw_main from w_pbgrid`dw_main within w_afxptoseis_grid
integer width = 2693
integer height = 1748
string dataobject = "dw_afxptoseis_list"
end type

