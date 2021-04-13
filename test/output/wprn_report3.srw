HA$PBExportHeader$wprn_report3.srw
$PBExportComments$
forward
global type wprn_report3 from w_print_args_noform
end type
end forward

global type wprn_report3 from w_print_args_noform
integer width = 3273
integer height = 1956
string title = "title"
end type
global wprn_report3 wprn_report3

type variables
long			il_kodfinal
string		is_kodreport
end variables

forward prototypes
public subroutine if_create ()
public subroutine if_addcol (ref datawindow adw, integer ai_kodcol, ref integer ai_x, integer ai_header_y, integer ai_data_y)
public subroutine of_open ()
public subroutine of_retrieve ()
public subroutine if_add_header (ref datawindow adw, sc_col asc_col, integer ai_x, integer ai_y, integer ai_height)
public subroutine if_add_data (ref datawindow adw, sc_col asc_col, integer ai_x, integer ai_y, integer ai_height)
public subroutine if_add_sum (ref datawindow adw, sc_col asc_col, integer ai_x, integer ai_y, integer ai_height)
public subroutine if_modify_page (ref datawindow adw)
public subroutine if_modify_existed (ref datawindow adw, integer ai_x)
end prototypes

public subroutine if_create ();// Create the custom columns
// (There are into misth_report_cols)

dw.setredraw(false)

// Äçìéïõñãßá datastore ãéá íá ðÜñïõìå üëåò ôéò óôÞëåò
// ôçò áíáöïñÜò il_kodreport
	datastore	lds_cols
	string		ls_sql
	long			ll_ncols

	
	ls_sql = "select * from misth_report_cols" + &
				" where kodreport = '" + is_kodreport + "'" + &
				" and kodxrisi = '" + gs_kodxrisi + "'" + &
				" order by aa"
				
	lds_cols = fn_createds_fromsql(ls_sql)
	ll_ncols = lds_cols.retrieve()
	
// ÐñïóèÞêç header, data, sum
	long		i
	integer	li_kodcol
	integer	li_data_x, li_data_y, li_data_width, li_data_height, &
				li_header_y, li_header_height, &
				li_sum_y, li_sum_height, &
				li_x
				
	sc_col	lsc_col
				
	
	// Ðáßñíïõìå ôï ôéò ôñÝ÷ïõóåò ôéìÝò position
	// ãéá íá õðïëïãßóïõìå áðü ðïõ áñ÷ßæïõí ôá cols
		li_data_x = integer(dw.object.cm_fullname.x)
		li_data_y = integer(dw.object.cm_fullname.y)
		li_data_width = integer(dw.object.cm_fullname.width)
		li_data_height = integer(dw.object.cm_fullname.height)
		
		lsc_col.data_alignment = 1
		lsc_col.data_color = long(dw.object.cm_fullname.color)
		lsc_col.data_border = integer(dw.object.cm_fullname.border)
		lsc_col.data_font_face = dw.object.cm_fullname.font.face
		lsc_col.data_font_height = integer(dw.object.cm_fullname.font.height)
		lsc_col.data_font_weight = integer(dw.object.cm_fullname.font.weight)
		lsc_col.data_font_italic = integer(dw.object.cm_fullname.font.italic)
		lsc_col.data_font_underline = integer(dw.object.cm_fullname.font.underline)
		lsc_col.data_background_mode = integer(dw.object.cm_fullname.background.mode)
		lsc_col.data_background_color = long(dw.object.cm_fullname.background.color)
		
		li_header_y = integer(dw.object.t_fullname.y)
		li_header_height = integer(dw.object.t_fullname.height)
		
		lsc_col.header_alignment = 1
		lsc_col.header_color = long(dw.object.t_fullname.color)
		lsc_col.header_border = integer(dw.object.t_fullname.border)
		lsc_col.header_font_face = dw.object.t_fullname.font.face
		lsc_col.header_font_height = integer(dw.object.t_fullname.font.height)
		lsc_col.header_font_weight = integer(dw.object.t_fullname.font.weight)
		lsc_col.header_font_italic = integer(dw.object.t_fullname.font.italic)
		lsc_col.header_font_underline = integer(dw.object.t_fullname.font.underline)
		lsc_col.header_background_mode = integer(dw.object.t_fullname.background.mode)
		lsc_col.header_background_color = long(dw.object.t_fullname.background.color)
		
		
		li_sum_y = integer(dw.object.t_sum.y)
		li_sum_height = integer(dw.object.t_sum.height)
	
	// Ðáßñíïõìå ôçí ïñéæüíôéá áðüóôáóç áðü ini
		integer	li_space
		
		li_space = ProfileInt(gs_ini_file, "REPORT", "space",0)
	
	// Yðïëïãßæïõìå ôï 'x' áðü üðïõ áñ÷ßæïõí ôá cols
		li_x = li_data_x + li_data_width
		
	
	for i = 1 to ll_ncols
		
		// Ðáßñíïõìå ôïí êùäéêü ôçò åðüìåíçò óôÞëçò
			li_kodcol = lds_cols.object.kodcol[i]
	
		// Ðáßñíïõìå ôá äåäïìÝíá ôçò óôÞëçò
			fn_loadcol(is_kodreport, li_kodcol, lsc_col)
		
		// ÐñïóèÝôïõìå ôçí ïñéæüíôéá áðüóôáóç
			li_x = li_x + li_space
		
		//	ÐñïóèÞêç header, data, sum
			if_add_header(dw, lsc_col, li_x, li_header_y, li_header_height)		
			if_add_data(dw, lsc_col, li_x, li_data_y, li_data_height)					
			if_add_sum(dw, lsc_col, li_x, li_sum_y, li_sum_height)
			
		// Åðüìåíï 'x'
			li_x = li_x + lsc_col.width
			
		// ÅðÝêôáóç ãñáììþí
			dw.object.line1.x2 = li_x
			dw.object.line2.x2 = li_x
			dw.object.line3.x2 = li_x
		
	next
	
