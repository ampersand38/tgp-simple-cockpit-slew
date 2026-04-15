class UserActionsConflictGroups {
    class ActionGroups {
        GVAR(ActionGroup)[] = {
            QGVAR(SlewHold),
            QGVAR(HMD),
            QGVAR(Waypoint),
            QGVAR(LockedTarget),
            QGVAR(Stabilize),
            QGVAR(CCIP),
            QGVAR(ZoomIn),
            QGVAR(ZoomOut),
            QGVAR(TakeControls),
            QGVAR(CollisionLightsOn),
            QGVAR(CollisionLightsOff),
            QGVAR(CollisionLightsToggle),
            QGVAR(PIPToggle),
            QGVAR(SlewUp),
            QGVAR(SlewDown),
            QGVAR(SlewLeft),
            QGVAR(SlewRight)
        };
    };

    class CollisionGroups {
        // Add your group to an existing collision group:
        //carMove[] += {"TAG_MyActionGroup"};

        // Or alternatively add your own collision group (which is usually preferrable):
        GVAR(ActionGroupCollisions)[] = {"basic", "vehBasic", "HeadMove", "aircraft", "heli", QGVAR(ActionGroup)};
    };
};
