class UserActionsConflictGroups {
    class ActionGroups {
        GVAR(ActionGroup)[] = {
            QGVAR(SlewHold),
            QGVAR(HMD),
            QGVAR(Waypoint),
            QGVAR(Stabilize),
            QGVAR(CCIP),
            QGVAR(ZoomIn),
            QGVAR(ZoomOut),
            QGVAR(TakeControls),
            QGVAR(CollisionLightsOn),
            QGVAR(CollisionLightsOff),
            QGVAR(CollisionLightsToggle)
        };
    };

    class CollisionGroups {
        // Add your group to an existing collision group:
        //carMove[] += {"TAG_MyActionGroup"};

        // Or alternatively add your own collision group (which is usually preferrable):
        GVAR(ActionGroupCollisions)[] = {"basic", "vehBasic", "HeadMove", "aircraft", "heli", QGVAR(ActionGroup)};
    };
};
