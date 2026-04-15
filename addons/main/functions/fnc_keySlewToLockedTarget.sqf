#include "script_component.hpp"
/*
 * Author: Ampersand
 * Lock pilot camera to playerTargetLock
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * call tgp_main_fnc_keySlewToLockedTarget
 */

EXITCHECK

[] call tgp_main_fnc_setup;

playerTargetLock params ["_target"];

_target = if (_target isEqualTo objNull) then {
    [false, [0, 0, 0], objNull];
} else {
    [true, _target, objNull];
};

_target call FUNC(lockCamera);

false
