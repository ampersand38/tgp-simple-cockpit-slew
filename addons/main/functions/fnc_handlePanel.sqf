#include "script_component.hpp"
/*
 * Author: Ampersand
 * Waits for new panel then runs setup. Run by user action EH.
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * call tgp_main_fnc_handlePanel
 */

private _panels = infoPanel "left" + infoPanel "right";

[{
    _this isNotEqualTo (infoPanel "left" + infoPanel "right");
}, FUNC(setup), _panels, 1] call CBA_fnc_waitUntilAndExecute;
