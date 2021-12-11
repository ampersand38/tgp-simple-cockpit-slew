params ["_vehicle"];
tgp_main_pip_camera = "camera" camCreate [0,0,0];
private _initFovStep = ((_vehicle getVariable "tgp_flir_fovObjects") # (_vehicle getVariable ["tgp_flir_initFovMode",0]));
tgp_main_pip_camera camSetFov (_initFovStep # 0);
tgp_main_fov = _initFovStep;
tgp_main_pip_camera cameraEffect ["internal", "BACK", "tgp_main_feed"];
tgp_main_pip_camera camSetFocus [-1,-1];

showCinemaBorder false;