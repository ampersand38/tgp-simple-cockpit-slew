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

// get current dir
(getPilotCameraRotation _vehicle) params ["_azimuth", "_elevation"];

private _inputX = 0;
private _inputY = 0;
private _mouseSlew = false; // also used for pilotCamera update

_inputX = inputAction "AimRight" - inputAction "AimLeft";
_inputY = inputAction "AimUp" - inputAction "AimDown";
_mouseSlew = (_inputX != 0 || {_inputY != 0});
tgp_main_isSlewing = tgp_main_slewAim && {_mouseSlew};

private _pilotCameraTarget = (getPilotCameraTarget _vehicle);

if (tgp_main_isSlewing) then {
    // check if in turret, apply different zoom-based slew speed
    private _rate = (0.04 * tgp_main_setting_AimSlewSpeed) * tgp_main_FOV;
    // customize x axis speed for better feel
    private _xFactor = tgp_main_aspectRatio * tgp_main_setting_AimXFactor;

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
    if (_pilotCameraTarget # 0) then {
        private _flirPosWorld = _vehicle modelToWorldVisualWorld tgp_main_camPos;
        private _slewDir = (getPilotCameraDirection _vehicle) vectorMultiply worldSize;
        private _position1 = AGLToASL (_vehicle modelToWorldVisual (tgp_main_camPos vectorAdd _slewDir));
        private _intersections = lineIntersectsSurfaces [_flirPosWorld, _position1, _vehicle];
        if (_intersections isEqualTo []) then {
            private _target = terrainIntersectAtASL [_flirPosWorld, _position1];
            if (_target isEqualTo [0,0,0]) then {
                _target = _position1;
            };
            _vehicle setPilotCameraTarget _target;
            tgp_main_pilotCameraTarget = getPilotCameraTarget _vehicle;
        } else {
            (_intersections # 0) params ["_intersectPosASL", "_surfaceNormal", "_intersectObject", "_parentObject"];
            _vehicle setPilotCameraTarget _intersectPosASL;
            tgp_main_pilotCameraTarget = getPilotCameraTarget _vehicle;
        };
    };
};
