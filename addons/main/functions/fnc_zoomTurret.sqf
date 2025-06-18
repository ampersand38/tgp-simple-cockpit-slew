#include "script_component.hpp"
/*
 * Author: Ampersand
 * Change optics mode of turret
 *
 * Arguments:
 * 0: Increment <NUMBER>
 *
 * Return Value:
 * NONE
 *
 * Example:
 * [1] call tgp_main_fnc_zoomTurret
 */

EXITCHECK

params ["_increment"];

if ([tgp_main_vehicle] call tgp_main_fnc_isSlewable) exitWith {
    private _opticsMode = getPilotCameraOpticsMode tgp_main_vehicle;
    tgp_main_vehicle setPilotCameraOpticsMode (_opticsMode + _increment);
};

private _opticsMode = tgp_main_vehicle getTurretOpticsMode tgp_main_turret;
tgp_main_vehicle setTurretOpticsMode [tgp_main_turret, _opticsMode + _increment];
