HA$PBExportHeader$w_misth_ypal_list.srw
$PBExportComments$
forward
global type w_misth_ypal_list from w_list
end type
end forward

global type w_misth_ypal_list from w_list
integer width = 3159
integer height = 2032
string menuname = "m_misth_ypal_list"
string icon = "res\ypal.ico"
string is_tablename = "misth_ypal"
string is_order = " order by surname, name, fathername "
string is_formwin = "w_misth_ypal_form"
string is_searchwin = "w_misth_ypal_search"
boolean ib_editwithkey = true
boolean ib_retrieve = true
boolean ib_sort = true
boolean ib_nofilter = true
end type
global w_misth_ypal_list w_misth_ypal_list

forward prototypes
public subroutine of_deleterow (ref datawindow adw, long row)
protected subroutine of_retrieve (ref datawindow adw)
protected subroutine of_init_struct ()
protected subroutine of_reset_struct ()
public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor)
protected subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_struct2dw (ref datawindow adw, long row)
end prototypes

public subroutine of_deleterow (ref datawindow adw, long row);long	ll_kodypal

ll_kodypal = adw.object.kodypal[row]

delete from misth_ypal
where  kodypal = :ll_kodypal and kodxrisi = :gs_kodxrisi;
fn_sqlerror()
commit;

end subroutine

protected subroutine of_retrieve (ref datawindow adw);dw.retrieve(gs_kodxrisi)
end subroutine

protected subroutine of_init_struct ();gsc_misth_ypal.kodypal = fn_getkey("misth_ypal")
gsc_misth_ypal.kodxrisi = gs_kodxrisi
gsc_misth_ypal.childs = 0
gsc_misth_ypal.prostmeli = 0
gsc_misth_ypal.klimakio = 0
end subroutine

protected subroutine of_reset_struct ();gsc_misth_ypal_reset()
end subroutine

public subroutine of_setrowcolors (ref long al_rowcolor, ref long al_rowrcolor);al_rowrcolor = rgb(210,255,210)
end subroutine

protected subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_ypal.kodypal = adw.object.kodypal[row]
gsc_misth_ypal.kodxrisi = adw.object.kodxrisi[row]
end subroutine

protected subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodypal[row] = gsc_misth_ypal.kodypal
adw.object.kodxrisi[row] = gsc_misth_ypal.kodxrisi
adw.object.surname[row] = gsc_misth_ypal.surname
adw.object.name[row] = gsc_misth_ypal.name
adw.object.mitroo[row] = gsc_misth_ypal.mitroo
adw.object.klimakio[row] = gsc_misth_ypal.klimakio
adw.object.bathmos[row] = gsc_misth_ypal.bathmos
adw.object.klados[row] = gsc_misth_ypal.klados

// misth_zpidikot_descidikot
	string	ls_descidikot
	select descidikot into :ls_descidikot from misth_zpidikot
	where kodidikot = :gsc_misth_ypal.kodidikot and kodxrisi = :gsc_misth_ypal.kodxrisi;
	fn_sqlerror()
	
	adw.object.misth_zpidikot_descidikot[row] = ls_descidikot
end subroutine

on w_misth_ypal_list.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_misth_ypal_list" then this.MenuID = create m_misth_ypal_list
end on

on w_misth_ypal_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;title = trn(337)

end event

type dw from w_list`dw within w_misth_ypal_list
integer width = 3122
string dataobject = "dw_misth_ypal_list"
end type

