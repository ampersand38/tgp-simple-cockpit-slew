#include "script_component.hpp"
/*
 * Author: Ampersand
 * Set state of Collision Lights
 *
 * Arguments:
 * 0: Collision Lights On <BOOLEAN>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [1] call tgp_main_fnc_setCollisionLights
 */

params ["_state"];

private _vehicle = vehicle call CBA_fnc_currentUnit;
if (isNil "_state") then {_state = !isCollisionLightOn _vehicle}; // Toggle
if (isCollisionLightOn _vehicle == _state) exitWith {};

if (local _vehicle) then {
    _vehicle setCollisionLight _state;
} else {
    [_vehicle, _state] remoteExec ["setCollisionLight", _vehicle];
};
