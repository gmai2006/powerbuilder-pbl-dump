HA$PBExportHeader$openpay.sra
$PBExportComments$
forward
global type openpay from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
// application & version
	string	gs_lockfile				// Ìõóôéêü áñ÷åßï óôï system
	String 	gs_ini_File
	string	gs_serialnumber		// âñßóêåôáé óôï printer.cfg
	string	gs_app_name
	string	gs_version_number
	string	gs_version_date
	string	gs_copyright, gs_copyright_year
	string	gs_company_address
	string	gs_creator
	string	gs_dbver_req			// database version that required
	
// database specific	
	string	gs_host
	string	gs_database
	string	gs_dsn
	string	gs_defuser
	string	gs_password
	string	gs_dbver	


// ×ñÞóç
	sc_misth_zpxrisi	gsc_misth_zpxrisi
	string				gs_kodxrisi
	string				gs_descxrisi
	date					gd_startdate
	date					gd_enddate

// afxUsers
	long						gl_koduser
	string					gs_username
	sc_usrUsers				gsc_usrUsers
	sc_usrGroups			gsc_usrGroups
	sc_usrMembers			gsc_usrMembers
	boolean					gb_useperm
	string					gs_kodapp		// Ôï åßäïò ôçò åöáñìïãÞò (áðü afxApps)
	
// popups
	m_popups	gpop
	
// dhmot variables
	string					gs_koddhmos		// Ï êùäéêüò ôïõ äÞìïõ áðü param_genika

// structures
	sc_misth_ypal			gsc_misth_ypal
	sc_misth_zpepidom		gsc_misth_zpepidom
	sc_misth_zpyvar		gsc_misth_zpyvar
	sc_misth_zpkrat		gsc_misth_zpkrat
	sc_misth_fylo			gsc_misth_fylo
	sc_misth_final			gsc_misth_final
	sc_misth_final_ypal	gsc_misth_final_ypal
	sc_misth_report		gsc_misth_report
	sc_misth_kratapod		gsc_misth_kratapod
	
	
// global helpers
	string				gstring
	date					gdate1, gdate2
	
	string				gs_country

end variables

global type openpay from application
string appname = "openpay"
string toolbarframetitle = "openpay"
string toolbarsheettitle = "openpay"
end type
global openpay openpay

type prototypes
	Function double	  cfn_mathparser(string	as_expr) &
							  Library "mathparser.dll" Alias for "cfn_mathparserA"

end prototypes

on openpay.create
appname="openpay"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on openpay.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;// Global Application variables

	gs_ini_file = GetCurrentDirectory() + "\openpay.ini"
	gs_app_name = "Openpay" 
	gs_version_number = "0.1.1b"
	gs_dbver_req = "0.1.1"
	gs_version_date = "22/12/2005"
	gs_copyright_year = "2005-2006"
	gs_serialnumber = "GPL"


// database specific
	gs_host = ProfileString(gs_ini_file, "DATABASE", "host", "localhost")
	gs_database = ProfileString(gs_ini_file, "DATABASE", "database", "")
	gs_dsn = ProfileString(gs_ini_file, "DATABASE", "dsn", "")
	gs_defuser = ProfileString(gs_ini_file, "DATABASE", "defuser", "root")
	gs_password = ProfileString(gs_ini_file, "DATABASE", "password", "")
	

// Profile 
	SQLCA.DBMS = "ODBC"
	SQLCA.AutoCommit = true
	sqlca.dbParm = "ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT', ConnectString='" + &
						"DSN=" + gs_dsn + ";" + &
						"UID=" + gs_defuser + ";" + &
						"PWD=" + gs_password + ";" + &
						"option=4611',OJSyntax='ANSI'"
 						 
	CONNECT USING SQLCA;
	if not fn_sqlerror() then halt close
	
// Get database version
	SELECT dbver into :gs_dbver
	FROM   afxinfo;
	
// Use permissions = no
	gb_useperm = false
	gs_kodapp = "openpay"		
	
// Global popups - destroy into close() event of application
	gpop = create m_popups
	
// Country selection
	gs_country = "uk"
	

// Post connection initialization
	gs_copyright = "'" + trn(655) + "'"
	gs_company_address = trn(588)
	gs_creator = trn(655)

	this.MicroHelpDefault = gs_app_name + " " + &
									trn(267) + " " + gs_version_number + " (" + gs_version_date + "), " + &
									trn(237) + " " + gs_copyright_year + " - " + gs_copyright


// Choose season
	Open(w_getxrisi)	
	if Message.DoubleParm <> 1 then halt close

	

// Open application main window
	open(w_app)	
	

// Check fro employee promotions
	fn_check_newklimakio()

end event

event close;// destroy gpop
	if isvalid(gpop) then destroy gpop

DISCONNECT USING SQLCA; 
end event

