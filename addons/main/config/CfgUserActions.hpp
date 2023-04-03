class CfgUserActions {
    class GVAR(BlindFireToggle) { // This class name is used for internal representation and also for the inputAction command.
        displayName = CSTRING(BlindFireToggle);
        tooltip = CSTRING(BlindFireToggle_Tip);
        onActivate = QUOTE(call FUNC(inputBlindFireToggle));		// _this is always true.
        //onDeactivate = QUOTE(call FUNC(inputBlindFireToggle));		// _this is always false.
        //onAnalog = QUOTE(call FUNC(inputBlindFireToggle));	// _this is the scalar analog value.
        //analogChangeThreshold = 0.1; // Minimum change required to trigger the onAnalog EH (default: 0.01).
    };
    class GVAR(AimLeft) { // This class name is used for internal representation and also for the inputAction command.
        displayName = "$STR_usract_aim_Left";
        tooltip = "$STR_controls_tooltips_AIM_Left";
        onActivate = QUOTE([-1] call FUNC(attachDummy));		// _this is always true.
        //onDeactivate = QUOTE(call FUNC(inputAimLeft));		// _this is always false.
        //onAnalog = QUOTE([1] call FUNC(attachDummy));	// _this is the scalar analog value.
        //analogChangeThreshold = 0.1; // Minimum change required to trigger the onAnalog EH (default: 0.01).
    };
    class GVAR(AimRight) { // This class name is used for internal representation and also for the inputAction command.
        displayName = "$STR_usract_aim_Right";
        tooltip = "$STR_controls_tooltips_AIM_Right";
        onActivate = QUOTE([1] call FUNC(attachDummy));		// _this is always true.
        //onDeactivate = QUOTE([ARR_2(3,_this)] call FUNC(inputAim));		// _this is always false.
        //onAnalog = QUOTE([2] call FUNC(attachDummy));	// _this is the scalar analog value.
        //analogChangeThreshold = 0.1; // Minimum change required to trigger the onAnalog EH (default: 0.01).
    };
    /*
    class GVAR(AimUp) { // This class name is used for internal representation and also for the inputAction command.
        displayName = "$STR_usract_aim_up";
        tooltip = "$STR_controls_tooltips_AIM_UP";
        //onActivate = QUOTE(call FUNC(inputAimUp));		// _this is always true.
        //onDeactivate = QUOTE(call FUNC(inputAimUp));		// _this is always false.
        onAnalog = QUOTE([ARR_2(0,_this)] call FUNC(inputAim));	// _this is the scalar analog value.
        analogChangeThreshold = 0.1; // Minimum change required to trigger the onAnalog EH (default: 0.01).
    };
    class GVAR(AimDown) { // This class name is used for internal representation and also for the inputAction command.
        displayName = "$STR_usract_aim_Down";
        tooltip = "$STR_controls_tooltips_AIM_Down";
        //onActivate = QUOTE(call FUNC(inputAimDown));		// _this is always true.
        //onDeactivate = QUOTE(call FUNC(inputAimDown));		// _this is always false.
        onAnalog = QUOTE([ARR_2(1,_this)] call FUNC(inputAim));	// _this is the scalar analog value.
        analogChangeThreshold = 0.1; // Minimum change required to trigger the onAnalog EH (default: 0.01).
    };
    class GVAR(TestInput) { // This class name is used for internal representation and also for the inputAction command.
        displayName = CSTRING(TestInput);
        tooltip = CSTRING(TestInput_Tip);
        onActivate = QUOTE(call FUNC(inputTestInput));		// _this is always true.
        onDeactivate = QUOTE(call FUNC(inputTestInput));		// _this is always false.
        onAnalog = QUOTE(call FUNC(inputTestInput));	// _this is the scalar analog value.
        analogChangeThreshold = 0.1; // Minimum change required to trigger the onAnalog EH (default: 0.01).
    };
    */
};
