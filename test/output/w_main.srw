HA$PBExportHeader$w_main.srw
$PBExportComments$
forward
global type w_main from window
end type
type mdi_1 from mdiclient within w_main
end type
end forward

global type w_main from window
integer width = 3081
integer height = 2352
boolean titlebar = true
string menuname = "m_main"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ie_closequery pbm_closequery
event ie_exit ( )
event me_updatexrisi ( )
mdi_1 mdi_1
end type
global w_main w_main

type variables

end variables

event ie_closequery;// ÅðáëÞèåõóç åîüäïõ áðü ôçí åöáñìïãÞ
// (¼ëá ôá ðáñÜèõñá åöáñìïãþí inherited from w_main
	int	nRet
	nRet = MessageBox(trn(297), trn(375), Exclamation!, OKCancel!, 2)
	if nRet = 2 then
		return 1
	else
		return 0
	end if
end event

event ie_exit;close(this)
end event

event me_updatexrisi();// ÁíáíÝùóç Üäåéáò ÷ñÞóçò

/*
	uo_lock aLock
	aLock = create uo_lock
	aLock.OpenFile("printer.cfg")
	
	if not aLock.GetKey() then 
		destroy(aLock)
		return
	end if

	destroy(aLock)

*/
end event

on w_main.create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_main
long BackColor=268435456
end type

