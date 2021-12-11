/*
 * Author: Ampersand
 * Set variables for current seat
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * call tgp_main_fnc_setup
 */

params ["_unit", "_vehicle"];

if (
    _unit != driver _vehicle ||
    {!hasPilotCamera _vehicle}
) exitWith {false};

private _vehicleConfig = configOf _vehicle;
private _pilotCameraConfig = _vehicleConfig >> "pilotCamera";
if (!isClass _pilotCameraConfig) exitWith {false};

private _controllable = (_pilotCameraConfig >> "controllable") call BIS_fnc_getCfgDataBool;
if (!_controllable) exitWith {false};

tgp_main_minTurn = getNumber (_pilotCameraConfig >> "minTurn") / 180 * pi;
tgp_main_maxTurn = getNumber (_pilotCameraConfig >> "maxTurn") / 180 * pi;
tgp_main_minElev = getNumber (_pilotCameraConfig >> "minElev") / 180 * pi;
tgp_main_maxElev = getNumber (_pilotCameraConfig >> "maxElev") / 180 * pi;

tgp_main_aspectRatio = getResolution # 4;
tgp_main_featureCamera = "";
tgp_main_pilotCameraTarget = getPilotCameraTarget _vehicle;

private _fovClasses = "true" configClasses (_pilotCameraConfig >> "OpticsIn");
tgp_main_OpticsInfo = createHashMapFromArray (_fovClasses apply {
	[
        getNumber (_x >> "initFov"),
		[
            getArray (_x >> "visionMode"),
      		getArray (_x >> "thermalMode")
        ]
	]
});
tgp_main_camFOVLevels = keys tgp_main_OpticsInfo;
tgp_main_camFOVLevels sort false; // Descending
tgp_main_FOV = tgp_main_camFOVLevels # 0;

tgp_main_camPos = getPilotCameraPosition _vehicle;

call tgp_main_fnc_setIsPipHidden;

true
