#include "script_component.hpp"

if (hasInterface) then {
    addUserActionEventHandler ["gunElevUp", "Activate", { tgp_main_ccipOffset = tgp_main_ccipOffset + 1; }];
    addUserActionEventHandler ["gunElevDown", "Activate", { tgp_main_ccipOffset = tgp_main_ccipOffset - 1; }];

/*
    ["vehicle", FUNC(setup), true] call CBA_fnc_addPlayerEventHandler;

    {
        addUserActionEventHandler [_x, "Activate", FUNC(handlePanel)];
    } forEach [
        "uavView",
        "uavViewToggle",
        "ListLeftVehicleDisplay",
        "ListRightVehicleDisplay",
        "ListPrevLeftVehicleDisplay",
        "ListPrevRightVehicleDisplay"
    ];

    {
        addUserActionEventHandler [_x, "Activate", FUNC(handleZoom)];
    } forEach [
        "pilotCamera",
        "zoomTemp",
        "zoomIn",
        "zoomInToggle",
        "zoomOut",
        "zoomOutToggle",
        "zoomContIn",
        "zoomContOut"
    ];
*/
};
