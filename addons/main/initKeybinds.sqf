#include "\a3\ui_f\hpp\definedikcodes.inc"

[
    "TGP Cockpit Control","tgp_main_key_slew",
    ["FLIR Slew Aim", "Hold this key and use mouse or 'Aim <Up|Down|Left|Right>' input to slew the FLIR."], // B
    {
        call tgp_main_fnc_keyDownSlew
    },{
        if (uiNamespace getVariable ["tgp_main_mouseBlocker", false]) then {
            (findDisplay 86005) closeDisplay 0;
        };
        tgp_main_slewAim = false;
    },
    [48, [false, true, false]],false
] call CBA_fnc_addKeybind;

[
    "TGP Cockpit Control","tgp_main_key_slewHMD","FLIR Slew To HMD", // Shift + T
    {
      if (tgp_main_playerIsPilot || {tgp_main_playerIsCopilot}) then {
        call tgp_main_fnc_keyFLIRSlewToHMD;
      };
      false
    },{},
    [20, [true, false, false]],false
] call CBA_fnc_addKeybind;

[
    "TGP Cockpit Control","tgp_main_key_zoom_inc","FLIR Zoom In", // PLUS
    {
        if (tgp_main_isPipHidden) exitWith {false};
        [1] call tgp_main_fnc_keyZoom;
        false
    },{},
    [13, [false, false, false]],false
] call CBA_fnc_addKeybind;

[
    "TGP Cockpit Control","tgp_main_key_zoom_desc","FLIR Zoom Out", // MIN
    {
        if (tgp_main_isPipHidden) exitWith {false};
        [-1] call tgp_main_fnc_keyZoom;
        false
    },{},
    [12, [false, false, false]],false
] call CBA_fnc_addKeybind;

[
    "TGP Cockpit Control","tgp_main_key_up","FLIR Up", // Control + W
    {if (tgp_main_isPipHidden) exitWith {false}; tgp_main_up = 1; false},{tgp_main_up = 0;},
    [17, [false, true, false]],false
] call CBA_fnc_addKeybind;

[
    "TGP Cockpit Control","tgp_main_key_down","FLIR Down", // Control + S
    {if (tgp_main_isPipHidden) exitWith {false}; tgp_main_down = 1; false},{tgp_main_down = 0;},
    [31, [false, true, false]],false
] call CBA_fnc_addKeybind;

[
    "TGP Cockpit Control","tgp_main_key_left","FLIR Left", // Control + A
    {if (tgp_main_isPipHidden) exitWith {false}; tgp_main_left = 1; false},{tgp_main_left = 0;},
    [30, [false, true, false]],false
] call CBA_fnc_addKeybind;

[
    "TGP Cockpit Control","tgp_main_key_right","FLIR Right", // Control + D
    {if (tgp_main_isPipHidden) exitWith {false}; tgp_main_right = 1; false},{tgp_main_right = 0;},
    [32, [false, true, false]],false
] call CBA_fnc_addKeybind;

[
    "TGP Cockpit Control","tgp_main_key_stabilize","FLIR Stabilize", // Ctrl + T
    {call tgp_main_fnc_setStabilization, false},{},
    [20, [false, true, false]],false
] call CBA_fnc_addKeybind;

[
    "TGP Cockpit Control","tgp_main_pipEffect","FLIR Camera Mode", // Ctrl + N
    {
        if (tgp_main_isPipHidden) exitWith {false};
        call tgp_main_fnc_keyVisionMode;
        false
    },{},
    [49, [false, true, false]],false
] call CBA_fnc_addKeybind;
