HA$PBExportHeader$w_app.srw
$PBExportComments$
forward
global type w_app from w_main
end type
type tv from treeview within w_app
end type
end forward

global type w_app from w_main
integer width = 2802
integer height = 2000
string menuname = "m_misth"
event ie_sizebar ( )
tv tv
end type
global w_app w_app

type variables
long		il_tvwidth
end variables

forward prototypes
public subroutine if_inittv ()
end prototypes

event ie_sizebar();// ÐñïóáñìïãÞ ôïõ tv

int cxClient, cyClient		// client area
int xClient, yClient			// Áðüóôáóç áðü ôá üñéá ôïõ ðáñáèýñïõ
int cxMDI, cyMDI				// mdi_1 object's dimensions

// Ðáßñíïõìå ôéò íÝåò äéáóôÜóåéò ôçò Client Area êáé ôçí áðüóôáóç ôçò áðü ôéò Üêñåò
	cxClient = WorkspaceWidth()
	cyClient = WorkspaceHeight() - mdi_1.microhelpheight	// microhelp included in WorkspaceHeight()
	xClient = WorkspaceX()
	yClient = WorkspaceY()
	
// ÁëëÜæïõìå ôï ýøïò ôïõ tv êáé ôï îáíáôïðïèåôïýìå
	tv.Height = cyClient
	tv.move(xClient, yClient)
	
// Îáíáêáèïñßæïõìå ôéò äéáóôÜóåéò ôïõ áíôéêåéìÝíïõ mdi_1
	cxMDI = cxClient - tv.Width
	cyMDI = WorkspaceHeight() - mdi_1.microhelpheight
	mdi_1.move(xClient + tv.Width, yClient)
	mdi_1.Resize(cxMDI, cyMDI)
end event

public subroutine if_inittv ();// initialize treeview control
	long	lev_misth, lev_katast, & 
			lev_tables, lev_prints, & 
			lev_xrisi, lev_tools, lev_transfer
			
	treeviewitem	item

// Ìéóèïäïóßá
	lev_misth = tv.InsertItemfirst(0, trn(448), 1)
	item.label = trn(337)
	item.data = "misth_ypal"
	item.PictureIndex = 2
	item.SelectedPictureIndex = 2
	tv.InsertItemLast(lev_misth, item)
	
	lev_katast = tv.InsertItemLast(lev_misth, trn(389), 3)
	item.label = trn(602)
	item.data = "misth_final_total"
	item.PictureIndex = 3
	item.SelectedPictureIndex = 3
	tv.InsertItemFirst(lev_katast, item)
	
	item.label = trn(76)
	item.data = "misth_final_details"
	item.PictureIndex = 3
	item.SelectedPictureIndex = 3
	tv.InsertItemLast(lev_katast, item)

	item.label = trn(94)
	item.data = "misth_kratapod"
	item.PictureIndex = 4
	item.SelectedPictureIndex = 4
	tv.InsertItemLast(lev_misth, item)

	item.label = trn(678)
	item.data = "misth_fylo"
	item.PictureIndex = 5
	item.SelectedPictureIndex = 5
	tv.InsertItemLast(lev_misth, item)
	
	item.label = trn(623)
	item.data = "misth_report"
	item.PictureIndex = 6
	item.SelectedPictureIndex = 6
	tv.InsertItemLast(lev_misth, item)

