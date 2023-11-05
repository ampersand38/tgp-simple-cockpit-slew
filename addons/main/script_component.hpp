#define COMPONENT main
#define COMPONENT_BEAUTIFIED main
#include "\z\tgp\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_main
  #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_main
  #define DEBUG_SETTINGS DEBUG_SETTINGS_main
#endif

#include "\z\tgp\addons\main\script_macros.hpp"

#define RESET_VARIABLES GVAR(ccipOffset) = 0; \
tgp_main_vehicle = objNull; \
GVAR(isSlewing) = false; \
GVAR(isTrackingCCIP) = false; \
GVAR(mode) = 0; \
GVAR(cameraTarget) = [false, [0, 0, 0], objNull]; \
GVAR(holdTurretLockPFHID) = -1;
