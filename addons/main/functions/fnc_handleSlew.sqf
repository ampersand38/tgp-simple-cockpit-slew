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

private _vehicle = vehicle (call CBA_fnc_currentUnit);

private _isGunnerView = cameraView isEqualTo "GUNNER";
//hintSilent format ["_mouseSlew: %1\n_isGunnerView: %2", "_____", cameraView isEqualTo "GUNNER"];

// get current dir
(getPilotCameraRotation _vehicle) params ["_azimuth", "_elevation"];

// check key slew
private _inputX = 0;
private _inputY = 0;
private _keySlew = 0 < (tgp_main_up + tgp_main_down + tgp_main_right + tgp_main_left);
private _mouseSlew = false; // also used for pilotCamera update

if _keySlew then {
    _inputX = tgp_main_right - tgp_main_left;
    _inputY = tgp_main_up - tgp_main_down;
} else {
    // check mouse slew
    //setMousePosition [5,5]; // can't use map while flir is on, also doesn't seem to be needed.
    _inputX = inputAction "AimRight" - inputAction "AimLeft";
    _inputY = inputAction "AimUp" - inputAction "AimDown";
    _mouseSlew = (_inputX != 0 || {_inputY != 0});
};
tgp_main_isSlewing = _keySlew || {tgp_main_isInScriptedCamera && {_mouseSlew}} || {tgp_main_slewAim && {_mouseSlew} && {!_isGunnerView}};

// Player is copilot in gunner view
if (
    tgp_main_playerIsCopilot && {
    _isGunnerView && {_mouseSlew}}
) exitWith {
    // unlock copilot camera
    if _mouseSlew then {
        _vehicle lockCameraTo [objNull, [0]];
    };

    private _azimuth = _vehicle animationSourcePhase "FLIR_DIRECTION";
    private _elevation = _vehicle animationSourcePhase "FLIR_ELEVATION";
    _vehicle setPilotCameraRotation [_azimuth, -_elevation];
    private _flirPosWorld = _vehicle modelToWorldVisualWorld tgp_main_camPos;
    private _slewDir = (getPilotCameraDirection _vehicle) vectorMultiply 5000;
    private _position1 = _vehicle modelToWorldVisual (tgp_main_camPos vectorAdd _slewDir);
    private _intersections = lineIntersectsSurfaces [_flirPosWorld, AGLToASL _position1, _vehicle];
    private _target = objNull;
    if !((_intersections # 0) isEqualTo []) then {
        (_intersections # 0) params ["_intersectPosASL", "_surfaceNormal", "_intersectObject", "_parentObject"];
        _target = _intersectPosASL;
    };
    _vehicle setPilotCameraTarget _target;
    [_slewDir, _target] call tgp_main_fnc_syncPilotCamera;
    //[_vehicle] call tgp_main_fnc_updateCamera;
};

private _pilotCameraTarget = (getPilotCameraTarget _vehicle);

// if copilot in turret, pilotCamera follows copilot turret
if (tgp_main_playerIsPilot && {tgp_main_isCopilotInGunnerView}) exitWith {
    if _isGunnerView then {
        if _mouseSlew then {
        _vehicle setPilotCameraTarget (getPilotCameraTarget _vehicle # 1);
        };
    } else {
        //[_vehicle] call tgp_main_fnc_updateCamera;
    };
};

if ( // pilot is moving pilotCamera
    tgp_main_playerIsPilot && {_mouseSlew && {_isGunnerView}}
) exitWith {
//systemChat "pilot gunnerview";
    [getPilotCameraDirection _vehicle, _pilotCameraTarget] call tgp_main_fnc_syncPilotCamera;
    //[_vehicle] call tgp_main_fnc_updateCamera;
};

if tgp_main_isSlewing then {
    // check if in turret, apply different zoom-based slew speed
    private _rate = ([0.04 * tgp_main_setting_AimSlewSpeed, 0.08 * tgp_main_setting_KeySlewSpeed] select _keySlew) * tgp_main_FOV;
    // customize x axis speed for better feel
    private _xFactor = tgp_main_aspectRatio * ([tgp_main_setting_AimXFactor, tgp_main_setting_KeyXFactor] select _keySlew);

    private _slewX = _rate * _xFactor * _inputX;
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

    if !(_pilotCameraTarget # 0) then { // not tracking
//systemChat format ["free %1", [[_azimuth, _elevation], objNull]];
        [[_azimuth, _elevation], objNull] call tgp_main_fnc_syncPilotCamera;

    } else { // tracking
        private _flirPosWorld = _vehicle modelToWorldVisualWorld tgp_main_camPos;
        private _slewDir = (getPilotCameraDirection _vehicle) vectorMultiply 5000;
        private _position1 = _vehicle modelToWorldVisual (tgp_main_camPos vectorAdd _slewDir);
        private _intersections = lineIntersectsSurfaces [_flirPosWorld, AGLToASL _position1, _vehicle];
        if !((_intersections # 0) isEqualTo []) then {
            (_intersections # 0) params ["_intersectPosASL", "_surfaceNormal", "_intersectObject", "_parentObject"];
            _vehicle setPilotCameraTarget _intersectPosASL;
//systemChat format ["tracking %1", [_slewDir, _intersectPosASL]];
            [_slewDir, _intersectPosASL] call tgp_main_fnc_syncPilotCamera;
        };
    };

};
