#include "script_component.hpp"
/*
 * Author: Ampersand
 * Checks if player has a slewable turret's AI gunner selected
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Gunner or Turret Path <OBJECT or ARRAY>
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * [cameraOn] call tgp_main_fnc_isSlewable
 */

#define STABILIZEDINAXES_XY 3

params ["_vehicle", ["_turret", focusOn]];

if (_turret isEqualTo objNull || {_turret isEqualTo []}) exitWith {false};

if (_turret isEqualType objNull) then {
    _turret = _vehicle unitTurret _turret;
};

GVAR(slewableTurretsHM) getOrDefaultCall [[typeOf _vehicle, _turret], {
    if (_turret isEqualTo [-1]) exitWith {
        (configOf _vehicle >> "pilotCamera" >> "controllable") call BIS_fnc_getCfgDataBool
    };

    private _turretConfig = [_vehicle, _turret] call CBA_fnc_getTurret;
    if (
        getText (_turretConfig >> "body") == ""
        || {getText (_turretConfig >> "gun") == ""}
        || {getText (_turretConfig >> "animationSourceBody") == ""}
        || {getText (_turretConfig >> "animationSourceGun") == ""}
    ) exitWith {false};

    private _gunner = _vehicle turretUnit _turret;
    if (isNull _gunner && {tgp_main_setting_createGunner}) then {
        private _uavAI = switch (side focusOn) do {
            case (blufor): { "B_UAV_AI" };
            case (opfor): { "O_UAV_AI" };
            case (independent): { "I_UAV_AI" };
            case (civilian): { "C_UAV_AI" };
        };
        tgp_gunner = group focusOn createUnit [_uavAI, [0, 0, 0], [], 0, "CAN_COLLIDE"];
        tgp_gunner moveInGunner _vehicle;
    };

    true
}, true];
