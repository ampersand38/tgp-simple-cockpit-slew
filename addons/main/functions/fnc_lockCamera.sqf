#include "script_component.hpp"
/*
 * Author: Ampersand
 * Lock camera or turret to given target
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
 * [false [0, 0, 0], objNull] call tgp_main_fnc_lockCamera
 */

params ["_isTracking", "_position", "_object"];

tgp_main_cameraTarget = _this;
private _target = _this call FUNC(parseCameraTarget);

switch (GVAR(mode)) do {
    case (MODE_PILOTCAMERA): {
        tgp_main_vehicle setPilotCameraTarget _target;
    };
    case (MODE_TURRET): {
        tgp_main_vehicle lockCameraTo [_target, tgp_main_turret, true];
        if (_isTracking && {GVAR(holdTurretLockPFHID) < 0}) then {
            GVAR(holdTurretLockPFHID) = [FUNC(holdTurretLock), 0] call CBA_fnc_addPerFrameHandler;
        };
    };
};
