HA$PBExportHeader$w_misth_report_list.srw
$PBExportComments$
forward
global type w_misth_report_list from w_list
end type
end forward

global type w_misth_report_list from w_list
integer width = 2190
integer height = 1856
string title = "title"
string icon = "res\report.ico"
string is_tablename = "misth_report"
string is_order = " order by kodreport "
string is_formwin = "w_misth_report_form"
boolean ib_editwithkey = true
boolean ib_retrieve = true
boolean ib_sort = true
boolean ib_noview = true
boolean ib_nofilter = true
end type
global w_misth_report_list w_misth_report_list

forward prototypes
public subroutine of_deleterow (ref datawindow adw, long row)
protected subroutine of_dw2struct (ref datawindow adw, long row)
protected subroutine of_struct2dw (ref datawindow adw, long row)
protected subroutine of_init_struct ()
protected subroutine of_reset_struct ()
protected subroutine of_retrieve (ref datawindow adw)
end prototypes

public subroutine of_deleterow (ref datawindow adw, long row);string		ls_kodreport

ls_kodreport = adw.object.kodreport[row]

delete from misth_report 
where kodreport = :ls_kodreport and kodxrisi = :gs_kodxrisi;
fn_sqlerror()
commit;
end subroutine

protected subroutine of_dw2struct (ref datawindow adw, long row);gsc_misth_report.kodreport = adw.object.kodreport[row]
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


end subroutine

protected subroutine of_struct2dw (ref datawindow adw, long row);adw.object.kodreport[row] = gsc_misth_report.kodreport
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
  
end subroutine

protected subroutine of_init_struct ();gsc_misth_report.kodxrisi = gs_kodxrisi
gsc_misth_report.print_margin_top = 0
gsc_misth_report.print_margin_bottom = 0
gsc_misth_report.print_margin_left = 0
gsc_misth_report.print_margin_right = 0
gsc_misth_report.print_orientation = 2
gsc_misth_report.print_paper_size = 0
gsc_misth_report.print_scale = 0

end subroutine

protected subroutine of_reset_struct ();gsc_misth_report_reset()
end subroutine

protected subroutine of_retrieve (ref datawindow adw);adw.retrieve(gs_kodxrisi)
end subroutine

on w_misth_report_list.create
call super::create
end on

on w_misth_report_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;title = trn(623)

end event

type dw from w_list`dw within w_misth_report_list
integer width = 2144
string dataobject = "dw_misth_report_list"
end type

