#include "script_component.hpp"
/*
 * Author: Ampersand
 * Handle zoom fov sync
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * call tgp_main_fnc_handleZoom
 */

 if (isNull tgp_main_vehicle || {cameraView != "GUNNER"}) exitWith {};

 tgp_main_FOV = getObjectFOV tgp_main_vehicle;
