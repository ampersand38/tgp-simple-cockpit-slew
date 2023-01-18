#include "\z\tgp\addons\main\script_component.hpp"

#define EXITCHECK if (\
    !tgp_main_hasPilotCamera ||\
    {cameraView != "INTERNAL"} ||\
    {visibleMap} ||\
    {!isNull curatorCamera} ||\
    {cameraOn != _vehicle}\
) exitWith {false};