// Ðßíáêåò
	lev_tables = tv.InsertItemLast(0, trn(534), 7)
	
	item.label = trn(590)
	item.data = "misth_zpstath"
	item.PictureIndex = 7
	item.SelectedPictureIndex = 7
	tv.InsertItemLast(lev_tables, item)

	item.label = trn(433)
	item.data = "misth_zpyvar"
	item.PictureIndex = 7
	item.SelectedPictureIndex = 7
	tv.InsertItemLast(lev_tables, item)

	item.label = trn(96)
	item.data = "misth_zpepidom"
	item.PictureIndex = 7
	item.SelectedPictureIndex = 7
	tv.InsertItemLast(lev_tables, item)

	item.label = trn(411)
	item.data = "misth_zpkrat"
	item.PictureIndex = 7
	item.SelectedPictureIndex = 7
	tv.InsertItemLast(lev_tables, item)
	
	item.label = trn(529)
	item.data = "misth_zpperiod"
	item.PictureIndex = 7
	item.SelectedPictureIndex = 7
	tv.InsertItemLast(lev_tables, item)

	item.label = trn(399)
	item.data = "misth_zpkat"
	item.PictureIndex = 7
	item.SelectedPictureIndex = 7
	tv.InsertItemLast(lev_tables, item)
	
	item.label = trn(118)
	item.data = "misth_zptamio"
	item.PictureIndex = 7
	item.SelectedPictureIndex = 7
	tv.InsertItemLast(lev_tables, item)

	item.label = trn(644)
	item.data = "misth_zptmima"
	item.PictureIndex = 7
	item.SelectedPictureIndex = 7
	tv.InsertItemLast(lev_tables, item)

	item.label = trn(250)
	item.data = "misth_zpidikot"
	item.PictureIndex = 7
	item.SelectedPictureIndex = 7
	tv.InsertItemLast(lev_tables, item)

	item.label = trn(376)
	item.data = "misth_zpthesi"
	item.PictureIndex = 7
	item.SelectedPictureIndex = 7
	tv.InsertItemLast(lev_tables, item)

	item.label = trn(475)
	item.data = "misth_zpoikog"
	item.PictureIndex = 7
	item.SelectedPictureIndex = 7
	tv.InsertItemLast(lev_tables, item)

	
// Åêôõðþóåéò
	lev_prints = tv.InsertItemLast(0, trn(270), 8)
	
	item.label = trn(541)
	item.data = "misth_print_1"
	item.PictureIndex = 8
	item.SelectedPictureIndex = 8
	tv.InsertItemLast(lev_prints, item)
	
	item.label = trn(86)
	item.data = "misth_print_2"
	item.PictureIndex = 8
	item.SelectedPictureIndex = 8
	tv.InsertItemLast(lev_prints, item)

	item.label = trn(85)
	item.data = "misth_print_3"
	item.PictureIndex = 8
	item.SelectedPictureIndex = 8
	tv.InsertItemLast(lev_prints, item)

	item.label = trn(606)
	item.data = "misth_print_4"
	item.PictureIndex = 8
	item.SelectedPictureIndex = 8
	tv.InsertItemLast(lev_prints, item)

	item.label = trn(634)
	item.data = "misth_print_5"
	item.PictureIndex = 8
	item.SelectedPictureIndex = 8
	tv.InsertItemLast(lev_prints, item)
	
	item.label = trn(613)
	item.data = "misth_print_6"
	item.PictureIndex = 8
	item.SelectedPictureIndex = 8
	tv.InsertItemLast(lev_prints, item)

	item.label = trn(415)
	item.data = "misth_print_7"
	item.PictureIndex = 8
	item.SelectedPictureIndex = 8
	tv.InsertItemLast(lev_prints, item)
	
	item.label = trn(61)
	item.data = "misth_print_8"
	item.PictureIndex = 8
	item.SelectedPictureIndex = 8
	tv.InsertItemLast(lev_prints, item)
	
// ×ñÞóåéò
	lev_xrisi = tv.InsertItemLast(0, trn(682), 9)
	
	item.label = trn(233)
	item.data = "misth_zpxrisi"
	item.PictureIndex = 9
	item.SelectedPictureIndex = 9
	tv.InsertItemLast(lev_xrisi, item)
	
	item.label = trn(502)
	item.data = "misth_param"
	item.PictureIndex = 10
	item.SelectedPictureIndex = 10
	tv.InsertItemLast(lev_xrisi, item)
	
	item.label = trn(66)
	item.data = "misth_chxrisi"
	item.PictureIndex = 11
	item.SelectedPictureIndex = 11
	tv.InsertItemLast(lev_xrisi, item)
		
	
