#include "script_component.hpp"
/*
 * Author: Ampersand
 * Handle slew, turret move
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * call tgp_main_fnc_handleSlewTurret
 */

params ["", "_pfID"];
if (!tgp_main_slewAim) exitWith {
    [_pfID] call CBA_fnc_removePerFrameHandler;
    tgp_main_azimuth = nil;
    tgp_main_elevation = nil;
    [tgp_main_vehicle lockedCameraTo [0], [], true] call tgp_main_fnc_setStabilization;
    tgp_main_vehicle setAutonomous GVAR(isAutonomous);
    //tgp_main_vehicle lockCameraTo [tgp_main_vehicle lockedCameraTo [0], [0]];
};

private _inputX = inputAction "AimLeft" - inputAction "AimRight";
private _inputY = inputAction "AimUp" - inputAction "AimDown";
private _mouseSlew = (_inputX != 0 || {_inputY != 0});
tgp_main_isSlewing = tgp_main_slewAim && {_mouseSlew};

//if (!tgp_main_isSlewing) exitWith {};

private _azimuth = missionNamespace getVariable ["tgp_main_azimuth", tgp_main_vehicle animationSourcePhase tgp_main_animSrcBody];
private _elevation = missionNamespace getVariable ["tgp_main_elevation", tgp_main_vehicle animationSourcePhase tgp_main_animSrcGun];

// check if in turret, apply different zoom-based slew speed
private _rate = (0.004 * tgp_main_setting_AimSlewSpeed) * tgp_main_FOV;
private _slewX = _rate * _inputX * tgp_main_setting_AimXFactor;
private _slewY = _rate * _inputY;

_azimuth = _azimuth + _slewX;
if (-pi < tgp_main_minTurn || {tgp_main_maxTurn < pi}) then {
  _azimuth = tgp_main_minTurn max _azimuth min tgp_main_maxTurn;
};

_elevation = _elevation + _slewY;
if (-pi < tgp_main_minElev || {tgp_main_maxElev < pi}) then {
  _elevation = tgp_main_minElev max _elevation min tgp_main_maxElev;
};

tgp_main_azimuth = _azimuth;
tgp_main_elevation = _elevation;
private _dir = [5000, -deg _azimuth, deg _elevation] call CBA_fnc_polar2vect;


_pos = tgp_main_vehicle modelToWorldVisualWorld _dir;
tgp_main_vehicle lockCameraTo [_pos, [0], true];
