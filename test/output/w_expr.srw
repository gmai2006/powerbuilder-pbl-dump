HA$PBExportHeader$w_expr.srw
$PBExportComments$
forward
global type w_expr from w_response
end type
type mle_expr from multilineedit within w_expr
end type
type dw_var from datawindow within w_expr
end type
type st_1 from statictext within w_expr
end type
type cb_syn from commandbutton within w_expr
end type
type cb_plin from commandbutton within w_expr
end type
type cb_epi from commandbutton within w_expr
end type
type cb_dia from commandbutton within w_expr
end type
type cb_leftpar from commandbutton within w_expr
end type
type cb_rightpar from commandbutton within w_expr
end type
type st_2 from statictext within w_expr
end type
type plb_category from picturelistbox within w_expr
end type
end forward

global type w_expr from w_response
integer width = 2455
integer height = 1584
string title = "Expresion builder"
mle_expr mle_expr
dw_var dw_var
st_1 st_1
cb_syn cb_syn
cb_plin cb_plin
cb_epi cb_epi
cb_dia cb_dia
cb_leftpar cb_leftpar
cb_rightpar cb_rightpar
st_2 st_2
plb_category plb_category
end type
global w_expr w_expr

type variables
datastore	ids_stath, &
				ids_yvar, &
				ids_epidom, &
				ids_krat

string		is_label_stath, &
				is_label_yvar, &
				is_label_epidom, &
				is_label_krat
end variables

forward prototypes
public subroutine if_init ()
end prototypes

public subroutine if_init ();// inititialize 

is_label_stath = trn(590)
is_label_yvar = trn(433)
is_label_epidom = trn(95) + "/" + trn(306)
is_label_krat = trn(411)

if isvalid(ids_stath) then	plb_category.additem(is_label_stath)
if isvalid(ids_yvar) then	plb_category.additem(is_label_yvar) 
if isvalid(ids_epidom) then	plb_category.additem(is_label_epidom)
if isvalid(ids_krat) then	plb_category.additem(is_label_krat)

plb_category.SelectItem ( 1 )	// trigger selectionchanged
plb_category.TriggerEvent(SelectionChanged!, 1, 0)

end subroutine

on w_expr.create
int iCurrent
call super::create
this.mle_expr=create mle_expr
this.dw_var=create dw_var
this.st_1=create st_1
this.cb_syn=create cb_syn
this.cb_plin=create cb_plin
this.cb_epi=create cb_epi
this.cb_dia=create cb_dia
this.cb_leftpar=create cb_leftpar
this.cb_rightpar=create cb_rightpar
this.st_2=create st_2
this.plb_category=create plb_category
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_expr
this.Control[iCurrent+2]=this.dw_var
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_syn
this.Control[iCurrent+5]=this.cb_plin
this.Control[iCurrent+6]=this.cb_epi
this.Control[iCurrent+7]=this.cb_dia
this.Control[iCurrent+8]=this.cb_leftpar
this.Control[iCurrent+9]=this.cb_rightpar
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.plb_category
end on

on w_expr.destroy
call super::destroy
destroy(this.mle_expr)
destroy(this.dw_var)
destroy(this.st_1)
destroy(this.cb_syn)
destroy(this.cb_plin)
destroy(this.cb_epi)
destroy(this.cb_dia)
destroy(this.cb_leftpar)
destroy(this.cb_rightpar)
destroy(this.st_2)
destroy(this.plb_category)
end on

event open;call super::open;// Ðáßñíïõìå ôá äåäïìÝíá
	s_expr	lsc_expr
	lsc_expr = message.powerobjectparm

	ids_stath = lsc_expr.stath
	ids_yvar = lsc_expr.yvar
	ids_epidom = lsc_expr.epidom
	ids_krat = lsc_expr.krat
	
	mle_expr.text = lsc_expr.expr

// plb_category init
	if_init()

// Translation 
	title = trn(625)
	st_1.text = trn(640)
	st_2.text = trn(397)
end event

type cb_cancel from w_response`cb_cancel within w_expr
integer x = 2075
integer y = 180
integer taborder = 40
end type

event cb_cancel::clicked;CloseWithReturn(GetParent(), 0)
end event

type cb_ok from w_response`cb_ok within w_expr
integer x = 2075
integer y = 32
integer taborder = 30
end type

event cb_ok::clicked;gstring = mle_expr.text

CloseWithReturn(GetParent(), 1)
end event

