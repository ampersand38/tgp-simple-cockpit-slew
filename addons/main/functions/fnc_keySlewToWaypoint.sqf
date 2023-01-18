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
 * [_vehicle] call tgp_main_fnc_keySlewToWaypoint
 */

private _unit = call CBA_fnc_currentUnit;
private _vehicle = vehicle _unit;

EXITCHECK

if (customWaypointPosition isNotEqualTo []) exitWith {
  _vehicle setPilotCameraTarget AGLToASL customWaypointPosition;
  tgp_main_pilotCameraTarget = getPilotCameraTarget _vehicle;
  true
};

private _currentWaypointIndex = currentWaypoint group player;
private _waypoints = waypoints group player;

if (_currentWaypointIndex < count _waypoints) exitWith { // valid base game waypoint
  private _target = AGLToASL waypointPosition [group player, _currentWaypointIndex];
  _vehicle setPilotCameraTarget _target;
  tgp_main_pilotCameraTarget = getPilotCameraTarget _vehicle;
  true
};

if (!isNil "ace_microdagr_currentwaypoint" && {ace_microdagr_currentwaypoint > -1}) exitWith {
  _vehicle setPilotCameraTarget ((player getVariable "ace_microdagr_waypoints") # ace_microdagr_currentwaypoint # 1);
  tgp_main_pilotCameraTarget = getPilotCameraTarget _vehicle;
  true
};

false
