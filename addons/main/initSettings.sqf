[
    "tgp_main_setting_AimSlewBlockMouse", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Aim Slew Block Mouse", "Block mouse from moving the cyclic while slewing. Not needed if Aim Slew key is same as ACE Interaction key."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "TGP Simple Cockpit Slew", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting: [min, max, default, number of shown trailing decimals]
    nil // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    "tgp_main_setting_CenterMouse", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Aim Slew Center Mouse", "Keep mouse cursor centered while slewing. Used when not in fullscreen mode to prevent mouse moving out of Arma window."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "TGP Simple Cockpit Slew", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting: [min, max, default, number of shown trailing decimals]
    nil // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    "tgp_main_setting_AimSlewSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["Aim Slew Speed", "Sensitivity when slewing using mouse or 'Aim <Up|Down|Left|Right>' inputs."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "TGP Simple Cockpit Slew", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0.01, 100, 1, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    nil // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    "tgp_main_setting_AimXFactor", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["Aim Slew Pan Speed", "Sensitivity multiplier for pan vs tilt. Use this to adjust diagonal movement."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "TGP Simple Cockpit Slew", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0.01, 100, 1, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    0, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        tgp_main_setting_AimXFactor = (getResolution select 4) * tgp_main_setting_AimXFactor; // Customize x axis speed for better feel
    }
] call CBA_fnc_addSetting;

/*
[
    "tgp_main_setting_createGunner", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Create AI Gunner", "If slewable turret is empty, create AI gunner to operate turret while slewing."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "TGP Simple Cockpit Slew", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting: [min, max, default, number of shown trailing decimals]
    nil // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    "tgp_main_setting_KeySlewSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["Key Slew Speed", "Sensitivity when slewing using the mod's keybinds."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "TGP Simple Cockpit Slew", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0.01, 100, 1, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    nil // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    "tgp_main_setting_KeyXFactor", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["Key Slew Pan Speed", "Sensitivity multiplier for pan vs tilt. Use this to adjust diagonal movement."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "TGP Simple Cockpit Slew", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0.01, 100, 1, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    nil // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;
*/
