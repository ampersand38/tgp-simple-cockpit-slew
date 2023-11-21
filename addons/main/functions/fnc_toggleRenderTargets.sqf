#include "script_component.hpp"
/*
 * Author: Ampersand
 * Toggle vehicle pip rtt effects
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: State <NUMBER>
 *      0: All off
 *      1: All on
 *      2: Toggle All
 *
 * Return Value:
 * None.
 *
 * Example:
 * [2] call tgp_main_fnc_toggleRenderTargets
 */

if (
    visibleMap
    || {!isNull curatorCamera}
    || {cameraView != "Internal"}
) exitWith {false};

params [["_vehicle", cameraOn], ["_state", 2]];

if (_vehicle == focusOn) exitWith {};

private _renderTargets = _vehicle getVariable [QGVAR(renderTargets), []];
if (_renderTargets isEqualTo []) then {
    // Not initialized, get config
    _renderTargets = "true" configClasses (configOf _vehicle >> "RenderTargets") apply { getText(_x >> "renderTarget") };
    if (_renderTargets isEqualTo []) then {
        _renderTargets = false;
    };
    _vehicle setVariable [QGVAR(renderTargets), _renderTargets];
};
if (_renderTargets isEqualTo false) exitWith {};

switch (_state) do {
    case false;
    case PIPSTATE_OFF: {
        {
            _vehicle cameraEffect ["terminate", "FRONT", _x];
            _vehicle setVariable [format ["%1%2", QGVAR(RTT), _x], false];
        } forEach _renderTargets;
    };
    case true;
    case PIPSTATE_ON: {
        _vehicle cameraEffect ["terminate", "FRONT"];
        {
            _vehicle setVariable [format ["%1%2", QGVAR(RTT), _x], true];
        } forEach _renderTargets;
    };
    case PIPSTATE_TOGGLE: {
        private _xState = _vehicle getVariable [format ["%1%2", QGVAR(RTT), _renderTargets select 0], true];
        [_vehicle, !_xState] call FUNC(toggleRenderTargets);
    };
    default {};
};
