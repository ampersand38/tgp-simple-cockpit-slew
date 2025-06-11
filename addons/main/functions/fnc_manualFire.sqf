#include "script_component.hpp"
/*
 * Author: Ampersand
 * Enable manual fire and start the gunner tracking the player's view.
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * call tgp_main_fnc_manualFire
 */

#define MAX_ANGLE 5 // rad 5

if (
    GVAR(isRunningManualFire)
    || {[] call CBA_fnc_getActiveFeatureCamera != ""}
    || {visibleMap}
) exitWith {
    GVAR(isRunningManualFire) = false;
};

private _player = call CBA_fnc_currentUnit;
private _vehicle = vehicle _player;

if (
    _vehicle == _player
    || {!local _vehicle}
    || {effectiveCommander _vehicle != _player}
) exitWith {};

private _groupSelectedUnits = groupSelectedUnits player;
private _hasSelection = _groupSelectedUnits isNotEqualTo [];
private _manualFires = [];

{
    private _turretPath = _x;
    private _gunner = _vehicle turretUnit _turretPath;
    weaponState [_vehicle, _turretPath] params ["_weapon", "_muzzle", "_fireMode", "_magazine"];

    if (
        !(_vehicle turretLocal _turretPath)
        || {!alive _gunner}
        || {_gunner == _player}
        || {_hasSelection && {!(_gunner in _groupSelectedUnits)}}
        || {(_vehicle weaponsTurret _turretPath) isEqualTo []}
        || {
            private _ammo = getText (configFile >> "CfgMagazines" >> _magazine >> "ammo");
            private _ammoSimulation = getText (configFile >> "CfgAmmo" >> _ammo >> "simulation");
            _ammoSimulation == "laserDesignate"
        }
    ) then {continue;};

    private _turretCfg = [_vehicle, _turretPath] call CBA_fnc_getTurret;

    if (abs getNumber (_turretCfg >> "initTurn") == 180) then {continue;};

    private _opticsSel = getText (_turretCfg >> "memoryPointGunnerOptics");

    _manualFires pushBack [_turretPath, _opticsSel, _gunner, _muzzle, _fireMode];
} forEach allTurrets _vehicle;

if (_manualFires isEqualTo []) exitWith {};

GVAR(isRunningManualFire) = true;
[{
    params ["_args", "_pfhID"];
    _args params ["_unit", "_vehicle", "_manualFires"];

    private _hint = [];

    // Exit if target object is deleted
    if (
        !GVAR(isRunningManualFire)
        || {[] call CBA_fnc_getActiveFeatureCamera != ""}
        || {visibleMap}
        || {!alive _unit}
        || {!alive _vehicle}
        || {!(_unit in _vehicle)}
    ) exitWith {
        {
            _vehicle lockCameraTo [objNull, _x select 0, true];
        } forEach _manualFires;
        GVAR(isRunningManualFire) = false;
        //hintSilent "";
        [_pfhID] call CBA_fnc_removePerFrameHandler;
    };

    private _lockPos = AGLToASL positionCameraToWorld [0, 0, 10000];
    private _lockDir = positionCameraToWorld [0, 0, 0] vectorFromTo _lockPos;
    {
        _x params ["_turretPath", "_opticsSel", "_gunner", "_muzzle", "_fireMode"];

        if (
            !alive _gunner
            || {_gunner != (_vehicle turretUnit _turretPath)}
        ) then {
            _manualFires deleteAt _forEachIndex;
            continue;
        };

        _vehicle lockCameraTo [_lockPos, _turretPath, true];

        private _opticsPos = _vehicle modelToWorldVisualWorld (_vehicle selectionPosition _opticsSel);
        _vehicle selectionVectorDirAndUp [_opticsSel, 1e15] params ["_gunDir"];
        _gunDir = _vehicle vectorModelToWorldVisual _gunDir;

        private _angle = acos (_lockDir vectorDotProduct _gunDir);
        if (!(_angle isEqualType 0)) then {
            _angle = 0;
        };
            _hint set [_forEachIndex, ["Aiming", _turretPath, _angle toFixed 1, "deg"]];

        #ifdef DEBUG_MODE_FULL
            drawLine3D [ASLToAGL _opticsPos, ASLToAGL _lockPos, [1,1,1,1]];
            private _colour = if (_angle > MAX_ANGLE) then {
                [1,0,0,1]
            } else {
                [0,1,0,1]
            };
            drawLine3D [ASLToAGL _opticsPos, ASLToAGL _opticsPos vectorAdd (_gunDir vectorMultiply 10000), _colour];
            drawIcon3D [
                "",
                _colour,
                ASLToAGL _opticsPos,
                1,1,0,
                _angle toFixed 1
            ];
        #endif

        if ((inputAction "defaultAction" + inputAction "fire") == 0) then {continue;};

        if (_angle > MAX_ANGLE) then {continue;};

        #ifdef DEBUG_MODE_FULL
            //hintSilent str ["Firing", _turretPath, _muzzle];
        #endif
            _hint set [_forEachIndex, ["Firing", _turretPath, _muzzle]];

        _gunner forceWeaponFire [_muzzle, _fireMode];
    } forEachReversed _manualFires;

    if (tgp_main_setting_manualFireHint) then {
        hintSilent (_hint joinString endl);
    };
}, 0, [_unit, _vehicle, _manualFires]] call CBA_fnc_addPerFrameHandler;
