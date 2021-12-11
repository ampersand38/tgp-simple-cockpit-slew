/*
 * Author: Ampersand
 * Sync the turret/camera fov value to the player [co]pilot
 *
 * Arguments:
 * 0: FOV <NUMBER>
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * [_fov] call tgp_main_fnc_setFOV
 */

params ["_fov", ["_sync", true]];

tgp_main_FOV = _fov;
tgp_main_camera camSetFov _fov;

if (_sync && {tgp_main_otherPilotIsPlayer}) then {
  ["tgp_main_syncFOV", [_fov], [tgp_main_otherPilot]] call CBA_fnc_targetEvent;
};


true
