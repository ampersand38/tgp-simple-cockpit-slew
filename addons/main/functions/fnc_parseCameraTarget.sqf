#include "script_component.hpp"
/*
 * Author: Ampersand
 * Parse camera target and return the actual target
 *
 * Arguments:
 * 0: Is Tracking <BOOLEAN>
 * 1: Position <ARRAY>
 * 2: Object <OBJECT>
 *
 * Return Value:
 * 0: Target Position or Object <ARRAY|OBJECT>
 *
 * Example:
 * [false [0, 0, 0], objNull] call tgp_main_fnc_parseCameraTarget
 */

params ["_isTracking", "_position", "_object"];

if (!_isTracking) exitWith {objNull};

if (isNull _object || {speed _object == 0}) exitWith {_position};

_object
