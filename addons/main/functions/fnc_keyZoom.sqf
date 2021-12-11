/*
 * Author: Ampersand
 * Change the zoom level
 *
 * Arguments:
 * 0: Change <NUMBER>
 *
 * Return Value:
 * Success
 *
 * Example:
 * [1] call tgp_main_fnc_keyZoom // In
 * [-1] call tgp_main_fnc_keyZoom // Out
 */

params ["_change"];

if (tgp_main_pipIsFixed && {!tgp_main_isInScriptedCamera}) exitWith {false};
private _currStep = tgp_main_camFOVLevels findIf {_x == tgp_main_FOV};
private _newStep = 0 max (_currStep + _change) min (count tgp_main_camFOVLevels - 1);

[tgp_main_camFOVLevels # _newStep] call tgp_main_fnc_setFOV;

true