type mle_expr from multilineedit within w_expr
integer x = 32
integer y = 32
integer width = 1970
integer height = 632
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_var from datawindow within w_expr
event ue_lbuttondown pbm_dwnlbuttonclk
event ue_lbuttonup pbm_dwnlbuttonup
integer x = 1042
integer y = 788
integer width = 1344
integer height = 680
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "edw_var"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_lbuttondown;if row = 0 then return

this.selectrow(row, true)
end event

event ue_lbuttonup;if row = 0 then return

// ÁíÜëïãá ìå ôçí êáôçãïñßá

string	ls_category
string	ls_var				// Ç ìåôáâëçôÞ, üðùò äçìéïõñãåßôáé

ls_category = plb_category.selecteditem()

choose case ls_category
		
	case is_label_stath
		// Ðáßñíïõìå ôïí êùäéêü ôçò óôáèåñÜò êáé ôïí äéáìïñöþíïõìå
			ls_var = this.object.kodvar[row]
			ls_var = " @" + ls_var + "@ "
			
	case is_label_yvar
		// Ðáßñíïõìå ôïí êùäéêü ôçò ìåôáâëçôÞò êáé ôïí äéáìïñöþíïõìå
			ls_var = this.object.kodvar[row]
			ls_var = " #" + ls_var + "# "
			
	case is_label_epidom
		// Ðáßñíïõìå ôïí êùäéêü ôïõ åðéäüìáôïò êáé ôïí äéáìïñöþíïõìå
			ls_var = this.object.kodvar[row]
			ls_var = " [" + ls_var + "] "
		
	case is_label_krat
		// Ðáßñíïõìå ôïí êùäéêü ôçò êñÜôçóçò êáé ôïí äéáìïñöþíïõìå
			ls_var = this.object.kodvar[row]
			ls_var = " {" + ls_var + "} "
		
end choose


// ÃñÜöïõìå ôçí ôéìÞ êáé áðïåðéëÝãïõìå ôçí ãñáììÞ
	mle_expr.ReplaceText(ls_var)
	this.SelectRow(row, false)
	mle_expr.setfocus()
end event

type st_1 from statictext within w_expr
integer x = 1042
integer y = 700
integer width = 343
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Value"
boolean focusrectangle = false
end type

type cb_syn from commandbutton within w_expr
integer x = 32
integer y = 788
integer width = 101
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "+"
end type

event clicked;
mle_expr.ReplaceText (" + " )

mle_expr.setfocus()
end event

type cb_plin from commandbutton within w_expr
integer x = 165
integer y = 788
integer width = 101
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "-"
end type

event clicked;mle_expr.ReplaceText (" - " )

mle_expr.setfocus()
end event

type cb_epi from commandbutton within w_expr
integer x = 32
integer y = 932
integer width = 101
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "*"
end type

event clicked;mle_expr.ReplaceText (" * " )

mle_expr.setfocus()
end event

type cb_dia from commandbutton within w_expr
integer x = 165
integer y = 932
integer width = 101
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "/"
end type

event clicked;mle_expr.ReplaceText (" / " )

mle_expr.setfocus()
end event

type cb_leftpar from commandbutton within w_expr
integer x = 32
integer y = 1076
integer width = 101
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "("
end type

event clicked;mle_expr.ReplaceText (" ( " )

mle_expr.setfocus()
end event

type cb_rightpar from commandbutton within w_expr
integer x = 165
integer y = 1076
integer width = 101
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ")"
end type

event clicked;mle_expr.ReplaceText (" ) " )

mle_expr.setfocus()
end event

type st_2 from statictext within w_expr
integer x = 320
integer y = 700
integer width = 343
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Category"
boolean focusrectangle = false
end type

type plb_category from picturelistbox within w_expr
integer x = 320
integer y = 788
integer width = 667
integer height = 680
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {""}
borderstyle borderstyle = stylelowered!
integer itempictureindex[] = {0}
long picturemaskcolor = 536870912
end type

event selectionchanged;// ÁëëÜæïõìå ôï dw_var

string		ls_category

ls_category = plb_category.selecteditem()

choose case ls_category
		
	case is_label_stath
		ids_stath.sharedata(dw_var)
		
	case is_label_yvar
		ids_yvar.sharedata(dw_var)
			
	case is_label_epidom
		ids_epidom.sharedata(dw_var)
		
	case is_label_krat
		ids_krat.sharedata(dw_var)
		
end choose


	
end event

