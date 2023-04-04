#include "script_component.hpp"
/*
 * Author: Ampersand
 * Lock FLIR to current aim pos or obj
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * [] call tgp_main_fnc_keyFLIRSlewToHMD
 */

EXITCHECK

[
    AGLToASL positionCameraToWorld [0, 0, 5000],
    AGLToASL positionCameraToWorld [0, 0, 0],
    true
] call tgp_main_fnc_setStabilization;

true
