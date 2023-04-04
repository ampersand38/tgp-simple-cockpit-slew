#include "script_component.hpp"
/*
 * Author: Ampersand
 * Stop slewing TGP
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * Block other input
 *
 * Example:
 * call tgp_main_fnc_inputSlewUp
 */

if (uiNamespace getVariable ["tgp_main_mouseBlocker", false]) then {
    (findDisplay 86005) closeDisplay 0;
};
tgp_main_slewAim = false;
if (!isNull tgp_gunner) then {deleteVehicle tgp_gunner};
