HA$PBExportHeader$w_misth_fylo_form.srw
$PBExportComments$
forward
global type w_misth_fylo_form from w_form_tab2
end type
type uo_epidom from uo_misth_fylo_epidom_grid within page1
end type
type uo_krat from uo_misth_fylo_krat_grid within page2
end type
type page3 from userobject within tab1
end type
type uo_ypal from uo_misth_fylo_ypal_sel within page3
end type
type page3 from userobject within tab1
uo_ypal uo_ypal
end type
end forward

global type w_misth_fylo_form from w_form_tab2
integer width = 3090
integer height = 1644
string title = "title"
string icon = "res\fylo.ico"
boolean ib_update = true
string is_tablename = "misth_fylo"
end type
global w_misth_fylo_form w_misth_fylo_form

type variables
string		is_kodfylo

datawindow		idw_epidom
datawindow		idw_krat
end variables

forward prototypes
public subroutine of_struct2dw (ref datawindow adw, long row)
public subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_accepttext ()
public function boolean of_check4required (ref datawindow adw, long row)
protected subroutine of_retrieve ()
protected subroutine of_storekey ()
protected subroutine of_update ()
public subroutine of_disabledws ()
protected subroutine of_settransactions ()
protected subroutine of_open ()
public subroutine if_kodfylo_changed (string as_newkodfylo)
end prototypes

public subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodfylo[row] = gsc_misth_fylo.kodfylo
adw.object.kodxrisi[row] = gsc_misth_fylo.kodxrisi
adw.object.descfylo[row] = gsc_misth_fylo.descfylo
end subroutine

public subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_fylo.kodfylo = adw.object.kodfylo[row]
gsc_misth_fylo.kodxrisi = adw.object.kodxrisi[row]
gsc_misth_fylo.descfylo = adw.object.descfylo[row]
end subroutine

protected subroutine of_accepttext ();idw_main.AcceptText()
idw_epidom.AcceptText()
idw_krat.AcceptText()
end subroutine

public function boolean of_check4required (ref datawindow adw, long row);string		lstring	
long		llong	
long		ll_count

// kodfylo
	lstring = adw.object.kodfylo[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(188))
		adw.setfocus()
		adw.setcolumn("kodfylo")
		return false
	end if
	
	// ¸ëåã÷ïò áí ï êùäéêüò Ý÷åé êáôá÷ùñçèåß
		if lstring <> is_kodfylo or isnull(is_kodfylo) or is_kodfylo = "" then
			select count(kodfylo) into :ll_count from misth_fylo
			where kodfylo = :lstring and kodxrisi = :gs_kodxrisi;
			fn_sqlerror()
			if ll_count > 0 then
				Messagebox(gs_app_name, tr("Ï Êùäéêüò") + " '" + lstring + "' " + trn(658))
				adw.setfocus()
				adw.setcolumn("kodfylo")
				return false
			end if
		end if
	
// descfylo
	lstring = adw.object.descfylo[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(175))
		adw.setfocus()
		adw.setcolumn("descfylo")
		return false
	end if
	
	
// everything ok
	return true
end function

protected subroutine of_retrieve ();idw_main.retrieve(is_kodfylo, gs_kodxrisi)
idw_epidom.retrieve(is_kodfylo, gs_kodxrisi)
idw_krat.retrieve(is_kodfylo, gs_kodxrisi)

end subroutine

protected subroutine of_storekey ();is_kodfylo = gsc_misth_fylo.kodfylo
end subroutine

protected subroutine of_update ();idw_main.update()
idw_epidom.update()
idw_krat.update()
tab1.page3.uo_ypal.triggerevent("ie_update")

COMMIT USING SQLCA;
end subroutine

public subroutine of_disabledws ();idw_main.enabled = false
idw_epidom.enabled = false
idw_krat.enabled = false
end subroutine

protected subroutine of_settransactions ();idw_main.SetTransObject(SQLCA)
idw_epidom.SetTransObject(SQLCA)
idw_krat.SetTransObject(SQLCA)

end subroutine

