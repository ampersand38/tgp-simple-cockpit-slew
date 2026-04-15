#include "script_component.hpp"
/*
 * Author: Ampersand
 * Start slewing TGP
 *
 * Arguments:
 * 0: Direction <NUMBER>
 * 1: Amount <NUMBER or BOOLEAN>
 *
 * Return Value:
 * Block other input
 *
 * Example:
 * call tgp_main_fnc_inputSlewAnalog;
 */

params ["_direction", "_amount"];

if (_amount isEqualType false) then {_amount = parseNumber _amount;};
GVAR(analogDirection) set [_direction, _amount];
if GVAR(slewAim) exitWith {};

EXITCHECK
[] call tgp_main_fnc_setup;

GVAR(slewAim) = true;

switch (GVAR(mode)) do {
    case (MODE_PILOTCAMERA): {
        [FUNC(handleSlew), 0, true] call CBA_fnc_addPerFrameHandler;
    };
    case (MODE_TURRET): {
        if (!GVAR(isAutonomous)) then {tgp_main_vehicle setAutonomous true;};
        [FUNC(handleSlewTurret), 0, true] call CBA_fnc_addPerFrameHandler;
    };
}; // switch

false
