#include "\z\tgp\addons\main\script_component.hpp"

#define PILOT_FEED ["VehicleDriverDisplay","TransportFeedDisplayComponent"]

#define MODE_FAILED 0
#define MODE_PILOTCAMERA 1
#define MODE_TURRET 2

#define EXITCHECK if ( \
    visibleMap \
    || {!isNull curatorCamera} \
) exitWith {false}; \
if (isNull tgp_main_vehicle && {call FUNC(setup) == 0}) exitWith {false};
