HA$PBExportHeader$w_misth_report_form.srw
$PBExportComments$
forward
global type w_misth_report_form from w_form_tab2
end type
type uo_cols from uo_misth_report_cols_grid within page1
end type
type uo_ypal from uo_misth_report_ypal_sel within page2
end type
type page3 from userobject within tab1
end type
type dw_notes from datawindow within page3
end type
type page3 from userobject within tab1
dw_notes dw_notes
end type
end forward

global type w_misth_report_form from w_form_tab2
integer width = 2853
integer height = 1836
string title = "title"
string icon = "res\report.ico"
boolean ib_update = true
string is_tablename = "misth_report"
end type
global w_misth_report_form w_misth_report_form

type variables
string		is_kodreport

datawindow		idw_ypal, &
					idw_cols, &
					idw_notes
end variables

forward prototypes
protected subroutine of_open ()
public subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_storekey ()
protected subroutine of_retrieve ()
public subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_update ()
public function boolean of_check4required (ref datawindow adw, long row)
protected subroutine of_accepttext ()
public subroutine of_sharedws ()
end prototypes

protected subroutine of_open ();idw_main = dw_main
idw_cols = tab1.page1.uo_cols.dw
idw_notes = tab1.page3.dw_notes

tab1.page1.uo_cols.iw_parent = this
tab1.page2.uo_ypal.iw_parent = this

end subroutine

public subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_report.kodreport = adw.object.kodreport[row]
gsc_misth_report.kodxrisi = adw.object.kodxrisi[row]
gsc_misth_report.descreport = adw.object.descreport[row]
gsc_misth_report.print_margin_top = adw.object.print_margin_top[row]
gsc_misth_report.print_margin_bottom = adw.object.print_margin_bottom[row]
gsc_misth_report.print_margin_left = adw.object.print_margin_left[row]
gsc_misth_report.print_margin_right = adw.object.print_margin_right[row]
gsc_misth_report.print_orientation = adw.object.print_orientation[row]
gsc_misth_report.print_paper_size = adw.object.print_paper_size[row]
gsc_misth_report.print_scale = adw.object.print_scale[row]
gsc_misth_report.subtitle = adw.object.subtitle[row]
gsc_misth_report.prn_notes1 = adw.object.prn_notes1[row]
gsc_misth_report.prn_notes2 = adw.object.prn_notes2[row]

end subroutine

protected subroutine of_storekey ();is_kodreport = gsc_misth_report.kodreport
end subroutine

protected subroutine of_retrieve ();idw_main.retrieve(is_kodreport, gs_kodxrisi)
idw_cols.retrieve(is_kodreport, gs_kodxrisi)
end subroutine

public subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodreport[row] = gsc_misth_report.kodreport
adw.object.kodxrisi[row] = gsc_misth_report.kodxrisi
adw.object.descreport[row] = gsc_misth_report.descreport
adw.object.print_margin_top[row] = gsc_misth_report.print_margin_top
adw.object.print_margin_bottom[row] = gsc_misth_report.print_margin_bottom
adw.object.print_margin_left[row] = gsc_misth_report.print_margin_left
adw.object.print_margin_right[row] = gsc_misth_report.print_margin_right
adw.object.print_orientation[row] = gsc_misth_report.print_orientation
adw.object.print_paper_size[row] = gsc_misth_report.print_paper_size
adw.object.print_scale[row] = gsc_misth_report.print_scale
adw.object.subtitle[row] = gsc_misth_report.subtitle  
adw.object.prn_notes1[row] = gsc_misth_report.prn_notes1 
adw.object.prn_notes2[row] = gsc_misth_report.prn_notes2 
end subroutine

protected subroutine of_update ();idw_main.update()
idw_cols.update()
tab1.page2.uo_ypal.triggerevent("ie_update")

COMMIT USING SQLCA;
end subroutine

public function boolean of_check4required (ref datawindow adw, long row);
string		lstring	
long		llong	
date		ldate
time		ltime
long		ll_count

