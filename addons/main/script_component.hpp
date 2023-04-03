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

#define RESET_VARIABLES  tgp_main_ccipOffset = 0; \
tgp_main_vehicle = objNull; \
tgp_main_isSlewing = false; \
tgp_main_isTrackingCCIP = false; \
GVAR(mode) = 0; \
tgp_main_pilotCameraTarget = [false, [0, 0, 0], objNull];
