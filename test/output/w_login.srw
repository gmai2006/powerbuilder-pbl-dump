HA$PBExportHeader$w_login.srw
$PBExportComments$
forward
global type w_login from window
end type
type st_version from statictext within w_login
end type
type st_app from statictext within w_login
end type
type cb_cancel from commandbutton within w_login
end type
type cb_ok from commandbutton within w_login
end type
type p_1 from picture within w_login
end type
type st_2 from statictext within w_login
end type
type st_1 from statictext within w_login
end type
type sle_password from singlelineedit within w_login
end type
type sle_user from singlelineedit within w_login
end type
type gb_1 from groupbox within w_login
end type
end forward

global type w_login from window
integer width = 1765
integer height = 816
boolean titlebar = true
string title = "login"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_version st_version
st_app st_app
cb_cancel cb_cancel
cb_ok cb_ok
p_1 p_1
st_2 st_2
st_1 st_1
sle_password sle_password
sle_user sle_user
gb_1 gb_1
end type
global w_login w_login

type variables
string	is_user, is_pass
end variables

forward prototypes
protected function boolean if_checkusername (string as_username)
protected function boolean if_checkinput (string as_username, string as_password)
protected function boolean if_checkuseractive (string as_username)
protected function boolean if_checkpassword (string as_username, string as_password)
protected function boolean if_checkapp (string as_username, string as_kodapp)
end prototypes

protected function boolean if_checkusername (string as_username);// ¸ëåã÷ïò áí õðÜñ÷åé ôï as_username óôç âÜóç

	long	ll_koduser
	setnull(ll_koduser)
	
	select koduser into :ll_koduser from usrusers
	where  username = :as_username;
	fn_sqlerror()
	
	if isnull(ll_koduser) then
	  	MessageBox(trn(102), trn(356) + " " + &
					 trn(279), Exclamation!)
	  	sle_user.setfocus()
	  	return false
	else
		return true
	end if	
end function

protected function boolean if_checkinput (string as_username, string as_password);// ¸ëåã÷ïò áí äþóáìå username êáé password
	if isnull(as_username) or as_username = "" or &
		isnull(as_password) or as_password = "" then
			MessageBox(trn(102), trn(356) + " " + &
				 trn(279), Exclamation!)
			sle_user.setfocus()
			return false
	else
		return true
	end if		

end function

protected function boolean if_checkuseractive (string as_username);// Áí ôï username õðÜñ÷åé Ýëåã÷ïò áí åßíáé active
	boolean	lb_isactive
	
	select isactive into :lb_isactive
	from usrusers where username = :as_username;
	fn_sqlerror()
	
	if (not lb_isactive) then 
	  	MessageBox(trn(102), trn(135), Exclamation!)
	  	sle_user.setfocus()
	  	return false
	else
		return true
	end if
end function

protected function boolean if_checkpassword (string as_username, string as_password);// ¸ëåã÷ïò ôïõ êùäéêïý ðñüóâáóçò óôç âÜóç
	string	ls_dbpassword
	
	select password into :ls_dbpassword	from usrusers
	where username = :as_username;
	fn_sqlerror()
	
	if as_password <> ls_dbpassword then 
	  	MessageBox(trn(102), trn(356) + " " + &
					 trn(279), Exclamation!)
	  	sle_user.setfocus()
	  	return false
	else
		return true
	end if
end function

protected function boolean if_checkapp (string as_username, string as_kodapp);// ÅëÝã÷ïõìå áí ï ÷ñÞóôçò Ý÷åé äéêáßùìá ðñüóâáóçò
// óôçí ôñÝ÷ïõóá åöáñìïãÞ (gs_kodapp)
	long		ll_koduser
	integer	li_flag
	
// Ï ÷ñÞóôçò ìå koduser = -1 (master)
// Ý÷åé ðÜíôá äéêáßùìá ðñüóâáóçò	
	setnull(ll_koduser)
	select koduser into :ll_koduser from usrusers
	where	 username = :as_username;
	fn_sqlerror()
	if ll_koduser = -1 then return true
	
	
