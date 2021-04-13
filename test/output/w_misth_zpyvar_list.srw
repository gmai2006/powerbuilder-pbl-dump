HA$PBExportHeader$w_misth_zpyvar_list.srw
$PBExportComments$
forward
global type w_misth_zpyvar_list from w_list
end type
end forward

global type w_misth_zpyvar_list from w_list
integer width = 2715
integer height = 1856
string title = "title"
string menuname = "m_misth_zpyvar_list"
string icon = "res\pinakes.ico"
string is_tablename = "misth_zpyvar"
string is_order = " order by descyvar asc "
string is_formwin = "w_misth_zpyvar_form"
boolean ib_editwithkey = true
boolean ib_retrieve = true
boolean ib_sort = true
boolean ib_noview = true
event me_create_krat ( )
event me_create_epidom ( )
end type
global w_misth_zpyvar_list w_misth_zpyvar_list

forward prototypes
public subroutine of_deleterow (ref datawindow adw, long row)
protected subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_init_struct ()
protected subroutine of_reset_struct ()
protected subroutine of_retrieve (ref datawindow adw)
end prototypes

event me_create_krat();// Äçìéïõñãßá êñÜôçóçò


// Ðáßñíïõìå ôçí åðéëåãìÝíç åããñáöÞ
	long		ll_row
	
	ll_row = dw.getrow()
	
	if ll_row = 0 then return
	
// Ðáßñíïõìå ôïí êùäéêü êáé ôçí ðåñéãñáöÞ ôçò ìåôáâëçôÞò õðáëëÞëïõ
// êáé áíïßãïõìå ôç öüñìá äçìïõñãßáò êñÜôçóçò

	gsc_misth_zpkrat_reset()
	
	gsc_misth_zpkrat.kodkrat = dw.object.kodyvar[ll_row]
	gsc_misth_zpkrat.kodxrisi = gs_kodxrisi
	gsc_misth_zpkrat.desckrat = dw.object.descyvar[ll_row]

	OpenWithParm(w_misth_zpkrat_form, 0)
	
end event

event me_create_epidom();// Äçìéïõñãßá áðïäï÷Þò - åðéäüìáôïò

// Ðáßñíïõìå ôçí åðéëåãìÝíç åããñáöÞ
	long		ll_row
	
	ll_row = dw.getrow()
	
	if ll_row = 0 then return
	
// Ðáßñíïõìå ôïí êùäéêü êáé ôçí ðåñéãñáöÞ ôçò êñÜôçóçò
// êáé áíïßãïõìå ôç öüñìá äçìïõñãßáò åðéäüìáôïò

	gsc_misth_zpepidom_reset()
	
	gsc_misth_zpepidom.kodepidom = dw.object.kodyvar[ll_row]
	gsc_misth_zpepidom.kodxrisi = gs_kodxrisi
	gsc_misth_zpepidom.descepidom = dw.object.descyvar[ll_row]

	OpenWithParm(w_misth_zpepidom_form, 0)
end event

public subroutine of_deleterow (ref datawindow adw, long row);string	ls_kodyvar

ls_kodyvar = adw.object.kodyvar[row]

delete from misth_zpyvar
where kodyvar = :ls_kodyvar and kodxrisi = :gs_kodxrisi;
fn_sqlerror()
commit;
end subroutine

protected subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_zpyvar.kodyvar = adw.object.kodyvar[row]
gsc_misth_zpyvar.kodxrisi = adw.object.kodxrisi[row]
gsc_misth_zpyvar.descyvar = adw.object.descyvar[row]
gsc_misth_zpyvar.expr = adw.object.expr[row]

end subroutine

protected subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodyvar[row] = gsc_misth_zpyvar.kodyvar
adw.object.kodxrisi[row] = gsc_misth_zpyvar.kodxrisi
adw.object.descyvar[row] = gsc_misth_zpyvar.descyvar
adw.object.expr[row] = gsc_misth_zpyvar.expr
end subroutine

protected subroutine of_init_struct ();gsc_misth_zpyvar.kodxrisi =  gs_kodxrisi


end subroutine

protected subroutine of_reset_struct ();gsc_misth_zpyvar_reset()
end subroutine

protected subroutine of_retrieve (ref datawindow adw);dw.retrieve(gs_kodxrisi)
end subroutine

on w_misth_zpyvar_list.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_misth_zpyvar_list" then this.MenuID = create m_misth_zpyvar_list
end on

on w_misth_zpyvar_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;// translation
	title = trn(433)
	
end event

type dw from w_list`dw within w_misth_zpyvar_list
integer width = 2679
integer height = 1496
string dataobject = "dw_misth_zpyvar_list"
end type

