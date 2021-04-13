HA$PBExportHeader$w_savefilter.srw
$PBExportComments$
forward
global type w_savefilter from w_singleform
end type
type dw_filtername from datawindow within w_savefilter
end type
end forward

global type w_savefilter from w_singleform
integer width = 1490
integer height = 1396
dw_filtername dw_filtername
end type
global w_savefilter w_savefilter

type variables
w_filter		iw_filter
end variables

forward prototypes
public subroutine of_retrieve ()
public subroutine of_open ()
end prototypes

public subroutine of_retrieve ();dw_main.retrieve(iw_filter.is_tablename)
end subroutine

public subroutine of_open ();iw_filter = Message.PowerObjectParm

dw_filtername.Insertrow(0)
dw_filtername.Setfocus()
end subroutine

on w_savefilter.create
int iCurrent
call super::create
this.dw_filtername=create dw_filtername
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filtername
end on

on w_savefilter.destroy
call super::destroy
destroy(this.dw_filtername)
end on

event open;call super::open;// translation
	title = trn(101)
end event

type cb_cancel from w_singleform`cb_cancel within w_savefilter
integer x = 1125
integer y = 1148
end type

type cb_ok from w_singleform`cb_ok within w_savefilter
integer x = 768
integer y = 1148
end type

event cb_ok::clicked;dw_filtername.AcceptText()

// ÅëÝã÷ïò áí äþóáìå üíïìá ößëôñïõ
	string	ls_filtername
	ls_filtername = dw_filtername.object.filtername[1]
	if isnull(ls_filtername) or ls_filtername = "" then
		Messagebox(trn(101), trn(163))
		dw_filtername.Setfocus()
		return
	end if
	
// ¸ëåã÷ïò áí ôï üíïìá ôïõ ößëôñïõ õðÜñ÷åé
	long		ll_count
	integer	li_ret
	select count(kodfilter) into :ll_count from afxfilter
	where descfilter = :ls_filtername;
	fn_sqlerror()
	if ll_count > 0 then
		li_ret = MessageBox(trn(101), trn(645) + ".~n" + trn(374), Exclamation!, OKCancel!, 2)
		if li_ret = 2 then 
			dw_filtername.Setfocus()
			dw_filtername.SetColumn("filtername")
			return
		else
			// ÄéáãñáöÞ ößëôñïõ
				delete from afxfilter where descfilter = :ls_filtername;
				commit using sqlca;
		end if
	end if

// ÅéóáãùãÞ ôïõ ößëôñïõ óôïí afxfilter
	long		ll_kodfilter
	ll_kodfilter = fn_getkey("afxfilter")
	
	INSERT INTO afxfilter(kodfilter, descfilter, tablename)
	VALUES (:ll_kodfilter, :ls_filtername, :iw_filter.is_tablename);

// ÅéóáãùãÞ ôùí êñéôçñßùí óôïí afxFilterD
// (¼ëåò ïé ãñáììÝò ôïõ iw_filter.idw_filter åêôþò áðü ôçí ôåëåõôáßá (íÝá))
	long	ll_rows, i, ll_kodfilterd
	string	ls_pedio, ls_telestis, ls_timi, ls_join
	ll_rows = iw_filter.idw_filter.rowcount()
	
	for i = 1 to ll_rows - 1
		ls_pedio = iw_filter.idw_filter.object.field[i]
		ls_telestis = iw_filter.idw_filter.object.operator[i]
		ls_timi = iw_filter.idw_filter.object.value[i]
		ls_join = trim(iw_filter.idw_filter.object.join[i])
		ll_kodfilterD = fn_getkey("afxfilterd")
		
		INSERT INTO afxfilterd(kodfilterd, kodfilter, pedio, telestis, timi, joint)
		VALUES (:ll_kodfilterd, :ll_kodfilter, :ls_pedio, :ls_telestis, :ls_timi, :ls_join);
		fn_sqlerror()
	next
	
// commit work and close
	COMMIT USING SQLCA;
	close(getparent())

end event

type dw_main from w_singleform`dw_main within w_savefilter
string dataobject = "dw_afxfilter_list"
end type

event dw_main::clicked;call super::clicked;this.Selectrow(0, false)
this.selectrow(row, true)

dw_filtername.object.filtername[1] = this.object.descfilter[row]
end event

type dw_filtername from datawindow within w_savefilter
integer x = 27
integer y = 944
integer width = 1408
integer height = 176
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "edw_filtername"
boolean border = false
boolean livescroll = true
end type

