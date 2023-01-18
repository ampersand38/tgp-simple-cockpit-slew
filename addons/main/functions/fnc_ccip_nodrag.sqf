#include "script_component.hpp"
/*
 * Author: Ampersand
 * Calculate CCIP at current parameters
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * call tgp_main_fnc_ccip_nodrag
 */

private _g = 9.8;
private _vehicle = vehicle (call CBA_fnc_currentUnit);
private _dropPosASL = getPosASL _vehicle;
private _velocity = velocity _vehicle;
if (_velocity isEqualTo [0, 0, 0]) exitWith {[0, 0, 0]};

private _azimuth = [0, 0, 0] getDir _velocity;
_velocity params ["_x", "_y", "_z"];
private _h = sqrt (_x^2 + _y^2);
private _elevation = atan (_z/_h);
ccip_elevation = _elevation;

// Estimate impact point terrain height, assume current PilotCameraTarget is near impact point
getPilotCameraTarget _vehicle params ["_pilotCamTracking", "_pilotCamTargetPos", "_pilotCamTarget"];
private _altitude = (_dropPosASL select 2);
if (_pilotCamTracking) then {
    _altitude = _altitude - (_pilotCamTargetPos select 2);
};

// Find Time of Flight based on altitude
private _sqrt = _z^2 + 2 * _g * _altitude;
if (_sqrt < 0) exitWith {[0, 0, 0]};

private _time = (_z + sqrt _sqrt) / _g;
_time = tgp_main_ccipOffset + _time *
    (1 - 0.000025 * _altitude) *
    (1 - 0.00000001 * (speed _vehicle - 560)^2) *
    (1 + 0.0025 * _elevation);

// Estimate Impact Point at PilotCameraTarget height
private _ip1ASL = _dropPosASL vectorAdd [_x * _time, _y * _time, -_altitude];
// Check above or below ground
private _ip1AGL = ASLToAGL _ip1ASL;
// Approximate correction
private _ip1Height = _ip1AGL select 2; // positive-above, negative-below
private _ip1VelocityZ = _z + _g * _time; // negative-descending, positive-ascending (lol)
_time = -_ip1Height / _ip1VelocityZ; // positive-later, negative-earlier

_ip1ASL vectorAdd [_x * _time, _y * _time, -_ip1Height];