// Ãéá ôïõò Üëëïõò ÷ñÞóôåò Ýëåã÷ïò ôïõ ðßíáêá usrUserPerm
	integer	li_enable
	
	select enable into :li_enable
	from	 usruserperm
	where	 koduser = :ll_koduser
	and	 kodapp = :as_kodapp;
	fn_sqlerror()
	
	if isnull(li_enable) or li_enable = 0 then
		MessageBox(trn(102), tr("Áõôüò ï ÷ñÞóôçò äåí Ý÷åé äéêáßùìá ðñüóâáóçò ó' áõôÞ ôçí åöáñìïãÞ"), Exclamation!)
		sle_user.setfocus()
		return false
	else
		return true
	end if	
			

end function

on w_login.create
this.st_version=create st_version
this.st_app=create st_app
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.p_1=create p_1
this.st_2=create st_2
this.st_1=create st_1
this.sle_password=create sle_password
this.sle_user=create sle_user
this.gb_1=create gb_1
this.Control[]={this.st_version,&
this.st_app,&
this.cb_cancel,&
this.cb_ok,&
this.p_1,&
this.st_2,&
this.st_1,&
this.sle_password,&
this.sle_user,&
this.gb_1}
end on

on w_login.destroy
destroy(this.st_version)
destroy(this.st_app)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_password)
destroy(this.sle_user)
destroy(this.gb_1)
end on

event open;// ÅíçìÝñùóç ðåäßùí
	st_app.text = gs_app_name
	st_version.text = trn(267) + ": " + gs_version_number

// Add default login to descenant (if we want)
	//sle_user.text = is_user
	//sle_password.text = is_pass

// Translation
	title = trn(610)
	cb_cancel.text = trn(2)
	cb_ok.text = trn(699)
	st_2.text = trn(419) + ":"
	st_1.text = trn(685) + ":"
	
end event

type st_version from statictext within w_login
integer x = 686
integer y = 144
integer width = 997
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 16711680
long backcolor = 67108864
string text = "Version"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_app from statictext within w_login
integer x = 686
integer y = 52
integer width = 997
integer height = 64
integer textsize = -11
integer weight = 700
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
long backcolor = 67108864
string text = "Application"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_login
integer x = 1362
integer y = 560
integer width = 343
integer height = 104
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "Cancel"
boolean cancel = true
end type

event clicked;// ¸îïäïò áðü ôçí åöáñìïãÞ
	HALT CLOSE
end event

type cb_ok from commandbutton within w_login
integer x = 658
integer y = 560
integer width = 343
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
string text = "OK"
boolean default = true
end type

event clicked;// Ðáßñíïõìå ôá óôïé÷åßá ðïõ ðëçêôñïëïãÞóáìå
	string	ls_username, &
				ls_password
				
	ls_username = sle_user.text
	ls_password = sle_password.text
	
// ¸ëåã÷ïé
	if not if_checkinput(ls_username, ls_password) then return
	if not if_checkusername(ls_username) then return
	if not if_checkuseractive(ls_username) then return
	if not if_checkpassword(ls_username, ls_password) then return
	if not if_checkapp(ls_username, gs_kodapp) then return

// Ðñüóâáóç åðéôñÝðåôáé. ÁðïèÞêåõóç óôéò êáèïëéêÝò
	gs_username = ls_username
	select koduser into :gl_koduser from usrusers where username = :ls_username;
	
	closewithreturn(getparent(), 1)

end event

type p_1 from picture within w_login
integer x = 18
integer y = 24
integer width = 590
integer height = 640
string picturename = "D:\projects\share\res\ÕÐÏÓÔÇÑÉÎÇ.WMF"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_login
integer x = 658
integer y = 428
integer width = 315
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_1 from statictext within w_login
integer x = 658
integer y = 292
integer width = 315
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_login
integer x = 1010
integer y = 420
integer width = 695
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
boolean password = true
end type

type sle_user from singlelineedit within w_login
integer x = 1010
integer y = 284
integer width = 695
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
end type

type gb_1 from groupbox within w_login
integer x = 658
integer width = 1051
integer height = 232
integer textsize = -10
integer weight = 700
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 33554432
long backcolor = 67108864
end type

