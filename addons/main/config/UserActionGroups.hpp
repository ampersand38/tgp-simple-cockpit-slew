class UserActionGroups
{
	class GVAR(Slew) // Unique classname of your category.
	{
		name = CSTRING(Slew); // Display name of your category.
		isAddon = 1;
		group[] = { // List of all actions inside this category.
            GVAR(SlewHold),
            GVAR(HMD),
            GVAR(Waypoint),
            GVAR(Stabilize),
            GVAR(CCIP)
        };
	};
};
