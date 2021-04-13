HA$PBExportHeader$uo_misth_report_cols_grid.sru
$PBExportComments$
forward
global type uo_misth_report_cols_grid from u_grid
end type
type pb_expr from picturebutton within uo_misth_report_cols_grid
end type
end forward

global type uo_misth_report_cols_grid from u_grid
integer width = 2267
integer height = 860
string is_tablename = "misth_ypal_epidom"
pb_expr pb_expr
end type
global uo_misth_report_cols_grid uo_misth_report_cols_grid

type variables
w_misth_report_form		iw_parent
end variables

forward prototypes
public subroutine of_postinitrow (ref datawindow adw, long row)
public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor)
public function boolean of_check4required (ref datawindow adw, long row)
end prototypes

public subroutine of_postinitrow (ref datawindow adw, long row);adw.object.kodcol[row] = fn_getkey("misth_report_cols")
adw.object.kodreport[row] = iw_parent.idw_main.object.kodreport[1]
adw.object.kodxrisi[row] = gs_kodxrisi
adw.object.width[row] = 250
adw.object.aa[row ] = fn_maxindw(adw, "aa") + 1
end subroutine

public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor);al_rowrcolor = rgb(204,255,204)
end subroutine

public function boolean of_check4required (ref datawindow adw, long row);
string		lstring	
long		ll_found	
date		ldate
time		ltime

// header_text
	lstring = adw.object.header_text[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(173))
		adw.setfocus()
		adw.setcolumn("header_text")
		return false
	end if
	
	// ¸ëåã÷ïò áí ç êåöáëßäá õðÜñ÷åé
		ll_found = adw.find("header_text = '" + lstring + "'", 1, adw.rowcount())
		if ll_found = row then ll_found = adw.find("header_text = '" + lstring + "'", ll_found + 1, adw.rowcount())
		if ll_found > 0 and ll_found <> row then
			MessageBox(gs_app_name, trn(127))
			adw.setfocus()
			adw.Setcolumn("header_text")
			return false
		end if		

// everything ok
	return true
end function

on uo_misth_report_cols_grid.create
int iCurrent
call super::create
this.pb_expr=create pb_expr
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_expr
end on

on uo_misth_report_cols_grid.destroy
call super::destroy
destroy(this.pb_expr)
end on

event ie_checkbuttons;long	ll_nrows, ll_row

// Óýíïëï åããñáöþí êáé ôñÝ÷ïõóá åããñáöÞ
	ll_nrows = dw.rowcount()
	ll_row = dw.getrow()
	
// ÅðáíáöÝñïõìå üëá óå åíåñãü êáôÜóôáóç êáé áðåíåñãïðïéïýìå áíÜëïãá
	pb_delete.enabled = true
	pb_selectrow.enabled = true
	pb_selectall.enabled = true
	pb_expr.enabled = true
		
	pb_first.enabled = true
	pb_previous.enabled = true
	pb_next.enabled = true
	pb_last.enabled = true
	pb_new.enabled = true
	

// Áí äåí õðÜñ÷ïõí åããñáöÝò ðáñÜ ìüíï ç íÝá
	if ll_nrows = 1 then
		pb_delete.enabled = false
		pb_selectrow.enabled = false
		pb_selectall.enabled = false
		pb_first.enabled = false
		pb_previous.enabled = false
		pb_next.enabled = false
		pb_last.enabled = false
		pb_new.enabled = false
		pb_expr.enabled = false
		return
	end if
		
// Åßìáóôå óôçí ôåëåõôáßá åããñáöÞ (íÝá) áëëÜ õðÜñ÷ïõí êáé Üëëåò
	if ll_row = ll_nrows and ll_nrows > 1 then
		pb_selectrow.enabled = false
		pb_new.enabled = false
		pb_next.enabled = false
		pb_delete.enabled = false
		return
	end if	
	