// Modify print page
	if_modify_page(dw)
	
// Modify existed
	if_modify_existed(dw, li_x)
	
	
// clean-up
	destroy		lds_cols
	
dw.setredraw(true)
end subroutine

public subroutine if_addcol (ref datawindow adw, integer ai_kodcol, ref integer ai_x, integer ai_header_y, integer ai_data_y);// ÐñïóèÞêç óôÞëçò óôï adw
// Ï êùäéêüò óôÞëçò âñßóêåôáé óôï ads_cols.object.kodcol[row]
// 
/*
// Ðáßñíïõìå ôá äåäïìÝíá ôçò óôÞëçò
	sc_col		lsc_col
	fn_loadcol(is_kodreport, ai_kodcol, lsc_col)
	


// ÐñïóèÞêç header
	adw.Modify( &
	"create text(band=header"  +  &
		" color='" + string(lsc_col.header_color) + "'" + &
		" alignment='" + string(lsc_col.header_alignment) + "'" + &
		" border='" + string(lsc_col.header_border) + "'" +  &
		" x='" + string(ai_x) + "'" + &
		" y='" + string(ai_header_y) + "'" + &
		" width='" + string(lsc_col.header_width) + "'" + &
		" height='56'" + &
		" text='" + lsc_col.header_text + "'"  +  &
		" name=t_" + string(ai_kodcol) + &
		" font.face='" + lsc_col.header_font_face + "'" + &
		" font.height='" + string(lsc_col.header_font_height) + "'" + &
		" font.weight='" + string(lsc_col.header_font_weight) + "'" + &
		" font.family='2' font.pitch='0' font.charset='1'" + &
		" font.italic='" + string(lsc_col.header_font_italic) + "'" + &
		" font.underline='" + string(lsc_col.header_font_underline) + "'" + &
		" background.mode='" + string(lsc_col.header_background_mode) + "'" + &
		" background.color='" + string(lsc_col.header_background_color) + "')")

/*
// ÐñïóèÞêç data (computed field)
	adw.Modify( &
	"create compute(band=Detail"  +  &
		" color='" + string(lsc_col.data_color) + "'" + &
		" alignment='" + string(lsc_col.data_alignment) + "'" + &
		" border='" + string(lsc_col.data_border) + "'" +  &
		" height.autosize=No pointer='Arrow!' moveable=0 resizeable=0" + &
		" x='" + string(ai_x) + "'" + &
		" y='" + string(ai_data_y) + "'" + &
		" height='" + string(lsc_col.data_height) + "'" + &
		" width='" + string(lsc_col.data_width) + "'" + &
		" format='fn_param_maskposo()'" + &
		" name=d_" + string(ai_kodcol) + &
		" tag=''" + &
		" expression='fn_getfromfinal(" + string(il_kodfinal) + ", kodypal, ~'" + lsc_col.expr + "~')" + "'" + &
		" font.face=" + lsc_col.data_font_face + &
		" font.height='" + string(lsc_col.data_font_height) + "'" + &
		" font.weight='" + string(lsc_col.data_font_weight) + "'" + &
		" font.family=2 font.pitch='0' font.charset='1'" + &
		" font.italic='" + string(lsc_col.data_font_italic) + "'" + &
		" font.strikethrough='0'" + &
		" font.underline='" + string(lsc_col.data_font_underline) + "'" + &
		" background.mode='" + string(lsc_col.data_background_mode) + "'" + &
		" background.color='" + string(lsc_col.data_background_color) + "')")

// ÐñïóèÞêç summary (computed field)
	adw.Modify( &
	"create compute(band=Summary"  +  &
		" color='" + string(lsc_col.data_color) + "'" + &
		" alignment='" + string(lsc_col.data_alignment) + "'" + &
		" border='" + string(lsc_col.data_border) + "'" +  &
		" height.autosize=No pointer='Arrow!' moveable=0 resizeable=0" + &
		" x='" + string(ai_x) + "'" + &
		" y='" + string(ai_data_y) + "'" + &
		" height='" + string(lsc_col.data_height) + "'" + &
		" width='" + string(lsc_col.data_width) + "'" + &
		" format='fn_param_maskposo()'" + &
		" name=sum_" + string(ai_kodcol) + &
		" tag=''" + &
		" expression='sum(d_" + string(ai_kodcol) + ")'" + &
		" font.face=" + lsc_col.data_font_face + &
		" font.height='" + string(lsc_col.data_font_height) + "'" + &
		" font.weight='700'" + &
		" font.family=2 font.pitch='0' font.charset='1'" + &
		" font.italic='" + string(lsc_col.data_font_italic) + "'" + &
		" font.strikethrough='0'" + &
		" font.underline='" + string(lsc_col.data_font_underline) + "'" + &
		" background.mode='" + string(lsc_col.data_background_mode) + "'" + &
		" background.color='" + string(lsc_col.data_background_color) + "')")



// ÐñïóèÞêç header
	adw.Modify( &
	"create text(band=Header"  +  &
		" alignment='1'" + &
		" color='0'" +  &
		" border='0'" +  &
		" x='" + string(ai_x) + "'" + &
		" y='" + string(ai_header_y) + "'" + &
		" height='56'" + &
		" width='200'" + &
		" text='" + lsc_col.header_text + "'"  +  &
		" name=t_" + string(ai_kodcol) + &
		" tag=''" + &
		" font.face='Arial Greek'" + &
		" font.height='-8'" + &
		" font.weight='700'" + &
		" font.family='2' font.pitch='2' font.charset='161'" + &
		" background.mode='1'" + &
		" background.color='536870912')")
*/

