HA$PBExportHeader$w_misth_zpkrat_list.srw
$PBExportComments$
forward
global type w_misth_zpkrat_list from w_list
end type
end forward

global type w_misth_zpkrat_list from w_list
integer width = 3035
integer height = 1928
string title = "title"
string menuname = "m_misth_zpkrat_list"
string icon = "res\pinakes.ico"
string is_tablename = "misth_zpkrat"
string is_order = " order by kodkrat asc "
string is_formwin = "w_misth_zpkrat_form"
boolean ib_editwithkey = true
boolean ib_retrieve = true
boolean ib_sort = true
boolean ib_noview = true
boolean ib_nofilter = true
event me_create_yvar ( )
event me_create_epidom ( )
end type
global w_misth_zpkrat_list w_misth_zpkrat_list

forward prototypes
public subroutine of_deleterow (ref datawindow adw, long row)
protected subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_init_struct ()
protected subroutine of_reset_struct ()
protected subroutine of_retrieve (ref datawindow adw)
end prototypes

event me_create_yvar();// Äçìéïõñãßá ìåôáâëçôÞò õðáëëÞëïõ

// Ðáßñíïõìå ôçí åðéëåãìÝíç åããñáöÞ
	long		ll_row
	
	ll_row = dw.getrow()
	
	if ll_row = 0 then return
	
// Ðáßñíïõìå ôïí êùäéêü êáé ôçí ðåñéãñáöÞ ôïõ åðéäüìáôïò
// êáé áíïßãïõìå ôç öüñìá äçìïõñãßáò ìåôáâëçôÞò õðáëëÞëïõ

	gsc_misth_zpyvar_reset()
	
	gsc_misth_zpyvar.kodyvar = dw.object.kodkrat[ll_row]
	gsc_misth_zpyvar.kodxrisi = gs_kodxrisi
	gsc_misth_zpyvar.descyvar = dw.object.desckrat[ll_row]

	OpenWithParm(w_misth_zpyvar_form, 0)
	
end event

event me_create_epidom();// Äçìéïõñãßá áðïäï÷Þò - åðéäüìáôïò

// Ðáßñíïõìå ôçí åðéëåãìÝíç åããñáöÞ
	long		ll_row
	
	ll_row = dw.getrow()
	
	if ll_row = 0 then return
	
// Ðáßñíïõìå ôïí êùäéêü êáé ôçí ðåñéãñáöÞ ôçò êñÜôçóçò
// êáé áíïßãïõìå ôç öüñìá äçìïõñãßáò åðéäüìáôïò

	gsc_misth_zpepidom_reset()
	
	gsc_misth_zpepidom.kodepidom = dw.object.kodkrat[ll_row]
	gsc_misth_zpepidom.kodxrisi = gs_kodxrisi
	gsc_misth_zpepidom.descepidom = dw.object.desckrat[ll_row]

	OpenWithParm(w_misth_zpepidom_form, 0)
end event

public subroutine of_deleterow (ref datawindow adw, long row);string	ls_kodkrat

ls_kodkrat = adw.object.kodkrat[row]

delete from misth_zpkrat
where kodkrat = :ls_kodkrat and kodxrisi = :gs_kodxrisi;
fn_sqlerror()
commit;

end subroutine

protected subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_zpkrat.kodkrat = adw.object.kodkrat[row]
gsc_misth_zpkrat.kodxrisi = adw.object.kodxrisi[row]
gsc_misth_zpkrat.desckrat = adw.object.desckrat[row]
gsc_misth_zpkrat.isforos = adw.object.isforos[row]
gsc_misth_zpkrat.isasf = adw.object.isasf[row]
gsc_misth_zpkrat.isautoforos = adw.object.isautoforos[row]

end subroutine

protected subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodkrat[row] = gsc_misth_zpkrat.kodkrat
adw.object.kodxrisi[row] = gsc_misth_zpkrat.kodxrisi
adw.object.desckrat[row] = gsc_misth_zpkrat.desckrat
adw.object.isforos[row] = gsc_misth_zpkrat.isforos
adw.object.isasf[row] = gsc_misth_zpkrat.isasf
adw.object.isautoforos[row] = gsc_misth_zpkrat.isautoforos

end subroutine

protected subroutine of_init_struct ();gsc_misth_zpkrat.kodxrisi =  gs_kodxrisi
gsc_misth_zpkrat.isforos = 0
gsc_misth_zpkrat.isasf = 0
gsc_misth_zpkrat.isautoforos = 0

end subroutine

protected subroutine of_reset_struct ();gsc_misth_zpkrat_reset()
end subroutine

protected subroutine of_retrieve (ref datawindow adw);dw.retrieve(gs_kodxrisi)

end subroutine

on w_misth_zpkrat_list.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_misth_zpkrat_list" then this.MenuID = create m_misth_zpkrat_list
end on

on w_misth_zpkrat_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;// translation
	title = trn(411)
	
end event

type dw from w_list`dw within w_misth_zpkrat_list
integer width = 2999
string dataobject = "dw_misth_zpkrat_list"
end type

