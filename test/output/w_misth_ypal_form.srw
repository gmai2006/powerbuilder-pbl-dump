HA$PBExportHeader$w_misth_ypal_form.srw
$PBExportComments$
forward
global type w_misth_ypal_form from w_form_tab2
end type
type dw_job from datawindow within page1
end type
type dw_personal from datawindow within page2
end type
type page3 from userobject within tab1
end type
type uo_yvar from uo_misth_ypal_yvar_grid within page3
end type
type page3 from userobject within tab1
uo_yvar uo_yvar
end type
type page4 from userobject within tab1
end type
type dw_misth from datawindow within page4
end type
type page4 from userobject within tab1
dw_misth dw_misth
end type
end forward

global type w_misth_ypal_form from w_form_tab2
integer width = 3090
integer height = 1644
string title = "Title"
string icon = "res\ypal.ico"
boolean ib_update = true
string is_tablename = "misth_ypal"
end type
global w_misth_ypal_form w_misth_ypal_form

type variables
datawindow		idw_personal, &
					idw_job, &
					idw_yvar, &
					idw_misth
					
long				il_kodypal
end variables

forward prototypes
protected subroutine of_open ()
protected subroutine of_accepttext ()
public function boolean of_check4required (ref datawindow adw, long row)
public subroutine of_disabledws ()
protected subroutine of_storekey ()
protected subroutine of_retrieve ()
protected subroutine of_update ()
public subroutine of_sharedws ()
public subroutine of_setmasks ()
public subroutine of_dw2struct (ref datawindow adw, long row)
public subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_settransactions ()
end prototypes

protected subroutine of_open ();idw_main = dw_main
idw_job = tab1.page1.dw_job
idw_personal = tab1.page2.dw_personal
idw_yvar = tab1.page3.uo_yvar.dw
idw_misth = tab1.page4.dw_misth
tab1.page3.uo_yvar.iw_parent = this

cb_cancel.setfocus()
fn_retrievechild(idw_main, "kodtitlos", gs_kodxrisi)
fn_retrievechild(idw_job, "kodtmima", gs_kodxrisi)
fn_retrievechild(idw_job, "kodidikot", gs_kodxrisi)
fn_retrievechild(idw_job, "kodthesi", gs_kodxrisi)
fn_retrievechild(idw_job, "kodtamio", gs_kodxrisi)
fn_retrievechild(idw_personal, "kodoikog", gs_kodxrisi)
fn_retrievechild(idw_yvar, "kodyvar", gs_kodxrisi)
idw_main.setfocus()

end subroutine

protected subroutine of_accepttext ();idw_main.AcceptText()
idw_job.AcceptText()
idw_personal.AcceptText()
idw_yvar.AcceptText()
end subroutine

public function boolean of_check4required (ref datawindow adw, long row);string	lstring	

// surname
	lstring = adw.object.surname[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(184))
		adw.setfocus()
		adw.setcolumn("surname")
		return false
	end if
	
// everything ok
	return true
end function

public subroutine of_disabledws ();idw_main.enabled = false
idw_job.enabled = false
idw_personal.enabled = false
idw_yvar.enabled = false
idw_misth.enabled = false
end subroutine

protected subroutine of_storekey ();il_kodypal = gsc_misth_ypal.kodypal
end subroutine

protected subroutine of_retrieve ();idw_main.retrieve(string(il_kodypal), gs_kodxrisi)
idw_yvar.retrieve(string(il_kodypal), gs_kodxrisi)
idw_misth.retrieve(string(il_kodypal), gs_kodxrisi)


end subroutine

protected subroutine of_update ();idw_main.update()
idw_yvar.update()
COMMIT USING SQLCA;

end subroutine

public subroutine of_sharedws ();idw_main.sharedata(idw_job)
idw_main.sharedata(idw_personal)

end subroutine

public subroutine of_setmasks ();fn_seteditmask(idw_job, "hireddate", fn_param_maskdate_e())
fn_seteditmask(idw_job, "rehireddate", fn_param_maskdate_e())
fn_seteditmask(idw_job, "exeldate", fn_param_maskdate_e())
fn_seteditmask(idw_job, "termdate", fn_param_maskdate_e())
fn_seteditmask(idw_job, "newexeldate", fn_param_maskdate_e())

fn_seteditmask(idw_personal, "birthdate", fn_param_maskdate_e())
end subroutine

public subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_ypal.kodypal = adw.object.kodypal[row]
gsc_misth_ypal.kodxrisi = adw.object.kodxrisi[row]
gsc_misth_ypal.surname = adw.object.surname[row]
gsc_misth_ypal.name = adw.object.name[row]
gsc_misth_ypal.fathername = adw.object.fathername[row]
gsc_misth_ypal.mothername = adw.object.mothername[row]
gsc_misth_ypal.adt = adw.object.adt[row]
gsc_misth_ypal.mitroo = adw.object.mitroo[row]
gsc_misth_ypal.afm = adw.object.afm[row]
gsc_misth_ypal.doy = adw.object.doy[row]
gsc_misth_ypal.birthdate = adw.object.birthdate[row]
gsc_misth_ypal.homephone = adw.object.homephone[row]
gsc_misth_ypal.mobilphone = adw.object.mobilphone[row]
gsc_misth_ypal.sex = adw.object.sex[row]
gsc_misth_ypal.spouse = adw.object.spouse[row]
gsc_misth_ypal.childs = adw.object.childs[row]
gsc_misth_ypal.prostmeli = adw.object.prostmeli[row]
gsc_misth_ypal.city = adw.object.city[row]
gsc_misth_ypal.area = adw.object.area[row]
gsc_misth_ypal.address = adw.object.address[row]
gsc_misth_ypal.tk = adw.object.tk[row]
gsc_misth_ypal.email = adw.object.email[row]
gsc_misth_ypal.kodtmima = adw.object.kodtmima[row]
gsc_misth_ypal.kodidikot = adw.object.kodidikot[row]
gsc_misth_ypal.jobtitle = adw.object.jobtitle[row]
gsc_misth_ypal.hireddate = adw.object.hireddate[row]
gsc_misth_ypal.rehireddate = adw.object.rehireddate[row]
gsc_misth_ypal.exeldate = adw.object.exeldate[row]
gsc_misth_ypal.termdate = adw.object.termdate[row]
gsc_misth_ypal.termreason = adw.object.termreason[row]
gsc_misth_ypal.jobphone = adw.object.jobphone[row]
gsc_misth_ypal.intphone = adw.object.intphone[row]
gsc_misth_ypal.klimakio = adw.object.klimakio[row]
gsc_misth_ypal.bathmos = adw.object.bathmos[row]
gsc_misth_ypal.klados = adw.object.klados[row]
gsc_misth_ypal.bank = adw.object.bank[row]
gsc_misth_ypal.bankno = adw.object.bankno[row]
gsc_misth_ypal.kodtamio = adw.object.kodtamio[row]
gsc_misth_ypal.newexeldate = adw.object.newexeldate[row]

end subroutine

public subroutine of_struct2dw (ref datawindow adw, long row); adw.object.kodypal[row] = gsc_misth_ypal.kodypal 
 adw.object.kodxrisi[row] =	gsc_misth_ypal.kodxrisi 
 adw.object.surname[row] =	gsc_misth_ypal.surname 
 adw.object.name[row] =	gsc_misth_ypal.name 
 adw.object.fathername[row] =	gsc_misth_ypal.fathername 
  adw.object.mothername[row] =	gsc_misth_ypal.mothername 
 adw.object.adt[row] =	gsc_misth_ypal.adt 
 adw.object.mitroo[row] =	gsc_misth_ypal.mitroo 
 adw.object.afm[row] =	gsc_misth_ypal.afm 
 adw.object.doy[row] =	gsc_misth_ypal.doy 
 adw.object.birthdate[row]	=	gsc_misth_ypal.birthdate 
 adw.object.homephone[row]	=	gsc_misth_ypal.homephone 
 adw.object.mobilphone[row]	=	gsc_misth_ypal.mobilphone 
 adw.object.sex[row]	=	gsc_misth_ypal.sex 
 adw.object.kodoikog[row]	=	gsc_misth_ypal.kodoikog
 adw.object.kodoikog[row]	=	gsc_misth_ypal.kodoikog 
 adw.object.spouse[row]	=	gsc_misth_ypal.spouse 
 adw.object.childs[row]	=	gsc_misth_ypal.childs 
 adw.object.prostmeli[row]	=	gsc_misth_ypal.prostmeli 
 adw.object.city[row]	=	gsc_misth_ypal.city 
 adw.object.area[row]	=	gsc_misth_ypal.area 
 adw.object.address[row]	=	gsc_misth_ypal.address 
 adw.object.tk[row]	=	gsc_misth_ypal.tk 
 adw.object.email[row]	=	gsc_misth_ypal.email 
 adw.object.kodtmima[row]	=	gsc_misth_ypal.kodtmima 
 adw.object.kodidikot[row]	=	gsc_misth_ypal.kodidikot 
 adw.object.jobtitle[row]	=	gsc_misth_ypal.jobtitle 
 adw.object.hireddate[row]	=	gsc_misth_ypal.hireddate 
 adw.object.rehireddate[row]	=	gsc_misth_ypal.rehireddate 
 adw.object.exeldate[row]	=	gsc_misth_ypal.exeldate 
 adw.object.termdate[row]	=	gsc_misth_ypal.termdate 
 adw.object.termreason[row]	=	gsc_misth_ypal.termreason 
 adw.object.jobphone[row]	=	gsc_misth_ypal.jobphone 
 adw.object.intphone[row]	=	gsc_misth_ypal.intphone 
 adw.object.klimakio[row]	=	gsc_misth_ypal.klimakio 
 adw.object.bathmos[row]	=	gsc_misth_ypal.bathmos 
 adw.object.klados[row]	=	gsc_misth_ypal.klados 
 adw.object.bank[row]	=	gsc_misth_ypal.bank 
 adw.object.bankno[row]	=	gsc_misth_ypal.bankno 
 adw.object.kodtamio[row]	=	gsc_misth_ypal.kodtamio 
 adw.object.newexeldate[row]	=	gsc_misth_ypal.newexeldate 