string	ls_expresion
ls_expresion = 'fn_getfromfinal(' + string(il_kodfinal) + ', misth_report_ypal_kodypal, ' + '~"' + lsc_col.expr + '~")'

// ÐñïóèÞêç data (computed field)
	adw.Modify( &
	"create compute(band=detail"  +  &
		" color='0'" + &
		" alignment='1'" + &
		" border='0'" + &
		" x='" + string(ai_x) + "'" + &
		" y='" + string(ai_data_y) + "'" + &
		" height='56'" + &
		" width='200'" + &
		" name=d_" + string(ai_kodcol) + &
		" expression='" + ls_expresion + "'" + &
		" font.face='Arial Greek'" + &
		" font.height='56'" + &
		" font.weight='400'" + &
		" font.family='2' font.pitch='2' font.charset='161'" + &
		" font.strikethrough='0'" + &
		" background.mode='1'" + &
		" background.color='536870912'")
		
/*
		dw.Modify("create text(band=header alignment='1' text='" + ias_xreoseis[i] + "' " + &
					 "border='0' color='0' x='" + string(ll_current_x) + "' " + "y='" + string(ll_label_y) + "' " + &
					 "height='" + string(ll_label_height) + "' " + "width='" + string(ll_data_width) + "'" + &
					 "  name=t" + string(ial_xreoseis[i]) + &
					 " font.face='Arial Greek' font.height='-8' font.weight='700'  font.family='2' " + &
					 "font.pitch='2' font.charset='161' background.mode='1' background.color='536870912'" )
					 
		// data 
		dw.Modify("create compute(band=detail alignment='1' " + &
					 "expression='fn_getcost(" + string(il_catalog) + ", id_citizen, " + string(ial_xreoseis[i]) + ")' " + &
					 "border='0' " + "color='0' x='" + string(ll_current_x) + "' " + "y='" + string(ll_data_y) + "' " + &
					 "height='" + string(ll_data_height) + "' " + "width='" + string(ll_data_width) + "'" + &
					 " format='" + ls_drx_mask + "' "  + "name=c_" + string(i) + " " + &
					 "font.face='Arial Greek' font.height='-8' font.weight='400'  font.family='2' " + &
					 "font.pitch='2' font.charset='161' background.mode='1' background.color='536870912'" )
					 
	*/

