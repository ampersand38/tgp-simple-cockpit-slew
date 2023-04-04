#include "script_component.hpp"
/*
 * Author: Ampersand
 * Handle slew, turret move
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * NONE
 *
 * Example:
 * call tgp_main_fnc_getCamDir
 */

// Pull the PIP pov or barrel direction, depending on how the model is set up
private _povPos = _vehicle modelToWorldVisualWorld (_vehicle selectionPosition _pov);
private _povDir = [0,0,0];

if (_pov == "pip0_pos") then {
    private _pipDir = _vehicle modelToWorldVisualWorld (_vehicle selectionPosition "pip0_dir");

    _povDir = _pipDir vectorDiff _povPos;
} else {
    private _gunBeginPos = _vehicle modelToWorldVisualWorld (_vehicle selectionPosition _gunBeg);
    private _gunEndPos = _vehicle modelToWorldVisualWorld (_vehicle selectionPosition _gunEnd);

    _povDir = _gunBeginPos vectorDiff _gunEndPos;
};
_povDir = vectorNormalized _povDir;
[_povPos, _povDir]
