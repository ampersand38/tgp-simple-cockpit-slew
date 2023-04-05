// testing, update fncs on the fly
//#define PREP(var1) TRIPLES(ADDON,fnc,var1) = { call compile preProcessFileLineNumbers '\MAINPREFIX\PREFIX\SUBPREFIX\COMPONENT_F\functions\DOUBLES(fnc,var1).sqf' }

PREP(ccip_nodrag);
PREP(handleSlew);
PREP(handleSlewTurret);
PREP(handleZoom);
PREP(inputSlewDown);
PREP(inputSlewUp);
PREP(isSlewable);
PREP(handlePanel);
PREP(holdTurretLock);
PREP(keyFLIRSlewToHMD);
PREP(keySlewToWaypoint);
PREP(lockCamera);
PREP(parseCameraTarget);
PREP(setCollisionLights);
PREP(setStabilization);
PREP(setup);
PREP(takeControls);
PREP(trackCCIP);
PREP(zoomTurret);