// Äßíïõìå ôï åðüìåíï x
	ai_x = ai_x + lsc_col.data_width
*/


end subroutine

public subroutine of_open ();// Ðáßñíïõìå ôéò ìåôáâëçôÝò
	il_kodfinal = message.doubleparm
	is_kodreport = gstring

	
// Ðáßñíïõìå ôá äåäïìÝíá ôïõ is_kodreport
	string	ls_subtitle, ls_prn_notes1, ls_prn_notes2
	
	select 	subtitle, prn_notes1, prn_notes2
	into		:ls_subtitle, :ls_prn_notes1, :ls_prn_notes2
	from		misth_report
	where		kodreport = :is_kodreport and kodxrisi = :gs_kodxrisi;
	fn_sqlerror()
	
	dw.object.t_subtitle.text = trim(ls_subtitle)
	dw.object.t_notes1.text = trim(ls_prn_notes1)
	dw.object.t_notes2.text = trim(ls_prn_notes2)
	
// Modify datawindow
	if_create()
end subroutine

public subroutine of_retrieve ();dw.retrieve(string(il_kodfinal), gs_kodxrisi)
end subroutine

public subroutine if_add_header (ref datawindow adw, sc_col asc_col, integer ai_x, integer ai_y, integer ai_height);// ÐñïóèÞêç header

adw.Modify( &
	"create text(band=header"  +  &
		" color='" + string(asc_col.header_color) + "'" + &
		" alignment='" + string(asc_col.header_alignment) + "'" + &
		" border='" + string(asc_col.header_border) + "'" +  &
		" x='" + string(ai_x) + "'" + &
		" y='" + string(ai_y) + "'" + &
		" width='" + string(asc_col.width) + "'" + &
		" height='" + string(ai_height) + "'" + &
		" text='" + asc_col.header_text + "'"  +  &
		" name=t_" + string(asc_col.kodcol) + &
		" font.face='" + asc_col.header_font_face + "'" + &
		" font.height='" + string(asc_col.header_font_height) + "'" + &
		" font.weight='" + string(asc_col.header_font_weight) + "'" + &
		" font.family='2' font.pitch='0' font.charset='1'" + &
		" font.italic='" + string(asc_col.header_font_italic) + "'" + &
		" font.underline='" + string(asc_col.header_font_underline) + "'" + &
		" background.mode='" + string(asc_col.header_background_mode) + "'" + &
		" background.color='" + string(asc_col.header_background_color) + "')")


end subroutine

public subroutine if_add_data (ref datawindow adw, sc_col asc_col, integer ai_x, integer ai_y, integer ai_height);// ÐñïóèÞêç data

string	ls_expresion

ls_expresion = 'fn_getfromfinal(' + string(il_kodfinal) + ', misth_ypal_kodypal, ' + '~"' + asc_col.expr + '~")'



adw.Modify( &
	"create compute(band=Detail"  +  &
		" color='" + string(asc_col.data_color) + "'" + &
		" alignment='" + string(asc_col.data_alignment) + "'" + &
		" border='" + string(asc_col.data_border) + "'" +  &
		" x='" + string(ai_x) + "'" + &
		" y='" + string(ai_y) + "'" + &
		" height='" + string(ai_height) + "'" + &
		" width='" + string(asc_col.width) + "'" + &
		" format='~tfn_param_maskposo()'" + &
		" name=d_" + string(asc_col.kodcol) + &
		" expression='" + ls_expresion + "'" + &
		" font.face='" + asc_col.data_font_face + "'" + &
		" font.height='" + string(asc_col.data_font_height) + "'" + &
		" font.weight='" + string(asc_col.data_font_weight) + "'" + &
		" font.family='2' font.pitch='0' font.charset='161'" + &
		" font.italic='" + string(asc_col.data_font_italic) + "'" + &
		" font.underline='" + string(asc_col.data_font_underline) + "'" + &
		" background.mode='" + string(asc_col.data_background_mode) + "'" + &
		" background.color='" + string(asc_col.data_background_color) + "')")


