/*
 * Author: Yax
 * Start the pip camera
 *
 * Arguments:
 * 0: Helicopter <OBJECT>
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * [_vehicle] call tgp_main_fnc_pipStart
 */

if (isNil "tgp_main_camera") then {
  tgp_main_camera = "camera" camCreate [0,0,0];
};

tgp_main_camera cameraEffect ["internal", "BACK", "tgp_main_feed"];
"tgp_main_feed" setPiPEffect [3,0.6,0.7,0.2,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
tgp_main_camera camSetFocus [-1,-1];
tgp_main_camera camCommit 0;

call tgp_main_fnc_setIsPipHidden;

true
