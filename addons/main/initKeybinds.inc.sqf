#include "\a3\ui_f\hpp\definedikcodes.inc"

[
    "TGP Simple Cockpit Slew","tgp_main_key_slew", // B
    [LSTRING(SlewHold), LSTRING(SlewHold_Tooltip)],
    tgp_main_fnc_inputSlewDown, tgp_main_fnc_inputSlewUp,
    [48, [false, false, false]], false
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew","tgp_main_key_slewHMD", // Shift + T
    [LSTRING(HMDLock), LSTRING(HMDLock_Tooltip)],
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

[
    "TGP Simple Cockpit Slew","tgp_main_key_zoom_inc","str_usract_zoom_in", // PLUS
    {[1] call tgp_main_fnc_zoomTurret},{},
    [13, [false, false, false]],false
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew","tgp_main_key_zoom_desc","str_usract_zoom_out", // MIN
    {[-1] call tgp_main_fnc_zoomTurret},{},
    [12, [false, false, false]],false
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew",QGVAR(key_TakeControls),"STR_action_take_control", // Unbound
    {[] call FUNC(takeControls)},{}
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew",QGVAR(key_CollisionLightsOn),"STR_ACTION_COLLISIONLIGHTS_ON", // Unbound
    {[true] call FUNC(setCollisionLights)},{}
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew",QGVAR(key_CollisionLightsOff),"STR_ACTION_COLLISIONLIGHTS_OFF", // Unbound
    {[false] call FUNC(setCollisionLights)},{}
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew",QGVAR(key_CollisionLightsToggle),LSTRING(CollisionLightsToggle), // Unbound
    {[] call FUNC(setCollisionLights)},{}
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew",QGVAR(key_toggleRenderTargets),[LSTRING(PIPToggle),LSTRING(PIPToggle_ToolTip)], // Unbound
    {[cameraOn, PIPSTATE_TOGGLE] call FUNC(toggleRenderTargets)},{}
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew",QGVAR(key_toggleLaser),[LSTRING(toggleLaser),LSTRING(toggleLaser_ToolTip)], // Unbound
    {[cameraOn] call zen_common_fnc_setVehicleLaserState},{}
] call CBA_fnc_addKeybind;

[
    "TGP Simple Cockpit Slew",QGVAR(key_focusGunnerView),[LSTRING(focusGunnerView),LSTRING(focusGunnerView)], // Unbound
    {
        with uiNamespace do {
            gf_display = findDisplay 46 createDisplay "RscCustomInfoTransportFeedPrimaryGunner";
            gf_control = gf_display displayCtrl 102;
            gf_control ctrlSetPosition [-0.5, -0.4, 2.0, 1.8];
            gf_control ctrlCommit 0;
        };
        tgp_main_slewAim = true;
        [FUNC(handleSlewTurret), 0] call CBA_fnc_addPerFrameHandler;
    },{}
] call CBA_fnc_addKeybind;

/*
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
