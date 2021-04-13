HA$PBExportHeader$w_misth_final_form_edit.srw
$PBExportComments$
forward
global type w_misth_final_form_edit from w_form
end type
type dw_ypal from datawindow within w_misth_final_form_edit
end type
type tab1 from tab within w_misth_final_form_edit
end type
type page1 from userobject within tab1
end type
type uo_epidom from uo_misth_final_ypal_epidom_grid within page1
end type
type page1 from userobject within tab1
uo_epidom uo_epidom
end type
type page2 from userobject within tab1
end type
type uo_krat from uo_misth_final_ypal_krat_grid within page2
end type
type page2 from userobject within tab1
uo_krat uo_krat
end type
type tab1 from tab within w_misth_final_form_edit
page1 page1
page2 page2
end type
type dw_plirdate from datawindow within w_misth_final_form_edit
end type
type gb_1 from groupbox within w_misth_final_form_edit
end type
end forward

global type w_misth_final_form_edit from w_form
integer width = 3255
integer height = 2012
string icon = "res\final.ico"
boolean ib_update = true
string is_tablename = "misth_final"
dw_ypal dw_ypal
tab1 tab1
dw_plirdate dw_plirdate
gb_1 gb_1
end type
global w_misth_final_form_edit w_misth_final_form_edit

type variables
long		il_kodfinal

datawindow	idw_epidom
datawindow	idw_krat
end variables

forward prototypes
public function boolean of_check4required (ref datawindow adw, long row)
public subroutine of_dw2struct (ref datawindow adw, long row)
public subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_storekey ()
protected subroutine of_retrieve ()
public subroutine of_setmasks ()
protected subroutine of_settransactions ()
protected subroutine of_open ()
protected subroutine of_update ()
public function boolean of_ok ()
protected subroutine of_accepttext ()
end prototypes

public function boolean of_check4required (ref datawindow adw, long row);string		lstring	
long		llong	
long		ll_count
date		ldate

// aa
	llong	= adw.object.aa[row]
	if isnull(llong) then
		Messagebox(gs_app_name, trn(157))
		adw.setfocus()
		adw.setcolumn("aa")
		return false
	end if
	

// kodperiod
	lstring = adw.object.kodperiod[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(182))
		adw.setfocus()
		adw.setcolumn("kodperiod")
		return false
	end if

// kodkat
	lstring = adw.object.kodkat[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(171))
		adw.setfocus()
		adw.setcolumn("kodkat")
		return false
	end if

// datefinal
	ldate	= adw.object.datefinal[row]
	if isnull(ldate) then
		Messagebox(gs_app_name, trn(170))
		adw.setfocus()
		adw.setcolumn("datefinal")
		return false
	end if	
	
// descfinal
	lstring = adw.object.descfinal[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(177))
		adw.setfocus()
		adw.setcolumn("descfinal")
		return false
	end if
	
// everything ok
	return true
end function

public subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_final.kodfinal = adw.object.kodfinal[row]
gsc_misth_final.kodxrisi = adw.object.kodxrisi[row]
gsc_misth_final.descfinal = adw.object.descfinal[row]
gsc_misth_final.datefinal = adw.object.datefinal[row]
gsc_misth_final.title = adw.object.title[row]
gsc_misth_final.kodkat = adw.object.kodkat[row]
gsc_misth_final.kodperiod = adw.object.kodperiod[row]
gsc_misth_final.aa = adw.object.aa[row]
end subroutine

public subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodfinal[row] = gsc_misth_final.kodfinal 
adw.object.kodxrisi[row] = gsc_misth_final.kodxrisi
adw.object.descfinal[row] = gsc_misth_final.descfinal 
adw.object.datefinal[row] = gsc_misth_final.datefinal
adw.object.title[row] = gsc_misth_final.title
adw.object.kodkat[row] = gsc_misth_final.kodkat
adw.object.kodperiod[row] = gsc_misth_final.kodperiod
adw.object.aa[row] = gsc_misth_final.aa


end subroutine

protected subroutine of_storekey ();il_kodfinal = gsc_misth_final.kodfinal
end subroutine

protected subroutine of_retrieve ();dw_main.retrieve(string(il_kodfinal), gs_kodxrisi)
dw_ypal.retrieve(string(il_kodfinal), gs_kodxrisi)
idw_epidom.retrieve(string(il_kodfinal), gs_kodxrisi)
idw_krat.retrieve(string(il_kodfinal), gs_kodxrisi)

dw_plirdate.retrieve(string(il_kodfinal), gs_kodxrisi)


end subroutine

public subroutine of_setmasks ();fn_seteditmask(dw_main, "datefinal", fn_param_maskdate_e())
//fn_seteditmask(dw_plirdate, "plirdate", fn_param_maskdate_e())

end subroutine

protected subroutine of_settransactions ();dw_main.SetTransObject(SQLCA)
dw_ypal.SetTransObject(SQLCA)
dw_plirdate.SetTransObject(SQLCA)
end subroutine

