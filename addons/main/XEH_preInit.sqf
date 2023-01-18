#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"
#include "initSettings.sqf";

tgp_main_hasPilotCamera = false;
tgp_main_isSlewing = false;
tgp_main_isTrackingCCIP = false;
tgp_main_pilotCameraTarget = [false, [0, 0, 0], objNull]; // Separate variable due to using basegame keybind, which first toggles the basegame stabilization
tgp_main_FOV = 0.5;

ADDON = true;
