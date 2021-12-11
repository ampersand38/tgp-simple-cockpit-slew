// pilotCamera
// zoomIn, zoomOut
// cameraVisionMode
// AimDown, AimLeft, AimRight, AimUp
// tgp_main_fnc_perFrame

params ["_vehicle", "_frameTime"];

if (!tgp_main_isPipHidden || {tgp_main_isInScriptedCamera} || {tgp_main_playerIsPilot && cameraView == "GUNNER"}) then {
  [_vehicle] call tgp_main_fnc_handleKeyInputs;
  [_vehicle] call tgp_main_fnc_handleSlew;
};

if (tgp_main_isPipHidden && {!tgp_main_isInScriptedCamera}) exitWith {};

[_vehicle] call tgp_main_fnc_updateCamera;
_this call tgp_main_fnc_updateUIValues;
