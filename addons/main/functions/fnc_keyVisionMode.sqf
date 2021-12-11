/*
 * Author: Ampersand
 * Get the next vision mode
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * 0: New Effect <ARRAY>
 *
 * Example:
 * call tgp_main_fnc_keyVisionMode
 */

// Get modes available at this FOV
private _pipEffects = [];
if (tgp_main_pipIsFixed && {!tgp_main_isInScriptedCamera}) then {
  _pipEffects = [[0], [1]]; // Sling cam
} else {
  private _opticsInfo = tgp_main_OpticsInfo get tgp_main_FOV;
  _opticsInfo params ["_visionModes", "_thermalModes"];
  {
    private _effect = (tgp_main_pipEffectsHashMap get _x);
    if (!isNil "_effect") then {
      _pipEffects pushBackUnique _effect;
    };
  } forEach _visionModes + _thermalModes;
};

// Increment
private _currStep = _pipEffects findIf {_x isEqualTo tgp_main_pipEffect};
private _newStep = if (_currStep == (count _pipEffects - 1) || {_currStep == -1}) then {0} else {_currStep + 1};

// Set
[_pipEffects # _newStep] call tgp_main_fnc_setVisionMode;

_pipEffects # _newStep
