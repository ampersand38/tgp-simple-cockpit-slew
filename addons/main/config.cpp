#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author = "";
        authors[] = {""};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "config\mouseBlocker.hpp"
#include "config\CfgDefaultKeysPresets.hpp"
#include "config\CfgUserActions.hpp"
#include "config\UserActionGroups.hpp"
#include "config\UserActionsConflictGroups.hpp"
