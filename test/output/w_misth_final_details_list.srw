HA$PBExportHeader$w_misth_final_details_list.srw
$PBExportComments$
forward
global type w_misth_final_details_list from w_list
end type
end forward

global type w_misth_final_details_list from w_list
integer width = 3269
string menuname = "m_misth_final_details_list"
string icon = "res\final.ico"
string is_tablename = "misth_final"
string is_order = " order by misth_final.datefinal, misth_final.descfinal, misth_ypal.surname, misth_ypal.name, misth_ypal.fathername "
string is_formwin = "w_misth_final_details_form_edit"
string is_searchwin = "w_misth_final_details_search"
boolean ib_editwithkey = true
boolean ib_retrieve = true
boolean ib_sort = true
boolean ib_nofilter = true
event me_edit_print ( )
end type
global w_misth_final_details_list w_misth_final_details_list

type variables

end variables

forward prototypes
public subroutine of_deleterow (ref datawindow adw, long row)
protected subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_reset_struct ()
protected subroutine of_retrieve (ref datawindow adw)
public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor)
end prototypes

event me_edit_print();// Åêôýðùóç åðéëåãìÝíçò áôïìéêÞò ìéóèïäïóßáò

// Ðáßñíïõìå ôçí åðéëåãìÝíç åããñáöÞ
	
	long		ll_row
	
	ll_row = dw.getrow()
	
	if ll_row = 0 then return
	
// ÌåôáöïñÜ óôçí gsc_misth_final_ypal
	of_reset_struct()
	of_dw2struct(dw, ll_row)
	
// ¸ëåã÷ïò äéêáéùìÜôùí êáé åêôýðùóç
	if not fn_perm("misth_final_ypal", "openlist") then return
	OpenSheet(wprn_final_atomiki_misth_arg, w_app, 0, Original!)		
	
end event

public subroutine of_deleterow (ref datawindow adw, long row);long		ll_kodfinal, &
			ll_kodypal
			
ll_kodfinal = adw.object.misth_final_ypal_kodfinal[row]
ll_kodypal = adw.object.misth_final_ypal_kodypal[row]

delete 	from misth_final_ypal
where		kodfinal = :ll_kodfinal
and		kodypal = :ll_kodypal
and		kodxrisi = :gs_kodxrisi;
fn_sqlerror()

commit;

// Áí äåí õðÜñ÷åé Üëëïò êáôá÷ùñçìÝíïò õðÜëëçëïò
// óôçí åðéëåãìÝíç ìéóèïäïóßá, äéáãñáöÞ êáé áõôÞò
	long	ll_count
	
	select 	count(kodypal) into :ll_count
	from		misth_final_ypal
	where		kodfinal = :ll_kodfinal
	and		kodxrisi = :gs_kodxrisi;
	fn_sqlerror()
	
	if isnull(ll_count) then ll_count = 0
	
	if ll_count = 0 then
		delete 	from	misth_final
		where	 	kodfinal = :ll_kodfinal
		and 		kodxrisi = :gs_kodxrisi;
		fn_sqlerror()
	end if
	
	commit;

end subroutine

protected subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_final_ypal.kodfinal = adw.object.misth_final_ypal_kodfinal[row]
gsc_misth_final_ypal.kodypal = adw.object.misth_final_ypal_kodypal[row]
gsc_misth_final_ypal.kodxrisi = adw.object.misth_final_ypal_kodxrisi[row]
gsc_misth_final_ypal.plirdate = adw.object.misth_final_ypal_plirdate[row]
end subroutine

protected subroutine of_struct2dw (ref datawindow adw, long row);adw.object.misth_final_ypal_kodfinal[row] = gsc_misth_final_ypal.kodfinal
adw.object.misth_final_ypal_kodypal[row] = gsc_misth_final_ypal.kodypal
adw.object.misth_final_ypal_kodxrisi[row] = gsc_misth_final_ypal.kodxrisi
adw.object.misth_final_ypal_plirdate[row] = gsc_misth_final_ypal.plirdate

