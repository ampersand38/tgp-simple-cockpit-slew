#define ALL_HARDPOINTS "DAR","DAGR","B_SHIEKER","SCALPEL_1RND_EJECTOR","B_ASRRAM_EJECTOR","O_SKYFIRE","I_ORCA_RIGHT_PYLON","20MM_TWIN_CANNON","SCALPEL_1RND","B_ASRAAM","O_MISSILE_PYLON","O_BOMB_PYLON_HELI","UNI_SCALPEL","B_MISSILE_PYLON","B_ZEPHYR","B_BOMB_PYLON","B_A143_BUZZARD_CENTER_PYLON","O_BOMB_PYLON","B_BIM9X_RAIL","B_BIM9X_DUAL_RAIL","B_AMRAAM_D_RAIL","B_AMRAAM_D_DUAL_RAIL","B_AGM65_RAIL","B_GBU12","B_AGM65_DUAL_RAIL","B_GBU12_DUAL_RAIL","B_HARM_RAIL","B_SDB_QUAD_RAIL","B_BIM9X","B_AMRAAM_D_INT","O_R73","O_R77","O_KH25","O_KAB250_BOMB","O_KH58","O_R77_INT","O_KH25_INT","O_KH58_INT","I_BIM9X","I_AMRAAM_C_RAIL","I_BIM9X_RAIL","I_AGM65_RAIL","I_BIM9X_DUAL_RAIL","I_AMRAAM_C_DUAL_RAIL","I_AGM65_DUAL_RAIL","I_GBU12","B_AGM65_DUAL","B_HARM_INT","UNI_LEAFLETS_PYLON","ANTIMINE_DRONE_PYLON"
class Components;
class ViewPilot;
class MainTurret;
class Turrets;
class CopilotTurret;
class AnimationSources;
class CargoTurret;
/*


class DefaultVehicleSystemsDisplayManagerLeft;
class DefaultVehicleSystemsDisplayManagerRight;

class SensorTemplateIR;
class SensorTemplateVisual;
class SensorTemplatePassiveRadar;
class SensorTemplateLaser;
class SensorTemplateNV;

*/
class CfgVehicles {
//["All","AllVehicles","Air","Helicopter","Helicopter_Base_F","UAV_03_base_F","UAV_03_dynamicLoadout_base_F"]

/*
    class Air;
    class Helicopter_Base_F: Air
    {
        class Turrets;
    };
    class Helicopter: Helicopter_Base_F
    {
        class Components;
        class Turrets: Turrets
        {
            class MainTurret;
        };
    };
*/
    class UAV_03_base_F;
    class GVAR(base): UAV_03_base_F
    {
        author = "Ampersand";
        mapSize = 0;
        editorSubcategory = QGVAR(EdSubcat_kits);
        _generalMacro = "";
        displayName = "Remote Kit Base";
        model = QPATHTOF(data\tgp_kit_single.p3d);
        DLC = "";
        icon = "\A3\Air_F_Exp\UAV_03\Data\UI\Map_UAV_03_CA.paa";
        picture = "\A3\Air_F_Exp\UAV_03\Data\UI\UAV_03_CA.paa";
        overviewPicture = "\A3\Data_F_Exp\Images\VehicleFalcon_ca.paa";
        vehicleClass = "Autonomous";
        destrType = "DestructDefault";
        memoryPointTaskMarker = "TaskMarker_1_pos";
        unitInfoType = "RscOptics_AV_pilot";
        unitInfoTypeRTD = "RscOptics_AV_pilot";
        fuelExplosionPower = 0;
        fuelCapacity = 0;
        fuelConsumptionRate = 0;
        class Library
        {
            libTextDesc = "";
        };
        getInRadius = 0;
        hasDriver = 0;
        armor = 1;
        cost = 0;
        altFullForce = 0;
        altNoForce = 0;
        class HitPoints {};
        selectionHRotorMove = "";
        selectionHRotorStill = "";
        selectionVRotorMove = "";
        selectionVRotorStill = "";
        maxSpeed = 0;
        threat[] = {0, 0, 0};
        maxMainRotorDive = 7;
        minMainRotorDive = -7;
        neutralMainRotorDive = 0;
        driveOnComponent[] = {};
        gearRetracting = 0;
        mainRotorSpeed = -1;
        backRotorSpeed = 1;
        startDuration = 5;
        radarTargetSize = 0;
        visualTargetSize = 0;
        irTargetSize = 0;
        lockDetectionSystem = "";
        incomingMissileDetectionSystem = "";
        soundIncommingMissile[] = {};
        //weapons[] = {"CMFlareLauncher"};
        //magazines[] = {"120Rnd_CMFlare_Chaff_Magazine"};
        weapons[] = {};
        magazines[] = {};
        laserScanner = 1;
        showAllTargets = 4;
        enableManualFire = 1;
        //memoryPointCM[] = {"Flare_launcher_1_pos", "Flare_launcher_2_pos"};
        //memoryPointCMDir[] = {"Flare_launcher_1_dir", "Flare_launcher_2_dir"};
        memoryPointCM[] = {};
        memoryPointCMDir[] = {};
        memoryPointLRocket = "";
        memoryPointRRocket = "";
        memoryPointLMissile = "";
        memoryPointRMissile = "";
        hiddenSelections[] = {};
        hiddenSelectionsTextures[] = {};
        //class Damage {};
        reportRemoteTargets = 1;
        reportOwnPosition = 1;

