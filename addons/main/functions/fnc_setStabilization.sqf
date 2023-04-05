#include "script_component.hpp"
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
  ["_tgtPosASL", []],
  ["_camPosASL", []],
  ["_track", false]
];

EXITCHECK

tgp_main_cameraTarget params ["_isTracking", "", "_oldObject"];

if (_camPosASL isEqualTo []) then {
    private _camPosASL = switch (GVAR(mode)) do {
        case (MODE_PILOTCAMERA): {
            _camPosASL = tgp_main_vehicle modelToWorldVisualWorld tgp_main_camPos
        };
        case (MODE_TURRET): {
            _camPosASL = tgp_main_vehicle modelToWorldVisualWorld (tgp_main_vehicle selectionPosition tgp_main_camPos)
        };
    };
};

if (_tgtPosASL in [[0, 0, 0], []]) then {
    private _flirDir = switch (GVAR(mode)) do {
        case (MODE_PILOTCAMERA): {
            tgp_main_vehicle vectorModelToWorldVisual (getPilotCameraDirection tgp_main_vehicle)
        };
        case (MODE_TURRET): {
            _camPosASL vectorFromTo (tgp_main_vehicle modelToWorldVisualWorld (tgp_main_vehicle selectionPosition tgp_main_camDir))
        };
    };
    _tgtPosASL = _camPosASL vectorAdd (_flirDir vectorMultiply 5000);
};

// If _isTracking then untrack
private _willTrack = false;
private _newObject = objNull;
private _newPosASL = [0, 0, 0];
private _intersections = lineIntersectsSurfaces [_camPosASL, _tgtPosASL, tgp_main_vehicle];

if (_intersections isEqualTo []) then {
    // No intersections
    if (!_isTracking || {_track}) then {
        _willTrack = true;
        // Check terrain
        _newPosASL = terrainIntersectAtASL [_camPosASL, _tgtPosASL];
        if (_newPosASL isEqualTo [0, 0, 0]) then {
            _newPosASL = _tgtPosASL;
        };
    };
} else {
    (_intersections # 0) params ["_intersectPosASL", "_surfaceNormal", "_intersectObject", "_parentObject"];

    if (isNull _intersectObject) then {
        // Terrain
        if (!_isTracking || {_track}) then {
            _willTrack = true;
            _newPosASL = _intersectPosASL;
        };
    } else {
        // Object
        // If re-track on same object, untrack
        if (_oldObject == _intersectObject) then { break; };
        // If new object
        _willTrack = true;
        _newObject = _intersectObject;
        _newPosASL = _intersectPosASL;
    };
};

[_willTrack, _newPosASL, _newObject] call FUNC(lockCamera);

false