// misth_final.datefinal
// misth_final.descfinal
// misth_final.aa
	date		ldt_datefinal
	string	ls_descfinal
	long		ll_aa
	
	select 	datefinal, descfinal, aa
	into		:ldt_datefinal, :ls_descfinal, :ll_aa
	from		misth_final
	where		kodfinal = :gsc_misth_final_ypal.kodfinal
	and		kodxrisi = :gsc_misth_final_ypal.kodxrisi;
	fn_sqlerror()
	
	adw.object.misth_final_datefinal[row] = ldt_datefinal
	adw.object.misth_final_descfinal[row] = ls_descfinal
	adw.object.misth_final_aa[row] = ll_aa
	
// misth_ypal_surname
// misth_ypal_name
// misth_ypal_fathername
	string	ls_surname, ls_name, ls_fathername
	
	select 	surname, name, fathername
	into		:ls_surname, :ls_name, :ls_fathername
	from		misth_ypal
	where		kodypal = :gsc_misth_final_ypal.kodypal
	and		kodxrisi = :gsc_misth_final_ypal.kodxrisi;
	fn_sqlerror()
	
	adw.object.misth_ypal_surname[row] = ls_surname
	adw.object.misth_ypal_name[row] = ls_name
	adw.object.misth_ypal_fathername[row] = ls_fathername
	
// misth_zpkat.desckat
	string	ls_desckat
	
	select	misth_zpkat.desckat into :ls_desckat
	from		misth_final, misth_zpkat
	where		misth_final.kodkat = misth_zpkat.kodkat
	and		misth_final.kodxrisi = misth_zpkat.kodxrisi
	and		misth_final.kodfinal = :gsc_misth_final_ypal.kodfinal
	and		misth_final.kodxrisi = :gsc_misth_final_ypal.kodxrisi;
	fn_sqlerror()
	
	adw.object.misth_zpkat_desckat[row] = ls_desckat
	
// misth_zpperiod.descperiod
	string	ls_descperiod
	
	select	misth_zpperiod.descperiod into :ls_descperiod
	from		misth_final, misth_zpperiod
	where		misth_final.kodperiod = misth_zpperiod.kodperiod
	and		misth_final.kodxrisi = misth_zpperiod.kodxrisi
	and		misth_final.kodfinal = :gsc_misth_final_ypal.kodfinal
	and		misth_final.kodxrisi = :gsc_misth_final_ypal.kodxrisi;
	fn_sqlerror()
	
	adw.object.misth_zpperiod_descperiod[row] = ls_descperiod		
	
	
end subroutine

protected subroutine of_reset_struct ();gsc_misth_final_ypal_reset()
end subroutine

protected subroutine of_retrieve (ref datawindow adw);adw.retrieve(gs_kodxrisi)
end subroutine

public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor);al_rowrcolor = rgb(128,255,255)
end subroutine

on w_misth_final_details_list.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_misth_final_details_list" then this.MenuID = create m_misth_final_details_list
end on

on w_misth_final_details_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event me_add;// ÐñïóèÞêç ìéáò íÝáò åããñáöÞò
// ---- wiz_misth_final_details ---

// ¸ëåã÷ïò äéêáéùìÜôùí
	if not fn_perm(is_tablename, "addrec") then return
	
// Êáèáñéóìüò ôçò áíÜëïãçò structure
	of_reset_struct()

// ¢íïéãìá ôïõ wizard
	Open(wiz_misth_final_details)
	if Message.DoubleParm <> 1 then return
	
dw.SetRedraw(false)

// Áí ðáôÞóáìå ïê åéóÜãïõìå ìßá íÝá ãñáììÞ êáé ìåôáöÝñïõìå ôá óôïé÷åßá
	long	ll_row
	ll_row = dw.InsertRow(0)
	of_struct2dw(dw, ll_row)	

// ÅðéëÝãïõìå ôçí íÝá ãñáììÞ
	//dw.SetRow(1)
	dw.SelectRow(0, false)
	dw.ScrollToRow(ll_row)
	dw.SelectRow(ll_row, true)
	dw.SetFocus()
	
dw.SetRedraw(true)
	
// check menu
	This.TriggerEvent("ie_checkmenu")

// Êáëïýìå ôçí of_afterinsert()
	of_afterinsert(dw, ll_row)
	


end event

event open;call super::open;// translation
	title = trn(391)
end event

type dw from w_list`dw within w_misth_final_details_list
integer width = 3081
string dataobject = "dw_misth_final_details_list"
end type

