#include "\a3\ui_f\hpp\definedikcodes.inc"

[
    "TGP Simple Cockpit Slew","tgp_main_key_slew", // B
    [LSTRING(SlewHold), LSTRING(SlewHold_Tooltip)],
    tgp_main_fnc_inputSlewDown, tgp_main_fnc_inputSlewUp,
    [48, [false, false, false]], false
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew","tgp_main_key_slewHMD", // Shift + T
    [LSTRING(HMD), LSTRING(HMD_Tooltip)],
    {[] call tgp_main_fnc_keyFLIRSlewToHMD; false}, {},
    [20, [true, false, false]], false
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew","tgp_main_key_slewWaypoint", // Alt + T
    [LSTRING(Waypoint), LSTRING(Waypoint_Tooltip)],
    {[] call tgp_main_fnc_keySlewToWaypoint; false}, {},
    [20, [false, false, true]], false
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew","tgp_main_key_stabilize", // Ctrl + T
    [LSTRING(Stabilize), LSTRING(Stabilize_Tooltip)],
    {[] call tgp_main_fnc_setStabilization; false}, {},
    [20, [false, true, false]], false
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew","tgp_main_key_ccip", // Ctrl + Alt + T
    [LSTRING(CCIP), LSTRING(CCIP_Tooltip)],
    {[] call tgp_main_fnc_trackCCIP; false}, {},
    [20, [false, true, true]], false
] call CBA_fnc_addKeybind;

/*
[
    "TGP Simple Cockpit Slew","tgp_main_key_zoom_inc","FLIR Zoom In", // PLUS
    {
        if (tgp_main_isPipHidden) exitWith {false};
        [1] call tgp_main_fnc_keyZoom;
        false
    },{},
    [13, [false, false, false]],false
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew","tgp_main_key_zoom_desc","FLIR Zoom Out", // MIN
    {
        if (tgp_main_isPipHidden) exitWith {false};
        [-1] call tgp_main_fnc_keyZoom;
        false
    },{},
    [12, [false, false, false]],false
] call CBA_fnc_addKeybind;

[
"TGP Simple Cockpit Slew","tgp_main_key_up","Slew Up", // Control + W
{if (tgp_main_isPipHidden) exitWith {false}; tgp_main_up = 1; false},{tgp_main_up = 0;},
[17, [false, true, false]],false
] call CBA_fnc_addKeybind;

[
"TGP Simple Cockpit Slew","tgp_main_key_down","Slew Down", // Control + S
{if (tgp_main_isPipHidden) exitWith {false}; tgp_main_down = 1; false},{tgp_main_down = 0;},
[31, [false, true, false]],false
] call CBA_fnc_addKeybind;

[
"TGP Simple Cockpit Slew","tgp_main_key_left","Slew Left", // Control + A
{if (tgp_main_isPipHidden) exitWith {false}; tgp_main_left = 1; false},{tgp_main_left = 0;},
[30, [false, true, false]],false
] call CBA_fnc_addKeybind;

[
"TGP Simple Cockpit Slew","tgp_main_key_right","Slew Right", // Control + D
{if (tgp_main_isPipHidden) exitWith {false}; tgp_main_right = 1; false},{tgp_main_right = 0;},
[32, [false, true, false]],false
] call CBA_fnc_addKeybind;
*/
