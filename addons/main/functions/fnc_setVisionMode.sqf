/*
 * Author: Ampersand
 * Set the vision mode for scripted camera and pip
 *
 * Arguments:
 * 0: Effect <ARRAY>
 * 0: Sync <BOOLEAN>
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * [_effect] call tgp_main_fnc_setVisionMode
 */

params ["_effect", ["_sync", true]];

tgp_main_pipEffect = _effect;
"tgp_main_feed" setPiPEffect tgp_main_pipEffect;

if (tgp_main_isInScriptedCamera) then {
  camUseNVG (tgp_main_pipEffect isEqualTo [1]);
  if (tgp_main_pipEffect in [[2], [7]]) then {
    true setCamUseTI (tgp_main_pipEffectsHashMap get tgp_main_pipEffect);
  } else {
    false setCamUseTI 0
  };
};
if (!tgp_main_otherPilotIsPlayer || !_sync) exitWith { false };

["tgp_main_syncVisionMode", [_effect], [tgp_main_otherPilot]] call CBA_fnc_targetEvent;

true

/*

tgp_main_pipEffectsHashMap = createHashMapFromArray [
  ["Normal", [0]],
  ["NVG", [1]],
  ["Ti", [2]],
  [0, [2]], // thermalMode[] white-hot
  [1, [7]], // thermalMode[] black-hot
  [2, [8]], // thermalMode[] green-hot
  // backwards for getting value for setCamUseTI
  [[2], 0], // thermalMode[] white-hot
  [[7], 1], // thermalMode[] black-hot
  [[8], 2] // thermalMode[] green-hot
];

*/