// Åßìáóôå óôçí ðñþôç åããñáöÞ êáé õðÜñ÷ïõí êáé Üëëåò
	if ll_row = 1 and ll_nrows > 1 then
		pb_first.enabled = false
		pb_previous.enabled = false
		
		// Áí åßíáé êáé ç ìïíáäéêÞ åããñáöÞ (ðñïôåëåõôáßá)
		if ll_row = ll_nrows - 1 then
			pb_last.enabled = false
		end if
		
		return
	end if
	
// Áí åßìáóôå óôçí ðñïôåëåõôáßá (ðñéí ôçí íÝá)
	if ll_row = ll_nrows - 1 then
		pb_last.enabled = false
		return
	end if
	
end event

event constructor;call super::constructor;pb_expr.powertiptext = trn(303)

end event

type pb_selectall from u_grid`pb_selectall within uo_misth_report_cols_grid
integer x = 2002
end type

type pb_selectrow from u_grid`pb_selectrow within uo_misth_report_cols_grid
integer x = 1888
end type

type pb_new from u_grid`pb_new within uo_misth_report_cols_grid
integer x = 1723
end type

type pb_last from u_grid`pb_last within uo_misth_report_cols_grid
integer x = 1600
end type

type pb_next from u_grid`pb_next within uo_misth_report_cols_grid
integer x = 1486
end type

type pb_previous from u_grid`pb_previous within uo_misth_report_cols_grid
integer x = 1371
end type

type pb_first from u_grid`pb_first within uo_misth_report_cols_grid
integer x = 1257
end type

type pb_delete from u_grid`pb_delete within uo_misth_report_cols_grid
integer x = 2167
end type

type dw from u_grid`dw within uo_misth_report_cols_grid
integer width = 2267
integer height = 740
string dataobject = "dw_misth_report_cols_list"
end type

event dw::itemchanged;call super::itemchanged;choose case dwo.name
		
	case "kodyvar"
		string		ls_expr
		
		select expr into :ls_expr
		from  misth_zpyvar
		where kodyvar = :data and kodxrisi = :gs_kodxrisi;
		fn_sqlerror()
		
		this.object.expr[row] = ls_expr

end choose
end event

type pb_expr from picturebutton within uo_misth_report_cols_grid
integer width = 101
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom082!"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;dw.AcceptText()

// Ðáßñíïõìå ôçí ôñÝ÷ïõóá åããñáöÞ
	long	ll_row
	ll_row = dw.getrow()
	if ll_row = 0 then return

// Ðáßñíïõìå ôïí ôñÝ÷ïí ôýðï
	string		ls_expr 
	ls_expr = dw.object.expr[ll_row]
	
// Öüñôùìá óôáèåñþí
	datastore		lds_stath
	lds_stath = fn_createds_zpstath()

// Öüñôùìá üëùí ôùí ìåôáâëçôþí õðáëëÞëùí
	datastore		lds_yvar
	lds_yvar = fn_createds_zpyvar_all()

// Öüñôùìá üëùí ôùí åðéäïìÜôùí 
	datastore		lds_epidom
	lds_epidom = fn_createds_zpepidom_all()
	
// Öüñôùìá ôùí êñáôÞóåùí
	datastore		lds_krat
	lds_krat = fn_createds_zpkrat_all()

// ÌåôáöïñÜ óå structure êáé Üíïéãìá w_expr
	s_expr	lsc_expr
	
	if lds_stath.rowcount() > 0 then
		lsc_expr.stath = lds_stath
	end if

	if lds_yvar.rowcount() > 0 then
		lsc_expr.yvar = lds_yvar
	end if
	
	if lds_epidom.rowcount() > 0 then
		lsc_expr.epidom = lds_epidom
	end if
	
	if lds_krat.rowcount() > 0 then
		lsc_expr.krat = lds_krat
	end if
	
	lsc_expr.expr = ls_expr

// ¢íïéãìá w_expr
	integer	li_ret
	openwithparm(w_expr, lsc_expr)
	li_ret = message.doubleparm
	if li_ret <> 1 then return
	dw.object.expr[ll_row] = gstring
	
// cleanup
	destroy lds_stath
	destroy lds_yvar	
	destroy lds_epidom
	destroy lds_krat
			
		
			
		

end event

