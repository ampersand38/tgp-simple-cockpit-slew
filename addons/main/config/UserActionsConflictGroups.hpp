class UserActionsConflictGroups {
    class ActionGroups {
        GVAR(ActionGroup)[] = {
            QGVAR(SlewHold),
            QGVAR(HMD),
            QGVAR(Waypoint),
            QGVAR(Stabilize),
            QGVAR(CCIP)
        };
    };

    class CollisionGroups {
        // Add your group to an existing collision group:
        //carMove[] += {"TAG_MyActionGroup"};

        // Or alternatively add your own collision group (which is usually preferrable):
        GVAR(ActionGroupCollisions)[] = {"basic", "vehBasic", "HeadMove", QGVAR(ActionGroup)};
    };
};
