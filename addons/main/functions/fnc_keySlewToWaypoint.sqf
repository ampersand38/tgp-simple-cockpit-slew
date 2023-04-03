#include "script_component.hpp"
/*
 * Author: Ampersand
 * Lock pilot camera to custom waypoint (shift-click) or next waypoint
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * call tgp_main_fnc_keySlewToWaypoint
 */

EXITCHECK

private _posASL = (call CBA_fnc_currentUnit) call {
    if (customWaypointPosition isNotEqualTo []) exitWith {
        AGLToASL customWaypointPosition
    };

    private _currentWaypointIndex = currentWaypoint group _this;
    private _waypoints = waypoints group _this;

    if (_currentWaypointIndex < count _waypoints) exitWith { // valid base game waypoint
        AGLToASL waypointPosition [group _this, _currentWaypointIndex]
    };

    if (!isNil "ace_microdagr_currentwaypoint" && {ace_microdagr_currentwaypoint > -1}) exitWith {
        ((_this getVariable "ace_microdagr_waypoints") # ace_microdagr_currentwaypoint # 1)
    };

    objNull
};

switch (GVAR(mode)) do {
    case (MODE_PILOTCAMERA): {
        tgp_main_vehicle setPilotCameraTarget _posASL;
        tgp_main_pilotCameraTarget = getPilotCameraTarget tgp_main_vehicle;
    };
    case (MODE_TURRET): {
        tgp_main_vehicle lockCameraTo [_posASL, [0], true];
    };
};

false
