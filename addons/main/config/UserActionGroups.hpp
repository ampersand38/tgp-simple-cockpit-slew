class UserActionGroups
{
    class GVAR(Slew) // Unique classname of your category.
    {
        name = CSTRING(Slew); // Display name of your category.
        isAddon = 1;
        group[] = { // List of all actions inside this category.
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
};
