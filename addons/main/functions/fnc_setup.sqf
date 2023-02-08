#include "script_component.hpp"
/*
 * Author: Ampersand
 * Set variables for current seat
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * call tgp_main_fnc_setup
 */

params ["_unit", "_vehicle"];

if (
    _unit != driver _vehicle ||
    {!hasPilotCamera _vehicle}
) exitWith {false};

private _vehicleConfig = configOf _vehicle;
private _pilotCameraConfig = _vehicleConfig >> "pilotCamera";
if (!isClass _pilotCameraConfig) exitWith {false};

private _controllable = (_pilotCameraConfig >> "controllable") call BIS_fnc_getCfgDataBool;
if (!_controllable) exitWith {false};

tgp_main_minTurn = getNumber (_pilotCameraConfig >> "minTurn") / 180 * pi;
tgp_main_maxTurn = getNumber (_pilotCameraConfig >> "maxTurn") / 180 * pi;
tgp_main_minElev = getNumber (_pilotCameraConfig >> "minElev") / 180 * pi;
tgp_main_maxElev = getNumber (_pilotCameraConfig >> "maxElev") / 180 * pi;

tgp_main_aspectRatio = getResolution # 4;
tgp_main_pilotCameraTarget = getPilotCameraTarget _vehicle;

tgp_main_camPos = getPilotCameraPosition _vehicle;
tgp_main_hasPilotCamera = true;
tgp_main_isSlewing = false;
tgp_main_pilotCameraTarget = [false, [0, 0, 0], objNull]; // Separate variable due to using basegame keybind, which first toggles the basegame stabilization

true
