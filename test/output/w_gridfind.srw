HA$PBExportHeader$w_gridfind.srw
$PBExportComments$
forward
global type w_gridfind from w_response
end type
type dw_find from datawindow within w_gridfind
end type
type gb_1 from groupbox within w_gridfind
end type
end forward

global type w_gridfind from w_response
integer width = 1646
integer height = 680
windowtype windowtype = popup!
dw_find dw_find
gb_1 gb_1
end type
global w_gridfind w_gridfind

type variables
// hold dw to act on
	datawindow		idw
	
// row and column to continue searching
	long				il_nextrow, &
					 	il_nextcol
end variables

forward prototypes
public subroutine if_find ()
end prototypes

public subroutine if_find ();// ÁíáæÞôçóç ìå âÜóç ôéò åðéëïãÝò
	string	ls_findwhat
	integer	li_lookat
	integer	li_match
	
// Ðáßñíïõìå ôá äåäïìÝíá áðü dw_find
	dw_find.AcceptText()
	ls_findwhat = dw_find.object.findwhat[1]
	li_lookat = dw_find.object.lookat[1]
	li_match = dw_find.object.match[1]
	
// Áí äåí äþóáìå êåßìåíï áíáæÞôçóçò åðéóôñÝöïõìå
	if isnull(ls_findwhat) or ls_findwhat = "" then
		MessageBox(trn(68), trn(161))
		dw_find.SetFocus()
		dw_find.SetColumn("findwhat")
		return
	end if
	
// Find number of rows and columns - Hold current row and column
// Row and column to continue searching
	long	ll_nrows, ll_ncols, ll_currow, ll_curcol
	
	ll_nrows = idw.rowcount()
	ll_ncols = integer(idw.Object.DataWindow.Column.Count)
	ll_currow = idw.getrow()
	ll_curcol = idw.GetColumn()
	
	il_nextcol = il_nextcol + 1
	if il_nextcol > ll_ncols then il_nextcol = 1
	
	il_nextrow = il_nextrow + 1
	if il_nextrow > ll_nrows then il_nextrow = 1

idw.SetRedraw(false)

// ÁíáæÞôçóç óôï ôñÝ÷ïí ðåäßï Þ óå üëï ôïí ðßíáêá
	long		ll_rowfound
	
	choose case li_lookat	// ÁíÜëïãá ìå Äéåñåýíçóç óå
			
		case 1		// ÔñÝ÷ïí ðåäßï
			
			Choose case li_match	// ÁíÜëïãá ìå ôáßñéáóìá
					
				case 1	// Ïëüêëçñï ôï ðåäßï
					ll_rowfound = idw.Find("#" + string(ll_curcol) + "='" + &
												  ls_findwhat + "'", il_nextrow, ll_nrows)
					
				case 2	// ÏðïéïäÞðïôå ôìÞìá ôïõ ðåäßïõ
					
				case 3	// Áñ÷Þ ôïõ ðåäßïõ
					
			end choose				// Choose case li_match
					
			
		case 0		// ¼ëá ôá ðåäßá
			
	end choose		// choose case li_lookat


// Go to row found
	long	ll_red
	ll_red = rgb(255,0,0)
	if  ll_rowfound > 0 then
		idw.SetRow(ll_rowfound)
		idw.SetColumn(ll_curcol)
		idw.Setfocus()
	else
		MessageBox(trn(68), trn(156))
	end if
		
idw.SetRedraw(true)



end subroutine

on w_gridfind.create
int iCurrent
call super::create
this.dw_find=create dw_find
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_find
this.Control[iCurrent+2]=this.gb_1
end on

on w_gridfind.destroy
call super::destroy
destroy(this.dw_find)
destroy(this.gb_1)
end on

event open;call super::open;// Hold dw to act on
	idw = Message.PowerObjectParm
	
// Initialize
	dw_find.Insertrow(0)
	dw_find.Setfocus()
	dw_find.object.lookat[1] = 0
	dw_find.object.match[1] = 1
	
// Reset instance variables
	il_nextcol = 0
	il_nextrow = 0
	
// Translation
	title = trn(68)
	cb_ok.text = trn(347)
	cb_cancel.text = trn(329)
end event

type cb_cancel from w_response`cb_cancel within w_gridfind
integer x = 1262
integer y = 444
integer width = 334
string text = ""
end type

event cb_cancel::clicked;Close(GetParent())
end event

type cb_ok from w_response`cb_ok within w_gridfind
integer x = 718
integer y = 444
integer width = 480
string text = ""
end type

event cb_ok::clicked;if_find()
end event

type dw_find from datawindow within w_gridfind
integer x = 69
integer y = 60
integer width = 1499
integer height = 292
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "edw_gridfind"
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_gridfind
integer x = 32
integer width = 1563
integer height = 392
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