protected subroutine of_open ();idw_main = dw_main
idw_epidom = tab1.page1.uo_epidom.dw
idw_krat = tab1.page2.uo_krat.dw

tab1.page1.uo_epidom.iw_parent = this
tab1.page2.uo_krat.iw_parent = this
tab1.page3.uo_ypal.iw_parent = this

fn_retrievechild(idw_epidom, "kodepidom", gs_kodxrisi)
fn_retrievechild(idw_krat, "kodkrat", gs_kodxrisi)


end subroutine

public subroutine if_kodfylo_changed (string as_newkodfylo);integer	li_rows, i

// idw_epidom
	li_rows = idw_epidom.rowcount()
	for i = 1 to li_rows
		idw_epidom.setitem(i, "kodfylo", as_newkodfylo)
	next
	
// idw_krat
	li_rows = idw_krat.rowcount()
	for i = 1 to li_rows
		idw_krat.setitem(i, "kodfylo", as_newkodfylo)
	next




end subroutine

on w_misth_fylo_form.create
int iCurrent
call super::create
end on

on w_misth_fylo_form.destroy
call super::destroy
end on

event open;call super::open;tab1.page3.uo_ypal.triggerevent("ie_retrieve")

// translation
	title = trn(599)
	tab1.page1.text = trn(95) + " - " + trn(306)
	tab1.page2.text = trn(411)
	tab1.page3.text = trn(657)
	
end event

type dw_main from w_form_tab2`dw_main within w_misth_fylo_form
integer height = 188
string dataobject = "dw_misth_fylo_form"
end type

event dw_main::itemchanged;call super::itemchanged;this.accepttext()

choose case dwo.name
		
	case "kodfylo"	// ÅíçìÝñùóç ôùí óõíäåäåìÝíùí
		//if_kodfylo_changed(data)
		
end choose
		
		
end event

type tab1 from w_form_tab2`tab1 within w_misth_fylo_form
integer x = 41
integer y = 400
integer width = 2629
integer height = 1096
integer textsize = -8
page3 page3
end type

on tab1.create
this.page3=create page3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.page3
end on

on tab1.destroy
call super::destroy
destroy(this.page3)
end on

type page1 from w_form_tab2`page1 within tab1
integer y = 104
integer width = 2592
integer height = 976
string text = " - "
uo_epidom uo_epidom
end type

on page1.create
this.uo_epidom=create uo_epidom
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_epidom
end on

on page1.destroy
call super::destroy
destroy(this.uo_epidom)
end on

type page2 from w_form_tab2`page2 within tab1
integer y = 104
integer width = 2592
integer height = 976
string text = ""
uo_krat uo_krat
end type

on page2.create
this.uo_krat=create uo_krat
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_krat
end on

on page2.destroy
call super::destroy
destroy(this.uo_krat)
end on

type cb_cancel from w_form_tab2`cb_cancel within w_misth_fylo_form
integer x = 2729
integer y = 1388
end type

type cb_ok from w_form_tab2`cb_ok within w_misth_fylo_form
integer x = 2729
integer y = 1256
end type

type uo_epidom from uo_misth_fylo_epidom_grid within page1
integer x = 18
integer y = 20
integer taborder = 20
end type

on uo_epidom.destroy
call uo_misth_fylo_epidom_grid::destroy
end on

type uo_krat from uo_misth_fylo_krat_grid within page2
integer x = 18
integer y = 20
integer taborder = 20
end type

on uo_krat.destroy
call uo_misth_fylo_krat_grid::destroy
end on

type page3 from userobject within tab1
integer x = 18
integer y = 104
integer width = 2592
integer height = 976
long backcolor = 67108864
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
uo_ypal uo_ypal
end type

on page3.create
this.uo_ypal=create uo_ypal
this.Control[]={this.uo_ypal}
end on

on page3.destroy
destroy(this.uo_ypal)
end on

type uo_ypal from uo_misth_fylo_ypal_sel within page3
integer x = 18
integer y = 20
integer taborder = 30
end type

on uo_ypal.destroy
call uo_misth_fylo_ypal_sel::destroy
end on

