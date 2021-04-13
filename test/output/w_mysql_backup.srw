HA$PBExportHeader$w_mysql_backup.srw
$PBExportComments$
forward
global type w_mysql_backup from w_response
end type
type dw from datawindow within w_mysql_backup
end type
type gb_1 from groupbox within w_mysql_backup
end type
end forward

global type w_mysql_backup from w_response
integer width = 2418
integer height = 912
string title = "Backup"
string icon = "res\Backup.ico"
dw dw
gb_1 gb_1
end type
global w_mysql_backup w_mysql_backup

forward prototypes
public function boolean if_check4required ()
public function integer if_backup ()
end prototypes

public function boolean if_check4required ();// ¸ëåã÷ïò áí äþóáìå üëá ôá óôïé÷åßá

string	lstring	

dw.accepttext()

// mysqlbin
	lstring = dw.object.mysqlbin[1]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(186))
		dw.setfocus()
		dw.setcolumn("mysqlbin")
		return false
	end if
	
// host
	lstring = dw.object.host[1]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(187))
		dw.setfocus()
		dw.setcolumn("host")
		return false
	end if

// database
	lstring = dw.object.database[1]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(159))
		dw.setfocus()
		dw.setcolumn("database")
		return false
	end if

// backupfolder
	lstring = dw.object.backupfolder[1]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(192))
		dw.setfocus()
		dw.setcolumn("backupfolder")
		return false
	end if
	
// backupfile
	lstring = dw.object.backupfile[1]
	if isnull(lstring) or lstring = "" then
		Messagebox(gs_app_name, trn(158))
		dw.setfocus()
		dw.setcolumn("backupfile")
		return false
	end if	



return true
end function

public function integer if_backup ();// backup

	integer	li_ret
	string	ls_host
	string	ls_backupfile
	string	ls_backuptool
	string	ls_database
	
	ls_host = dw.object.host[1]
	ls_backupfile = dw.object.backupfolder[1] + "\" + dw.object.backupfile[1]
	ls_backuptool = dw.object.mysqlbin[1] + "\mysqldump.exe"
	ls_database = dw.object.database[1]
	
	// create backup.bat file
		integer	li_file
		string	ls_tempfile
		
		ls_tempfile = "backup.bat"
		
		li_file = FileOpen(ls_tempfile, LineMode!, Write!, LockWrite!, Replace!)
		
		FileWrite(li_file, "@echo off")
		FileWrite(li_file, "echo SET FOREIGN_KEY_CHECKS=0; > " + ls_backupfile) 
		FileWrite(li_file, "echo DROP DATABASE IF EXISTS " + ls_database + "; >> " + ls_backupfile)
		//FileWrite(li_file, "echo CREATE DATABASE `" + ls_database + "`; >> " + ls_backupfile)
		FileWrite(li_file, "echo USE " + ls_database + "; >> " + ls_backupfile)
		FileWrite(li_file, ls_backuptool + " -v -h" + gs_host + " -u" + gs_defuser + " -p" + gs_password + " " + gs_database + " >> " + ls_backupfile)
	
		FileClose(li_file)
	
	// execute backup 
		li_ret = run(ls_tempfile)
		
		return li_ret

end function

on w_mysql_backup.create
int iCurrent
call super::create
this.dw=create dw
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw
this.Control[iCurrent+2]=this.gb_1
end on

on w_mysql_backup.destroy
call super::destroy
destroy(this.dw)
destroy(this.gb_1)
end on

event open;call super::open;// init dw
	dw.Insertrow(0)
	dw.setfocus()
	
// read ini
	string	ls_mysqlbin
	string	ls_host
	string	ls_database
	string	ls_backupfolder
	
	ls_mysqlbin = ProfileString(gs_ini_file, "BACKUP", "mysqlbin", "")
	ls_host = ProfileString(gs_ini_file, "DATABASE", "host", "")
	ls_database = ProfileString(gs_ini_file, "DATABASE", "database", "")
	ls_backupfolder = ProfileString(gs_ini_file, "BACKUP", "backupfolder", "")
	
	dw.object.mysqlbin[1] = ls_mysqlbin	
	dw.object.host[1] = ls_host
	dw.object.database[1] = ls_database
	dw.object.backupfolder[1] = ls_backupfolder
	
// Generate new backup filename (based on database and current date)
	string	ls_backupfile
	
	ls_backupfile = gs_database + "-" + fn_replace_str(string(today()), "/", "-") + ".sql"
	
	dw.object.backupfile[1] = ls_backupfile
	
// Translation
	title = trn(82)
end event

type cb_cancel from w_response`cb_cancel within w_mysql_backup
integer x = 2062
integer y = 676
end type

type cb_ok from w_response`cb_ok within w_mysql_backup
integer x = 1705
integer y = 676
end type

event cb_ok::clicked;// Check for required
	if not if_check4required() then return

// Buckup
	if if_backup()  <> 1 then return
	
// Store to ini
	string	ls_mysqlbin
	string	ls_host
	string	ls_database
	string	ls_backupfolder
	
	ls_mysqlbin	= dw.object.mysqlbin[1]
	ls_host = dw.object.host[1]
	ls_database = dw.object.database[1]
	ls_backupfolder = dw.object.backupfolder[1]

	SetProfileString (gs_ini_file, "BACKUP", "mysqlbin", ls_mysqlbin )
	SetProfileString (gs_ini_file, "BACKUP", "backupfolder", ls_backupfolder )

// return
	CloseWithReturn(GetParent(), 1)
end event

type dw from datawindow within w_mysql_backup
integer x = 55
integer y = 76
integer width = 2299
integer height = 524
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_mysql_backup"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;string ls_path 
integer li_ret

choose case dwo.name
		
	case "b_binfolder"
		ls_path = this.object.mysqlbin[1]
		li_ret = GetFolder( trn(669), ls_path )

		if li_ret = 1 then 
			dw.object.mysqlbin[1] = ls_path
			dw.setcolumn("mysqlbin")
		end if
		
	case "b_backupfolder"
		ls_path = this.object.backupfolder[1]
		li_ret = GetFolder( trn(667), ls_path )

		if li_ret = 1 then 
			dw.object.backupfolder[1] = ls_path
			dw.setcolumn("backupfolder")
		end if
		
		
end choose
end event

type gb_1 from groupbox within w_mysql_backup
integer x = 27
integer y = 12
integer width = 2350
integer height = 616
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 33554432
long backcolor = 67108864
end type