// kodreport
	lstring = adw.object.kodreport[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(188))
		adw.setfocus()
		adw.setcolumn("kodreport")
		return false
	end if
	
	// ¸ëåã÷ïò áí ï êùäéêüò Ý÷åé êáôá÷ùñçèåß
		if lstring <> is_kodreport or isnull(is_kodreport) or is_kodreport = "" then
			select count(kodreport) into :ll_count from misth_report
			where kodreport = :lstring and kodxrisi = :gs_kodxrisi;
			fn_sqlerror()
			if ll_count > 0 then
				Messagebox(gs_app_name, tr("Ï Êùäéêüò") + " '" + lstring + "' " + trn(658))
				adw.setfocus()
				adw.setcolumn("kodreport")
				return false
			end if
		end if
	

// descreport
	lstring = adw.object.descreport[row]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(175))
		adw.setfocus()
		adw.setcolumn("descreport")
		return false
	end if	


// everything ok
	return true
end function

protected subroutine of_accepttext ();idw_main.AcceptText()
idw_cols.AcceptText()
idw_notes.AcceptText()

end subroutine

public subroutine of_sharedws ();idw_main.ShareData(idw_notes)
end subroutine

on w_misth_report_form.create
int iCurrent
call super::create
end on

on w_misth_report_form.destroy
call super::destroy
end on

event open;call super::open;tab1.page2.uo_ypal.triggerevent("ie_retrieve")

dw_main.object.gb_1.text = tr("Ðåñéèùñéá")

// translation
	title = trn(595)
	tab1.page1.text = trn(591)
	tab1.page2.text = trn(657)
	tab1.page3.text = trn(593)
	
	dw_main.Object.print_paper_size.Values=trn(701) + "	0/" + &
														"A3	8/" + &
														"A4	9/" + &
														"A5	11/" + &
														"B4	12/" 
														
															
	dw_main.Object.print_orientation.Values=trn(702) + "	2/" + &
														 trn(703) + "	1/"
end event

type dw_main from w_form_tab2`dw_main within w_misth_report_form
integer height = 572
string dataobject = "dw_misth_report_form"
end type

type tab1 from w_form_tab2`tab1 within w_misth_report_form
integer y = 620
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
integer height = 884
string text = "page1"
uo_cols uo_cols
end type

on page1.create
this.uo_cols=create uo_cols
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_cols
end on

on page1.destroy
call super::destroy
destroy(this.uo_cols)
end on

type page2 from w_form_tab2`page2 within tab1
integer y = 104
integer height = 884
string text = "page2"
uo_ypal uo_ypal
end type

on page2.create
this.uo_ypal=create uo_ypal
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_ypal
end on

on page2.destroy
call super::destroy
destroy(this.uo_ypal)
end on

type cb_cancel from w_form_tab2`cb_cancel within w_misth_report_form
integer y = 1516
end type

type cb_ok from w_form_tab2`cb_ok within w_misth_report_form
integer y = 1384
end type

type uo_cols from uo_misth_report_cols_grid within page1
integer x = 27
integer y = 24
integer taborder = 20
end type

on uo_cols.destroy
call uo_misth_report_cols_grid::destroy
end on

type uo_ypal from uo_misth_report_ypal_sel within page2
event destroy ( )
integer x = 27
integer y = 24
integer taborder = 20
end type

on uo_ypal.destroy
call uo_misth_report_ypal_sel::destroy
end on

type page3 from userobject within tab1
integer x = 18
integer y = 104
integer width = 2322
integer height = 884
long backcolor = 67108864
string text = "page3"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
dw_notes dw_notes
end type

on page3.create
this.dw_notes=create dw_notes
this.Control[]={this.dw_notes}
end on

on page3.destroy
destroy(this.dw_notes)
end on

type dw_notes from datawindow within page3
integer x = 27
integer y = 56
integer width = 2267
integer height = 788
integer taborder = 30
string title = "none"
string dataobject = "dw_misth_report_form_notes"
boolean border = false
boolean livescroll = true
end type

