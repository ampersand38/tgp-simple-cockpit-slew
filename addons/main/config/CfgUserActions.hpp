class CfgUserActions {
    class GVAR(SlewHold) { // This class name is used for internal representation and also for the inputAction command.
        displayName = CSTRING(SlewHold);
        tooltip = CSTRING(SlewHold_Tooltip);
        onActivate = QUOTE([] call FUNC(inputSlewDown));        // _this is always true.
        onDeactivate = QUOTE([] call FUNC(inputSlewUp));        // _this is always false.
        //onAnalog = QUOTE(call FUNC(inputBlindFireToggle);    // _this is the scalar analog value.
        //analogChangeThreshold = 0.1; // Minimum change required to trigger the onAnalog EH (default: 0.01).
    };
    class GVAR(HMD) { // This class name is used for internal representation and also for the inputAction command.
        displayName = CSTRING(PlsWork);
        tooltip = CSTRING(HMDLock_Tooltip);
        onActivate = QUOTE([] call FUNC(keyFLIRSlewToHMD));        // _this is always true.
    };
    class GVAR(Waypoint) { // This class name is used for internal representation and also for the inputAction command.
        displayName = CSTRING(Waypoint);
        tooltip = CSTRING(Waypoint_Tooltip);
        onActivate = QUOTE([] call FUNC(keySlewToWaypoint));        // _this is always true.
    };
    class GVAR(Stabilize) { // This class name is used for internal representation and also for the inputAction command.
        displayName = CSTRING(Stabilize);
        tooltip = CSTRING(Stabilize_Tooltip);
        onActivate = QUOTE([] call FUNC(setStabilization));        // _this is always true.
    };
    class GVAR(CCIP) { // This class name is used for internal representation and also for the inputAction command.
        displayName = CSTRING(CCIP);
        tooltip = CSTRING(CCIP_Tooltip);
        onActivate = QUOTE([] call FUNC(trackCCIP));        // _this is always true.
    };
    class GVAR(ZoomIn) { // This class name is used for internal representation and also for the inputAction command.
        displayName = "$STR_usract_zoom_in";
        tooltip = "";
        onActivate = QUOTE([1] call FUNC(zoomTurret));        // _this is always true.
    };
    class GVAR(ZoomOut) { // This class name is used for internal representation and also for the inputAction command.
        displayName = "$STR_usract_zoom_out";
        tooltip = "";
        onActivate = QUOTE([-1] call FUNC(zoomTurret));        // _this is always true.
    };
    class GVAR(TakeControls) { // This class name is used for internal representation and also for the inputAction command.
        displayName = "$STR_action_take_control";
        tooltip = "";
        onActivate = QUOTE([] call FUNC(takeControls));        // _this is always true.
    };
    class GVAR(CollisionLightsOn) { // This class name is used for internal representation and also for the inputAction command.
        displayName = "$STR_ACTION_COLLISIONLIGHTS_ON";
        tooltip = "";
        onActivate = QUOTE([true] call FUNC(setCollisionLights));        // _this is always true.
    };
    class GVAR(CollisionLightsOff) { // This class name is used for internal representation and also for the inputAction command.
        displayName = "$STR_ACTION_COLLISIONLIGHTS_OFF";
        tooltip = "";
        onActivate = QUOTE([false] call FUNC(setCollisionLights));        // _this is always true.
    };
    class GVAR(CollisionLightsToggle) { // This class name is used for internal representation and also for the inputAction command.
        displayName = CSTRING(CollisionLightsToggle);
        tooltip = "";
        onActivate = QUOTE([false] call FUNC(setCollisionLights));        // _this is always true.
    };
};