end subroutine

public subroutine if_add_sum (ref datawindow adw, sc_col asc_col, integer ai_x, integer ai_y, integer ai_height);// ÐñïóèÞêç summary (computed field)

adw.Modify( &
	"create compute(band=Summary"  +  &
		" color='" + string(asc_col.data_color) + "'" + &
		" alignment='" + string(asc_col.data_alignment) + "'" + &
		" border='" + string(asc_col.data_border) + "'" +  &
		" x='" + string(ai_x) + "'" + &
		" y='" + string(ai_y) + "'" + &
		" height='" + string(ai_height) + "'" + &
		" width='" + string(asc_col.width) + "'" + &
		" format='~tfn_param_maskposo()'" + &
		" name=sum_" + string(asc_col.kodcol) + &
		" expression='sum(d_" + string(asc_col.kodcol) + ")'" + &
		" font.face='" + asc_col.data_font_face + "'" + &
		" font.height='" + string(asc_col.data_font_height) + "'" + &
		" font.weight='700'" + &
		" font.family='2' font.pitch='0' font.charset='1'" + &
		" font.italic='" + string(asc_col.data_font_italic) + "'" + &
		" font.underline='" + string(asc_col.data_font_underline) + "'" + &
		" background.mode='" + string(asc_col.data_background_mode) + "'" + &
		" background.color='" + string(asc_col.data_background_color) + "')")


end subroutine

public subroutine if_modify_page (ref datawindow adw);// modify page based on misth_report

// Ðáßñíïõìå ôá äåäïìÝíá
	sc_misth_report		lsc_report
	
	fn_loadreport(is_kodreport, lsc_report)
	
// modify attributes
	adw.modify( &
	"DataWindow.Print.Margin.top='" + string(lsc_report.print_margin_top) + "'" + &
	" DataWindow.Print.Margin.Bottom='" + string(lsc_report.print_margin_bottom) + "'" + &
	" DataWindow.Print.Margin.left='" + string(lsc_report.print_margin_left) + "'" + &
	" DataWindow.Print.Margin.right='" + string(lsc_report.print_margin_right) + "'" + &
	" DataWindow.Print.Orientation='" + string(lsc_report.print_orientation) + "'" + &
	" DataWindow.Print.Scale='" + string(lsc_report.print_scale) + "'" + &
	" DataWindow.Print.Paper.Size ='" + string(lsc_report.print_paper_size) + "'")


end subroutine

public subroutine if_modify_existed (ref datawindow adw, integer ai_x);// Ìåôáêßíçóç óôáèåñþí óôïé÷åßùí óôï óçìåßùí 'ai_x'
// (ôï äåîéüôåñï óçìåßï)
	integer	li_x, li_width1, li_width2

// t_title, misth_final_title, t_subtitle, t_notes1, t_notes2
	li_x = integer(adw.object.t_title.x)
	li_width1 = ai_x - li_x
	adw.object.t_title.width = li_width1
	adw.object.misth_final_title.width = li_width1
	adw.object.t_subtitle.width = li_width1
	adw.object.t_notes1.width = li_width1
	adw.object.t_notes2.width = li_width1
	
// misth_final_aa, misth_final_date
// t_kodfinal_t, t_datefinal_t
	li_width1 = integer(adw.object.misth_final_aa.width)
	li_width2 = integer(adw.object.t_kodfinal_t.width)
	adw.object.misth_final_aa.x = ai_x - li_width1
	adw.object.misth_final_datefinal.x = ai_x - li_width1
	li_x = integer(adw.object.misth_final_aa.x)			// new x position
	adw.object.t_kodfinal_t.x = li_x - li_width2
	adw.object.t_datefinal_t.x = li_x - li_width2
	
end subroutine

on wprn_report3.create
call super::create
end on

on wprn_report3.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;title = trn(271) + " - " + trn(396)

end event

type dw from w_print_args_noform`dw within wprn_report3
string dataobject = "sprn_report3"
end type

