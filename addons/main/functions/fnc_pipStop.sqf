/*
 * Author: Yax
 * Disable the pip camera
 *
 * Arguments:
 * 0: Helicopter <OBJECT>
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * [_vehicle] call tgp_main_fnc_pipStop
 */

//params ["_vehicle"];

camDestroy tgp_main_camera;
tgp_main_camera cameraEffect ["terminate", "back", "tgp_main_feed"];
tgp_main_camera = nil;

true
