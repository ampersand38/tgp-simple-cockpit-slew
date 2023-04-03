class UserActionGroups
{
	class GVAR(BlindFire) // Unique classname of your category.
	{
		name = CSTRING(BlindFire); // Display name of your category.
		isAddon = 1;
		group[] = { // List of all actions inside this category.
            QGVAR(AimUp),
            QGVAR(AimDown),
            QGVAR(AimLeft),
            QGVAR(AimRight),
            QGVAR(BlindFireToggle),
            QGVAR(TestInput)
        };
	};
};
