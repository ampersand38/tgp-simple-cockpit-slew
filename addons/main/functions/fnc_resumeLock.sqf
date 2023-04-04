#include "script_component.hpp"
/*
 * Author: Ampersand
 * Resume lock
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * Block other input
 *
 * Example:
 * call tgp_main_fnc_resumeLock
 */

EXITCHECK

if !(tgp_main_cameraTarget # 0) exitWith {};

switch (GVAR(mode)) do {
    case (MODE_TURRET): {
        if (!GVAR(isAutonomous)) then {tgp_main_vehicle setAutonomous true;};
        tgp_main_vehicle lockCameraTo [tgp_main_cameraTarget call tgp_main_fnc_parseCameraTarget, tgp_main_turret, true];
    };
}; // switch

false
