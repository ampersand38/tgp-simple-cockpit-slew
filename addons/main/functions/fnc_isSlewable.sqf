#include "script_component.hpp"
/*
 * Author: Ampersand
 * Checks if player has a slewable turret's AI gunner selected
 *
 * Arguments:
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * [vehicle player] call tgp_main_fnc_isSlewable
 */

#define STABILIZEDINAXES_XY 3

params ["_vehicle"];

if (unitIsUAV _vehicle) exitWith {true};

private _turretConfig = [_vehicle, [0]] call CBA_fnc_getTurret;
if (getNumber (_turretConfig >> "stabilizedInAxes") != STABILIZEDINAXES_XY) exitWith {false};

private _player = call CBA_fnc_currentUnit;
private _gunner = _vehicle turretUnit [0];
if (isPlayer _gunner) exitWith {};
if (isNull _gunner && {tgp_main_setting_createGunner}) then {
    private _uavAI = switch (side _player) do {
        case (blufor): { "B_UAV_AI" };
        case (opfor): { "O_UAV_AI" };
        case (independent): { "I_UAV_AI" };
        case (civilian): { "C_UAV_AI" };
    };
    tgp_gunner = group call CBA_fnc_currentUnit createUnit [_uavAI, [0, 0, 0], [], 0, "CAN_COLLIDE"];
    tgp_gunner moveInGunner _vehicle;
};

true
