#include "\a3\ui_f\hpp\definedikcodes.inc"

[
    "TGP Simple Cockpit Slew","tgp_main_key_slew",
    ["Slew Aim", "Hold this key and use mouse or 'Aim <Up|Down|Left|Right>' input to slew the Pilot Camera."], // B
    {[] call tgp_main_fnc_keyDownSlew},{
        if (uiNamespace getVariable ["tgp_main_mouseBlocker", false]) then {
            (findDisplay 86005) closeDisplay 0;
        };
        tgp_main_slewAim = false;
    },
    [48, [false, false, false]], false
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew","tgp_main_key_slewHMD", // Shift + T
    ["Slew To HMD", "Slew the Pilot Camera to the aim point of the HMD."],
    {[] call tgp_main_fnc_keyFLIRSlewToHMD; false}, {},
    [20, [true, false, false]], false
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew","tgp_main_key_slewWaypoint","Slew To Waypoint", // Alt + T
    {[] call tgp_main_fnc_keySlewToWaypoint; false}, {},
    [20, [false, false, true]], false
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew","tgp_main_key_stabilize", // Ctrl + T
    ["Stabilize", "Toggle stabilization of the Pilot Camera where it is currently pointed"],
    {[] call tgp_main_fnc_setStabilization; false}, {},
    [20, [false, true, false]], false
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew","tgp_main_key_ccip", // Ctrl + Alt + T
    ["Track CCIP", "Pilot Camera will (roughly) track the bomb CCIP until a bomb is dropped."],
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
