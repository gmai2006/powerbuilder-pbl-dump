HA$PBExportHeader$bcv_step.sru
$PBExportComments$
forward
global type bcv_step from userobject
end type
end forward

global type bcv_step from userobject
integer width = 1755
integer height = 1116
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type
global bcv_step bcv_step

type variables
public		w_wizmain	iw_parent
end variables

forward prototypes
public subroutine of_postactivate ()
public function boolean of_preactivate ()
public subroutine of_stepadded ()
public function boolean of_next ()
public function boolean of_prev ()
end prototypes

public subroutine of_postactivate ();// Called after step becomes visible

end subroutine

public function boolean of_preactivate ();// Called before step becomes visible
// if return false then don't make visible

	return true
end function

public subroutine of_stepadded ();// Called when this step has added into w_wizmain
// with addstep() function
end subroutine

public function boolean of_next ();// Next pressed
// return true to procced

	return true


end function

public function boolean of_prev ();// Prev pressed
// return true to procced

	return true


end function

on bcv_step.create
end on

on bcv_step.destroy
end on

