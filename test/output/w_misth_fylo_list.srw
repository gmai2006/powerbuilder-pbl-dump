HA$PBExportHeader$w_misth_fylo_list.srw
$PBExportComments$
forward
global type w_misth_fylo_list from w_list
end type
end forward

global type w_misth_fylo_list from w_list
integer width = 2039
integer height = 1660
string title = "title"
string menuname = "m_misth_fylo_list"
string icon = "res\fylo.ico"
string is_tablename = "misth_fylo"
string is_order = " order by kodfylo asc "
string is_formwin = "w_misth_fylo_form"
boolean ib_editwithkey = true
boolean ib_retrieve = true
boolean ib_sort = true
boolean ib_noview = true
event me_copy ( )
end type
global w_misth_fylo_list w_misth_fylo_list

forward prototypes
public subroutine of_deleterow (ref datawindow adw, long row)
protected subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_init_struct ()
protected subroutine of_reset_struct ()
protected subroutine of_retrieve (ref datawindow adw)
end prototypes

event me_copy();// Äçìéïõñãßá áíôéãñÜöïõ áðü ôï åðéëåãìÝíï öýëï

// Êáèáñéóìüò ôçò áíÜëïãçò structure
	of_reset_struct()
	
// Ðáßñíïõìå ôçí ôñÝ÷ïõóá ãñáììÞ ôïõ dw
	long	ll_row
	ll_row = dw.getrow()
	if ll_row = 0 then return

// Default ôéìÝò ãéá íÝá åããñáöÞ
	of_init_struct()

// ¢íïéãìá ôçò öüñìáò åéóáãùãÞò êùäéêïý êáé ðåñéãñáöÞò
	OpenWithParm(w_misth_fylo_form_copy, 0)
	if Message.DoubleParm <> 1 then return

// insert data into:
// misth_fylo_epidom
	string		ls_sql
	long			ll_dsrows, i
	datastore 	ds
	string		ls_kodepidom, ls_expr
	integer		li_aa
	
	ls_sql = "select * from misth_fylo_epidom where kodfylo = '" + &
				dw.object.kodfylo[ll_row] + "' and kodxrisi = '" + gs_kodxrisi + "'"
	ds = fn_createds_fromsql(ls_sql)
	
	ll_dsrows = ds.retrieve()
	
	for i = 1 to ll_dsrows
		
		ls_kodepidom = ds.object.kodepidom[i]
		ls_expr = ds.object.expr[i]
		li_aa = ds.object.aa[i]
		
		insert into misth_fylo_epidom (
			kodfylo,
			kodepidom,
			kodxrisi,
			expr,
			aa)
		values (
			:gsc_misth_fylo.kodfylo,
			:ls_kodepidom,
			:gs_kodxrisi,
			:ls_expr,
			:li_aa);
			
			fn_sqlerror()
			
	next
	commit;
		
// misth_fylo_krat
	string		ls_kodkrat
	
	ls_sql = "select * from misth_fylo_krat where kodfylo = '" + &
				dw.object.kodfylo[ll_row] + "' and kodxrisi = '" + gs_kodxrisi + "'"
	ds = fn_createds_fromsql(ls_sql)
	
	ll_dsrows = ds.retrieve()
	
	for i = 1 to ll_dsrows
		
		ls_kodkrat = ds.object.kodkrat[i]
		ls_expr = ds.object.expr[i]
		li_aa = ds.object.aa[i]
		
		insert into misth_fylo_krat (
			kodfylo,
			kodkrat,
			kodxrisi,
			expr,
			aa)
		values (
			:gsc_misth_fylo.kodfylo,
			:ls_kodkrat,
			:gs_kodxrisi,
			:ls_expr,
			:li_aa);
			
			fn_sqlerror()
			
	next
	
	commit;


// misth_fylo_ypal

	long		ll_kodypal
	
	ls_sql = "select * from misth_fylo_ypal where kodfylo = '" + &
				dw.object.kodfylo[ll_row] + "' and kodxrisi = '" + gs_kodxrisi + "'"
	ds = fn_createds_fromsql(ls_sql)
	
	ll_dsrows = ds.retrieve()
	
	for i = 1 to ll_dsrows
		
		ll_kodypal = ds.object.kodypal[i]
	
		insert into misth_fylo_ypal (
			kodfylo,
			kodypal,
			kodxrisi)
		values (
			:gsc_misth_fylo.kodfylo,
			:ll_kodypal,
			:gs_kodxrisi);
			
			fn_sqlerror()
			
	next
	
	commit;	
	
	

dw.SetRedraw(false)

// Áí ðáôÞóáìå ïê åéóÜãïõìå ìßá íÝá ãñáììÞ êáé ìåôáöÝñïõìå ôá óôïé÷åßá
	ll_row = dw.InsertRow(0)
	of_struct2dw(dw, ll_row)	

// ÅðéëÝãïõìå ôçí íÝá ãñáììÞ
	//dw.SetRow(1)
	dw.SelectRow(0, false)
	dw.ScrollToRow(ll_row)
	dw.SelectRow(ll_row, true)
	dw.SetFocus()
	
dw.SetRedraw(true)
	

// delete datastore
	destroy ds

// update áíÜëïãá ìå ôçí ib_update
	if ib_update then
		dw.update()
		COMMIT;
	end if
	
// check menu
	This.TriggerEvent("ie_checkmenu")

// Êáëïýìå ôçí of_afterinsert()
	of_afterinsert(dw, ll_row)
	


end event

public subroutine of_deleterow (ref datawindow adw, long row);string	ls_kodfylo

ls_kodfylo = adw.object.kodfylo[row]

delete from misth_fylo
where kodfylo = :ls_kodfylo and kodxrisi = :gs_kodxrisi;
fn_sqlerror()
commit;
end subroutine

protected subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_fylo.kodfylo = adw.object.kodfylo[row]
gsc_misth_fylo.kodxrisi = adw.object.kodxrisi[row]
gsc_misth_fylo.descfylo = adw.object.descfylo[row]
end subroutine

protected subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodfylo[row] = gsc_misth_fylo.kodfylo
adw.object.kodxrisi[row] = gsc_misth_fylo.kodxrisi
adw.object.descfylo[row] = gsc_misth_fylo.descfylo
end subroutine

protected subroutine of_init_struct ();gsc_misth_fylo.kodxrisi = gs_kodxrisi

// Êùäéêüò öýëïõ ï åðüìåíïò (ìïñöÞ: ××××)
	string	ls_kodfylo
	
	select max(kodfylo) into :ls_kodfylo
	from   misth_fylo
	where  kodxrisi = :gs_kodxrisi;
	
	if not fn_sqlerror() then return
	
gsc_misth_fylo.kodfylo = fn_getnextstraa(ls_kodfylo, 4)


end subroutine

protected subroutine of_reset_struct ();gsc_misth_fylo_reset()
end subroutine

protected subroutine of_retrieve (ref datawindow adw);adw.retrieve(gs_kodxrisi)
end subroutine

on w_misth_fylo_list.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_misth_fylo_list" then this.MenuID = create m_misth_fylo_list
end on

on w_misth_fylo_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;// translation
	title = trn(678)
end event

type dw from w_list`dw within w_misth_fylo_list
integer width = 1998
string dataobject = "dw_misth_fylo_list"
end type

