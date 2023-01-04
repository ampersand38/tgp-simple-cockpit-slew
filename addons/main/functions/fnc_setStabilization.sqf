/*
 * Author: Ampersand
 * Lock FLIR to current aim pos or obj
 *
 * Arguments:
 * 0: Camera Position ASL <ARRAY>
 * 1: Target Position ASL <ARRAY>
 * 2: Sync <BOOLEAN>
 *
 * Return Value:
 * Success
 *
 * Example:
 * [] call tgp_main_fnc_setStabilization
 */

params [
  ["_camPosASL", []],
  ["_tgtPosASL", []],
  ["_sync", true]
];

private _unit = call CBA_fnc_currentUnit;
private _vehicle = vehicle _unit;
if (_unit == _vehicle) exitWith {false};
if !(hasPilotCamera _vehicle) exitWith {false};

tgp_main_pilotCameraTarget params ["_isTracking", "", "_trackObj"];

if (_camPosASL isEqualTo []) then {
  _camPosASL = AGLToASL (_vehicle modelToWorldVisual (tgp_main_camPos));
};
if (_tgtPosASL in [[0, 0, 0], []]) then {
  private _flirDir = _vehicle vectorModelToWorldVisual (getPilotCameraDirection _vehicle);
  _tgtPosASL = _camPosASL vectorAdd (_flirDir vectorMultiply worldSize);
};

private _intersections = lineIntersectsSurfaces [_camPosASL, _tgtPosASL, _vehicle];
private _target = objNull;
private _targetObject = objNull;
if (_intersections isEqualTo []) then {
    if (!_isTracking) then {
        _target = terrainIntersectAtASL [_camPosASL, _tgtPosASL];
        if (_target isEqualTo [0,0,0]) then {
            _target = _tgtPosASL;
        };
    };
} else {
    (_intersections # 0) params ["_intersectPosASL", "_surfaceNormal", "_intersectObject", "_parentObject"];
    if (isNull _intersectObject) then {
        // Terrain
        _target = [_intersectPosASL, objNull] select _isTracking; // if already tracking position, untrack
    } else {
        _targetObject = _intersectObject;
        // Object
        if (speed _intersectObject > 0) then {
            // Moving vehicle
            _target = [objNull, _intersectObject] select (_trackObj != _intersectObject); // if already tracking same object, untrack
            systemChat str _target;
        } else {
            // Stationary target
            _target = [objNull, _intersectPosASL] select (_trackObj != _intersectObject); // if already tracking same object, untrack
        };
    };
};

[{(_this # 0) setPilotCameraTarget (_this # 1)}, [_vehicle, _target]] call CBA_fnc_execNextFrame;
_vehicle setPilotCameraTarget _target;
tgp_main_pilotCameraTarget = getPilotCameraTarget _vehicle;
tgp_main_pilotCameraTarget set [2, [objNull, _targetObject] select (_target isEqualType [])];

true
