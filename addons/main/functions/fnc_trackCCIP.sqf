#include "script_component.hpp"
/*
 * Author: Ampersand
 * Start tracking the CCIP
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * call tgp_main_fnc_trackCCIP
 */

if (tgp_main_isTrackingCCIP) exitWith {tgp_main_isTrackingCCIP = false;};

tgp_main_vehicle vehicleChat "CCIP";
tgp_main_isTrackingCCIP = true;
tgp_main_ccipOffset = 0;
addMissionEventHandler ["draw3D", {
    if (!tgp_main_isTrackingCCIP) exitWith {removeMissionEventHandler ["draw3D", _thisEventHandler];};

    private _pos = call tgp_main_fnc_ccip_nodrag;
    tgp_main_vehicle setPilotCameraTarget _pos;
}];

tgp_main_vehicle addEventHandler ["Fired", {
    params ["_vehicle"];
    _vehicle removeEventHandler [_thisEvent, _thisEventHandler];
    tgp_main_isTrackingCCIP = false;
}];
