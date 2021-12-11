#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"
#include "initSettings.sqf";

call tgp_main_fnc_initVars;

tgp_main_aspectRatio = getResolution # 4;
tgp_main_pipEffectsHashMap = createHashMapFromArray [
  ["Normal", [0]],
  ["NVG", [1]],
  ["Ti", [2]],
  [0, [2]], // thermalMode[] white-hot
  [1, [7]], // thermalMode[] black-hot
  [2, [8]], // thermalMode[] green-hot
  // backwards for getting value for setCamUseTI
  [[2], 0], // thermalMode[] white-hot
  [[7], 1], // thermalMode[] black-hot
  [[8], 2] // thermalMode[] green-hot
];

tgp_main_visionModeNamesHashMap = createHashMapFromArray [
  [[0], "DTV"],
  [[1], "NVG"],
  [[2], "WHOT"], // thermalMode[] white-hot
  [[7], "BHOT"], // thermalMode[] black-hot
  [[8], "GHOT"] // thermalMode[] green-hot
];

tgp_main_visionModesHashMap = createHashMapFromArray [
  [[0, -1], [0]],
  [[1, -1], [1]],
  [[2, 0], [2]], // thermalMode[] white-hot
  [[2, 1], [7]] // thermalMode[] black-hot
];

ADDON = true;
