/*
 * Author: Ampersand
 * Handle inputs for Zoom and Vision Mode while in scripted camera
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * [] call tgp_main_fnc_handleKeyInputs
 */

// PIP Vision Mode
private _visionMode = inputAction "transportNightVision";
if (_visionMode > 0) then {
  if (tgp_main_transportNightVision == 0) then {
    tgp_main_transportNightVision = ceil _visionMode;
    [] call tgp_main_fnc_keyVisionMode;
  };
} else {
  tgp_main_transportNightVision = 0;
};

if (!tgp_main_controllable) exitWith {};

// Stabilize enables object tracking anywhere
private _stab = inputAction "vehLockTurretView";
if (_stab > 0) then {
  if (tgp_main_inputStabilize == 0) then {
    tgp_main_inputStabilize = ceil _stab;
    if (tgp_main_isInScriptedCamera) then {
      [
         AGLToASL positionCameraToWorld [0, 0, 0],
         AGLToASL positionCameraToWorld [0, 0, 5000]
      ] call tgp_main_fnc_setStabilization;
    } else {
      [] call tgp_main_fnc_setStabilization;
    };
  };
} else {
  tgp_main_inputStabilize = 0;
}; // Stabilize

if (tgp_main_playerIsCopilot) then {
  // Laser
  private _laser = inputAction "fire"; // Ctrl+Click
  if (_laser > 0) then {
    if (tgp_main_inputToggleLaser == 0) then {
      tgp_main_inputToggleLaser = ceil _laser;
      [_vehicle] call tgp_main_fnc_toggleLaser;
    };
  } else {
    tgp_main_inputToggleLaser = 0;
  };

  // Copilot Camera
  if (tgp_main_isInScriptedCamera) then {
    // Next Weapon
    private _nextWeapon = inputAction "nextWeapon"; // Next Weapon
    if (_nextWeapon > 0) then {
      if (tgp_main_inputNextWeapon == 0) then {
        tgp_main_inputNextWeapon = ceil _nextWeapon;
        [_vehicle, [0]] call tgp_main_fnc_nextWeapon;
      };
    } else {
      tgp_main_inputNextWeapon = 0;
    };

    // Fire
    private _fireWeapon = inputAction "defaultAction"; // Click
    if (_fireWeapon > 0) then {
      if (tgp_main_inputFireWeapon == 0) then {
        tgp_main_inputFireWeapon = ceil _fireWeapon;
        [_vehicle] call tgp_main_fnc_fireWeapon;
      };
    } else {
      tgp_main_inputFireWeapon = 0;
    };

    // Zoom
    private _in = inputAction "zoomIn";
    private _out = inputAction "zoomOut";
    if (_in > 0 || {_out > 0}) then {
      if (tgp_main_inputZoom == 0) then {
        tgp_main_inputZoom = (ceil _in) - (ceil _out);
        [tgp_main_inputZoom] call tgp_main_fnc_keyZoom;
      };
    } else {
      tgp_main_inputZoom = 0;
    };

    // Vision Mode
    private _visionMode = inputAction "cameraVisionMode";
    if (_visionMode > 0) then {
      if (tgp_main_inputVisionMode == 0) then {
        tgp_main_inputVisionMode = ceil _visionMode;
        [] call tgp_main_fnc_keyVisionMode;
      };
    } else {
      tgp_main_inputVisionMode = 0;
    };

  }; // isInScriptedCamera

}; // playerIsCopilot

true
