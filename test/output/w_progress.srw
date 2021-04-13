HA$PBExportHeader$w_progress.srw
$PBExportComments$
forward
global type w_progress from window
end type
type hpb from hprogressbar within w_progress
end type
type st_caption from statictext within w_progress
end type
end forward

global type w_progress from window
integer width = 1554
integer height = 332
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
hpb hpb
st_caption st_caption
end type
global w_progress w_progress

type variables
pointer ip_pointer 

end variables

forward prototypes
public subroutine setcaption (string as_caption)
public subroutine setrange (long al_min, long al_max)
public subroutine setstep (long al_step)
public subroutine stepit ()
end prototypes

public subroutine setcaption (string as_caption);st_caption.text = as_caption
end subroutine

public subroutine setrange (long al_min, long al_max);// Set range and min-max position the same
	hpb.MinPosition = al_min
	hpb.MaxPosition = al_max
	hpb.SetRange(al_min,al_max)
	
// Initial step = 1
// Call setstep() to change
	hpb.SetStep = 1
end subroutine

public subroutine setstep (long al_step);// Initial step = 1 (set into setrange)

	hpb.SetStep = al_step
end subroutine

public subroutine stepit ();// increase step
	hpb.stepit()
end subroutine

on w_progress.create
this.hpb=create hpb
this.st_caption=create st_caption
this.Control[]={this.hpb,&
this.st_caption}
end on

on w_progress.destroy
destroy(this.hpb)
destroy(this.st_caption)
end on

event open;ip_pointer = SetPointer(HourGlass!)



end event

event close;SetPointer(ip_pointer)
end event

type hpb from hprogressbar within w_progress
integer x = 23
integer y = 152
integer width = 1495
integer height = 84
boolean smoothscroll = true
end type

type st_caption from statictext within w_progress
integer x = 27
integer y = 60
integer width = 1495
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = greekcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Greek"
long textcolor = 128
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

