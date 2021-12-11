/*
 * Author: Ampersand
 * Reset state-tracking variables
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * 0: Success <BOOLEAN>
 *
 * Example:
 * call tgp_main_fnc_initVars
 */

// Player state
tgp_main_playerIsPilot = false;
tgp_main_playerIsCopilot = false;
tgp_main_otherPilotIsPlayer = false;
tgp_main_otherPilot = objNull;

// Eventhandlers
tgp_main_playerEHs = [];
tgp_main_playerCBAEHs = [];
tgp_main_vehicleEHs = [];

// Inputs
tgp_main_inputZoom = 0;
tgp_main_inputStabilize = 0;
tgp_main_inputVisionMode = 0;
tgp_main_isSlewing = false; // Slewing using any input
tgp_main_slewAim = false; // Slewing using input Aim Up|Down|Left|Right, mostly mouse
tgp_main_up = 0; // Slewing using keys
tgp_main_down = 0;
tgp_main_left = 0;
tgp_main_right = 0;

// FLIR state
tgp_main_isPipHidden = true;
tgp_main_pipIsFixed = false;
tgp_main_featureCamera = "";
tgp_main_pilotCameraTarget = [false, [0, 0, 0], objNull]; // Separate variable due to using basegame keybind, which first toggles the basegame stabilization
tgp_main_controllable = false;
tgp_main_isInScriptedCamera = false;
tgp_main_playerIsPilot = false;
tgp_main_playerIsCopilot = false;
tgp_main_otherPilot = objNull;
tgp_main_otherPilotIsPlayer = false;
tgp_main_isCopilotInGunnerView = false;
tgp_main_lastSyncTimePilotCamera = 0;
tgp_main_lastSyncTimeAnimation = 0;
tgp_main_pipEffect = [];