protected subroutine of_open ();// set parents
	tab1.page1.uo_epidom.iw_parent = this
	tab1.page2.uo_krat.iw_parent = this

// get datawindow's to instance variables
	idw_epidom = tab1.page1.uo_epidom.dw
	idw_krat = tab1.page2.uo_krat.dw
	
// set alternative coloring of dw_ypal
	long	ll_rowrcolor, ll_rowcolor
	
	ll_rowrcolor = rgb(191,255,255)
	ll_rowcolor = rgb(255,255,255)
	
	dw_ypal.Modify("DataWindow.Detail.Color= '536870912~tif(mod(getrow(), 2) = 1, " + string(ll_rowcolor) + ", " + string(ll_rowrcolor) + ")'")



end subroutine

protected subroutine of_update ();dw_main.update()
dw_plirdate.update()
idw_epidom.update()
idw_krat.update()


COMMIT USING SQLCA;
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

protected subroutine of_accepttext ();dw_main.AcceptText()
dw_plirdate.AcceptText()
end subroutine

on w_misth_final_form_edit.create
int iCurrent
call super::create
this.dw_ypal=create dw_ypal
this.tab1=create tab1
this.dw_plirdate=create dw_plirdate
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ypal
this.Control[iCurrent+2]=this.tab1
this.Control[iCurrent+3]=this.dw_plirdate
this.Control[iCurrent+4]=this.gb_1
end on

on w_misth_final_form_edit.destroy
call super::destroy
destroy(this.dw_ypal)
destroy(this.tab1)
destroy(this.dw_plirdate)
destroy(this.gb_1)
end on

event open;call super::open;fn_retrievechild(dw_main, "kodkat", gs_kodxrisi)
fn_retrievechild(dw_main, "kodperiod", gs_kodxrisi)
fn_retrievechild(idw_epidom, "kodepidom", gs_kodxrisi)
fn_retrievechild(idw_krat, "kodkrat", gs_kodxrisi)

// translation
	title = trn(598)
	tab1.page1.text = trn(96)
	tab1.page2.text = trn(411)	
end event

type cb_cancel from w_form`cb_cancel within w_misth_final_form_edit
integer x = 2862
integer y = 188
integer width = 334
end type

type cb_ok from w_form`cb_ok within w_misth_final_form_edit
integer x = 2862
integer y = 32
integer width = 334
end type

type dw_main from w_form`dw_main within w_misth_final_form_edit
integer x = 37
integer y = 64
integer width = 2747
integer height = 368
string dataobject = "dw_misth_final_form"
end type

event dw_main::retrieveend;call super::retrieveend;// disable kodfinal
	if_lockfield(dw_main, "kodfinal")
	this.setcolumn("descfinal")
end event

type dw_ypal from datawindow within w_misth_final_form_edit
integer x = 32
integer y = 480
integer width = 891
integer height = 1336
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "pick_misth_final_ypal"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanging;this.SelectRow(currentrow, false)
this.Selectrow(newrow, true)
		
end event

event retrieveend;this.setrow(1)


end event

event rowfocuschanged;// ÖéëôñÜñéóìá uo_epidom, uo_krat
	long	ll_kodypal
	
	ll_kodypal = this.object.misth_final_ypal_kodypal[currentrow]
	
	tab1.page1.uo_epidom.uf_filter(ll_kodypal)
	tab1.page2.uo_krat.uf_filter(ll_kodypal)
	
// ÖéëôñÜñéóìá dw_plirdate ãéá ôïí åðéëåãìÝíï õðÜëëçëï

	dw_plirdate.setredraw(false)
	dw_plirdate.setfilter("kodypal = " + string(ll_kodypal))
	dw_plirdate.filter()
	dw_plirdate.setredraw(true)
	

end event

type tab1 from tab within w_misth_final_form_edit
event create ( )
event destroy ( )
integer x = 960
integer y = 600
integer width = 2235
integer height = 1216
integer taborder = 30
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
integer width = 2199
integer height = 1152
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

type uo_epidom from uo_misth_final_ypal_epidom_grid within page1
integer x = 18
integer y = 32
integer height = 1064
integer taborder = 40
end type

on uo_epidom.destroy
call uo_misth_final_ypal_epidom_grid::destroy
end on

type page2 from userobject within tab1
integer x = 18
integer y = 48
integer width = 2199
integer height = 1152
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

type uo_krat from uo_misth_final_ypal_krat_grid within page2
integer x = 18
integer y = 32
integer height = 1064
integer taborder = 20
end type

on uo_krat.destroy
call uo_misth_final_ypal_krat_grid::destroy
end on

type dw_plirdate from datawindow within w_misth_final_form_edit
integer x = 960
integer y = 480
integer width = 1111
integer height = 84
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_misth_final_ypal_prildate"
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_misth_final_form_edit
integer x = 23
integer y = 4
integer width = 2789
integer height = 440
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 33554432
long backcolor = 67108864
end type

