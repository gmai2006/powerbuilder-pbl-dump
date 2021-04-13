HA$PBExportHeader$uc_atom.sru
$PBExportComments$
forward
global type uc_atom from nonvisualobject
end type
end forward

global type uc_atom from nonvisualobject
end type
global uc_atom uc_atom

type variables
any		data
uc_atom	ptrPrev
uc_atom	ptrNext
end variables

on uc_atom.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uc_atom.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

