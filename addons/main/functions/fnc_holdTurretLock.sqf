#include "script_component.hpp"
/*
 * Author: Ampersand
 * Hold lock
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * Block other input
 *
 * Example:
 * call tgp_main_fnc_holdTurretLock
 */

params ["", "_pfID"];

if !(tgp_main_cameraTarget # 0) exitWith {
    GVAR(holdTurretLockPFHID) = -1;
    [_pfID] call CBA_fnc_removePerFrameHandler;
};

tgp_main_vehicle lockCameraTo [tgp_main_cameraTarget call tgp_main_fnc_parseCameraTarget, tgp_main_turret, true];
