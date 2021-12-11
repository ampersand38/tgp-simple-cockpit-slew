/*
 * Author: Ampersand
 * Set tgp_main_isPipHidden for faster perFrame
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * 0: New Effect <ARRAY>
 *
 * Example:
 * call tgp_main_fnc_setIsPipHidden
 */

tgp_main_isPipHidden = isNil "tgp_main_camera" ||
  {cameraView isNotEqualTo "INTERNAL"} ||
  {tgp_main_isVisibleMap} ||
  {tgp_main_featureCamera != ""} ||
  {!isNull curatorCamera}
