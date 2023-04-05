#include "script_component.hpp"
/*
 * Author: Ampersand
 * Handle slew, turret move, pilotCamera move, fov sync
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

params ["", "_pfID"];
if (!tgp_main_slewAim) exitWith {[_pfID] call CBA_fnc_removePerFrameHandler;};
if (tgp_main_setting_CenterMouse) then {setMousePosition [0.5, 0.5]};
private _vehicle = tgp_main_vehicle;

private _inputX = inputAction "AimRight" - inputAction "AimLeft";
private _inputY = inputAction "AimUp" - inputAction "AimDown";
private _mouseSlew = (_inputX != 0 || {_inputY != 0});
tgp_main_isSlewing = tgp_main_slewAim && {_mouseSlew};

if (!tgp_main_isSlewing) exitWith {};

(getPilotCameraRotation _vehicle) params ["_azimuth", "_elevation"];
private _pilotCameraTarget = (getPilotCameraTarget _vehicle);

// check if in turret, apply different zoom-based slew speed
private _rate = (0.04 * tgp_main_setting_AimSlewSpeed) * tgp_main_FOV;

private _slewX = _rate * _inputX * tgp_main_setting_AimXFactor;
private _slewY = _rate * _inputY;

_azimuth = _azimuth - _slewX;
if (-pi < tgp_main_minTurn || {tgp_main_maxTurn < pi}) then {
  _azimuth = tgp_main_minTurn max _azimuth min tgp_main_maxTurn;
};

_elevation = _elevation - _slewY;
if (-pi < tgp_main_minElev || {tgp_main_maxElev < pi}) then {
  _elevation = tgp_main_minElev max _elevation min tgp_main_maxElev;
};

_vehicle setPilotCameraRotation [_azimuth, _elevation];

if (_pilotCameraTarget # 0) then {
    private _flirPosWorld = _vehicle modelToWorldVisualWorld tgp_main_camPos;
    private _slewDir = (getPilotCameraDirection _vehicle) vectorMultiply 5000;
    private _position1 = AGLToASL (_vehicle modelToWorldVisual (tgp_main_camPos vectorAdd _slewDir));
    private _intersections = lineIntersectsSurfaces [_flirPosWorld, _position1, _vehicle];
    if (_intersections isEqualTo []) then {
        private _target = terrainIntersectAtASL [_flirPosWorld, _position1];
        if (_target isEqualTo [0,0,0]) then {
            _target = _position1;
        };
        _vehicle setPilotCameraTarget _target;
        tgp_main_cameraTarget = getPilotCameraTarget _vehicle;
    } else {
        (_intersections # 0) params ["_intersectPosASL", "_surfaceNormal", "_intersectObject", "_parentObject"];
        _vehicle setPilotCameraTarget _intersectPosASL;
        tgp_main_cameraTarget = getPilotCameraTarget _vehicle;
    };
};