end subroutine

protected subroutine of_settransactions ();idw_main.SetTransObject(SQLCA)
idw_misth.SetTransObject(SQLCA)
end subroutine

on w_misth_ypal_form.create
int iCurrent
call super::create
end on

on w_misth_ypal_form.destroy
call super::destroy
end on

event open;call super::open;// Translation
	idw_personal.Object.sex.Values=trn(113) + "	1/" + trn(380) + "	" + "2/"
	title = trn(594)
	tab1.page1.text = trn(341)
	tab1.page2.text = trn(575)
	tab1.page3.text = trn(432)
	tab1.page4.text = trn(449)
end event

type dw_main from w_form_tab2`dw_main within w_misth_ypal_form
integer x = 37
integer width = 2423
integer height = 364
string dataobject = "dw_misth_ypal_form_general"
end type

type tab1 from w_form_tab2`tab1 within w_misth_ypal_form
integer x = 41
integer y = 400
integer width = 2629
integer height = 1096
integer textsize = -8
page3 page3
page4 page4
end type

on tab1.create
this.page3=create page3
this.page4=create page4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.page3
this.Control[iCurrent+2]=this.page4
end on

on tab1.destroy
call super::destroy
destroy(this.page3)
destroy(this.page4)
end on

type page1 from w_form_tab2`page1 within tab1
integer y = 104
integer width = 2592
integer height = 976
string text = "page1"
dw_job dw_job
end type

on page1.create
this.dw_job=create dw_job
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_job
end on

on page1.destroy
call super::destroy
destroy(this.dw_job)
end on

type page2 from w_form_tab2`page2 within tab1
integer y = 104
integer width = 2592
integer height = 976
string text = "page2"
dw_personal dw_personal
end type

on page2.create
this.dw_personal=create dw_personal
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_personal
end on

on page2.destroy
call super::destroy
destroy(this.dw_personal)
end on

type cb_cancel from w_form_tab2`cb_cancel within w_misth_ypal_form
integer x = 2725
integer y = 1388
end type

type cb_ok from w_form_tab2`cb_ok within w_misth_ypal_form
integer x = 2729
integer y = 1256
end type

type dw_job from datawindow within page1
integer x = 9
integer y = 32
integer width = 2574
integer height = 920
integer taborder = 50
string title = "none"
string dataobject = "dw_misth_ypal_form_job"
boolean border = false
boolean livescroll = true
end type

type dw_personal from datawindow within page2
integer x = 9
integer y = 32
integer width = 2574
integer height = 792
integer taborder = 40
string title = "none"
string dataobject = "dw_misth_ypal_form_personal"
boolean border = false
boolean livescroll = true
end type

type page3 from userobject within tab1
integer x = 18
integer y = 104
integer width = 2592
integer height = 976
long backcolor = 67108864
string text = "page3"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
uo_yvar uo_yvar
end type

on page3.create
this.uo_yvar=create uo_yvar
this.Control[]={this.uo_yvar}
end on

on page3.destroy
destroy(this.uo_yvar)
end on

type uo_yvar from uo_misth_ypal_yvar_grid within page3
integer x = 18
integer y = 20
integer taborder = 20
end type

on uo_yvar.destroy
call uo_misth_ypal_yvar_grid::destroy
end on

type page4 from userobject within tab1
integer x = 18
integer y = 104
integer width = 2592
integer height = 976
long backcolor = 67108864
string text = "page4"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
dw_misth dw_misth
end type

on page4.create
this.dw_misth=create dw_misth
this.Control[]={this.dw_misth}
end on

on page4.destroy
destroy(this.dw_misth)
end on

type dw_misth from datawindow within page4
integer x = 18
integer y = 20
integer width = 2542
integer height = 936
integer taborder = 20
string title = "none"
string dataobject = "dw_misth_final_ypal_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

