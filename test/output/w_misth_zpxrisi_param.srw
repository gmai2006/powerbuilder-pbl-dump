HA$PBExportHeader$w_misth_zpxrisi_param.srw
$PBExportComments$
forward
global type w_misth_zpxrisi_param from w_singleform_tab
end type
type page2 from userobject within tab1
end type
type dw_masks from datawindow within page2
end type
type page2 from userobject within tab1
dw_masks dw_masks
end type
type page3 from userobject within tab1
end type
type dw_prn from datawindow within page3
end type
type page3 from userobject within tab1
dw_prn dw_prn
end type
end forward

global type w_misth_zpxrisi_param from w_singleform_tab
integer height = 1608
string title = "title"
string icon = "res\param.ico"
end type
global w_misth_zpxrisi_param w_misth_zpxrisi_param

type variables
datawindow		idw_eteria, &
					idw_masks, &
					idw_prn
					
end variables

forward prototypes
public subroutine of_sharedws ()
public subroutine of_retrieve ()
public subroutine of_open ()
public subroutine of_settransactions ()
end prototypes

public subroutine of_sharedws ();idw_main.ShareData(idw_masks)
idw_main.ShareData(idw_prn)
end subroutine

public subroutine of_retrieve ();idw_main.retrieve(gs_kodxrisi)
end subroutine

public subroutine of_open ();idw_main = tab1.page1.dw_main
idw_masks = tab1.page2.dw_masks
idw_prn = tab1.page3.dw_prn

end subroutine

public subroutine of_settransactions ();idw_main.settransobject(sqlca)

end subroutine

on w_misth_zpxrisi_param.create
int iCurrent
call super::create
end on

on w_misth_zpxrisi_param.destroy
call super::destroy
end on

event open;call super::open;tab1.page2.dw_masks.object.gb_1.text = trn(556)
tab1.page2.dw_masks.object.gb_2.text = trn(302)
title = trn(503)
tab1.page1.text = trn(344)
tab1.page2.text = trn(452)
tab1.page3.text = trn(271)

end event

type cb_cancel from w_singleform_tab`cb_cancel within w_misth_zpxrisi_param
integer y = 1380
end type

type cb_ok from w_singleform_tab`cb_ok within w_misth_zpxrisi_param
integer y = 1380
end type

type tab1 from w_singleform_tab`tab1 within w_misth_zpxrisi_param
integer height = 1320
page2 page2
page3 page3
end type

on tab1.create
this.page2=create page2
this.page3=create page3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.page2
this.Control[iCurrent+2]=this.page3
end on

on tab1.destroy
call super::destroy
destroy(this.page2)
destroy(this.page3)
end on

type page1 from w_singleform_tab`page1 within tab1
integer height = 1200
string text = "page1"
end type

type dw_main from w_singleform_tab`dw_main within page1
string dataobject = "dw_misth_zpxrisi_param_eteria"
end type

type page2 from userobject within tab1
integer x = 18
integer y = 104
integer width = 2089
integer height = 1200
long backcolor = 67108864
string text = "page2"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
dw_masks dw_masks
end type

on page2.create
this.dw_masks=create dw_masks
this.Control[]={this.dw_masks}
end on

on page2.destroy
destroy(this.dw_masks)
end on

type dw_masks from datawindow within page2
integer x = 46
integer y = 52
integer width = 1993
integer height = 596
integer taborder = 30
string title = "none"
string dataobject = "dw_misth_zpxrisi_param_masks"
boolean border = false
boolean livescroll = true
end type

type page3 from userobject within tab1
integer x = 18
integer y = 104
integer width = 2089
integer height = 1200
long backcolor = 67108864
string text = "page3"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
dw_prn dw_prn
end type

on page3.create
this.dw_prn=create dw_prn
this.Control[]={this.dw_prn}
end on

on page3.destroy
destroy(this.dw_prn)
end on

type dw_prn from datawindow within page3
integer x = 46
integer y = 52
integer width = 1993
integer height = 1112
integer taborder = 30
string title = "none"
string dataobject = "dw_misth_zpxrisi_param_prn"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