// Åñãáëåßá
	lev_tools = tv.InsertItemLast(0, trn(340), 12)
	
	item.label = trn(82)
	item.data = "misth_backup"
	item.PictureIndex = 13
	item.SelectedPictureIndex = 13
	tv.InsertItemLast(lev_tools, item)

	item.label = trn(299)
	item.data = "misth_restore"
	item.PictureIndex = 14
	item.SelectedPictureIndex = 14
	tv.InsertItemLast(lev_tools, item)


	lev_transfer = tv.InsertItemLast(lev_tools, trn(443), 15)
	
	item.label = trn(589)
	item.data = "misth_transfer_stath"
	item.PictureIndex = 15
	item.SelectedPictureIndex = 15
	tv.InsertItemLast(lev_transfer, item)

	item.label = trn(84)
	item.data = "misth_transfer_nopaid"
	item.PictureIndex = 15
	item.SelectedPictureIndex = 15
	tv.InsertItemLast(lev_transfer, item)
	


// ÊñáôÜìå ôï ðëÜôïò ôïõ tv
	il_tvwidth = tv.width

end subroutine

on w_app.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_misth" then this.MenuID = create m_misth
this.tv=create tv
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv
end on

on w_app.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tv)
end on

event open;// Initialize tv
	if_inittv()

// Arange listbar
	this.TriggerEvent("ie_sizebar")
	
// ÐñïóáñìïãÞ ôßôëïõ
	this.title = gs_app_name + " - " + trn(683) + ": " + gs_descxrisi
	
end event

event resize;call super::resize;// Arange tv
	this.TriggerEvent("ie_sizebar")
end event

