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
systemChat "ccip";
if (tgp_main_isTrackingCCIP) exitWith {tgp_main_isTrackingCCIP = false;};

tgp_main_isTrackingCCIP = true;
addMissionEventHandler ["draw3D", {
    if (!tgp_main_isTrackingCCIP) exitWith {removeMissionEventHandler ["draw3D", _thisEventHandler];};

    private _pos = call tgp_main_fnc_ccip_nodrag;
    cameraOn setPilotCameraTarget _pos;
}];

cameraOn addEventHandler ["Fired", {
    tgp_main_isTrackingCCIP = false;
}];
