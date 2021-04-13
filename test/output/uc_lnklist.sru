HA$PBExportHeader$uc_lnklist.sru
$PBExportComments$
forward
global type uc_lnklist from nonvisualobject
end type
end forward

global type uc_lnklist from nonvisualobject autoinstantiate
end type

type variables
private	uc_atom	ptrHead
private	uc_atom	ptrTail

private	uc_atom	ptrPos		// current atom
end variables

forward prototypes
public function uc_atom addtail (readonly any arg_data)
public function boolean remove (ref uc_atom arg_atom)
public function uc_atom addpos (readonly any adata)
public function boolean ishead ()
public function boolean istail ()
public function any getposdata ()
public function boolean movenext ()
public function boolean moveprev ()
public subroutine emptylist ()
public function uc_atom gethead ()
public function uc_atom gettail ()
public function uc_atom getpos ()
public subroutine setpos (ref uc_atom newpos)
public function long count ()
end prototypes

public function uc_atom addtail (readonly any arg_data);// Insert a new atom to the end of the list

// Create a new atom and assign adata
	uc_atom		atom
	atom = create uc_atom
	
	if isvalid(atom) then
		
		atom.data = arg_data

		// ¸ëåã÷ïò head-tail
			if not isvalid(ptrHead) then	// it's the 1st atom
				ptrHead = atom
			else	
				ptrTail.ptrNext = atom
				atom.ptrPrev = ptrTail
			end if
			
		// Insert to tail
			ptrTail = atom
			
		// Set current pos
			ptrPos = atom
			
	end if
		
	return atom
end function

public function boolean remove (ref uc_atom arg_atom);// removes arg_atom from the list

	uc_atom		ptrPrev, &
					ptrNext
					
	// If head is not valid, the list is empty
		if not isvalid(ptrHead) then return false

	// Get prev and next pointers of arg_atom
		ptrPrev = arg_atom.ptrPrev
		ptrNext = arg_atom.ptrNext
		
	// Áí õðÜñ÷åé åðüìåíï ôï óõíäÝïõìå ìå ôï ðñïçãïýìåíï
	// Áí õðÜñ÷åé ðñïçãïýìåíï, ôï óõíäÝïõìå ìå ôï åðüìåíï
		if isvalid(ptrNext) then ptrNext.ptrPrev = ptrPrev
		if isvalid(ptrPrev) then ptrPrev.ptrNext = ptrNext
		
	// Áí åßíáé ôï ôåëåõôáßï êáé õðÜñ÷åé ðñïçãïýìåíï,
	// move tail pointer to previous (ptrTail = ptrPrev)
		if arg_atom = ptrTail and isvalid(ptrPrev) then	ptrTail = ptrPrev
		
	// Áí åßíáé ôï ðñþôï êáé õðÜñ÷åé åðüìåíï,
	// move head pointer to next
		if arg_atom = ptrHead and isvalid(ptrNext) then ptrHead = ptrNext
		
	// Set current position to previous 
		ptrPos = arg_atom.ptrPrev		
		
	// destroy and return
		destroy arg_atom
		return true
end function

public function uc_atom addpos (readonly any adata);// Insert a new atom after the current position

// Áí åßìáóôå óôï ôÝëïò, ðñïóèÞêç óôï tail
	if (ptrPos = ptrTail) or (not isvalid(ptrPos)) then
		return addtail(adata)
	end if
		

// Create a new atom and assign adata
	uc_atom		atom
	atom = create uc_atom
	
	if isvalid(atom) then
		
		atom.data = adata
		
		atom.ptrNext = ptrPos.ptrNext
		atom.ptrPrev = ptrPos
		ptrPos.ptrNext.ptrPrev = atom
		ptrPos.ptrNext = atom

		// Set current pos
			ptrPos = atom
			
	end if
		
	return atom
end function

public function boolean ishead ();// returns true if ptrPos = ptrHead
	if ptrPos = ptrHead then 
		return true
	else
		return false
	end if
end function

public function boolean istail ();// returns true if ptrPos = ptrTail
	if ptrPos = ptrTail then 
		return true
	else
		return false
	end if
end function

public function any getposdata ();// returns current pos data
	return ptrPos.data
end function

public function boolean movenext ();// moves ptrPos to next atom
// if this is the last atom, return false

	if isvalid(ptrPos) then
		
		if isvalid(ptrPos.ptrNext) then
			ptrPos = ptrPos.ptrNext
			return true
		end if
		
		return false
		
	end if
	
	return false
end function

public function boolean moveprev ();// moves ptrPos to previous atom
// if this is the first atom, return false

	if isvalid(ptrPos) then
		
		if isvalid(ptrPos.ptrPrev) then
			ptrPos = ptrPos.ptrPrev
			return true
		end if
		
		return false
		
	end if
	
	return false
end function

public subroutine emptylist ();// removes all items from the list
// delete head recursively until is not valid

	do while isvalid(ptrHead) 
		remove(ptrHead)
	loop
end subroutine

public function uc_atom gethead ();// return head
	return ptrHead
end function

public function uc_atom gettail ();return ptrTail
end function

public function uc_atom getpos ();return ptrPos
end function

public subroutine setpos (ref uc_atom newpos);ptrPos = newpos
end subroutine

public function long count ();// counts atoms into the list
	long	ll_count = 0
	
	uc_atom	uc_curatom
	
	uc_curatom = ptrHead
	
	do while isvalid(uc_curatom)
		ll_count = ll_count + 1
		uc_curatom = uc_curatom.ptrNext
	loop
	
	
	return ll_count
end function

on uc_lnklist.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uc_lnklist.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// set current position to head
	ptrPos = ptrHead
end event