type tv from treeview within w_app
integer width = 978
integer height = 1528
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean hideselection = false
boolean fullrowselect = true
string picturename[] = {"res\app.ico","res\ypal.ico","res\final.ico","res\kratapod.ico","res\fylo.ico","res\report.ico","res\pinakes.ico","res\print.ico","res\xrisi.ico","res\param.ico","res\cxrisi.ico","res\Tools7.ico","res\backup.ico","res\restore.ico","res\transfer.ico"}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event doubleclicked;// Ðáßñíïõìå ôï data ôïõ handle

	treeviewitem	item
	string			ls_data
	
	this.getitem(handle, item)
	ls_data = string(item.data)
	
	choose case ls_data
			
		// Ìéóèïäïóßá
		
		case "misth_ypal"
			if not fn_perm("misth_ypal", "openlist") then return
			OpenSheet(w_misth_ypal_list, w_app, 0, Original!)
	
		case "misth_final_total"
			if not fn_perm("misth_final", "openlist") then return
			OpenSheet(w_misth_final_list, w_app, 0, Original!)		

		case "misth_final_details"
			if not fn_perm("misth_final", "openlist") then return
			OpenSheet(w_misth_final_details_list, w_app, 0, Original!)		

		case "misth_kratapod"
			if not fn_perm("misth_kratapod", "openlist") then return
			OpenSheet(w_misth_kratapod_list, w_app, 0, Original!)		
	
		case "misth_fylo"
			if not fn_perm("misth_fylo", "openlist") then return
			OpenSheet(w_misth_fylo_list, w_app, 0, Original!)
			
		case "misth_report"
			if not fn_perm("misth_report", "openlist") then return
			OpenSheet(w_misth_report_list, w_app, 0, Original!)
	
		// Ðßíáêåò
		
		case "misth_zpstath"
			if not fn_perm("misth_zpstath", "openlist") then return
			OpenSheet(w_misth_zpstath_grid, w_app, 0, Original!)
			
		case "misth_zpyvar"
			if not fn_perm("misth_zpyvar", "openlist") then return
			OpenSheet(w_misth_zpyvar_list, w_app, 0, Original!)

		case "misth_zpepidom"
			if not fn_perm("misth_zpepidom", "openlist") then return
			OpenSheet(w_misth_zpepidom_list, w_app, 0, Original!)

		case "misth_zpkrat"
			if not fn_perm("misth_zpkrat", "openlist") then return
			OpenSheet(w_misth_zpkrat_list, w_app, 0, Original!)

		case "misth_zpperiod"
			if not fn_perm("misth_zpperiod", "openlist") then return
			OpenSheet(w_misth_zpperiod_grid, w_app, 0, Original!)

		case "misth_zpkat"
			if not fn_perm("misth_zpkat", "openlist") then return
			OpenSheet(w_misth_zpkat_grid, w_app, 0, Original!)

		case "misth_zptamio"
			if not fn_perm("misth_zptamio", "openlist") then return
			OpenSheet(w_misth_zptamio_grid, w_app, 0, Original!)

		case "misth_zptmima"
			if not fn_perm("misth_zptmima", "openlist") then return
			OpenSheet(w_misth_zptmima_grid, w_app, 0, Original!)

		case "misth_zpidikot"
			if not fn_perm("misth_zpidikot", "openlist") then return
			OpenSheet(w_misth_zpidikot_grid, w_app, 0, Original!)

		case "misth_zpthesi"
			if not fn_perm("misth_zpthesi", "openlist") then return
			OpenSheet(w_misth_zpthesi_grid, w_app, 0, Original!)

		case "misth_zpoikog"
			if not fn_perm("misth_zpoikog", "openlist") then return
			OpenSheet(w_misth_zpoikog_grid, w_app, 0, Original!)

		// Åêôõðþóåéò
		
		case "misth_print_1"
			if not fn_perm("misth_final", "openlist") then return
			OpenSheet(wprn_ypal_final, w_app, 0, Original!)

		case "misth_print_2"
			if not fn_perm("misth_final", "openlist") then return
			OpenSheet(wprn_final_nopaid_ana_katast, w_app, 0, Original!)

		case "misth_print_3"		
			if not fn_perm("misth_final", "openlist") then return
			OpenSheet(wprn_final_nopaid_ana_ypal, w_app, 0, Original!)

		case "misth_print_4"	
			if not fn_perm("misth_final", "openlist") then return
			OpenSheet(wprn_ypal_total_dates, w_app, 0, Original!)

		case "misth_print_5"		
			if not fn_perm("misth_final", "openlist") then return
			OpenSheet(wprn_analisi_ypal, w_app, 0, Original!)

		case "misth_print_6"	
			if not fn_perm("misth_final", "openlist") then return
			OpenSheet(wprn_krat_total, w_app, 0, Original!)

		case "misth_print_7"	
			if not fn_perm("misth_final", "openlist") then return
			OpenSheet(wprn_krat_noapod, w_app, 0, Original!)

		case "misth_print_8"	
			if not fn_perm("misth_ypal", "openlist") then return
			OpenSheet(wprn_ypal_newklimakio, w_app, 0, Original!)

		// ×ñÞóåéò
			
		case "misth_zpxrisi"
			if not fn_perm("misth_zpxrisi", "openlist") then return
			OpenSheet(w_misth_zpxrisi_list, w_app, 0, Original!)
		
		case "misth_param"
			if not fn_perm("misth_zpxrisi", "openlist") then return
			Open(w_misth_zpxrisi_param)
			
		case "misth_chxrisi"
			fn_changexrisi()		
	
		// Åñãáëåßá
		
		case "misth_backup"
			open(w_mysql_backup)	
			
		case "misth_restore"
			open(w_mysql_restore)
			
		case "misth_transfer_stath"
			open(w_transfer_xrisi)
	
		case "misth_transfer_nopaid"	
			open(w_transfer_nopaid)
				
	end choose
end event

