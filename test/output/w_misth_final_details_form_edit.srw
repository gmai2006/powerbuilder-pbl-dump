HA$PBExportHeader$w_misth_final_details_form_edit.srw
$PBExportComments$
forward
global type w_misth_final_details_form_edit from w_form
end type
type tab1 from tab within w_misth_final_details_form_edit
end type
type page1 from userobject within tab1
end type
type uo_epidom from uo_misth_final_ypal_epidom_details_grid within page1
end type
type page1 from userobject within tab1
uo_epidom uo_epidom
end type
type page2 from userobject within tab1
end type
type uo_krat from uo_misth_final_ypal_krat_details_grid within page2
end type
type page2 from userobject within tab1
uo_krat uo_krat
end type
type tab1 from tab within w_misth_final_details_form_edit
page1 page1
page2 page2
end type
type gb_1 from groupbox within w_misth_final_details_form_edit
end type
end forward

global type w_misth_final_details_form_edit from w_form
integer width = 3109
integer height = 2196
string icon = "res\final.ico"
boolean ib_update = true
string is_tablename = "misth_final"
tab1 tab1
gb_1 gb_1
end type
global w_misth_final_details_form_edit w_misth_final_details_form_edit

type variables
long		il_kodfinal
long		il_kodypal

datawindow	idw_epidom
datawindow	idw_krat
end variables

forward prototypes
public subroutine of_dw2struct (ref datawindow adw, long row)
public subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_retrieve ()
protected subroutine of_storekey ()
public function boolean of_ok ()
protected subroutine of_open ()
protected subroutine of_update ()
end prototypes

public subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_final_ypal.kodfinal = adw.object.misth_final_ypal_kodfinal[row]
gsc_misth_final_ypal.kodypal = adw.object.misth_final_ypal_kodypal[row]
gsc_misth_final_ypal.kodxrisi = adw.object.misth_final_ypal_kodxrisi[row]
gsc_misth_final_ypal.plirdate = adw.object.misth_final_ypal_plirdate[row]
end subroutine

public subroutine of_struct2dw (ref datawindow adw, long row);adw.object.misth_final_ypal_kodfinal[row] = gsc_misth_final_ypal.kodfinal
adw.object.misth_final_ypal_kodypal[row] = gsc_misth_final_ypal.kodypal
adw.object.misth_final_ypal_kodxrisi[row] = gsc_misth_final_ypal.kodxrisi
adw.object.misth_final_ypal_plirdate[row] = gsc_misth_final_ypal.plirdate
end subroutine

protected subroutine of_retrieve ();dw_main.retrieve(string(il_kodfinal), string(il_kodypal), gs_kodxrisi)

idw_epidom.retrieve(string(il_kodfinal), gs_kodxrisi)
tab1.page1.uo_epidom.uf_filter()

idw_krat.retrieve(string(il_kodfinal), gs_kodxrisi)
tab1.page2.uo_krat.uf_filter()
end subroutine

protected subroutine of_storekey ();il_kodfinal = gsc_misth_final_ypal.kodfinal
il_kodypal = gsc_misth_final_ypal.kodypal
end subroutine

public function boolean of_ok ();// check for required for both epidom, krat
	long	ll_row
	
	ll_row = idw_epidom.getrow()
	if not tab1.page1.uo_epidom.of_check4required(idw_epidom, ll_row) then return false

	ll_row = idw_krat.getrow()
	if not tab1.page2.uo_krat.of_check4required(idw_krat, ll_row) then return false
	
// OK
	return true
	
end function

protected subroutine of_open ();// set parents
	tab1.page1.uo_epidom.iw_parent = this
	tab1.page2.uo_krat.iw_parent = this

// get datawindow's to instance variables
	idw_epidom = tab1.page1.uo_epidom.dw
	idw_krat = tab1.page2.uo_krat.dw
	

end subroutine

protected subroutine of_update ();// update ôïõ dw
// (override if there is more dw's
	dw_main.update()
	idw_epidom.update()
	idw_krat.update()
	
	COMMIT USING SQLCA;
end subroutine

on w_misth_final_details_form_edit.create
int iCurrent
call super::create
this.tab1=create tab1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab1
this.Control[iCurrent+2]=this.gb_1
end on

on w_misth_final_details_form_edit.destroy
call super::destroy
destroy(this.tab1)
destroy(this.gb_1)
end on

event open;call super::open;fn_retrievechild(dw_main, "kodkat", gs_kodxrisi)
fn_retrievechild(idw_epidom, "kodepidom", gs_kodxrisi)
fn_retrievechild(idw_krat, "kodkrat", gs_kodxrisi)

// translation
	title = trn(598)
	tab1.page1.text = trn(96)
	tab1.page2.text = trn(411)
end event

type cb_cancel from w_form`cb_cancel within w_misth_final_details_form_edit
integer x = 2720
integer y = 1968
end type

type cb_ok from w_form`cb_ok within w_misth_final_details_form_edit
integer x = 2354
integer y = 1968
end type

type dw_main from w_form`dw_main within w_misth_final_details_form_edit
integer x = 50
integer y = 48
integer width = 2967
integer height = 480
string dataobject = "dw_misth_final_details_form_edit"
end type

type tab1 from tab within w_misth_final_details_form_edit
event create ( )
event destroy ( )
integer x = 32
integer y = 584
integer width = 3003
integer height = 1336
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
page1 page1
page2 page2
end type

on tab1.create
this.page1=create page1
this.page2=create page2
this.Control[]={this.page1,&
this.page2}
end on

on tab1.destroy
destroy(this.page1)
destroy(this.page2)
end on

type page1 from userobject within tab1
integer x = 18
integer y = 48
integer width = 2967
integer height = 1272
long backcolor = 67108864
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
uo_epidom uo_epidom
end type

on page1.create
this.uo_epidom=create uo_epidom
this.Control[]={this.uo_epidom}
end on

on page1.destroy
destroy(this.uo_epidom)
end on

type uo_epidom from uo_misth_final_ypal_epidom_details_grid within page1
event destroy ( )
integer x = 23
integer y = 36
integer taborder = 20
end type

on uo_epidom.destroy
call uo_misth_final_ypal_epidom_details_grid::destroy
end on

type page2 from userobject within tab1
integer x = 18
integer y = 48
integer width = 2967
integer height = 1272
long backcolor = 67108864
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
uo_krat uo_krat
end type

on page2.create
this.uo_krat=create uo_krat
this.Control[]={this.uo_krat}
end on

on page2.destroy
destroy(this.uo_krat)
end on

type uo_krat from uo_misth_final_ypal_krat_details_grid within page2
integer x = 23
integer y = 36
integer taborder = 20
end type

on uo_krat.destroy
call uo_misth_final_ypal_krat_details_grid::destroy
end on

type gb_1 from groupbox within w_misth_final_details_form_edit
integer x = 32
integer width = 3022
integer height = 552
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

