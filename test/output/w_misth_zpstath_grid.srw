HA$PBExportHeader$w_misth_zpstath_grid.srw
$PBExportComments$
forward
global type w_misth_zpstath_grid from w_pbgrid
end type
end forward

global type w_misth_zpstath_grid from w_pbgrid
integer width = 2533
integer height = 1900
string title = "title"
string menuname = "m_misth_zpstath_grid"
string icon = "res\pinakes.ico"
string is_tablename = "misth_stath"
event me_create_yvar ( )
event me_create_epidom ( )
event me_create_krat ( )
end type
global w_misth_zpstath_grid w_misth_zpstath_grid

forward prototypes
public function boolean of_check4required (ref datawindow adw, long row)
public subroutine of_postinitrow (ref datawindow adw, long row)
public subroutine of_setmasks ()
public function long if_retrieve ()
end prototypes

event me_create_yvar();// Äçìéïõñãßá ìåôáâëçôÞò õðáëëÞëïõ ìå ôá óôïé÷åßá ôçò óôáèåñÜò

// Ðáßñíïõìå ôçí åðéëåãìÝíç åããñáöÞ
	long		ll_row
	
	ll_row = dw_main.getrow()
	
	if ll_row = 0 then return
	
// Ðáßñíïõìå ôïí êùäéêü êáé ôçí ðåñéãñáöÞ ôçò óôáèåñÜò
// êáé áíïßãïõìå ôç öüñìá äçìïõñãßáò ìåôáâëçôÞò
	gsc_misth_zpyvar_reset()
	
	gsc_misth_zpyvar.kodyvar = dw_main.object.kodstath[ll_row]
	gsc_misth_zpyvar.kodxrisi = gs_kodxrisi
	gsc_misth_zpyvar.descyvar = dw_main.object.descstath[ll_row]

	OpenWithParm(w_misth_zpyvar_form, 0)
end event

event me_create_epidom();// Äçìéïõñãßá åðéäüìáôïò ìå ôá óôïé÷åßá ôçò óôáèåñÜò

// Ðáßñíïõìå ôçí åðéëåãìÝíç åããñáöÞ
	long		ll_row
	
	ll_row = dw_main.getrow()
	
	if ll_row = 0 then return
	
// Ðáßñíïõìå ôïí êùäéêü êáé ôçí ðåñéãñáöÞ ôçò óôáèåñÜò
// êáé áíïßãïõìå ôç öüñìá äçìïõñãßáò åðéäüìáôïò
	gsc_misth_zpepidom_reset()
	
	gsc_misth_zpepidom.kodepidom = dw_main.object.kodstath[ll_row]
	gsc_misth_zpepidom.kodxrisi = gs_kodxrisi
	gsc_misth_zpepidom.descepidom = dw_main.object.descstath[ll_row]

	OpenWithParm(w_misth_zpepidom_form, 0)
end event

event me_create_krat();// Äçìéïõñãßá êñÜôçóçò ìå ôá óôïé÷åßá ôçò óôáèåñÜò

// Ðáßñíïõìå ôçí åðéëåãìÝíç åããñáöÞ
	long		ll_row
	
	ll_row = dw_main.getrow()
	
	if ll_row = 0 then return
	
// Ðáßñíïõìå ôïí êùäéêü êáé ôçí ðåñéãñáöÞ ôçò óôáèåñÜò
// êáé áíïßãïõìå ôç öüñìá äçìïõñãßáò êñÜôçóçò

	gsc_misth_zpkrat_reset()
	
	gsc_misth_zpkrat.kodkrat = dw_main.object.kodstath[ll_row]
	gsc_misth_zpkrat.kodxrisi = gs_kodxrisi
	gsc_misth_zpkrat.desckrat = dw_main.object.descstath[ll_row]

	OpenWithParm(w_misth_zpkrat_form, 0)
	
end event

public function boolean of_check4required (ref datawindow adw, long row);string	lstring	
long		ll_found


// kodstath
	lstring = adw.object.kodstath[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(191))
		adw.setfocus()
		adw.setcolumn("kodstath")
		return false
	end if
	
	// ¸ëåã÷ïò áí ï êùäéêüò õðÜñ÷åé
		ll_found = adw.find("kodstath = '" + lstring + "'", 1, adw.rowcount())
		if ll_found = row then ll_found = adw.find("kodstath = '" + lstring + "'", ll_found + 1, adw.rowcount())
		if ll_found > 0 and ll_found <> row then
			MessageBox(gs_app_name, trn(133))
			adw.setfocus()
			adw.Setcolumn("kodstath")
			return false
		end if	
		
// descstath
	lstring = adw.object.descstath[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(180))
		adw.setfocus()
		adw.setcolumn("descstath")
		return false
	end if
	
	// ¸ëåã÷ïò áí ç ðåñéãñáöÞ õðÜñ÷åé
		ll_found = adw.find("descstath = '" + lstring + "'", 1, adw.rowcount())
		if ll_found = row then ll_found = adw.find("descstath = '" + lstring + "'", ll_found + 1, adw.rowcount())
		if ll_found > 0 and ll_found <> row then
			MessageBox(gs_app_name, "ÁõôÞ ç ðåñéãñáöÞ õðÜñ÷åé Þäç")
			adw.setfocus()
			adw.Setcolumn("descstath")
			return false
		end if			


// everything ok
	return true
end function

public subroutine of_postinitrow (ref datawindow adw, long row);adw.object.kodxrisi[row] = gs_kodxrisi
end subroutine

public subroutine of_setmasks ();fn_seteditmask(dw_main, "poso", fn_param_maskposo_e())
end subroutine

public function long if_retrieve ();long	ll_nrows

ll_nrows = dw_main.retrieve(gs_kodxrisi)

return ll_nrows
end function

on w_misth_zpstath_grid.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_misth_zpstath_grid" then this.MenuID = create m_misth_zpstath_grid
end on

on w_misth_zpstath_grid.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;// translation
	title = trn(590)
	
end event

type dw_main from w_pbgrid`dw_main within w_misth_zpstath_grid
integer width = 2487
string dataobject = "dw_misth_zpstath_list"
end type

