#include "script_component.hpp"
/*
 * Author: Ampersand
 * Take aircraft controls
 *
 * Arguments:
 * 0: Collision Lights On <BOOLEAN>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [1] call tgp_main_fnc_takeControls
 */

private _unit = call CBA_fnc_currentUnit;
private _vehicle = vehicle _unit;
private _currentPilot = currentPilot _vehicle;

if (_unit == _currentPilot) exitWith {};

// Pilot taking control
if (_unit == driver _vehicle) exitWith {
    _unit action ["SuspendVehicleControl", _vehicle];
};

if (getNumber ([_vehicle, _vehicle unitTurret _unit] call CBA_fnc_getTurret >> "isCopilot") < 1) exitWith {};

// Co-pilot taking control
_unit action ["TakeVehicleControl", _vehicle];
