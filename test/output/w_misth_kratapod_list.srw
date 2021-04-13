HA$PBExportHeader$w_misth_kratapod_list.srw
$PBExportComments$
forward
global type w_misth_kratapod_list from w_list
end type
end forward

global type w_misth_kratapod_list from w_list
integer width = 2560
string title = "title"
string menuname = "m_misth_kratapod_list"
string icon = "res\kratapod.ico"
string is_tablename = "misth_kratapod"
string is_order = " order by apoddate asc "
boolean ib_editwithkey = true
boolean ib_retrieve = true
boolean ib_sort = true
boolean ib_noview = true
boolean ib_nofilter = true
end type
global w_misth_kratapod_list w_misth_kratapod_list

forward prototypes
protected subroutine of_retrieve (ref datawindow adw)
public subroutine of_deleterow (ref datawindow adw, long row)
protected subroutine of_struct2dw (ref datawindow adw, long row)
end prototypes

protected subroutine of_retrieve (ref datawindow adw);adw.retrieve(gs_kodxrisi)
end subroutine

public subroutine of_deleterow (ref datawindow adw, long row);long		ll_kodkratapod

ll_kodkratapod = adw.object.kodkratapod[row]

delete from misth_kratapod
where kodkratapod = :ll_kodkratapod
and   kodxrisi = :gs_kodxrisi;
fn_sqlerror()
commit;
end subroutine

protected subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodkratapod[row] = gsc_misth_kratapod.kodkratapod
adw.object.kodxrisi[row] = gsc_misth_kratapod.kodxrisi
adw.object.desckratapod[row] = gsc_misth_kratapod.desckratapod
adw.object.apoddate[row] = gsc_misth_kratapod.apoddate
end subroutine

on w_misth_kratapod_list.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_misth_kratapod_list" then this.MenuID = create m_misth_kratapod_list
end on

on w_misth_kratapod_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event me_edit;// Åêôýðùóç åðéëåãìÝíçò áðüäïóçò

// Ðáßñíïõìå ôçí åðéëåãìÝíç êñÜôçóç
	long		ll_row, ll_kodkratapod
	
	ll_row = dw.getrow()
	if ll_row = 0 then return
	
	ll_kodkratapod = dw.object.kodkratapod[ll_row]
	
// ¢íïéãìá ðáñáèýñïõ åêôýðùóçò withparm
	OpenSheetWithParm(wprn_kratapod, ll_kodkratapod, w_app, 0, Original!)

end event

event me_add;// ÐñïóèÞêç ìéáò íÝáò åããñáöÞò

// ¸ëåã÷ïò äéêáéùìÜôùí
	if not fn_perm(is_tablename, "addrec") then return

// Êáèáñéóìüò ôçò áíÜëïãçò structure
	of_reset_struct()

// ¢íïéãìá wizard
	Open(wiz_kratapod)
	if message.DoubleParm <> 1 then return

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

event open;call super::open;// Translation
	title = trn(94)
	
end event

type dw from w_list`dw within w_misth_kratapod_list
integer width = 2523
string dataobject = "dw_misth_kratapod_list"
end type