        class AnimationSources {};
        class Components;
        class Exhausts {};
        class Sounds {};
        class Turrets;
        ace_cargo_space = 0;
        ace_cargo_hasCargo = 0;
    };

    class GVAR(flir): GVAR(base)
    {
        scope = 2;
        scopeCurator = 2;
        side = 1;
        faction = "BLU_F";
        crew = "B_UAV_AI";
        displayName = "FLIR Turret Kit";

        class Turrets: Turrets
        {
            class MainTurret: MainTurret
            {
                weapons[] = {};
                magazines[] = {};
            };
        };
    };
    class GVAR(tgp): GVAR(flir)
    {
        displayName = "Targeting Pod Kit";

        class Components;
        class Turrets: Turrets
        {
            class MainTurret: MainTurret
            {
                weapons[] = {"Laserdesignator_mounted"};
                magazines[] = {"Laserbatteries"};
            };
        };
    };
    class GVAR(pylons): GVAR(tgp)
    {
        displayName = "Pylons Kit (TGP)";
        model = QPATHTOF(data\tgp_kit.p3d);
        class AnimationSources: AnimationSources {

#define HIDE_PYLON_ANIM(index) class Hide_Pylon##index \
{ \
    source = QUOTE(pylonIsEmpty.##index); \
    initPhase = 1; \
    animPeriod = 1; \
}

            HIDE_PYLON_ANIM(1);
            HIDE_PYLON_ANIM(2);
            HIDE_PYLON_ANIM(3);
            HIDE_PYLON_ANIM(4);
            HIDE_PYLON_ANIM(5);
            HIDE_PYLON_ANIM(6);
            HIDE_PYLON_ANIM(7);
            HIDE_PYLON_ANIM(8);
            HIDE_PYLON_ANIM(9);
        }; // AnimationSources
        class Components: Components
        {
            class TransportPylonsComponent
            {
                uiPicture = "\A3\Air_F_Exp\UAV_03\Data\UI\Map_UAV_03_3DEN_CA.paa";
                class Pylons
                {
                    class Pylons1
                    {
                        hardpoints[] = {ALL_HARDPOINTS};
                        attachment = "";
                        priority = 1;
                        turret[] = {0};
                        maxweight = 10000;
                        UIposition[] = {0.35, 0.20};
                    };

                    class Pylons2: Pylons1
                    {
                        priority = 2;
                        UIposition[] = {0.25, 0.25};
                    };
                    class Pylons3: Pylons2
                    {
                        UIposition[] = {0.45, 0.25};
                        mirroredMissilePos = 2;
                    };

                    class Pylons4: Pylons1
                    {
                        priority = 3;
                        UIposition[] = {0.20, 0.3};
                    };
                    class Pylons5: Pylons4
                    {
                        UIposition[] = {0.50, 0.3};
                        mirroredMissilePos = 4;
                    };

                    class Pylons6: Pylons1
                    {
                        priority = 4;
                        UIposition[] = {0.15, 0.35};
                    };
                    class Pylons7: Pylons6
                    {
                        UIposition[] = {0.55, 0.35};
                        mirroredMissilePos = 6;
                    };

                    class Pylons8: Pylons1
                    {
                        priority = 5;
                        UIposition[] = {0.10, 0.4};
                    };
                    class Pylons9: Pylons8
                    {
                        UIposition[] = {0.60, 0.4};
                        mirroredMissilePos = 8;
                    };
                };
                class Presets
                {
                    class Empty
                    {
                        displayName = "Empty";
                        attachment[] = {};
                    };
                };
            };
        }; // Components
    };
    class GVAR(pylons_fixed): GVAR(tgp)
    {
        displayName = "Pylons Kit (Fixed Camera)";
        class Turrets: Turrets
        {
            class MainTurret: MainTurret
            {
                animationSourceBody = "";
                animationSourceGun = "";
            };
        };
    };

    class GVAR(camera): GVAR(flir)
    {
        displayName = "Camera Kit";
        class Turrets: Turrets
        {
            class MainTurret: MainTurret
            {
                animationSourceBody = "";
                animationSourceGun = "";
            };
        };
    };
    class GVAR(pylon_single): GVAR(camera)
    {
        displayName = "Pylon Kit (Single)";
        class Components: Components
        {
            class TransportPylonsComponent
            {
                uiPicture = "\A3\Air_F_Exp\UAV_03\Data\UI\Map_UAV_03_3DEN_CA.paa";
                class Pylons
                {
                    class Pylons1
                    {
                        hardpoints[] = {ALL_HARDPOINTS};
                        attachment = "";
                        priority = 5;
                        turret[] = {0};
                        maxweight = 10000;
                        UIposition[] = {0.05, 0.3};
                    };
                };
                class Presets
                {
                    class Empty
                    {
                        displayName = "Empty";
                        attachment[] = {};
                    };
                };
            };
        };
    };
};
