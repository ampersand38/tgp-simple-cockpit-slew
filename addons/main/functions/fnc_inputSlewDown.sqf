#include "script_component.hpp"
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
 * call tgp_main_fnc_inputSlewDown
 */

EXITCHECK
[] call tgp_main_fnc_setup;

tgp_main_slewAim = true;

if (tgp_main_setting_AimSlewBlockMouse && {isNil "ace_interact_menu_keyDown" || {!ace_interact_menu_keyDown}}) then {
    if (!(uiNamespace getVariable ["tgp_main_mouseBlocker", false])) then {
        setMousePosition [0.5, 0.5];
        (findDisplay 46) createDisplay "tgp_main_mouseBlocker";
        (finddisplay 86005) displayAddEventHandler ["KeyUp", {[_this,'keyup'] call CBA_events_fnc_keyHandler}];
    };
};

switch (GVAR(mode)) do {
    case (MODE_PILOTCAMERA): {
        [FUNC(handleSlew), 0] call CBA_fnc_addPerFrameHandler;
    };
    case (MODE_TURRET): {
        if (!GVAR(isAutonomous)) then {tgp_main_vehicle setAutonomous true;};
        [FUNC(handleSlewTurret), 0] call CBA_fnc_addPerFrameHandler;
    };
}; // switch

false
