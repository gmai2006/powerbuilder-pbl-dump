HA$PBExportHeader$w_wizmain.srw
$PBExportComments$
forward
global type w_wizmain from window
end type
type ucv_step from bcv_step within w_wizmain
end type
type cb_cancel from commandbutton within w_wizmain
end type
type cb_prev from commandbutton within w_wizmain
end type
type cb_next from commandbutton within w_wizmain
end type
end forward

global type w_wizmain from window
integer width = 2651
integer height = 1788
boolean titlebar = true
string title = "wizard"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
ucv_step ucv_step
cb_cancel cb_cancel
cb_prev cb_prev
cb_next cb_next
end type
global w_wizmain w_wizmain

type variables
// Steps
protected		bcv_step		icv_steps[]		// step objects
protected		integer		ii_steps			// number of steps
protected		integer		ii_curstep		// current step
protected		string		is_steps[]		// step names

// steps position
protected		integer		ii_stepx
protected		integer		ii_stepy
protected		integer		ii_stepwidth
protected		integer		ii_stepheight

// Button labes
protected		string	is_nextstr = "&Next"
protected		string	is_prevstr = "&Prev"
protected 		string	is_finishstr = "&Finish"
protected		string	is_cancelstr = "&Cancel"

end variables

forward prototypes
protected subroutine of_addsteps ()
protected subroutine if_setbuttons ()
protected subroutine addstep (string as_objectname, string as_stepname)
protected function boolean of_finish ()
public function bcv_step getstep (string as_stepname)
public function integer getsteppos (string as_stepname)
public function bcv_step getstep (integer ai_pos)
end prototypes

protected subroutine of_addsteps ();// override to add steps to the wizard
// usage: addstep("bcv_step_derived", "stepname")
end subroutine

protected subroutine if_setbuttons ();// set button state and captions

// if ii_curstep = 1 then disable prev
	if ii_curstep = 1 then
		cb_prev.enabled = false
	else
		cb_prev.enabled = true
	end if
	
// if ii_curstep = ii_steps then change "next" to "finish"
	if ii_curstep = ii_steps then
		cb_next.text = is_finishstr
	else
		cb_next.text = is_nextstr
	end if
end subroutine

protected subroutine addstep (string as_objectname, string as_stepname);// add a new step 
// visible = false

// next step id
	ii_steps = ii_steps + 1

// Open user object - Set position - make invisible - set parent
	OpenUserObject(icv_steps[ii_steps], as_objectname, ii_stepx, ii_stepy)
	
	icv_steps[ii_steps].width = ii_stepwidth
	icv_steps[ii_steps].height = ii_stepheight
	
	icv_steps[ii_steps].visible = false
	
	icv_steps[ii_steps].iw_parent = this
	
// hold step's name
	is_steps[ii_steps] = as_stepname
	
// call of_stepadded()
	icv_steps[ii_steps].of_stepadded()
	


end subroutine

protected function boolean of_finish ();// Called when finish button pressed
// Return true to close the wizard
// Return false to keep the wizard opened
	
	return true
end function

public function bcv_step getstep (string as_stepname);// Return step object by name
	
// Find position of as_stepname
	integer	i
	for i = 1 to ii_steps
		if is_steps[i] = as_stepname then
			return icv_steps[i]
		end if
	next
	
// return invalid object
	bcv_step		lcv_step
	return lcv_step		// not valid - not found
end function

public function integer getsteppos (string as_stepname);// Return step position into icv_steps[]
	
// Find position of as_stepname
	integer	i
	for i = 1 to ii_steps
		if is_steps[i] = as_stepname then
			return i
		end if
	next
	
// return 0 - Not found
	return 0
	
end function

public function bcv_step getstep (integer ai_pos);// Return step object by position
	
	return icv_steps[ai_pos]
	

end function

on w_wizmain.create
this.ucv_step=create ucv_step
this.cb_cancel=create cb_cancel
this.cb_prev=create cb_prev
this.cb_next=create cb_next
this.Control[]={this.ucv_step,&
this.cb_cancel,&
this.cb_prev,&
this.cb_next}
end on

on w_wizmain.destroy
destroy(this.ucv_step)
destroy(this.cb_cancel)
destroy(this.cb_prev)
destroy(this.cb_next)
end on

event open;// set default button text (translated)
	is_nextstr = trn(23)
	is_prevstr = trn(36)
	is_finishstr = trn(48)
	is_cancelstr = trn(2)


// Set button strings
	cb_prev.text = is_prevstr
	cb_next.text = is_nextstr
	cb_cancel.text = is_cancelstr
	
// Get position parameters of ucv_step and close it
	ii_stepx = ucv_step.x
	ii_stepy = ucv_step.y
	ii_stepwidth = ucv_step.width
	ii_stepheight = ucv_step.height
	CloseUserObject(ucv_step)

// Override funcions
	of_addsteps()
	
// If there is no step return
	if ii_steps = 0 then
		MessageBox("Wizard", "No step defined!")
		CloseWithReturn(this, 0)
		return
	end if
	
// Set step 1
	if icv_steps[1].of_preactivate() = false then return
	icv_steps[1].visible = true
	ii_curstep = 1
	icv_steps[1].of_postactivate()
		
// set buttons
	if_setbuttons()

end event

event close;// Destroy steps
	integer	i
	
	for i = 1 to ii_steps
		CloseUserObject(icv_steps[i])
	next
end event

type ucv_step from bcv_step within w_wizmain
integer x = 27
integer y = 20
integer width = 2583
integer height = 1484
integer taborder = 10
long backcolor = 12639424
end type

on ucv_step.destroy
call bcv_step::destroy
end on

type cb_cancel from commandbutton within w_wizmain
integer x = 2213
integer y = 1548
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(GetParent(), 0)
end event

type cb_prev from commandbutton within w_wizmain
integer x = 1289
integer y = 1548
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Prev"
end type

event clicked;// proceed to prev step

// Override functions
	if not icv_steps[ii_curstep].of_prev() then return

// If we are on first step, return.
// Normally we wouldn't come here because
// prev button is disabled when on first step
	if ii_curstep = 1 then 
		MessageBox("Wizard", "You are at the first step!")
		return
	end if

// Override functions
	if not icv_steps[ii_curstep - 1].of_preactivate() then return

// go to prev step (make it visible and hide current)
	icv_steps[ii_curstep].visible = false
	ii_curstep = ii_curstep - 1
	icv_steps[ii_curstep].visible = true
	
// Override functions
	icv_steps[ii_curstep].of_postactivate()
	
// set button state
	if_setbuttons()

end event

type cb_next from commandbutton within w_wizmain
integer x = 1751
integer y = 1548
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Next"
end type

event clicked;// proceed to next step

// Override functions
	if not icv_steps[ii_curstep].of_next() then return

// If there isn't next step, we are on finish 
// Call override function
// if of_finish return true, close wizard
	if ii_curstep = ii_steps then 
		if of_finish() then 
			CloseWithReturn(getparent(), 1)
			return
		else
			return
		end if
	end if
	
// Override functions
	if not icv_steps[ii_curstep + 1].of_preactivate() then return

// go to next step (make it visible and hide current)
	icv_steps[ii_curstep].visible = false
	ii_curstep = ii_curstep + 1
	icv_steps[ii_curstep].visible = true
	
// Override functions
	icv_steps[ii_curstep].of_postactivate()
	
// set button state
	if_setbuttons()

end event

