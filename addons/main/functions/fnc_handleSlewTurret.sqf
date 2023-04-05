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

    [tgp_main_vehicle lockedCameraTo tgp_main_turret, [], true] call tgp_main_fnc_setStabilization;
};

if (tgp_main_setting_CenterMouse) then {setMousePosition [0.5, 0.5]};

private _inputX = inputAction "AimLeft" - inputAction "AimRight";
private _inputY = inputAction "AimUp" - inputAction "AimDown";
private _mouseSlew = (_inputX != 0 || {_inputY != 0});
tgp_main_isSlewing = tgp_main_slewAim && {_mouseSlew};

private _camPos = tgp_main_vehicle selectionPosition tgp_main_camPos;
if (isNil "tgp_main_azimuth" || {isNil "tgp_main_elevation"}) then {
    private _camDir = tgp_main_vehicle selectionPosition tgp_main_camDir;
    _povDir = _camDir vectorDiff _camPos;
    _povDir call CBA_fnc_vect2Polar params ["", "_azimuth", "_elevation"];
    if (_azimuth > 180) then {
        _azimuth = _azimuth - 360;
    };
    [-_azimuth, _elevation]
} else {
    [tgp_main_azimuth, tgp_main_elevation]
} params ["_azimuth", "_elevation"];

// check if in turret, apply different zoom-based slew speed
private _rate = (1.0 * tgp_main_setting_AimSlewSpeed) * tgp_main_FOV;
private _slewX = _rate * _inputX * tgp_main_setting_AimXFactor;
private _slewY = _rate * _inputY;

_azimuth = _azimuth + _slewX;
if (-180 < tgp_main_minTurn || {tgp_main_maxTurn < 180}) then {
  _azimuth = tgp_main_minTurn max _azimuth min tgp_main_maxTurn;
};

_elevation = _elevation + _slewY;
if (-180 < tgp_main_minElev || {tgp_main_maxElev < 180}) then {
  _elevation = tgp_main_minElev max _elevation min tgp_main_maxElev;
};

tgp_main_azimuth = _azimuth;
tgp_main_elevation = _elevation;
private _dir = [5000, -_azimuth, _elevation] call CBA_fnc_polar2vect;

_pos = tgp_main_vehicle modelToWorldVisualWorld (_camPos vectorAdd _dir);
tgp_main_cameraTarget = [true, _pos, objNull];
tgp_main_vehicle lockCameraTo [_pos, tgp_main_turret, true];
