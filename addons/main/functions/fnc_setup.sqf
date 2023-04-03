#include "script_component.hpp"
/*
 * Author: Ampersand
 * Set variables for current seat
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Slew Mode <NUMBER>
 *
 * Example:
 * [] call tgp_main_fnc_setup
 */

params [["_unit", call CBA_fnc_currentUnit], ["_vehicle", vehicle call CBA_fnc_currentUnit]];

RESET_VARIABLES

private _uav = getConnectedUAV _unit;
if (
    shownUAVFeed
    && {!isNull _uav}
) then {
    _vehicle = _uav;
};
if (_vehicle == _unit) exitWith {MODE_FAILED};

if ([_vehicle] call FUNC(isSlewable)) exitWith {
    private _turretConfig = [_vehicle, [0]] call CBA_fnc_getTurret;
    tgp_main_minTurn = getNumber (_turretConfig >> "minTurn") / 180 * pi;
    tgp_main_maxTurn = getNumber (_turretConfig >> "maxTurn") / 180 * pi;
    tgp_main_minElev = getNumber (_turretConfig >> "minElev") / 180 * pi;
    tgp_main_maxElev = getNumber (_turretConfig >> "maxElev") / 180 * pi;
    tgp_main_animSrcBody = getText (_turretConfig >> "animationSourceBody");
    tgp_main_animSrcGun = getText (_turretConfig >> "animationSourceGun");

    tgp_main_camPos = getText (_turretConfig >> "memoryPointGunnerOptics");
    tgp_main_gunBeg = getText (_turretConfig >> "gunBeg");
    tgp_main_gunEnd = getText (_turretConfig >> "gunEnd");
    private _lockedTo = _vehicle lockedCameraTo [0];
    tgp_main_pilotCameraTarget = if (_lockedTo isEqualTo objNull) then {
        [false, [0, 0, 0], objNull]
    } else {
        if (_lockedTo isEqualType objNull) then {
            [true, getPosASL _lockedTo, _lockedTo]
        } else {
            [true, _lockedTo, objNull]
        };
    };
    tgp_main_vehicle = _vehicle;
    GVAR(isAutonomous) = isAutonomous tgp_main_vehicle;
    tgp_main_FOV = getNumber (_turretConfig >> "ViewGunner" >> "initFov");

    MODE_TURRET
};

if (_unit != driver _vehicle) exitWith {MODE_FAILED};
if (!hasPilotCamera _vehicle) exitWith {MODE_FAILED};

private _vehicleConfig = configOf _vehicle;
private _pilotCameraConfig = _vehicleConfig >> "pilotCamera";
if (!isClass _pilotCameraConfig) exitWith {MODE_FAILED};

private _controllable = (_pilotCameraConfig >> "controllable") call BIS_fnc_getCfgDataBool;
if (!_controllable) exitWith {MODE_FAILED};

tgp_main_minTurn = getNumber (_pilotCameraConfig >> "minTurn") / 180 * pi;
tgp_main_maxTurn = getNumber (_pilotCameraConfig >> "maxTurn") / 180 * pi;
tgp_main_minElev = getNumber (_pilotCameraConfig >> "minElev") / 180 * pi;
tgp_main_maxElev = getNumber (_pilotCameraConfig >> "maxElev") / 180 * pi;

tgp_main_camPos = getPilotCameraPosition _vehicle;
tgp_main_pilotCameraTarget = getPilotCameraTarget _vehicle;
tgp_main_vehicle = _vehicle;
tgp_main_FOV = selectMax (("true" configClasses (_pilotCameraConfig >> "OpticsIn")) apply {
    call compile ((_x >> "initFOV") call BIS_fnc_getCfgData)
});

MODE_PILOTCAMERA
