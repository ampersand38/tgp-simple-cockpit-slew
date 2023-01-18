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
 * call tgp_main_fnc_handleSlew
 */
ccip_slew = true;
ccip_firedTime = CBA_MissionTime;
s = "Sign_Sphere200cm_F" createVehicle [0,0,0];
ccip_airFriction = 0.08;
ccip_maxSpeed = 100;
ccip_mass = 227;
ccip_g = 9.8;
ccip_terminalSpeed = sqrt (ccip_mass * ccip_g / ccip_airFriction);

fnc_ccip = {
private _vehicle = vehicle (call CBA_fnc_currentUnit);
private _dropPosASL = getPosASL _vehicle;
private _velocity = velocity _vehicle;
if (_velocity isEqualTo [0, 0, 0]) exitWith {[0, 0, 0]};

private _azimuth = [0, 0, 0] getDir _velocity;
_velocity params ["_x", "_y", "_z"];

// Estimate impact point terrain height, assume current PilotCameraTarget is near impact point
getPilotCameraTarget _vehicle params ["_pilotCamTracking", "_pilotCamTargetPos", "_pilotCamTarget"];
private _altitude = (_dropPosASL select 2);
if (_pilotCamTracking) then {
    _altitude = _altitude - (_pilotCamTargetPos select 2);
};

// Find Time of Flight based on altitude
private _sqrt = _z^2 + 2 * _g * _altitude;
if (_sqrt < 0) exitWith {[0, 0, 0]};
//private _time = (_z + sqrt _sqrt) / _g;
private _acosh = 2.71828 ^ (_altitude * ccip_airFriction / ccip_mass);
private _time = sqrt (ccip_mass/ccip_airFriction/_g) * ln (_acosh + sqrt (_acosh^2 -1));

// Estimate Impact Point at PilotCameraTarget height
private _ip1ASL = _dropPosASL vectorAdd [_x * _time, _y * _time, -_altitude];
// Check above or below ground
private _ip1AGL = ASLToAGL _ip1ASL;
// Approximate correction
private _ip1Height = _ip1AGL select 2; // positive-above, negative-below
private _ip1VelocityZ = _z + _g * _time; // negative-descending, positive-ascending (lol)
_time = -_ip1Height / _ip1VelocityZ; // positive-later, negative-earlier

_ip1ASL vectorAdd [_x * _time, _y * _time, -_ip1Height];
};

onEachFrame {
    if (ccip_slew) then {
        _pos = call fnc_ccip;
        vehicle player setPilotCameraTarget _pos;
        s setPosASL _pos;
    };
    if (speed b > 0) then {
        hintSilent format ["%1 %2", velocity b, CBA_MissionTime-ccip_firedTime];
    }
};
ccip_firedEH = {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    b = _projectile;
    systemChat str ((velocity _projectile # 2) / (velocity _unit # 2));
    s = "Sign_Sphere200cm_F" createVehicle [0,0,0];
    (getAssignedCuratorLogic player) addCuratorEditableObjects [[s], true];
    ccip_firedTime = CBA_MissionTime;
};
vehicle player addEventHandler ["Fired", {call ccip_firedEH}];

BIS_tracedShooter = nil;
[player] spawn BIS_fnc_traceBullets;
