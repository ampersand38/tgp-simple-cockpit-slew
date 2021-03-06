/*
 * Author: Ampersand
 * Start slewing TGP
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * Block other input
 *
 * Example:
 * call tgp_main_fnc_keyDownSlew
 */

if (
    !tgp_main_hasPilotCamera ||
    {cameraView != "INTERNAL"} ||
    {visibleMap} ||
    {!isNull curatorCamera}
) exitWith {false};

private _unit = call CBA_fnc_currentUnit;
private _vehicle = vehicle _unit;

tgp_main_slewAim = true;

if (tgp_main_setting_AimSlewBlockMouse && {isNil "ace_interact_menu_keyDown" || {!ace_interact_menu_keyDown}}) then {
    if (!(uiNamespace getVariable ["tgp_main_mouseBlocker", false])) then {
        setMousePosition [0.5, 0.5];
        (findDisplay 46) createDisplay "tgp_main_mouseBlocker";
        (finddisplay 86005) displayAddEventHandler ["KeyUp", {[_this,'keyup'] call CBA_events_fnc_keyHandler}];
    };
};

[{
    params ["", "_pfID"];
    if (!tgp_main_slewAim) exitWith {
        [_pfID] call CBA_fnc_removePerFrameHandler;
    };
    [] call tgp_main_fnc_handleSlew;
}, 0] call CBA_fnc_addPerFrameHandler;

false
