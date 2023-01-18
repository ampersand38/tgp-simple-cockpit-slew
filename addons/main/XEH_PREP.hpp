// testing, update fncs on the fly
//#define PREP(var1) TRIPLES(ADDON,fnc,var1) = { call compile preProcessFileLineNumbers '\MAINPREFIX\PREFIX\SUBPREFIX\COMPONENT_F\functions\DOUBLES(fnc,var1).sqf' }

PREP(ccip_drag);
PREP(ccip_nodrag);
PREP(handleSlew);
PREP(keyDownSLew);
PREP(keyFLIRSlewToHMD);
PREP(keySlewToWaypoint);
PREP(setStabilization);
PREP(setup);
PREP(trackCCIP);
