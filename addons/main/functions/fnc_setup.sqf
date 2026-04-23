#include "script_component.hpp"
/*
 * Author: Ampersand
 * Set variables for current seat
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Slew Mode <NUMBER>
 *
 * Example:
 * [] call tgp_main_fnc_setup
 */

private _unit = focusOn;
private _vehicle = objectParent _unit;
private _continue = true;

RESET_VARIABLES

// Group Unit
private _groupSelectedUnit = groupSelectedUnits focusOn param [0, objNull];
if (
    _continue
    && {!isNull _groupSelectedUnit} // A group unit is selected
    && {!isNull objectParent _groupSelectedUnit} // Unit is in a vehicle
    && {[objectParent _groupSelectedUnit, objectParent _groupSelectedUnit unitTurret _groupSelectedUnit] call FUNC(isSlewable)} // Vehicle has a slewable turret
) then {
    _continue = false;
    _unit = _groupSelectedUnit;
    _vehicle = objectParent _groupSelectedUnit;
};

// Camera Feed
private _infoPanels = [
    ["left", "right"],
    ["right", "left"]
] select tgp_main_setting_feedPref;

{
    // Current result is saved in variable _x
    if (!_continue) then {continue;};
    switch (infoPanel _x) do {
        case ["VehicleDriverDisplay","TransportFeedDisplayComponent"]: {
            if ([_vehicle, driver _vehicle] call FUNC(isSlewable)) then {
                _continue = false;
                _unit = driver _vehicle;
            };
        };
        case ["VehiclePrimaryGunnerDisplay","TransportFeedDisplayComponent"]: {
            if ([_vehicle, gunner _vehicle] call FUNC(isSlewable)) then {
                _continue = false;
                _unit = gunner _vehicle;
            };
        };
        case ["VehicleCommanderDisplay","TransportFeedDisplayComponent"]: {
            if ([_vehicle, commander _vehicle] call FUNC(isSlewable)) then {
                _continue = false;
                _unit = commander _vehicle;
            };
        };
        case ["UAVDisplay","UAVFeedDisplayComponent"]: {
            private _uav = getConnectedUAV _unit;
            if ([_uav, gunner _uav] call FUNC(isSlewable)) then {
                _continue = false;
                _unit = gunner _uav;
                _vehicle = _uav;
            };
            if (_continue && {[_uav, driver _uav] call FUNC(isSlewable)}) then {
                _continue = false;
                _unit = driver _uav;
                _vehicle = _uav;
            };
        };
        default { };
    };

} forEach _infoPanels;

if ([_vehicle, _unit] call FUNC(isSlewable)) exitWith {
    if (unitIsUAV _vehicle && {!isAutonomous _vehicle}) then {
        _vehicle setAutonomous true;
    };

    private _turretConfig = [_vehicle, tgp_main_turret] call CBA_fnc_getTurret;
    tgp_main_minTurn = getNumber (_turretConfig >> "minTurn");
    tgp_main_maxTurn = getNumber (_turretConfig >> "maxTurn");
    tgp_main_minElev = getNumber (_turretConfig >> "minElev");
    tgp_main_maxElev = getNumber (_turretConfig >> "maxElev");
    //tgp_main_animSrcBody = getText (_turretConfig >> "animationSourceBody");
    //tgp_main_animSrcGun = getText (_turretConfig >> "animationSourceGun");
    tgp_main_camPos = getText (_turretConfig >> "memoryPointGunnerOptics");
    if (tgp_main_camPos == "pip0_pos") then {
        tgp_main_camDir = "pip0_dir";
    } else {
        tgp_main_camPos = getText (_turretConfig >> "gunEnd");
        tgp_main_camDir = getText (_turretConfig >> "gunBeg");
    };

    private _lockedTo = _vehicle lockedCameraTo tgp_main_turret;
    tgp_main_cameraTarget = if (isNil "_lockedTo") then {
        [false, [0, 0, 0], objNull]
    } else {
        if (_lockedTo isEqualType objNull) then {
            [true, getPosASL _lockedTo, _lockedTo]
        } else {
            [true, _lockedTo, objNull]
        };
    };
    tgp_main_vehicle = _vehicle;
    tgp_main_turret = [0];
    tgp_main_FOV = getNumber (_turretConfig >> "ViewGunner" >> "initFov");

    GVAR(mode) = MODE_TURRET;
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
tgp_main_cameraTarget = getPilotCameraTarget _vehicle;
tgp_main_turret = [-1];
tgp_main_vehicle = _vehicle;
tgp_main_FOV = selectMax (("true" configClasses (_pilotCameraConfig >> "OpticsIn")) apply {
    private _fov = (_x >> "initFOV") call BIS_fnc_getCfgData;
    if (_fov isEqualType "") then {parseNumber _fov} else {_fov}
});

GVAR(mode) = MODE_PILOTCAMERA;
MODE_PILOTCAMERA
