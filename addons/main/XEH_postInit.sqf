#include "script_component.hpp"

if (hasInterface) then {
    #include "initKeybinds.sqf"

};

["vehicle", FUNC(setup), true] call CBA_fnc_addPlayerEventHandler;
["cameraView", {
    if ((_this # 1) == "GUNNER") then {
        [{
            params ["_vehicle", "_idPFH"];
            if (cameraView != "GUNNER" ) exitWith {
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };

            tgp_main_FOV = getObjectFOV _vehicle;
        }, 0, vehicle (call CBA_fnc_currentUnit)] call CBA_fnc_addPerFrameHandler;
    };
}] call CBA_fnc_addPlayerEventHandler;
