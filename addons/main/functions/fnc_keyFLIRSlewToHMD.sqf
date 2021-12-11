/*
 * Author: Ampersand
 * Lock FLIR to current aim pos or obj
 *
 * Arguments:
 * None
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * [] call tgp_main_fnc_keyFLIRSlewToHMD
 */

if (
  !tgp_main_controllable
) exitWith {};

[
  AGLToASL positionCameraToWorld [0, 0, 0],
  AGLToASL positionCameraToWorld [0, 0, 5000]
] call tgp_main_fnc_setStabilization;

true
