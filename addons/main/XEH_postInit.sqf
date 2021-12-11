#include "script_component.hpp"

if (hasInterface) then {
    #include "initKeybinds.sqf"

};

["vehicle", FUNC(setup), true] call CBA_fnc_addPlayerEventHandler;
