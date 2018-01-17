/*
	* SAMP-IL - SA-MP.co.il Heavy Stunts
	* © Copyright 2014-2016, Amit Barami (`Amit_B`)
	* Updated for:		SanAndreas:MultiPlayer 0.3c
	* Version:			1.0.0
	* Creation Date:	09/04/2014
*/
// Included Files
#include "a_samp.inc"
#include "old_streamer.inc"
#include "y_files.inc"
// Settings
#define version "1.0.0"
#define updates 1
#define last_update "07/03/2016"
#define tsip "ts.sa-mp.co.il:9696"
#define webpage "SA-MP.co.il"
#define M_S 200
#define CHAT_MAIN "Lobby"
#define respawntime 180
#define PLAYER_ALPHA 60
#define PROP_EARNS 40
#define PROP_COUNT 10
#pragma dynamic 50000
#define srvip "149.202.65.95"
#define TELE_AREA_SIZE 50.0
#define audio_url "http:/" "/sa-mp.co.il/samp/sounds/"
#undef INVALID_TEXT_DRAW
#define INVALID_TEXT_DRAW Text:0xFFFF
#define INVALID_PLAYER_TEXT_DRAW PlayerText:0xFFFF
// Limits
#define MAX_WORLDS 5
#define MAX_CHECKPOINTS 50
#define MAX_AREAS 150
#define MAX_TELEPORTS 70
#define MAX_CHATS 50
#define MAX_ADMIN_VEHICLES 100
#define MAX_PLAYER_VEHICLES 2
#define MAX_MAP_OBJECTS 800
#define MAX_MAPS 20
#define MAX_STREAMED_OBJECTS 5000
#define MAX_GROUPS 50
#define MAX_GROUP_MEMBERS 15
#define MAX_CLAN_LEVEL 5
#define MAX_HQ_ITEMS 50
#define DRIFT_MINKAT 10.0
#define DRIFT_MAXKAT 90.0
#define DRIFT_SPEED 30.0
#define MAX_PROPERTIES 50
#define MAX_CREW_LEVEL 5
#define MAX_CAMERA_SAVES 3
#define FLOAT_INFINITY (Float:0x7F800000)
#define FLOAT_NEG_INFINITY (Float:0xFF800000)
#define FLOAT_NAN (Float:0xFFFFFFFF)
#define MAX_MOVE_OBJECTS 50
#define MAX_DCMDS 2
// Colors
#define yellow 0xF8FAAFFF
#define green 0x9DF59DFF
#define red 0xF76D6DFF
#define blue 0x595AF0FF
#define grey 0xE0DEDEFF
#define lightblue 0x0FF5CBFF
#define orange 0xFA9E66FF
#define darkblue 0x0A67C4FF
#define purple 0xC219C2FF
#define white 0xFFFFFFFF
#define black 0x000000FF
#define C_yellow F8FAAF
#define C_green 9DF59D
#define C_red F76D6D
#define C_blue 595AF0
#define C_grey E0DEDE
#define C_lightblue 0FF5CB
#define C_orange FA9E66
#define C_darkblue 0A67C4
#define C_purple C219C2
#define C_white FFFFFF
#define C_black 000000
#define @c(%1) "{"#C_%1"}"
// Worlds
#define world_class 0
#define world_stunts 1
#define world_stuntswo 2
#define world_dm 3
#define world_tdm 4
// Directories & files
#define file_users "/HS/Users.ini"
#define file_admins "/HS/Admins.ini"
#define file_rules "/HS/Rules.txt"
#define file_config "/HS/Configuration.cfg"
#define file_admincmd "/HS/AdminCommands.cfg"
#define file_tele "/HS/Teleports/Teleports.cfg"
#define file_vsave "/HS/SavedVehicles.txt"
#define file_groups "/HS/Groups/Groups.cfg"
#define file_automsg "/HS/AutoMessage.txt"
#define file_censoring "/HS/Censoring.txt"
#define file_bans "/HS/Bans/Names.cfg"
#define file_objoutput "/HS/ObjectOutput.txt"
#define dir_users "/HS/Users/"
#define dir_tele "/HS/Teleports/"
#define dir_maps "/HS/Maps/"
#define dir_groups "/HS/Groups/"
#define dir_logs "/HS/Logs/"
#define dir_bans "/HS/Bans/"
// Virtual Worlds
#define vworld_requestclass 50
#define worlds_gameplay 0
#define worlds_activities 10
#define worlds_dmzones 20
#define max_vworlds 1000
// Connection Status
#define ct_connection 0
#define ct_register 1
#define ct_selectworld 2
#define ct_selectskin 3
#define ct_playing 4
// Checkpoints
#define cp_none 0
#define cp_bank 1
#define cp_ammu 2
// Area Types
#define area_none 0
#define area_cp 1
#define area_money 2
#define area_tele 3
// Setting
#define max_settings 6
#define setting_autologin 0
#define setting_showjoin 1
#define setting_showquit 2
#define setting_fs 3
#define setting_clock 4
#define setting_exp 5
// Exp
#define exp_kill 0
#define exp_assist 1
#define exp_headshot 2
#define exp_stunt 3
#define exp_drift 4
#define exp_speed 5
#define exp_activity 6
#define exp_time 7
#define exp_quest 8
#define exp_area 9
// Group Types
#define group_none -1
#define group_clan 0
#define group_crew 1
#define group_count 2
// Pickup Types
#define pickup_default 0
#define pickup_property 1
// Camera Mode
#define camera_none 0
#define camera_fly 1
#define camera_view 2
#define camera_updated 3
#define camera_spec 4
// Attach Object Slots
#define aoslot_skin 0 // 0-4
// Map Icons
#define icon_mark 0
// Directive Functions
#define SendFormat(%0,%1,%2,%3) SendClientMessage(%0,%1,(format(fstring,sizeof(fstring),%2,%3), fstring))
#define SendFormatToAll(%0,%1,%2) SendClientMessageToAll(%0,(format(fstring,sizeof(fstring),%1,%2), fstring))
#define frmt(%0,%1) (format(fstring,sizeof(fstring),%0,%1), fstring)
#define equal(%0,%1) (!strcmp(%0,%1,true) && strlen(%0) == strlen(%1))
#define GetName(%0) (PlayerInfo[%0][pName])
#define GetIP(%0) (PlayerInfo[%0][pIP])
#define uf(%0) (PlayerInfo[%0][pUserFile])
#define Loop(%1) for(new %1 = 0, %1_ = GetPlayerPoolSize(); %1 <= %1_; %1++) if(IsPlayerConnected(%1))//for(new %1_ = 0, %1 = player[0]; %1_ < players; %1 = player[++%1_])
#define LoopEx(%1,<%2>) for(new %1 = 0, %1_ = GetPlayerPoolSize(); %1 <= %1_ && %2; %1++) if(IsPlayerConnected(%1))//for(new %1_ = 0, %1 = player[0]; %1_ < players && (%2); %1 = player[++%1_])
#define PlaySound(%1,%2) PlayerPlaySound(%1,%2,0.0,0.0,0.0)
#define VehicleName(%1) (VehicleNames[%1-400])
#define WeaponName(%1) (WeaponNames[%1])
#define ConvertVelocityToKMH(%1,%2,%3) floatround(floatround(floatpower((%1*%1)+(%2*%2)+(%3*%3),0.5)*100)*2.0)
#define SetPlayerColor2(%1,%2) SetPlayerColor(%1,PlayerInfo[playerid][pColor] = %2)
// Enumerations
enum e_Worlds
{
	wID,
	wName[32],
	bool:wPlayable
}
enum e_World
{
	bool:wValid,
	wPlayers,
	Text:wTD[4],
	wActivity[3],
	wActivityParam,
	wCD
}
enum e_Rate
{
	rtKills,
	rtAssists,
	rtDamage,
	rtHeadshots,
	rtDeaths,
	rtDamaged,
	rtWeapons[55],
	rtDamagePlayers[MAX_PLAYERS]
}
enum e_Points
{
	ptStunts,
	ptDrifts,
	ptSpeed
}
enum e_Player
{
	pID,
	pConnectStage,
	bool:pFirstSpawn,
	pArrayPos,
	pName[MAX_PLAYER_NAME],
	pIP[16],
	pUserFile[32],
	pUserID,
	bool:pLogged,
	pFailedLogins,
	pAdmin,
	pWorld,
	pUsedCommand[2],
	pLastPM,
	bool:pAFK,
	pIdleTime,
	pConnectionTime[3],
	bool:pBlockPMs,
	pCheckpoint,
	pArea,
	pInterpolating,
	pAdminLogged,
	pMoney,
	pBank,
	pLevel,
	pSetting[max_settings],
	pRate[e_Rate],
	pPoints[e_Points],
	pActivityWins,
	pExp,
	pExpUpdate,
	pAreaExp,
	bool:pHeadshots,
	bool:pHeadshoted,
	pRegDate[16],
	pFreezeTime,
	pChat,
	bool:pChatAdmin,
	pACreatedVehicle[MAX_ADMIN_VEHICLES],
	pACreatedVehicles,
	pALastVehicle,
	pColor,
	pRGB[3],
	bool:pGodmod,
	pVIP,
	pDMZone,
	pGroup[group_count],
	pGroupInvite[group_count],
	pGroupLevel[group_count],
	bool:pToggle[2],
	pLoadSelection,
	pCreatedVehicle[MAX_PLAYER_VEHICLES],
	pCreatedVehicles,
	pLastVehicle,
	pLastVModelID,
	Float:pSpeed[10],
	Float:pDPos[3],
	Float:pDSPos[3],
	pDrift[4],
	PlayerText:pDriftTD[2],
	pHideDriftTD,
	pSaveSkin,
	pWeapons[10],
	pAmmo[8],
	bool:pAdminInv,
	pProps,
	pEarns[MAX_PROPERTIES],
	pEarnType,
	bool:pInActivity,
	pActivityVehicle,
	pActivityParams[2],
	pSpectate,
	bool:pUsingWeapons[46],
	pWeaponsCheatWait,
	pSpamCheck[2],
	bool:pBanned,
	bool:pFrozen,
	pOldState,
	Float:pMark[4],
	pMark2,
	bool:pNoCMD,
	bool:pNoPM,
	pMute,
	pJail,
	pCameraMode,
	pFlyObject,
	pFlyKeys,
	pLR,
	pUD,
	pLastMove,
	Float:pAccelMul,
	Float:pMoveSpeed,
	Float:pCameraX[MAX_CAMERA_SAVES],
	Float:pCameraY[MAX_CAMERA_SAVES],
	Float:pCameraZ[MAX_CAMERA_SAVES],
	Float:pCameraLAX[MAX_CAMERA_SAVES],
	Float:pCameraLAY[MAX_CAMERA_SAVES],
	Float:pCameraLAZ[MAX_CAMERA_SAVES],
	pCameraDirection,
	Float:pCameraDistance,
	bool:pCameraFollow,
	pCameraFollowID,
	pKickIn,
	pSpecAsk,
	pQuest,
	pQuestStep,
	pShootTC[47],
	pWeaponWarns[2],
	pSawnoffAmmo,
	pChatJoinMessage[MAX_CHATS],
	pPointsCooldown[3],
	bool:pCooldownDelay[3],
	pPickupID,
	bool:pRadioSet,
	pTag[64],
	pTagColor,
	bool:pDeath[MAX_DCMDS],
	pTPAsk,
	bool:pInvisible,
	pChannel,
	bool:pChannelToggle,
	pRaise[3],
	PlayerText:pSpeedoText[3],
	bool:pSpeedoVisible,
	pChannelRampa[2]
}
enum e_Teleports
{
	tlName[32],
	tlCommand[32],
	Float:tlPos[4],
	Float:tlVPos[4],
	tlInterior,
	bool:tlWorld[MAX_WORLDS],
	tlLevel,
	bool:tlWithVehicle,
	bool:tlVIP,
	tlFreezeTime,
	tlCreator,
	bool:tlActive,
	tlArea[2],
	tlPlayers[MAX_WORLDS]
}
enum e_Checkpoints
{
	Float:cpPos[3],
	Float:cpSize,
	cpInterior,
	cpWorld,
	cpType
}
enum e_Checkpoint
{
	bool:cpActive,
	cpArea
}
enum e_Area
{
	bool:arValid,
	Float:arCoords[4],
	Float:arHeight[2],
	arWorld,
	arInterior,
	arType,
	arParam
}
enum e_Configuration
{
	cfgPassword[32],
	cfgHighestPlayerCount,
	cfgDefaultTime,
	cfgDefaultWeather,
	cfgMaxAdminLevel,
	cfgAutoMinigameTime,
	cfgGlobalRulesTime,
	cfgAutoMessageTime,
	cfgPropertyEarnTime,
	cfgMoneyAreaEarn,
	bool:cfgDisableCBug,
	bool:cfgDisableSawnoff22,
	cfgVIPMoneyAreaBonus,
	cfgVIPPropertyPercentBonus,
	cfgWriteLockedChat
}
enum e_Settings
{
	stName[32],
	stKey[16],
	stDefault
}
enum e_Levels
{
	lvlName[32],
	lvlExp,
	lvlBankLimit
}
enum e_Chat
{
	bool:chValid,
	bool:chProtected,
	chName[32],
	chPassword[32],
	chOnline
}
enum e_Activities
{
	actUID,
	actWorld,
	actTime,
	actName[32]
}
enum e_Vehicle
{
	bool:vValid,
	vCreatedBy,
	vACreatedBy,
	bool:vLocked,
	vModel,
	Float:vSpawnPos[4],
	vColors[2],
	vPaintjob,
	vInterior,
	vWorld,
	vNumberPlate[16]
}
enum e_Pickup
{
	bool:pkValid,
	pkModel,
	Float:pkPos[3],
	pkWorld,
	pkType,
	pkParam
}
enum e_Map
{
	bool:mLoaded,
	mName[32],
	mAuthor[32],
	mWorld,
	mObject[MAX_MAP_OBJECTS],
	mObjects
}
enum e_Exp
{
	eName[32],
	eColor[16],
	ePoints,
	eDescription[64]
}
enum e_DMZones
{
	dmCommand[32],
	dmName[32],
	Float:dmStatus[2],
	dmInterior,
	dmType,
	bool:dmHeadshots
}
enum e_MoneyAreas
{
	maName[32],
	Float:maCoords[4]
}
enum e_Groups
{
	gType,
	gName[32],
	gMember[MAX_GROUP_MEMBERS],
	gMembers,
	gColor[3],
	gHeadquarter
}
enum e_Headquarters
{
	hqClan,
	hqCommand[16],
	Float:hqPos[4],
	Float:hqVPos[4],
	hqVehicle[MAX_HQ_ITEMS],
	hqVehicles,
	hqObject[MAX_HQ_ITEMS],
	hqObjects,
	hqPickup[MAX_HQ_ITEMS],
	hqPickups
}
enum e_Ammunation
{
	aName[32],
	aWeapon,
	aCost,
	aAmmo,
	aLevel,
	aSlot
}
enum e_Properties
{
	prName[32],
	Float:prPos[3],
	prCost,
	prEarning,
	prPickup,
	prOwner
}
enum e_AdminCmdOptions
{
	acInitialize,
	acUpdate,
	acFind
}
enum e_AdminCmdList
{
	acName[32],
	acLevel
}
enum e_AdminCmdShortcuts
{
	acShortcut[16],
	acTarget[32]
}
enum e_GTASAHandling
{
	Float:esh_mass,
	Float:esh_turnMass,
	Float:esh_dragCoeff,
	Float:esh_centerOfMassX,
	Float:esh_centerOfMassY,
	Float:esh_centerOfMassZ,
	esh_percentSubmerged,
	Float:esh_tractionMultiplier,
	Float:esh_tractionLoss,
	Float:esh_tractionBias,
	esh_numberOfGears,
	Float:esh_maxVelocity,
	Float:esh_engineAcceleration,
	Float:esh_engineInertia,
	esh_driveType[5],
	esh_engineType[10],
	Float:esh_brakeDeceleration,
	Float:esh_brakeBias,
	Float:esh_steeringLock,
	Float:esh_suspensionForceLevel,
	Float:esh_suspensionDamping,
	Float:esh_suspensionHighSpeedDamping,
	Float:esh_suspensionUpperLimit,
	Float:esh_suspensionLowerLimit,
	Float:esh_suspensionFrontRearBias,
	Float:esh_suspensionAntiDriveMul, // multiplier
	Float:esh_seatOffsetDistance,
	Float:esh_collisionDmgMultiplier
};
enum e_Quests
{
	qUID,
	qName[32],
	qPath,
	qExp
};
enum e_Radio
{
	rdTitle[32],
	rdURL[128]
};
enum e_MoveObjects
{
	moHQ,
	moObjectID,
	Float:moPos[3],
	Float:moMPos[3],
	bool:moStatus
};
enum e_LCommands
{
	lcName[32],
	lcShort[32],
	lcLevel,
	lcWorlds[MAX_WORLDS],
	lcText[64]
};
enum e_Channels
{
	chName[32],
	chLevel,
	chWorlds[MAX_WORLDS],
	chPointsBlock[3],
	chText[64]
};
enum e_Skins
{
	skName[32],
	skLevel
};
// Arrays
new Worlds[][e_Worlds] =
{
	{world_class,"Class Selection",false},
	{world_stunts,"Stunts",true},
	{world_stuntswo,"Stunts WO",true},
	{world_dm,"DeathMatch",true},
	{world_tdm,"TDM",true}
};
new Checkpoints[][e_Checkpoints] =
{
	{{-23.6005,-54.9346,1003.5468},3.0,6,world_dm,cp_bank},
	{{289.8941,-84.1930,1001.5156},3.0,4,world_dm,cp_ammu}
};
new Settings[max_settings][e_Settings] =
{
	{"התחברות אוטומטית","autologin",1},
	{"צפייה בהודעות כניסה","showjoin",1},
	{"צפייה בהודעות יציאה","showquit",1},
	{"שיטת קרב","fs",1},
	{"שעון המשחק","clock",0},
	{"הודעות נקודות","exp",1}
};
new Levels[][e_Levels] =
{
	// {"Name",exp,banklimit}
	{"Guest",0,5000},
	{"Stoned Noob",0,5000},
	{"Noob",100,10000},
	{"Newbie",300,15000},
	{"Less Newbie",650,20000},
	{"Beginner",1000,30000},
	{"Recruit",1500,40000},
	{"Novice",2150,50000},
	{"Rookie",2800,60000},
	{"Trainee",4000,80000},
	{"Newcomer",5500,100000},
	{"Amateur",7000,120000},
	{"Apprentice",9000,140000},
	{"Nice player",11500,160000},
	{"Good player",14000,180000},
	{"Great player",18000,200000},
	{"A super strong player",22500,225000},
	{"Experienced Player",27500,250000},
	{"Wanted Criminal",33000,275000},
	{"Veteran",39500,300000},
	{"Gangster",46500,350000},
	{"Pro",54000,400000},
	{"Super Pro",62000,450000},
	{"Combat Terminator",72000,500000},
	{"Champion",83500,550000},
	{"Underdog",97000,600000},
	{"Genius",115000,650000},
	{"Superman",130500,700000},
	{"Serial-Killer",148000,800000},
	{"Mega man",168500,900000},
	{"Pro Gamer",180000,1000000},
	{"Crazy",200000,1200000},
	{"Evil",220550,1400000},
	{"Cheater",246000,1600000},
	{"Sharp and Mighty",279000,1800000},
	{"Scary",300000,2000000},
	{"Incredibly Scary",338000,2250000},
	{"Mad man",380500,2500000},
	{"Hell's Guardian",421750,2750000},
	{"Extremely Powerful",453250,3000000},
	{"GTA Pro",484500,3500000},
	{"King",525500,0},
	{"Hacker",565500,0},
	{"Master",605000,0},
	{"The Angel",645000,0},
	{"SAMP-IL Pro",680000,0},
	{"SAMP-IL God-like King",715500,0},
	{"The Devil",730500,0},
	{"Goddess",750000,0},
	{"God",775000,0},
	{"The god of gods",800000,0}
};
new Activities[][e_Activities] =
{
	{1,world_dm,30,"Random War"},
	{2,world_dm,30,"War Game"},
	{3,world_dm,60,"Matrix"},
	{4,world_dm,60,"Gun Game"}/*,
	{5,world_stunts,60,"Bike Jump"},
	{6,world_stuntswo,60,"Bumper"},
	{7,world_stuntswo,60,"Race War"}*/
};
new Exp[][e_Exp] =
{
	{"Kill","~r~",10,"להרוג שחקן בשרת"},
	{"Assist","~r~~h~",5,"ביצוע פגיעה מרובה בשחקן שלא נהרג על ידיך"},
	{"Headshots","~l~",15,"להרוג בהד-שוט"},
	{"Stunts","~b~",1,"להרוויח נקודות סטאנטים"},
	{"Drifts","~g~",1,"להרוויח 10 נקודות דריפטים"},
	{"Speed","~y~",1,"להרוויח 10 נקודות מהירות"},
	{"Activity Win","~p~",50,"ניצחון בפעילות"},
	{"Playing Time","~p~~h~",25,"לשחק חצי שעה בשרת"},
	{"Stunt Quest","~g~~h~",1,"לבצע קווסט של עולם הסטאנטים"},
	{"Money Area","~b~~h~",1,"עשר שניות באזור כסף"}
};
new DMZones[][e_DMZones] =
{
	{"/heavy","Heavy Weapons",{100.0,100.0},10,1,true},
	{"/light","Light Weapons",{100.0,100.0},0,2,false}
};
new MoneyAreas[][e_MoneyAreas] =
{
	{"Pirate Ship",{1995.5,1518.0,2006.0,1569.0}},
	{"Cemetery",{804.0,-1127.1,867.1,-1069.0}},
	{"Cemetery",{867.1,-1127.1,938.2,-1052.9}}
};
new AdminCommandList[][e_AdminCmdList] =
{
	{"/ahelp",1},
	{"/vehicle",7},
	{"/vdel",7},
	{"/vsave",7},
	{"/vsaveall",7},
	{"/vamount",7},
	{"/teleport",10},
	{"/map",9},
	{"/createclan",7},
	{"/deleteclan",7},
	{"/setclan",7},
	{"/remclan",7},
	{"/setlclan",7},
	{"/clanname",7},
	{"/loadhq",7},
	{"/unloadhq",7},
	{"/reloadhq",7},
	{"/gotohq",7},
	{"/createcrew",7},
	{"/deletecrew",7},
	{"/setcrew",7},
	{"/remcrew",7},
	{"/setlcrew",7},
	{"/crewname",7},
	{"/inv",1},
	{"/say",1},
	{"/asay",1},
	{"/freeze",1},
	{"/unfreeze",1},
	{"/mute",1},
	{"/unmute",1},
	{"/jail",1},
	{"/unjail",1},
	{"/disarm",1},
	{"/aeject",1},
	{"/settime",1},
	{"/setweather",1},
	{"/goto",1},
	{"/get",1},
	{"/getc",1},
	{"/cc",1},
	{"/cl",1},
	{"/explode",3},
	{"/pexplode",3},
	{"/togcmd",3},
	{"/togpm",3},
	{"/akill",1},
	{"/respawn",1},
	{"/ajetpack",2},
	{"/sworld",1},
	{"/spec",1},
	{"/specoff",1},
	{"/slap",1},
	{"/sislap",1},
	{"/getbank",1},
	{"/kick",1},
	{"/ban",1},
	{"/b",1},
	{"/aadv",1},
	{"/banip",1},
	{"/unban",1},
	{"/baninfo",1},
	{"/actout",1},
	{"/resetmoney",4},
	{"/details",1},
	{"/unlockall",4},
	{"/resetvehicles",4},
	{"/fixall",4},
	{"/full",1},
	{"/giveweapon",4},
	{"/sethealth",4},
	{"/setarmour",4},
	{"/setvhealth",4},
	{"/setcolor",4},
	{"/setvcolor",5},
	{"/setvpaintjob",5},
	{"/setskin",4},
	{"/setpos",6},
	{"/getpos",6},
	{"/angle",6},
	{"/pfix",4},
	{"/smark",7},
	{"/gmark",7},
	{"/rmark",7},
	{"/nocmd",7},
	{"/nopm",7},
	{"/setname",5},
	{"/givemoney",7},
	{"/setmoney",7},
	{"/removemoney",7},
	{"/setinterior",8},
	{"/setworld",8},
	{"/lockchat",6},
	{"/godmod",7},
	{"/pgodmod",7},
	{"/start",1},
	{"/end",1},
	{"/setadmin",9},
	{"/tmpadmin",9},
	{"/setlevel",9},
	{"/deflevel",9},
	{"/spassword",10},
	{"/hostname",10},
	{"/gmx",10},
	{"/serverexit",10},
	{"/aradio",2},
	{"/cradio",8},
	{"/settag",9},
	{"/deltag",9},
	{"/settagcolor",9},
	{"/setgravity",9},
	{"/hostname",9},
	{"/spassword",9},
	{"/cd",4},
	{"/scd",4}
};
new AdminCommandShortcuts[][e_AdminCmdShortcuts] =
{
	{"/v","/vehicle"},
	{"/f","/freeze"},
	{"/unf","/unfreeze"},
	{"/m","/mute"},
	{"/unm","/unmute"},
	{"/j","/jali"},
	{"/unj","/unjail"},
	{"/d","/disarm"},
	{"/rv","/resetvehicles"},
	{"/gm","/givemoney"},
	{"/sm","/setmoney"},
	{"/rm","/resetmoney"},
	{"/gw","/giveweapon"},
	{"/setwea","/setweather"},
	{"/xp","/explode"},
	{"/pxp","/pexplode"}
};
new const GTASAHandling[][e_GTASAHandling] =
{	// by Hesse
	{1700.0, 5008.299805, 2.500000, 0.000000, 0.000000, -0.300000, 85, 2.500000, 2.500000, 2.500000, 5, 160.0, 10.000000, 160.0, "awd", "diesel", 6.2, 0.6, 35.0, 2.4, 0.1, 0.0, 0.3, -0.1, 0.5, 0.3, 0.3, 0.2},
	{1300.0, 2200.000000, 1.700000, 0.000000, 0.300000, 0.000000, 70, 1.700000, 1.700000, 1.700000, 5, 160.0, 6.000000, 160.0, "fwd", "petrol", 8.0, 0.8, 30.0, 1.3, 0.1, 0.0, 0.3, -0.2, 0.6, 0.0, 0.3, 0.5},
	{1500.0, 4000.000000, 2.000000, 0.000000, 0.000000, -0.100000, 85, 2.000000, 2.000000, 2.000000, 5, 200.0, 11.200000, 200.0, "rwd", "petrol", 11.0, 0.4, 30.0, 1.2, 0.1, 0.0, 0.3, -0.2, 0.5, 0.4, 0.3, 0.5},
	{3800.0, 19953.199219, 5.000000, 0.000000, 0.000000, -0.200000, 90, 5.000000, 5.000000, 5.000000, 5, 120.0, 10.000000, 120.0, "rwd", "diesel", 8.0, 0.3, 25.0, 1.6, 0.1, 0.0, 0.4, -0.2, 0.5, 0.0, 0.6, 0.3},
	{1200.0, 3000.000000, 2.500000, 0.000000, 0.100000, 0.000000, 70, 2.500000, 2.500000, 2.500000, 5, 150.0, 7.200000, 150.0, "fwd", "petrol", 4.0, 0.8, 30.0, 1.4, 0.1, 0.0, 0.4, -0.2, 0.5, 0.0, 0.2, 0.6},
	{1600.0, 4000.000000, 2.200000, 0.000000, 0.000000, -0.200000, 75, 2.200000, 2.200000, 2.200000, 5, 165.0, 9.600000, 165.0, "rwd", "petrol", 10.0, 0.5, 27.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.5, 0.3, 0.2, 0.6},
	{20000.0, 200000.000000, 4.000000, 0.000000, 0.500000, -0.400000, 90, 4.000000, 4.000000, 4.000000, 4, 110.0, 10.000000, 110.0, "rwd", "diesel", 3.2, 0.4, 30.0, 0.8, 0.1, 0.0, 0.2, -0.3, 0.6, 0.0, 0.4, 0.2},
	{6500.0, 36670.800781, 3.000000, 0.000000, 0.000000, 0.000000, 90, 3.000000, 3.000000, 3.000000, 5, 170.0, 10.800000, 170.0, "rwd", "diesel", 10.0, 0.4, 27.0, 1.2, 0.1, 0.0, 0.5, -0.2, 0.5, 0.0, 0.2, 0.3},
	{5500.0, 33187.898438, 5.000000, 0.000000, 0.000000, -0.200000, 90, 5.000000, 5.000000, 5.000000, 4, 110.0, 8.000000, 110.0, "rwd", "diesel", 3.5, 0.4, 30.0, 1.0, 0.1, 0.0, 0.4, -0.3, 0.6, 0.3, 0.4, 0.2},
	{2200.0, 10000.000000, 1.800000, 0.000000, 0.000000, 0.000000, 75, 1.800000, 1.800000, 1.800000, 5, 180.0, 7.200000, 180.0, "rwd", "petrol", 10.0, 0.4, 30.0, 1.1, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.2, 0.7},
	{1000.0, 1400.000000, 2.800000, 0.000000, 0.200000, 0.000000, 70, 2.800000, 2.800000, 2.800000, 3, 160.0, 7.600000, 160.0, "fwd", "petrol", 8.0, 0.8, 30.0, 1.2, 0.1, 5.0, 0.3, -0.2, 0.5, 0.2, 0.3, 0.5},
	{1400.0, 2725.300049, 1.500000, 0.000000, 0.000000, -0.250000, 70, 1.500000, 1.500000, 1.500000, 5, 240.0, 12.000000, 240.0, "awd", "petrol", 11.0, 0.5, 30.0, 1.2, 0.2, 0.0, 0.3, -0.1, 0.5, 0.4, 0.4, 0.7},
	{1800.0, 4411.500000, 2.000000, 0.000000, -0.100000, -0.200000, 70, 2.000000, 2.000000, 2.000000, 5, 160.0, 9.200000, 160.0, "rwd", "petrol", 6.5, 0.5, 30.0, 1.0, 0.1, 0.0, 0.2, -0.3, 0.5, 0.6, 0.3, 0.4},
	{2600.0, 8666.700195, 3.000000, 0.000000, 0.000000, -0.250000, 80, 3.000000, 3.000000, 3.000000, 5, 160.0, 6.000000, 160.0, "rwd", "diesel", 6.0, 0.8, 30.0, 2.6, 0.1, 0.0, 0.3, -0.2, 0.3, 0.0, 0.2, 0.5},
	{3500.0, 14000.000000, 4.000000, 0.000000, 0.000000, 0.100000, 80, 4.000000, 4.000000, 4.000000, 5, 140.0, 7.200000, 140.0, "rwd", "diesel", 4.5, 0.6, 30.0, 2.0, 0.1, 5.0, 0.3, -0.2, 0.5, 0.0, 0.5, 0.5},
	{1200.0, 3000.000000, 2.000000, 0.000000, -0.200000, -0.200000, 70, 2.000000, 2.000000, 2.000000, 5, 230.0, 12.000000, 230.0, "rwd", "petrol", 11.1, 0.5, 35.0, 0.8, 0.2, 0.0, 0.1, -0.2, 0.5, 0.6, 0.4, 0.5},
	{2600.0, 10202.799805, 2.500000, 0.000000, 0.000000, -0.100000, 90, 2.500000, 2.500000, 2.500000, 5, 155.0, 9.600000, 155.0, "awd", "diesel", 7.0, 0.6, 35.0, 1.0, 0.1, 0.0, 0.4, -0.2, 0.5, 0.0, 0.6, 0.3},
	{15000.0, 200000.000000, 0.100000, 0.000000, 0.000000, 0.000000, 30, 0.100000, 0.100000, 0.100000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 5.0, 0.4, 30.0, 1.0, 0.1, 0.0, 0.5, -0.2, 0.9, 0.0, 0.3, 0.5},
	{2000.0, 5848.299805, 2.800000, 0.000000, 0.200000, -0.100000, 85, 2.800000, 2.800000, 2.800000, 5, 150.0, 6.000000, 150.0, "rwd", "diesel", 5.5, 0.6, 30.0, 1.4, 0.1, 0.0, 0.3, -0.2, 0.6, 0.0, 0.2, 0.8},
	{1800.0, 4350.000000, 2.000000, 0.000000, 0.000000, 0.000000, 70, 2.000000, 2.000000, 2.000000, 5, 160.0, 7.200000, 160.0, "rwd", "petrol", 4.0, 0.6, 28.0, 1.0, 0.1, 1.0, 0.3, -0.2, 0.5, 0.0, 0.4, 0.5},
	{1450.0, 4056.399902, 2.200000, 0.000000, 0.300000, -0.250000, 75, 2.200000, 2.200000, 2.200000, 5, 180.0, 7.600000, 180.0, "fwd", "petrol", 9.1, 0.6, 35.0, 1.4, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.2, 0.5},
	{1850.0, 5000.000000, 2.200000, 0.000000, 0.000000, -0.100000, 75, 2.200000, 2.200000, 2.200000, 5, 180.0, 8.400000, 180.0, "rwd", "petrol", 7.5, 0.6, 30.0, 1.0, 0.2, 0.0, 0.3, -0.2, 0.5, 0.3, 0.2, 0.6},
	{1700.0, 4000.000000, 2.500000, 0.000000, 0.050000, -0.200000, 75, 2.500000, 2.500000, 2.500000, 5, 165.0, 8.000000, 165.0, "awd", "diesel", 8.5, 0.5, 35.0, 1.5, 0.1, 5.0, 0.3, -0.2, 0.4, 0.0, 0.3, 0.2},
	{1700.0, 4108.299805, 3.500000, 0.000000, 0.000000, 0.000000, 85, 3.500000, 3.500000, 3.500000, 5, 145.0, 5.600000, 145.0, "rwd", "diesel", 4.2, 0.8, 35.0, 1.2, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.2, 0.8},
	{1200.0, 2000.000000, 4.000000, 0.000000, -0.100000, -0.100000, 80, 4.000000, 4.000000, 4.000000, 4, 170.0, 12.000000, 170.0, "rwd", "petrol", 6.0, 0.5, 35.0, 1.0, 0.1, 5.0, 0.2, -0.2, 0.4, 0.0, 0.4, 0.4},
	{10000.0, 150000.000000, 0.200000, 0.000000, 0.000000, 0.000000, 75, 0.200000, 0.200000, 0.200000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 5.0, 0.4, 30.0, 1.0, 0.1, 0.0, 0.2, -0.2, 0.9, 0.0, 0.4, 0.5},
	{1600.0, 3921.300049, 1.800000, 0.000000, -0.400000, 0.000000, 75, 1.800000, 1.800000, 1.800000, 5, 200.0, 8.800000, 200.0, "rwd", "petrol", 10.0, 0.5, 35.0, 1.3, 0.1, 0.0, 0.3, -0.1, 0.4, 0.0, 0.2, 0.2},
	{4000.0, 17333.300781, 1.800000, 0.000000, 0.100000, 0.000000, 85, 1.800000, 1.800000, 1.800000, 5, 170.0, 8.000000, 170.0, "rwd", "diesel", 5.4, 0.4, 27.0, 1.4, 0.1, 0.0, 0.4, -0.3, 0.5, 0.0, 0.3, 0.2},
	{7000.0, 30916.699219, 1.500000, 0.000000, 0.000000, 0.000000, 90, 1.500000, 1.500000, 1.500000, 5, 170.0, 6.000000, 170.0, "rwd", "diesel", 8.4, 0.4, 27.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.3, 0.3},
	{1400.0, 3000.000000, 2.000000, 0.000000, 0.000000, -0.200000, 70, 2.000000, 2.000000, 2.000000, 5, 200.0, 13.200000, 200.0, "rwd", "petrol", 8.0, 0.5, 34.0, 1.6, 0.1, 5.0, 0.3, -0.2, 0.5, 0.3, 0.2, 0.5},
	{2200.0, 29333.300781, 1.000000, 0.000000, 0.000000, 0.000000, 14, 1.000000, 1.000000, 1.000000, 5, 190.0, 0.680000, 190.0, "rwd", "petrol", 0.1, 0.0, 24.0, 1.0, 3.0, 0.0, 0.1, 0.1, 0.0, 0.0, 0.2, 0.3},
	{5500.0, 33187.898438, 2.000000, 0.000000, 0.500000, 0.000000, 90, 2.000000, 2.000000, 2.000000, 4, 130.0, 5.600000, 130.0, "rwd", "diesel", 4.2, 0.4, 30.0, 1.2, 0.1, 0.0, 0.4, -0.3, 0.4, 0.0, 0.2, 0.8},
	{25000.0, 250000.000000, 5.000000, 0.000000, 0.000000, 0.000000, 90, 5.000000, 5.000000, 5.000000, 4, 80.0, 16.000000, 80.0, "awd", "diesel", 5.0, 0.5, 35.0, 0.4, 0.0, 0.0, 0.3, -0.1, 0.5, 0.0, 0.2, 0.1},
	{10500.0, 61407.500000, 4.000000, 0.000000, 0.000000, 0.000000, 90, 4.000000, 4.000000, 4.000000, 5, 180.0, 8.000000, 180.0, "awd", "diesel", 4.0, 0.4, 27.0, 1.2, 0.1, 0.0, 0.5, -0.2, 0.5, 0.0, 0.6, 0.3},
	{1400.0, 3400.000000, 2.500000, 0.000000, 0.300000, -0.300000, 75, 2.500000, 2.500000, 2.500000, 5, 200.0, 11.200000, 200.0, "rwd", "petrol", 11.0, 0.4, 30.0, 0.8, 0.1, 0.0, 0.3, -0.2, 0.4, 0.3, 0.2, 0.6},
	{3800.0, 30000.000000, 2.000000, 0.000000, 0.000000, -0.500000, 90, 2.000000, 2.000000, 2.000000, 5, 120.0, 7.200000, 120.0, "rwd", "diesel", 8.0, 0.3, 25.0, 1.5, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.6, 0.3},
	{1400.0, 3000.000000, 2.000000, 0.000000, 0.300000, -0.100000, 70, 2.000000, 2.000000, 2.000000, 4, 160.0, 7.200000, 160.0, "fwd", "petrol", 8.0, 0.6, 35.0, 1.1, 0.1, 2.0, 0.3, -0.2, 0.6, 0.3, 0.2, 0.5},
	{9500.0, 57324.601563, 1.800000, 0.000000, 0.000000, 0.000000, 90, 1.800000, 1.800000, 1.800000, 5, 160.0, 7.200000, 160.0, "rwd", "diesel", 5.7, 0.3, 30.0, 1.5, 0.0, 0.0, 0.4, -0.3, 0.5, 0.0, 0.4, 0.5},
	{1750.0, 4351.700195, 2.900000, 0.000000, 0.100000, -0.150000, 75, 2.900000, 2.900000, 2.900000, 4, 160.0, 9.600000, 160.0, "rwd", "petrol", 7.0, 0.4, 40.0, 0.7, 0.1, 2.0, 0.3, -0.3, 0.5, 0.5, 0.2, 0.4},
	{1600.0, 3921.300049, 2.000000, 0.000000, 0.000000, -0.150000, 70, 2.000000, 2.000000, 2.000000, 4, 160.0, 9.200000, 160.0, "rwd", "petrol", 8.2, 0.5, 35.0, 1.2, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.3, 0.6},
	{2000.0, 4901.700195, 2.400000, 0.000000, 0.400000, -0.100000, 85, 2.400000, 2.400000, 2.400000, 5, 160.0, 7.200000, 160.0, "fwd", "petrol", 5.5, 0.4, 30.0, 1.4, 0.1, 0.0, 0.4, -0.1, 0.5, 0.0, 0.2, 0.6},
	{100.0, 24.100000, 6.000000, 0.000000, 0.050000, -0.100000, 70, 6.000000, 6.000000, 6.000000, 1, 75.0, 14.000000, 75.0, "awd", "electric", 5.5, 0.5, 25.0, 1.6, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.2, 0.1},
	{2500.0, 5960.399902, 2.000000, 0.000000, -0.800000, 0.200000, 70, 2.000000, 2.000000, 2.000000, 5, 150.0, 6.400000, 150.0, "rwd", "petrol", 4.0, 0.8, 30.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.4, 0.0, 0.2, 1.3},
	{8000.0, 48273.300781, 2.000000, 0.000000, 0.000000, 0.000000, 90, 2.000000, 2.000000, 2.000000, 5, 150.0, 5.200000, 150.0, "rwd", "diesel", 5.7, 0.3, 30.0, 1.5, 0.0, 0.0, 0.4, -0.3, 0.5, 0.0, 0.6, 0.4},
	{5000.0, 20000.000000, 3.000000, 0.000000, 0.000000, -0.350000, 80, 3.000000, 3.000000, 3.000000, 5, 110.0, 18.000000, 110.0, "awd", "petrol", 7.0, 0.4, 35.0, 1.5, 0.1, 0.0, 0.4, -0.3, 0.5, 0.3, 0.4, 0.3},
	{1650.0, 3851.399902, 2.000000, 0.000000, 0.000000, -0.050000, 75, 2.000000, 2.000000, 2.000000, 5, 165.0, 8.800000, 165.0, "fwd", "petrol", 8.5, 0.5, 30.0, 1.0, 0.2, 0.0, 0.3, -0.2, 0.5, 0.6, 0.2, 0.6},
	{2200.0, 29333.300781, 1.000000, 0.000000, 0.000000, 0.000000, 42, 1.000000, 1.000000, 1.000000, 5, 190.0, 1.200000, 190.0, "rwd", "petrol", 0.0, 0.0, 24.0, 0.4, 5.0, 0.0, 0.1, 0.1, 0.0, 0.0, 0.2, 0.3},
	{3000.0, 7250.000000, 0.100000, 0.000000, 0.000000, -0.100000, 5, 0.100000, 0.100000, 0.100000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 5.0, 0.4, 30.0, 2.0, 0.1, 0.0, 0.5, -0.2, 0.5, 0.0, 0.3, 0.6},
	{350.0, 119.599998, 5.000000, 0.000000, 0.050000, -0.100000, 103, 5.000000, 5.000000, 5.000000, 3, 190.0, 12.000000, 190.0, "rwd", "petrol", 14.0, 0.5, 35.0, 1.0, 0.2, 0.0, 0.1, -0.2, 0.5, 0.0, 0.0, 0.1},
	{1900.0, 4795.899902, 1.000000, 0.000000, -0.300000, 0.000000, 85, 1.000000, 1.000000, 1.000000, 5, 150.0, 10.000000, 150.0, "rwd", "petrol", 8.5, 0.4, 30.0, 1.3, 0.1, 0.0, 0.0, -1.0, 0.4, 0.5, 0.2, 0.5},
	{3800.0, 30000.000000, 2.000000, 0.000000, 0.000000, -0.500000, 90, 2.000000, 2.000000, 2.000000, 5, 120.0, 7.200000, 120.0, "rwd", "diesel", 8.0, 0.3, 25.0, 1.5, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.6, 0.3},
	{1400.0, 3000.000000, 2.000000, 0.000000, -0.300000, -0.200000, 70, 2.000000, 2.000000, 2.000000, 5, 240.0, 12.000000, 240.0, "awd", "petrol", 11.0, 0.5, 30.0, 1.2, 0.1, 0.0, 0.2, -0.2, 0.5, 0.4, 0.2, 0.7},
	{2200.0, 20210.699219, 1.000000, 0.000000, 0.000000, 0.000000, 22, 1.000000, 1.000000, 1.000000, 5, 190.0, 1.000000, 190.0, "rwd", "petrol", 0.0, 0.0, 20.0, 1.3, 3.0, 0.0, 0.1, 0.5, 2.0, 0.0, 0.7, 0.4},
	{5000.0, 25520.800781, 1.000000, 0.000000, 0.000000, 0.000000, 15, 1.000000, 1.000000, 1.000000, 5, 190.0, 0.280000, 190.0, "rwd", "petrol", 0.0, 0.0, 25.0, 1.0, 3.0, 0.0, 0.1, 0.1, 0.0, 0.0, 0.2, 0.4},
	{2200.0, 29333.300781, 1.000000, 0.000000, 0.000000, 0.000000, 10, 1.000000, 1.000000, 1.000000, 5, 190.0, 0.560000, 190.0, "rwd", "petrol", 0.1, 0.0, 24.0, 1.8, 3.0, 0.0, 0.1, 0.1, 0.0, 0.0, 0.2, 0.3},
	{8500.0, 48804.199219, 2.500000, 0.000000, 0.000000, 0.300000, 90, 2.500000, 2.500000, 2.500000, 5, 140.0, 10.000000, 140.0, "rwd", "diesel", 10.0, 0.4, 27.0, 1.2, 0.1, 0.0, 0.5, -0.2, 0.5, 0.0, 0.6, 0.4},
	{4500.0, 18003.699219, 3.000000, 0.000000, 0.000000, 0.000000, 80, 3.000000, 3.000000, 3.000000, 5, 160.0, 5.600000, 160.0, "rwd", "diesel", 4.5, 0.8, 30.0, 1.8, 0.1, 0.0, 0.3, -0.3, 0.5, 0.0, 0.3, 0.4},
	{1000.0, 1354.199951, 4.000000, 0.000000, 0.000000, -0.100000, 70, 4.000000, 4.000000, 4.000000, 3, 160.0, 6.000000, 160.0, "awd", "electric", 13.0, 0.5, 30.0, 1.0, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5},
	{2000.0, 5500.000000, 2.000000, 0.000000, 0.000000, 0.000000, 75, 2.000000, 2.000000, 2.000000, 4, 165.0, 8.000000, 165.0, "rwd", "petrol", 5.0, 0.6, 30.0, 1.2, 0.1, 0.0, 0.3, -0.2, 0.5, 0.2, 0.2, 0.5},
	{1900.0, 6333.299805, 2.000000, 0.000000, 0.000000, -0.200000, 80, 2.000000, 2.000000, 2.000000, 5, 160.0, 6.000000, 160.0, "rwd", "diesel", 6.0, 0.8, 30.0, 1.5, 0.1, 2.0, 0.3, -0.2, 0.4, 0.0, 0.2, 0.4},
	{5000.0, 27083.300781, 12.000000, 0.000000, 0.000000, 0.000000, 9, 12.000000, 12.000000, 12.000000, 1, 200.0, 0.680000, 200.0, "awd", "petrol", 0.0, 0.1, 24.0, 1.5, 0.8, 0.0, 0.1, 0.0, 2.0, 0.0, 1.0, 0.1},
	{500.0, 161.699997, 4.000000, 0.000000, 0.050000, -0.090000, 103, 4.000000, 4.000000, 4.000000, 5, 190.0, 20.000000, 190.0, "rwd", "petrol", 15.0, 0.5, 35.0, 0.9, 0.2, 0.0, 0.2, -0.2, 0.5, 0.0, 0.0, 0.2},
	{350.0, 119.599998, 5.000000, 0.000000, 0.050000, -0.100000, 103, 5.000000, 5.000000, 5.000000, 3, 190.0, 12.000000, 190.0, "rwd", "petrol", 14.0, 0.5, 35.0, 1.0, 0.2, 0.0, 0.1, -0.2, 0.5, 0.0, 0.0, 0.1},
	{800.0, 403.299988, 4.000000, 0.000000, 0.100000, 0.000000, 103, 4.000000, 4.000000, 4.000000, 4, 190.0, 16.000000, 190.0, "rwd", "petrol", 10.0, 0.6, 35.0, 0.6, 0.2, 0.0, 0.1, -0.1, 0.6, 0.0, 0.0, 0.2},
	{100.0, 50.000000, 120.000000, 0.000000, 0.000000, 0.000000, 99, 120.000000, 120.000000, 120.000000, 1, 75.0, 0.400000, 75.0, "fwd", "petrol", 0.5, 0.5, 45.0, 0.6, 0.1, 0.0, 0.3, -0.0, 0.8, 0.0, 0.2, 0.1},
	{100.0, 24.100000, 0.200000, 0.000000, 0.000000, -0.100000, 70, 0.200000, 0.200000, 0.200000, 1, 75.0, 14.000000, 75.0, "awd", "petrol", 5.5, 0.5, 25.0, 1.6, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.2, 0.1},
	{1600.0, 4000.000000, 2.500000, 0.000000, 0.000000, 0.050000, 75, 2.500000, 2.500000, 2.500000, 5, 160.0, 8.800000, 160.0, "rwd", "petrol", 6.2, 0.6, 30.0, 0.8, 0.1, 0.0, 0.3, -0.2, 0.5, 0.5, 0.2, 0.4},
	{1900.0, 4529.899902, 2.000000, 0.000000, 0.000000, 0.000000, 75, 2.000000, 2.000000, 2.000000, 5, 160.0, 6.400000, 160.0, "rwd", "petrol", 5.0, 0.6, 30.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.5, 0.5, 0.2, 0.4},
	{500.0, 195.000000, 5.000000, 0.000000, 0.050000, -0.090000, 103, 5.000000, 5.000000, 5.000000, 5, 190.0, 20.000000, 190.0, "rwd", "petrol", 14.0, 0.5, 35.0, 0.9, 0.2, 0.0, 0.2, -0.2, 0.5, 0.0, 0.0, 0.2},
	{2500.0, 6041.700195, 0.200000, 0.000000, 0.000000, -0.100000, 75, 0.200000, 0.200000, 0.200000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 5.0, 0.4, 30.0, 2.0, 0.1, 0.0, 0.5, -0.2, 0.5, 0.0, 0.3, 0.5},
	{2500.0, 7968.700195, 2.500000, 0.000000, 0.000000, 0.000000, 80, 2.500000, 2.500000, 2.500000, 5, 170.0, 10.000000, 170.0, "awd", "petrol", 8.0, 0.5, 30.0, 1.5, 0.1, 4.0, 0.3, -0.3, 0.5, 0.0, 0.3, 0.3},
	{400.0, 300.000000, 5.000000, 0.000000, 0.050000, -0.200000, 70, 5.000000, 5.000000, 5.000000, 4, 160.0, 10.000000, 160.0, "awd", "petrol", 8.0, 0.5, 35.0, 0.8, 0.1, 0.0, 0.2, -0.2, 0.5, 0.0, 0.2, 0.5},
	{1200.0, 6525.000000, 1.000000, 0.000000, -0.300000, 0.000000, 14, 1.000000, 1.000000, 1.000000, 5, 190.0, 0.640000, 190.0, "rwd", "petrol", 0.1, 0.0, 24.0, 1.0, 3.0, 0.0, 3.2, 0.1, 2.5, 0.0, 0.2, 0.2},
	{800.0, 1483.300049, 1.000000, 0.000000, 0.000000, 0.000000, 16, 1.000000, 1.000000, 1.000000, 5, 190.0, 0.480000, 190.0, "rwd", "petrol", 0.1, 0.0, 30.0, 1.0, 4.5, 0.0, 3.5, 0.1, 0.7, 0.0, 0.2, 0.1},
	{1950.0, 4712.500000, 2.000000, 0.000000, 0.300000, 0.000000, 70, 2.000000, 2.000000, 2.000000, 5, 160.0, 7.200000, 160.0, "fwd", "petrol", 3.5, 0.6, 28.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.6, 0.0, 0.3, 0.4},
	{1700.0, 4000.000000, 2.000000, 0.000000, 0.100000, 0.000000, 70, 2.000000, 2.000000, 2.000000, 4, 160.0, 9.600000, 160.0, "rwd", "petrol", 8.0, 0.5, 35.0, 1.3, 0.1, 5.0, 0.3, -0.2, 0.5, 0.3, 0.3, 0.5},
	{5000.0, 27083.300781, 10.000000, 0.000000, 0.000000, 0.000000, 75, 10.000000, 10.000000, 10.000000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 1.5, 0.4, 45.0, 2.0, 0.2, 0.0, 0.5, -0.2, 0.5, 0.0, 0.3, 0.8},
	{1400.0, 2979.699951, 2.000000, 0.000000, 0.200000, -0.100000, 70, 2.000000, 2.000000, 2.000000, 5, 200.0, 11.200000, 200.0, "rwd", "petrol", 11.1, 0.5, 30.0, 1.2, 0.1, 0.0, 0.3, -0.2, 0.5, 0.3, 0.2, 0.6},
	{1850.0, 3534.000000, 2.500000, 0.000000, 0.000000, 0.000000, 75, 2.500000, 2.500000, 2.500000, 4, 150.0, 5.600000, 150.0, "awd", "diesel", 6.5, 0.5, 35.0, 1.6, 0.1, 0.0, 0.3, -0.2, 0.4, 0.0, 0.3, 0.2},
	{1500.0, 3800.000000, 2.000000, 0.000000, 0.200000, 0.000000, 75, 2.000000, 2.000000, 2.000000, 4, 165.0, 6.400000, 165.0, "fwd", "petrol", 5.0, 0.6, 30.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.5, 0.2, 0.2, 0.5},
	{1400.0, 2200.000000, 2.200000, 0.000000, 0.100000, -0.200000, 75, 2.200000, 2.200000, 2.200000, 5, 200.0, 12.000000, 200.0, "awd", "petrol", 11.0, 0.4, 30.0, 1.4, 0.1, 3.0, 0.3, -0.2, 0.5, 0.3, 0.3, 0.6},
	{100.0, 39.000000, 7.000000, 0.000000, 0.050000, -0.090000, 103, 7.000000, 7.000000, 7.000000, 5, 120.0, 7.200000, 120.0, "rwd", "petrol", 19.0, 0.5, 35.0, 0.8, 0.2, 0.0, 0.2, -0.1, 0.5, 0.0, 0.0, 0.2},
	{1900.0, 5000.000000, 2.500000, 0.000000, 0.000000, -0.200000, 85, 2.500000, 2.500000, 2.500000, 5, 150.0, 10.000000, 150.0, "rwd", "petrol", 8.5, 0.4, 30.0, 1.3, 0.1, 2.0, 0.4, -0.3, 0.4, 0.5, 0.2, 0.5},
	{1900.0, 4000.000000, 2.600000, 0.000000, -0.500000, -0.400000, 85, 2.600000, 2.600000, 2.600000, 5, 120.0, 6.400000, 120.0, "rwd", "petrol", 8.5, 0.4, 30.0, 1.1, 0.1, 0.0, 0.3, -0.1, 0.4, 0.5, 0.2, 0.5},
	{5000.0, 155520.796875, 1.000000, 0.000000, 0.000000, 0.000000, 10, 1.000000, 1.000000, 1.000000, 5, 190.0, 0.200000, 190.0, "rwd", "petrol", 0.0, 0.0, 38.0, 1.0, 3.0, 0.0, 0.1, 0.0, 1.0, 0.0, 0.2, 0.4},
	{1000.0, 1354.199951, 5.000000, 0.000000, 0.400000, -0.200000, 70, 5.000000, 5.000000, 5.000000, 3, 160.0, 8.000000, 160.0, "rwd", "electric", 5.0, 0.5, 30.0, 2.0, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5},
	{10000.0, 35000.000000, 20.000000, 0.000000, -0.500000, -0.500000, 90, 20.000000, 20.000000, 20.000000, 5, 100.0, 14.000000, 100.0, "awd", "diesel", 5.0, 0.4, 45.0, 1.4, 0.2, 0.0, 0.3, -0.2, 0.3, 0.0, 0.4, 0.2},
	{5000.0, 29270.800781, 0.200000, 0.000000, 0.000000, -0.100000, 75, 0.200000, 0.200000, 0.200000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 5.0, 0.4, 30.0, 2.0, 0.2, 0.0, 0.5, -0.2, 0.5, 0.0, 0.3, 0.8},
	{3500.0, 8458.299805, 0.200000, 0.000000, 0.000000, -0.100000, 75, 0.200000, 0.200000, 0.200000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 5.0, 0.4, 30.0, 2.0, 0.1, 0.0, 0.5, -0.2, 0.5, 0.0, 0.3, 0.6},
	{2500.0, 7604.200195, 2.500000, 0.000000, 0.000000, -0.350000, 80, 2.500000, 2.500000, 2.500000, 5, 170.0, 8.000000, 170.0, "awd", "petrol", 7.0, 0.4, 35.0, 0.8, 0.1, 0.0, 0.4, -0.3, 0.4, 0.3, 0.4, 0.3},
	{3500.0, 11156.200195, 2.200000, 0.000000, 0.000000, -0.200000, 80, 2.200000, 2.200000, 2.200000, 5, 170.0, 8.800000, 170.0, "awd", "petrol", 8.5, 0.5, 30.0, 0.7, 0.2, 0.0, 0.3, -0.2, 0.5, 0.5, 0.4, 0.3},
	{1700.0, 3435.399902, 2.000000, 0.000000, 0.000000, -0.100000, 70, 2.000000, 2.000000, 2.000000, 4, 160.0, 7.200000, 160.0, "rwd", "petrol", 7.0, 0.5, 32.0, 0.8, 0.1, 0.0, 0.3, -0.2, 0.5, 0.5, 0.3, 0.9},
	{1600.0, 4000.000000, 2.500000, 0.000000, 0.000000, 0.000000, 70, 2.500000, 2.500000, 2.500000, 4, 160.0, 8.000000, 160.0, "rwd", "petrol", 5.4, 0.6, 30.0, 1.1, 0.1, 5.0, 0.3, -0.2, 0.5, 0.0, 0.2, 0.5},
	{3000.0, 40000.000000, 1.000000, 0.000000, 0.000000, 0.000000, 35, 1.000000, 1.000000, 1.000000, 5, 190.0, 1.200000, 190.0, "rwd", "petrol", 0.0, 0.0, 24.0, 0.8, 4.0, 0.0, 0.1, 0.3, 1.5, 0.0, 0.2, 0.4},
	{1600.0, 4500.000000, 1.400000, 0.000000, 0.200000, -0.400000, 70, 1.400000, 1.400000, 1.400000, 5, 220.0, 10.400000, 220.0, "rwd", "petrol", 10.0, 0.5, 30.0, 1.5, 0.1, 10.0, 0.3, -0.2, 0.6, 0.4, 0.2, 0.6},
	{2000.0, 4000.000000, 2.200000, 0.000000, 0.000000, -0.600000, 80, 2.200000, 2.200000, 2.200000, 5, 170.0, 11.200000, 170.0, "awd", "petrol", 8.0, 0.5, 30.0, 0.8, 0.1, 0.0, 0.3, -0.3, 0.5, 0.0, 0.4, 0.3},
	{1000.0, 2141.699951, 2.400000, 0.000000, 0.000000, -0.100000, 50, 2.400000, 2.400000, 2.400000, 5, 200.0, 10.400000, 200.0, "fwd", "petrol", 11.0, 0.4, 30.0, 1.4, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5},
	{4500.0, 26343.699219, 0.200000, 0.000000, 0.000000, -0.100000, 75, 0.200000, 0.200000, 0.200000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 5.0, 0.4, 30.0, 2.0, 0.1, 0.0, 0.5, -0.2, 0.5, 0.0, 0.3, 0.6},
	{5500.0, 23489.599609, 3.000000, 0.000000, 0.000000, 0.000000, 80, 3.000000, 3.000000, 3.000000, 5, 140.0, 5.600000, 140.0, "rwd", "diesel", 4.5, 0.6, 30.0, 0.9, 0.1, 0.0, 0.3, -0.3, 0.3, 0.6, 0.3, 0.4},
	{3500.0, 13865.799805, 2.300000, 0.000000, 0.000000, -0.200000, 80, 2.300000, 2.300000, 2.300000, 5, 140.0, 5.600000, 140.0, "rwd", "diesel", 4.5, 0.6, 30.0, 1.2, 0.2, 0.0, 0.3, -0.2, 0.4, 0.0, 0.5, 0.5},
	{1300.0, 1900.000000, 3.000000, 0.000000, 0.200000, -0.300000, 85, 3.000000, 3.000000, 3.000000, 5, 160.0, 9.600000, 160.0, "awd", "diesel", 8.0, 0.5, 35.0, 1.2, 0.1, 0.0, 0.3, -0.2, 0.3, 0.4, 0.2, 0.3},
	{100.0, 24.100000, 0.200000, 0.000000, 0.000000, -0.100000, 70, 0.200000, 0.200000, 0.200000, 1, 75.0, 14.000000, 75.0, "awd", "petrol", 5.5, 0.5, 25.0, 1.6, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.2, 0.1},
	{1600.0, 4500.000000, 1.400000, 0.000000, 0.200000, -0.400000, 70, 1.400000, 1.400000, 1.400000, 5, 220.0, 10.400000, 220.0, "rwd", "petrol", 10.0, 0.5, 30.0, 1.5, 0.1, 10.0, 0.3, -0.2, 0.6, 0.4, 0.2, 0.6},
	{1600.0, 4500.000000, 1.400000, 0.000000, 0.200000, -0.400000, 70, 1.400000, 1.400000, 1.400000, 5, 220.0, 10.400000, 220.0, "rwd", "petrol", 10.0, 0.5, 30.0, 1.5, 0.1, 10.0, 0.3, -0.2, 0.6, 0.4, 0.2, 0.6},
	{2100.0, 5146.700195, 2.000000, 0.000000, 0.000000, 0.000000, 75, 2.000000, 2.000000, 2.000000, 5, 160.0, 9.600000, 160.0, "rwd", "petrol", 6.2, 0.6, 35.0, 1.0, 0.1, 3.0, 0.3, -0.2, 0.5, 0.0, 0.3, 0.3},
	{2500.0, 7604.200195, 2.500000, 0.000000, 0.000000, -0.350000, 80, 2.500000, 2.500000, 2.500000, 5, 170.0, 8.000000, 170.0, "awd", "petrol", 7.0, 0.4, 35.0, 0.8, 0.1, 0.0, 0.4, -0.3, 0.4, 0.3, 0.4, 0.3},
	{1400.0, 2800.000000, 2.000000, 0.000000, -0.200000, -0.240000, 70, 2.000000, 2.000000, 2.000000, 5, 230.0, 10.400000, 230.0, "rwd", "petrol", 8.0, 0.5, 30.0, 1.0, 0.2, 0.0, 0.3, -0.1, 0.5, 0.3, 0.4, 0.5},
	{2200.0, 5000.000000, 1.800000, 0.000000, 0.100000, -0.100000, 75, 1.800000, 1.800000, 1.800000, 5, 165.0, 8.000000, 165.0, "rwd", "petrol", 6.0, 0.6, 30.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.5, 0.3, 0.2, 0.3},
	{3500.0, 13865.799805, 3.000000, 0.000000, 0.000000, 0.000000, 80, 3.000000, 3.000000, 3.000000, 5, 140.0, 5.600000, 140.0, "rwd", "diesel", 4.5, 0.6, 30.0, 1.5, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.5, 0.5},
	{100.0, 39.000000, 6.000000, 0.000000, 0.050000, -0.090000, 103, 6.000000, 6.000000, 6.000000, 5, 120.0, 7.200000, 120.0, "rwd", "petrol", 19.0, 0.5, 35.0, 0.9, 0.2, 0.0, 0.2, -0.1, 0.5, 0.0, 0.0, 0.2},
	{100.0, 60.000000, 5.000000, 0.000000, 0.050000, -0.090000, 103, 5.000000, 5.000000, 5.000000, 4, 140.0, 10.000000, 140.0, "rwd", "petrol", 19.0, 0.5, 35.0, 0.9, 0.2, 0.0, 0.2, -0.1, 0.5, 0.0, 0.0, 0.2},
	{10000.0, 80000.000000, 14.000000, 0.000000, 0.000000, 0.000000, 75, 14.000000, 14.000000, 14.000000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 1.5, 0.4, 45.0, 2.0, 0.2, 0.0, 1.0, -0.1, 0.3, 0.0, 0.3, 0.8},
	{5000.0, 27083.300781, 15.000000, 0.000000, 0.000000, 0.000000, 75, 15.000000, 15.000000, 15.000000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 1.5, 0.4, 45.0, 2.0, 0.2, 0.0, 0.6, -0.1, 0.5, 0.0, 0.3, 0.8},
	{5000.0, 20000.000000, 14.000000, 0.000000, 0.000000, 0.000000, 75, 14.000000, 14.000000, 14.000000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 1.5, 0.4, 45.0, 2.0, 0.2, 0.0, 0.5, -0.1, 0.9, 0.0, 0.3, 0.8},
	{3800.0, 20000.000000, 2.000000, 0.000000, 0.000000, -0.200000, 90, 2.000000, 2.000000, 2.000000, 5, 120.0, 10.000000, 120.0, "rwd", "diesel", 8.0, 0.3, 35.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.3, 0.3},
	{5000.0, 28000.000000, 2.000000, 0.000000, 0.500000, -0.400000, 90, 2.000000, 2.000000, 2.000000, 5, 120.0, 10.000000, 120.0, "rwd", "diesel", 8.0, 0.3, 25.0, 0.7, 0.1, 0.0, 0.2, -0.2, 0.5, 0.0, 0.6, 0.3},
	{1400.0, 4000.000000, 2.000000, 0.000000, 0.300000, -0.100000, 75, 2.000000, 2.000000, 2.000000, 5, 165.0, 8.000000, 165.0, "fwd", "petrol", 8.0, 0.6, 30.0, 1.4, 0.1, 0.0, 0.3, -0.1, 0.6, 0.3, 0.2, 0.6},
	{1400.0, 3267.800049, 2.200000, 0.000000, 0.100000, -0.100000, 75, 2.200000, 2.200000, 2.200000, 5, 165.0, 8.800000, 165.0, "rwd", "petrol", 7.0, 0.6, 30.0, 1.3, 0.1, 0.0, 0.3, -0.2, 0.5, 0.3, 0.2, 0.6},
	{1700.0, 4500.000000, 2.200000, 0.000000, 0.300000, 0.000000, 70, 2.200000, 2.200000, 2.200000, 4, 160.0, 9.600000, 160.0, "rwd", "petrol", 5.0, 0.5, 35.0, 0.8, 0.1, 0.0, 0.2, -0.2, 0.5, 0.4, 0.3, 0.5},
	{15000.0, 81250.000000, 8.000000, 0.000000, 0.000000, 0.000000, 75, 8.000000, 8.000000, 8.000000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 1.5, 0.2, 45.0, 4.0, 0.2, 0.0, 1.0, -0.0, 0.3, 0.0, 0.3, 0.8},
	{9000.0, 48750.000000, 20.000000, 0.000000, 0.000000, 0.000000, 75, 20.000000, 20.000000, 20.000000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 1.5, 0.4, 45.0, 1.0, 0.2, 0.0, 0.5, -0.2, 0.8, 0.0, 0.6, 0.8},
	{500.0, 200.000000, 4.000000, 0.000000, 0.050000, -0.090000, 103, 4.000000, 4.000000, 4.000000, 5, 190.0, 20.000000, 190.0, "rwd", "petrol", 15.0, 0.5, 35.0, 0.9, 0.2, 0.0, 0.2, -0.2, 0.5, 0.0, 0.0, 0.1},
	{400.0, 200.000000, 4.000000, 0.000000, 0.080000, -0.090000, 103, 4.000000, 4.000000, 4.000000, 5, 190.0, 24.000000, 190.0, "rwd", "petrol", 15.0, 0.5, 35.0, 0.9, 0.2, 0.0, 0.2, -0.2, 0.5, 0.0, 0.0, 0.2},
	{500.0, 240.000000, 4.500000, 0.000000, 0.050000, -0.090000, 103, 4.500000, 4.500000, 4.500000, 5, 190.0, 20.000000, 190.0, "rwd", "petrol", 15.0, 0.5, 35.0, 0.9, 0.2, 0.0, 0.2, -0.2, 0.5, 0.0, 0.0, 0.2},
	{5500.0, 33187.898438, 2.000000, 0.000000, 0.000000, 0.000000, 90, 2.000000, 2.000000, 2.000000, 4, 110.0, 8.000000, 110.0, "rwd", "diesel", 3.2, 0.4, 30.0, 1.4, 0.1, 0.0, 0.4, -0.3, 0.6, 0.0, 0.4, 0.2},
	{3500.0, 12000.000000, 2.500000, 0.000000, 0.300000, -0.250000, 80, 2.500000, 2.500000, 2.500000, 5, 160.0, 10.000000, 160.0, "rwd", "diesel", 6.0, 0.8, 45.0, 1.6, 0.1, 0.0, 0.3, -0.2, 0.3, 0.0, 0.2, 0.5},
	{1700.0, 4166.399902, 2.000000, 0.000000, 0.000000, -0.200000, 70, 2.000000, 2.000000, 2.000000, 4, 160.0, 8.000000, 160.0, "rwd", "petrol", 8.2, 0.5, 35.0, 1.2, 0.2, 0.0, 0.3, -0.1, 0.5, 0.3, 0.3, 0.5},
	{1200.0, 2000.000000, 2.200000, 0.000000, 0.150000, -0.100000, 70, 2.200000, 2.200000, 2.200000, 4, 160.0, 8.000000, 160.0, "rwd", "petrol", 8.0, 0.6, 30.0, 1.4, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5},
	{4000.0, 10000.000000, 2.000000, 0.000000, 0.000000, -0.200000, 85, 2.000000, 2.000000, 2.000000, 5, 170.0, 10.000000, 170.0, "awd", "diesel", 6.0, 0.4, 30.0, 0.8, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.3, 0.2},
	{1800.0, 4350.000000, 2.000000, 0.000000, 0.000000, 0.000000, 70, 2.000000, 2.000000, 2.000000, 4, 160.0, 7.200000, 160.0, "rwd", "petrol", 5.4, 0.6, 30.0, 1.1, 0.2, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5},
	{1000.0, 1354.199951, 2.000000, 0.000000, -0.200000, -0.350000, 70, 2.000000, 2.000000, 2.000000, 3, 60.0, 8.000000, 60.0, "fwd", "electric", 6.0, 0.5, 30.0, 2.0, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.3, 0.5},
	{2000.0, 5000.000000, 3.000000, 0.000000, 0.000000, -0.200000, 70, 3.000000, 3.000000, 3.000000, 4, 70.0, 8.000000, 70.0, "rwd", "diesel", 15.0, 0.2, 50.0, 2.0, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5},
	{8500.0, 48804.199219, 5.000000, 0.000000, 0.300000, -0.200000, 90, 5.000000, 5.000000, 5.000000, 5, 140.0, 10.000000, 140.0, "awd", "diesel", 10.0, 0.4, 27.0, 1.2, 0.1, 0.0, 0.5, -0.1, 0.5, 0.0, 1.2, 0.4},
	{1600.0, 4500.000000, 2.500000, 0.000000, 0.000000, -0.150000, 75, 2.500000, 2.500000, 2.500000, 5, 200.0, 11.200000, 200.0, "rwd", "petrol", 7.0, 0.5, 30.0, 1.1, 0.1, 0.0, 0.3, -0.1, 0.5, 0.3, 0.3, 0.6},
	{1800.0, 4000.000000, 2.000000, 0.000000, -0.400000, -0.200000, 70, 2.000000, 2.000000, 2.000000, 5, 160.0, 9.200000, 160.0, "rwd", "petrol", 6.5, 0.5, 30.0, 0.5, 0.1, 0.0, 0.0, -0.2, 0.4, 0.6, 0.2, 0.4},
	{1950.0, 4712.500000, 4.000000, 0.000000, 0.100000, 0.000000, 70, 4.000000, 4.000000, 4.000000, 5, 160.0, 16.000000, 160.0, "rwd", "petrol", 10.0, 0.5, 28.0, 1.6, 0.1, 0.0, 0.3, -0.1, 0.5, 0.3, 0.4, 0.4},
	{1500.0, 2500.000000, 2.000000, 0.000000, -0.200000, 0.100000, 70, 2.000000, 2.000000, 2.000000, 4, 160.0, 9.600000, 160.0, "rwd", "petrol", 8.2, 0.5, 35.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.4, 0.3, 0.3, 0.5},
	{5500.0, 65000.000000, 3.000000, 0.000000, 0.000000, 0.000000, 90, 3.000000, 3.000000, 3.000000, 4, 110.0, 8.000000, 110.0, "rwd", "diesel", 3.2, 0.4, 30.0, 1.4, 0.1, 0.0, 0.4, 0.0, 0.6, 0.0, 0.4, 0.2},
	{5500.0, 65000.000000, 3.000000, 0.000000, 0.000000, 0.000000, 90, 3.000000, 3.000000, 3.000000, 4, 110.0, 8.000000, 110.0, "rwd", "diesel", 3.2, 0.4, 30.0, 1.4, 0.1, 0.0, 0.4, -0.1, 0.6, 0.0, 0.6, 0.2},
	{1900.0, 4795.899902, 20.000000, 0.000000, 0.000000, 0.200000, 85, 20.000000, 20.000000, 20.000000, 5, 150.0, 0.800000, 150.0, "rwd", "petrol", 1.0, 0.5, 30.0, 0.5, 0.1, 0.0, 0.3, -0.3, 0.5, 0.0, 0.6, 0.5},
	{1800.0, 3000.000000, 2.000000, 0.000000, 0.300000, 0.000000, 70, 2.000000, 2.000000, 2.000000, 4, 160.0, 7.200000, 160.0, "fwd", "petrol", 5.4, 0.6, 30.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.6, 0.0, 0.3, 0.5},
	{1200.0, 2500.000000, 1.800000, 0.000000, -0.150000, -0.200000, 70, 1.800000, 1.800000, 1.800000, 5, 230.0, 12.000000, 230.0, "rwd", "petrol", 8.0, 0.6, 30.0, 1.0, 0.1, 5.0, 0.3, -0.1, 0.4, 0.3, 0.2, 0.5},
	{1600.0, 3000.000000, 2.200000, 0.000000, 0.000000, 0.000000, 70, 2.200000, 2.200000, 2.200000, 4, 160.0, 9.600000, 160.0, "rwd", "petrol", 8.0, 0.5, 35.0, 1.0, 0.1, 0.0, 0.3, -0.1, 0.5, 0.3, 0.3, 0.5},
	{1700.0, 4500.000000, 2.700000, 0.000000, 0.000000, -0.050000, 75, 2.700000, 2.700000, 2.700000, 5, 165.0, 10.000000, 165.0, "awd", "diesel", 8.5, 0.5, 35.0, 0.8, 0.1, 3.0, 0.3, -0.2, 0.4, 0.4, 0.3, 0.2},
	{6500.0, 36670.800781, 3.000000, 0.000000, 0.000000, 0.000000, 90, 3.000000, 3.000000, 3.000000, 5, 170.0, 10.800000, 170.0, "rwd", "diesel", 10.0, 0.4, 27.0, 1.2, 0.1, 0.0, 0.5, -0.2, 0.5, 0.0, 0.2, 0.3},
	{1700.0, 4000.000000, 2.500000, 0.000000, 0.000000, -0.050000, 75, 2.500000, 2.500000, 2.500000, 5, 160.0, 8.800000, 160.0, "rwd", "petrol", 8.0, 0.5, 30.0, 0.4, 0.1, 0.0, 0.1, -0.2, 0.5, 0.5, 0.2, 0.4},
	{1800.0, 4350.000000, 2.000000, 0.000000, 0.000000, 0.000000, 70, 2.000000, 2.000000, 2.000000, 5, 160.0, 7.200000, 160.0, "rwd", "petrol", 5.4, 0.6, 30.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.3, 0.5},
	{1600.0, 3300.000000, 2.200000, 0.000000, 0.000000, 0.000000, 70, 2.200000, 2.200000, 2.200000, 4, 160.0, 7.200000, 160.0, "rwd", "petrol", 5.4, 0.6, 30.0, 1.1, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5},
	{20000.0, 48333.300781, 0.200000, 0.000000, 0.000000, -0.100000, 75, 0.200000, 0.200000, 0.200000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 5.0, 0.4, 30.0, 0.6, 0.1, 0.0, 0.5, -0.1, 0.3, 0.0, 0.3, 0.5},
	{1700.0, 4166.399902, 2.500000, 0.000000, 0.150000, 0.000000, 70, 2.500000, 2.500000, 2.500000, 4, 160.0, 9.600000, 160.0, "rwd", "petrol", 8.2, 0.5, 35.0, 0.7, 0.1, 3.0, 0.3, -0.2, 0.5, 0.5, 0.3, 0.5},
	{1600.0, 3550.000000, 2.000000, 0.000000, 0.300000, 0.000000, 70, 2.000000, 2.000000, 2.000000, 5, 160.0, 6.800000, 160.0, "fwd", "petrol", 5.4, 0.6, 30.0, 1.0, 0.1, 0.0, 0.3, -0.1, 0.6, 0.0, 0.3, 0.5},
	{1800.0, 4500.000000, 2.200000, 0.000000, 0.200000, -0.100000, 75, 2.200000, 2.200000, 2.200000, 5, 165.0, 8.800000, 165.0, "rwd", "petrol", 9.0, 0.6, 30.0, 1.1, 0.2, 0.0, 0.3, -0.1, 0.5, 0.3, 0.2, 0.6},
	{2600.0, 8666.700195, 3.000000, 0.000000, 0.000000, 0.000000, 80, 3.000000, 3.000000, 3.000000, 5, 160.0, 7.200000, 160.0, "rwd", "diesel", 6.0, 0.8, 30.0, 1.8, 0.1, 0.0, 0.3, -0.2, 0.3, 0.0, 0.2, 0.5},
	{25000.0, 438750.000000, 10.000000, 0.000000, 0.000000, 0.000000, 75, 10.000000, 10.000000, 10.000000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 1.0, 0.4, 45.0, 1.0, 0.1, 0.0, 0.4, -0.3, 0.5, 0.0, 0.3, 0.8},
	{3000.0, 6000.000000, 3.000000, 0.000000, 0.350000, 0.000000, 80, 3.000000, 3.000000, 3.000000, 5, 170.0, 10.000000, 170.0, "rwd", "petrol", 8.5, 0.3, 30.0, 1.0, 0.1, 0.0, 0.2, -0.2, 0.5, 0.5, 0.4, 0.3},
	{1500.0, 3500.000000, 3.000000, 0.000000, 0.050000, -0.200000, 75, 3.000000, 3.000000, 3.000000, 5, 180.0, 12.000000, 180.0, "rwd", "petrol", 8.0, 0.4, 30.0, 0.6, 0.1, 0.0, 0.2, -0.1, 0.5, 0.3, 0.3, 0.6},
	{5000.0, 20000.000000, 3.000000, 0.000000, 0.000000, -0.350000, 80, 3.000000, 3.000000, 3.000000, 5, 110.0, 18.000000, 110.0, "awd", "petrol", 7.0, 0.4, 35.0, 1.5, 0.1, 0.0, 0.4, -0.3, 0.5, 0.3, 0.4, 0.3},
	{5000.0, 20000.000000, 3.000000, 0.000000, 0.000000, -0.350000, 80, 3.000000, 3.000000, 3.000000, 5, 110.0, 18.000000, 110.0, "awd", "petrol", 7.0, 0.4, 35.0, 1.5, 0.1, 0.0, 0.4, -0.3, 0.5, 0.3, 0.4, 0.3},
	{1400.0, 2998.300049, 2.000000, 0.000000, 0.100000, -0.300000, 75, 2.000000, 2.000000, 2.000000, 5, 200.0, 8.000000, 200.0, "rwd", "petrol", 8.0, 0.4, 30.0, 1.3, 0.2, 0.0, 0.3, -0.1, 0.5, 0.3, 0.3, 0.6},
	{1500.0, 3600.000000, 2.200000, 0.000000, 0.000000, -0.050000, 75, 2.200000, 2.200000, 2.200000, 5, 200.0, 11.200000, 200.0, "fwd", "petrol", 10.0, 0.4, 30.0, 1.1, 0.1, 0.0, 0.3, -0.2, 0.5, 0.3, 0.3, 0.6},
	{1400.0, 3400.000000, 2.400000, 0.000000, 0.100000, -0.100000, 75, 2.400000, 2.400000, 2.400000, 5, 200.0, 11.200000, 200.0, "awd", "petrol", 10.0, 0.5, 30.0, 1.2, 0.2, 0.0, 0.3, -0.2, 0.5, 0.3, 0.3, 0.6},
	{1800.0, 4500.000000, 2.100000, 0.000000, 0.100000, -0.100000, 75, 2.100000, 2.100000, 2.100000, 5, 200.0, 8.000000, 200.0, "rwd", "petrol", 7.0, 0.5, 30.0, 1.0, 0.2, 0.0, 0.3, -0.2, 0.5, 0.3, 0.3, 0.6},
	{1500.0, 3500.000000, 2.200000, 0.000000, 0.300000, -0.150000, 75, 2.200000, 2.200000, 2.200000, 5, 200.0, 11.200000, 200.0, "rwd", "petrol", 8.0, 0.5, 35.0, 1.0, 0.2, 0.0, 0.3, -0.1, 0.5, 0.3, 0.3, 0.6},
	{10000.0, 96666.703125, 0.050000, 0.000000, 0.000000, -1.000000, 75, 0.050000, 0.050000, 0.050000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 5.0, 0.4, 30.0, 1.5, 0.1, 0.0, 0.2, -0.2, 0.5, 0.0, 0.7, 0.5},
	{100.0, 24.100000, 5.000000, 0.000000, 0.000000, -0.100000, 70, 5.000000, 5.000000, 5.000000, 1, 75.0, 14.000000, 75.0, "awd", "electric", 5.0, 0.5, 45.0, 1.6, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.2, 0.1},
	{1400.0, 2998.300049, 2.200000, 0.000000, 0.200000, -0.100000, 75, 2.200000, 2.200000, 2.200000, 5, 200.0, 9.600000, 200.0, "fwd", "petrol", 8.0, 0.6, 30.0, 1.4, 0.2, 0.0, 0.3, -0.1, 0.5, 0.3, 0.3, 0.6},
	{1800.0, 4000.000000, 2.300000, 0.000000, -0.300000, 0.000000, 75, 2.300000, 2.300000, 2.300000, 5, 160.0, 9.600000, 160.0, "rwd", "petrol", 7.0, 0.5, 35.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.4, 0.3, 0.3, 0.6},
	{1500.0, 2500.000000, 2.000000, 0.000000, -0.600000, 0.100000, 70, 2.000000, 2.000000, 2.000000, 4, 160.0, 9.600000, 160.0, "rwd", "petrol", 8.2, 0.5, 35.0, 1.0, 0.1, 0.0, 0.3, -0.2, 0.3, 0.3, 0.3, 0.5},
	{1000.0, 2500.300049, 4.000000, 0.000000, 0.000000, -0.300000, 80, 4.000000, 4.000000, 4.000000, 4, 170.0, 14.000000, 170.0, "rwd", "petrol", 6.1, 0.6, 35.0, 1.0, 0.1, 5.0, 0.3, -0.2, 0.3, 0.0, 0.6, 0.4},
	{5500.0, 33187.898438, 1.000000, 0.000000, 0.000000, 0.000000, 90, 1.000000, 1.000000, 1.000000, 4, 110.0, 8.000000, 110.0, "rwd", "diesel", 3.2, 0.4, 30.0, 1.4, 0.1, 0.0, 0.4, 0.0, 0.6, 0.0, 0.4, 0.2},
	{300.0, 150.000000, 5.000000, 0.000000, 0.000000, -0.150000, 110, 5.000000, 5.000000, 5.000000, 4, 90.0, 7.200000, 90.0, "rwd", "petrol", 15.0, 0.2, 35.0, 1.5, 0.2, 0.0, 0.3, -0.0, 0.5, 0.0, 0.4, 0.4},
	{800.0, 500.000000, 5.000000, 0.000000, 0.000000, -0.300000, 80, 5.000000, 5.000000, 5.000000, 3, 60.0, 4.800000, 60.0, "rwd", "petrol", 6.1, 0.6, 35.0, 1.0, 0.2, 0.0, 0.2, -0.1, 0.5, 0.0, 0.4, 0.4},
	{10000.0, 50000.000000, 2.000000, 0.000000, 0.000000, -0.600000, 80, 2.000000, 2.000000, 2.000000, 5, 110.0, 14.000000, 110.0, "awd", "petrol", 7.0, 0.4, 35.0, 0.8, 0.1, 0.0, 0.4, -0.4, 0.5, 0.3, 0.3, 0.3},
	{800.0, 632.700012, 5.000000, 0.000000, 0.000000, -0.300000, 80, 5.000000, 5.000000, 5.000000, 3, 60.0, 4.800000, 60.0, "rwd", "petrol", 6.1, 0.6, 35.0, 1.6, 0.2, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.4},
	{1700.0, 4166.399902, 2.000000, 0.000000, 0.100000, 0.100000, 70, 2.000000, 2.000000, 2.000000, 4, 160.0, 8.000000, 160.0, "rwd", "petrol", 6.0, 0.6, 25.0, 0.8, 0.1, 0.0, 0.3, -0.1, 0.5, 0.3, 0.3, 0.5},
	{1700.0, 4166.399902, 2.000000, 0.000000, -0.100000, 0.100000, 70, 2.000000, 2.000000, 2.000000, 4, 160.0, 8.000000, 160.0, "rwd", "petrol", 6.0, 0.6, 35.0, 0.8, 0.1, 0.0, 0.3, -0.2, 0.5, 0.3, 0.3, 0.5},
	{60000.0, 9000000.000000, 4.000000, 0.000000, 0.000000, 0.000000, 75, 4.000000, 4.000000, 4.000000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 1.0, 0.4, 45.0, 1.5, 0.2, 0.0, 0.5, -0.2, 0.3, 0.0, 0.7, 0.8},
	{5500.0, 33187.898438, 2.000000, 0.000000, 0.000000, -0.200000, 90, 2.000000, 2.000000, 2.000000, 5, 110.0, 8.000000, 110.0, "rwd", "diesel", 3.5, 0.4, 30.0, 1.4, 0.1, 0.0, 0.4, -0.3, 0.6, 0.0, 0.4, 0.2},
	{2500.0, 6000.000000, 2.500000, 0.000000, 0.000000, -0.200000, 80, 2.500000, 2.500000, 2.500000, 5, 160.0, 10.000000, 160.0, "awd", "petrol", 7.0, 0.4, 35.0, 1.0, 0.1, 0.0, 0.4, -0.2, 0.4, 0.3, 0.4, 0.3},
	{2200.0, 6000.000000, 2.500000, 0.000000, 0.000000, 0.000000, 75, 2.500000, 2.500000, 2.500000, 5, 165.0, 9.600000, 165.0, "rwd", "petrol", 5.0, 0.6, 30.0, 1.1, 0.1, 0.0, 0.3, -0.2, 0.5, 0.3, 0.2, 0.6},
	{500.0, 200.000000, 4.500000, 0.000000, 0.050000, -0.090000, 103, 4.500000, 4.500000, 4.500000, 5, 190.0, 20.000000, 190.0, "rwd", "petrol", 15.0, 0.5, 35.0, 0.9, 0.2, 0.0, 0.2, -0.2, 0.5, 0.0, 0.0, 0.2},
	{1900.0, 6333.299805, 2.000000, 0.000000, 0.000000, -0.150000, 80, 2.000000, 2.000000, 2.000000, 5, 160.0, 6.000000, 160.0, "rwd", "diesel", 6.0, 0.8, 30.0, 1.3, 0.1, 0.0, 0.3, -0.2, 0.4, 0.0, 0.2, 0.4},
	{800.0, 632.700012, 5.000000, 0.000000, 0.000000, -0.100000, 80, 5.000000, 5.000000, 5.000000, 4, 170.0, 6.000000, 170.0, "rwd", "petrol", 6.1, 0.6, 35.0, 1.2, 0.2, 0.0, 0.3, -0.1, 0.5, 0.0, 0.4, 0.4},
	{3800.0, 30000.000000, 2.000000, 0.000000, 0.000000, -0.500000, 90, 2.000000, 2.000000, 2.000000, 5, 120.0, 7.200000, 120.0, "rwd", "diesel", 8.0, 0.3, 25.0, 1.5, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.6, 0.3},
	{1800.0, 4000.000000, 2.200000, 0.000000, 0.200000, 0.150000, 75, 2.200000, 2.200000, 2.200000, 5, 165.0, 8.400000, 165.0, "rwd", "petrol", 8.0, 0.4, 30.0, 0.9, 0.1, 3.0, 0.3, -0.1, 0.5, 0.3, 0.2, 0.6},
	{800.0, 600.000000, 4.000000, 0.000000, 0.100000, 0.000000, 103, 4.000000, 4.000000, 4.000000, 4, 190.0, 16.000000, 190.0, "rwd", "petrol", 10.0, 0.6, 35.0, 0.6, 0.2, 0.0, 0.1, -0.1, 0.6, 0.0, 0.0, 0.2},
	{1400.0, 2998.300049, 2.200000, 0.000000, 0.100000, -0.100000, 75, 2.200000, 2.200000, 2.200000, 5, 200.0, 9.600000, 200.0, "awd", "petrol", 8.0, 0.6, 30.0, 1.2, 0.2, 0.0, 0.3, -0.1, 0.5, 0.3, 0.3, 0.6},
	{5500.0, 23489.599609, 3.000000, 0.000000, 0.000000, 0.300000, 80, 3.000000, 3.000000, 3.000000, 5, 140.0, 5.600000, 140.0, "rwd", "diesel", 4.5, 0.6, 30.0, 0.6, 0.1, 0.0, 0.3, -0.2, 0.4, 0.6, 0.4, 0.4},
	{1400.0, 3000.000000, 2.800000, 0.000000, 0.000000, 0.000000, 80, 2.800000, 2.800000, 2.800000, 5, 200.0, 12.000000, 200.0, "fwd", "petrol", 11.0, 0.4, 30.0, 1.7, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5},
	{5500.0, 33187.898438, 1.000000, 0.000000, 0.000000, 0.000000, 90, 1.000000, 1.000000, 1.000000, 4, 110.0, 8.000000, 110.0, "rwd", "diesel", 3.2, 0.4, 30.0, 1.4, 0.1, 0.0, 0.4, 0.0, 0.6, 0.0, 0.4, 0.2},
	{3800.0, 30000.000000, 2.000000, 0.000000, 0.000000, -0.500000, 90, 2.000000, 2.000000, 2.000000, 5, 120.0, 7.200000, 120.0, "rwd", "diesel", 8.0, 0.3, 25.0, 1.5, 0.1, 0.0, 0.3, -0.2, 0.5, 0.0, 0.6, 0.3},
	{40000.0, 3000000.000000, 4.000000, 0.000000, 0.000000, 0.000000, 75, 4.000000, 4.000000, 4.000000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 1.0, 0.4, 45.0, 2.0, 0.2, 0.0, 0.5, -0.2, 0.5, 0.0, 0.3, 0.8},
	{5000.0, 27083.300781, 12.000000, 0.000000, 0.300000, 0.000000, 75, 12.000000, 12.000000, 12.000000, 1, 200.0, 6.400000, 200.0, "awd", "petrol", 1.5, 0.4, 45.0, 1.5, 0.2, 0.0, 0.5, -0.1, 0.2, 0.0, 0.5, 0.8},
	{100.0, 50.000000, 20.000000, 0.000000, 0.050000, -0.200000, 70, 20.000000, 20.000000, 20.000000, 1, 60.0, 20.000000, 60.0, "awd", "electric", 5.5, 0.5, 25.0, 3.0, 0.3, 0.0, 0.2, -0.2, 0.5, 0.0, 0.2, 0.1},
	{2200.0, 20210.699219, 1.000000, 0.000000, -1.000000, 0.000000, 22, 1.000000, 1.000000, 1.000000, 5, 190.0, 0.600000, 190.0, "rwd", "petrol", 0.0, 0.0, 24.0, 1.0, 3.0, 0.0, 0.1, 0.5, 2.0, 0.0, 0.7, 0.4},
	{1600.0, 4500.000000, 2.000000, 0.000000, 0.300000, -0.100000, 75, 2.000000, 2.000000, 2.000000, 5, 200.0, 10.000000, 200.0, "rwd", "petrol", 10.0, 0.5, 35.0, 1.0, 0.1, 0.0, 0.3, -0.1, 0.6, 0.0, 0.2, 0.2},
	{1600.0, 4500.000000, 2.000000, 0.000000, 0.300000, -0.150000, 75, 2.000000, 2.000000, 2.000000, 5, 200.0, 10.000000, 200.0, "rwd", "petrol", 10.0, 0.5, 35.0, 1.1, 0.1, 0.0, 0.3, -0.2, 0.6, 0.0, 0.2, 0.2},
	{1600.0, 4500.000000, 2.000000, 0.000000, 0.300000, -0.100000, 75, 2.000000, 2.000000, 2.000000, 5, 200.0, 10.000000, 200.0, "rwd", "petrol", 10.0, 0.5, 35.0, 0.9, 0.1, 0.0, 0.3, -0.2, 0.6, 0.0, 0.2, 0.2},
	{2500.0, 5500.000000, 3.000000, 0.000000, 0.000000, -0.200000, 85, 3.000000, 3.000000, 3.000000, 5, 160.0, 12.000000, 160.0, "awd", "diesel", 6.2, 0.6, 35.0, 0.7, 0.1, 1.0, 0.3, -0.3, 0.5, 0.3, 0.3, 0.2},
	{1600.0, 3800.000000, 2.700000, 0.000000, 0.200000, 0.000000, 75, 2.700000, 2.700000, 2.700000, 5, 165.0, 10.000000, 165.0, "rwd", "diesel", 8.5, 0.5, 35.0, 0.8, 0.1, 2.0, 0.3, -0.2, 0.4, 0.4, 0.3, 0.2},
	{5000.0, 10000.000000, 2.500000, 0.000000, 0.000000, -0.100000, 85, 2.500000, 2.500000, 2.500000, 5, 110.0, 9.600000, 110.0, "awd", "diesel", 6.4, 0.4, 27.0, 0.7, 0.1, 1.0, 0.3, -0.2, 0.5, 0.0, 0.3, 0.1},
	{1500.0, 3400.000000, 2.000000, 0.000000, 0.100000, -0.200000, 85, 2.000000, 2.000000, 2.000000, 5, 200.0, 9.200000, 200.0, "rwd", "petrol", 7.0, 0.6, 30.0, 1.2, 0.1, 0.0, 0.3, -0.2, 0.5, 0.4, 0.3, 0.5},
	{1500.0, 4000.000000, 2.200000, 0.000000, 0.300000, -0.150000, 85, 2.200000, 2.200000, 2.200000, 5, 200.0, 10.400000, 200.0, "rwd", "petrol", 6.0, 0.6, 30.0, 0.8, 0.1, 0.0, 0.3, -0.2, 0.6, 0.4, 0.3, 0.5},
	{1600.0, 4000.000000, 2.500000, 0.000000, 0.000000, 0.050000, 75, 2.500000, 2.500000, 2.500000, 5, 160.0, 8.800000, 160.0, "rwd", "petrol", 6.2, 0.6, 30.0, 0.8, 0.1, 0.0, 0.3, -0.2, 0.5, 0.5, 0.2, 0.4},
	{1700.0, 4500.000000, 2.700000, 0.000000, 0.000000, -0.050000, 75, 2.700000, 2.700000, 2.700000, 5, 165.0, 10.000000, 165.0, "awd", "diesel", 8.5, 0.5, 35.0, 0.8, 0.1, 3.0, 0.3, -0.2, 0.4, 0.4, 0.3, 0.2},
	{1000.0, 1354.199951, 5.000000, 0.000000, 0.400000, -0.200000, 70, 5.000000, 5.000000, 5.000000, 3, 160.0, 8.000000, 160.0, "rwd", "electric", 5.0, 0.5, 30.0, 2.0, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5},
	{1000.0, 1354.199951, 5.000000, 0.000000, 0.400000, -0.200000, 70, 5.000000, 5.000000, 5.000000, 3, 160.0, 8.000000, 160.0, "rwd", "electric", 5.0, 0.5, 30.0, 2.0, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5},
	{1000.0, 2500.000000, 5.000000, 0.000000, 0.400000, -0.200000, 70, 5.000000, 5.000000, 5.000000, 3, 160.0, 8.000000, 160.0, "rwd", "electric", 5.0, 0.5, 30.0, 2.0, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5},
	{5500.0, 23489.599609, 3.000000, 0.000000, 0.000000, 0.000000, 80, 3.000000, 3.000000, 3.000000, 5, 140.0, 5.600000, 140.0, "rwd", "diesel", 4.5, 0.6, 30.0, 0.9, 0.1, 0.0, 0.3, -0.3, 0.3, 0.6, 0.4, 0.4},
	{400.0, 400.000000, 5.000000, 0.000000, -0.400000, 0.000000, 70, 5.000000, 5.000000, 5.000000, 3, 160.0, 8.000000, 160.0, "rwd", "electric", 5.0, 0.5, 30.0, 1.0, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5},
	{1000.0, 1354.199951, 5.000000, 0.000000, 0.000000, 0.000000, 70, 5.000000, 5.000000, 5.000000, 3, 160.0, 8.000000, 160.0, "rwd", "electric", 5.0, 0.5, 30.0, 2.0, 0.1, 0.0, 0.3, -0.1, 0.5, 0.0, 0.3, 0.5}
};
new Quests[][e_Quests] =
{
	{1,"Name",1,100}
};
new Radio[][e_Radio] =
{
	{"Hit 104","http://tuner.hit104.com:80"},
	//{"I Love Radio","http://www.iloveradio.de/listen.m3u"},
	//{"I Love Radio 2","http://www.iloveradio.de/listen2.m3u"},
	{"Sky FM Top Hits","http://listen.sky.fm/public3/tophits.pls"},
	{"100FM רדיוס","http://213.8.143.168/100fmAudio"}//,
	//{"גלי צהל","http://50.22.219.97:14959/"}
};
new Skins[][e_Skins] =
{
	{"Cop",16},
	{"FireMan",16},
	{"Builder",17},
	{"Fisherman",18},
	{"Pirate",19},
	{"Heart",21},
	{"Parrot",23},
	{"Mr.Animal",26},
	{"Nazgul",30}
};
new GroupTypes[][16] =
{
	"Clan",
	"Crew"
};
new Ammunation[][e_Ammunation] =
{
	// name, 				id, cost, 	ammo,	level,	slot
	{"Pistol",				22,	1000,	100,	1,		0},
	{"Silenced Pistol",		23,	1500,	50,		1,		0},
	{"Desert Eagle",		24,	3000,	50,		1,		0},
	{"Shotgun",				25,	2000,	50,		1,		1},
	{"Combat Shotgun",		27,	4000,	50,		2,		1},
	{"Sawnoff Shotgun",		26,	5000,	50,		1,		1},
	{"Micro Uzi",			28,	2500,	100,	1,		2},
	{"Tec9",				32,	2500,	100,	1,		2},
	{"MP5",					29,	3000,	50,		2,		2},
	{"AK47",				30,	4500,	100,	3,		3},
	{"M4",					31,	6000,	100,	3,		3},
	{"Country Rifle",		33,	4000,	10,		2,		4},
	{"Sniper Rifle",		34,	8000,	10,		3,		4},
	{"Grenade",				16,	8000,	1,		4,		5},
	{"Molotov",				18,	8000,	1,		4,		5},
	{"Tear Gas",			17,	3000,	1,		1,		5},
	{"Satchel Charge",		39,	12000,	1,		5,		5},
	{"Rocket Launcher",		35,	150000,	1,		18,		6},
	{"HSRocket Launcher",	36,	150000,	1,		18,		6},
	{"Flamethrower",		37,	20000,	25,		6,		6},
	{"Spray",				41,	250,	500,	1,		7},
	{"Fire Extinguisher"	,42,500,	500,	1,		7},
	{"Brass Knuckles",		1,	8000,	0,		1,		8},
	{"Knife",				4,	12000,	0,		1,		9},
	{"Bat",					5,	10000,	0,		1,		9},
	{"Katana",				8,	12000,	0,		1,		9},
	{"Chainsaw",			9,	15000,	0,		1,		9}
};
new LCMDs[][e_LCommands] =
{
	{"/flip",		"",		2,	{world_stunts,world_stuntswo,world_dm,world_tdm},	"היפוך הרכב"},
	{"/vcolor",		"",		4,	{world_stunts,world_stuntswo,world_dm,world_tdm},	"שינוי צבע לרכב"},
	{"/fix",		"/vr",	6,	{world_stunts,world_stuntswo,world_dm,world_tdm},	"תיקון רכב"},
	{"/eject",		"",		6,	{world_stunts,world_stuntswo,world_dm,world_tdm},	"הוצאת שחקן מהרכב"},
	{"/healme",		"/hm",	8,	{world_stunts,world_stuntswo,world_dm},				"ריפוי עצמי"},
	{"/trade",		"",		10,	{world_stunts,world_stuntswo,world_dm,world_tdm},	""},
	{"/skydive",	"",		12,	{world_dm,world_tdm},								"קפיצה לשמיים"},
	{"/invisible",	"",		14,	{world_dm},											"הסתרת תאג שם [משתדרג]"},
	{"/skin",		"",		16,	{world_stunts,world_stuntswo,world_dm},				"שינוי תחפושת [משתדרג]"},
	{"/hyd",		"",		20,	{world_stunts,world_stuntswo,world_dm,world_tdm},	"הוספת הידרוליקה לרכב"},
	{"/loc",		"",		21,	{world_dm},											"שמירת מיקום"},
	{"/tp",			"",		24,	{world_stunts,world_stuntswo,world_dm},				"השתגרות לשחקן אחר"},
	{"/jetpack",	"/jetp",30,	{world_dm},											"תיק סילון"},
	{"/raise",		"",		34,	{world_dm},											"להרים מישהו עם תיק סילון"}
};
new Channels[][e_Channels] =
{
	{"צבע מתחלף",		6,		{world_stunts,world_stuntswo,world_dm},				{0,0,0},	""},
	{"היפוך בלחיצה",	8,		{world_stunts,world_stuntswo,world_dm},				{0,0,0},	""},
	{"קפיצה לגובה",		11,		{world_stunts,world_stuntswo,world_dm},				{1,0,0},	""},
	{"קפיצה לרוחק",		14,		{world_stunts,world_stuntswo,world_dm},				{1,0,0},	""},
	{"ניטרו אינסופי",	17,		{world_stunts,world_stuntswo,world_dm},				{0,0,0},	""},
	{"היפוך אוטומטי",	20,		{world_stunts,world_stuntswo,world_dm},				{0,0,0},	""},
	{"אי נפילה מאופנוע",22,		{world_stunts,world_stuntswo,world_dm},				{0,0,0},	""},
	{"רמפה בלחיצה",		24,		{world_dm},											{0,0,0},	""},
	{"מהירות רכב",		27,		{world_dm},											{0,0,1},	""},
	{"רכב משוריין",		32,		{world_dm},											{0,0,0},	""},
	{"גודמוד לרכב",		35,		{world_dm},											{0,0,0},	""}
};
// Elements
new PlayerInfo[MAX_PLAYERS][e_Player];
new WorldInfo[MAX_WORLDS][e_World];
new CheckpointInfo[MAX_CHECKPOINTS][e_Checkpoint];
new AreaInfo[MAX_AREAS][e_Area];
new ServerConfig[e_Configuration];
new Teleports[MAX_TELEPORTS][e_Teleports];
new ChatInfo[MAX_CHATS][e_Chat];
new VehicleInfo[MAX_VEHICLES][e_Vehicle];
new PickupInfo[MAX_PICKUPS][e_Pickup];
new MapInfo[MAX_MAPS][e_Map];
new GroupInfo[MAX_GROUPS][e_Groups];
new HeadquarterInfo[MAX_GROUPS][e_Headquarters];
new PropertyInfo[MAX_PROPERTIES][e_Properties];
new MoveObjectInfo[MAX_MOVE_OBJECTS][e_MoveObjects];
// Variables
new player[MAX_PLAYERS] = {INVALID_PLAYER_ID,...}, players = 0;
new fstring[256];
new bestToday = 0;
new teleCount = 0;
new params[10][16];
new maArea[sizeof(MoneyAreas)] = {0,...};
new Text:driftlabels[2], Text:speedotext[8];
new props_count = 0;
new sUptime = 0;
new warweaps[] = {22,23,24,25,26,27,28,29,30,31,32,34};
new censoring[25][16], censwords = 0;
new bool:chatlock = false;
new lastB = INVALID_PLAYER_ID, lastBType = 0;
new lastAdvMessage[M_S], advAccess = 0;
new mainChatID = -1;
new currentRadioID = -1, currentRadio[128];
new File:fop;
new moveObjectsCount = 0;
new ggweapons[2][] = {{29,31,24,27},{22,32,28,26}};
// Lists
new VehicleNames[212][32] =
{
   "Landstalker",
   "Bravura",
   "Buffalo",
   "Linerunner",
   "Pereniel",
   "Sentinel",
   "Dumper",
   "Firetruck",
   "Trashmaster",
   "Stretch",
   "Manana",
   "Infernus",
   "Voodoo",
   "Pony",
   "Mule",
   "Cheetah",
   "Ambulance",
   "Leviathan",
   "Moonbeam",
   "Esperanto",
   "Taxi",
   "Washington",
   "Bobcat",
   "Mr Whoopee",
   "BF Injection",
   "Hunter",
   "Premier",
   "Enforcer",
   "Securicar",
   "Banshee",
   "Predator",
   "Bus",
   "Rhino",
   "Barracks",
   "Hotknife",
   "Trailer",
   "Previon",
   "Coach",
   "Cabbie",
   "Stallion",
   "Rumpo",
   "RC Bandit",
   "Romero",
   "Packer",
   "Monster Truck A",
   "Admiral",
   "Squalo",
   "Seasparrow",
   "Pizzaboy",
   "Tram",
   "Trailer",
   "Turismo",
   "Speeder",
   "Reefer",
   "Tropic",
   "Flatbed",
   "Yankee",
   "Caddy",
   "Solair",
   "Berkley's RC Van",
   "Skimmer",
   "PCJ-600",
   "Faggio",
   "Freeway",
   "RC Baron",
   "RC Raider",
   "Glendale",
   "Oceanic",
   "Sanchez",
   "Sparrow",
   "Patriot",
   "Quad",
   "Coastguard",
   "Dinghy",
   "Hermes",
   "Sabre",
   "Rustler",
   "ZR-350",
   "Walton",
   "Regina",
   "Comet",
   "BMX",
   "Burrito",
   "Camper",
   "Marquis",
   "Baggage",
   "Dozer",
   "Maverick",
   "News Chopper",
   "Rancher",
   "FBI Rancher",
   "Virgo",
   "Greenwood",
   "Jetmax",
   "Hotring",
   "Sandking",
   "Blista Compact",
   "Police Maverick",
   "Boxville",
   "Benson",
   "Mesa",
   "RC Goblin",
   "Hotring Racer 1",
   "Hotring Racer 2",
   "Bloodring Banger",
   "Rancher",
   "Super GT",
   "Elegant",
   "Journey",
   "Bike",
   "Mountain Bike",
   "Beagle",
   "Cropdust",
   "Stunt",
   "Tanker",
   "RoadTrain",
   "Nebula",
   "Majestic",
   "Buccaneer",
   "Shamal",
   "Hydra",
   "FCR-900",
   "NRG-500",
   "HPV1000",
   "Cement Truck",
   "Tow Truck",
   "Fortune",
   "Cadrona",
   "FBI Truck",
   "Willard",
   "Forklift",
   "Tractor",
   "Combine",
   "Feltzer",
   "Remington",
   "Slamvan",
   "Blade",
   "Freight",
   "Streak",
   "Vortex",
   "Vincent",
   "Bullet",
   "Clover",
   "Sadler",
   "Firetruck",
   "Hustler",
   "Intruder",
   "Primo",
   "Cargobob",
   "Tampa",
   "Sunrise",
   "Merit",
   "Utility",
   "Nevada",
   "Yosemite",
   "Windsor",
   "Monster Truck B",
   "Monster Truck C",
   "Uranus",
   "Jester",
   "Sultan",
   "Stratum",
   "Elegy",
   "Raindance",
   "RC Tiger",
   "Flash",
   "Tahoma",
   "Savanna",
   "Bandito",
   "Freight",
   "Trailer",
   "Kart",
   "Mower",
   "Duneride",
   "Sweeper",
   "Broadway",
   "Tornado",
   "AT-400",
   "DFT-30",
   "Huntley",
   "Stafford",
   "BF-400",
   "Newsvan",
   "Tug",
   "Trailer",
   "Emperor",
   "Wayfarer",
   "Euros",
   "Hotdog",
   "Club",
   "Trailer",
   "Trailer",
   "Andromada",
   "Dodo",
   "RC Cam",
   "Launch",
   "Police Car (LSPD)",
   "Police Car (SFPD)",
   "Police Car (LVPD)",
   "Police Ranger",
   "Picador",
   "S.W.A.T. Van",
   "Alpha",
   "Phoenix",
   "Glendale",
   "Sadler",
   "Luggage Trailer A",
   "Luggage Trailer B",
   "Stair Trailer",
   "Boxville",
   "Farm Plow",
   "Utility Trailer"
};
new WeaponNames[48][32] =
{
	"Fist", // 0
	"Brass Knuckles", // 1
	"Golf Club", // 2
	"Night Stick", // 3
	"Knife", // 4
	"Baseball Bat", // 5
	"Shovel", // 6
	"Pool Cue", // 7
	"Katana", // 8
	"Chainsaw", // 9
	"Purple Dildo", // 10
	"Big White Vibrator", // 11
	"Medium White Vibrator", // 12
	"Small White Vibrator", // 13
	"Flowers", // 14
	"Cane", // 15
	"Grenade", // 16
	"Teargas", // 17
	"Molotov", // 18
	" ", // 19
	" ", // 20
	" ", // 21
	"Pistol", // 22
	"Silenced Pistol", // 23
	"Desert Eagle", // 24
	"Shotgun", // 25
	"Sawnoff Shotgun", // 26
	"Combat Shotgun", // 27
	"Micro Uzi", // 28
	"MP5", // 29
	"AK47", // 30
	"M4", // 31
	"Tec9", // 32
	"Country Rifle", // 33
	"Sniper Rifle", // 34
	"Rocket Launcher", // 35
	"Heat-Seeking Rocket Launcher", // 36
	"Flamethrower", // 37
	"Minigun", // 38
	"Satchel Charge", // 39
	"Detonator", // 40
	"Spray Can", // 41
	"Fire Extinguisher", // 42
	"Camera", // 43
	"Night Vision Goggles", // 44
	"Infrared Vision Goggles", // 45
	"Parachute", // 46
	"Fake Pistol" // 47
};
new Float:RandomSpawns[][4] =
{
	// x, y, z, a
	{2218.6982,1283.5702,10.8203,270.0000},
	{2096.2002,1284.7495,10.8203,180.0000},
	{2142.0940,1442.5226,10.8203,180.0000},
	{1999.5558,1564.7164,15.3672,180.0000},
	{1970.2527,1623.2292,12.8620,270.0000},
	{2216.4617,1839.7662,10.8203,90.0000},
	{2019.1263,1926.6437,12.3414,270.0000},
	{2019.5150,1906.3398,12.3084,270.0000},
	{2272.3191,2036.5476,10.8203,270.0000},
	{2471.3762,1911.0078,9.7656,354.4634},
	{2624.7810,2076.6721,14.1161,270.0309},
	{2628.7922,2348.2671,10.8203,207.5086},
	{2535.9382,2259.9419,10.8203,92.3929},
	{2127.5774,2364.8457,10.8203,181.8388},
	{1481.4026,2213.2019,11.0234,271.3079},
	{1420.8719,2033.1235,14.7396,89.9096},
	{1318.8535,1254.4611,14.2731,1.0670},
	{1959.0493,1342.8811,15.3746,270.0000},
	{2199.8708,1393.1593,10.8203,182.7787},
	{2483.5977,1222.0825,10.8203,182.7787},
	{2637.2712,1129.2743,11.1797,182.7787},
	{2262.0986,2398.6572,10.8203,5.2129},
	{2244.2566,2523.7280,10.8203,180.0000},
	{2335.3228,2786.4478,10.8203,0.0000},
	{2150.0186,2734.2297,11.1763,0.0000},
	{2158.0811,2797.5488,10.8203,90.0000},
	{1969.8301,2722.8564,10.8203,0.0000},
	{1494.2671,2773.5227,10.8203,270.0544},
	{1433.4550,2641.1621,11.3926,180.8987},
	{1400.5808,2225.7263,11.0234,0.0000},
	{1318.7759,1251.3580,10.8203,0.0000},
	{1558.0731,1007.8292,10.8125,270.0000},
	{1705.2347,1025.6808,10.8203,90.0000},
	{2182.7429,1115.7207,12.6484,62.7710},
	{2023.6941,1007.2962,10.8203,273.9597},
	{2437.6929,1293.4052,10.8203,90.9947},
	{2452.1626,1497.7577,11.2538,135.8017},
	{2589.3987,1657.0817,11.0234,1.0672},
	{1714.2064,1614.4215,10.0156,180.0000},
	{2192.5696,1677.2351,12.3672,87.8614},
	{2238.4832,2428.8569,10.8203,87.8614},
	{2097.4688,2490.1531,14.8390,181.6443},
	{1893.6559,2417.6289,11.1782,274.0785},
	{1845.9323,2159.9307,10.8203,7.4527},
	{1694.0907,2207.2297,11.0692,180.4144},
	{1644.4773,1912.9337,10.8203,4.0294},
	{1098.3141,1619.0585,12.5469,0.0000},
	{1025.9534,2144.9365,10.8203,177.7951},
	{411.3962,2533.4890,19.1484,90.0000},
	{-778.8023,2745.7263,45.6872,179.6986},
	{2163.0583,2795.4783,10.8203,184.1087},
	{2262.9167,2775.3733,10.8203,87.6245},
	{1376.6473,1019.4727,10.8203,274.6629},
	{1490.9999,714.1702,10.8203,176.2987},
	{1963.6082,1915.1859,130.9375,271.2396},
	{2001.6309,1914.6458,40.3516,271.2396},
	{1491.2498,2773.8394,15.9924,271.2396},
	{1958.6237,694.7396,14.2681,271.2396},
	{1645.9165,1614.2947,14.8222,271.2396},
	{1607.1293,1816.6422,10.8203,5.3850},
	{1499.5253,2032.7206,14.7396,4.7817},
	{1964.2982,1915.0114,130.9375,275.0119},
	{369.8243,-2043.8961,7.6719,359.8126},
    {325.0051,-1775.4016,4.9110,184.9709},
    {154.5413,-1941.4746,3.7734,2.9225},
    {211.0533,-1774.9187,3.8404,182.7306},
    {369.8813,-1655.7845,32.7059,181.1639},
    {-2031.8074,174.0464,28.8359,269.4272},
    {-1848.8369,1270.6168,20.4154,210.5088},
    {-1873.0016,1189.6779,45.4453,181.9953},
    {-1868.5798,1047.6156,46.0898,85.8244},
    {-1899.1678,1016.9435,40.5593,270.6928},
    {-1926.8235,952.8443,54.4159,180.4519},
    {-1984.6594,883.5139,45.2031,271.0062},
    {-2018.3838,813.4980,45.5984,273.8262},
    {-2117.6499,801.0459,69.5625,88.9578},
    {-2129.4636,740.0439,69.5625,177.0053},
    {-2131.4583,576.6295,35.1719,193.9255},
    {-2109.6411,482.6904,35.1719,98.9846},
    {-2135.3687,362.1779,35.1719,179.8253},
    {805.7454,-1870.1541,6.1379,113.9965},
	{-2265.2839,541.3666,35.0156,272.5729},
	{-2260.8208,636.2311,48.9460,178.2587},
	{-2585.1716,1102.3281,55.5903,329.4242},
	{-2586.1848,1103.0665,55.5903,329.2041},
	{-2577.9485,1119.9773,55.6044,153.7591},
	{-2532.7532,1145.5861,65.2344,175.3793},
	{-2445.0286,1101.6935,55.7147,91.3817},
	{-2403.4861,1026.0643,50.0157,359.9109},
	{-2370.5247,1041.6334,55.7266,60.3848},
	{-2404.8030,959.3821,45.2969,271.5735},
	{-2278.1045,958.5306,66.5129,267.8134},
	{-2266.4268,958.2126,66.5000,268.4401},
	{-2258.7095,958.0025,66.6633,268.4401},
	{-2251.0693,961.8110,66.8621,352.1009},
	{-2242.8877,924.5412,66.6546,175.0659},
	{-2176.7041,918.2699,79.8477,272.2001},
	{-2117.4778,925.0164,86.0791,272.2001},
	{-2107.5779,899.4196,76.7109,352.1243},
	{-2015.3131,857.6700,45.4453,275.3570},
	{-2013.7953,807.1531,45.2969,87.6685},
	{-2075.4773,805.9670,68.4018,87.6685},
	{-2079.3911,817.3040,69.4949,265.6202},
	{-1957.8762,797.8786,55.7306,268.7535},
	{-1889.9418,746.3691,45.4453,179.1393},
	{-1808.0160,771.2361,31.8787,359.3078},
	{-1804.9175,907.4219,24.8906,357.4278},
	{-1803.9921,941.2214,24.8906,355.2345},
	{-1753.7567,961.5361,24.8828,186.3462},
	{-1706.0895,922.2576,24.7422,272.8270},
	{-1520.9639,925.9390,7.1875,88.2952},
	{-1477.9790,754.9825,46.3763,135.8989},
	{-1448.6219,774.9763,47.2170,314.7905},
	{-1255.7847,954.9302,139.2734,50.6715},
	{-1267.8210,966.3453,133.0514,315.1040},
	{-1278.3456,976.3602,139.2734,224.5499},
	{-1060.2147,907.0626,34.5781,119.9190},
	{-1021.1921,935.8571,34.5781,305.7040},
	{-960.3574,979.8104,34.5781,305.0774},
	{-846.6107,999.4467,24.5882,274.6838},
	{-687.5215,948.5159,12.1429,342.9911},
	{-658.6411,881.2059,2.0000,227.6834},
	{-642.2476,866.1154,2.0000,227.3701},
	{-1359.8123,-251.6320,14.1440,315.0892},
	{-1364.8552,-245.8510,14.1440,314.7758},
	{-1371.4509,-238.3022,14.1484,313.8358},
	{-1373.8293,-257.9059,14.2903,317.9092},
	{-1378.9966,-252.1470,14.1903,315.0891},
	{-1367.8396,-264.6156,14.2903,316.3425},
	{-1237.0217,-190.0986,14.1440,116.4574},
	{-1304.9657,-325.7573,25.4375,40.6300},
	{-1335.1017,-303.8033,25.4375,40.6300},
	{-1401.0962,-304.1236,25.4375,305.0624},
	{1477.6801,1829.8801,10.8125,168.4621},
	{1484.5763,1828.7017,10.8125,174.7288},
	{1492.5852,1827.5060,10.8125,174.7288},
	{1469.4358,1827.3755,10.8125,182.2489},
	{1460.9225,1825.9122,10.8125,182.2489},
	{2481.0117,1675.2046,10.8203,175.1550},
	{2426.7825,1757.5659,10.6719,1.8800},
	{2425.3733,1810.1606,38.8203,353.1301},
	{2575.0183,1823.1459,10.8203,273.2293},
	{404.3200,2478.9812,16.7700,186.5848},
	{408.6276,2484.1343,16.7700,64.4070},
	{-1639.9104,1200.4347,7.1931,329.3651},
	{-1633.8696,1185.4178,7.1265,85.2762},
	{-1714.9695,1114.8132,45.2916,0.6754},
	{-1782.0853,1091.7776,45.4453,86.5295},
	{-1872.3738,1112.7476,45.4453,94.0496},
	{-1988.3485,1161.0609,48.5000,7.2555},
	{-2049.7710,1166.3809,45.4453,90.6029},
	{-2124.1714,1119.4111,72.4257,98.7496},
	{-2126.6804,1102.5782,82.7422,3.8321},
	{-2180.9380,1099.3986,80.0078,86.2395},
	{-1648.4087,95.7513,-11.1931,312.9320},
	{-1652.5254,99.3021,-11.2344,312.9319},
	{-1642.1677,90.0196,-11.1949,314.8120},
	{-1636.7655,85.1023,-10.0502,316.0653},
	{-1632.8201,106.6029,-11.1564,313.5586},
	{-1625.0631,114.5056,-11.1633,316.6920},
	{-127.5763,-19.2271,3.1172,340.2846},
	{1420.3265,-2496.9602,13.5547,274.4730},
	{1423.8893,-2487.0513,13.5547,274.4730}
};
new Float:RandomSpawns_SWO[][4] =
{
	// x, y, z, a, interior
	{-1328.4875,-247.8706,19.1503,135.4496},
	{-1331.8398,-244.4093,19.1503,133.3288},
	{-1328.8169,-254.1583,19.1503,44.8954},
	{-1332.1716,-257.7346,19.1503,43.3287},
	{-1336.1332,-260.9589,19.1503,36.9895},
	{-1339.4138,-264.9734,19.1503,42.0754},
	{-1343.3651,-268.1885,19.1503,41.1354},
	{-1351.2572,-268.6381,19.1503,312.7746},
	{-1354.7554,-265.2001,19.1503,310.5811},
	{-1358.3663,-261.9360,19.1503,315.9078},
	{-1361.6180,-258.3478,19.1503,312.1478},
	{-1364.9752,-254.7869,19.1503,316.8478},
	{-1368.6819,-251.4301,19.1503,316.8478},
	{-1372.0096,-247.9261,19.1503,316.4619},
	{-1375.4142,-244.3494,19.1503,321.7887},
	{-1378.6787,-240.8107,19.1503,315.8353},
	{-1382.5533,-237.6532,19.1503,313.4011},
	{-1385.4808,-233.7991,19.1503,319.3545},
	{-1385.5952,-225.5033,19.1503,225.9802},
	{-1381.9623,-222.1964,19.1503,224.1002},
	{-1378.4181,-218.7260,19.1503,224.1002},
	{-1375.0146,-215.0764,19.1503,224.1002},
	{-1371.2260,-211.8471,19.1503,224.1002},
	{-1365.2797,-211.0419,19.1503,136.6068},
	{-1361.7440,-214.5376,19.1503,129.7860}

};
// Natives
native IsValidVehicle(vehicleid);
// Forwards
forward Contents();
forward Drift();
forward Contents2();
forward DriftExit(playerid);
forward CheckPlayerState();
forward AutoMessage();
forward PropertiesPay();
forward ActivityStart(actuid);
forward ActivityCD(actuid,cd);
// Callback Functions
main() return 1;
public OnGameModeInit()
{
	// Settings
	SetGameModeText("SAMP-IL HS " version);
	UsePlayerPedAnims();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	ShowNameTags(1);
	SetGravity(0.008000);
	AllowInteriorWeapons(0);
	EnableStuntBonusForAll(0);
	Log("Server",-1,"Starting...");
	// Defense
	new serverIP[16];
	GetServerVarAsString("bind",serverIP,sizeof(serverIP));
	if(!equal(serverIP,"127.0.0.1") && !equal(serverIP,srvip))
	{
		print("Wrong server IP.");
		return GameModeExit();
	}
	// Streamer
	Streamer_TickRate(100);
	Streamer_VisibleItems(0,500);
	Streamer_VisibleItems(6,MAX_AREAS / 2);
	// Class Selection
	for(new i = 0; i < 300; i++) if(IsValidSkin(i)) AddPlayerClass(i,0.0,0.0,1000.0,0.0,-1,-1,-1,-1,-1,-1);
	// Directories & Files
	new dirs[][32] = {"/HS/",dir_users,dir_tele,dir_maps,dir_groups,dir_logs,dir_bans};
	for(new i = 0; i < sizeof(dirs); i++) if(!fexist(dirs[i]))
	{
		strdel(dirs[i],strlen(dirs[i])-1,strlen(dirs[i]));
		strdel(dirs[i],0,1);
		dcreate(dirs[i]);
	}
	new files[][32] = {file_users,file_admins,file_rules,file_config,file_tele,file_vsave,file_groups,file_automsg,file_censoring,file_admincmd,file_bans};
	if(fexist(file_admincmd)) AdminCommands(acUpdate);
	for(new i = 0; i < sizeof(files); i++) if(!fexist(files[i]))
	{
		fcreate(files[i]);
		if(equal(files[i],file_users)) fsetint(files[i],"#Count",0);
		else if(equal(files[i],file_groups)) fsetint(file_groups,"#Count",0);
		else if(equal(files[i],file_admincmd)) AdminCommands(acInitialize);
	}
	// Configuration
	new DefaultConfiguration[15][2][32] =
	{
		{"AdminPassword","null"},
		{"HighestPlayerCount","0"},
		{"DefaultTime","8"},
		{"DefaultWeather","4"},
		{"MaxAdminLevel","10"},
		{"AutoMinigameTime","600"},
		{"GlobalRulesTime","900"},
		{"AutoMessageTime","300"},
		{"PropertyEarnTime","90"},
		{"MoneyAreaEarn","10"},
		{"DisableCBug","1"},
		{"DisableSawnoff22","1"},
		{"VIPMoneyAreaBonus","2"},
		{"VIPPropertyPercentBonus","10"},
		{"WriteLockedChat","8"}
	};
	for(new i = 0; i < sizeof(DefaultConfiguration); i++) if(!fkeyexist(file_config,DefaultConfiguration[i][0])) fsetstring(file_config,DefaultConfiguration[i][0],DefaultConfiguration[i][1]);
	format(ServerConfig[cfgPassword],32,fgetstring(file_config,DefaultConfiguration[0][0]));
	ServerConfig[cfgHighestPlayerCount] = fgetint(file_config,DefaultConfiguration[1][0]);
	ServerConfig[cfgDefaultTime] = fgetint(file_config,DefaultConfiguration[2][0]);
	ServerConfig[cfgDefaultWeather] = fgetint(file_config,DefaultConfiguration[3][0]);
	ServerConfig[cfgMaxAdminLevel] = fgetint(file_config,DefaultConfiguration[4][0]);
	ServerConfig[cfgAutoMinigameTime] = fgetint(file_config,DefaultConfiguration[5][0]);
	ServerConfig[cfgGlobalRulesTime] = fgetint(file_config,DefaultConfiguration[6][0]);
	ServerConfig[cfgAutoMessageTime] = fgetint(file_config,DefaultConfiguration[7][0]);
	ServerConfig[cfgPropertyEarnTime] = fgetint(file_config,DefaultConfiguration[8][0]);
	ServerConfig[cfgMoneyAreaEarn] = fgetint(file_config,DefaultConfiguration[9][0]);
	ServerConfig[cfgDisableCBug] = bool:fgetint(file_config,DefaultConfiguration[10][0]);
	ServerConfig[cfgDisableSawnoff22] = bool:fgetint(file_config,DefaultConfiguration[11][0]);
	ServerConfig[cfgVIPMoneyAreaBonus] = fgetint(file_config,DefaultConfiguration[12][0]);
	ServerConfig[cfgVIPPropertyPercentBonus] = fgetint(file_config,DefaultConfiguration[13][0]);
	ServerConfig[cfgWriteLockedChat] = fgetint(file_config,DefaultConfiguration[14][0]);
	// Worlds
	for(new i = 0; i < MAX_WORLDS; i++) WorldInfo[i][wValid] = i < sizeof(Worlds), WorldInfo[i][wPlayers] = 0, WorldInfo[i][wActivity] = {0,0,0}, WorldInfo[i][wActivityParam] = 0;
	WorldTextDraw("create");
	// Checkpoints
	const Float:cpDis = 20.0;
	for(new i = 0; i < MAX_CHECKPOINTS; i++)
	{
		CheckpointInfo[i][cpActive] = i < sizeof(Checkpoints);
		if(CheckpointInfo[i][cpActive]) CheckpointInfo[i][cpArea] = CreateArea(Checkpoints[i][cpPos][0]-cpDis,Checkpoints[i][cpPos][1]-cpDis,Checkpoints[i][cpPos][0]+cpDis,Checkpoints[i][cpPos][1]+cpDis,area_cp,i,Checkpoints[i][cpInterior],Checkpoints[i][cpWorld]);
	}
	// Teleport
	UpdateTeleports();
	// Chat Groups
	mainChatID = CreateChat(CHAT_MAIN,"",true);
	for(new i = 1; i < MAX_WORLDS; i++) if(WorldInfo[i][wValid]) CreateChat(Worlds[i][wName],"",true);
	// Groups
	new count = fgetint(file_groups,"#Count"), num[8];
	for(new i = 0; i < MAX_GROUPS; i++)
	{
		if(!i)
		{
			format(GroupInfo[i][gName],32,"None");
			continue;
		}
		GroupInfo[i][gType] = group_none;
		if(i <= count)
		{
			valstr(num,i);
			format(GroupInfo[i][gName],32,fgetstring(file_groups,num));
			GroupInfo[i][gMembers] = 0;
			for(new j = 0; j < MAX_GROUP_MEMBERS; j++) GroupInfo[i][gMember][j] = INVALID_PLAYER_ID;
			if(fexist(frmt(dir_groups "%s-%s.ini",GroupTypes[group_clan],GroupInfo[i][gName])))
			{
				GroupInfo[i][gType] = group_clan;
				GroupInfo[i][gColor][0] = fgetint(fstring,"R");
				GroupInfo[i][gColor][1] = fgetint(fstring,"G");
				GroupInfo[i][gColor][2] = fgetint(fstring,"B");
				GroupInfo[i][gHeadquarter] = fgetint(fstring,"HQ");
				if(GroupInfo[i][gHeadquarter]) hqLoad(i);
			}
			else if(fexist(frmt(dir_groups "%s-%s.ini",GroupTypes[group_crew],GroupInfo[i][gName])))
			{
				GroupInfo[i][gType] = group_crew;
				GroupInfo[i][gColor][0] = fgetint(fstring,"R");
				GroupInfo[i][gColor][1] = fgetint(fstring,"G");
				GroupInfo[i][gColor][2] = fgetint(fstring,"B");
			}
		}
	}
	// Maps
	fop = fopen(file_objoutput,io_write);
	for(new i = 0; i < MAX_MAPS; i++) if(MapExist(i+1)) MapLoad(i);
	fclose(fop);
	Streamer_MaxItems(0,MAX_STREAMED_OBJECTS);
	Streamer_MaxItems(6,MAX_AREAS);
	// Money Areas
	for(new i = 0; i < sizeof(MoneyAreas); i++) maArea[i] = CreateArea(MoneyAreas[i][maCoords][0],MoneyAreas[i][maCoords][1],MoneyAreas[i][maCoords][2],MoneyAreas[i][maCoords][3],area_money,i,0,world_dm);
	// Textdraws
	LoadTextDraws();
	// Properties
	LoadProperties();
	// Vehicles
	LoadVehicles();
	// Censoring
	new File:fwords = fopen(file_censoring,io_read), word[16];
	while(fread(fwords,word)) if(strlen(word) > 1)
	{
		StripNewLine(word);
		format(censoring[censwords++],sizeof censoring [],word);
	}
	fclose(fwords);
	// Timers
	SetTimer("Contents",1000,1);
    SetTimer("Contents2",250,1);
    SetTimer("CheckPlayerState",100,1);
    // World
	SetWeather(ServerConfig[cfgDefaultWeather]);
	SetWorldTime(ServerConfig[cfgDefaultTime]);
	// Message
	Log("Server",-1,"Started");
	printf("SAMP-IL Heavy Stunts by Amit_B loaded");
	return 1;
}
public OnGameModeExit()
{
	printf("SAMP-IL Heavy Stunts by Amit_B unloaded");
	return 1;
}
public OnPlayerConnect(playerid)
{
	Streamer_CallbackHook(STREAMER_OPC,playerid);
	ResetInfo(playerid);
	GetPlayerName(playerid,PlayerInfo[playerid][pName],MAX_PLAYER_NAME);
	GetPlayerIp(playerid,PlayerInfo[playerid][pIP],16);
	new f[32];
	format(f,sizeof(f),dir_bans "%s.ini",GetIP(playerid));
	if(fexist(f))
	{
		SendClientMessage(playerid,red,webpage " :הושעית מהשרת ולכן לא תוכל לשחק בו. לערעור נא לפנות לפורום שלנו");
		new adminName[MAX_PLAYER_NAME];
		format(adminName,sizeof(adminName),fgetstring(f,"AdminName"));
		if(adminName[0] != '#') SendFormat(playerid,grey," - אדמין: %s",adminName);
		SendFormat(playerid,grey," - סיבה: %s",fgetstring(f,"Reason"));
		SendFormat(playerid,grey," - מועד: %s %s",fgetstring(f,"Date"),fgetstring(f,"Time"));
		PlayerInfo[playerid][pBanned] = true;
		return 1;
	}
	ResetWeapons(playerid);
	player[PlayerInfo[playerid][pArrayPos] = (players++)] = playerid;
	Log("Connections",playerid,"Connected");
	new id = GetUserID(playerid);
	SendFormat(playerid,green," » !SAMP-IL Heavy Stunts ברוכים הבאים לשרת הראשי והרשמי של קהילת ,%s",GetName(playerid));
	if(id > 0)
	{
		format(PlayerInfo[playerid][pUserFile],32,dir_users "%d.ini",id);
		if(fgetint(PlayerInfo[playerid][pUserFile],frmt("Setting-%s",Settings[setting_autologin][stKey])) == 1 && equal(GetIP(playerid),fgetstring(PlayerInfo[playerid][pUserFile],"LastConnectIP")))
		{
			Login(playerid);
			SendClientMessage(playerid,yellow," • IP-חוברת אוטומטית למשתמש שלך לפי כתובת ה");
			if(PlayerInfo[playerid][pAdminLogged]) SendClientMessage(playerid,yellow," • /admlog :כעת עליך להתחבר למערכת האדמינים");
		}
		else
		{
			SendClientMessage(playerid,yellow," • /login :הכינוי שנכנסת איתו רשום לשרת, על מנת להמשיך לשחק עליך להתחבר באמצעות הפקודה");
			GameTextForPlayer(playerid,"~y~please~n~~g~/login",2000,1);
		}
	}
	else
	{
		SendClientMessage(playerid,yellow," • /register :על מנת לשחק בשרת עליך להרשם");
		GameTextForPlayer(playerid,"~y~please~n~~g~/register",2000,1);
	}
	//TogglePlayerSpectating(playerid,1);
	if(players > bestToday)
	{
		bestToday = players;
		if(players > ServerConfig[cfgHighestPlayerCount])
		{
			fsetint(file_config,"HighestPlayerCount",ServerConfig[cfgHighestPlayerCount] = players);
			SendFormatToAll(orange," • שיא המחוברים לשרת נשבר! השיא החדש: %d",players);
		}
	}
	PlayerInfo[playerid][pDriftTD][0] = CreatePlayerTextDraw(playerid,500,100+20,"0");
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][pDriftTD][0],0x000000FF);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][pDriftTD][0],0);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][pDriftTD][0],1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][pDriftTD][0],0.5,2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][pDriftTD][0],0xFFFFFF40);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][pDriftTD][0],3);
	PlayerInfo[playerid][pDriftTD][1] = CreatePlayerTextDraw(playerid,500,100+70,"0");
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][pDriftTD][1],0x000000FF);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][pDriftTD][1],0);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][pDriftTD][1],1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][pDriftTD][1],0.5,2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][pDriftTD][1],0xFFFFFF40);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][pDriftTD][1],3);
	frmt("* %s has joined the server",GetName(playerid));
	Loop(i) if(i != playerid && PlayerInfo[i][pSetting][setting_showjoin]) SendClientMessage(i,grey,fstring);
	PlayerInfo[playerid][pConnectStage] = PlayerInfo[playerid][pLogged] ? ct_selectworld : ct_register;
	WorldPlayer(world_class,true);
	SetPlayerColor2(playerid,rgba2hex(PlayerInfo[playerid][pRGB][0] = random(256),PlayerInfo[playerid][pRGB][1] = random(256),PlayerInfo[playerid][pRGB][2] = random(256),PLAYER_ALPHA));
	JoinChat(playerid,0);
	Streamer_ToggleItemUpdate(playerid,STREAMER_TYPE_OBJECT,1);
	Streamer_ToggleIdleUpdate(playerid,1);
	Speedometer(playerid,'c');
	return 1;
}
public OnPlayerDisconnect(playerid,reason)
{
	Streamer_CallbackHook(STREAMER_OPDC,playerid,reason);
	if(PlayerInfo[playerid][pBanned]) return 1;
	Loop(i)
	{
		if(PlayerInfo[i][pLastPM] == playerid) PlayerInfo[i][pLastPM] = INVALID_PLAYER_ID;
		if(PlayerInfo[i][pTPAsk] == playerid) PlayerInfo[i][pTPAsk] = INVALID_PLAYER_ID;
		if(PlayerInfo[i][pSpecAsk] == playerid) PlayerInfo[i][pSpecAsk] = INVALID_PLAYER_ID;
		if(PlayerInfo[i][pRaise][0] == playerid) PlayerInfo[i][pRaise][0] = INVALID_PLAYER_ID;
		if(PlayerInfo[i][pRaise][2] == playerid) PlayerInfo[i][pRaise][2] = INVALID_PLAYER_ID;
	}
	if(PlayerInfo[playerid][pChat] != -1)
	{
		ChatInfo[PlayerInfo[playerid][pChat]][chOnline]--;
		ChatCheck4Close(PlayerInfo[playerid][pChat]);
	}
	if(IsPlayerMAdmin(playerid)) for(new i = 0; i < MAX_ADMIN_VEHICLES; i++)
	{
		if(PlayerInfo[playerid][pACreatedVehicle][i] != INVALID_VEHICLE_ID) DestroyVehicleEx(PlayerInfo[playerid][pACreatedVehicle][i]);
		PlayerInfo[playerid][pACreatedVehicle][i] = INVALID_VEHICLE_ID;
	}
	if(PlayerInfo[playerid][pCreatedVehicles] > 0) for(new i = 0; i < MAX_PLAYER_VEHICLES; i++)
	{
		if(PlayerInfo[playerid][pCreatedVehicle][i] != INVALID_VEHICLE_ID) DestroyVehicleEx(PlayerInfo[playerid][pCreatedVehicle][i]);
		PlayerInfo[playerid][pCreatedVehicle][i] = INVALID_VEHICLE_ID;
	}
	WorldPlayer(PlayerInfo[playerid][pWorld],false);
	if(IsPlayerInAnyVehicle(playerid))
	{
		new v = GetPlayerVehicleID(playerid);
		if(VehicleInfo[v][vLocked])
		{
			Loop(i) SetVehicleParamsForPlayer(v,i,0,0);
			VehicleInfo[v][vLocked] = false;
		}
	}
	if(PlayerInfo[playerid][pInActivity]) LeaveActivity(playerid,true);
	if(PlayerInfo[playerid][pLogged])
	{
		new f[64];
		format(f,sizeof(f),uf(playerid));
		fsetint(f,"Level",PlayerInfo[playerid][pLevel]);
		fsetint(f,"Exp",PlayerInfo[playerid][pExp]);
		fsetint(f,"StuntPoints",PlayerInfo[playerid][pPoints][ptStunts]);
		fsetint(f,"DriftPoints",PlayerInfo[playerid][pPoints][ptDrifts]);
		fsetint(f,"SpeedPoints",PlayerInfo[playerid][pPoints][ptSpeed]);
		fsetint(f,"Kills",PlayerInfo[playerid][pRate][rtKills]);
		fsetint(f,"Assists",PlayerInfo[playerid][pRate][rtAssists]);
		fsetint(f,"Deaths",PlayerInfo[playerid][pRate][rtDeaths]);
		fsetint(f,"Headshots",PlayerInfo[playerid][pRate][rtHeadshots]);
		fsetint(f,"Damage",PlayerInfo[playerid][pRate][rtDamage]);
		fsetint(f,"Damaged",PlayerInfo[playerid][pRate][rtDamaged]);
	}
	new rs[16];
	switch(reason)
	{
		case 0: rs = "Timeout";
		case 1: rs = "Leaving";
		case 2: rs = "Kicked";
		default: rs = "Unknown";
	}
	Log("Connections",playerid,frmt("Disconnected (%s)",rs));
	for(new i = 0; i < 2; i++) if(PlayerInfo[playerid][pDriftTD][i] == PlayerText:INVALID_TEXT_DRAW) PlayerTextDrawDestroy(playerid,PlayerInfo[playerid][pDriftTD][i]);
	Loop(i) if(PlayerInfo[i][pSpectate] == playerid)
	{
		TogglePlayerSpectating(i,0);
		PlayerInfo[i][pSpectate] = -1;
		if(PlayerInfo[i][pCameraMode] == camera_spec) PlayerInfo[i][pCameraMode] = camera_none;
		SendClientMessage(i,red," .השחקן אחריו עקבת יצא מהשרת");
	}
	frmt("* %s has left the server (%s)",GetName(playerid),rs);
	Loop(i) if(i != playerid && PlayerInfo[i][pSetting][setting_showquit]) SendClientMessage(i,grey,fstring);
	if(PlayerInfo[playerid][pDrift][0] != 0) KillTimer(PlayerInfo[playerid][pDrift][0]);
	if(PlayerInfo[playerid][pDrift][2] != 0) KillTimer(PlayerInfo[playerid][pDrift][2]);
	Speedometer(playerid,'d');
	if(PlayerInfo[playerid][pChannelRampa][1] > 0 && IsValidPlayerObject(playerid,PlayerInfo[playerid][pChannelRampa][0])) DestroyPlayerObject(playerid,PlayerInfo[playerid][pChannelRampa][0]);
	for(new i = 0, c = CountDynamicAreas(); i <= c; i++) if(IsValidDynamicArea(i) && IsPlayerInDynamicArea(playerid,i)) OnPlayerLeaveDynamicArea(playerid,i);
	ResetInfo(playerid);
	for(new i = PlayerInfo[playerid][pArrayPos]; i < players - 1; i++) player[i] = player[i+1];
	player[players--] = INVALID_PLAYER_ID, PlayerInfo[playerid][pArrayPos] = -1;
	if(lastB == playerid) lastB = INVALID_PLAYER_ID, lastBType = 0, lastAdvMessage = "", advAccess = 0;
	if(PlayerInfo[playerid][pLogged]) SendDeathMessage(INVALID_PLAYER_ID,playerid,201);
	return 1;
}
public OnPlayerRequestClass(playerid,classid)
{
	if(PlayerInfo[playerid][pConnectStage] == ct_selectworld) WorldTextDraw("show",playerid);
	else if(PlayerInfo[playerid][pConnectStage] == ct_playing) PlayerInfo[playerid][pConnectStage] = ct_selectskin;
	SetPlayerPos(playerid,229.8910,-1870.9111,6.0000);
	SetPlayerFacingAngle(playerid,1.5668);
	Streamer_Update(playerid);
	if(PlayerInfo[playerid][pSaveSkin] > -1) SetSpawnInfo(playerid,NO_TEAM,PlayerInfo[playerid][pSaveSkin],1958.3783,1343.1572,15.3746,269.1425,0,0,0,0,0,0);
	switch(PlayerInfo[playerid][pConnectStage])
	{
		case ct_selectskin:
		{
			if((GetTickCount()-PlayerInfo[playerid][pInterpolating]) > 2000)
			{
				SetPlayerCameraPos(playerid,229.429397,-1849.013549,10.186964);
				SetPlayerCameraLookAt(playerid,229.8910,-1870.9111,6.0000);
			}
		}
		default:
		{
			SetPlayerCameraPos(playerid,198.044738,-1750.411132,20.670663);
			SetPlayerCameraLookAt(playerid,229.387725,-1844.057250,10.845205);
		}
	}
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,vworld_requestclass);
	PlayerInfo[players][pInActivity] = false;
	return 1;
}
public OnPlayerRequestSpawn(playerid)
{
	if(!GetUserID(playerid)) return SendClientMessage(playerid,red," • /register :כדי לבחור דמות עליך להרשם לשרת"), 0;
	if(!PlayerInfo[playerid][pLogged]) return SendClientMessage(playerid,red," • /login :כדי לבחור דמות עליך להתחבר לשרת"), 0;
	if(PlayerInfo[playerid][pAdminLogged] == 1) return SendClientMessage(playerid,red," • /admlog :כדי לבחור דמות עליך להתחבר למערכת האדמינים"), 0;
	if(PlayerInfo[playerid][pConnectStage] < ct_selectskin || PlayerInfo[playerid][pWorld] == world_class) return SendClientMessage(playerid,red," • .נא לבחור עולם"), 0;
	return 1;
}
public OnPlayerSpawn(playerid)
{
	if(!PlayerInfo[playerid][pFirstSpawn])
	{
		RemoveBuildingForPlayer(playerid,2786,0.0,0.0,0.0,6000); // Gambling
		RemoveBuildingForPlayer(playerid,2785,0.0,0.0,0.0,6000); // Gambling
		RemoveBuildingForPlayer(playerid,2188,0.0,0.0,0.0,6000); // Gambling
		RemoveBuildingForPlayer(playerid,1978,0.0,0.0,0.0,6000); // Gambling
		RemoveBuildingForPlayer(playerid,2325,0.0,0.0,0.0,6000); // Gambling
		RemoveBuildingForPlayer(playerid,1895,0.0,0.0,0.0,6000); // Gambling
		PlayerInfo[playerid][pFirstSpawn] = true;
	}
	if(PlayerInfo[playerid][pConnectStage] != ct_playing)
	{
		PlayerInfo[playerid][pConnectStage] = ct_playing;
		Log("Connections",playerid,frmt("Selected world: %s",Worlds[PlayerInfo[playerid][pWorld]][wName]));
		SendFormat(playerid,lightblue," ~~~ :%s התחלת לשחק בעולם ~~~",Worlds[PlayerInfo[playerid][pWorld]][wName]);
		switch(PlayerInfo[playerid][pWorld])
		{
			case world_stunts:
			{
				SendClientMessage(playerid,green," !ברוכים הבאים לעולם הסטאנטים");
				SendClientMessage(playerid,grey," ,עולם זה הוא \"טבעי\" לחלוטין, באופן כזה שאין בו שום אובייקט או תוספת למפה");
				SendClientMessage(playerid,grey," .GTA SA והוא נועד לביצוע פעלולים במפה הרגילה הנורמאלית של");
				SendClientMessage(playerid,grey," .מעבר לפעלולים הרגילים תוכלו לצלם, לצפות, להשתגר למקומות, לבצע קווסטים (משימות), לקחת חלק בקרו ועוד");
				SendClientMessage(playerid,orange," ,בעולם זה כל שחקן מקבל אינסוף חיים. כמו כן ניתן להרוויח כאן נקודות סטאנטים, דריפטים, מהירות וגם מביצוע קווסטים");
				SendClientMessage(playerid,orange," .אך לא ניתן להרוויח כאן ניקוד על הריגות או אסיסטים כי עולם זה לא נועד להריגה");
			}
			case world_stuntswo:
			{
				SendClientMessage(playerid,green," !ברוכים הבאים לעולם הסטאנטים עם אובייקטים");
				SendClientMessage(playerid,grey," .בשונה מעולם הסטאנטים המקורי, עולם זה מכיל בתוכו המון מפות מגניבות ואובייקטים שמוסיפים למפה");
				SendClientMessage(playerid,grey," .יש פה המון שיגורים כאשר כל שיגור הוא מפה אחרת בנושא קפיצות, לופים ועוד רעיונות אחרים");
				SendClientMessage(playerid,grey," .כמו עולם הסטאנטים, גם כאן המטרה היא לעשות פעלולים אך הרבה אנשים ימצאו את זה קל וכיף יותר עם אובייקטים");
				SendClientMessage(playerid,grey," .מעבר לפעלולים הרגילים תוכלו לצלם, לצפות, להשתגר למקומות, לבצע קווסטים (משימות), לקחת חלק בקרו ועוד");
				SendClientMessage(playerid,orange," ,בעולם זה כל שחקן מקבל אינסוף חיים. כמו כן ניתן להרוויח כאן נקודות סטאנטים, דריפטים, מהירות וגם מביצוע קווסטים");
				SendClientMessage(playerid,orange," .אך לא ניתן להרוויח כאן ניקוד על הריגות או אסיסטים כי עולם זה לא נועד להריגה");
			}
			case world_dm:
			{
				SendClientMessage(playerid,green," !ברוכים הבאים לעולם הדי-אם");
				SendClientMessage(playerid,grey," .הסגנון שהיה הוא די-אם רגיל SA-MP רוב האנשים לא יבינו את הרעיון, אך בתקופות ישנות של");
				SendClientMessage(playerid,grey," ,בשונה משרתי די-אם אחרים שאפשר למצוא, מוד זה מביא אליכם את הדי-אם המקורי והישן");
				SendClientMessage(playerid,grey," .שמתרכז בעיקר במשחק קשה אך עם זאת מאתגר. לא תמצאו כאן כסף קל, קיצורי דרך או הריגות קלות");
				SendClientMessage(playerid,grey," .בעולם זה המטרה היא להשתפר מבחינת יריות, להרוג כמה שיותר ולהרוויח הרבה כסף");
				SendClientMessage(playerid,grey," ,במקביל לבסיס, תמצאו במוד זה אזורי כסף ונכסים איתם תוכלו להרוויח כסף לקניית נשקים בחנות ולשמירה בבנק");
				SendClientMessage(playerid,grey," .תוך כדי תוכלו לשחק גם באזורי די-אם, שיגורים מגוונים, לקחת חלק בקלאנים ועוד");
				SendClientMessage(playerid,orange," .בעולם זה ניתן להרוויח נקודות דריפטים, מהירות, הריגות, אסיסטים והד-שוטים אך לא קווסטים וסטאנטים");
			}
			case world_tdm:
			{
				SendClientMessage(playerid,grey," - מידע -");
			}
		}
		SendClientMessage(playerid,green," • (: .צוות השרת מאחל לך משחק מהנה");
		JoinChat(playerid,PlayerInfo[playerid][pWorld]);
		EnableStuntBonusForPlayer(playerid,PlayerInfo[playerid][pWorld] == world_stunts || PlayerInfo[playerid][pWorld] == world_stuntswo);
		if(PlayerInfo[playerid][pWorld] != world_stunts && PlayerInfo[playerid][pWorld] != world_stuntswo) Loop(i) if(PlayerInfo[i][pSpectate] == playerid && PlayerInfo[i][pCameraMode] == camera_spec)
		{
			TogglePlayerSpectating(i,0);
			PlayerInfo[i][pSpectate] = -1, PlayerInfo[i][pCameraMode] = camera_none;
			SendClientMessage(i,red," .שחקן זה עבר עולם ולכן לא ניתן להמשיך לצפות בו");
		}
		groupLoad(playerid); // used to change the player color
	}
	if(!PlayerInfo[playerid][pRadioSet] && strlen(currentRadio) > 0)
	{
		PlayerInfo[playerid][pRadioSet] = true;
		PlayAudioStreamForPlayer(playerid,currentRadio);
		if(currentRadioID == -1) SendClientMessage(playerid,grey," • כרגע מופעל רדיו מיוחד ע\"י האדמין [/radio :להחלפה | /saudio :לסיום]");
		else SendFormat(playerid,grey," • %s כרגע מופעל הרדיו [/radio :להחלפה | /saudio :לסיום]",Radio[currentRadioID][rdTitle]);
	}
	ResetMoney(playerid);
	TogglePlayerControllable(playerid,1);
	if(PlayerInfo[playerid][pDMZone] > -1) GoToDMZone(playerid,PlayerInfo[playerid][pDMZone]);
	else
	{
		SetPlayerVirtualWorld(playerid,worlds_gameplay + PlayerInfo[playerid][pWorld]);
		switch(PlayerInfo[playerid][pWorld])
		{
			case world_stunts:
			{
				//SetPlayerTime(playerid,12,0);
				new r = random(sizeof(RandomSpawns));
				SetPlayerPos(playerid,RandomSpawns[r][0],RandomSpawns[r][1],RandomSpawns[r][2]);
				SetPlayerFacingAngle(playerid,RandomSpawns[r][3]);
				SetPlayerInterior(playerid,0);
			}
			case world_stuntswo:
			{
				//SetPlayerTime(playerid,23,0);
				PlayerInfo[playerid][pFreezeTime] = 3;
				Freeze(playerid,true);
				new r = random(sizeof(RandomSpawns_SWO));
				SetPlayerPos(playerid,RandomSpawns_SWO[r][0],RandomSpawns_SWO[r][1],RandomSpawns_SWO[r][2]);
				SetPlayerFacingAngle(playerid,RandomSpawns_SWO[r][3]);
				SetPlayerInterior(playerid,0);
			}
			case world_dm:
			{
				GiveWeapon(playerid,24,100);
				GiveMoney(playerid,100,false);
				//SetPlayerTime(playerid,12,0);
				for(new i = 0; i < 10; i++) if(PlayerInfo[playerid][pWeapons][i] > 0) GiveWeapon(playerid,PlayerInfo[playerid][pWeapons][i],i == 9 || i == 8 ? 1 : (Ammunation[i][aAmmo]*PlayerInfo[playerid][pAmmo][i]));
				SetPlayerArmedWeapon(playerid,0);
				new r = random(sizeof(RandomSpawns));
				SetPlayerPos(playerid,RandomSpawns[r][0],RandomSpawns[r][1],RandomSpawns[r][2]);
				SetPlayerFacingAngle(playerid,RandomSpawns[r][3]);
				SetPlayerInterior(playerid,0);
			}
			case world_tdm:
			{
				//SetPlayerTime(playerid,12,0);
				new r = random(sizeof(RandomSpawns));
				SetPlayerPos(playerid,RandomSpawns[r][0],RandomSpawns[r][1],RandomSpawns[r][2]);
				SetPlayerFacingAngle(playerid,RandomSpawns[r][3]);
				SetPlayerInterior(playerid,0);
			}
		}
		PlayerInfo[playerid][pGodmod] = PlayerInfo[playerid][pWorld] == world_stunts || PlayerInfo[playerid][pWorld] == world_stuntswo;
		SetPlayerHealth(playerid,PlayerInfo[playerid][pGodmod] ? 100000.0 : 100.0);
		SetPlayerArmour(playerid,0.0);
	}
	SetCameraBehindPlayer(playerid);
	if(PlayerInfo[playerid][pSaveSkin] != -1) SetPlayerSkin(playerid,PlayerInfo[playerid][pSaveSkin]);
	for(new i = 0; i < MAX_DCMDS; i++) PlayerInfo[playerid][pDeath][i] = false;
	return 1;
}
public OnPlayerDeath(playerid,killerid,reason)
{
	Log("Deaths",playerid,frmt("Died (%d)",reason));
	SendDeathMessage(killerid,playerid,reason);
	if(PlayerInfo[playerid][pWorld] == world_dm)
	{
		new m = GetMoney(playerid);
		if(killerid != INVALID_PLAYER_ID)
		{
			ResetMoney(playerid);
			PlayerInfo[playerid][pRate][rtDeaths]++;
			Log("Deaths",playerid,frmt("Killed %s (%d)",GetName(killerid),reason));
			PlayerInfo[killerid][pRate][rtKills]++;
			GiveMoney(killerid,m);
			GiveExp(killerid,PlayerInfo[playerid][pHeadshoted] ? exp_headshot : exp_kill);
			new assist[MAX_PLAYERS] = INVALID_PLAYER_ID, assists = 0;
			Loop(i)
			{
				if(i != playerid && i != killerid && PlayerInfo[i][pRate][rtDamagePlayers][playerid] > 0) if(PlayerInfo[i][pRate][rtDamagePlayers][playerid] > 50) assist[assists++] = i;
				PlayerInfo[i][pRate][rtDamagePlayers][playerid] = 0;
			}
			if(assists > 0) for(new i = 0; i < assists; i++)
			{
				PlayerInfo[assist[i]][pRate][rtAssists]++;
				GiveExp(assist[i],exp_assist);
			}
			if(reason < 55) PlayerInfo[killerid][pRate][rtWeapons][reason]++;
			if(PlayerInfo[playerid][pLevel] > PlayerInfo[killerid][pLevel])
			{
				SetPlayerHealth(killerid,100.0);
				SendClientMessage(killerid,orange," • .על כך שהרגת שחקן ברמה גבוהה ממך התמלאו לך החיים");
			}
		}
	}
	if(PlayerInfo[playerid][pQuest] > -1)
	{
		DisablePlayerRaceCheckpoint(playerid);
		SendFormat(playerid,red," !כי מתת %s נפסלת במשימה",Quests[PlayerInfo[playerid][pQuest]][qName]);
		PlayerInfo[playerid][pQuest] = -1, PlayerInfo[playerid][pQuestStep] = 0;
	}
	if(PlayerInfo[playerid][pInActivity]) LeaveActivity(playerid);
	if(killerid != INVALID_PLAYER_ID) if(PlayerInfo[killerid][pInActivity])
	{
		new actuid = WorldInfo[PlayerInfo[killerid][pWorld]][wActivity][0], idx = GetActivityIndex(actuid);
		switch(actuid)
		{
			case 4:
			{
				PlayerInfo[killerid][pActivityParams][0]++;
				ResetWeapons(killerid);
				new w = ggweapons[WorldInfo[Activities[idx][actWorld]][wActivityParam]][min(PlayerInfo[killerid][pActivityParams][0],sizeof ggweapons [])];
				GiveWeapon(killerid,w,100000);
				GameTextForPlayer(killerid,frmt("~y~level %d:~n~~r~%s",PlayerInfo[killerid][pActivityParams][0]+1,WeaponName(w)),2000,4);
			}
		}
	}
	return 1;
}
public OnPlayerTakeDamage(playerid,issuerid,Float:amount,weaponid,bodypart)
{
	if(PlayerInfo[playerid][pGodmod]) amount = 0.0;
	PlayerInfo[playerid][pRate][rtDamaged] += floatround(amount);
	if(issuerid != INVALID_PLAYER_ID)
	{
		if(PlayerInfo[issuerid][pHeadshots] && bodypart == 9 && weaponid >= 22 && weaponid <= 38)
		{
			GetPlayerHealth(playerid,amount);
			SetPlayerHealth(playerid,0.0);
			PlayerInfo[playerid][pHeadshoted] = true;
			PlayerInfo[issuerid][pRate][rtHeadshots]++;
		}
		PlayerInfo[issuerid][pRate][rtDamage] += floatround(amount);
		PlayerInfo[issuerid][pRate][rtDamagePlayers][playerid] += floatround(amount);
	}
	return 1;
}
public OnPlayerText(playerid,text[])
{
	if(!PlayerInfo[playerid][pLogged]) return SendClientMessage(playerid,red," • .כדי לכתוב בצ'אט עליך להתחבר / להרשם לשרת"), 0;
	if(PlayerInfo[playerid][pAdminLogged] == 1) return SendClientMessage(playerid,red," • .כדי לכתוב בצ'אט עליך להתחבר למערכת האדמינים"), 0;
	if(chatlock && (!IsPlayerMAdmin(playerid) || PlayerInfo[playerid][pAdmin] < ServerConfig[cfgWriteLockedChat])) return SendClientMessage(playerid,red," • .הצ'אט נעול, לא ניתן לכתוב"), 0;
	if(PlayerInfo[playerid][pMute] > 0) return SendFormat(playerid,red," • .אתה במיוט, תוכל לכתוב שוב בעוד %d שניות",PlayerInfo[playerid][pMute]), 0;
	if(strlen(text) > 100) return SendClientMessage(playerid,red," .ההודעה שרשמת ארוכה מדי"), 0;
	if(advertisement(text,"צ'אט",playerid)) return 0;
	if(strlen(text) >= 25)
	{
		new sentence[M_S];
		GetPVarString(playerid,"player_sentence",sentence,sizeof(sentence));
		if(strfind(text,sentence,true) != -1) return SendClientMessage(playerid,red," .נא לא לכתוב את אותה ההודעה כמה פעמים"), 0;
		else SetPVarString(playerid,"player_sentence",text);
	}
	new prev = PlayerInfo[playerid][pSpamCheck][0], bool:censored = false;
	if(GetTickCount()-prev <= 500 && !IsPlayerMAdmin(playerid)) return SendClientMessage(playerid,red," .נא לא להציף את הצ'אט"), 0;
	PlayerInfo[playerid][pSpamCheck][0] = GetTickCount();
	for(new i = 0, pos = 0; i < censwords; i++) if((pos = strfind(text,censoring[i],true)) != -1)
	{
		for(new s = pos, j = pos + strlen(censoring[i]); s < j; s++) text[s] = '*';
		if(!censored) censored = true;
	}
	if(censored)
	{
		// Punishment?
	}
	Log("Chat",playerid,text);
	new gt = group_none;
	switch(text[0])
	{
		case '!': gt = group_clan;
		case '@': gt = group_crew;
	}
	if(gt > group_none && !PlayerInfo[playerid][pGroup][gt]) gt = group_none;
	if(gt != group_none)
	{
		frmt("[%s %s] %s (ID %03d | %d): %s",GroupTypes[gt],GroupInfo[PlayerInfo[playerid][pGroup][gt]][gName],GetName(playerid),playerid,PlayerInfo[playerid][pGroupLevel][gt],text[1]);
		Loop(i) if(PlayerInfo[i][pGroup][gt] == PlayerInfo[playerid][pGroup][gt]) SendClientMessage(i,0x00FFFFAA,fstring);
		return 0;
	}
	if(strlen(PlayerInfo[playerid][pTag]) > 0 && !equal(PlayerInfo[playerid][pTag],"None"))
	{
		if(PlayerInfo[playerid][pTagColor] != 0) frmt("%03d  {%s}%s {%s}%s:" @c(white) " %s",playerid,HexStringOfColor(PlayerInfo[playerid][pTagColor]),PlayerInfo[playerid][pTag],HexStringOfColor(PlayerInfo[playerid][pColor]),GetName(playerid),text);
		else frmt("%03d  %s {%s}%s:" @c(white) " %s",playerid,PlayerInfo[playerid][pTag],HexStringOfColor(PlayerInfo[playerid][pColor]),GetName(playerid),text);
	}
	else frmt("%03d  {%s}%s:" @c(white) " %s",playerid,HexStringOfColor(PlayerInfo[playerid][pColor]),GetName(playerid),text);
	Loop(i) if(PlayerInfo[i][pChat] == PlayerInfo[playerid][pChat]) SendClientMessage(i,white,fstring);
	PlayerInfo[playerid][pIdleTime] = 0;
	return 0;
}
public OnPlayerCommandText(playerid,cmdtext[])
{
	PlayerInfo[playerid][pIdleTime] = 0;
	if(!IsPlayerMAdmin(playerid) && (PlayerInfo[playerid][pMute] > 0 || PlayerInfo[playerid][pJail] > 0))
	{
		if(PlayerInfo[playerid][pMute]) return SendFormat(playerid,red," .לא ניתן לכתוב פקודות כאשר אתה במיוט, נסה שוב בעוד %d שניות",PlayerInfo[playerid][pMute]);
		else if(PlayerInfo[playerid][pJail]) return SendFormat(playerid,red," .לא ניתן לכתוב פקודות כאשר אתה בכלא, נסה שוב בעוד %d שניות",PlayerInfo[playerid][pJail]);
	}
	Log("Chat",playerid,cmdtext);
	new cmd[256], idx;
	cmd = strtok(cmdtext,idx);
	if(PlayerInfo[playerid][pNoCMD] && !equal(cmd,"/nocmd")) return SendClientMessage(playerid,red," .הפקודות חסומות לך");
	new prev = PlayerInfo[playerid][pSpamCheck][1];
	if(GetTickCount()-prev <= 500 && !IsPlayerMAdmin(playerid)) return SendClientMessage(playerid,red," .נא לא להציף בפקודות");
	PlayerInfo[playerid][pSpamCheck][1] = GetTickCount();
	if(equal(cmd,"/register"))
	{
		if(PlayerInfo[playerid][pLogged]) return SendClientMessage(playerid,red," .אתה כבר רשום ומחובר");
		if(GetUserID(playerid) != 0 || fexist(PlayerInfo[playerid][pUserFile])) return SendClientMessage(playerid,red," .הכינוי שלך כבר רשום, אנא החלף לכינוי אחר או התחבר");
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /register [password] :צורת השימוש");
		if(strlen(cmd) < 4 || strlen(cmd) > 15) return SendClientMessage(playerid,red," .הסיסמא שהקלדת קצרה / ארוכה מדי");
		Register(playerid,cmd);
		PlaySound(playerid,1057);
		SendClientMessage(playerid,lightblue," ~~~ !נרשמת בהצלחה לשרת ~~~");
		SendFormat(playerid,white,"%s" @c(yellow) " :שם משתמש",GetName(playerid));
		SendFormat(playerid,white,"%d" @c(yellow) " :מספר סידורי",PlayerInfo[playerid][pID]);
		SendFormat(playerid,white,"%s" @c(yellow) " :סיסמא",cmd);
		SendFormat(playerid,white,"%s" @c(yellow) " :תאריך הרשמה",GetDateAsString());
		SendClientMessage(playerid,red," * !F8 מומלץ לצלם מסך זה על ידי לחיצה על");
		return 1;
	}
	if(equal(cmd,"/login"))
	{
		if(PlayerInfo[playerid][pLogged]) return SendClientMessage(playerid,red," .אתה כבר רשום ומחובר");
		if(GetUserID(playerid) == 0 || !fexist(PlayerInfo[playerid][pUserFile])) return SendClientMessage(playerid,red," .לא קיים משתמש בכינוי שלך");
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /login [password] :צורת השימוש");
		if(strlen(cmd) < 4 || strlen(cmd) > 15) return SendClientMessage(playerid,red," .הסיסמא שהקלדת קצרה / ארוכה מדי");
		if(equal(fgetstring(PlayerInfo[playerid][pUserFile],"Password"),cmd))
		{
			PlayerInfo[playerid][pFailedLogins] = 0;
			Login(playerid);
			PlaySound(playerid,1057);
			SendFormat(playerid,green," • [התחברת בהצלחה [מספר סידורי: %d",PlayerInfo[playerid][pID]);
		}
		else
		{
			PlayerInfo[playerid][pFailedLogins]++;
			SendFormat(playerid,red," • [ההתחברות למשתמש נכשלה [%d/3",PlayerInfo[playerid][pFailedLogins]);
			if(PlayerInfo[playerid][pFailedLogins] == 3) SetKick(playerid,-1,"התחברויות נכשלו");
		}
		return 1;
	}
 	if(equal(cmd,"/pm"))
 	{
	 	if(PlayerInfo[playerid][pNoPM]) return SendClientMessage(playerid,red," .הפיאמים חסומים לך");
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /pm [id/name] [text] :צורת השימוש");
		new id = ReturnUser(cmd,playerid);
		if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
		if(id == playerid) return SendClientMessage(playerid,red," .אין באפשרותך לבצע את הפקודה הזו על עצמך");
		cmd = strrest(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /pm [id/name] [text] :צורת השימוש");
		if(advertisement(cmdtext,"הודעה פרטית",playerid)) return 1;
		SendPM(playerid,id,cmd);
		return 1;
	}
 	if(equal(cmd,"/r"))
 	{
	 	if(PlayerInfo[playerid][pNoPM]) return SendClientMessage(playerid,red," .הפיאמים חסומים לך");
		cmd = strrest(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /r [text] :צורת השימוש");
		if(!IsPlayerConnected(PlayerInfo[playerid][pLastPM]) || PlayerInfo[playerid][pLastPM] == playerid) return SendClientMessage(playerid,red," .לא שלחת פיאם לאחרונה או שהשחקן האחרון ששלחת אליו התנתק");
		if(advertisement(cmdtext,"הודעה פרטית",playerid)) return 1;
		SendPM(playerid,PlayerInfo[playerid][pLastPM],cmd);
		return 1;
	}
	if((equal(cmd,"/admlog") || equal(cmd,"/al")) && PlayerInfo[playerid][pAdminLogged] > 0)
	{
		if(!PlayerInfo[playerid][pLogged]) return SendClientMessage(playerid,red," .התחבר למשתמש שלך קודם");
		if(PlayerInfo[playerid][pAdminLogged] == 2) return SendClientMessage(playerid,red," .אתה כבר מחובר לאדמין");
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /admlog [password] :צורת השימוש");
		if(equal(cmd,ServerConfig[cfgPassword]))
		{
			PlayerInfo[playerid][pFailedLogins] = 0, PlayerInfo[playerid][pAdminLogged] = 2, PlayerInfo[playerid][pAdmin] = GetAdminLevel(PlayerInfo[playerid][pID]);
			SendClientMessage(playerid,green," • !התחברת בהצלחה למערכת האדמינים");
			SendDeathMessage(INVALID_PLAYER_ID,playerid,200);
		}
		else
		{
			PlayerInfo[playerid][pFailedLogins]++;
			SendFormat(playerid,red," • [ההתחברות לאדמין נכשלה [%d/2",PlayerInfo[playerid][pFailedLogins]);
			if(PlayerInfo[playerid][pFailedLogins] == 2) SetKick(playerid,-1,"התחברויות נכשלו");
		}
		return 1;
	}
	if(equal(cmd,"/changepass"))
	{
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /changepass [new password] :צורת השימוש");
		if(strlen(cmd) < 4 || strlen(cmd) > 15) return SendClientMessage(playerid,red," .הסיסמא שהקלדת קצרה / ארוכה מדי");
		if(equal(cmd,fgetstring(uf(playerid),"Password"))) return SendClientMessage(playerid,red," .על הסיסמא להיות שונה מהסיסמא העכשווית שלך");
		fsetstring(uf(playerid),"Password",cmd);
		PlaySound(playerid,1057);
		SendFormat(playerid,yellow," ." @c(white) "%s" @c(yellow) "-הסיסמא שלך שונתה ל",cmd);
		return 1;
	}
	if(!PlayerInfo[playerid][pLogged]) return SendClientMessage(playerid,red," • .כדי לבצע פקודות עליך להתחבר / להרשם לשרת");
	if(PlayerInfo[playerid][pAdminLogged] == 1) return SendClientMessage(playerid,red," • .כדי לבצע פקודות עליך להתחבר למערכת האדמינים");
	if(cmd[1] == '/' && IsPlayerMAdmin(playerid))
	{
		frmt("[AC] %s (ID %03d | %d): %s",GetName(playerid),playerid,PlayerInfo[playerid][pAdmin],cmdtext[2]);
		Loop(i) if(IsPlayerMAdmin(i)) SendClientMessage(i,orange,fstring);
		return 1;
	}
	frmt("[CMD] %s (%03d): %s",GetName(playerid),playerid,cmdtext);
	Loop(i) if(IsPlayerMAdmin(i) && PlayerInfo[i][pAdmin] >= PlayerInfo[playerid][pAdmin] && i != playerid && PlayerInfo[i][pToggle][0]) SendClientMessage(i,darkblue,fstring);
	if(equal(cmd,"/help"))
	{
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
			SendClientMessage(playerid,lightblue," ~~~ Help - עזרה ~~~");
			SendClientMessage(playerid,green," !SAMP-IL Heavy Stunts ברוכים הבאים לשרת");
			SendClientMessage(playerid,yellow," .על מנת לקבל עזרה, אתם מתבקשים לבחור נושא עזרה מהרשימה");
			SendClientMessage(playerid,yellow," /contact :בכל רגע אל תהססו ליצור קשר עם הצוות • /help [topic] - בחרו באמצעות הפקודה");
			SendClientMessage(playerid,purple," » :נושאי עזרה אפשריים");
			SendClientMessage(playerid,yellow," objective - מטרת השחקנים בשרת | info - מידע טכני לגבי הקהילה, השרת והמוד");
			SendClientMessage(playerid,yellow," commands - פקודות כלליות שלא קשורות למערכת ספציפית | rules - חוקי השרת");
			SendClientMessage(playerid,yellow," mode - רשימת המערכות במוד ופירוט על כל אחת מהן | credits - רשימת המעורבים ביצירת המוד");
			SendClientMessage(playerid,white," Gamemode Version: " version);
			return 1;
		}
		if(equal(cmd,"objective"))
		{
			SendClientMessage(playerid,lightblue," ~~~ Objective - משימה ~~~");
			SendClientMessage(playerid,yellow," .אין מטרה אחת ספציפית לכל השחקנים בשרת ,SA-MP-בניגוד להרבה שרתים אחרים ב");
			SendClientMessage(playerid,yellow," :המטרה משתנית בהתאם לעולם שהשחקן בחר לשחק בו");
			SendClientMessage(playerid,yellow," ,לדוגמה, המטרה היא להרוג כמה שיותר שחקנים ולשלוט בשרת DM בעולמות מסגנון");
			SendClientMessage(playerid,yellow," .לעומת עולמות מסוג סטאנטים שבהם המטרה היא להשיג כמה שיותר נקודות ולעלות רמות");
			SendClientMessage(playerid,green," .כאשר תכנסו לכל אחד מהעולמות יופיע בצ'אט הסבר בנושא אותו העולם");
			SendClientMessage(playerid,green," !בהצלחה");
		}
		else if(equal(cmd,"info"))
		{
			SendClientMessage(playerid,lightblue," ~~~ Info - מידע ~~~");
			SendFormat(playerid,grey," ~ %s :גרסת המוד",version);
			SendFormat(playerid,grey," ~ .%s העדכון אחרון היה בתאריך",last_update);
			SendFormat(playerid,grey," ~ .מספר העדכונים שהיו עד כה הוא %d",updates);
			SendFormat(playerid,grey," ~ %s :כתובת שרת הדיבור",tsip);
			SendClientMessage(playerid,purple," » :ניתן להשתמד גם בפקודות המידע");
			SendClientMessage(playerid,yellow," /contact || /gamemode • /gmode || /teamspeak • /ts • /voice || /forum • /webpage");
		}
		else if(equal(cmd,"commands"))
		{
			SendClientMessage(playerid,lightblue," ~~~ Commands - פקודות ~~~");
			SendClientMessage(playerid,green," .(/help mode) שים לב: כאן מוצגות רק הפקודות שלא נמצא להן תפריט עזרה בנושא העזרה של המוד");
			SendClientMessage(playerid,yellow," • /rules - חוקי השרת • /search - חיפוש שחקן");
			SendClientMessage(playerid,yellow," • /report - דיווח • /a - שליחת הודעה לאדמינים");
			SendClientMessage(playerid,yellow," • /pay - שליחת כסף בעולם הדיאם בלבד • /kill - מוות עצמי");
			SendClientMessage(playerid,yellow," • /admins - אדמינים מחוברים • /td - שעה ותאריך מציאותיים");
			SendClientMessage(playerid,yellow," • /mytime - שינוי שעה לעצמך • /saveskin - שמירת דמות");
			SendClientMessage(playerid,yellow," • /delskin - מחיקת דמות שמורה • /afk - או חזרה ממנו AFK כניסה למצב");
			SendClientMessage(playerid,yellow," • /lock - נעילת רכב • /unlock - פתיחת רכב");
		}
		else if(equal(cmd,"rules"))
		{
			SendClientMessage(playerid,lightblue," ~~~ Rules - חוקים ~~~");
			SendClientMessage(playerid,green," .בכל כמה זמן יופיעו חוקי השרת בצ'אט. יש להפנים ולציית להם");
			SendClientMessage(playerid,green," /rules :בכל זמן תוכלו לקרוא אותם בפקודה");
		}
		else if(equal(cmd,"mode"))
		{
			new helpMenus[][32] =
			{
				"Gameplay",
				"Private Messages",
				"Worlds",
				"User Accounts",
				"Levels",
				"Teleports",
				"Chat",
				"Radio",
				"Mini Games",
				"Donators",
				"Maps",
				"DM Zones",
				"Clans",
				"Bank",
				"Ammunation",
				"Properties",
				"Money Areas",
				"Houses",
				"Player Points",
				"Vehicles",
				"Crews",
				"Camera",
				"Spectator",
				"Quests",
				"Teams",
				"Team Leaders"
			};
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd))
			{
				SendFormat(playerid,lightblue," ~~~ List of Help Menus - [%d] - רשימת תפריטי עזרה ~~~",sizeof(helpMenus));
				new string[M_S];
				for(new i = 0; i < sizeof(helpMenus); i++)
				{
					format(string,sizeof(string),!strlen(string) ? ("%s(%d) %s") : ("%s • (%d) %s"),string,i+1,helpMenus[i]);
					if(strlen(string) >= 70 || i == sizeof(helpMenus)-1)
					{
						SendClientMessage(playerid,white,string);
						string = "";
					}
				}
			}
			else
			{
				new i = strval(cmd);
				if(i < 1 || i > sizeof(helpMenus)) return SendClientMessage(playerid,red," .מספר תפריט עזרה שגוי");
				cmd = strtok(cmdtext,idx);
				new c = !strlen(cmd) || strval(cmd) < 1 ? 0 : strval(cmd);
				if(!c) SendFormat(playerid,lightblue," ~~~ (%d - %s) Mode - מוד ~~~",i,helpMenus[i-1]);
				else SendFormat(playerid,lightblue," ~~~ (%d - %s) Mode Details - פירוט מערכת ~~~",i,helpMenus[i-1]);
				switch(i)
				{
					case 1: // Gameplay
					{
						if(!c)
						{
							SendClientMessage(playerid,yellow," .בא לשמר איכויות משחק ישנות ולהביא למרכז סוגי משחק שונים שנשכחו Heavy Stunts המוד בשרת");
							SendClientMessage(playerid,yellow," .מערכת הגיימפליי של המשחק שולטת במגוון העולמות, ומדוואת שכל שחקן זוכה להכיר בכל האיכויות של כל עולם");
							SendClientMessage(playerid,purple," » :לקריאה נוספת השתמשו בפקודות");
							SendClientMessage(playerid,orange," /help mode 1 1 :DM שיטת המשחק בשרת מבחינת סטאנטים ומבחינת");
							SendClientMessage(playerid,orange," /help mode 1 2 :טעמי האבטחה של השרת");
							SendClientMessage(playerid,orange," /help commands :לרשימת הפקודות הכלליות");
							c = -2;
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,purple," » :DM שיטת המשחק מבחינת");
							SendClientMessage(playerid,yellow," .היא אחת מהשיטות הפעילות בשרת מאחר והיא משומשת במספר עולמות שונים DeathMatch שיטת");
							SendClientMessage(playerid,yellow," ,הישנה והטובה, שעל פיה המוד עובד, המטרה היא להיות כמה שיותר חזק DM-לפי שיטת ה");
							SendClientMessage(playerid,yellow," ,להשיג נשקים, להרוויח כסף ולהרוג שחקנים אחרים. למרות הכל, ובניגוד לשיטה המוכרת");
							SendClientMessage(playerid,yellow," .DEagle CBug או Sawnoff 2-2 יש חסימה לשימוש בשיטות המוכרות כגון");
							SendClientMessage(playerid,purple," » :שיטות משחק אחרות");
							SendClientMessage(playerid,yellow," .השרת משמר ומעודד שיטות להתקדמות ולפיתוח ברמת הסטאנטים ,DM מעבר לשיטות");
							SendClientMessage(playerid,yellow," .DM-צוות השרת מזמין אתכם ללמוד וללמד, להתנסות ולהמציא, שיטות שונות למשחקים מסוג שונה מ");
						}
						else if(c == 2)
						{
							SendClientMessage(playerid,purple," » :טעמי האבטחה של השרת");
							SendClientMessage(playerid,purple," • אנטיצ'יט: " @c(orange) " מערכת הגנה בסיסית נגד שימוש בהאקים וצ'יטים");
							SendClientMessage(playerid,purple," • חסימת הצפה: " @c(orange) " הגבלת שליחת הודעות בצ'אט באותו זמן, כולל ביצוע פקודות והודעות פרטיות");
							SendClientMessage(playerid,purple," • חסימת קללות: " @c(orange) " חסימה בסיסית של קללות בצ'אט");
							SendClientMessage(playerid,purple," • חסימת פרסום: " @c(orange) " בקרה נגד פרסומי אתרים או שרתים");
							SendClientMessage(playerid,purple," • שמירת לוגים: " @c(orange) " הסטוריית השרת נשמרת ומתאפשרת לצפייה ע\"י הצוות");
						}
						else c = -1;
					}
					case 2: // Private Messages
					{
						if(!c)
						{
							SendClientMessage(playerid,yellow," .מערכת ההודעות הפרטיות מאפשרת לשלוח הודעה למשתמש יחיד מבלי שכל השחקנים בצ'אט יראו אותה");
							SendClientMessage(playerid,purple," » :פקודות מערכת ההודעות הפרטיות");
							SendClientMessage(playerid,orange," /pm /r /blockpms");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /pm [id/name] [text] - שליחת הודעה פרטית לשחקן ספציפי");
							SendClientMessage(playerid,yellow," /r [text] - החזרת הודעה פרטית לשחקן האחרון ששלח לך הודעה פרטית");
							SendClientMessage(playerid,yellow," /blockpms - חסימת או ביטול חסימה לקבלת הודעות פרטיות מכולם");
						}
						else c = -1;
					}
					case 3: // Worlds
					{
						if(!c)
						{
							SendClientMessage(playerid,yellow," .מערכת העולמות הייחודית של השרת מאפשרת למספר שחקנים לשחק בסוגים שונים של משחק בו זמנית ובאותו שרת");
							SendClientMessage(playerid,yellow," .בכל כניסה לשרת, כל שחקן נדרש לבחור עולם לפני שיוכל להמשיך לשחק, באותו עולם הוא ישחק ויוכל להחליף אותו במידה וירצה");
							SendClientMessage(playerid,purple," » :העולמות הקיימים");
							SendClientMessage(playerid,orange," עולם הסטאנטים" @c(yellow) " - פעלולים וסטאנטים במגוון של מפות ועם כלי רכב שונים | " @c(orange) "עולם הדיאם" @c(yellow) " - נשקים והריגות, הרווחת כסף וכדומה");
							SendClientMessage(playerid,orange," עולם הסטאנטים ללא אובייקטים" @c(yellow) " - סטאנטים בעולם הסאן אנדרס הקלאסי | " @c(orange) "עולם הטידיאם" @c(yellow) " - דיאם בקבוצות, כולל תפקידים ומטרות");
							SendClientMessage(playerid,purple," » :פקודות מערכת העולמות");
							SendClientMessage(playerid,orange," /world /players");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /world - החלפת עולם");
							SendClientMessage(playerid,yellow," /players - כמות השחקנים בעולמות השונים");
						}
						else c = -1;
					}
					case 4: // User Accounts
					{
						if(!c)
						{
							SendClientMessage(playerid,yellow," ,מערכת המשתמשים בשרת מאפשרת לכל שחקן גישה למשתמש שלו באמצעות שם וסיסמא, תוך כדי שפרטיו נשמרים");
							SendClientMessage(playerid,yellow," .וניתן להתנתק מהשרת בכל פעם בידיעה שכשנחזור - כל הפרטים של המשחק ישמרו");
							SendClientMessage(playerid,yellow," .לפי מערכת זו, כל משתמש מחוייב להרשם לשרת כדי לשחק, ולהתחבר באמצעות סיסמא בכל פעם שיכנס");
							SendClientMessage(playerid,purple," » :פקודות מערכת המשתמשים");
							SendClientMessage(playerid,orange," /register /login /changepass /changename /setting");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /register - הרשמה");
							SendClientMessage(playerid,yellow," /login - התחברות");
							SendClientMessage(playerid,yellow," /changepass - שינוי סיסמת משתמש");
							SendClientMessage(playerid,yellow," /changename - שינוי שם משתמש");
							SendClientMessage(playerid,yellow," /setting - הגדרות");
						}
						else c = -1;
					}
					case 5: // Levels
					{
						if(!c)
						{
							SendClientMessage(playerid,yellow," .מערכת הרמות מדרגת את הוותק, הנסיון והכוח של כל שחקן בשרת");
							SendClientMessage(playerid,yellow," .המערכת משותפת בין כלל העולמות, וכדי לעלות רמות צריך להתמצות ולעבור דרישות שקשורות בכל העולמות");
							SendClientMessage(playerid,yellow," .על ידי הריגות, סטאנטים, דריפטים וכדומה EXP לפי מערכת זו, כל שחקן ירוויח נקודות");
							SendClientMessage(playerid,yellow," ,מערכת הסטאטסים תשמור עבור כל שחקן כמות הריגות, התקפה שעשה, נקודות ומספר פרטים נוספים");
							SendClientMessage(playerid,yellow," .הנדרשת תעלו רמה EXP-בהם יהיה שימוש לצורך עליית הרמה. ברגע שתהיה לכם כמות ה");
							SendClientMessage(playerid,purple," » :פקודות מערכת הרמות");
							SendClientMessage(playerid,orange," /stats /pstats /level /exp /lcmds /channel");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /stats - הסטאטס שלך");
							SendClientMessage(playerid,yellow," /pstats - הסטאטס של שחקן אחר");
							SendClientMessage(playerid,yellow," /level - דרישות לרמה הבאה שלך");
							SendClientMessage(playerid,yellow," /exp - רשימת דרכי השגת נקודות");
							SendClientMessage(playerid,yellow," /lcmds - פקודות לפי רמות");
							SendClientMessage(playerid,yellow," /channel - אפשרויות רכב לכל רמה");
						}
						else c = -1;
					}
					case 6: // Teleports
					{
						if(!c)
						{
							SendClientMessage(playerid,yellow," .מערכת השיגורים מאפשרת להגיע לכל מיני מקומות ללא מאמץ");
							SendClientMessage(playerid,yellow," .המערכת עצמה קיימת בכל העולמות, אבל סוגי השיגורים נקבעים ספציפית לכל עולם בנפרד");
							SendClientMessage(playerid,yellow," .כדי להשתגר ניתן להשתמש בתפריטים, או בפקודות שמופיעות בכל אחד מהתפריטים");
							SendClientMessage(playerid,purple," » :פקודות מערכת השיגורים");
							SendClientMessage(playerid,orange," /tm");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /tm - תפריט השיגורים");
						}
						else c = -1;
					}
					case 7: // Chat
					{
						if(!c)
						{
							SendClientMessage(playerid,yellow," .מערכת הצ'אט מאפשרת מחלקת את הכתיבה והקריאה בצ'אט לפי סוגי העולמות, על מנת שלא ליצור בלבול");
							SendClientMessage(playerid,yellow," ,המערכת עובדת בצורה פשוטה: ישנם חדרי צ'אט וכל שחקן יכול לבחור באיזה חדר צ'אט להיות");
							SendClientMessage(playerid,yellow," .זה כולל חדרי צ'אט כלליים של כל עולם ובנוסף חדרי צ'אט פרטיים");
							SendClientMessage(playerid,purple," » :פקודות מערכת הצ'אט");
							SendClientMessage(playerid,orange," /chat /chatopt");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /chat - רשימת חדרי הצ'אט ואפשרות להכנס אליהם");
							SendClientMessage(playerid,yellow," /chatopt - אפשרויות צ'אט פרטי");
						}
						else c = -1;
					}
					case 8: // Radio
					{
						if(!c)
						{
							SendClientMessage(playerid,yellow," .מערכת הרדיו פעילה בכלל העולמות ומאפשרת להקשיב לרדיו מאחד מהערוצים הקיימים");
							SendClientMessage(playerid,yellow," .במקביל לאפשרות של השחקן להפעיל רדיו, האדמינים יכולים להפעיל רדיו ספציפי לכלל השרת");
							SendClientMessage(playerid,purple," » :פקודות מערכת הרדיו");
							SendClientMessage(playerid,orange," /radio /stations /saudio");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /radio - השמעת רדיו");
							SendClientMessage(playerid,yellow," /stations - רשימת ערוצי רדיו");
							SendClientMessage(playerid,yellow," /saudio - הפסקת כל צליל");
						}
						else c = -1;
					}
					case 9: // Minigames
					{   // TODO: Adding more activities
						if(!c)
						{
							SendClientMessage(playerid,yellow," .מערכת הפעילויות מפעילה באופן אוטומטי או על ידי האדמין משחקים קצרים ומהנים שהופכים את המשחק למעניין יותר");
							SendClientMessage(playerid,yellow," .לכל עולם יש סוגי פעילויות שונות משלו");
							SendClientMessage(playerid,purple," » :פקודות מערכת הפעילויות");
							SendClientMessage(playerid,orange," /activities /join /leave /actplayers");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /activities - רשימת הפעילויות");
							SendClientMessage(playerid,yellow," /join - הצטרפות לפעילות");
							SendClientMessage(playerid,yellow," /leave - יציאה מהפעילות");
							SendClientMessage(playerid,yellow," /actplayers - רשימת השחקנים בפעילות");
						}
						else c = -1;
					}
					case 10: // Dontaors
					{   // TODO: Adding bonuses and commands
						if(!c)
						{
							SendClientMessage(playerid,yellow," .מערכת התרומות מאפשרת חלוקת משתמשי תורם לשחקנים ספציפיים בשרת");
							SendClientMessage(playerid,yellow," .תורמים הם משתמשי הכבוד של השרת, שמקבלים הטבות ויכולים לבצע פקודות מיוחדות שאחרים לא יכולים");
							SendClientMessage(playerid,yellow," " webpage " :פרטים על האפשרות לתרום ניתן למצוא בפורומים שלנו בכתובת");
							SendClientMessage(playerid,purple," » :פקודות מערכת התורמים");
							SendClientMessage(playerid,orange," /vip /donators");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /vip - רשימת בעלי משתמש תורם שמחוברים לשרת");
							SendClientMessage(playerid,yellow," /donators - מידע על פקודות התורמים ורשימת ההטבות");
						}
						else c = -1;
					}
					case 11: // Maps
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_stuntswo);
							SendClientMessage(playerid,yellow," .מערכת המפות דואגת להוספת אובייקטים לעולם הסטאנטים על מנת להפוך אותו ליפה, מעניין ומהנה יותר");
							SendClientMessage(playerid,yellow," .לשימושכם מגוון רחב של מפות שנטענו על השרת ונבנו על ידי טובי המאבייקטים; עם הזמן יתווספו עוד");
							SendClientMessage(playerid,purple," » :פקודות מערכת המפות");
							SendClientMessage(playerid,orange," /maps");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /maps - רשימת כל המפות");
						}
						else c = -1;
					}
					case 12: // DM Zones
					{   // TODO: Adding more DM zones
						if(!c)
						{
							CheckWorld(playerid,true,world_dm);
							SendClientMessage(playerid,yellow," .מערכת אזורי הדיאם נותנת מענה לשחקנים שרוצים להלחם רק בנשק ספציפי, או רק בסגנון מסויים");
							SendClientMessage(playerid,yellow," ,באמצעות מערכת זו ניתן להשתגר לאזור מסויים ולקבל אליו ספאון בחזרה בכל פעם שמתים");
							SendClientMessage(playerid,yellow," .ככה שהקרב מפסיק רק כשאנחנו בוחרים שהוא יפסיק");
							SendClientMessage(playerid,purple," » :פקודות מערכת אזורי הדיאם");
							SendClientMessage(playerid,orange," /dm /qdmz");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /dm - רשימת אזורי הדיאם");
							SendClientMessage(playerid,yellow," /qdmz - יציאה מאזור דיאם וחזרה לספאון");
						}
						else c = -1;
					}
					case 13: // Clans
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_dm);
							SendClientMessage(playerid,yellow," ,מערכת הקלאנים אחראית על שילוב עבודת צוות במשחק, בכך שהיא מאפשרת משחק קבוצתי של מספר שחקנים");
							SendClientMessage(playerid,yellow," .שיכולים לקבל במידה והם קלאן רשמי - צבע משלהם, מפקדה, צ'אט פרטי ואפשרויות יעילות נוספות");
							SendClientMessage(playerid,yellow," .קלאנים שמקבלים מפקדה יכולים להנות משיגור, אזור, רכבים ופיקאפים משלהם");
							SendClientMessage(playerid,yellow," .בנוסף, לקלאנים האפשרות לכבוש אזורי כסף במשחק");
							SendClientMessage(playerid,purple," » :פקודות מערכת הקלאנים");
							SendClientMessage(playerid,orange," /clan /clans");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /clan - מגוון ענק של אפשרויות קלאנים");
							SendClientMessage(playerid,yellow," /clans - רשימת הקלאנים הקיימים בשרת");
						}
						else c = -1;
					}
					case 14: // Bank
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_dm);
							SendClientMessage(playerid,yellow," .מערכת הבנק דואגת שהכסף של כל שחקן ישמר גם לאחר שיצא מהשרת במקום שמור");
							SendClientMessage(playerid,yellow," .ניתן להכניס ולהוציא את הכסף בכל רגע נתון");
							SendClientMessage(playerid,yellow," ...בעזרת הכסף, שמקבלים מהריגות וממקורות נוספים, ניתן לקנות נשקים / בתים / ועוד");
							SendClientMessage(playerid,green," .הבנק ממוקם בחנויות ה-24/7 שברחבי מפת המשחק");
							SendClientMessage(playerid,purple," » :פקודות מערכת הבנק");
							SendClientMessage(playerid,orange," /deposit /depositall /withdraw /withdrawall /balance");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /deposit - הפקדת כסף");
							SendClientMessage(playerid,yellow," /depositall - הפקדת כל הכסף שעליך");
							SendClientMessage(playerid,yellow," /withdraw - הוצאת כסף");
							SendClientMessage(playerid,yellow," /withdrawall - הוצאת כל הכסף שבחשבון הבנק שלך");
							SendClientMessage(playerid,yellow," /balance - בדיקת מאזן הכסף בחשבון הבנק שלך");
						}
						else c = -1;
					}
					case 15: // Ammunation
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_dm);
							SendClientMessage(playerid,yellow," .מטרתו של כל שחקן דיאם, בראש ובראשונה, זה להשיג את כל הנשקים החזקים");
							SendClientMessage(playerid,yellow," .לשם כך קיימת מערכת חנות הנשקים - שמאפשרת לקנות נשקים במחירים מתאימים");
							SendClientMessage(playerid,yellow," .הנשקים נשמרים לתמיד, אלא אם מוחקים אותם");
							SendClientMessage(playerid,green," .במפת המשחק Ammunation חנות הנשקים ממוקמת בכל חנות");
							SendClientMessage(playerid,purple," » :פקודות מערכת חנות הנשקים");
							SendClientMessage(playerid,orange," /wl /bw /rw");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /wl - רשימת הנשקים");
							SendClientMessage(playerid,yellow," /bw - קניית נשק");
							SendClientMessage(playerid,yellow," /rw - מחיקת נשק");
						}
						else c = -1;
					}
					case 16: // Properties
					{   // TODO: Adding properties
						if(!c)
						{
							CheckWorld(playerid,true,world_dm);
							SendClientMessage(playerid,yellow," .מערכת הנכסים היא הדרך המרכזית להשיג כסף בעולם הדיאם");
							SendClientMessage(playerid,yellow," ,כל משתמש שברשותו סכום הכסף הדרוש, יוכל לקנות נכס ובכל 2 דקות להרוויח עליו סכום מסויים");
							SendClientMessage(playerid,yellow," .בדרך זו להרוויח יותר מהכסף שהשקיע");
							//SendClientMessage(playerid,green," .ניתן לקנות גם נכס ששייך למישהו אחר. אם קנו נכס ששייך לך, תקבל חלק מהסכום");
							SendClientMessage(playerid,green," .ניתן לקבל עד " #PROP_EARNS " משכורות מהנכס");
							SendClientMessage(playerid,purple," » :פקודות מערכת הנכסים");
							SendClientMessage(playerid,orange," /buy /properties /earnings");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /buy - קניית נכס");
							SendClientMessage(playerid,yellow," /properties - רשימת הנכסים בשרת");
							SendClientMessage(playerid,yellow," /earnings - בחירת דרך קבלת משכורות");
						}
						else c = -1;
					}
					case 17: // Money Areas
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_dm);
							SendClientMessage(playerid,yellow," .מערכת אזורי הכסף היא דרך משנית להשיג כסף");
							SendFormat(playerid,yellow," .כל מי שעומד באזורי הכסף הקיימים בשרת ירוויח %d$ לשנייה",ServerConfig[cfgMoneyAreaEarn]);
							SendClientMessage(playerid,green," .LV-אזור הכסף בשרת הוא ספינת הכסף ב");
						}
						else c = -1;
					}
					case 18: // Houses
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_dm);
							SendClientMessage(playerid,red," .מערכת זו תופעל בעתיד");
						}
						else c = -1;
					}
					case 19: // Player Points
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_stunts,world_stuntswo);
							SendClientMessage(playerid,yellow," .השונים Freeroam-מערכת הנקודות היא היעד המרכזי שכל שחקן צריך להשיג עם הזמן בשהייתו בעולמות ה");
							SendClientMessage(playerid,yellow," .מערכת זו כוללת נקודות מסוגים שונים שצריך לקבל על מנת לעלות רמה");
							SendClientMessage(playerid,purple," » :סוגי הנקודות");
							SendClientMessage(playerid,yellow," • נקודות סטאנטים: תקבלו באופן מוגבל ברגע שתבצעו סטאנטים ופעלולים שונים");
							SendClientMessage(playerid,yellow," • נקודות דריפטים: תקבלו כאשר תבצעו דריפטים עם רכב כלשהו");
							SendClientMessage(playerid,yellow," • נקודות מהירות: תקבלו כשתגיעו לאזור שיא המהירות ברכבים השונים");
						}
						else c = -1;
					}
					case 20: // Vehicles
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_stunts,world_stuntswo);
							SendClientMessage(playerid,yellow," .מכיוון שחסרים רכבים בשני עולמות הסטאנטים, באמצעות הפקודות הבאות ניתן לזמן רכבים משלכם לפי מספר או שם");
							SendClientMessage(playerid,yellow," .ניתן לזמן עד " #MAX_PLAYER_VEHICLES " רכבים סך הכל, בכל אחד מהעולמות, כמו כן ניתן למחוק רכבים שיצרת ולשגר אותם אליך");
							SendClientMessage(playerid,yellow," .לאחר יציאה מעולם כלשהו / מהשרת הרכבים שזימנת יימחקו");
							SendClientMessage(playerid,purple," » :פקודות מערכת הרכבים");
							SendClientMessage(playerid,orange," /call /del /vget");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /call - זימון רכב חדש");
							SendClientMessage(playerid,yellow," /del - העלמה של רכב שיצרת");
							SendClientMessage(playerid,yellow," /vget - שיגור רכב שיצרת אליך");
						}
						else c = -1;
					}
					case 21: // Crews
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_stunts,world_stuntswo);
							SendClientMessage(playerid,yellow," ,מערכת הקרוים, בדומה למערכת הקלאנים של הדיאם, מאפשר משחק קבוצתי ומהנה יותר שמעודד עבודת צוות");
							SendClientMessage(playerid,yellow," .אבל לא כדי להרוג - אלא כדי לשחק יחד. קרוים יתפקדו כקבוצות מרכזיות של עולמות הסטאנטים");
							SendClientMessage(playerid,yellow," .קרו רשמי יוכל לקבל הטבות, כמו צ'אט קבוצתי, פקודות מיוחדות לקרו וכדומה");
							SendClientMessage(playerid,purple," » :פקודות מערכת הקרויים");
							SendClientMessage(playerid,orange," /crew /crews");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /crew - אפשרויות קרוים");
							SendClientMessage(playerid,yellow," /crews - רשימת הקרוים בשרת");
						}
						else c = -1;
					}
					case 22: // Camera
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_stunts,world_stuntswo);
							SendClientMessage(playerid,yellow," .מערכת המצלמות מאפשרת לצלמי סרטונים לקחת חלק ולצלם סטאנטים או כל סרטון אחר");
							SendClientMessage(playerid,yellow," .בעזרת כמה פקודות יעילות ניתן להסתכל על השחקן שלך בזויות ואף לעקוב (באישור) אחרי שחקנים אחרים");
							SendClientMessage(playerid,purple," » :פקודות מערכת המצלמה");
							SendClientMessage(playerid,orange," /camera /watch");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,orange," /camera - אפשרויות המצלמה");
							SendClientMessage(playerid,orange," /watch - מעקב אחרי שחקן");
						}
						else c = -1;
					}
					case 23: // Spectator
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_stunts,world_stuntswo);
							SendClientMessage(playerid,yellow," .מערכת הספקטיטור בדומה למערכת המצלמה נועדה לעזור לצלמי סרטונים");
							SendClientMessage(playerid,yellow," ,Counter Strike באמצעות מערכת זו ניתן לרחף ברחבי המפה ממש כמו במשחקים כמו");
							SendClientMessage(playerid,yellow," .מה שעשוי להועיל בצילום");
							SendClientMessage(playerid,purple," » :פקודות מערכת הספקטיטור");
							SendClientMessage(playerid,orange," /fly /flyspeed");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /fly - מעבר למצב ספקטיטור או יציאה ממנו");
							SendClientMessage(playerid,yellow," /flyspeed - קביעת מהירות הצילום");
						}
						else c = -1;
					}
					case 24: // Quests
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_stunts,world_stuntswo);
							SendClientMessage(playerid,yellow," :ע\"י השלמה של מטרות שונות XP מערכת המשימות מאפשרת דרך חדשה להשגת");
							SendClientMessage(playerid,yellow," .בעת התחלת המשימה יוצבו מולך נקודות אליהן תצטרך להגיע");
							SendClientMessage(playerid,yellow," .אם תצליח להשלים את המשימה, תזוכה באופן אוטומטי בנקודות");
							SendClientMessage(playerid,yellow," .שים לב כי מקבלים נקודות רק בפעם הראשונה והשנייה בהשלמת משימה בכל יום");
							SendClientMessage(playerid,purple," » :פקודות מערכת המשימות");
							SendClientMessage(playerid,orange," /quest");
						}
						else if(c == 1)
						{
							SendClientMessage(playerid,yellow," /quest - אפשרויות המשימות");
						}
						else c = -1;
					}
					case 25: // Teams
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_tdm);
							SendClientMessage(playerid,red," .מערכת זו תופעל בעתיד");
						}
						else if(c == 1)
						{
						}
						else if(c == 2)
						{
						}
						else c = -1;
					}
					case 26: // Team Leaders
					{
						if(!c)
						{
							CheckWorld(playerid,true,world_tdm);
							SendClientMessage(playerid,red," .מערכת זו תופעל בעתיד");
						}
						else if(c == 1)
						{
						}
						else if(c == 2)
						{
						}
						else c = -1;
					}
				}
				if(c <= 0)
				{
					if(c == -1) SendClientMessage(playerid,red," .אפשרות רשימה שגויה");
					else if(!c) SendFormat(playerid,grey," /help mode %d 1 :לרשימת פקודות והסבר על כל אחת מהן השתמשו בפקודה",i);
				}
			}
		}
		else if(equal(cmd,"credits"))
		{
			SendClientMessage(playerid,lightblue," ~~~ Credits - יוצרי המוד ואודות ~~~");
			SendFormat(playerid,green," %s :אתר הקהילה",webpage);
			SendClientMessage(playerid,0x0066FFFF," • Amit_B :מתכנת המוד");
			SendClientMessage(playerid,0x0000FFFF," • Beater :הוגה הרעיון ומייסד הקהילה");
			SendClientMessage(playerid,orange," • תאריך יצירת המוד לראשונה: 09/04/2014");
		}
		else SendClientMessage(playerid,red," .תפריט עזרה שגוי");
		return 1;
	}
	if(equal(cmd,"/gamemode") || equal(cmd,"/gmode")) return SendClientMessage(playerid,blue," » Gamemode: SAMP-IL Heavy Stunts • Version: " version " • Last Update: " last_update " • Total Updates: " #updates);
	if(equal(cmd,"/teamspeak") || equal(cmd,"/ts") || equal(cmd,"/voice")) return SendClientMessage(playerid,blue," » TeamSpeak Address: " tsip " • TeamSpeak Version: 3");
	if(equal(cmd,"/forum") || equal(cmd,"/webpage")) return SendClientMessage(playerid,blue," » Community Name: SAMP-IL • Forum: " webpage);
	if(equal(cmd,"/contact"))
	{
		SendClientMessage(playerid,lightblue," ~~~ :יצירת קשר ~~~");
		SendClientMessage(playerid,green," .צוות השרת ישמח לשמוע מכם בכל עת");
		SendClientMessage(playerid,purple," » :ליצירת קשר השתמשו באחת מהפקודות הבאות");
		SendClientMessage(playerid,yellow," /report - לדיווח על שחקן מחובר");
		SendClientMessage(playerid,yellow," /a - פנייה לכל האדמינים");
		SendClientMessage(playerid,yellow," (/admins :או לאדמינים) /pm - ליצירת קשר בפרטיות עם כל משתמש");
		SendClientMessage(playerid,orange,webpage " :תמיד תוכלו לפנות אלינו גם בפורומים");
		return 1;
	}
	if(equal(cmd,"/kill")) return SetPlayerHealth(playerid,0.0);
	if(equal(cmd,"/rules"))
	{
		SendClientMessage(playerid,lightblue," ~~~ :חוקי השרת ~~~");
		ShowFile(playerid,green,file_rules);
		return 1;
	}
	if(equal(cmd,"/admins"))
	{
		new admin[MAX_PLAYERS] = {INVALID_PLAYER_ID,...}, admins = 0;
		Loop(i) if(IsPlayerConnected(i) && IsPlayerMAdmin(i)) admin[admins++] = i;
		if(!admins) SendClientMessage(playerid,red," .אין אדמינים מחוברים");
		else
		{
			SendFormat(playerid,lightblue," ~~~ :[אדמינים מחוברים [%d ~~~",admins);
			for(new i = 0, c = 0; i < admins; i++)
			{
				format(fstring,sizeof(fstring)," %d) " @c(white) "%s" @c(grey) " [ID: %03d",++c,GetName(admin[i]),admin[i]);
				if(IsPlayerMAdmin(playerid))
				{
					format(fstring,sizeof(fstring),"%s | Level: %d",fstring,PlayerInfo[admin[i]][pAdmin]);
					if(IsPlayerAdmin(admin[i])) format(fstring,sizeof(fstring),"%s | RCON Admin",fstring,PlayerInfo[admin[i]][pAdmin]);
				}
				format(fstring,sizeof(fstring),"%s]",fstring);
				SendClientMessage(playerid,grey,fstring);
			}
		}
		return 1;
	}
	if(equal(cmd,"/td"))
	{
		new td[6];
		gettime(td[0],td[1],td[2]);
		getdate(td[3],td[4],td[5]);
		SendFormat(playerid,purple,"%02d:%02d:%02d :שעה",td[0],td[1],td[2]);
		SendFormat(playerid,purple,"%02d/%02d/%04d :תאריך",td[5],td[4],td[3]);
		return 1;
	}
	if(equal(cmd,"/mytime"))
	{
		if(!PlayerInfo[playerid][pSetting][setting_clock]) return SendClientMessage(playerid,red," /setting clock :השעון אצלך צריך להיות מופעל לשימוש בפקודה זו");
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /mytime [time 0-23] :צורת שימוש");
		new h = strval(cmd);
		if(h < 0) h = 0;
		else if(h > 23) h = 23;
		SetPlayerTime(playerid,h,0);
		return 1;
	}
	if(equal(cmd,"/saveskin"))
	{
		SendClientMessage(playerid,green," • .הסקין שלך נשמר");
		fsetint(uf(playerid),"Skin",PlayerInfo[playerid][pSaveSkin] = GetPlayerSkin(playerid));
		return 1;
	}
	if(equal(cmd,"/delskin"))
	{
		if(PlayerInfo[playerid][pSaveSkin] == -1) return SendClientMessage(playerid,red," .אין לך סקין שמור");
		SendClientMessage(playerid,green," • .הסקין שלך נמחק");
		PlayerInfo[playerid][pSaveSkin] = -1;
		fsetint(uf(playerid),"Skin",PlayerInfo[playerid][pSaveSkin]);
		return 1;
	}
	if(equal(cmd,"/afk"))
	{
		if(PlayerInfo[playerid][pFrozen]) return SendClientMessage(playerid,red," .לא ניתן להשתמש בפקודה זו כשאתה בהקפאה");
		if(!PlayerInfo[playerid][pAFK])
		{
			if(PlayerInfo[playerid][pConnectStage] != ct_playing) return SendClientMessage(playerid,red," .עד שתתחיל לשחק AFK אינך יכול לעבור למצב");
			if(PlayerInfo[playerid][pInActivity]) return SendClientMessage(playerid,red," .כאשר אתה בפעילות AFK לא ניתן לעבור למצב");
			SetPlayerChatBubble(playerid,"AFK",blue,15.0,3000);
			GameTextForPlayer(playerid,"~b~~h~~h~afk",1000,6);
			SendClientMessage(playerid,grey," /afk :ליציאה השתמש שוב ,AFK נכנסת למצב");
		}
		Freeze(playerid,PlayerInfo[playerid][pAFK] = !PlayerInfo[playerid][pAFK]);
		return 1;
	}
	if(equal(cmd,"/lock"))
	{
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red," .עליך להיות ברכב");
		switch(GetPlayerState(playerid))
		{
			case PLAYER_STATE_PASSENGER: SendClientMessage(playerid,red," .עליך להיות הנהג בכדי לנעול את הרכב");
			case PLAYER_STATE_DRIVER:
			{
				new v = GetPlayerVehicleID(playerid);
				if(VehicleInfo[v][vLocked]) return SendClientMessage(playerid,red," .הרכב כבר נעול");
				SendClientMessage(playerid,green," .הרכב ננעל");
				Loop(i) if(i != playerid) SetVehicleParamsForPlayer(v,i,0,1);
				VehicleInfo[v][vLocked] = true;
			}
			default: SendClientMessage(playerid,red," .עליך להיות בתוך הרכב בכדי לנעול אותו");
		}
		return 1;
	}
	if(equal(cmd,"/unlock"))
	{
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red," .עליך להיות ברכב");
		switch(GetPlayerState(playerid))
		{
			case PLAYER_STATE_PASSENGER: SendClientMessage(playerid,red," .עליך להיות הנהג בכדי לנעול את הרכב");
			case PLAYER_STATE_DRIVER:
			{
				new v = GetPlayerVehicleID(playerid);
				if(!VehicleInfo[v][vLocked]) return SendClientMessage(playerid,red," .הרכב לא נעול");
				SendClientMessage(playerid,green," .הרכב נפתח");
				Loop(i) if(i != playerid) SetVehicleParamsForPlayer(v,i,0,0);
				VehicleInfo[v][vLocked] = false;
			}
			default: SendClientMessage(playerid,red," .עליך להיות בתוך הרכב בכדי לנעול אותו");
		}
		return 1;
	}
	if(equal(cmd,"/search") || equal(cmd,"/s") || equal(cmd,"/id"))
	{
		new string[M_S];
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /search(s) [id/name] :צורת שימוש");
		if(IsNumeric(cmd))
		{
			new id = strval(cmd);
			format(string,sizeof(string)," :תוצאת חיפוש משתמש בעל האיידי %d",id);
			SendClientMessage(playerid,green,string);
			if(IsPlayerConnected(id)) SendFormat(playerid,yellow," • %s [ID: %03d]",GetName(id),id);
			else SendClientMessage(playerid,red," .איידי לא קיים");
		}
		else
		{
			new found = 0;
 			SendFormat(playerid,green," :\"%s\" תוצאות חיפוש כינוי",cmd);
			Loop(i) if(IsPlayerConnected(i) && strfind(GetName(i),cmd,true) != -1)
			{
				found++;
				SendFormat(playerid,yellow," • %d. %s [ID: %03d]",found,GetName(i),i);
			}
			if(!found) SendClientMessage(playerid,red," .לא נמצאו כינויים דומים לכינוי שכתבת");
			SendFormat(playerid,green," .סך הכל %d תוצאות חיפוש",found);
		}
		return 1;
	}
	if(equal(cmd,"/report"))
	{
		if(IsPlayerMAdmin(playerid)) return SendClientMessage(playerid,red," .אתה אדמין, אתה לא צריך להשתמש בפקודה זו");
		if(PlayerInfo[playerid][pUsedCommand][1] > 0) return SendClientMessage(playerid,red," .תוכל לבצע את הפקודה הזו שוב בקרוב");
		new id, reason[M_S], string[64];
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /report [id/name] [reason] :צורת השימוש");
		id = ReturnUser(cmd,playerid);
		if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
		if(IsPlayerMAdmin(id)) return SendClientMessage(playerid,red," .לא ניתן לדווח על אדמין");
		if(id == playerid) return SendClientMessage(playerid,red," .לא ניתן לדווח על עצמך");
		reason = strrest(cmdtext,idx);
		if(!strlen(reason)) reason = "לא צוינה סיבה";
		SendFormat(playerid,green," .נשלח לאדמינים %s הדיווח שלך על",GetName(id));
		SendFormat(playerid,grey,"(%s)",reason);
		format(string,sizeof(string)," • :(%d) %s (על (%d %s הגיע דיווח מ",id,GetName(id),playerid,GetName(playerid));
		Loop(i) if(IsPlayerConnected(i) && IsPlayerMAdmin(i))
		{
			SendClientMessage(i,grey,string);
			SendClientMessage(i,grey,reason);
		}
		PlayerInfo[playerid][pUsedCommand][1] = 60;
		return 1;
	}
	if(equal(cmd,"/a"))
	{
		new txt[256], aa = 0, string[M_S];
		txt = strrest(cmdtext,idx);
		if(IsPlayerMAdmin(playerid)) return SendClientMessage(playerid,red," .אתה אדמין, אתה לא צריך להשתמש בפקודה זו");
		if(PlayerInfo[playerid][pUsedCommand][0] > 0) return SendClientMessage(playerid,red," .תוכל לבצע את הפקודה הזו שוב בקרוב");
		if(!strlen(txt)) return SendClientMessage(playerid,white," /a [message] :צורת השימוש");
		format(string,sizeof(string)," • :שלח הודעה לכל האדמינים %s",GetName(playerid));
		Loop(i) if(IsPlayerConnected(i) && IsPlayerMAdmin(i))
		{
			aa++;
			SendClientMessage(i,grey,string);
			SendClientMessage(i,grey,txt);
		}
		if(!aa) return SendClientMessage(playerid,red," .אין אדמינים מחוברים ולכן הדיווח לא נשלח");
		SendClientMessage(playerid,green," :הודעתך נשלחה בהצלחה אל האדמינים");
		SendClientMessage(playerid,green,txt);
		PlayerInfo[playerid][pUsedCommand][0] = 60;
		return 1;
	}
	if(equal(cmd,"/pay"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /pay [id/name] [amount] :צורת השימוש");
		new id = ReturnUser(cmd,playerid);
		if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
		if(id == playerid) return SendClientMessage(playerid,red," .לא ניתן לשלוח כסף לעצמך");
		if(PlayerInfo[id][pWorld] != world_dm) return SendClientMessage(playerid,red," .DM משתמש זה לא נמצא בעולם");
		cmd = strtok(cmdtext,idx);
		new m = strval(cmd);
		if(m < 1 || m > GetMoney(playerid)) return SendClientMessage(playerid,red," .סכום כסף שגוי");
		GiveMoney(id,m);
		GiveMoney(playerid,0-m);
		SendFormat(playerid,green," • %s-שלחת $%d ל",GetName(id),m);
		SendFormat(id,green," • %s-קיבלת $%d מ",GetName(playerid),m);
		return 1;
	}
	if(equal(cmd,"/blockpms"))
	{
		PlayerInfo[playerid][pBlockPMs] = !PlayerInfo[playerid][pBlockPMs];
		SendClientMessage(playerid,green,PlayerInfo[playerid][pBlockPMs] ? (" • /blockpms :חסמת קבלת הודעות פרטיות. כדי לבטל את החסימה, השתמש שוב") : (" • .ביטלת את החסימה לשימוש בהודעות פרטיות"));
		return 1;
	}
	if(equal(cmd,"/changename"))
	{
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /changename [new name] :צורת השימוש");
		if(strlen(cmd) < 3 || strlen(cmd) > 20) return SendClientMessage(playerid,red," .הכינוי שלך קצר / ארוך מדי");
		if(fexist((format(fstring,sizeof(fstring),dir_users "%s.ini",GetName(playerid)), fstring))) return SendClientMessage(playerid,red," .הכינוי שהקלדת כבר קיים אצל משתמש אחר");
		if(!IsValidNick(cmd)) return SendClientMessage(playerid,red," .הכינוי שהקלדת מכיל תווים לא חוקיים");
		fsetstring(uf(playerid),"Nickname",cmd);
		SetPlayerName(playerid,cmd);
		PlaySound(playerid,1057);
		SendFormat(playerid,yellow," ." @c(white) "%s" @c(yellow) " לשם " @c(white) "%s" @c(yellow) "-שם המשתמש שלך שונה מ",cmd,GetName(playerid));
		GetPlayerName(playerid,PlayerInfo[playerid][pName],MAX_PLAYER_NAME);
		return 1;
	}
	if(IsPlayerMAdmin(playerid))
	{
		if(equal(cmd,"/acmdupdate")) return AdminCommands(acUpdate), 1;
		new shortcut = -1;
		for(new i = 0; i < sizeof(AdminCommandShortcuts) && shortcut == -1; i++) if(equal(cmd,AdminCommandShortcuts[i][acShortcut])) shortcut = i;
		if(shortcut != -1)
		{
			new newcmdtext[128];
			strmid(newcmdtext,cmdtext,strlen(cmd),strlen(cmdtext));
			strins(newcmdtext,AdminCommandShortcuts[shortcut][acTarget],0);
			return OnPlayerCommandText(playerid,newcmdtext);
		}
		new cmdid = AdminCommands(acFind,cmd);
		if(cmdid > -1) if(PlayerInfo[playerid][pAdmin] < AdminCommandList[cmdid][acLevel]) return SendFormat(playerid,red," .עליך להיות לפחות ברמת אדמין %d %s כדי להשתמש בפקודה",AdminCommandList[cmdid][acLevel],AdminCommandList[cmdid][acName]);
		if(equal(cmd,"/ahelp"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd) || !IsNumeric(cmd))
			{
				SendClientMessage(playerid,lightblue," ~~~ :עזרה - אדמין ~~~");
				SendFormat(playerid,white," /ahelp [level 1-%d] :פקודות לפי רמת אדמין",ServerConfig[cfgMaxAdminLevel]);
				return 1;
			}
			new alvl = strval(cmd), c = 0;
			if(alvl < 1 || alvl > ServerConfig[cfgMaxAdminLevel]) return SendClientMessage(playerid,red," .רמת אדמין שגויה");
			if(PlayerInfo[playerid][pAdmin] < alvl) return SendClientMessage(playerid,red," .אינך מורשה לצפות בפקודות לאדמינים ברמה גבוהה משלך");
			SendFormat(playerid,lightblue," ~~~ :פקודות לאדמין ברמה %d ~~~",alvl);
			fstring = "";
			for(new i = 0; i < sizeof(AdminCommandList); i++)
			{
				if(AdminCommandList[i][acLevel] == alvl)
				{
					format(fstring,sizeof(fstring),c % 6 == 0 ? (" • %s%s") : ("%s, %s"),fstring,AdminCommandList[i][acName]);
					c++;
				}
				if((c % 6 == 0 || i == sizeof(AdminCommandList)-1) && strlen(fstring) > 0)
				{
					SendClientMessage(playerid,white,fstring);
					fstring = "";
				}
			}
			if(!c) return SendClientMessage(playerid,red," .לא נמצאו פקודות אדמין לרמה זו");
			return 1;
		}
		if(equal(cmd,"/vehicle"))
		{
			if(PlayerInfo[playerid][pConnectStage] != ct_playing) return SendClientMessage(playerid,red," .עליך להתחיל לשחק כדי לבצע פקודה זו");
			new Float:p[4], vmodel, vid, avid = -1;
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /vehicle [vehicle name/model] :צורת השימוש");
			vmodel = IsNumeric(cmd) ? strval(cmd) : GetVehicleModelIDFromName(cmd);
			if(vmodel < 400 || vmodel > 611) return SendClientMessage(playerid,red," .שם הרכב או מודל שגוי");
			for(new i = 0; i < MAX_ADMIN_VEHICLES && avid == -1; i++) if(PlayerInfo[playerid][pACreatedVehicle][i] == INVALID_VEHICLE_ID) avid = i;
			if(avid == -1 || PlayerInfo[playerid][pACreatedVehicles] >= MAX_ADMIN_VEHICLES) return SendClientMessage(playerid,red," .כל אדמין יכול ליצור עד " #MAX_ADMIN_VEHICLES " רכבים דרך האדמין, נא למחוק חלק על מנת ליצור עוד");
			GetPlayerPos(playerid,p[0],p[1],p[2]);
			GetPlayerFacingAngle(playerid,p[3]);
			GetXYInFrontOfPlayer(playerid,p[0],p[1],IsPlayerInAnyVehicle(playerid) ? 10.0 : 5.0);
			vid = CreateVehicleEx(vmodel,p[0],p[1],p[2],p[3]+90,-1,-1,respawntime,PlayerInfo[playerid][pWorld],GetPlayerInterior(playerid));
			VehicleInfo[vid][vACreatedBy] = playerid;
			PlayerInfo[playerid][pACreatedVehicle][avid] = vid;
			PlayerInfo[playerid][pACreatedVehicles]++;
			SendFormat(playerid,yellow," [%d/" #MAX_ADMIN_VEHICLES "] %s :רכב %d נוצר",PlayerInfo[playerid][pACreatedVehicles],VehicleName(vmodel),vid);
			return 1;
		}
		if(equal(cmd,"/vdel"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid,white," /vdel [option] :צורת השימוש");
				SendClientMessage(playerid,white," /vdel cur :מחיקת הרכב הנוכחי שאתה נמצא בו");
				SendClientMessage(playerid,white," /vdel com [text] :מחיקת הרכב עם הוספת הערה לקובץ הרכבים");
				SendClientMessage(playerid,white," /vdel last :מחיקת הרכב האחרון שהצבת");
				SendClientMessage(playerid,white," /vdel all :מחיקת כל הרכבים שהצבת");
				return 1;
			}
			if(equal(cmd,"cur"))
			{
				if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red," .עליך להיות ברכב");
				new v = GetPlayerVehicleID(playerid);
				if(IsPlayerConnected(VehicleInfo[v][vACreatedBy]))
				{
					new pos = -1;
					for(new i = 0; i < PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicles] && pos == -1; i++) if(PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicle][i] == v) pos = i;
					if(pos != -1)
					{
						for(new i = pos; i < PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicles] && i < MAX_ADMIN_VEHICLES - 2; i++) PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicle][i] = PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicle][i + 1];
						PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicle][PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicles]-1] = INVALID_VEHICLE_ID, PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicles]--;
					}
					SendFormat(VehicleInfo[v][vACreatedBy],red," .%s נמחק על ידי האדמין [%s ,הרכב שיצרת [רכב מס' %d",GetName(playerid),VehicleName(GetVehicleModel(v)),v);
				}
				DestroyVehicleEx(v);
				SendClientMessage(playerid,green," .הרכב נמחק בהצלחה");
			}
			else if(equal(cmd,"com"))
			{
				if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red," .עליך להיות ברכב");
				new v = GetPlayerVehicleID(playerid);
				if(IsPlayerConnected(VehicleInfo[v][vACreatedBy]))
				{
					new pos = -1;
					for(new i = 0; i < PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicles] && pos == -1; i++) if(PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicle][i] == v) pos = i;
					if(pos != -1)
					{
						for(new i = pos; i < PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicles] && i < MAX_ADMIN_VEHICLES - 1; i++) PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicle][i] = PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicle][i + 1];
						PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicle][PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicles]-1] = INVALID_VEHICLE_ID, PlayerInfo[VehicleInfo[v][vACreatedBy]][pACreatedVehicles]--;
					}
					SendFormat(VehicleInfo[v][vACreatedBy],red," .%s נמחק על ידי האדמין [%s ,הרכב שיצרת [רכב מס' %d",GetName(playerid),VehicleName(GetVehicleModel(v)),v);
				}
				new File:fh = fopen(file_vsave,io_append), Float:p[4];
				if(fh)
				{
					GetVehiclePos(v,p[0],p[1],p[2]);
					GetVehicleZAngle(v,p[3]);
					fwrite(fh,frmt("CreateVehicleEx(%d,%.4f,%.4f,%.4f,%.4f,%d,%d,.world=%s); // -- [%s] %s\r\n",GetVehicleModel(v),p[0],p[1],p[2],p[3],VehicleInfo[v][vColors][0],VehicleInfo[v][vColors][1],WorldDefineName(PlayerInfo[playerid][pWorld]),VehicleName(GetVehicleModel(v)),cmdtext[6]));
					fclose(fh);
				}
				DestroyVehicleEx(v);
				SendClientMessage(playerid,green,file_vsave " :הרכב נמחק בהצלחה וההערה נשמרה");
			}
			else if(equal(cmd,"last"))
			{
				if(!PlayerInfo[playerid][pACreatedVehicles]) return SendClientMessage(playerid,red," .אין לך רכבים שיצרת");
				new v = PlayerInfo[playerid][pACreatedVehicle][PlayerInfo[playerid][pACreatedVehicles]-1], pos = -1;
				for(new i = 0; i < PlayerInfo[playerid][pACreatedVehicles] && pos == -1; i++) if(PlayerInfo[playerid][pACreatedVehicle][i] == v) pos = i;
				if(pos != -1)
				{
					for(new i = pos; i < PlayerInfo[playerid][pACreatedVehicles] && i < MAX_ADMIN_VEHICLES - 2; i++) PlayerInfo[playerid][pACreatedVehicle][i] = PlayerInfo[playerid][pACreatedVehicle][i + 1];
					PlayerInfo[playerid][pACreatedVehicle][PlayerInfo[playerid][pACreatedVehicles]-1] = INVALID_VEHICLE_ID, PlayerInfo[playerid][pACreatedVehicles]--;
				}
				SendFormat(playerid,yellow," .נמחק [%s ,הרכב האחרון שיצרת [רכב מס' %d",VehicleName(GetVehicleModel(v)),v);
				DestroyVehicleEx(v);
			}
			else if(equal(cmd,"all"))
			{
				if(!PlayerInfo[playerid][pACreatedVehicles]) return SendClientMessage(playerid,red," .אין לך רכבים שיצרת");
				for(new i = 0; i < PlayerInfo[playerid][pACreatedVehicles]; i++)
				{
					DestroyVehicleEx(PlayerInfo[playerid][pACreatedVehicle][i]);
					PlayerInfo[playerid][pACreatedVehicle][i] = INVALID_VEHICLE_ID;
				}
				SendFormat(playerid,yellow," .כל %d הרכבים האחרונים שיצרת נמחקו",PlayerInfo[playerid][pACreatedVehicles]);
				PlayerInfo[playerid][pACreatedVehicles] = 0;
			}
			else SendClientMessage(playerid,red," .אפשרות שגויה");
			return 1;
		}
		if(equal(cmd,"/vsave"))
		{
			if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red," .עליך להיות ברכב");
			new Float:p[4], File:fh = fopen(file_vsave,io_append), v = GetPlayerVehicleID(playerid);
			if(fh)
			{
				GetVehiclePos(v,p[0],p[1],p[2]);
				GetVehicleZAngle(v,p[3]);
				fwrite(fh,frmt("CreateVehicleEx(%d,%.4f,%.4f,%.4f,%.4f,%d,%d,.world=%s); // [%s] %s\r\n",GetVehicleModel(v),p[0],p[1],p[2],p[3],VehicleInfo[v][vColors][0],VehicleInfo[v][vColors][1],WorldDefineName(PlayerInfo[playerid][pWorld]),VehicleName(GetVehicleModel(v)),cmdtext[6]));
				fclose(fh);
			}
			SendClientMessage(playerid,yellow,file_vsave " :הרכב נשמר אל");
			return 1;
		}
		if(equal(cmd,"/vsaveall"))
		{
			new File:fh = fopen(file_vsave,io_append);
			if(fh)
			{
				for(new i = 0, v = 0, Float:p[4]; i < PlayerInfo[playerid][pACreatedVehicles]; i++)
				{
					v = PlayerInfo[playerid][pACreatedVehicle][i];
					if(VehicleInfo[v][vValid])
					{
						GetVehiclePos(v,p[0],p[1],p[2]);
						GetVehicleZAngle(v,p[3]);
						fwrite(fh,frmt("CreateVehicleEx(%d,%.4f,%.4f,%.4f,%.4f,%d,%d,.world=%s); // [%s] %s\r\n",GetVehicleModel(v),p[0],p[1],p[2],p[3],VehicleInfo[v][vColors][0],VehicleInfo[v][vColors][1],WorldDefineName(PlayerInfo[playerid][pWorld]),VehicleName(GetVehicleModel(v)),cmdtext[9]));
					}
				}
				fclose(fh);
			}
			SendFormat(playerid,yellow,file_vsave " :כל %d הרכבים האחרונים שיצרת נשמרו",PlayerInfo[playerid][pACreatedVehicles]);
			return 1;
		}
		if(equal(cmd,"/vamount"))
		{
			if(PlayerInfo[playerid][pConnectStage] != ct_playing) return SendClientMessage(playerid,red," .עליך להתחיל לשחק כדי לבצע פקודה זו");
			new string[M_S], Float:p[4], vmodel, amount, Float:dis;
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /vamount [amount] [dis] [vehicle name/model] :צורת השימוש");
			amount = strval(cmd), cmd = strtok(cmdtext,idx), dis = floatstr(cmd), cmd = strtok(cmdtext,idx), vmodel = IsNumeric(cmd) ? strval(cmd) : GetVehicleModelIDFromName(cmd);
			if(vmodel < 400 || vmodel > 611) return SendClientMessage(playerid,red," .שם הרכב או מודל שגוי");
			if((PlayerInfo[playerid][pACreatedVehicles]+amount) > MAX_ADMIN_VEHICLES) return SendClientMessage(playerid,red," .כל אדמין יכול ליצור עד " #MAX_ADMIN_VEHICLES " רכבים דרך האדמין, נא למחוק חלק על מנת ליצור עוד");
			GetPlayerFacingAngle(playerid,p[3]);
			GetPlayerPos(playerid,p[0],p[1],p[2]);
			for(new i = 0, int = GetPlayerInterior(playerid); i < amount; i++)
			{
				GetXYInFrontOfPoint(p[0],p[1],p[3],dis);
				PlayerInfo[playerid][pACreatedVehicle][PlayerInfo[playerid][pACreatedVehicles]+i] = CreateVehicleEx(vmodel,p[0],p[1],p[2],p[3]+90,-1,-1,respawntime,PlayerInfo[playerid][pWorld],int);
			}
			PlayerInfo[playerid][pACreatedVehicles] += amount;
			format(string,sizeof(string)," [%d/" #MAX_ADMIN_VEHICLES "] %s :נוצרו %d רכבים מסוג",PlayerInfo[playerid][pACreatedVehicles],VehicleName(vmodel),amount);
			SendClientMessage(playerid,yellow,string);
			return 1;
		}
		if(equal(cmd,"/teleport"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid,white," /teleport [option] :צורת השימוש");
				SendClientMessage(playerid,white," /teleport add [name] :הוספת שיגור");
				SendClientMessage(playerid,white," /teleport remove [name] :הסרת שיגור");
				SendClientMessage(playerid,white," /teleport activate [name] :הפעלת שיגור");
				SendClientMessage(playerid,white," /teleport deactivate [name] :הפסקת פעילות שיגור");
				SendClientMessage(playerid,white," /teleport edit [name] [name/pos/vpos/int/level/vip/delvpos] :עריכת שיגור");
				SendClientMessage(playerid,white," /teleport setworld [name] [world id] :הפעלה של שיגור בעולם ספציפי");
				SendClientMessage(playerid,white," /teleport delworld [name] [world id] :ביטול של שיגור מעולם ספציפי");
				return 1;
			}
			new File:fh, f[32], tel = -1;
			if(equal(cmd,"add"))
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /teleport add [name] :צורת השימוש");
				for(new i = 0, len = strlen(cmd); i < len; i++) cmd[i] = tolower(cmd[i]);
				format(f,sizeof(f),dir_tele "%s.ini",cmd);
				if(fexist(frmt(dir_tele "%s.ini",cmd))) return SendClientMessage(playerid,red," .כבר קיים שיגור בשם הזה");
				fh = fopen(file_tele,io_append);
				if(fh)
				{
					fwrite(fh,frmt("%s\r\n",cmd));
					fclose(fh);
				}
				fcreate(f);
				format(Teleports[teleCount][tlName],32,cmd);
				format(Teleports[teleCount][tlCommand],32,"/%s",cmd);
				fsetstring(f,"Command",Teleports[teleCount][tlCommand]);
				GetPlayerPos(playerid,Teleports[teleCount][tlPos][0],Teleports[teleCount][tlPos][1],Teleports[teleCount][tlPos][2]);
				GetPlayerFacingAngle(playerid,Teleports[teleCount][tlPos][3]);
				new Float:p[4];
				for(new i = 0; i < 4; i++) p[i] = Teleports[teleCount][tlPos][i];
				fsetstring(f,"Pos",LoadStringFromPos(p));
				if(IsPlayerInAnyVehicle(playerid))
				{
					GetVehiclePos(GetPlayerVehicleID(playerid),Teleports[teleCount][tlVPos][0],Teleports[teleCount][tlVPos][1],Teleports[teleCount][tlVPos][2]);
					GetVehicleZAngle(GetPlayerVehicleID(playerid),Teleports[teleCount][tlVPos][3]);
				}
				else for(new i = 0; i < 4; i++) Teleports[teleCount][tlVPos][i] = Teleports[teleCount][tlPos][i];
				for(new i = 0; i < 4; i++) p[i] = Teleports[teleCount][tlVPos][i];
				fsetstring(f,"VPos",LoadStringFromPos(p));
				Teleports[teleCount][tlWithVehicle] = true;
				fsetint(f,"Interior",Teleports[teleCount][tlInterior] = GetPlayerInterior(playerid));
				fsetint(f,frmt("World%d",PlayerInfo[playerid][pWorld]),1);
				fsetint(f,"Level",Teleports[teleCount][tlLevel] = 1);
				fsetint(f,"VIP",_:(Teleports[teleCount][tlVIP] = false));
				fsetint(f,"FreezeTime",Teleports[teleCount][tlFreezeTime] = 1);
				fsetint(f,"Creator",Teleports[teleCount][tlCreator] = PlayerInfo[playerid][pID]);
				fsetint(f,"Active",1);
				for(new i = 1; i < MAX_WORLDS; i++) Teleports[teleCount][tlWorld][i] = i == PlayerInfo[playerid][pWorld];
				Teleports[teleCount][tlActive] = true;
				SendFormat(playerid,green," • %s :נוצר השיגור",Teleports[teleCount][tlCommand]);
				teleCount++;
			}
			else if(equal(cmd,"remove"))
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /teleport remove [name] :צורת השימוש");
				for(new i = 0, len = strlen(cmd); i < len; i++) cmd[i] = tolower(cmd[i]);
				format(f,sizeof(f),dir_tele "%s.ini",cmd);
				if(!fexist(frmt(dir_tele "%s.ini",cmd))) return SendClientMessage(playerid,red," .לא קיים שיגור בשם הזה");
				fh = fopen(file_tele,io_write);
				if(fh)
				{
					for(new i = 0; i < teleCount; i++)
					{
						if(equal(Teleports[i][tlName],cmd))
						{
							tel = i;
							continue;
						}
						fwrite(fh,frmt("%s\r\n",Teleports[i][tlName]));
					}
					fclose(fh);
				}
				fremove(f);
				SendFormat(playerid,green," • %s :השיגור נמחק",Teleports[tel][tlCommand]);
				for(new i = tel; i < teleCount; i++)
				{
					format(Teleports[i][tlName],32,Teleports[i+1][tlName]);
					format(Teleports[i][tlCommand],32,Teleports[i+1][tlCommand]);
					for(new j = 0; j < 4; j++) Teleports[i][tlPos][j] = Teleports[i+1][tlPos][j], Teleports[i][tlVPos][j] = Teleports[i+1][tlVPos][j];
					Teleports[i][tlInterior] = Teleports[i+1][tlInterior];
					for(new j = 1; j < MAX_WORLDS; i++) Teleports[i][tlWorld][j] = Teleports[i+1][tlWorld][j];
					Teleports[i][tlLevel] = Teleports[i+1][tlLevel];
					Teleports[i][tlWithVehicle] = Teleports[i+1][tlWithVehicle];
					Teleports[i][tlVIP] = Teleports[i+1][tlVIP];
					Teleports[i][tlFreezeTime] = Teleports[i+1][tlFreezeTime];
					Teleports[i][tlCreator] = Teleports[i+1][tlCreator];
					Teleports[i][tlActive] = Teleports[i+1][tlActive];
				}
				teleCount--;
			}
			else if(equal(cmd,"activate"))
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /teleport activate [name] :צורת השימוש");
				for(new i = 0, len = strlen(cmd); i < len; i++) cmd[i] = tolower(cmd[i]);
				format(f,sizeof(f),dir_tele "%s.ini",cmd);
				if(!fexist(f)) return SendClientMessage(playerid,red," .לא קיים שיגור בשם הזה");
				for(new i = 0; i < teleCount && tel == -1; i++) if(equal(Teleports[i][tlName],cmd)) tel = i;
				if(tel == -1) return SendClientMessage(playerid,red," .השיגור לא נמצא");
				if(Teleports[tel][tlActive]) return SendClientMessage(playerid,red," .השיגור הזה כבר פעיל");
				fsetint(f,"Active",1);
				Teleports[tel][tlActive] = true;
				SendFormat(playerid,green," • %s :השיגור מופעל",Teleports[tel][tlCommand]);
			}
			else if(equal(cmd,"deactivate"))
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /teleport activate [name] :צורת השימוש");
				for(new i = 0, len = strlen(cmd); i < len; i++) cmd[i] = tolower(cmd[i]);
				format(f,sizeof(f),dir_tele "%s.ini",cmd);
				if(!fexist(f)) return SendClientMessage(playerid,red," .לא קיים שיגור בשם הזה");
				for(new i = 0; i < teleCount && tel == -1; i++) if(equal(Teleports[i][tlName],cmd)) tel = i;
				if(tel == -1) return SendClientMessage(playerid,red," .השיגור לא נמצא");
				if(!Teleports[tel][tlActive]) return SendClientMessage(playerid,red," .השיגור הזה לא פעיל");
				fsetint(f,"Active",0);
				Teleports[tel][tlActive] = false;
				SendFormat(playerid,green," • %s :השיגור כבוי",Teleports[tel][tlCommand]);
			}
			else if(equal(cmd,"edit"))
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /teleport edit [name] [name/pos/vpos/int/level/vip] :צורת השימוש");
				for(new i = 0, len = strlen(cmd); i < len; i++) cmd[i] = tolower(cmd[i]);
				format(f,sizeof(f),dir_tele "%s.ini",cmd);
				if(!fexist(f)) return SendClientMessage(playerid,red," .לא קיים שיגור בשם הזה");
				for(new i = 0; i < teleCount && tel == -1; i++) if(equal(Teleports[i][tlName],cmd)) tel = i;
				if(tel == -1) return SendClientMessage(playerid,red," .השיגור לא נמצא");
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /teleport edit [name] [name/pos/vpos/int/level/vip] :צורת השימוש");
				if(equal(cmd,"name"))
				{
					cmd = strtok(cmdtext,idx);
					if(!strlen(cmd)) return SendClientMessage(playerid,white," /teleport edit name [new name] :צורת השימוש");
					for(new i = 0; i < teleCount && tel == -1; i++) if(equal(Teleports[i][tlName],cmd)) return SendClientMessage(playerid,red," .שיגור בשם הזה כבר קיים");
					new f2[32];
					format(f2,sizeof(f2),dir_tele "%s.ini",cmd);
					frename(f,f2);
					format(Teleports[tel][tlName],32,cmd);
					fh = fopen(file_tele,io_write);
					if(fh)
					{
						for(new i = 0; i < teleCount; i++) fwrite(fh,frmt("%s\r\n",Teleports[i][tlName]));
						fclose(fh);
					}
					SendFormat(playerid,green," • %s-שונה ל %s שם השיגור",cmd,Teleports[tel][tlCommand]);
					format(Teleports[tel][tlCommand],32,"/%s",cmd);
				}
				else if(equal(cmd,"pos") || equal(cmd,"vpos"))
				{
					new Float:p[4];
					if(IsPlayerInAnyVehicle(playerid))
					{
						GetVehiclePos(GetPlayerVehicleID(playerid),p[0],p[1],p[2]);
						GetVehicleZAngle(GetPlayerVehicleID(playerid),p[3]);
					}
					else
					{
						GetPlayerPos(playerid,p[0],p[1],p[2]);
						GetPlayerFacingAngle(playerid,p[3]);
					}
					if(cmd[0] == 'p' || cmd[0] == 'P')
					{
						for(new i = 0; i < 4; i++) Teleports[tel][tlPos][i] = p[i];
						fsetstring(f,"Pos",LoadStringFromPos(p));
						SendFormat(playerid,green," • שונה למיקומך הנוכחי %s מיקום השיגור",Teleports[tel][tlCommand]);
					}
					else
					{
						Teleports[tel][tlWithVehicle] = true;
						for(new i = 0; i < 4; i++) Teleports[tel][tlVPos][i] = p[i];
						fsetstring(f,"VPos",LoadStringFromPos(p));
						SendFormat(playerid,green," • ברכב שונה למיקומך הנוכחי %s מיקום השיגור",Teleports[tel][tlCommand]);
					}
				}
				else if(equal(cmd,"int"))
				{
					Teleports[tel][tlInterior] = GetPlayerInterior(playerid);
					fsetint(f,"Interior",Teleports[tel][tlInterior]);
					SendFormat(playerid,green," • שונה לאינטריור הנוכחי שלך, %d %s האינטריור של השיגור",Teleports[tel][tlInterior],Teleports[tel][tlCommand]);
				}
				else if(equal(cmd,"level"))
				{
					if(!strlen(cmd)) return SendClientMessage(playerid,white," /teleport edit level [level] :צורת השימוש");
					new lvl = strval(cmd);
					if(lvl < 0 || lvl >= sizeof(Levels)) return SendClientMessage(playerid,red," .רמה שגויה");
					Teleports[tel][tlLevel] = lvl;
					fsetint(f,"Level",lvl);
					SendFormat(playerid,green," • שונתה לרמה שבחרת, %d %s הרמה הנדרשת של השיגור",lvl,Teleports[tel][tlCommand]);
				}
				else if(equal(cmd,"vip"))
				{
					if(!strlen(cmd)) return SendClientMessage(playerid,white," /teleport edit vip [on/off] :צורת השימוש");
					if(!equal(cmd,"on") && !equal(cmd,"off")) return SendClientMessage(playerid,red," .אפשרות שגויה");
					Teleports[tel][tlVIP] = equal(cmd,"on");
					fsetint(f,"VIP",_:(Teleports[tel][tlVIP]));
					SendFormat(playerid,green," • כעת %s %s דרישת משתמש כבוד לשיגור",Teleports[tel][tlVIP] ? ("פעילה") : ("כבויה"),Teleports[tel][tlCommand]);
				}
				else if(equal(cmd,"delvpos"))
				{
					if(!Teleports[tel][tlWithVehicle]) return SendClientMessage(playerid,red," .לשיגור זה לא ניתן להשתגר עם רכב");
					Teleports[tel][tlWithVehicle] = false;
					fremovekey(f,"VPos");
					SendFormat(playerid,green," • %s מעכשיו לא ניתן להשתגר עם רכב לשיגור",Teleports[tel][tlCommand]);
				}
				else SendClientMessage(playerid,red," .אפשרות עריכה שגויה");
			}
			else if(equal(cmd,"setworld") || equal(cmd,"delworld"))
			{
				new bool:set = cmd[0] == 's' || cmd[0] == 'S', wid = -1;
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white,set ? (" /teleport setworld [name] [world id] :צורת השימוש") : (" /teleport delworld [name] [world id] :צורת השימוש"));
				for(new i = 0, len = strlen(cmd); i < len; i++) cmd[i] = tolower(cmd[i]);
				format(f,sizeof(f),dir_tele "%s.ini",cmd);
				if(!fexist(f)) return SendClientMessage(playerid,red," .לא קיים שיגור בשם הזה");
				for(new i = 0; i < teleCount && tel == -1; i++) if(equal(Teleports[i][tlName],cmd)) tel = i;
				if(tel == -1) return SendClientMessage(playerid,red," .השיגור לא נמצא");
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white,set ? (" /teleport setworld [name] [world id] :צורת השימוש") : (" /teleport delworld [name] [world id] :צורת השימוש"));
				wid = strval(cmd);
				if(wid < 0 || wid >= sizeof(Worlds)) return SendClientMessage(playerid,red," .מספר עולם שגוי");
				if(!Worlds[wid][wPlayable]) return SendClientMessage(playerid,red," .לא ניתן לשחק בעולם זה");
				if(set && Teleports[teleCount][tlWorld][wid]) return SendClientMessage(playerid,red," .השיגור כבר פעיל בעולם זה");
				if(!set && !Teleports[teleCount][tlWorld][wid]) return SendClientMessage(playerid,red," .השיגור לא פעיל בעולם זה");
				Teleports[teleCount][tlWorld][wid] = set;
				fsetint(f,frmt("World%d",wid),_:(set));
				if(set) SendFormat(playerid,green," • הופעל בעולם מספר %d %s השיגור",wid,Teleports[tel][tlCommand]);
				else SendFormat(playerid,green," • בוטל מעולם מספר %d %s השיגור",wid,Teleports[tel][tlCommand]);
			}
			else SendClientMessage(playerid,red," .אפשרות שגויה");
			return 1;
		}
		if(equal(cmd,"/map"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid,white," /map [option] :צורת השימוש");
				SendClientMessage(playerid,white," /map load [id] :טעינת מפה");
				SendClientMessage(playerid,white," /map unload [id] :הסרת מפה");
				SendClientMessage(playerid,white," /map reload [id] :עדכון מפה");
				SendClientMessage(playerid,white," /map goto [id] :שיגור למפה");
				return 1;
			}
			if(equal(cmd,"load"))
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /map load [id] :צורת השימוש");
				new id = strval(cmd);
				if(!MapExist(id)) return SendClientMessage(playerid,red," .מפה שגויה");
				if(MapInfo[id][mLoaded]) return SendClientMessage(playerid,red," .מפה זו כבר טעונה");
				//if(!MapLoad(id)) return SendClientMessage(playerid,red," .הטעינה נכשלה");
				MapLoad(id-1);
				SendFormat(playerid,white," * %s טענת את המפה",MapInfo[id][mName]);
			}
			else if(equal(cmd,"unload"))
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /map unload [id] :צורת השימוש");
				new id = strval(cmd);
				if(!MapExist(id)) return SendClientMessage(playerid,red," .מפה שגויה");
				if(!MapInfo[id][mLoaded]) return SendClientMessage(playerid,red," .מפה זו לא טעונה");
				MapUnload(id-1);
				SendFormat(playerid,white," * %s הסרת את המפה",MapInfo[id][mName]);
			}
			else if(equal(cmd,"reload"))
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /map reload [id] :צורת השימוש");
				new id = strval(cmd);
				if(!MapExist(id)) return SendClientMessage(playerid,red," .מפה שגויה");
				if(MapInfo[id][mLoaded]) MapUnload(id-1);
				//if(!MapLoad(id)) return SendClientMessage(playerid,red," .הטעינה נכשלה");
				MapLoad(id-1);
				SendFormat(playerid,white," * %s עדכנת את המפה",MapInfo[id][mName]);
			}
			else if(equal(cmd,"goto"))
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /map goto [id] :צורת השימוש");
				new id = strval(cmd), Float:avg[3];
				if(!MapExist(id)) return SendClientMessage(playerid,red," .מפה שגויה");
				for(new i = 0, Float:p[3]; i < MapInfo[id][mObjects]; i++)
				{
					GetDynamicObjectPos(MapInfo[id][mObject][i],p[0],p[1],p[2]);
					for(new j = 0; j < 3; j++) avg[j] += p[j];
				}
				for(new j = 0; j < 3; j++) avg[j] /= float(MapInfo[id][mObjects]);
				SetPlayerPosFindZ(playerid,avg[0],avg[1],avg[2]+50.0);
			}
			else SendClientMessage(playerid,red," .אפשרות שגויה");
			return 1;
		}
		if(equal(cmd,"/createclan"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /createclan [clan name] :צורת השימוש");
			if(strlen(cmd) > 20) return SendClientMessage(playerid,red," .שם ארוך מדי");
			if(!IsValidName(cmd)) return SendClientMessage(playerid,red," .חלק מהאותיות שכתבת לא יכולות להכנס לשם של קלאן");
			for(new i = 1; i < MAX_GROUPS; i++) if(equal(cmd,GroupInfo[i][gName])) return SendClientMessage(playerid,red," .שם הקלאן כבר בשימוש");
			format(fstring,sizeof(fstring),dir_groups "%s-%s.ini",GroupTypes[group_clan],cmd);
			if(fexist(fstring)) return SendClientMessage(playerid,red," .קובץ הקלאן הזה כבר קיים");
			new clanid = GetEmptyGroupID(), num[8], Float:p[4];
			if(clanid == -1) return SendClientMessage(playerid,red," .(לא ניתן ליצור קלאנים (כמות גבוהה מדי");
			fcreate(fstring);
			fsetint(fstring,"ID",clanid);
			fsetint(fstring,"R",255);
			fsetint(fstring,"G",255);
			fsetint(fstring,"B",255);
			fsetint(fstring,"HQ",0);
			fsetstring(fstring,"HQCMD",cmd);
			GetPlayerPos(playerid,p[0],p[1],p[2]);
			GetPlayerFacingAngle(playerid,p[3]);
			fsetstring(fstring,"HQPos",LoadStringFromPos(p));
			fsetstring(fstring,"HQVPos",LoadStringFromPos(p));
			format(GroupInfo[clanid][gName],32,cmd);
			GroupInfo[clanid][gMembers] = 0;
			for(new j = 0; j < MAX_GROUP_MEMBERS; j++) GroupInfo[clanid][gMember][j] = INVALID_PLAYER_ID;
			GroupInfo[clanid][gType] = group_clan;
			GroupInfo[clanid][gColor] = {255,255,255};
			new c = fgetint(file_groups,"#Count");
			if(clanid == fgetint(file_groups,"#Count") || !c) fsetint(file_groups,"#Count",c+1);
			valstr(num,clanid);
			fsetstring(file_groups,num,cmd);
			SendFormat(playerid,green," .מספר הקבוצה: %d ,%s יצרת את הקלאן",clanid,cmd);
			return 1;
		}
		if(equal(cmd,"/deleteclan"))
		{
			new clanid, f[64];
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /deleteclan [clan name] :צורת השימוש");
			clanid = gid(cmd,group_clan);
			if(!clanid || GroupInfo[clanid][gType] != group_clan) return SendClientMessage(playerid,red," .קלאן שגוי");
			frmt(" .%s ,האדמין מחק את הקלאן שלך",GroupInfo[clanid][gName]);
			Loop(i)
			{
				if(PlayerInfo[i][pGroupInvite][group_clan] == clanid) PlayerInfo[i][pGroupInvite] = 0;
				if(PlayerInfo[i][pGroup][group_clan] == clanid)
				{
					groupDel(clanid,i,false);
					groupLoad(i);
					SendClientMessage(i,red,fstring);
				}
			}
			format(f,sizeof(f),dir_groups "%s-%s.ini",GroupTypes[group_clan],GroupInfo[clanid][gName]);
			fremove(f);
			valstr(f,clanid);
			fsetstring(file_groups,f,"None");
			GroupInfo[clanid][gType] = group_none;
			format(GroupInfo[clanid][gName],32,"");
			GroupInfo[clanid][gMembers] = 0;
			for(new j = 0; j < MAX_GROUP_MEMBERS; j++) GroupInfo[clanid][gMember][j] = INVALID_PLAYER_ID;
			GroupInfo[clanid][gColor] = {255,255,255};
			SendFormat(playerid,green," .%s מחקת את הקלאן",cmd);
			return 1;
		}
		if(equal(cmd,"/setclan"))
		{
			new cmd2[64], id, c;
			cmd = strtok(cmdtext,idx), cmd2 = strtok(cmdtext,idx);
			if(!strlen(cmd) || !strlen(cmd2)) return SendClientMessage(playerid,white," /setclan [id/name] [clan name] :צורת השימוש");
			id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(PlayerInfo[id][pGroup][group_clan] > 0) return SendClientMessage(playerid,red," .השחקן שבחרת כבר בקלאן");
			c = gid(cmd2,group_clan);
			if(!c) return SendClientMessage(playerid,red," .קלאן שגוי");
			if(GroupInfo[c][gMembers] >= MAX_GROUP_MEMBERS) return SendClientMessage(playerid,red," .בקלאן יש כבר יותר מדי מחוברים");
			groupAdd(c,id);
			groupLoad(id);
			SendClientMessage(id,green," .האדמין שינה את הקלאן שלך");
			SendFormat(playerid,green," .%s לקלאן %s צירפת את",GroupInfo[c][gName],GetName(id));
			frmt(" .%s האדמין צירף לקלאן שלך את",GetName(id));
			for(new i = 0; i < GroupInfo[c][gMembers]; i++) if(GroupInfo[c][gMember][i] != id && GroupInfo[c][gMember][i] != playerid) SendClientMessage(GroupInfo[c][gMember][i],green,fstring);
			return 1;
		}
		if(equal(cmd,"/remclan"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /remclan [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(!PlayerInfo[id][pGroup][group_clan]) return SendClientMessage(playerid,red," .השחקן שבחרת לא בקלאן");
			new c = PlayerInfo[id][pGroup][group_clan];
			groupDel(c,id);
			groupLoad(id);
			SendFormat(id,green," .%s האדמין הוציא אותך מהקלאן",GroupInfo[c][gName]);
			SendFormat(playerid,green," .%s מהקלאן %s הוצאת את",GroupInfo[c][gName],GetName(id));
			frmt(" .%s האדמין הוציא מהקלאן שלך את",GetName(id));
			for(new i = 0; i < GroupInfo[c][gMembers]; i++) if(GroupInfo[c][gMember][i] != id && GroupInfo[c][gMember][i] != playerid) SendClientMessage(GroupInfo[c][gMember][i],green,fstring);
			return 1;
		}
		if(equal(cmd,"/setlclan"))
		{
			new cmd2[64], id;
			cmd = strtok(cmdtext,idx), cmd2 = strtok(cmdtext,idx);
			if(!strlen(cmd) || !strlen(cmd2)) return SendClientMessage(playerid,white," /setlclan [id/name] [level 1-" #MAX_CLAN_LEVEL "] :צורת השימוש");
			id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			new lvl = strval(cmd2), c = PlayerInfo[id][pGroup][group_clan];
			if(!c) return SendClientMessage(playerid,red," .השחקן שבחרת לא בקלאן");
			if(lvl < 1 || lvl > MAX_CLAN_LEVEL) return SendClientMessage(playerid,red," .רמת גישות שגויה");
			if(GroupInfo[c][gMembers] >= MAX_GROUP_MEMBERS) return SendClientMessage(playerid,red," .בקלאן יש כבר יותר מדי מחוברים");
			PlayerInfo[id][pGroupLevel][group_clan] = lvl;
			SendFormat(id,green," .ל-%d %s האדמין שינה את הרמה שלך בקלאן",lvl,GroupInfo[c][gName]);
			SendFormat(playerid,green," .ל-%d %s בקלאן %s שינית את הרמה של",lvl,GroupInfo[c][gName],GetName(id));
			frmt(" .ל-%d %s האדמין שינה את רמת הגישות בקלאן של",lvl,GetName(id));
			for(new i = 0; i < GroupInfo[c][gMembers]; i++) if(GroupInfo[c][gMember][i] != id && GroupInfo[c][gMember][i] != playerid) SendClientMessage(GroupInfo[c][gMember][i],green,fstring);
			return 1;
		}
		if(equal(cmd,"/clanname"))
		{
			new cmd2[64], c, string[64], string2[64];
			cmd = strtok(cmdtext,idx), cmd2 = strtok(cmdtext,idx);
			if(!strlen(cmd) || !strlen(cmd2)) return SendClientMessage(playerid,white," /clanname [old name] [new name] :צורת השימוש");
			c = gid(cmd,group_clan);
			if(c == -1) return SendClientMessage(playerid,red," .קלאן שגוי");
			if(strlen(cmd2) > 20) return SendClientMessage(playerid,red," .שם ארוך מדי");
			if(!IsValidName(cmd2)) return SendClientMessage(playerid,red," .חלק מהאותיות שכתבת לא יכולות להכנס לשם של קלאן");
			for(new i = 1; i < MAX_GROUPS; i++) if(equal(cmd2,GroupInfo[i][gName])) return SendClientMessage(playerid,red," .שם הקלאן כבר בשימוש");
			format(string,sizeof(string),dir_groups "%s-%s.ini",GroupTypes[group_clan],cmd);
			format(string2,sizeof(string2),dir_groups "%s-%s.ini",GroupTypes[group_clan],cmd2);
			if(!fexist(string)) return SendClientMessage(playerid,red," .צויין קלאן שגוי");
			if(fexist(string2)) return SendClientMessage(playerid,red," .הקלאן הזה כבר קיים");
			frename(string,string2);
			valstr(string2,c);
			fsetstring(file_groups,string2,cmd2);
			SendFormat(playerid,green," .%s-ל %s שינית את שם הקלאן",cmd2,GroupInfo[c][gName]);
			frmt(" .%s-ל %s-האדמין שינה את שם הקלאן שלך מ",cmd2,GroupInfo[c][gName]);
			for(new i = 0; i < GroupInfo[c][gMembers]; i++) if(GroupInfo[c][gMember][i] != playerid) SendClientMessage(GroupInfo[c][gMember][i],green,string);
			format(GroupInfo[c][gName],32,cmd2);
			return 1;
		}
		if(equal(cmd,"/loadhq"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd) || IsNumeric(cmd)) return SendClientMessage(playerid,white," /loadhq [clan name] :צורת השימוש");
			new c = gid(cmd,group_clan);
			if(!c) return SendClientMessage(playerid,red," .קלאן שגוי");
			if(GroupInfo[c][gHeadquarter]) return SendClientMessage(playerid,red," .לקלאן הזה כבר יש מפקדה");
			if(!hqLoad(c)) return SendClientMessage(playerid,red," .אין משאבי מפקדה שהועלו לקובץ הקלאן");
			SendFormatToAll(rgba2hex(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gColor][0],GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gColor][1],GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gColor][2],255)," * !%s טען את מפקדת הקלאן %s האדמין",GroupInfo[c][gName],GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/unloadhq"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd) || IsNumeric(cmd)) return SendClientMessage(playerid,white," /unloadhq [clan name] :צורת השימוש");
			new c = gid(cmd,group_clan);
			if(!c) return SendClientMessage(playerid,red," .קלאן שגוי");
			if(!GroupInfo[c][gHeadquarter]) return SendClientMessage(playerid,red," .לקלאן הזה אין מפקדה");
			hqUnload(c);
			SendFormatToAll(rgba2hex(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gColor][0],GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gColor][1],GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gColor][2],255)," * !%s הסיר את מפקדת הקלאן %s האדמין",GroupInfo[c][gName],GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/reloadhq"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd) || IsNumeric(cmd)) return SendClientMessage(playerid,white," /reloadhq [clan name] :צורת השימוש");
			new c = gid(cmd,group_clan);
			if(!c) return SendClientMessage(playerid,red," .קלאן שגוי");
			if(!GroupInfo[c][gHeadquarter]) return SendClientMessage(playerid,red," .לקלאן הזה אין מפקדה");
			hqUnload(c);
			hqLoad(c);
			SendFormatToAll(rgba2hex(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gColor][0],GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gColor][1],GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gColor][2],255)," * !%s טען מחדש את מפקדת הקלאן %s האדמין",GroupInfo[c][gName],GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/gotohq"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd) || IsNumeric(cmd)) return SendClientMessage(playerid,white," /gotohq [clan name] :צורת השימוש");
			new c = gid(cmd,group_clan);
			if(!c) return SendClientMessage(playerid,red," .קלאן שגוי");
			if(!GroupInfo[c][gHeadquarter]) return SendClientMessage(playerid,red," .לקלאן הזה אין מפקדה");
			hqGoto(playerid,c);
			return 1;
		}
		if(equal(cmd,"/createcrew"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /createcrew [crew name] :צורת השימוש");
			if(strlen(cmd) > 20) return SendClientMessage(playerid,red," .שם ארוך מדי");
			if(!IsValidName(cmd)) return SendClientMessage(playerid,red," .חלק מהאותיות שכתבת לא יכולות להכנס לשם של קרו");
			for(new i = 1; i < MAX_GROUPS; i++) if(equal(cmd,GroupInfo[i][gName])) return SendClientMessage(playerid,red," .שם קרו כבר בשימוש");
			format(fstring,sizeof(fstring),dir_groups "%s-%s.ini",GroupTypes[group_crew],cmd);
			if(fexist(fstring)) return SendClientMessage(playerid,red," .הקרו הזה כבר קיים");
			new crewid = GetEmptyGroupID(), num[8];
			if(crewid == -1) return SendClientMessage(playerid,red," .(לא ניתן ליצור קרויים (כמות גבוהה מדי");
			fcreate(fstring);
			fsetint(fstring,"ID",crewid);
			fsetint(fstring,"R",255);
			fsetint(fstring,"G",255);
			fsetint(fstring,"B",255);
			format(GroupInfo[crewid][gName],32,cmd);
			GroupInfo[crewid][gMembers] = 0;
			for(new j = 0; j < MAX_GROUP_MEMBERS; j++) GroupInfo[crewid][gMember][j] = INVALID_PLAYER_ID;
			GroupInfo[crewid][gType] = group_crew;
			GroupInfo[crewid][gColor] = {255,255,255};
			new c = fgetint(file_groups,"#Count");
			if(crewid == fgetint(file_groups,"#Count") || !c) fsetint(file_groups,"#Count",c+1);
			valstr(num,crewid);
			fsetstring(file_groups,num,cmd);
			SendFormat(playerid,green," .מספר הקבוצה: %d ,%s יצרת את הקרו",crewid,cmd);
			return 1;
		}
		if(equal(cmd,"/deletecrew"))
		{
			new crewid, f[64];
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /deletecrew [crew name] :צורת השימוש");
			crewid = gid(cmd,group_crew);
			if(!crewid || GroupInfo[crewid][gType] != group_crew) return SendClientMessage(playerid,red," .קרו שגוי");
			frmt(" .%s ,האדמין מחק את הקרו שלך",GroupInfo[crewid][gName]);
			Loop(i)
			{
				if(PlayerInfo[i][pGroupInvite][group_crew] == crewid) PlayerInfo[i][pGroupInvite] = 0;
				if(PlayerInfo[i][pGroup][group_crew] == crewid)
				{
					groupDel(crewid,i,false);
					groupLoad(i);
					SendClientMessage(i,red,fstring);
				}
			}
			format(f,sizeof(f),dir_groups "%s-%s.ini",GroupTypes[group_crew],GroupInfo[crewid][gName]);
			fremove(f);
			valstr(f,crewid);
			fsetstring(file_groups,f,"None");
			format(GroupInfo[crewid][gName],32,"");
			GroupInfo[crewid][gMembers] = 0;
			for(new j = 0; j < MAX_GROUP_MEMBERS; j++) GroupInfo[crewid][gMember][j] = INVALID_PLAYER_ID;
			GroupInfo[crewid][gType] = group_none;
			GroupInfo[crewid][gColor] = {255,255,255};
			SendFormat(playerid,green," .%s מחקת את הקרו",cmd);
			return 1;
		}
		if(equal(cmd,"/setcrew"))
		{
			new cmd2[64], id, c;
			cmd = strtok(cmdtext,idx), cmd2 = strtok(cmdtext,idx);
			if(!strlen(cmd) || !strlen(cmd2)) return SendClientMessage(playerid,white," /setcrew [id/name] [crew name] :צורת השימוש");
			id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(PlayerInfo[id][pGroup][group_crew] > 0) return SendClientMessage(playerid,red," .השחקן שבחרת כבר בקרו");
			c = gid(cmd2,group_crew);
			if(!c) return SendClientMessage(playerid,red," .קרו שגוי");
			if(GroupInfo[c][gMembers] >= MAX_GROUP_MEMBERS) return SendClientMessage(playerid,red," .בקרו יש כבר יותר מדי מחוברים");
			groupAdd(c,id);
			groupLoad(id);
			SendClientMessage(id,green," .האדמין שינה את הקלאן שלך");
			SendFormat(playerid,green," .%s לקרו %s צירפת את",GroupInfo[c][gName],GetName(id));
			frmt(" .%s האדמין צירף לקרו שלך את",GetName(id));
			for(new i = 0; i < GroupInfo[c][gMembers]; i++) if(GroupInfo[c][gMember][i] != id && GroupInfo[c][gMember][i] != playerid) SendClientMessage(GroupInfo[c][gMember][i],green,fstring);
			return 1;
		}
		if(equal(cmd,"/remcrew"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /remcrew [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(!PlayerInfo[id][pGroup][group_crew]) return SendClientMessage(playerid,red," .השחקן שבחרת לא בקרו");
			new c = PlayerInfo[id][pGroup][group_crew];
			groupDel(c,id);
			groupLoad(id);
			SendFormat(id,green," .%s האדמין הוציא אותך מהקרו",GroupInfo[c][gName]);
			SendFormat(playerid,green," .%s מהקרו %s הוצאת את",GroupInfo[c][gName],GetName(id));
			frmt(" .%s האדמין הוציא מהקרו שלך את",GetName(id));
			for(new i = 0; i < GroupInfo[c][gMembers]; i++) if(GroupInfo[c][gMember][i] != id && GroupInfo[c][gMember][i] != playerid) SendClientMessage(GroupInfo[c][gMember][i],green,fstring);
			return 1;
		}
		if(equal(cmd,"/setlcrew"))
		{
			new cmd2[64], id;
			cmd = strtok(cmdtext,idx), cmd2 = strtok(cmdtext,idx);
			if(!strlen(cmd) || !strlen(cmd2)) return SendClientMessage(playerid,white," /setlcrew [id/name] [level 1-" #MAX_CREW_LEVEL "] :צורת השימוש");
			id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			new lvl = strval(cmd2), c = PlayerInfo[id][pGroup][group_crew];
			if(!c) return SendClientMessage(playerid,red," .השחקן שבחרת לא בקרו");
			if(lvl < 1 || lvl > MAX_CREW_LEVEL) return SendClientMessage(playerid,red," .רמת גישות שגויה");
			if(GroupInfo[c][gMembers] >= MAX_GROUP_MEMBERS) return SendClientMessage(playerid,red," .בקרו יש כבר יותר מדי מחוברים");
			PlayerInfo[id][pGroupLevel][group_crew] = lvl;
			SendFormat(id,green," .ל-%d %s האדמין שינה את הרמה שלך בקרו",lvl,GroupInfo[c][gName]);
			SendFormat(playerid,green," .ל-%d %s בקרו %s שינית את הרמה של",lvl,GroupInfo[c][gName],GetName(id));
			frmt(" .ל-%d %s האדמין שינה את רמת הגישות בקרו של",lvl,GetName(id));
			for(new i = 0; i < GroupInfo[c][gMembers]; i++) if(GroupInfo[c][gMember][i] != id && GroupInfo[c][gMember][i] != playerid) SendClientMessage(GroupInfo[c][gMember][i],green,fstring);
			return 1;
		}
		if(equal(cmd,"/crewname"))
		{
			new cmd2[64], c, string[64], string2[64];
			cmd = strtok(cmdtext,idx), cmd2 = strtok(cmdtext,idx);
			if(!strlen(cmd) || !strlen(cmd2)) return SendClientMessage(playerid,white," /crewname [old name] [new name] :צורת השימוש");
			c = gid(cmd,group_crew);
			if(c == -1) return SendClientMessage(playerid,red," .קרו שגוי");
			if(strlen(cmd2) > 20) return SendClientMessage(playerid,red," .שם ארוך מדי");
			if(!IsValidName(cmd2)) return SendClientMessage(playerid,red," .חלק מהאותיות שכתבת לא יכולות להכנס לשם של קרו");
			for(new i = 1; i < MAX_GROUPS; i++) if(equal(cmd2,GroupInfo[i][gName])) return SendClientMessage(playerid,red," .שם קרו כבר בשימוש");
			format(string,sizeof(string),dir_groups "%s-%s.ini",GroupTypes[group_crew],cmd);
			format(string2,sizeof(string2),dir_groups "%s-%s.ini",GroupTypes[group_crew],cmd2);
			if(!fexist(string)) return SendClientMessage(playerid,red," .צויין קרו שגוי");
			if(fexist(string2)) return SendClientMessage(playerid,red," .הקרו הזה כבר קיים");
			frename(string,string2);
			valstr(string2,c);
			fsetstring(file_groups,string2,cmd2);
			SendFormat(playerid,green," .%s-ל %s שינית את שם הקרו",cmd2,GroupInfo[c][gName]);
			frmt(" .%s-ל %s-האדמין שינה את שם הקרו שלך מ",cmd2,GroupInfo[c][gName]);
			for(new i = 0; i < GroupInfo[c][gMembers]; i++) if(GroupInfo[c][gMember][i] != playerid) SendClientMessage(GroupInfo[c][gMember][i],green,string);
			format(GroupInfo[c][gName],32,cmd2);
			return 1;
		}
		if(equal(cmd,"/inv"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /inv [on/off] :צורת השימוש");
			new bool:result = equal(cmd,"on");
			if(result)
			{
				if(PlayerInfo[playerid][pAdminInv]) return SendClientMessage(playerid,red," .אתה כבר במצב בלתי נראה");
				SetPlayerColor2(playerid,0xFFFFFF00);
				PlayerInfo[playerid][pAdminInv] = true;
			}
			else
			{
				if(!PlayerInfo[playerid][pAdminInv]) return SendClientMessage(playerid,red," .אתה לא במצב בלתי נראה");
				SetPlayerColor2(playerid,PlayerInfo[playerid][pColor]);
				PlayerInfo[playerid][pAdminInv] = false;
			}
			PlaySound(playerid,1057);
			SendClientMessage(playerid,result ? green : red,result ? (" .מצב בלתי נראה במפה הופעל") : (" .מצב בלתי נראה במפה הופסק"));
			return 1;
		}
		if(equal(cmd,"/say"))
		{
			cmd = strrest(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /say [text] :צורת השימוש");
			SendFormatToAll(0x2585C2FF,"* Admin: %s",cmd);
			return 1;
		}
		if(equal(cmd,"/asay"))
		{
			cmd = strrest(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /asay [text] :צורת השימוש");
			SendFormatToAll(0x2585C2FF,"* Admin %s: %s",GetName(playerid),cmd);
			return 1;
		}
		if(equal(cmd,"/freeze"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /freeze [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			Freeze(id,PlayerInfo[id][pFrozen] = true);
			SendFormatToAll(white," * %s has been frozen by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/unfreeze"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /unfreeze [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			Freeze(id,PlayerInfo[id][pFrozen] = false);
			SendFormatToAll(white," * %s has been unfrozen by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/mute"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /mute [id/name] [seconds] [reason] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(PlayerInfo[id][pMute] > 0) return SendClientMessage(playerid,red," .משתמש זה כבר במיוט");
			cmd = strtok(cmdtext,idx);
			new time = strval(cmd);
			if(time < 1 || time > 99999) return SendClientMessage(playerid,red," .זמן שגוי");
			cmd = strrest(cmdtext,idx);
			if(!strlen(cmd)) cmd = "לא צוינה סיבה";
			PlayerInfo[id][pMute] = time;
			SendFormatToAll(white," * %s has been muted by %s for %d seconds (%s)",GetName(id),GetName(playerid),time,cmd);
			return 1;
		}
		if(equal(cmd,"/unmute"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /unmute [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(!PlayerInfo[id][pMute]) return SendClientMessage(playerid,red," .משתמש זה לא במיוט");
			PlayerInfo[id][pMute] = 0;
			SendFormatToAll(white," * %s has been unmuted by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/jail"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /jail [id/name] [seconds] [reason] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(PlayerInfo[id][pJail] > 0) return SendClientMessage(playerid,red," .משתמש זה כבר בכלא");
			cmd = strtok(cmdtext,idx);
			new time = strval(cmd);
			if(time < 1 || time > 99999) return SendClientMessage(playerid,red," .זמן שגוי");
			cmd = strrest(cmdtext,idx);
			if(!strlen(cmd)) cmd = "לא צוינה סיבה";
			PlayerInfo[id][pJail] = time;
			SetPlayerPos(id,264.3591,77.5832,1001.0391);
			SetPlayerFacingAngle(id,270.0);
			SetCameraBehindPlayer(id);
			SetPlayerInterior(id,6);
			Freeze(id,true);
			SendFormatToAll(white," * %s has been jailed by %s for %d seconds (%s)",GetName(id),GetName(playerid),time,cmd);
			return 1;
		}
		if(equal(cmd,"/unjail"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /unjail [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(!PlayerInfo[id][pJail]) return SendClientMessage(playerid,red," .משתמש זה לא בכלא");
			PlayerInfo[id][pJail] = 0;
			SpawnPlayer(id);
			SendFormatToAll(white," * %s has been unjailed by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/disarm"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /disarm [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			ResetWeapons(id);
			SendFormatToAll(white," * %s has been disarmed by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/aeject"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /aeject [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid,red," .שחקן זה אינו ברכב");
			RemovePlayerFromVehicle(id);
			SendFormatToAll(white," * %s has been ejected by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/settime"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /settime [hour/default] :צורת השימוש");
			new h = equal(cmd,"default") ? ServerConfig[cfgDefaultTime] : strval(cmd);
			if(!IsNumeric(cmd) || h < 0 || h > 23) return SendClientMessage(playerid,red," .שעה שגויה");
			SetWorldTime(h);
			Loop(i) SetPlayerTime(i,h,0);
			SendFormatToAll(white," * %02d:00-שינה את השעה ל %s האדמין",h,GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/setwea"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setwea [weather/default] :צורת השימוש");
			new w = equal(cmd,"default") ? ServerConfig[cfgDefaultWeather] : strval(cmd);
			if(!IsNumeric(cmd) || w < 0 || w > 50) return SendClientMessage(playerid,red," .מזג אויר שגוי");
			SetWeather(w);
			Loop(i) SetPlayerWeather(i,w);
			SendFormatToAll(white," * שינה את מזג האויר ל-%d %s האדמין",w,GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/goto"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /goto [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid), Float:p[3];
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(PlayerInfo[id][pWorld] != PlayerInfo[playerid][pWorld]) return SendClientMessage(playerid,red," .שחקן זה לא נמצא בעולם שלך ולכן לא ניתן להשתמש עליו בפקודה זו");
			GetPlayerPos(id,p[0],p[1],p[2]);
			GetXYInFrontOfPlayer(id,p[0],p[1],3.0);
			if(IsPlayerInAnyVehicle(playerid))
			{
				new v = GetPlayerVehicleID(playerid);
				SetVehiclePos(v,p[0],p[1],p[2]+3.0);
				LinkVehicleToInterior(v,GetPlayerInterior(id));
				SetVehicleVirtualWorld(v,GetPlayerVirtualWorld(id));
			}
			else SetPlayerPos(playerid,p[0],p[1],p[2]+3.0);
			SetPlayerInterior(playerid,GetPlayerInterior(id));
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id));
			SendFormat(playerid,green," * %s השתגרת אל",GetName(id));
			SendClientMessage(id,green," * האדמין השתגר אליך");
			return 1;
		}
		if(equal(cmd,"/get"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /get [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid), Float:p[3];
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(PlayerInfo[id][pWorld] != PlayerInfo[playerid][pWorld]) return SendClientMessage(playerid,red," .שחקן זה לא נמצא בעולם שלך ולכן לא ניתן להשתמש עליו בפקודה זו");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			GetPlayerPos(playerid,p[0],p[1],p[2]);
			GetXYInFrontOfPlayer(playerid,p[0],p[1],3.0);
			SetPlayerPos(id,p[0],p[1],p[2]);
			SetPlayerInterior(id,GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(id,GetPlayerVirtualWorld(playerid));
			SendFormat(playerid,green," * %s שיגרת את",GetName(id));
			SendClientMessage(id,green," * האדמין שיגר אותך אליו");
			return 1;
		}
		if(equal(cmd,"/getc"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /getc [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid), Float:p[3];
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(PlayerInfo[id][pWorld] != PlayerInfo[playerid][pWorld]) return SendClientMessage(playerid,red," .שחקן זה לא נמצא בעולם שלך ולכן לא ניתן להשתמש עליו בפקודה זו");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid,red," .המשתמש לא ברכב");
			GetPlayerPos(playerid,p[0],p[1],p[2]);
			GetXYInFrontOfPlayer(playerid,p[0],p[1],3.0);
			new v = GetPlayerVehicleID(id);
			SetVehiclePos(v,p[0],p[1],p[2]);
			SetPlayerInterior(id,GetPlayerInterior(playerid));
			LinkVehicleToInterior(v,GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(id,GetPlayerVirtualWorld(playerid));
			SetVehicleVirtualWorld(v,GetPlayerVirtualWorld(playerid));
			SendFormat(playerid,green," * %s שיגרת את",GetName(id));
			SendClientMessage(id,green," * האדמין שיגר אותך אליו");
			return 1;
		}
		if(equal(cmd,"/cc"))
		{
			frmt(" .ניקה את כל הצ'אטים %s האדמין",GetName(playerid));
			Loop(i)
			{
				if(!PlayerInfo[i][pAdmin]) for(new c = 0; c < 120; c++) SendClientMessage(i,white," ");
				SendClientMessage(i,white,fstring);
			}
			return 1;
		}
		if(equal(cmd,"/cl"))
		{
			frmt(" [%s] .ניקה את הצ'אט %s האדמין",ChatInfo[PlayerInfo[playerid][pChat]][chName],GetName(playerid));
			Loop(i) if(PlayerInfo[i][pChat] == PlayerInfo[playerid][pChat])
			{
				if(!PlayerInfo[i][pAdmin]) for(new c = 0; c < 120; c++) SendClientMessage(i,white," ");
				SendClientMessage(i,white,fstring);
			}
			return 1;
		}
		if(equal(cmd,"/explode"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /explode [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid), Float:p[3];
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			GetPlayerPos(id,p[0],p[1],p[2]);
			CreateExplosion(p[0],p[1],p[2],6,0.0);
			SendFormatToAll(white," * %s has been exploded by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/pexplode"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /pexplode [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid), Float:p[3];
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			GetPlayerPos(id,p[0],p[1],p[2]);
			CreateExplosionForPlayer(id,p[0],p[1],p[2],6,0.0);
			SendFormatToAll(white," * %s has been exploded by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/togcmd"))
		{
			PlayerInfo[playerid][pToggle][0] = !PlayerInfo[playerid][pToggle][0];
			SendClientMessage(playerid,PlayerInfo[playerid][pToggle][0] ? green : red,PlayerInfo[playerid][pToggle][0] ? (" * מצב צפייה בפקודות הופעל") : (" * מצב צפייה בפקודות כובה"));
			PlaySound(playerid,1057);
			return 1;
		}
		if(equal(cmd,"/togpm"))
		{
			PlayerInfo[playerid][pToggle][1] = !PlayerInfo[playerid][pToggle][1];
			SendClientMessage(playerid,PlayerInfo[playerid][pToggle][1] ? green : red,PlayerInfo[playerid][pToggle][1] ? (" * מצב צפייה בהודעות פרטיות הופעל") : (" * מצב צפייה בהודעות פרטיות כובה"));
			PlaySound(playerid,1057);
			return 1;
		}
		if(equal(cmd,"/akill"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /akill [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			SetPlayerHealth(id,0.0);
			SendFormatToAll(white," * %s has been killed by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/respawn"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /respawn [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			SpawnPlayer(id);
			SendFormatToAll(white," * %s has been respawned by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/ajetpack"))
		{
			cmd = strtok(cmdtext,idx);
			new id = !strlen(cmd) ? playerid : ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) return SendClientMessage(playerid,red," .כבר יש לך תיק סילון");
			else if(GetPlayerSpecialAction(id) == SPECIAL_ACTION_USEJETPACK) return SendClientMessage(playerid,red," .כבר יש למשתמש זה תיק סילון");
			SetPlayerSpecialAction(id,SPECIAL_ACTION_USEJETPACK);
			return 1;
		}
		if(equal(cmd,"/sworld"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /sworld [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(PlayerInfo[id][pConnectStage] <= ct_selectworld) return SendClientMessage(playerid,red," .משתמש זה כבר נמצא בבחירת עולם");
			SwitchWorld(id);
			SendFormatToAll(white," * %s has been forced to switch world by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/spec"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /spec [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(id == playerid) return SendClientMessage(playerid,red," .אין באפשרותך לבצע את הפקודה הזו על עצמך");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			PlayerInfo[playerid][pSpectate] = id;
	 		SetPlayerInterior(playerid,GetPlayerInterior(id));
	 		SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id));
	 		TogglePlayerSpectating(playerid,1);
	 		if(IsPlayerInAnyVehicle(id)) PlayerSpectateVehicle(playerid,GetPlayerVehicleID(id));
	 		else PlayerSpectatePlayer(playerid,id);
			SendFormat(playerid,green," * %s התחלת מעקב אחרי",GetName(id));
			return 1;
		}
		if(equal(cmd,"/specoff"))
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) return SendClientMessage(playerid,red," .אתה לא במעקב");
			PlayerInfo[playerid][pSpectate] = INVALID_PLAYER_ID;
			TogglePlayerSpectating(playerid,0);
			SpawnPlayer(playerid);
			SendClientMessage(playerid,green," * יצאת מהמעקב");
			return 1;
		}
		if(equal(cmd,"/slap") || equal(cmd,"/sislap"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white,cmdtext[2] == 'i' ? (" /sislap [id/name] :צורת השימוש") : (" /slap [id/name] :צורת השימוש"));
			new id = ReturnUser(cmd,playerid), Float:v[3];
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			GetPlayerVelocity(id,v[0],v[1],v[2]);
			SetPlayerVelocity(id,v[0],v[1],2.0);
			PlaySound(playerid,1190);
			PlaySound(id,1190);
			if(cmdtext[2] != 'i') SendFormatToAll(white," * %s has been slapped by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/getbank"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /getbank [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(!PlayerInfo[id][pLogged]) return SendClientMessage(playerid,red," .על השחקן להתחבר למשתמש קודם");
			SendFormat(playerid,yellow," * היא $%d (DM-בעולם ה) %s-כמות הכסף שיש ל",PlayerInfo[id][pBank],GetName(id));
			return 1;
		}
		if(equal(cmd,"/kick"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /kick [id/name] [reason] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strrest(cmdtext,idx);
			if(!strlen(cmd)) cmd = "לא צוינה סיבה";
			SetKick(id,playerid,cmd);
			return 1;
		}
		if(equal(cmd,"/ban"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /ban [id/name] [reason] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(fexist(frmt(dir_bans "%s.ini",GetIP(id)))) return SendClientMessage(playerid,red," .כתובת האייפי הזו כבר בבאן");
			cmd = strrest(cmdtext,idx);
			if(!strlen(cmd)) cmd = "לא צוינה סיבה";
			SetBan(GetIP(id),playerid,cmd,id);
			return 1;
		}
		if(equal(cmd,"/b"))
		{
			new string[M_S];
			if(!IsPlayerConnected(lastB) || lastB == INVALID_PLAYER_ID) return SendClientMessage(playerid,red," .אין אדם אחרון לבאן מהיר");
			if(PlayerInfo[lastB][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			switch(lastBType)
			{
				case 1: format(string,sizeof(string),"/ban %d פרסום שרתים",lastB);
			}
			OnPlayerCommandText(playerid,string);
			return 1;
		}
		if(equal(cmd,"/aadv"))
		{
			new string[M_S];
			if(!IsPlayerConnected(lastB) || lastBType != 1) return SendClientMessage(playerid,red," .המפרסם האחרון התנתק או שההודעה כבר אושרה");
			format(string,sizeof(string)," .אישר את ההודעה שלך %s האדמין",GetName(playerid));
			SendClientMessage(lastB,green,string);
			format(string,sizeof(string)," .%s אישרת את ההודעה של",GetName(lastB));
			SendClientMessage(playerid,green,string);
			advAccess = 1;
			if(lastAdvMessage[0] == '/') OnPlayerCommandText(lastB,lastAdvMessage);
			else OnPlayerText(lastB,lastAdvMessage);
			advAccess = 0, lastB = INVALID_PLAYER_ID, lastBType = 0, lastAdvMessage = "";
			return 1;
		}
		if(equal(cmd,"/banip"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /banip [ip] [reason] :צורת השימוש");
			new ip[16];
			format(ip,sizeof(ip),cmd);
			if(fexist(frmt(dir_bans "%s.ini",ip))) return SendClientMessage(playerid,red," .כתובת האייפי הזו כבר בבאן");
			cmd = strrest(cmdtext,idx);
			if(!strlen(cmd)) cmd = "לא צוינה סיבה";
			SetBan(ip,playerid,cmd);
			SendFormat(playerid,green," .כתובת האייפי %s הושעתה מהשרת",ip);
			return 1;
		}
		if(equal(cmd,"/unban"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /unban [name/ip] :צורת השימוש");
			new f[32];
			if(fkeyexist(file_bans,cmd))
			{
				format(f,sizeof(f),dir_bans "%s.ini",fgetstring(file_bans,cmd));
				if(fexist(f)) fremove(f);
				fremovekey(file_bans,cmd);
				SendFormat(playerid,green," .%s-ירדה ההשעיה ל",cmd);
				SendFormatToAll(0xFF0000FF," * %s has been unbanned by %s",cmd,GetName(playerid));
			}
			else
			{
				format(f,sizeof(f),dir_bans "%s.ini",cmd);
				if(fexist(f))
				{
					fremove(f);
					SendFormat(playerid,green," .ירדה ההשעיה לכתובת האייפי %s",cmd);
				}
				else return SendClientMessage(playerid,red," .לא נמצא באן בשם / אייפי שהקלדת");
			}
			return 1;
		}
		if(equal(cmd,"/baninfo"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /baninfo [ip] :צורת השימוש");
			new ff[32];
			format(ff,sizeof(ff),dir_bans "%s.ini",cmd);
			if(!fexist(ff)) return SendClientMessage(playerid,red," .כתובת האייפי הזו לא בבאן");
			SendFormat(playerid,lightblue," ~~~ :%s פרטי ההשעיה לכתובת ~~~",cmd);
			new keys[][16] = {"PlayerName","PlayerIP","AdminName","Reason","Date","Time"};
			for(new i = 0; i < sizeof(keys); i++) if(fkeyexist(ff,keys[i])) SendFormat(playerid,grey," - %s: %s",keys[i],fgetstring(ff,keys[i]));
			return 1;
		}
		if(equal(cmd,"/actout"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /actout [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(!WorldInfo[PlayerInfo[id][pWorld]][wActivity][0]) return SendClientMessage(playerid,red," .אין פעילות בעולם בו שחקן זה נמצא");
			if(!PlayerInfo[id][pInActivity]) return SendClientMessage(playerid,red," .שחקן זה לא בפעילות");
			LeaveActivity(id);
			SendFormatToAll(white," * %s has been removed from the activity by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/resetmoney"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /resetmoney [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			ResetMoney(id);
			SendFormatToAll(white," * %s's money has been reseted by %s",GetName(id),GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/details"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /details [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			SendFormat(playerid,white,"%s's details:",GetName(id));
			SendFormat(playerid,grey," - IP: %s",GetIP(id));
			SendFormat(playerid,grey," - Ping: %d",GetPlayerPing(id));
			SendFormat(playerid,grey," - Money: $%d ($%d?)",GetMoney(id),GetPlayerMoney(id));
			return 1;
		}
		if(equal(cmd,"/unlockall") || equal(cmd,"/resetvehicles") || equal(cmd,"/fixall"))
		{
			new failed = 0, opt[16];
			if(equal(cmd,"/unlockall")) opt = "Unlock";
			else if(equal(cmd,"/resetvehicles")) opt = "Respawn";
			else if(equal(cmd,"/fixall")) opt = "Fix";
			new bool:vEmpty[MAX_VEHICLES] = {true,...};
			Loop(i) if(IsPlayerInAnyVehicle(i)) vEmpty[GetPlayerVehicleID(i)] = false;
			for(new v = 0; v < MAX_VEHICLES; v++)
			{
				if(VehicleInfo[v][vValid])
				{
					switch(opt[0])
					{
						case 'U':
						{
							Loop(i) SetVehicleParamsForPlayer(v,i,0,0);
							VehicleInfo[v][vLocked] = false;
						}
						case 'R': if(vEmpty[v]) SetVehicleToRespawn(v);
						case 'F': RepairVehicle(v);
					}
					failed = 0;
				}
				else
				{
					failed++;
					if(failed >= 50) break;
				}
			}
			SendFormatToAll(yellow," * %s :ביצע את הפעולה הבאה לכל הרכבים בשרת %s האדמין",opt,GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/full"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /full [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			SetPlayerHealth(id,100.0);
			SetPlayerArmour(id,100.0);
			SendFormat(playerid,green," .%s מילאת את החיים והמגן של",GetName(id));
			SendClientMessage(id,green," .האדמין מילא את החיים והמגן שלך");
			return 1;
		}
		if(equal(cmd,"/giveweapon"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /giveweapon [id/name] [weaponid] [ammo] :צורת השימוש");
			new id = ReturnUser(cmd,playerid), weaponid, ammo;
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /giveweapon [id/name] [weaponid] [ammo] :צורת השימוש");
			weaponid = IsNumeric(cmd) ? strval(cmd) : GetWeaponIDFromName(cmd), cmd = strtok(cmdtext,idx), ammo = !strlen(cmd) ? 99999 : strval(cmd);
			if(weaponid < 0 || weaponid > 46) return SendClientMessage(playerid,red," .נשק שגוי");
			if(ammo < 0 || ammo > 99999) return SendClientMessage(playerid,red," .כמות כדורים שגויה");
			GiveWeapon(id,weaponid,ammo);
			SendFormat(playerid,green," .עם %d כדורים %s את הנשק %s-הבאת ל",ammo,WeaponName(weaponid),GetName(id));
			SendFormat(id,green," .עם %d כדורים %s האדמין הביא לך את הנשק",ammo,WeaponName(weaponid));
			return 1;
		}
		if(equal(cmd,"/sethealth"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /sethealth [id/name] [health] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /sethealth [id/name] [health] :צורת השימוש");
			new Float:h = floatstr(cmd);
			SetPlayerHealth(id,h);
			SendFormat(playerid,green," .ל-%.0f %s שינית את החיים של",h,GetName(id));
			SendFormat(id,green," .האדמין שינה את החיים שלך ל-%.0f",h);
			return 1;
		}
		if(equal(cmd,"/setarmour"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setarmour [id/name] [armour] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setarmour [id/name] [armour] :צורת השימוש");
			new Float:a = floatstr(cmd);
			SetPlayerArmour(id,a);
			SendFormat(playerid,green," .ל-%.0f %s שינית את המגן של",a,GetName(id));
			SendFormat(id,green," .האדמין שינה את המגן שלך ל-%.0f",a);
			return 1;
		}
		if(equal(cmd,"/setvhealth"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setvhealth [id/name] [health] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid,red," .שחקן זה לא ברכב");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setvhealth [id/name] [health] :צורת השימוש");
			new Float:h = floatstr(cmd);
			SetVehicleHealth(GetPlayerVehicleID(id),h);
			SendFormat(playerid,green," .ל-%.0f %s שינית את החיים של הרכב של",h,GetName(id));
			SendFormat(id,green," .האדמין שינה את החיים של הרכב שלך ל-%.0f",h);
			return 1;
		}
		if(equal(cmd,"/setcolor"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setcolor [id/name] [r g b a] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			new rgba[4] = {0,0,0,255};
			for(new i = 0; i < 4; i++) cmd = strtok(cmdtext,idx), rgba[i] = !strlen(cmd) ? (!i || i == 3 ? 255 : rgba[i-1]) : strval(cmd);
			new col = rgba2hex(rgba[0],rgba[1],rgba[2],rgba[3]);
			SetPlayerColor2(id,col);
			SendFormat(playerid,col," .לצבע ההודעה הזו %s שינית את הצבע של",GetName(id));
			SendClientMessage(id,col," .האדמין שינה את הצבע שלך לצבע ההודעה הזו");
			return 1;
		}
		if(equal(cmd,"/setvcolor"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setvcolor [id/name] [color 1] [color 2] :צורת השימוש");
			new id = ReturnUser(cmd,playerid), c[2] = {-1,-1};
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid,red," .שחקן זה לא ברכב");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setvcolor [id/name] [color 1] [color 2] :צורת השימוש");
			c[0] = strval(cmd), cmd = strtok(cmdtext,idx), c[1] = !strlen(cmd) ? c[0] : strval(cmd);
			ChangeVehicleColor(GetPlayerVehicleID(id),c[0],c[1]);
			SendFormat(playerid,green," .לצבעים %d & %d %s שינית את צבע הרכב של",c[0],c[1],GetName(id));
			SendFormat(id,green," .האדמין שינה את צבע הרכב שלך לצבעים %d & %d",c[0],c[1]);
			return 1;
		}
		if(equal(cmd,"/setvpaintjob"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setvpaintjob [id/name] [paintjob] :צורת השימוש");
			new id = ReturnUser(cmd,playerid), pj;
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid,red," .שחקן זה לא ברכב");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setvpaintjob [id/name] [paintjob] :צורת השימוש");
			pj = strval(cmd);
			ChangeVehiclePaintjob(GetPlayerVehicleID(id),pj);
			SendFormat(playerid,green," .לפיינטג'וב %d %s שינית את צבע הרכב של",pj,GetName(id));
			SendFormat(id,green," .האדמין שינה את צבע הרכב שלך לפיינטג'וב %d",pj);
			return 1;
		}
		if(equal(cmd,"/setskin"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setskin [id/name] [skin id] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setskin [id/name] [skin id] :צורת השימוש");
			new s = strval(cmd);
			if(!IsValidSkin(s)) return SendClientMessage(playerid,red," .סקין שגוי");
			SetPlayerSkin(id,s);
			SendFormat(playerid,green," .ל-%d %s שינית את הסקין של",s,GetName(id));
			SendFormat(id,green," .האדמין שינה את הסקין שלך ל-%d",s);
			return 1;
		}
		if(equal(cmd,"/setpos"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setpos [id/name] [x] [y] [z] :צורת השימוש");
			new id = ReturnUser(cmd,playerid), Float:p[4];
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			for(new i = 0; i < 4; i++)
			{
				cmd = strtok2(cmdtext,idx,' ',',');
				if(!strlen(cmd) && i != 3) return SendClientMessage(playerid,white," /setpos [id/name] [x] [y] [z] :צורת השימוש");
				p[i] = floatstr(cmd);
			}
			SetPlayerPos(id,p[0],p[1],p[2]);
			if(p[3] != 0.0) SetPlayerFacingAngle(playerid,p[3]);
			SendFormat(playerid,green," .%s שינית את המיקום של",GetName(id));
			SendClientMessage(id,green," .האדמין שינה את המיקום שלך");
			return 1;
		}
		if(equal(cmd,"/getpos"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /getpos [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid), Float:p[3];
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			GetPlayerPos(id,p[0],p[1],p[2]);
			SendFormat(playerid,green," .הוא %.4f,%.4f,%.4f %s המיקום של",p[2],p[1],p[0],GetName(id));
			return 1;
		}
		if(equal(cmd,"/angle"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /angle [facing angle] :צורת השימוש");
			new Float:a = floatstr(cmd);
			SetPlayerFacingAngle(playerid,a);
			SendFormat(playerid,green," .שינית את הזוית של עצמך ל-%.1f",a);
			return 1;
		}
		if(equal(cmd,"/pfix"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /pfix [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid,red," .שחקן זה לא ברכב");
			RepairVehicle(GetPlayerVehicleID(id));
			PlaySound(playerid,1133);
			PlaySound(id,1133);
			SendFormat(playerid,green," .%s תיקנת את הרכב של",GetName(id));
			SendClientMessage(id,green," .האדמין תיקן את הרכב שלך");
			return 1;
		}
		if(equal(cmd,"/smark"))
		{
			GetPlayerPos(playerid,PlayerInfo[playerid][pMark][0],PlayerInfo[playerid][pMark][1],PlayerInfo[playerid][pMark][2]);
			GetPlayerFacingAngle(playerid,PlayerInfo[playerid][pMark][3]);
			PlayerInfo[playerid][pMark2] = GetPlayerInterior(playerid);
			SetPlayerMapIcon(playerid,icon_mark,PlayerInfo[playerid][pMark][0],PlayerInfo[playerid][pMark][1],PlayerInfo[playerid][pMark][2],35,0);
			return 1;
		}
		if(equal(cmd,"/gmark"))
		{
			if(PlayerInfo[playerid][pMark2] == -1) return SendClientMessage(playerid,red," .אין לך מיקום שמור");
			SetPlayerPos(playerid,PlayerInfo[playerid][pMark][0],PlayerInfo[playerid][pMark][1],PlayerInfo[playerid][pMark][2]);
			SetPlayerFacingAngle(playerid,PlayerInfo[playerid][pMark][3]);
			SetPlayerInterior(playerid,PlayerInfo[playerid][pMark2]);
			return 1;
		}
		if(equal(cmd,"/rmark"))
		{
			PlayerInfo[playerid][pMark2] = -1;
			RemovePlayerMapIcon(playerid,icon_mark);
			return 1;
		}
		if(equal(cmd,"/nocmd"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /nocmd [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			PlayerInfo[id][pNoCMD] = !PlayerInfo[id][pNoCMD];
			SendFormat(playerid,green,PlayerInfo[id][pNoCMD] ? (" .%s-ירדה הגישה לפקודות ל") : (" .%s-חזרה הגישה לפקודות ל"),GetName(id));
			SendClientMessage(id,green,PlayerInfo[id][pNoCMD] ? (" .האדמין הוריד לך את הגישה לפקודות") : (" .האדמין החזיר לך את הגישה לפקודות"));
			return 1;
		}
		if(equal(cmd,"/nopm"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /nopm [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			PlayerInfo[id][pNoPM] = !PlayerInfo[id][pNoPM];
			SendFormat(playerid,green,PlayerInfo[id][pNoPM] ? (" .%s-ירדה הגישה לפיאמים ל") : (" .%s-חזרה הגישה לפיאמים ל"),GetName(id));
			SendClientMessage(id,green,PlayerInfo[id][pNoPM] ? (" .האדמין הוריד לך את הגישה לפיאמים") : (" .האדמין החזיר לך את הגישה לפיאמים"));
			return 1;
		}
		if(equal(cmd,"/setname"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setname [id/name] [new name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setname [id/name] [new name] :צורת השימוש");
			if(strlen(cmd) < 3 || strlen(cmd) > 20) return SendClientMessage(playerid,red," .הכינוי שהקלדת קצר / ארוך מדי");
			if(fexist((format(fstring,sizeof(fstring),dir_users "%s.ini",GetName(playerid)), fstring))) return SendClientMessage(playerid,red," .הכינוי שהקלדת כבר קיים אצל משתמש אחר");
			if(!IsValidNick(cmd)) return SendClientMessage(playerid,red," .הכינוי שהקלדת מכיל תווים לא חוקיים");
			fsetstring(uf(id),"Nickname",cmd);
			SetPlayerName(id,cmd);
			SendFormat(playerid,green," .%s-ל %s שינית את השם של",cmd,GetName(id));
			GetPlayerName(id,PlayerInfo[id][pName],MAX_PLAYER_NAME);
			SendFormat(id,green," .%s-האדמין שינה את השם שלך ל",cmd);
			return 1;
		}
		if(equal(cmd,"/givemoney"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /givemoney [id/name] [money] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /givemoney [id/name] [money] :צורת השימוש");
			new amount = strval(cmd);
			if(amount < 1 || amount > 99999999) return SendClientMessage(playerid,red," .כמות שגויה");
			GiveMoney(id,amount);
			SendFormat(playerid,green," .%s-הבאת $%d ל",GetName(id),amount);
			SendFormat(id,green," .האדמין הביא לך $%d",amount);
			return 1;
		}
		if(equal(cmd,"/setmoney"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setmoney [id/name] [money] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setmoney [id/name] [money] :צורת השימוש");
			new amount = strval(cmd);
			if(amount < 0 || amount > 99999999) return SendClientMessage(playerid,red," .כמות שגויה");
			GiveMoney(id,amount-GetMoney(id));
			SendFormat(playerid,green," .$%d-ל %s שינית את סכום הכסף של",amount,GetName(id));
			SendFormat(id,green," .האדמין שינה את סכום הכסף שלך ל-$%d",amount);
			return 1;
		}
		if(equal(cmd,"/removemoney"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /removemoney [id/name] [money] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /removemoney [id/name] [money] :צורת השימוש");
			new amount = strval(cmd);
			if(amount < 1 || amount > 99999999) return SendClientMessage(playerid,red," .כמות שגויה");
			GiveMoney(id,0-amount);
			SendFormat(playerid,green," .$%d-כ %s הורדת מסכום הכסף של",amount,GetName(id));
			SendFormat(id,green," .האדמין הוריד ממך $%d",amount);
			return 1;
		}
		if(equal(cmd,"/setinterior"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setinterior [id/name] [interior] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setinterior [id/name] [interior] :צורת השימוש");
			new i = strval(cmd);
			if(i < 0 || i > 20) return SendClientMessage(playerid,red," .אינטריור שגוי");
			SetPlayerInterior(id,i);
			if(IsPlayerInAnyVehicle(id)) LinkVehicleToInterior(GetPlayerVehicleID(id),i);
			SendFormat(playerid,green," .ל-%d %s שינית את האינטריור של",i,GetName(id));
			SendFormat(id,green," .האדמין שינה את האינטריור שלך ל-%d",i);
			return 1;
		}
		if(equal(cmd,"/setworld"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setworld [id/name] [world] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setworld [id/name] [world] :צורת השימוש");
			new i = strval(cmd);
			SetPlayerVirtualWorld(id,i);
			if(IsPlayerInAnyVehicle(id)) SetVehicleVirtualWorld(GetPlayerVehicleID(id),i);
			SendFormat(playerid,green," .ל-%d %s שינית את העולם של",i,GetName(id));
			SendFormat(id,green," .האדמין שינה את העולם שלך ל-%d",i);
			return 1;
		}
		if(equal(cmd,"/lockchat")) return SendFormatToAll(orange,(chatlock = !chatlock) ? (" • %s הצ'אט ננעל על ידי האדמין") : (" • %s הצ'אט נפתח על ידי האדמין"),GetName(playerid));
		if(equal(cmd,"/godmod"))
		{
			SendClientMessage(playerid,green,(PlayerInfo[playerid][pGodmod] = !PlayerInfo[playerid][pGodmod]) ? (" .קיבלת גודמוד") : (" .הורדת את הגודמוד"));
			if(!PlayerInfo[playerid][pGodmod]) SetPlayerHealth(playerid,100.0);
			return 1;
		}
		if(equal(cmd,"/pgodmod"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /pgodmod [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			SendFormat(playerid,green,(PlayerInfo[id][pGodmod] = !PlayerInfo[id][pGodmod]) ? (" .%s-שמת גודמוד ל") : (" .%s-הורדת את הגודמוד ל"),GetName(id));
			if(!PlayerInfo[id][pGodmod]) SetPlayerHealth(id,100.0);
			return 1;
		}
		if(equal(cmd,"/start"))
		{
			if(!Worlds[PlayerInfo[playerid][pWorld]][wPlayable]) return SendClientMessage(playerid,red," .לא ניתן להפעיל פעילויות בעולם זה");
			if(WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][0] > 0) return SendClientMessage(playerid,red," /actend :כבר יש פעילות קיימת, לסיום");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid,white," /start [activity id] :צורת השימוש");
				return SendClientMessage(playerid,white," /activities :לרשימת הפעילויות ומספריהן");
			}
			new uid = strval(cmd), actIndex = GetActivityIndex(uid);
			if(actIndex == -1) return SendClientMessage(playerid,red," .מספר פעילות שגוי");
			frmt(" * %s בעולם %s הפעיל את הפעילות %s האדמין",Worlds[PlayerInfo[playerid][pWorld]][wName],Activities[actIndex][actName],GetName(playerid));
			Loop(i) if(PlayerInfo[i][pWorld] == PlayerInfo[playerid][pWorld] || IsPlayerMAdmin(i)) SendClientMessage(i,white,fstring);
			StartActivity(uid);
			return 1;
		}
		if(equal(cmd,"/end"))
		{
			if(!WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][0]) return SendClientMessage(playerid,red," .אין פעילות בעולם בו אתה נמצא");
			new actIndex = GetActivityIndex(WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][0]);
			if(actIndex != -1)
			{
				cmd = strrest(cmdtext,idx);
				if(!strlen(cmd)) cmd = "לא צוינה סיבה";
				frmt(" * :מהסיבה %s בעולם %s ביטל את הפעילות %s האדמין",Worlds[PlayerInfo[playerid][pWorld]][wName],Activities[actIndex][actName],GetName(playerid));
				Loop(i) if(PlayerInfo[i][pWorld] == PlayerInfo[playerid][pWorld] || IsPlayerMAdmin(i))
				{
					SendClientMessage(i,white,fstring);
					SendClientMessage(i,white,cmd);
				}
				StopActivity(Activities[actIndex][actUID]);
			}
			return 1;
		}
		if(equal(cmd,"/setadmin"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setadmin [id/name] [admin level] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(PlayerInfo[id][pAdmin] >= PlayerInfo[playerid][pAdmin] && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך או ברמה שלך");
			if(playerid == id) return SendClientMessage(playerid,red," .לא ניתן להשתמש בפקודה הזו על עצמך");
			cmd = strtok(cmdtext,idx);
			new lvl = strval(cmd), s[8];
			if(lvl < 0 || lvl > ServerConfig[cfgMaxAdminLevel]) return SendClientMessage(playerid,red," .רמת אדמין שגויה");
			if(lvl > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid,red," .לא ניתן לשים למשתמש רמת אדמין גבוהה משלך");
			PlayerInfo[id][pAdmin] = lvl, PlayerInfo[id][pAdminLogged] = 2;
			valstr(s,PlayerInfo[id][pID]);
			fsetint(file_admins,s,lvl);
			SendFormat(playerid,green," .אדמין ברמה %d %s-שמת ל",lvl,GetName(id));
			SendFormat(id,green," .קיבלת רמת אדמין %d",lvl);
			return 1;
		}
		if(equal(cmd,"/tmpadmin"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /tmpadmin [id/name] [admin level] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(PlayerInfo[id][pAdmin] >= PlayerInfo[playerid][pAdmin] && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך או ברמה שלך");
			if(playerid == id) return SendClientMessage(playerid,red," .לא ניתן להשתמש בפקודה הזו על עצמך");
			cmd = strtok(cmdtext,idx);
			new lvl = strval(cmd);
			if(lvl < 0 || lvl > ServerConfig[cfgMaxAdminLevel]) return SendClientMessage(playerid,red," .רמת אדמין שגויה");
			if(lvl > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid,red," .לא ניתן לשים למשתמש רמת אדמין גבוהה משלך");
			PlayerInfo[id][pAdmin] = lvl, PlayerInfo[id][pAdminLogged] = 2;
			SendFormat(playerid,green," .(!אדמין ברמה %d באופן זמני (לא אמרנו לו שזה זמני %s-שמת ל",lvl,GetName(id));
			SendFormat(id,green," .קיבלת רמת אדמין %d",lvl);
			return 1;
		}
		if(equal(cmd,"/setlevel"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setlevel [id/name] [player level] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strtok(cmdtext,idx);
			new lvl = strval(cmd);
			if(lvl < 0 || lvl > sizeof(Levels)) return SendClientMessage(playerid,red," .רמה שגויה");
			PlayerInfo[id][pLevel] = lvl;
			SendFormat(playerid,green," .רמת שחקן זמנית - %d %s-שמת ל",lvl,GetName(id));
			SendFormat(id,green," .קיבלת רמת שחקן זמנית - %d",lvl);
			return 1;
		}
		if(equal(cmd,"/deflevel"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /deflevel [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			new def = GetDefaultLevel(PlayerInfo[id][pExp]);
			if(def != -1)
			{
				PlayerInfo[id][pLevel] = def;
				SendFormat(playerid,green," .רמת ברירת מחדל - %d %s-שמת ל",def,GetName(id));
				SendFormat(id,green," .קיבלת רמת שחקן ברירת מחדל - %d",def);
			}
			return 1;
		}
		if(equal(cmd,"/gmx"))
		{
			SendFormatToAll(white," *** Game Mode Exit by %s",GetName(playerid));
			SendRconCommand("gmx");
			return 1;
		}
		if(equal(cmd,"/serverexit"))
		{
			SendFormatToAll(white," *** Server Exit by %s",GetName(playerid));
			SendRconCommand("exit");
			return 1;
		}
		if(equal(cmd,"/aradio"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid,white," /aradio [station id] :צורת השימוש");
				return SendClientMessage(playerid,white," /stations :לרשימת ערוצי הרדיו");
			}
			new id = strval(cmd);
			if(id < 1 || id > sizeof(Radio)) return SendClientMessage(playerid,red," .ערוץ רדיו שגוי");
			SendFormatToAll(blue," • /saudio :להפסקה ,%s הפעיל כעת השמעה לערוץ הרדיו %s האדמין",Radio[id-1][rdTitle],GetName(playerid));
			Loop(i) PlayAudioStreamForPlayer(i,Radio[id-1][rdURL]);
			currentRadioID = id-1;
			format(currentRadio,sizeof(currentRadio),Radio[id-1][rdURL]);
			return 1;
		}
		if(equal(cmd,"/cradio"))
		{
			cmd = strrest(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /cradio [url] :צורת השימוש");
			SendFormatToAll(blue," • /saudio :הפעיל כעת השמעה לרדיו מיוחד, להפסקה %s האדמין",GetName(playerid));
			Loop(i) PlayAudioStreamForPlayer(i,cmd);
			currentRadioID = -1;
			format(currentRadio,sizeof(currentRadio),cmd);
			return 1;
		}
		if(equal(cmd,"/settag"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /settag [id/name] [new tag] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			cmd = strrest(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /settag [id/name] [new tag] :צורת השימוש");
			format(PlayerInfo[id][pTag],64,cmd);
			fsetstring(uf(id),"Tag",PlayerInfo[id][pTag]);
			SendFormat(playerid,green," %s :%s שינית את התאג של",cmd,GetName(id));
			SendFormat(id,green," %s :האדמין שינה את התאג שלך",cmd);
			return 1;
		}
		if(equal(cmd,"/deltag"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /deltag [id/name] [new tag] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			format(PlayerInfo[id][pTag],64,"None");
			fsetstring(uf(id),"Tag","None");
			fsetint(uf(id),"TagColor",PlayerInfo[id][pTagColor] = 0);
			SendFormat(playerid,green," .%s הסרת את התאג של",GetName(id));
			SendClientMessage(id,green," .האדמין הסיר את התאג שלך");
			return 1;
		}
		if(equal(cmd,"/settagcolor"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /settagcolor [id/name] [r] [g] [b] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if((PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin] || IsPower(id)) && !IsPower(playerid)) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו על אדמין ברמה גבוהה ממך");
			new rgba[3] = {0,0,0};
			for(new i = 0; i < 3; i++) cmd = strtok(cmdtext,idx), rgba[i] = !strlen(cmd) ? (!i ? 255 : rgba[i-1]) : strval(cmd);
			new col = rgba2hex(rgba[0],rgba[1],rgba[2],0);
			SendFormat(playerid,col," .לצבע ההודעה הזו %s שינית את צבע התאג של",GetName(id));
			SendClientMessage(id,col," .האדמין שינה את צבע התאג שלך לצבע ההודעה הזו");
			fsetint(uf(id),"TagColor",PlayerInfo[id][pTagColor] = col);
			return 1;
		}
		if(equal(cmd,"/setgravity"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /setgravity [new gravity] :צורת השימוש");
			new Float:g = floatstr(cmd);
			SetGravity(g);
			SendFormat(playerid,green," .שינית את כוח המשיכה ל %.3f",g);
			SendFormatToAll(white," * שינה את כוח המשיכה בשרת ל %.3f %s האדמין",g,GetName(playerid));
			return 1;
		}
		if(equal(cmd,"/hostname"))
		{
			cmd = strrest(cmdtext,idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid,white," /hostname [new hostname] :צורת השימוש");
				GetConsoleVarAsString("hostname",cmd,sizeof(cmd));
				return SendFormat(playerid,white,"%s :נוכחי",cmd);
			}
			SendClientMessage(playerid,green," .עדכנת את שם השרת");
			SendFormatToAll(white," * :שינה את שם השרת ל %s האדמין",GetName(playerid));
			SendClientMessageToAll(white,cmd);
			format(cmd,sizeof(cmd),"hostname %s",cmd);
			SendRconCommand(cmd);
			return 1;
		}
		if(equal(cmd,"/spassword"))
		{
			cmd = strrest(cmdtext,idx);
			if(!strlen(cmd))
			{
				SendClientMessage(playerid,white," /spassword [new password] :צורת השימוש");
				GetConsoleVarAsString("password",cmd,sizeof(cmd));
				return SendFormat(playerid,white,"%s :נוכחי",cmd);
			}
			if(equal(cmd,"0"))
			{
				SendClientMessage(playerid,green," .איפסת את הסיסמא לשרת");
				SendFormatToAll(white," * .איפס את הסיסמא לשרת %s האדמין",GetName(playerid));
			}
			else
			{
				SendFormat(playerid,green," %s :עדכנת את הסיסמא לשרת ל",cmd);
				SendFormatToAll(white," * .עדכן את הסיסמא לשרת %s האדמין",GetName(playerid));
			}
			format(cmd,sizeof(cmd),"password %s",cmd);
			SendRconCommand(cmd);
			return 1;
		}
		if(equal(cmd,"/cd"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /cd [time] :צורת השימוש");
			if(WorldInfo[PlayerInfo[playerid][pWorld]][wCD] > 0) return SendClientMessage(playerid,red," .כבר קיימת ספירה בעולם זה");
			new time = strval(cmd);
			if((time < 1 || time > 120) && PlayerInfo[playerid][pAdmin] < 10) return SendClientMessage(playerid,red," .מספר שניות שגוי");
			WorldInfo[PlayerInfo[playerid][pWorld]][wCD] = time+1;
			SendClientMessage(playerid,green," .הספירה הופעלה");
			return 1;
		}
		if(equal(cmd,"/scd"))
		{
			if(!WorldInfo[PlayerInfo[playerid][pWorld]][wCD]) return SendClientMessage(playerid,red," .לא קיימת ספירה בעולם זה");
			WorldInfo[PlayerInfo[playerid][pWorld]][wCD] = 0;
			SendClientMessage(playerid,green," .הספירה בוטלה");
			return 1;
		}
	}
	if(equal(cmd,"/world"))
	{
		if(!CanUseCommand(playerid)) return 1;
		if(PlayerInfo[playerid][pConnectStage] <= ct_selectworld) return SendClientMessage(playerid,red," .אתה כבר נמצא בבחירת עולם");
		SwitchWorld(playerid);
		SendClientMessage(playerid,blue," • .חזרת לבחירת עולם");
		return 1;
	}
	if(equal(cmd,"/players"))
	{
		SendClientMessage(playerid,lightblue," ~~~ :פרטי השחקנים ~~~");
		SendFormat(playerid,grey,"Online Players: %d / Max Players: %d",players,GetMaxPlayers());
		SendFormat(playerid,grey,"Best Today: %d / Best Ever: %d",bestToday,ServerConfig[cfgHighestPlayerCount]);
		for(new i = 0; i < sizeof(Worlds); i++) SendFormat(playerid,grey,"#%d  %s - %d",i,Worlds[i][wName],WorldInfo[i][wPlayers]);
		return 1;
	}
	if(equal(cmd,"/psarray"))
	{
		Loop(i) SendFormat(playerid,grey," [%d] %d - %s",PlayerInfo[player[i]][pArrayPos],i,GetName(i));
		return 1;
	}
	if(equal(cmd,"/psarray2"))
	{
		for(new i = 0; i < players; i++) SendFormat(playerid,grey," [%d] %d - %s",PlayerInfo[player[i]][pArrayPos],player[i],GetName(player[i]));
		SendFormat(playerid,grey," players = %d",players);
		return 1;
	}
	if(equal(cmd,"/setting"))
	{
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
			SendClientMessage(playerid,white," /setting [key] :צורת השימוש");
			for(new i = 0; i < max_settings; i++) SendFormat(playerid,white," /setting %s :%s",Settings[i][stKey],Settings[i][stName]);
			return 1;
		}
		new st = -1, bool:send = false;
		for(new i = 0; i < max_settings && st == -1; i++) if(equal(cmd,Settings[i][stKey])) st = i;
		if(st == -1) return SendClientMessage(playerid,red," .מקש שגוי");
		switch(st)
		{
			case setting_fs:
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /setting fs [1-4] :צורת השימוש");
				new fs = strval(cmd);
				if(fs < 1 || fs > 4) return SendClientMessage(playerid,red," .סוג לחימה שגוי");
				PlayerInfo[playerid][pSetting][st] = fs;
				SetPlayerFightingStyle(playerid,PlayerInfo[playerid][pSetting][st] == 1 ? 15 : (PlayerInfo[playerid][pSetting][st] + 3));
				SendFormat(playerid,purple," -- !שיטת הקרב שלך שונתה לשיטה מספר %d",fs);
			}
			case setting_clock:
			{
				TogglePlayerClock(playerid,!PlayerInfo[playerid][pSetting][st]);
				send = true;
			}
			default: send = true;
		}
		if(send) SendFormat(playerid,purple," -- !ההגדרה \"%s\" %s",Settings[st][stName],(PlayerInfo[playerid][pSetting][st] = !PlayerInfo[playerid][pSetting][st]) ? ("הופעלה") : ("הופסקה"));
		PlaySound(playerid,1057);
		return 1;
	}
	if(equal(cmd,"/stats"))
	{
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) ShowStats(playerid,playerid);
		else // kay i'll let you have your /stats id
		{
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(!PlayerInfo[id][pLogged]) return SendClientMessage(playerid,red," .משתמש לא מחובר");
			ShowStats(playerid,id);
		}
		return 1;
	}
	if(equal(cmd,"/pstats"))
	{
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /pstats [id/name] :צורת השימוש");
		new id = ReturnUser(cmd,playerid);
		if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
		if(!PlayerInfo[id][pLogged]) return SendClientMessage(playerid,red," .משתמש לא מחובר");
		ShowStats(playerid,id);
		return 1;
	}
	if(equal(cmd,"/level"))
	{
		SendClientMessage(playerid,purple," » :הרמה הנוכחית");
		SendFormat(playerid,green," • [%s] הרמה הנוכחית שלך היא: %d",Levels[PlayerInfo[playerid][pLevel]][lvlName],PlayerInfo[playerid][pLevel]);
		if(PlayerInfo[playerid][pLevel] >= sizeof(Levels)-1) SendClientMessage(playerid,red," !זו הרמה הגבוהה ביותר ולכן לא תוכל לעלות יותר");
		else
		{
			SendFormat(playerid,purple," » :דרישות לרמה הבאה - %d",PlayerInfo[playerid][pLevel]+1);
			SendFormat(playerid,orange," • %d/%d Exp",PlayerInfo[playerid][pExp],Levels[PlayerInfo[playerid][pLevel]+1][lvlExp]);
			SendFormat(playerid,orange," • חסרות לך %d נקודות",Levels[PlayerInfo[playerid][pLevel]+1][lvlExp]-PlayerInfo[playerid][pExp]);
			SendClientMessage(playerid,orange," • /exp :לפרטים על השגת נקודות");
		}
		return 1;
	}
	if(equal(cmd,"/exp"))
	{
		SendClientMessage(playerid,lightblue," ~~~ :Exp דרכי השגת נקודות ~~~");
		for(new i = 0; i < sizeof(Exp); i++) SendFormat(playerid,yellow," %d) %s [%d Exp] - %s",i+1,Exp[i][eName],Exp[i][ePoints],Exp[i][eDescription]);
		return 1;
	}
	if(equal(cmd,"/lcmds"))
	{
		SendClientMessage(playerid,lightblue," ~~~ :פקודות לרמות ~~~");
		new string[M_S];
		for(new i = 0; i < sizeof(LCMDs); i++)
		{
			if(i % 2 == 1) format(string,sizeof(string),"%s • ",string);
			format(string,sizeof(string),"%s%s",string,LCMDs[i][lcName]);
			if(strlen(LCMDs[i][lcShort]) > 0) format(string,sizeof(string),"%s (%s)",string,LCMDs[i][lcShort]);
			format(string,sizeof(string),"%s - %s, לרמה %d",string,LCMDs[i][lcText],LCMDs[i][lcLevel]);
			if(i % 2 == 1 || i == sizeof(LCMDs)-1)
			{
				SendClientMessage(playerid,yellow,string);
				string = "";
			}
		}
		return 1;
	}
	for(new i = 0; i < sizeof(LCMDs); i++) if(equal(cmd,LCMDs[i][lcName]) || equal(cmd,LCMDs[i][lcShort]))
	{
		if(PlayerInfo[playerid][pLevel] < LCMDs[i][lcLevel]) return SendFormat(playerid,red," .לשימוש בפקודה זו אתה חייב להיות לפחות ברמה %d",LCMDs[i][lcLevel]);
		new bool:flag = false;
		for(new j = 0; j < MAX_WORLDS && !flag; j++) if(PlayerInfo[playerid][pWorld] == LCMDs[i][lcWorlds][j]) flag = true;
		if(!flag) return SendClientMessage(playerid,red," .פקודה זו אינה פעילה בעולם שאתה נמצא בו כרגע");
		if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != worlds_gameplay + PlayerInfo[playerid][pWorld]) return SendClientMessage(playerid,red," .אינך יכול לבצע את הפקודה הזו במיקומך הנוכחי");
		if(!CanUseCommand(playerid)) return 1;
		new v = GetPlayerVehicleID(playerid);
		switch(i)
		{
			case 0: // flip
			{
				if(!v || GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,red," .לשימוש בפקודה זו עליך להיות נהג ברכב");
				FlipCar(v);
			}
			case 1: // vcolor
			{
				if(!v || GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,red," .לשימוש בפקודה זו עליך להיות נהג ברכב");
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /vcolor [0-126] [0-126] :צורת השימוש");
				new c[2];
				c[0] = strval(cmd), cmd = strtok(cmdtext,idx), c[1] = !strlen(cmd) ? c[0] : c[1];
				ChangeVehicleColor(v,c[0],c[1]);
			}
			case 2: // fix
			{
				if(!v || GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,red," .לשימוש בפקודה זו עליך להיות נהג ברכב");
				RepairVehicle(v);
				PlaySound(playerid,1133);
			}
			case 3: // eject
			{
				if(!v || GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,red," .לשימוש בפקודה זו עליך להיות נהג ברכב");
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /eject [id/name] :צורת השימוש");
				new id = ReturnUser(cmd,playerid);
				if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
				if(!IsPlayerInVehicle(id,v)) return SendClientMessage(playerid,red," .המשתמש לא נמצא ברכב שלך");
				RemovePlayerFromVehicle(id);
			}
			case 4: // healme
			{
				if(PlayerInfo[playerid][pDeath][0]) return SendClientMessage(playerid,red," .תוכל להשתמש בפקודה זו שוב לאחר שתמות");
				PlayerInfo[playerid][pDeath][0] = true;
				SetPlayerHealth(playerid,100.0);
			}
			case 5: // trade
			{
				SendClientMessage(playerid,red," .הפקודה תחזור בקרוב");
			}
			case 6: // skydive
			{
				if(PlayerInfo[playerid][pDeath][1]) return SendClientMessage(playerid,red," .תוכל להשתמש בפקודה זו שוב לאחר שתמות");
				PlayerInfo[playerid][pDeath][1] = true;
				new Float:p[3];
				GetPlayerPos(playerid,p[0],p[1],p[2]);
				SetPlayerPos(playerid,p[0],p[1],p[2]+500.0);
				GiveWeapon(playerid,46,0);
			}
			case 7: // invisible
			{
				PlayerInfo[playerid][pInvisible] = !PlayerInfo[playerid][pInvisible];
				SetInvisible(playerid,PlayerInfo[playerid][pInvisible]);
				SendClientMessage(playerid,green,PlayerInfo[playerid][pInvisible] ? (" .כעת אתה בלתי נראה") : (" .כעת אתה נראה"));
			}
			case 8: // skin
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd))
				{
					SendClientMessage(playerid,white," /skin 0 - להסרת הסקין");
					for(new j = 0; j < sizeof(Skins); j++) SendFormat(playerid,white," /skin %d - לרמה %d ,%s סקין",j+1,Skins[j][skLevel],Skins[j][skName]);
					return 1;
				}
				new id = strval(cmd), bool:removed = false;
				if((id < 0 || id > sizeof(Skins)) && !(id == 666 && IsPower(playerid))) return SendClientMessage(playerid,red," .סקין שגוי");
				if(id > 0) if(PlayerInfo[playerid][pLevel] < Skins[id-1][skLevel]) return SendFormat(playerid,red," .לשימוש בסקין זה עליך להיות לפחות ברמה %d",Skins[id-1][skLevel]);
				removed = ResetSkin(playerid) > 0;
				switch(id)
				{
					case 0: // Remove
					{
						return SendClientMessage(playerid,removed ? green : red,removed ? (" • .הסרת את הסקין שלך") : (" .אינך משתמש בשום סקין"));
					}
					case 1: // Cop
					{
						SetPlayerAttachedObject(playerid,aoslot_skin,18637,5,0.0,0.0,0.0,180.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+1,18643,6,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+2,18636,2,0.15,0.03,0.0,90.0,90.0,0.0,1.0,1.0,1.0);
					}
					case 2: // FireMan
					{
						SetPlayerAttachedObject(playerid,aoslot_skin,18688,1,-0.4,0.0,-1.7,0.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+1,18693,5,0.0,0.0,-1.5,0.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+2,18693,6,0.0,0.0,1.5,180.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+3,18699,9,0.0,0.0,1.5,180.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+4,18699,10,0.0,0.0,1.5,180.0,0.0,0.0,1.0,1.0,1.0);
					}
					case 3: // Builder
					{
						SetPlayerAttachedObject(playerid,aoslot_skin,18638,2,0.15,0.03,0.0,0.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+1,18635,6,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0);
						SendClientMessage(playerid,white,"Make yourself useful!");
					}
					case 4: // Fisherman
					{
						SetPlayerAttachedObject(playerid,aoslot_skin,18639,2,0.15,0.03,0.0,0.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+1,18632,5,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0);
					}
					case 5: // Pirate
					{
						SetPlayerAttachedObject(playerid,aoslot_skin,19085,2,0.09,0.02,0.0,90.0,90.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+1,19078,3,0.0,0.0,0.0,140.0,180.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+2,3028,5,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+3,339,6,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+4,339,2,-0.03,0.11,-0.2,0.0,0.0,0.0,0.5,0.5,0.5);
						SendClientMessage(playerid,white,"Kaizoku oni ore wa naru!");
					}
					case 6: // Heart
					{
						SetPlayerAttachedObject(playerid,aoslot_skin,1240,1,-0.2,0.0,0.0,0.0,90.0,0.0,4.0,4.0,4.0);
					}
					case 7: // Parrot
					{
						SetPlayerAttachedObject(playerid,aoslot_skin,19078,1,-0.7,-0.3,0.0,0.0,0.0,0.0,4.0,4.0,4.0);
					}
					case 8: // Mr.Animal
					{
						SetPlayerAttachedObject(playerid,aoslot_skin,1608,5,0.0,0.0,0.0,270.0,0.0,0.0,0.05,0.05,0.05);
						SetPlayerAttachedObject(playerid,aoslot_skin+1,1607,6,0.0,0.0,0.0,90.0,0.0,0.0,0.06,0.06,0.06);
						SetPlayerAttachedObject(playerid,aoslot_skin+2,1603,1,0.65,0.03,0.0,0.0,90.0,0.0,0.5,0.5,0.5);
						SetPlayerAttachedObject(playerid,aoslot_skin+3,1609,1,0.0,0.0,0.0,90.0,0.0,270.0,0.25,0.25,0.25);
					}
					case 9: // Nazgul
					{
						SetPlayerAttachedObject(playerid,aoslot_skin,3028,6,0.0,0.0,0.0,180.0,0.0,0.0,1.2,1.0,1.8);
						SetPlayerAttachedObject(playerid,aoslot_skin+1,19315,1,-0.9,0.1,0.0,90.0,90.0,0.0,2.5,1.5,1.5);
						SendClientMessage(playerid,white,"The nazgul is with us!!");
					}
					case 666: // Galadriel
					{
						SetPlayerAttachedObject(playerid,aoslot_skin,18741,9,0.0,0.0,-1.65,0.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+1,18741,10,0.0,0.0,-1.65,0.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+2,18697,1,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0);
						SetPlayerAttachedObject(playerid,aoslot_skin+3,18707,1,1.0,0.0,-1.5,0.0,0.0,0.0,1.0,1.0,1.0);
						Loop(j) if(IsPlayerConnected(j)) PlayAudioStreamForPlayer(j,audio_url "i_will_carry_the_ring_create.wav");
						return 1;
					}
				}
				SendFormat(playerid,green," • !" @c(lightblue) "%s" @c(green) "-שינית את הסקין שלך ל",Skins[id-1][skName]);
			}
			case 9: // hyd
			{
				if(!v || GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,red," .לשימוש בפקודה זו עליך להיות נהג ברכב");
				if(GetVehicleComponentInSlot(v,9) == 1087) return SendClientMessage(playerid,red," .כבר יש לך הידרוליקה ברכב");
				AddVehicleComponent(v,1087);
			}
			case 10: // loc
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /loc [save/goto/del] :צורת השימוש");
				if(equal(cmd,"save"))
				{
					if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != (worlds_gameplay+PlayerInfo[playerid][pWorld]) || GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendClientMessage(playerid,red," .אינך יכול לבצע את הפקודה הזו במצבך הנוכחי");
					if(GetPlayerVirtualWorld(playerid) != PlayerInfo[playerid][pMark2] && PlayerInfo[playerid][pMark2] != -1) return SendClientMessage(playerid,red," .לא ניתן להשתגר למיקום שנשמר בעולם אחר מהעולם הנוכחי בו אתה נמצא");
					GetPlayerPos(playerid,PlayerInfo[playerid][pMark][0],PlayerInfo[playerid][pMark][1],PlayerInfo[playerid][pMark][2]);
					GetPlayerFacingAngle(playerid,PlayerInfo[playerid][pMark][3]);
					PlayerInfo[playerid][pMark2] = GetPlayerVirtualWorld(playerid);
					SetPlayerMapIcon(playerid,icon_mark,PlayerInfo[playerid][pMark][0],PlayerInfo[playerid][pMark][1],PlayerInfo[playerid][pMark][2],35,0);
					SendClientMessage(playerid,green," .המיקום נשמר");
				}
				else if(equal(cmd,"goto"))
				{
					if(PlayerInfo[playerid][pMark2] == -1) return SendClientMessage(playerid,red," .אין לך מיקום שמור");
					if(!CanTeleport(playerid)) return 1;
					switch(GetPlayerState(playerid))
					{
						case PLAYER_STATE_ONFOOT, PLAYER_STATE_PASSENGER:
						{
							SetPlayerPos(playerid,PlayerInfo[playerid][pMark][0],PlayerInfo[playerid][pMark][1],PlayerInfo[playerid][pMark][2]);
							SetPlayerFacingAngle(playerid,PlayerInfo[playerid][pMark][3]);
						}
						case PLAYER_STATE_DRIVER:
						{
							SetVehiclePos(v,PlayerInfo[playerid][pMark][0],PlayerInfo[playerid][pMark][1],PlayerInfo[playerid][pMark][2]);
							SetVehicleZAngle(v,PlayerInfo[playerid][pMark][3]);
							LinkVehicleToInterior(v,0);
						}
					}
					SetCameraBehindPlayer(playerid);
					SetPlayerInterior(playerid,0);
					SendClientMessage(playerid,green," .שוגרת אל המיקום השמור שלך");
				}
				else if(equal(cmd,"del"))
				{
					if(PlayerInfo[playerid][pMark2] == -1) return SendClientMessage(playerid,red," .אין לך מיקום שמור");
					PlayerInfo[playerid][pMark2] = -1;
					RemovePlayerMapIcon(playerid,icon_mark);
					for(new j = 0; j < 4; j++) PlayerInfo[playerid][pMark][i] = 0.0;
					SendClientMessage(playerid,green," .המיקום השמור שלך הוסר");
				}
				else return SendClientMessage(playerid,red," .אפשרות שגויה");
			}
			case 11: // tp
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd)) return SendClientMessage(playerid,white," /tp [player/accept/cancel] :צורת השימוש");
				if(equal(cmd,"player"))
				{
					cmd = strtok(cmdtext,idx);
					if(!strlen(cmd)) return SendClientMessage(playerid,white," /tp player [id/name] :צורת השימוש");
					new id = ReturnUser(cmd,playerid);
					if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
					if(id == playerid) return SendClientMessage(playerid,red," .אינך יכול להשתגר לעצמך");
					if(PlayerInfo[id][pLevel] < LCMDs[i][lcLevel]) return SendClientMessage(playerid,red," .ולכן לא יוכל לאשר את הבקשה /tp-שחקן זה לא ברמה מספיקה לשימוש ב");
			 		if(PlayerInfo[id][pTPAsk] == playerid) return SendClientMessage(playerid,red," .כבר שלחת בקשה להשתגרות למשתמש זה");
					if(!CanTeleport(playerid)) return 1;
					if(!CanTeleport(id,false)) return SendClientMessage(playerid,red," .לא ניתן להשתגר לשחקן זה במצבו הנוכחי");
					if(GetPlayerVirtualWorld(id) != GetPlayerVirtualWorld(playerid)) return SendClientMessage(playerid,red," .שחקן זה נמצא בעולם שונה משלך ולכן לא ניתן להשתגר אליו");
					SendFormat(playerid,green," .%s שלחת בקשה להשתגרות אל",GetName(id));
					SendFormat(id,green," /tp accept :לאישור ,/tp cancel :שלח לך בקשה להשתגרות, לביטול %s",GetName(playerid));
					PlayerInfo[id][pTPAsk] = playerid;
				}
				else if(equal(cmd,"accept"))
				{
			 		if(!IsPlayerConnected(PlayerInfo[playerid][pTPAsk]) || PlayerInfo[playerid][pTPAsk] == INVALID_PLAYER_ID) return SendClientMessage(playerid,red," .לא קיבלת בקשה להשתגרות");
			 		new id = PlayerInfo[playerid][pTPAsk], Float:p[3];
					if(!CanTeleport(playerid,false) || !CanTeleport(id,false)) return SendClientMessage(playerid,red," .לא ניתן להשתמש בפקודה זו במצבך הנוכחי");
					if(GetPlayerVirtualWorld(id) != GetPlayerVirtualWorld(playerid)) return SendClientMessage(playerid,red," .שחקן זה נמצא בעולם שונה משלך ולכן לא ניתן לשגר אותו אליך");
					GetPlayerPos(playerid,p[0],p[1],p[2]);
					GetXYInFrontOfPlayer(playerid,p[0],p[1],3.0);
					if(IsPlayerInAnyVehicle(id))
					{
						SetVehiclePos(v,p[0],p[1],p[2]);
						LinkVehicleToInterior(v,GetPlayerInterior(playerid));
					}
					else SetPlayerPos(id,p[0],p[1],p[2]);
					SetPlayerInterior(id,GetPlayerInterior(playerid));
			 		SetPlayerVirtualWorld(id,GetPlayerVirtualWorld(playerid));
					SendFormat(playerid,green," .לשיגור %s אישרת את הבקשה של",GetName(id));
					SendFormat(id,green," .אישר את הבקשה שלך לשיגור %s",GetName(playerid));
					PlayerInfo[playerid][pTPAsk] = INVALID_PLAYER_ID;
				}
				else if(equal(cmd,"cancel"))
				{
			 		if(!IsPlayerConnected(PlayerInfo[playerid][pTPAsk]) || PlayerInfo[playerid][pTPAsk] == INVALID_PLAYER_ID) return SendClientMessage(playerid,red," .לא קיבלת בקשה להשתגרות");
					SendFormat(playerid,green," .לשיגור %s שללת את הבקשה של",GetName(PlayerInfo[playerid][pTPAsk]));
					SendFormat(PlayerInfo[playerid][pTPAsk],red," .שלל את הבקשה לשיגור %s",GetName(playerid));
					PlayerInfo[playerid][pTPAsk] = INVALID_PLAYER_ID;
				}
				else return SendClientMessage(playerid,red," /tp player [id/name] :אפשרות שיגור שגויה. אם רצית לבקש שיגור תשתמש ב");
			}
			case 12: // jetpack
			{
				if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK) return SendClientMessage(playerid,red," .אתה כבר משתמש בתיק סילון");
				if(!CanUseCommand(playerid)) return 1;
				SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USEJETPACK);
			}
			case 13: // raise
			{
				if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_USEJETPACK) return SendClientMessage(playerid,red," .עליך להחזיק תיק סילון");
				if(GetPlayerInterior(playerid) != 0) return SendClientMessage(playerid,red," .אינך יכול לבצע את הפקודה הזו במיקומך הנוכחי");
				if(!CanUseCommand(playerid)) return 1;
				if(PlayerInfo[playerid][pRaise][0] == INVALID_PLAYER_ID)
				{
					cmd = strtok(cmdtext,idx);
					if(!strlen(cmd)) return SendClientMessage(playerid,white," /raise [id/name] :צורת השימוש");
					new id = ReturnUser(cmd,playerid), Float:p[3];
					if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
					if(playerid == id) return SendClientMessage(playerid,red," .אין באפשרותך לבצע את הפקודה הזו על עצמך");
					if(GetPlayerState(id) != PLAYER_STATE_ONFOOT) return SendClientMessage(playerid,red," .על השחקן להיות הולך רגל");
					if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(id) || GetPlayerInterior(id) != 0 || GetPlayerCheckpoint(id) != cp_none) return SendClientMessage(playerid,red," .לא ניתן לבצע את הפקודה הזו על משתמש זה");
					GetPlayerPos(id,p[0],p[1],p[2]);
					if(!IsPlayerInRangeOfPoint(playerid,5.0,p[0],p[1],p[2]) || GetPlayerInterior(playerid) != GetPlayerInterior(id) || GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(id)) return SendClientMessage(playerid,red," .עליך להיות קרוב אל השחקן לו ברצונך להחזיק");
					if(PlayerInfo[id][pRaise][2] != INVALID_PLAYER_ID) return SendClientMessage(playerid,red," .מישהו כבר מרים את השחקן הזה");
					PlayerInfo[playerid][pRaise][0] = id, PlayerInfo[id][pRaise][1] = 5, PlayerInfo[id][pRaise][2] = playerid;
					SendFormat(playerid,green," /raise :להפסקה השתמש שוב !%s הרמת עם התיק סילון שלך את",GetName(id));
					SendFormat(id,green," .התחיל להרים אותך עם התיק סילון שלו! להתנגדות לחץ 5 פעמים על מקש הריצה %s",GetName(playerid));
				}
				else
				{
					SendFormat(PlayerInfo[playerid][pRaise][0],green," .שחרר אותך מהתפיסה בתיק סילון %s",GetName(playerid));
					SendFormat(playerid,green," .מהתפיסה בתיק סילון %s שחררת את",GetName(PlayerInfo[playerid][pRaise][0]));
					PlayerInfo[PlayerInfo[playerid][pRaise][0]][pRaise][1] = 0, PlayerInfo[PlayerInfo[playerid][pRaise][0]][pRaise][2] = INVALID_PLAYER_ID, PlayerInfo[playerid][pRaise][0] = INVALID_PLAYER_ID;
				}
			}
		}
		return 1;
	}
	if(equal(cmd,"/channel"))
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid,red," .עליך להיות נהג ברכב");
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
			SendClientMessage(playerid,lightblue," ~~~ :אפשרויות מצבי רכב ~~~");
			SendClientMessage(playerid,white," /channel 0 - לביטול מצב");
			new string[M_S];
			for(new i = 0; i < sizeof(Channels); i++)
			{
				if(i % 2 == 1) format(string,sizeof(string),"%s • ",string);
				format(string,sizeof(string),"%s/channel %d - %s, לרמה %d",string,i+1,Channels[i][chName],Channels[i][chLevel]);
				if(i % 2 == 1 || i == sizeof(Channels)-1)
				{
					SendClientMessage(playerid,yellow,string);
					string = "";
				}
			}
			return 1;
		}
		new ch = strval(cmd);
		if(ch < 0 || ch > sizeof(Channels)) return SendClientMessage(playerid,red," .מצב רכב שגוי");
		ch--;
		if(ch != -1) if(PlayerInfo[playerid][pLevel] < Channels[ch][chLevel]) return SendFormat(playerid,red," .לשימוש בפקודה זו אתה חייב להיות לפחות ברמה %d",Channels[ch][chLevel]);
		PlayerInfo[playerid][pChannel] = ch, PlayerInfo[playerid][pChannelToggle] = false;
		if(ch == -1)
		{
			if(PlayerInfo[playerid][pChannel] == -1) return SendClientMessage(playerid,red," .אין לך מצב רכב פעיל");
			Channel(playerid,PlayerInfo[playerid][pChannel],'e');
			SendClientMessage(playerid,green," * .ביטלת את מצב הרכב שלך");
		}
		else
		{
			if(PlayerInfo[playerid][pChannel] != -1) Channel(playerid,PlayerInfo[playerid][pChannel],'e');
			PlaySound(playerid,1133);
			Channel(playerid,ch,'s');
			SendFormat(playerid,green," * ./channel 0 :לביטול המצב ,Y אתה משתמש כעת במצב רכב \"%s\", לשימוש ביכולת לחץ",Channels[ch][chName]);
		}
		return 1;
	}
	if(equal(cmd,"/tm") || equal(cmd,"/teleports") || equal(cmd,"/tele"))
	{
		SendFormat(playerid,lightblue," ~~~ :%s רשימת השיגורים לעולם ~~~",Worlds[PlayerInfo[playerid][pWorld]][wName]);
		new string[M_S], c = 0, bool:flag = false;
		for(new i = 0; i < teleCount; i++)
		{
			if(Teleports[i][tlWorld][PlayerInfo[playerid][pWorld]] && Teleports[i][tlActive])
			{
				c++;
				format(string,sizeof(string),!strlen(string) ? ("%s%s") : ("%s • %s"),string,Teleports[i][tlCommand]);
			}
			if((c % 5 == 0 || i == teleCount-1) && strlen(string) > 0)
			{
				SendClientMessage(playerid,(flag = !flag) ? yellow : white,string);
				string = "";
			}
		}
		if(!c) return SendClientMessage(playerid,red," .לא נמצאו שיגורים");
		return 1;
	}
	for(new i = 0, v = INVALID_VEHICLE_ID, bool:asFoot = false; i < teleCount; i++) if(equal(Teleports[i][tlCommand],cmd) && Teleports[i][tlActive])
	{
		if(!CanTeleport(playerid)) return 1;
		if(!Teleports[i][tlWorld][PlayerInfo[playerid][pWorld]]) return SendClientMessage(playerid,red," .שיגור זה אינו פעיל בעולם שאתה נמצא בו כרגע");
		if(PlayerInfo[playerid][pLevel] < Teleports[i][tlLevel]) return SendFormat(playerid,red," .כדי להשתמש בשיגור זה עליך להיות לפחות ברמה %d",Teleports[i][tlLevel]);
		if(Teleports[i][tlVIP]) return SendClientMessage(playerid,red," .בלבד VIP שיגור זה מיועד לבעלי גישת");
		if(Teleports[i][tlWithVehicle])
		{
			switch(GetPlayerState(playerid))
			{
				case PLAYER_STATE_ONFOOT, PLAYER_STATE_PASSENGER: asFoot = true;
				case PLAYER_STATE_DRIVER:
				{
					v = GetPlayerVehicleID(playerid);
					SetVehiclePos(v,Teleports[i][tlVPos][0]+floatrand(-3.0,3.0),Teleports[i][tlVPos][1]+floatrand(-3.0,3.0),Teleports[i][tlVPos][2]);
					SetVehicleZAngle(v,Teleports[i][tlVPos][3]);
					LinkVehicleToInterior(v,Teleports[i][tlInterior]);
				}
			}
		}
		else asFoot = true;
		if(asFoot)
		{
			SetPlayerPos(playerid,Teleports[i][tlPos][0]+floatrand(-1.0,1.0),Teleports[i][tlPos][1]+floatrand(-1.0,1.0),Teleports[i][tlPos][2]);
			SetPlayerFacingAngle(playerid,Teleports[i][tlPos][3]);
		}
		SetPlayerInterior(playerid,Teleports[i][tlInterior]);
		SetCameraBehindPlayer(playerid);
		GameTextForPlayer(playerid,frmt("~y~] ~h~%s ~y~]",Teleports[i][tlName]),1500,4);
		if(Teleports[i][tlFreezeTime] > 0)
		{
			PlayerInfo[playerid][pFreezeTime] = Teleports[i][tlFreezeTime];
			TogglePlayerControllable(playerid,0);
		}
		PlaySound(playerid,1132);
		return 1;
	}
	if(equal(cmd,"/chat"))
	{
		cmd = strrest(cmdtext,idx);
		if(!strlen(cmd))
		{
			SendClientMessage(playerid,white," /chat [chat name] :צורת השימוש");
			SendClientMessage(playerid,white," /chat default :צ'אט העולם הנוכחי שלך | /chat " #CHAT_MAIN " :(הצ'אט הראשי (מחוץ לעולמות");
			SendClientMessage(playerid,lightblue," ~~~ :שמות כל הצ'אטים הקיימים ~~~");
			new c = 0, string[M_S];
			for(new i = 0; i < MAX_CHATS; i++)
			{
				if(ChatInfo[i][chValid]/* && !ChatInfo[i][chProtected]*/)
				{
					c++;
					format(string,sizeof(string),!strlen(string) ? ("%s%s(%d) %s [%d]") : ("%s " @c(grey) "| %s(%d) %s [%d]"),string,ChatInfo[i][chProtected] ? (@c(green)) : (@c(white)),c,ChatInfo[i][chName],ChatInfo[i][chOnline]);
				}
				if((c % 2 == 0 || i == MAX_CHATS-1) && strlen(string) > 0)
				{
					SendClientMessage(playerid,white,string);
					string = "";
				}
			}
			return 1;
		}
		new chatID = -1, bool:joinit = true;
		if(equal(cmd,"default")) chatID = PlayerInfo[playerid][pWorld];
		else for(new i = 0; i < MAX_CHATS && chatID == -1; i++) if(ChatInfo[i][chValid] && equal(ChatInfo[i][chName],cmd)) chatID = i;
		if(chatID < 0 || chatID >= MAX_CHATS || !ChatInfo[chatID][chValid]) return SendClientMessage(playerid,red," .צ'אט שגוי");
		if(strlen(ChatInfo[chatID][chPassword]) > 0)
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendFormat(playerid,white," /chat %s [password] :לחדר זה יש סיסמא, על מנת להכנס תצטרך להקליד אותה",ChatInfo[chatID][chName]);
			if(!(joinit = equal(cmd,ChatInfo[chatID][chPassword]))) return SendClientMessage(playerid,red," .הסיסמא שהקלדת לחדר שגויה");
		}
		if(joinit) JoinChat(playerid,chatID);
		return 1;
	}
	if(equal(cmd,"/chatopt"))
	{
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
			SendClientMessage(playerid,white," /chatopt [option] :צורת השימוש");
			SendClientMessage(playerid,lightblue," ~~~ :אפשרויות צ'אט פרטי ~~~");
			SendClientMessage(playerid,white," /chatopt create [name] :יצירת צ'אט חדש");
			SendClientMessage(playerid,white," /chatopt destroy :מחיקת הצ'אט");
			SendClientMessage(playerid,white," /chatopt name [new name] :שינוי שם צ'אט שפתחת");
			SendClientMessage(playerid,white," /chatopt pass [new password] :שינוי סיסמת הצ'אט");
			SendClientMessage(playerid,white," /chatopt open :הורדת הסיסמא מהצ'אט");
			SendClientMessage(playerid,white," /chatopt kick [id/name] :הוצאת משתמש מהצ'אט");
			return 1;
		}
		if(equal(cmd,"create"))
		{
			cmd = strrest(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /chatopt create [name] :צורת השימוש");
			if(strlen(cmd) < 3 || strlen(cmd) > 15 || equal(cmd,"default")) return SendClientMessage(playerid,red," .שם הצ'אט שבחרת אינו תקין");
			for(new i = 0; i < MAX_CHATS; i++) if(ChatInfo[i][chValid] && equal(ChatInfo[i][chName],cmd)) return SendClientMessage(playerid,red," .כבר קיים צ'אט בשם שבחרת");
			new cid = CreateChat(cmd);
			SendFormat(playerid,green," .נפתח בהצלחה " @c(white) "%s" @c(green) " הצ'אט",cmd);
			JoinChat(playerid,cid);
			PlayerInfo[playerid][pChatAdmin] = true;
		}
		else if(equal(cmd,"destroy"))
		{
			if(!PlayerInfo[playerid][pChatAdmin]) return SendClientMessage(playerid,red," .עליך להיות מנהל הצ'אט");
			new oldchat = -1;
			format(cmd,sizeof(cmd)," .%s סגר את הצ'אט %s",ChatInfo[oldchat = PlayerInfo[playerid][pChat]][chName],GetName(playerid));
			Loop(i) if(PlayerInfo[i][pChat] == PlayerInfo[playerid][pChat])
			{
				SendClientMessage(i,red,cmd);
				KickFromChat(i);
			}
			ChatCheck4Close(oldchat);
		}
		else if(equal(cmd,"name"))
		{
			if(!PlayerInfo[playerid][pChatAdmin]) return SendClientMessage(playerid,red," .עליך להיות מנהל הצ'אט");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /chatopt name [new name] :צורת השימוש");
			if(strlen(cmd) < 3 || strlen(cmd) > 15 || equal(cmd,"default")) return SendClientMessage(playerid,red," .שם הצ'אט שבחרת אינו תקין");
			if(equal(cmd,ChatInfo[PlayerInfo[playerid][pChat]][chName])) return SendClientMessage(playerid,red," .השם זהה לשם הנוכחי");
			format(ChatInfo[PlayerInfo[playerid][pChat]][chName],32,cmd);
			format(cmd,sizeof(cmd)," .%s-שינה את שם הצ'אט ל %s",ChatInfo[PlayerInfo[playerid][pChat]][chName],GetName(playerid));
			Loop(i) if(PlayerInfo[i][pChat] == PlayerInfo[playerid][pChat]) SendClientMessage(i,green,cmd);
		}
		else if(equal(cmd,"pass"))
		{
			if(!PlayerInfo[playerid][pChatAdmin]) return SendClientMessage(playerid,red," .עליך להיות מנהל הצ'אט");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /chatopt pass [new pass] :צורת השימוש");
			if(strlen(cmd) < 3 || strlen(cmd) > 12) return SendClientMessage(playerid,red," .הסיסמא שבחרת אינה תקינה");
			if(equal(cmd,ChatInfo[PlayerInfo[playerid][pChat]][chPassword])) return SendClientMessage(playerid,red," .הסיסמא זהה לסיסמא הנוכחית");
			format(ChatInfo[PlayerInfo[playerid][pChat]][chPassword],16,cmd);
			format(cmd,sizeof(cmd)," .שינה את סיסמת הצ'אט %s",GetName(playerid));
			Loop(i) if(PlayerInfo[i][pChat] == PlayerInfo[playerid][pChat]) SendClientMessage(i,green,cmd);
		}
		else if(equal(cmd,"open"))
		{
			if(!PlayerInfo[playerid][pChatAdmin]) return SendClientMessage(playerid,red," .עליך להיות מנהל הצ'אט");
			if(!strlen(ChatInfo[PlayerInfo[playerid][pChat]][chPassword])) return SendClientMessage(playerid,red," .הצ'אט כבר פתוח");
			ChatInfo[PlayerInfo[playerid][pChat]][chPassword] = EOS;
			format(cmd,sizeof(cmd)," .הוריד את הסיסמא לצ'אט %s",GetName(playerid));
			Loop(i) if(PlayerInfo[i][pChat] == PlayerInfo[playerid][pChat]) SendClientMessage(i,green,cmd);
		}
		else if(equal(cmd,"kick"))
		{
			if(!PlayerInfo[playerid][pChatAdmin]) return SendClientMessage(playerid,red," .עליך להיות מנהל הצ'אט");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /chatopt kick [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(id == playerid) return SendClientMessage(playerid,red," .אין באפשרותך לבצע את הפקודה הזו על עצמך");
			SendFormat(id,red," .הוציא אותך ממנו %s מנהל הצ'אט",ChatInfo[PlayerInfo[playerid][pChat]][chName]);
			KickFromChat(id);
			format(cmd,sizeof(cmd)," .%s הוציא מהצ'אט את %s",GetName(id),GetName(playerid));
			Loop(i) if(PlayerInfo[i][pChat] == PlayerInfo[playerid][pChat]) SendClientMessage(i,green,cmd);
		}
		else return SendClientMessage(playerid,red," .אפשרות צ'אט שגויה");
		return 1;
	}
	if(equal(cmd,"/radio"))
	{
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
			SendClientMessage(playerid,white," /radio [station id] :צורת השימוש");
			return SendClientMessage(playerid,white," /stations :לרשימת ערוצי הרדיו");
		}
		new id = strval(cmd);
		if(id < 1 || id > sizeof(Radio)) return SendClientMessage(playerid,red," .ערוץ רדיו שגוי");
		SendFormat(playerid,blue," • /saudio :להפסקה ,%s הפעלת השמעה לערוץ הרדיו",Radio[id-1][rdTitle]);
		PlayAudioStreamForPlayer(playerid,Radio[id-1][rdURL]);
		return 1;
	}
	if(equal(cmd,"/stations"))
	{
		SendClientMessage(playerid,lightblue," ~~~ :רשימת ערוצי הרדיו ~~~");
		for(new i = 0; i < sizeof(Radio); i++) SendFormat(playerid,yellow," • %d) %s",i+1,Radio[i][rdTitle]);
		return 1;
	}
	if(equal(cmd,"/play")) return strlen(currentRadio) > 0 ? PlayAudioStreamForPlayer(playerid,currentRadio) : 1;
	if(equal(cmd,"/saudio")) return StopAudioStreamForPlayer(playerid);
	if(equal(cmd,"/activities"))
	{
		SendFormat(playerid,lightblue," ~~~ :%s רשימת הפעילויות של עולם ~~~",Worlds[PlayerInfo[playerid][pWorld]][wName]);
		new c = 0;
		for(new i = 0; i < sizeof(Activities); i++) if(Activities[i][actWorld] == PlayerInfo[playerid][pWorld]) SendFormat(playerid,green," %d) %s (#%d)",++c,Activities[i][actName],Activities[i][actUID]);
		if(!c) return SendClientMessage(playerid,red," .לא נמצאו פעילויות לעולם זה");
		return 1;
	}
	if(equal(cmd,"/join"))
	{
		if(!WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][0]) return SendClientMessage(playerid,red," .אין פעילות כרגע");
		if(!WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][1]) return SendClientMessage(playerid,red," .זמן ההצטרפות עבר");
		if(PlayerInfo[playerid][pAFK]) return SendClientMessage(playerid,red," .AFK לא ניתן להצטרף לפעילות כאשר אתה במצב");
		if(PlayerInfo[playerid][pInActivity]) return SendClientMessage(playerid,red," /leave :כבר הצטרפת לפעילות, לעזיבה");
		if(!CanUseCommand(playerid)) return 1;
		PlayerInfo[playerid][pInActivity] = true;
		SendFormat(playerid,green," • .אנא המתן בסבלנות עד שהיא תתחיל !%s נרשמת בהצלחה לפעילות",Activities[GetActivityIndex(WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][0])][actName]);
		return 1;
	}
	if(equal(cmd,"/leave"))
	{
		if(!WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][0]) return SendClientMessage(playerid,red," .אין פעילות כרגע");
		if(PlayerInfo[playerid][pAFK]) return SendClientMessage(playerid,red," .AFK לא ניתן להצטרף לפעילות כאשר אתה במצב");
		if(!PlayerInfo[playerid][pInActivity]) return SendClientMessage(playerid,red," /join :אתה לא בפעילות, להצטרפות");
		SendFormat(playerid,green," • !%s עזבת את הפעילות",Activities[GetActivityIndex(WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][0])][actName]);
		LeaveActivity(playerid);
		return 1;
	}
	if(equal(cmd,"/actplayers"))
	{
		if(!WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][0]) return SendClientMessage(playerid,red," .אין פעילות כרגע");
		new pl[MAX_PLAYERS] = {INVALID_PLAYER_ID,...}, pls = 0;
		Loop(i) if(IsPlayerConnected(i) && PlayerInfo[i][pInActivity] && PlayerInfo[i][pWorld] == PlayerInfo[playerid][pWorld]) pl[pls++] = i;
		if(!pls) SendClientMessage(playerid,red," .אין עדיין משתתפים בפעילות");
		else
		{
			SendFormat(playerid,lightblue," ~~~ :[%d] %s משתתפים בפעילות ~~~",pls,Activities[GetActivityIndex(WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][0])][actName]);
			for(new i = 0; i < pls; i++) SendFormat(playerid,grey," %d) " @c(white) "%s",i+1,GetName(pl[i]));
		}
		return 1;
	}
	if(equal(cmd,"/maps"))
	{
		SendFormat(playerid,lightblue," ~~~ :%s רשימת המפות הקיימות בעולם ~~~",Worlds[PlayerInfo[playerid][pWorld]][wName]);
		for(new i = 0, c = 0; i < MAX_MAPS; i++) if(MapInfo[i][mLoaded] && MapInfo[i][mWorld] == PlayerInfo[playerid][pWorld]) SendFormat(playerid,green," %d) %s (כוללת %d אובייקטים, מס\"ד: %d ,%s נוצרה על ידי)",++c,MapInfo[i][mName],MapInfo[i][mObjects],i,MapInfo[i][mAuthor]);
		return 1;
	}
	if(equal(cmd,"/vip"))
	{
		new donator[MAX_PLAYERS] = {INVALID_PLAYER_ID,...}, donators = 0;
		Loop(i) if(IsPlayerConnected(i) && PlayerInfo[i][pVIP] > 0) donator[donators++] = i;
		if(!donators) SendClientMessage(playerid,red," .אין תורמים מחוברים");
		else
		{
			SendFormat(playerid,lightblue," ~~~ :[תורמים מחוברים [%d ~~~",donators);
			for(new i = 0; i < donators; i++) SendFormat(playerid,grey," %d) " @c(white) "%s" @c(grey) " [ID: %03d | VIP Level: %d]",++i,GetName(donator[i]),donator[i],PlayerInfo[donator[i]][pVIP]);
		}
		return 1;
	}
	if(equal(cmd,"/donators"))
	{
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd) || !IsNumeric(cmd))
		{
			SendClientMessage(playerid,white," /donators [menu id] :צורת השימוש");
			SendClientMessage(playerid,white," /donators 1 - בונוסים לתורמים");
			SendClientMessage(playerid,white," /donators 2 - פקודות מיוחדות לתורמים");
			return 1;
		}
		new menu = strval(cmd);
		switch(menu)
		{
			case 1:
			{
				SendClientMessage(playerid,lightblue," ~~~ :בונוסים לתורמים ~~~");
				SendFormat(playerid,yellow," • תוספת רווח באזורי כסף: $%d",ServerConfig[cfgVIPMoneyAreaBonus]);
				SendFormat(playerid,yellow," • תוספת אחוז כסף מהנכסים: %d%c",ServerConfig[cfgVIPPropertyPercentBonus],'%');
			}
			case 2:
			{
				SendClientMessage(playerid,white,"Soon");
			}
			default: SendClientMessage(playerid,red," .תפריט שגוי");
		}
		return 1;
	}
	for(new i = 0; i < sizeof(DMZones); i++) if(equal(DMZones[i][dmCommand],cmd))
	{
		if(PlayerInfo[playerid][pAFK]) return SendClientMessage(playerid,red," .AFK לא ניתן להשתגר כאשר אתה במצב");
		if(PlayerInfo[playerid][pConnectStage] != ct_playing) return SendClientMessage(playerid,red," .עליך להתחיל לשחק כדי להשתגר");
		if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו כאשר אתה במעקב");
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(PlayerInfo[playerid][pDMZone] == i) return SendClientMessage(playerid,red," .אתה כבר נמצא באזור הדיאם הזה");
		if(!CanUseCommand(playerid,.dmz = false)) return 1;
		GoToDMZone(playerid,PlayerInfo[playerid][pDMZone] = i);
		PlayerInfo[playerid][pHeadshots] = DMZones[i][dmHeadshots];
		SetCameraBehindPlayer(playerid);
		SendFormat(playerid,green," • \"%s\" ברוכים הבאים לאזור הדי-אם",DMZones[i][dmName]);
		if(PlayerInfo[playerid][pHeadshots]) SendClientMessage(playerid,grey," (באזור זה מופעלת אפשרות הד-שוט)");
		PlaySound(playerid,1132);
		return 1;
	}
	if(equal(cmd,"/dm"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		SendFormat(playerid,lightblue," ~~~ :רשימת %d אזורי הדי-אם בשרת ~~~",sizeof(DMZones));
		for(new i = 0; i < sizeof(DMZones); i++) SendFormat(playerid,orange," • %d) %s - %s",i+1,DMZones[i][dmName],DMZones[i][dmCommand]);
		return 1;
	}
	if(equal(cmd,"/qdmz"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(PlayerInfo[playerid][pDMZone] == -1) return SendClientMessage(playerid,red," .אתה לא נמצא באיזור די-אם");
		SendFormat(playerid,green," • \"%s\" יצאת מאיזור הדי-אם",DMZones[PlayerInfo[playerid][pDMZone]][dmName]);
		PlayerInfo[playerid][pDMZone] = -1, PlayerInfo[playerid][pHeadshots] = false;
		SetPlayerInterior(playerid,0);
		SpawnPlayer(playerid);
		return 1;
	}
	if(equal(cmd,"/clan") || (equal(cmd,"/c") && (PlayerInfo[playerid][pWorld] == world_dm)))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
			SendClientMessage(playerid,white," /c[action] או /clan [action] :צורת השימוש");
			SendClientMessage(playerid,white," invite - הזמנה לקלאן | quit - יציאה מקלאן");
			SendClientMessage(playerid,white," accept - אישור הזמנה | cancel - ביטול הזמנה");
			SendClientMessage(playerid,white," kick - הוצאה מהקלאן | kickn - הוצאת שחקן לא מחובר");
			SendClientMessage(playerid,white," setlevel - שינוי רמת גישות | edit - עריכת פרטי הקלאן");
			SendClientMessage(playerid,white," color - צבע הקלאן | info - מידע על הקלאן");
			SendClientMessage(playerid,white," members - חברי הקלאן");
			return 1;
		}
		new f[32];
		if(equal(cmd,"invite"))
		{
			if(!PlayerInfo[playerid][pGroup][group_clan]) return SendClientMessage(playerid,red," .אתה לא בקלאן");
			if(!HasGroupPermission(playerid,4,group_clan)) return 1;
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /clan invite [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(id == playerid) return SendClientMessage(playerid,red," .אינך יכול להזמין את עצמך");
			if(PlayerInfo[id][pGroup][group_clan] > 0) return SendFormat(playerid,red," .%s כבר נמצא בקלאן %s",GroupInfo[PlayerInfo[id][pGroup][group_clan]][gName],GetName(id));
	 		if(PlayerInfo[id][pGroupInvite][group_clan] == PlayerInfo[playerid][pGroup][group_clan]) return SendClientMessage(playerid,red," .כבר שלחת הזמנה למשתמש הזה לקלאן שלך");
			if(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers] >= MAX_GROUP_MEMBERS) return SendClientMessage(playerid,red," .בקלאן יש כבר יותר מדי מחוברים");
			SendFormat(playerid,green," .%s לקלאן %s-שלחת הזמנה ל",GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gName],GetName(id));
			SendFormat(id,green," /clan accept :להצטרפות ,/clan accept :לביטול ,%s שלח לך הזמנה לקלאן %s",GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gName],GetName(playerid));
			PlayerInfo[id][pGroupInvite][group_clan] = PlayerInfo[playerid][pGroup][group_clan];
			frmt(" .%s-שלח הזמנה לקלאן ל %s",GetName(id),GetName(playerid));
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers]; i++) if(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i] != playerid) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i],green,fstring);
		}
		else if(equal(cmd,"accept"))
		{
	 		if(!PlayerInfo[playerid][pGroupInvite][group_clan]) return SendClientMessage(playerid,red," .לא קיבלת הזמנה לקלאן");
			if(PlayerInfo[playerid][pGroup][group_clan] > 0) return SendClientMessage(playerid,red," .אתה כבר בקלאן");
			groupAdd(PlayerInfo[playerid][pGroupInvite][group_clan],playerid);
			groupLoad(playerid);
			SendFormat(playerid,green," .%s הצטרפת לקלאן",GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gName]);
			frmt(" .%s הצטרף לקלאן %s",GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gName],GetName(playerid));
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers]; i++) if(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i] != playerid) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i],green,fstring);
		}
		else if(equal(cmd,"cancel"))
		{
	 		if(!PlayerInfo[playerid][pGroupInvite][group_clan]) return SendClientMessage(playerid,red," .לא קיבלת הזמנה לקלאן");
	 		PlayerInfo[playerid][pGroupInvite][group_clan] = 0;
			SendFormat(playerid,green," .%s ביטלת את ההזמנה לקלאן",GroupInfo[PlayerInfo[playerid][pGroupInvite][group_clan]][gName]);
			frmt(" .%s שלל את ההזמנה להצטרפות לקלאן %s",GroupInfo[PlayerInfo[playerid][pGroupInvite][group_clan]][gName],GetName(playerid));
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers]; i++) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i],green,fstring);
		}
		else if(equal(cmd,"quit"))
		{
			if(!PlayerInfo[playerid][pGroup][group_clan]) return SendClientMessage(playerid,red," .אתה לא בקלאן");
			new c = PlayerInfo[playerid][pGroup][group_clan];
			groupDel(c,playerid);
			groupLoad(playerid);
			SendFormat(playerid,green," .%s יצאת מהקלאן",GroupInfo[c][gName]);
			frmt(" .%s יצא מהקלאן %s",GroupInfo[c][gName],GetName(playerid));
			for(new i = 0; i < GroupInfo[c][gMembers]; i++) if(GroupInfo[c][gMember][i] != playerid) SendClientMessage(GroupInfo[c][gMember][i],green,fstring);
		}
		else if(equal(cmd,"kick"))
		{
			if(!PlayerInfo[playerid][pGroup][group_clan]) return SendClientMessage(playerid,red," .אתה לא בקלאן");
			if(!HasGroupPermission(playerid,3,group_clan)) return 1;
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /clan kick [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(id == playerid) return SendClientMessage(playerid,red," /clan quit :אינך יכול להוציא את עצמך, השתמש ב");
			if(PlayerInfo[playerid][pGroupLevel][group_clan] < PlayerInfo[id][pGroupLevel][group_clan]) return SendClientMessage(playerid,red," .אין באפשרותך להעיף מהקלאן שחקן ברמת גישות גבוהה משלך");
			if(PlayerInfo[id][pGroup][group_clan] != PlayerInfo[playerid][pGroup][group_clan]) return SendFormat(playerid,red," .לא נמצא בקלאן שלך %s",GetName(id));
			SendFormat(playerid,red," .%s הוצאת מהקלאן את",GetName(id));
			SendFormat(id,red," .%s הוציא אותך מהקלאן %s",GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gName],GetName(playerid));
			frmt(" .%s הוציא מהקלאן את %s",GetName(id),GetName(playerid));
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers]; i++) if(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i] != playerid && GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i] != id) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i],green,fstring);
			groupDel(PlayerInfo[playerid][pGroup][group_clan],id);
		}
		else if(equal(cmd,"kickn"))
		{
			if(!PlayerInfo[playerid][pGroup][group_clan]) return SendClientMessage(playerid,red," .אתה לא בקלאן");
			if(!HasGroupPermission(playerid,3,group_clan)) return 1;
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /clan kickn [username] :צורת השימוש");
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers]; i++) if(equal(GetName(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i]),cmd)) return SendClientMessage(playerid,red," /clan kick :משתמש זה מחובר לשרת, תשתמש בפקודה");
			new id = GetUserIDByName(cmd), kickedname[MAX_PLAYER_NAME];
			format(f,32,dir_users "%d.ini",id);
			if(!id || !fexist(f)) return SendClientMessage(playerid,red," .משתמש לא נמצא");
			if(fgetint(f,GroupTypes[group_clan]) != PlayerInfo[playerid][pGroup][group_clan]) return SendClientMessage(playerid,red," .משתמש זה לא בקלאן שלך");
			if(PlayerInfo[playerid][pGroupLevel][group_clan] < fgetint(f,frmt("%sLevel",GroupTypes[group_clan]))) return SendClientMessage(playerid,red," .אין באפשרותך להעיף מהקלאן שחקן ברמת גישות גבוהה משלך");
			fsetint(f,GroupTypes[group_clan],0);
			fsetint(f,frmt("%sLevel",GroupTypes[group_clan]),1);
			format(kickedname,sizeof(kickedname),fgetstring(f,"Nickname"));
			SendFormat(playerid,green," .מהקלאן %s הוצאת את",kickedname);
			frmt(" .%s הוציא מהקלאן את %s",kickedname,GetName(playerid));
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers]; i++) if(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i] != playerid) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i],green,fstring);
		}
		else if(equal(cmd,"setlevel"))
		{
			if(!PlayerInfo[playerid][pGroup][group_clan]) return SendClientMessage(playerid,red," .אתה לא בקלאן");
			if(!HasGroupPermission(playerid,5,group_clan)) return 1;
			new cmd2[64];
			cmd = strtok(cmdtext,idx), cmd2 = strtok(cmdtext,idx);
			if(!strlen(cmd) || !strlen(cmd2)) return SendClientMessage(playerid,white," /clan setlevel [id/name] [1-" #MAX_CLAN_LEVEL "] :צורת השימוש");
			new id = ReturnUser(cmd,playerid), lvl = strval(cmd2);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(PlayerInfo[id][pGroup][group_clan] != PlayerInfo[playerid][pGroup][group_clan]) return SendFormat(playerid,red," .לא נמצא בקלאן שלך %s",GetName(id));
			if(lvl < 1 || lvl > MAX_CLAN_LEVEL) return SendClientMessage(playerid,red," .רמת גישות שגויה");
			if(lvl > PlayerInfo[id][pGroupLevel][group_clan]) return SendClientMessage(playerid,red," .לא ניתן להעלות את רמת הגישות מעל לרמה הנוכחית שלך");
			PlayerInfo[id][pGroupLevel][group_clan] = lvl;
			if(PlayerInfo[id][pLogged]) fsetint(uf(id),frmt("%sLevel",GroupTypes[group_clan]),lvl);
			SendFormat(playerid,green," .ל-%d %s שינית את רמת הגישות של",lvl,GetName(id));
			SendFormat(id,green," .שינה את רמת הגישות שלך ל-%d %s",lvl,GetName(playerid));
			frmt(" .בקלאן ל-%d %s שינה את רמת הגישות של %s",lvl,GetName(id),GetName(playerid));
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers]; i++) if(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i] != playerid && GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i] != id) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i],green,fstring);
		}
		else if(equal(cmd,"edit"))
		{
			if(!PlayerInfo[playerid][pGroup][group_clan]) return SendClientMessage(playerid,red," .אתה לא בקלאן");
			if(!GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gHeadquarter]) return SendClientMessage(playerid,red," .לקלאן שלך אין מפקדה");
			if(!HasGroupPermission(playerid,3,group_clan)) return 1;
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd) || IsNumeric(cmd))
			{
				SendClientMessage(playerid,white," /clan edit [edit type] :צורת השימוש");
				SendClientMessage(playerid,white," cmd - עריכת פקודת השיגור למפקדת הקלאן");
				SendClientMessage(playerid,white," foot - עריכת מיקום השיגור למפקדה");
				SendClientMessage(playerid,white," vehicle - עריכת מיקום השיגור למפקדה ברכב");
				return 1;
			}
			format(f,sizeof(f),dir_groups "%s-%s.ini",GroupTypes[group_clan],GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gName]);
			if(equal(cmd,"cmd"))
			{
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd))
				{
					SendClientMessage(playerid,white," /clan edit cmd [command] :צורת השימוש");
					SendClientMessage(playerid,white," / :יש לרשום את שם הפקודה ללא סלאש");
					return 1;
				}
				if(cmd[0] == '/' || cmd[0] == ' ') strdel(cmd,0,1);
				if(strlen(cmd) > 12) return SendClientMessage(playerid,red," .הפקודה ארוכה מדי");
				format(HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqCommand],16,"/%s",cmd);
				fsetstring(f,"HQCMD",cmd);
				frmt(" .%s-שינה את הפקודה לשיגור למפקדה ל %s",cmd,GetName(playerid));
				for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers]; i++) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i],green,fstring);
			}
			else if(equal(cmd,"foot"))
			{
				GetPlayerPos(playerid,HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqPos][0],HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqPos][1],HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqPos][2]);
				GetPlayerFacingAngle(playerid,HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqPos][3]);
				fsetstring(f,"HQPos",frmt("%.4f,%.4f,%.4f,%.4f",HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqPos][0],HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqPos][1],HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqPos][2],HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqPos][3]));
				frmt(" .שינה את השיגור למפקדה %s",GetName(playerid));
				for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers]; i++) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i],green,fstring);
			}
			else if(equal(cmd,"vehicle"))
			{
				if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red," .לשימוש בפקודה זו עליך להיות ברכב");
				GetVehiclePos(GetPlayerVehicleID(playerid),HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqVPos][0],HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqVPos][1],HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqVPos][2]);
				GetVehicleZAngle(GetPlayerVehicleID(playerid),HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqVPos][3]);
				fsetstring(f,"HQVPos",frmt("%.4f,%.4f,%.4f,%.4f",HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqVPos][0],HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqVPos][1],HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqVPos][2],HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqVPos][3]));
				frmt(" .שינה את השיגור למפקדה ברכב %s",GetName(playerid));
				for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers]; i++) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i],green,fstring);
			}
			else return SendClientMessage(playerid,red," .אפשרות עריכת קלאן שגויה");
		}
		else if(equal(cmd,"color"))
		{
			if(!PlayerInfo[playerid][pGroup][group_clan]) return SendClientMessage(playerid,red," .אתה לא בקלאן");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /clan color [show/edit] :צורת השימוש");
			if(equal(cmd,"show"))
			{
				new c = PlayerInfo[playerid][pGroup][group_clan];
				SendFormat(playerid,rgba2hex(GroupInfo[c][gColor][0],GroupInfo[c][gColor][1],GroupInfo[c][gColor][2],255)," %d, %d, %d :מספרי צבע הקלאן הם",GroupInfo[c][gColor][0],GroupInfo[c][gColor][1],GroupInfo[c][gColor][2]);
			}
			else if(equal(cmd,"edit"))
			{
				if(!HasGroupPermission(playerid,4,group_clan)) return 1;
				new r, g, b;
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd) || !IsNumeric(cmd)) return SendClientMessage(playerid,white," /clan color edit [red 0-255] [green 0-255] [blue 0-255] :צורת השימוש");
				r = strval(cmd), cmd = strtok(cmdtext,idx), g = !strlen(cmd) || !IsNumeric(cmd) ? r : strval(cmd), cmd = strtok(cmdtext,idx), b = !strlen(cmd) || !IsNumeric(cmd) ? g : strval(cmd);
				if(r < 0 || r > 255 || g < 0 || g > 255 || b < 0 || b > 255) return SendClientMessage(playerid,red," .אחד מהצבעים שגוי");
				format(f,sizeof(f),dir_groups "%s-%s.ini",GroupTypes[group_clan],GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gName]);
				fsetint(f,"R",GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gColor][0] = r);
				fsetint(f,"G",GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gColor][1] = g);
				fsetint(f,"B",GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gColor][2] = b);
				new c = rgba2hex(r,g,b,PLAYER_ALPHA);
				frmt(" .שינה את צבע הקלאן לצבע ההודעה הזאת %s",GetName(playerid));
				for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers]; i++)
				{
					SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i],c,fstring);
					SetPlayerColor2(GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i],c);
				}
			}
			else return SendClientMessage(playerid,red," .אפשרות עריכת צבע קלאן שגויה");
		}
		else if(equal(cmd,"info"))
		{
			cmd = strtok(cmdtext,idx);
			new clanid = !strlen(cmd) ? PlayerInfo[playerid][pGroup][group_clan] : gid(cmd,group_clan);
			if(!clanid) return SendClientMessage(playerid,!strlen(cmd) ? white : red,!strlen(cmd) ? (" /clan info [clan name] :צורת השימוש") : (" .קלאן לא נמצא"));
			SendFormat(playerid,lightblue," ~~~ :%s הקלאן ~~~",GroupInfo[clanid][gName]);
			SendFormat(playerid,grey," שחקנים מחוברים: %d",GroupInfo[clanid][gMembers]);
			SendFormat(playerid,grey," מפקדה: %s",GroupInfo[clanid][gHeadquarter] ? ("יש") : ("אין"));
			SendClientMessage(playerid,rgba2hex(GroupInfo[clanid][gColor][0],GroupInfo[clanid][gColor][1],GroupInfo[clanid][gColor][2],255)," - צבע הקלאן -");
		}
		else if(equal(cmd,"members"))
		{
			cmd = strtok(cmdtext,idx);
			new clanid = !strlen(cmd) ? PlayerInfo[playerid][pGroup][group_clan] : gid(cmd,group_clan);
			if(!clanid) return SendClientMessage(playerid,!strlen(cmd) ? white : red,!strlen(cmd) ? (" /clan info [clan name] :צורת השימוש") : (" .קלאן לא נמצא"));
			if(!GroupInfo[clanid][gMembers]) return SendClientMessage(playerid,red," .לקלאן זה אין שחקנים מחוברים");
			SendFormat(playerid,lightblue," ~~~ :(%d) %s הקלאן ~~~",GroupInfo[clanid][gMembers],GroupInfo[clanid][gName]);
			for(new i = 0, pl; i < GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMembers]; i++)
			{
				pl = GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gMember][i];
				SendFormat(playerid,PlayerInfo[playerid][pGroupLevel][group_clan] == 5 ? orange : yellow," %d) %s [ID: %03d | Clan Level: %d]",i+1,GetName(pl),pl,PlayerInfo[pl][pGroupLevel][group_clan]);
			}
		}
		else return SendClientMessage(playerid,red," .אפשרות קלאן שגויה");
		return 1;
	}
	if(equal(cmd,"/clans"))
	{
		new c = 0;
		for(new i = 1; i < MAX_GROUPS; i++) if(GroupInfo[i][gType] == group_clan)
		{
			if(!c) SendClientMessage(playerid,lightblue," ~~~ :רשימת הקלאנים בשרת ~~~");
			SendFormat(playerid,rgba2hex(GroupInfo[i][gColor][0],GroupInfo[i][gColor][1],GroupInfo[i][gColor][2],255)," %d) %s (%d players)",++c,GroupInfo[i][gName],GroupInfo[i][gMembers]);
		}
		if(!c) return SendClientMessage(playerid,red," .אין קלאנים בשרת כרגע");
		return 1;
	}
	if(equal(cmd,"/hq"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(!PlayerInfo[playerid][pGroup][group_clan]) return SendClientMessage(playerid,red," .אתה לא בקלאן");
		if(!GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gHeadquarter]) return SendClientMessage(playerid,red," .לקלאן שלך אין מפקדה");
		if(!CanTeleport(playerid)) return 1;
		hqGoto(playerid,PlayerInfo[playerid][pGroup][group_clan]);
		return 1;
	}
	if(PlayerInfo[playerid][pGroup][group_clan] > 0 && GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gHeadquarter] && equal(cmd,HeadquarterInfo[PlayerInfo[playerid][pGroup][group_clan]][hqCommand]))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(!CanTeleport(playerid)) return 1;
		hqGoto(playerid,PlayerInfo[playerid][pGroup][group_clan]);
		return 1;
	}
	if(equal(cmd,"/og") || equal(cmd,"/cg"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(!PlayerInfo[playerid][pGroup][group_clan]) return SendClientMessage(playerid,red," .אתה לא בקלאן");
		if(!GroupInfo[PlayerInfo[playerid][pGroup][group_clan]][gHeadquarter]) return SendClientMessage(playerid,red," .לקלאן שלך אין מפקדה");
		new id = FindAnyCloseMoveObject(playerid,PlayerInfo[playerid][pGroup][group_clan]), Float:p[3];
		if(id == -1) return SendClientMessage(playerid,red," .אין לידך שום אובייקט שניתן לפתיחה ושייך לקלאן שלך");
		p = MoveObjectInfo[id][moStatus] ? MoveObjectInfo[id][moPos] : MoveObjectInfo[id][moMPos];
		MoveDynamicObject(MoveObjectInfo[id][moObjectID],p[0],p[1],p[2],7.0);
		return 1;
	}
	if(equal(cmd,"/deposit"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(GetPlayerCheckpoint(playerid) != cp_bank || !IsPlayerInCheckpoint(playerid)) return SendClientMessage(playerid,red," .עליך להיות בבנק בכדי לבצע פקודה זו");
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd) || !IsNumeric(cmd)) return SendClientMessage(playerid,white," /deposit [amount] :צורת השימוש");
		new amount = strval(cmd);
		if(amount < 1 || amount > GetMoney(playerid)) return SendClientMessage(playerid,red," .סכום הפקדה שגוי");
		if(Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit] != 0)
		{
			if(PlayerInfo[playerid][pBank] >= Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit]) return SendFormat(playerid,red," אינך יכול להכניס עוד כסף לחשבון הבנק שלך מפני שהגעת למגבלה: $%d",Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit]);
			if(PlayerInfo[playerid][pBank]+amount > Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit])
			{
				new prev_am = amount;
				amount = Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit]-PlayerInfo[playerid][pBank];
				SendFormat(playerid,red," (מפני שהסכום שהכנסת עוקף את הגבלת הבנק שלך, הוכנס רק חלק מהסכום: $%d במקום $%d (מגבלת הבנק שלך: $%d",Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit],prev_am,amount);
			}
		}
		GiveMoney(playerid,0-amount);
		PlayerInfo[playerid][pBank] += amount;
		if(PlayerInfo[playerid][pLogged]) fsetint(uf(playerid),"Bank",PlayerInfo[playerid][pBank]);
		SendFormat(playerid,yellow," .הפקדת $%d בחשבון הבנק שלך, כעת יש לך $%d",amount,PlayerInfo[playerid][pBank]);
		return 1;
	}
	if(equal(cmd,"/withdraw"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(GetPlayerCheckpoint(playerid) != cp_bank || !IsPlayerInCheckpoint(playerid)) return SendClientMessage(playerid,red," .עליך להיות בבנק בכדי לבצע פקודה זו");
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd) || !IsNumeric(cmd)) return SendClientMessage(playerid,white," /withdraw [amount] :צורת השימוש");
		new amount = strval(cmd);
		if(amount < 1 || amount > PlayerInfo[playerid][pBank]) return SendClientMessage(playerid,red," .סכום הוצאה שגוי");
		GiveMoney(playerid,amount);
		PlayerInfo[playerid][pBank] -= amount;
		if(PlayerInfo[playerid][pLogged]) fsetint(uf(playerid),"Bank",PlayerInfo[playerid][pBank]);
		SendFormat(playerid,yellow," .הוצאת $%d מחשבון הבנק שלך, כעת יש לך $%d",amount,PlayerInfo[playerid][pBank]);
		return 1;
	}
	if(equal(cmd,"/depositall"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(GetPlayerCheckpoint(playerid) != cp_bank || !IsPlayerInCheckpoint(playerid)) return SendClientMessage(playerid,red," .עליך להיות בבנק בכדי לבצע פקודה זו");
		if(GetMoney(playerid) <= 0) return SendClientMessage(playerid,red," .אין בידך כסף הניתן להפקדה");
		new amount = GetMoney(playerid);
		if(Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit] != 0)
		{
			if(PlayerInfo[playerid][pBank] >= Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit]) return SendFormat(playerid,red," אינך יכול להכניס עוד כסף לחשבון הבנק שלך מפני שהגעת למגבלה: $%d",Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit]);
			if(PlayerInfo[playerid][pBank]+amount > Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit])
			{
				new prev_am = amount;
				amount = Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit]-PlayerInfo[playerid][pBank];
				SendFormat(playerid,red," (מפני שהסכום שהכנסת עוקף את הגבלת הבנק שלך, הוכנס רק חלק מהסכום: $%d במקום $%d (מגבלת הבנק שלך: $%d",Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit],prev_am,amount);
			}
		}
		GiveMoney(playerid,0-amount);
		PlayerInfo[playerid][pBank] += amount;
		if(PlayerInfo[playerid][pLogged]) fsetint(uf(playerid),"Bank",PlayerInfo[playerid][pBank]);
		SendFormat(playerid,yellow," .הפקדת $%d בחשבון הבנק שלך, כעת יש לך $%d",amount,PlayerInfo[playerid][pBank]);
		return 1;
	}
	if(equal(cmd,"/withdrawall"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(GetPlayerCheckpoint(playerid) != cp_bank || !IsPlayerInCheckpoint(playerid)) return SendClientMessage(playerid,red," .עליך להיות בבנק בכדי לבצע פקודה זו");
		if(!PlayerInfo[playerid][pBank]) return SendClientMessage(playerid,red," .אין לך כסף בחשבון הבנק");
		GiveMoney(playerid,PlayerInfo[playerid][pBank]);
		SendFormat(playerid,yellow," .הוצאת את כל הכסף מחשבון הבנק שלך, $%d",PlayerInfo[playerid][pBank]);
		PlayerInfo[playerid][pBank] = 0;
		if(PlayerInfo[playerid][pLogged]) fsetint(uf(playerid),"Bank",PlayerInfo[playerid][pBank]);
		return 1;
	}
	if(equal(cmd,"/balance"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(GetPlayerCheckpoint(playerid) != cp_bank || !IsPlayerInCheckpoint(playerid)) return SendClientMessage(playerid,red," .עליך להיות בבנק בכדי לבצע פקודה זו");
		//SendFormat(playerid,yellow," .יש לך $%d בחשבון הבנק",PlayerInfo[playerid][pBank]);
		if(Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit] != 0) SendFormat(playerid,yellow," .יש לך $%d בחשבון הבנק, ללא מגבלה",PlayerInfo[playerid][pBank]);
		else SendFormat(playerid,yellow," .יש לך $%d בחשבון הבנק, עם מגבלה של $%d",PlayerInfo[playerid][pBank],Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit]);
		return 1;
	}
	if(equal(cmd,"/call"))
	{
		if(!CheckWorld(playerid,false,world_stunts,world_stuntswo)) return 1;
		if(PlayerInfo[playerid][pConnectStage] != ct_playing) return SendClientMessage(playerid,red," .עליך להתחיל לשחק כדי לבצע פקודה זו");
		if(!CanUseCommand(playerid)) return 1;
		new Float:p[4], vmodel, vid, avid = -1;
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /call [vehicle name/model] :צורת השימוש");
		vmodel = IsNumeric(cmd) ? strval(cmd) : GetVehicleModelIDFromName(cmd);
		if(vmodel < 400 || vmodel > 611) return SendClientMessage(playerid,red," .שם הרכב או מודל שגוי");
		for(new i = 0; i < MAX_PLAYER_VEHICLES && avid == -1; i++) if(PlayerInfo[playerid][pCreatedVehicle][i] == INVALID_VEHICLE_ID) avid = i;
		if(avid == -1 || PlayerInfo[playerid][pCreatedVehicles] >= MAX_PLAYER_VEHICLES) return SendClientMessage(playerid,red," .(/del) כל שחקן יכול ליצור עד " #MAX_PLAYER_VEHICLES " רכבים, נא למחוק חלק על מנת ליצור עוד");
		GetPlayerPos(playerid,p[0],p[1],p[2]);
		GetPlayerFacingAngle(playerid,p[3]);
		GetXYInFrontOfPlayer(playerid,p[0],p[1],IsPlayerInAnyVehicle(playerid) ? 10.0 : 5.0);
		vid = CreateVehicleEx(vmodel,p[0],p[1],p[2],p[3]+90,-1,-1,respawntime,PlayerInfo[playerid][pWorld],GetPlayerInterior(playerid));
		VehicleInfo[vid][vCreatedBy] = playerid;
		PlayerInfo[playerid][pCreatedVehicle][avid] = vid;
		PlayerInfo[playerid][pCreatedVehicles]++;
		SendFormat(playerid,yellow," [%d/" #MAX_PLAYER_VEHICLES "] %s :רכב נוצר - /del :למחיקה - /vget :לשיגור",PlayerInfo[playerid][pCreatedVehicles],VehicleName(vmodel));
		return 1;
	}
	if(equal(cmd,"/del"))
	{
		if(!CheckWorld(playerid,false,world_stunts,world_stuntswo)) return 1;
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd) && !PlayerInfo[playerid][pCreatedVehicles]) SendClientMessage(playerid,white," (או בלי לרשום = הרכב האחרון ששיגרת) /del [vehicle id 1-" #MAX_PLAYER_VEHICLES "] :צורת השימוש");
		new v = !strlen(cmd) || !IsNumeric(cmd) ? 0 : strval(cmd);
		v = (!v ? (PlayerInfo[playerid][pCreatedVehicles]) : (v < 1 || v > MAX_PLAYER_VEHICLES ? (v < 1 ? 1 : MAX_PLAYER_VEHICLES) : v))-1;
		if(PlayerInfo[playerid][pCreatedVehicle][v] == INVALID_VEHICLE_ID) return SendClientMessage(playerid,red," .לא שיגרת רכב בסלוט הזה");
		new model = GetVehicleModel(PlayerInfo[playerid][pCreatedVehicle][v]);
		DestroyVehicleEx(PlayerInfo[playerid][pCreatedVehicle][v]);
		for(new i = v; i < PlayerInfo[playerid][pCreatedVehicles] && i < MAX_PLAYER_VEHICLES - 1; i++) PlayerInfo[playerid][pCreatedVehicle][i] = PlayerInfo[playerid][pCreatedVehicle][i + 1];
		PlayerInfo[playerid][pCreatedVehicle][PlayerInfo[playerid][pCreatedVehicles]-1] = INVALID_VEHICLE_ID, PlayerInfo[playerid][pCreatedVehicles]--;
		SendFormat(playerid,yellow," .[%s ,מחקת את הרכב שיצרת [רכב מס' %d",VehicleName(model),v+1);
		return 1;
	}
	if(equal(cmd,"/vget"))
	{
		if(!CheckWorld(playerid,false,world_stunts,world_stuntswo)) return 1;
		if(!CanUseCommand(playerid)) return 1;
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd) && !PlayerInfo[playerid][pCreatedVehicles]) SendClientMessage(playerid,white," (או בלי לרשום = הרכב האחרון ששיגרת) /vget [vehicle id 1-" #MAX_PLAYER_VEHICLES "] :צורת השימוש");
		new v = !strlen(cmd) || !IsNumeric(cmd) ? 1 : strval(cmd), Float:p[4];
		v = !v ? PlayerInfo[playerid][pCreatedVehicles] : ((v < 1 || v > MAX_PLAYER_VEHICLES ? (v < 1 ? 1 : MAX_PLAYER_VEHICLES) : v)-1);
		if(PlayerInfo[playerid][pCreatedVehicle][v] == INVALID_VEHICLE_ID) return SendClientMessage(playerid,red," .לא שיגרת רכב בסלוט הזה");
		GetPlayerPos(playerid,p[0],p[1],p[2]);
		GetPlayerFacingAngle(playerid,p[3]);
		GetXYInFrontOfPlayer(playerid,p[0],p[1],IsPlayerInAnyVehicle(playerid) ? 10.0 : 5.0);
		SetVehiclePos(PlayerInfo[playerid][pCreatedVehicle][v],p[0],p[1],p[2]);
		LinkVehicleToInterior(PlayerInfo[playerid][pCreatedVehicle][v],GetPlayerInterior(playerid));
		SendFormat(playerid,yellow," .[%s ,שיגרת את הרכב שיצרת [רכב מס' %d",VehicleName(GetVehicleModel(PlayerInfo[playerid][pCreatedVehicle][v])),v+1);
		return 1;
	}
	if(equal(cmd,"/weaponlist") || equal(cmd,"/wl"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		const PER_PAGE = 9;
		new pages = sizeof(Ammunation) / PER_PAGE + (_:(sizeof(Ammunation) % PER_PAGE > 0));
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd) || !IsNumeric(cmd)) return SendFormat(playerid,white," /weaponlist(wl) [1-%d] :צורת השימוש",pages);
		new page = strval(cmd);
		if(page < 1 || page > pages) return SendClientMessage(playerid,red," .תפריט נשקים שגוי");
		SendFormat(playerid,lightblue," ~~~ :רשימת הנשקים - %d/%d ~~~",page,pages);
		for(new i = (page-1)*PER_PAGE; i < (page*PER_PAGE) && i < sizeof(Ammunation); i++) SendFormat(playerid,i % 2 == 0 ? yellow : green," • %02d) %s [Cost: $%d | Ammo: %d | Level: %d]",(i + 1),Ammunation[i][aName],Ammunation[i][aCost],Ammunation[i][aAmmo],Ammunation[i][aLevel]);
		return 1;
	}
	if(equal(cmd,"/buyweapon") || equal(cmd,"/bw"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(GetPlayerCheckpoint(playerid) != cp_ammu || !IsPlayerInCheckpoint(playerid)) return SendClientMessage(playerid,red," .עליך להיות בחנות הנשקים בכדי לבצע פקודה זו");
		new weaponid, times;
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd) || !IsNumeric(cmd)) return SendClientMessage(playerid,white," /bw [weapon number] [times] :צורת השימוש");
		weaponid = strval(cmd), cmd = strtok(cmdtext,idx), times = !strlen(cmd) || !IsNumeric(cmd) ? 1 : strval(cmd);
		if(weaponid < 1 || weaponid > sizeof(Ammunation)) return SendClientMessage(playerid,red," .מספר נשק שגוי");
		weaponid--;
		if(PlayerInfo[playerid][pLevel] < Ammunation[weaponid][aLevel]) return SendFormat(playerid,red," .%s עליך להיות לפחות ברמה %d על מנת שתוכל לקנות את הנשק",Ammunation[weaponid][aName],Ammunation[weaponid][aLevel]);
		if(GetMoney(playerid) < (Ammunation[weaponid][aCost]*times)) return SendFormat(playerid,red," .אין לך מספיק כסף - הנשק עולה $%d, חסרים לך עוד $%d",Ammunation[weaponid][aCost]*times,(Ammunation[weaponid][aCost]*times)-GetMoney(playerid));
		if(times < 1) return SendClientMessage(playerid,red," .מספר פעמי קנייה נמוך מדי");
		if(times > 20) return SendClientMessage(playerid,red," .מספר פעמי קנייה גדול מדי - ניתן לקנות עד 20 פעמים");
		PlayerInfo[playerid][pWeapons][Ammunation[weaponid][aSlot]] = Ammunation[weaponid][aWeapon];
		if(Ammunation[weaponid][aSlot] < 8) PlayerInfo[playerid][pAmmo][Ammunation[weaponid][aSlot]] += times;
		GiveWeapon(playerid,Ammunation[weaponid][aWeapon],Ammunation[weaponid][aAmmo]*times);
		GiveMoney(playerid,0-(Ammunation[weaponid][aCost]*times));
		fsetint(uf(playerid),frmt("Weapon-%d",Ammunation[weaponid][aSlot]),Ammunation[weaponid][aWeapon]);
		if(Ammunation[weaponid][aSlot] != 8 && Ammunation[weaponid][aSlot] != 9) fsetint(uf(playerid),frmt("Ammo-%d",Ammunation[weaponid][aSlot]),PlayerInfo[playerid][pAmmo][Ammunation[weaponid][aSlot]]);
		if(times != 1) SendFormat(playerid,green," • .%s רכשת %d פעמים את הנשק",Ammunation[weaponid][aName],times);
		else SendFormat(playerid,green," • .%s רכשת את הנשק",Ammunation[weaponid][aName]);
		return 1;
	}
	if(equal(cmd,"/removeweapon") || equal(cmd,"/rw"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(GetPlayerCheckpoint(playerid) != cp_ammu || !IsPlayerInCheckpoint(playerid)) return SendClientMessage(playerid,red," .עליך להיות בחנות הנשקים בכדי לבצע פקודה זו");
		new weaponid, wd[2];
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd) || !IsNumeric(cmd)) return SendClientMessage(playerid,white," /rw [weapon number] :צורת השימוש");
		weaponid = strval(cmd), cmd = strtok(cmdtext,idx);
		if(weaponid < 1 || weaponid > sizeof(Ammunation)) return SendClientMessage(playerid,red," .מספר נשק שגוי");
		weaponid--;
		if(!PlayerInfo[playerid][pWeapons][Ammunation[weaponid][aSlot]]) return SendClientMessage(playerid,red," .אין לך את הנשק הזה");
		PlayerInfo[playerid][pWeapons][Ammunation[weaponid][aSlot]] = 0;
		if(Ammunation[weaponid][aSlot] < 8) PlayerInfo[playerid][pAmmo][Ammunation[weaponid][aSlot]] = 0;
		GetPlayerWeaponData(playerid,GetWeaponSlot(Ammunation[weaponid][aWeapon]),wd[0],wd[1]);
		if(wd[1] > 0 && wd[0] == Ammunation[weaponid][aWeapon]) GiveWeapon(playerid,Ammunation[weaponid][aWeapon],0-wd[1]);
		fsetint(uf(playerid),frmt("Weapon-%d",Ammunation[weaponid][aSlot]),0);
		if(Ammunation[weaponid][aSlot] != 8 && Ammunation[weaponid][aSlot] != 9) fsetint(uf(playerid),frmt("Ammo-%d",Ammunation[weaponid][aSlot]),0);
		SendFormat(playerid,green," • .%s מחקת את הנשק",Ammunation[weaponid][aName]);
		return 1;
	}
	if(equal(cmd,"/buy"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		if(PlayerInfo[playerid][pProps] >= PROP_COUNT) return SendClientMessage(playerid,red," .ניתן לקנות עד " #PROP_COUNT " נכסים");
		new p = GetPlayerProperty(playerid);
		if(p == -1 || GetPlayerVirtualWorld(playerid) != (worlds_gameplay + world_dm)) return SendClientMessage(playerid,red," .אתה לא נמצא בנכס");
		if(PropertyInfo[p][prOwner] == playerid) return SendClientMessage(playerid,red," .הנכס הזה שייך לך");
		if(GetMoney(playerid) < PropertyInfo[p][prCost]) return SendClientMessage(playerid,red," .אין לך מספיק כסף בכדי לקנות את הנכס הזה");
		if(IsPlayerConnected(PropertyInfo[p][prOwner])) return SendFormat(playerid,red," .%s-הנכס הזה כבר שייך ל",GetName(PropertyInfo[p][prOwner]));
		//{
		//	SendFormat(PropertyInfo[p][prOwner],red," .%s נקנה על ידי %s-הנכס שלך, ה",GetName(playerid),PropertyInfo[p][prName]);
		//	PlayerInfo[PropertyInfo[p][prOwner]][pProps]--;
		//}
		PropertyInfo[p][prOwner] = playerid, PlayerInfo[playerid][pEarns][p] = PROP_EARNS, PlayerInfo[playerid][pProps]++;
		GiveMoney(playerid,0-PropertyInfo[p][prCost]);
		SendFormat(playerid,green," • !%s קנית את הנכס",PropertyInfo[p][prName]);
		frmt(" • %s קנה את הנכס %s",PropertyInfo[p][prName],GetName(playerid));
		Loop(i) if(PlayerInfo[i][pWorld] == world_dm && i != playerid) SendClientMessage(i,green,fstring);
		return 1;
	}
	if(equal(cmd,"/properties") || equal(cmd,"/props"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		const PER_PAGE = 9;
		new pages = props_count / PER_PAGE + (_:(props_count % PER_PAGE > 0)), page = 0;
		if(pages > 1)
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd) || !IsNumeric(cmd)) return SendFormat(playerid,white," /properties(props) [1-%d] :צורת השימוש",pages);
			page = strval(cmd);
		}
		else page = 1;
		if(page < 1 || page > pages) return SendClientMessage(playerid,red," .תפריט נשקים שגוי");
		SendFormat(playerid,lightblue," ~~~ :רשימת הנכסים - %d/%d ~~~",page,pages);
		for(new i = (page-1)*PER_PAGE, c, e, n[MAX_PLAYER_NAME]; i < (page*PER_PAGE) && i < props_count; i++)
		{
			c = PropertyInfo[i][prCost], e = PropertyInfo[i][prEarning];
			if(IsPlayerConnected(PropertyInfo[i][prOwner])) format(n,sizeof(n),GetName(PropertyInfo[i][prOwner]));
			else n = "None";
			SendFormat(playerid,i % 2 == 0 ? yellow : green," • %02d) %s [Cost: $%d | Earnings: $%d | Owner: %s | Total Earn: $%d (saving $%d = %.0f%c)]",(i + 1),PropertyInfo[i][prName],c,e,n,e*PROP_EARNS,(e*PROP_EARNS)-c,floatmul(floatdiv(float((e*PROP_EARNS)-c),float(c)),100.0),'%');
		}
		return 1;
	}
	if(equal(cmd,"/earnings"))
	{
		if(!CheckWorld(playerid,false,world_dm)) return 1;
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd) || IsNumeric(cmd)) return SendClientMessage(playerid,white," /earnings [none/normal/bank] :צורת השימוש");
		if(equal(cmd,"none"))
		{
			PlayerInfo[playerid][pEarnType] = 0;
			SendClientMessage(playerid,green," .מעכשיו לא תרוויח כסף מהנכסים");
		}
		else if(equal(cmd,"normal"))
		{
			PlayerInfo[playerid][pEarnType] = 1;
			SendClientMessage(playerid,green," .מעכשיו תקבל כסף מהנכסים");
		}
		else if(equal(cmd,"bank"))
		{
			PlayerInfo[playerid][pEarnType] = 2;
			SendClientMessage(playerid,green," .מעכשיו הכסף שתרוויח מהנכסים יועבר לבנק");
		}
		else return SendClientMessage(playerid,red," .אפשרות שגויה");
		return 1;
	}
	if(equal(cmd,"/crew") || (equal(cmd,"/c") && (PlayerInfo[playerid][pWorld] == world_stunts || PlayerInfo[playerid][pWorld] == world_stuntswo)))
	{
		if(!CheckWorld(playerid,false,world_stunts,world_stuntswo)) return 1;
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
			SendClientMessage(playerid,white," /c[action] או /crew [action] :צורת השימוש");
			SendClientMessage(playerid,white," invite - הזמנה לקרו | quit - יציאה מקרו");
			SendClientMessage(playerid,white," accept - אישור הזמנה | cancel - ביטול הזמנה");
			SendClientMessage(playerid,white," kick - הוצאה מהקרו | kickn - הוצאת שחקן לא מחובר");
			SendClientMessage(playerid,white," setlevel - שינוי רמת גישות | color - צבע הקרו");
			return 1;
		}
		new f[32];
		if(equal(cmd,"invite"))
		{
			if(!PlayerInfo[playerid][pGroup][group_crew]) return SendClientMessage(playerid,red," .אתה לא בקרו");
			if(!HasGroupPermission(playerid,3,group_crew)) return 1;
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /crew invite [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(id == playerid) return SendClientMessage(playerid,red," .אינך יכול להזמין את עצמך");
			if(PlayerInfo[id][pGroup][group_crew] > 0) return SendFormat(playerid,red," .%s כבר נמצא בקרו %s",GroupInfo[PlayerInfo[id][pGroup][group_crew]][gName],GetName(id));
	 		if(PlayerInfo[id][pGroupInvite][group_crew] == PlayerInfo[playerid][pGroup][group_crew]) return SendClientMessage(playerid,red," .כבר שלחת הזמנה למשתמש הזה לקרו שלךד");
			if(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMembers] >= MAX_GROUP_MEMBERS) return SendClientMessage(playerid,red," .בקרו יש כבר יותר מדי מחוברים");
			SendFormat(playerid,green," .%s לקרו %s-שלחת הזמנה ל",GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gName],GetName(id));
			SendFormat(id,green," /crew accept :להצטרפות ,/crew accept :לביטול ,%s שלח לך הזמנה לקרו %s",GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gName],GetName(playerid));
			PlayerInfo[id][pGroupInvite][group_crew] = PlayerInfo[playerid][pGroup][group_crew];
			frmt(" .%s-שלח הזמנה לקרו ל %s",GetName(id),GetName(playerid));
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMembers]; i++) if(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i] != playerid) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i],green,fstring);
		}
		else if(equal(cmd,"accept"))
		{
	 		if(!PlayerInfo[playerid][pGroupInvite][group_crew]) return SendClientMessage(playerid,red," .לא קיבלת הזמנה לקרו");
			if(PlayerInfo[playerid][pGroup][group_crew] > 0) return SendClientMessage(playerid,red," .אתה כבר בקרו");
			groupAdd(PlayerInfo[playerid][pGroupInvite][group_crew],playerid);
			groupLoad(playerid);
			SendFormat(playerid,green," .%s הצטרפת לקרו",GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gName]);
			frmt(" .%s הצטרף לקרו %s",GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gName],GetName(playerid));
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMembers]; i++) if(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i] != playerid) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i],green,fstring);
		}
		else if(equal(cmd,"cancel"))
		{
	 		if(!PlayerInfo[playerid][pGroupInvite][group_crew]) return SendClientMessage(playerid,red," .לא קיבלת הזמנה לקרו");
	 		PlayerInfo[playerid][pGroupInvite][group_crew] = 0;
			SendFormat(playerid,green," .%s ביטלת את ההזמנה לקרו",GroupInfo[PlayerInfo[playerid][pGroupInvite][group_crew]][gName]);
			frmt(" .%s שלל את ההזמנה להצטרפות לקרו %s",GroupInfo[PlayerInfo[playerid][pGroupInvite][group_crew]][gName],GetName(playerid));
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMembers]; i++) if(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i] != playerid) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i],green,fstring);
		}
		else if(equal(cmd,"quit"))
		{
			if(!PlayerInfo[playerid][pGroup][group_crew]) return SendClientMessage(playerid,red," .אתה לא בקרו");
			new c = PlayerInfo[playerid][pGroup][group_crew];
			groupDel(c,playerid);
			groupLoad(playerid);
			SendFormat(playerid,green," .%s יצאת מהקרו",GroupInfo[c][gName]);
			frmt(" .%s יצא מהקרו %s",GroupInfo[c][gName],GetName(playerid));
			for(new i = 0; i < GroupInfo[c][gMembers]; i++) if(GroupInfo[c][gMember][i] != playerid) SendClientMessage(GroupInfo[c][gMember][i],green,fstring);
		}
		else if(equal(cmd,"kick"))
		{
			if(!PlayerInfo[playerid][pGroup][group_crew]) return SendClientMessage(playerid,red," .אתה לא בקרו");
			if(!HasGroupPermission(playerid,3,group_crew)) return 1;
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /crew kick [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(id == playerid) return SendClientMessage(playerid,red," /crew quit :אינך יכול להוציא את עצמך, השתמש ב");
			if(PlayerInfo[playerid][pGroupLevel][group_crew] < PlayerInfo[id][pGroupLevel][group_crew]) return SendClientMessage(playerid,red," .אין באפשרותך להעיף מהקרו שחקן ברמת גישות גבוהה משלך");
			if(PlayerInfo[id][pGroup][group_crew] != PlayerInfo[playerid][pGroup][group_crew]) return SendFormat(playerid,red," .לא נמצא בקרו שלך %s",GetName(id));
			SendFormat(playerid,red," .%s הוצאת מהקרו את",GetName(id));
			SendFormat(id,red," .%s הוציא אותך מהקרו %s",GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gName],GetName(playerid));
			frmt(" .%s הוציא מהקרו את %s",GetName(id),GetName(playerid));
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMembers]; i++) if(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i] != playerid && GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i] != id) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i],green,fstring);
			groupDel(PlayerInfo[playerid][pGroup][group_crew],id);
		}
		else if(equal(cmd,"kickn"))
		{
			if(!PlayerInfo[playerid][pGroup][group_crew]) return SendClientMessage(playerid,red," .אתה לא בקרו");
			if(!HasGroupPermission(playerid,3,group_crew)) return 1;
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /crew kickn [username] :צורת השימוש");
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMembers]; i++) if(equal(GetName(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i]),cmd)) return SendClientMessage(playerid,red," /crew kick :משתמש זה מחובר לשרת, תשתמש בפקודה");
			new id = GetUserIDByName(cmd), kickedname[MAX_PLAYER_NAME];
			format(f,32,dir_users "%d.ini",id);
			if(!id || !fexist(f)) return SendClientMessage(playerid,red," .משתמש לא נמצא");
			if(fgetint(f,GroupTypes[group_crew]) != PlayerInfo[playerid][pGroup][group_crew]) return SendClientMessage(playerid,red," .משתמש זה לא בקרו שלך");
			if(PlayerInfo[playerid][pGroupLevel][group_crew] < fgetint(f,frmt("%sLevel",GroupTypes[group_crew]))) return SendClientMessage(playerid,red," .אין באפשרותך להעיף מהקרו שחקן ברמת גישות גבוהה משלך");
			fsetint(f,GroupTypes[group_crew],0);
			fsetint(f,frmt("%sLevel",GroupTypes[group_crew]),1);
			format(kickedname,sizeof(kickedname),fgetstring(f,"Nickname"));
			SendFormat(playerid,green," .מהקרו %s הוצאת את",kickedname);
			frmt(" .%s הוציא מהקרו את %s",kickedname,GetName(playerid));
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMembers]; i++) if(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i] != playerid) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i],green,fstring);
		}
		else if(equal(cmd,"setlevel"))
		{
			if(!PlayerInfo[playerid][pGroup][group_crew]) return SendClientMessage(playerid,red," .אתה לא בקרו");
			if(!HasGroupPermission(playerid,5,group_crew)) return 1;
			new cmd2[64];
			cmd = strtok(cmdtext,idx), cmd2 = strtok(cmdtext,idx);
			if(!strlen(cmd) || !strlen(cmd2)) return SendClientMessage(playerid,white," /crew setlevel [id/name] [1-" #MAX_CREW_LEVEL "] :צורת השימוש");
			new id = ReturnUser(cmd,playerid), lvl = strval(cmd2);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(PlayerInfo[id][pGroup][group_crew] != PlayerInfo[playerid][pGroup][group_crew]) return SendFormat(playerid,red," .לא נמצא בקרו שלך %s",GetName(id));
			if(lvl < 1 || lvl > MAX_CREW_LEVEL) return SendClientMessage(playerid,red," .רמת גישות שגויה");
			if(lvl > PlayerInfo[id][pGroupLevel][group_crew]) return SendClientMessage(playerid,red," .לא ניתן להעלות את רמת הגישות מעל לרמה הנוכחית שלך");
			PlayerInfo[id][pGroupLevel][group_crew] = lvl;
			if(PlayerInfo[id][pLogged]) fsetint(uf(id),frmt("%sLevel",GroupTypes[group_crew]),lvl);
			SendFormat(playerid,green," .ל-%d %s שינית את רמת הגישות של",lvl,GetName(id));
			SendFormat(id,green," .שינה את רמת הגישות שלך ל-%d %s",lvl,GetName(playerid));
			frmt(" .בקרו ל-%d %s שינה את רמת הגישות של %s",lvl,GetName(id),GetName(playerid));
			for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMembers]; i++) if(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i] != playerid && GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i] != id) SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i],green,fstring);
		}
		else if(equal(cmd,"color"))
		{
			if(!PlayerInfo[playerid][pGroup][group_crew]) return SendClientMessage(playerid,red," .אתה לא בקרו");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /crew color [show/edit] :צורת השימוש");
			if(equal(cmd,"show"))
			{
				new c = PlayerInfo[playerid][pGroup][group_crew];
				SendFormat(playerid,rgba2hex(GroupInfo[c][gColor][0],GroupInfo[c][gColor][1],GroupInfo[c][gColor][2],255)," %d, %d, %d :מספרי צבע הקרו הם",GroupInfo[c][gColor][0],GroupInfo[c][gColor][1],GroupInfo[c][gColor][2]);
			}
			else if(equal(cmd,"edit"))
			{
				if(!HasGroupPermission(playerid,4,group_crew)) return 1;
				new r, g, b;
				cmd = strtok(cmdtext,idx);
				if(!strlen(cmd) || !IsNumeric(cmd)) return SendClientMessage(playerid,white," /crew color edit [red 0-255] [green 0-255] [blue 0-255] :צורת השימוש");
				SendClientMessage(playerid,white,"1");
				r = strval(cmd), cmd = strtok(cmdtext,idx), g = !strlen(cmd) || !IsNumeric(cmd) ? r : strval(cmd), cmd = strtok(cmdtext,idx), b = !strlen(cmd) || !IsNumeric(cmd) ? g : strval(cmd);
				if(r < 0 || r > 255 || g < 0 || g > 255 || b < 0 || b > 255) return SendClientMessage(playerid,red," .אחד מהצבעים שגוי");
				SendClientMessage(playerid,white,"2");
				format(f,sizeof(f),dir_groups "%s-%s.ini",GroupTypes[group_crew],GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gName]);
				SendClientMessage(playerid,white,"3");
				fsetint(f,"R",GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gColor][0] = r);
				fsetint(f,"G",GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gColor][1] = g);
				fsetint(f,"B",GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gColor][2] = b);
				SendClientMessage(playerid,white,"4");
				new c = rgba2hex(r,g,b,PLAYER_ALPHA);
				frmt(" .שינה את צבע הקרו לצבע ההודעה הזאת %s",GetName(playerid));
				SendClientMessage(playerid,white,"5");
				for(new i = 0; i < GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMembers]; i++)
				{
					SendClientMessage(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i],c,fstring);
					SetPlayerColor2(GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i],c);
				}
			}
			else return SendClientMessage(playerid,red," .אפשרות עריכת צבע קרו שגויה");
		}
		else if(equal(cmd,"info"))
		{
			cmd = strtok(cmdtext,idx);
			new crewid = !strlen(cmd) ? PlayerInfo[playerid][pGroup][group_crew] : gid(cmd,group_crew);
			if(!crewid) return SendClientMessage(playerid,!strlen(cmd) ? white : red,!strlen(cmd) ? (" /crew info [crew name] :צורת השימוש") : (" .קרו לא נמצא"));
			SendFormat(playerid,lightblue," ~~~ :%s הקרו ~~~",GroupInfo[crewid][gName]);
			SendFormat(playerid,grey," שחקנים מחוברים: %d",GroupInfo[crewid][gMembers]);
			SendClientMessage(playerid,rgba2hex(GroupInfo[crewid][gColor][0],GroupInfo[crewid][gColor][1],GroupInfo[crewid][gColor][2],255)," - צבע הקרו -");
		}
		else if(equal(cmd,"members"))
		{
			cmd = strtok(cmdtext,idx);
			new crewid = !strlen(cmd) ? PlayerInfo[playerid][pGroup][group_crew] : gid(cmd,group_crew);
			if(!crewid) return SendClientMessage(playerid,!strlen(cmd) ? white : red,!strlen(cmd) ? (" /crew info [crew name] :צורת השימוש") : (" .קרו לא נמצא"));
			if(!GroupInfo[crewid][gMembers]) return SendClientMessage(playerid,red," .לקרו זה אין שחקנים מחוברים");
			SendFormat(playerid,lightblue," ~~~ :(%d) %s הקרו ~~~",GroupInfo[crewid][gMembers],GroupInfo[crewid][gName]);
			for(new i = 0, pl; i < GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMembers]; i++)
			{
				pl = GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gMember][i];
				SendFormat(playerid,PlayerInfo[playerid][pGroupLevel][group_crew] == 5 ? orange : yellow," %d) %s [ID: %03d | Crew Level: %d]",i+1,GroupInfo[PlayerInfo[playerid][pGroup][group_crew]][gName],pl,PlayerInfo[pl][pGroupLevel][group_crew]);
			}
		}
		else return SendClientMessage(playerid,red," .אפשרות קרו שגויה");
		return 1;
	}
	if(equal(cmd,"/crews"))
	{
		new c = 0;
		for(new i = 1; i < MAX_GROUPS; i++) if(GroupInfo[i][gType] == group_crew)
		{
			if(!c) SendClientMessage(playerid,lightblue," ~~~ :רשימת הקרויים בשרת ~~~");
			SendFormat(playerid,rgba2hex(GroupInfo[i][gColor][0],GroupInfo[i][gColor][1],GroupInfo[i][gColor][2],255)," %d) %s (%d players)",++c,GroupInfo[i][gName],GroupInfo[i][gMembers]);
		}
		if(!c) return SendClientMessage(playerid,red," .אין קרויים בשרת כרגע");
		return 1;
	}
	if(equal(cmd,"/camera"))
	{
		if(!CheckWorld(playerid,false,world_stunts,world_stuntswo)) return 1;
		if(PlayerInfo[playerid][pCameraMode] != camera_none && PlayerInfo[playerid][pCameraMode] != camera_updated && PlayerInfo[playerid][pCameraMode] != camera_view) return SendClientMessage(playerid,red," .על מנת להשתמש בפקודה זו עליך לצאת ממצב הצילום הנוכחי שאתה נמצא בו");
		if(!CanUseCommand(playerid)) return 1;
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
			SendClientMessage(playerid,white," /camera [option] :צורת השימוש");
			SendClientMessage(playerid,white," /camera direction - שינוי כיוון המצלמה");
			SendClientMessage(playerid,white," /camera distance - שינוי מרחק המצלמה מהדמות");
			SendClientMessage(playerid,white," /camera follow - הפעלת או ביטול מעקב המצלמה");
			SendClientMessage(playerid,white," /camera save - שמירת זווית המצלמה הנוכחית");
			SendClientMessage(playerid,white," /camera load - צפייה בזווית מצלמה שמורה");
			SendClientMessage(playerid,white," /camera stop - חזרה למצב רגיל");
			return 1;
		}
		if(equal(cmd,"direction"))
		{
			cmd = strtok(cmdtext,idx);
			new directions[][16] = {"up","down","left","right","forward","backward"};
			if(!strlen(cmd))
			{
				fstring = "";
				for(new i = 0; i < sizeof(directions); i++) format(fstring,sizeof(fstring),!i ? ("%s%s") : ("%s/%s"),fstring,directions[i]);
				return SendFormat(playerid,white," /camera direction [%s] :צורת השימוש",fstring);
			}
			new directionid = -1;
			for(new i = 0; i < sizeof(directions) && directionid == -1; i++) if(equal(cmd,directions[i])) directionid = i;
			PlayerInfo[playerid][pCameraDirection] = directionid;
			CameraUpdate(playerid);
			PlayerInfo[playerid][pCameraMode] = camera_updated;
			SendFormat(playerid,green," * %s :הכיוון שונה לכיוון מספר #%d",directions[directionid],directionid);
			SendClientMessage(playerid,grey," (/camera stop :להפסקה)");
		}
		else if(equal(cmd,"distance"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /camera distance [0.0 - 100.0] :צורת השימוש");
			new Float:d = floatstr(cmd);
			if(d < 0.0 || d > 100.0) return SendClientMessage(playerid,red," .מרחק שגוי");
			PlayerInfo[playerid][pCameraDistance] = d;
			CameraUpdate(playerid);
			PlayerInfo[playerid][pCameraMode] = camera_updated;
			SendFormat(playerid,green," * המרחק מהמצלמה שונה ל-%.1f",d);
			SendClientMessage(playerid,grey," (/camera stop :להפסקה)");
		}
		else if(equal(cmd,"follow"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /camera follow [on/off] :צורת השימוש");
			if(equal(cmd,"on"))
			{
				PlayerInfo[playerid][pCameraFollow] = true;
				SendClientMessage(playerid,green," * מעקב אחרי השחקן הופעל");
			}
			else if(equal(cmd,"off"))
			{
				PlayerInfo[playerid][pCameraFollow] = false;
				SendClientMessage(playerid,green," * מעקב אחרי השחקן בוטל");
			}
			else return SendClientMessage(playerid,red," .אפשרות מעקב שגויה");
			SendClientMessage(playerid,grey," (/camera stop :להפסקה)");
			PlayerInfo[playerid][pCameraMode] = camera_updated;
		}
		else if(equal(cmd,"save"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /camera save [slot 1-" #MAX_CAMERA_SAVES "]");
			new s = strval(cmd);
			if(s < 1 || s > MAX_CAMERA_SAVES) return SendClientMessage(playerid,red," .מספר סלוט שגוי");
			s--;
			GetPlayerCameraPos(playerid,PlayerInfo[playerid][pCameraX][s],PlayerInfo[playerid][pCameraY][s],PlayerInfo[playerid][pCameraZ][s]);
		    GetPlayerCameraFrontVector(playerid,PlayerInfo[playerid][pCameraLAX][s],PlayerInfo[playerid][pCameraLAY][s],PlayerInfo[playerid][pCameraLAZ][s]);
		    PlayerInfo[playerid][pCameraLAX][s] += PlayerInfo[playerid][pCameraX][s];
			PlayerInfo[playerid][pCameraLAY][s] += PlayerInfo[playerid][pCameraY][s];
			PlayerInfo[playerid][pCameraLAZ][s] += PlayerInfo[playerid][pCameraZ][s];
			SendFormat(playerid,green," * זווית צילום נשמרה בסלוט #%d",s+1);
			SendClientMessage(playerid,grey," (/camera stop :להפסקה)");
		}
		else if(equal(cmd,"load"))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /camera load [slot 1-" #MAX_CAMERA_SAVES "]");
			new s = strval(cmd);
			if(s < 1 || s > MAX_CAMERA_SAVES) return SendClientMessage(playerid,red," .מספר סלוט שגוי");
			s--;
			if(PlayerInfo[playerid][pCameraX][s] == 0.0) return SendClientMessage(playerid,red," .אין לך זווית צילום שמורה בסלוט זה");
			PlayerInfo[playerid][pCameraMode] = camera_view;
			SetPlayerCameraPos(playerid,PlayerInfo[playerid][pCameraX][s],PlayerInfo[playerid][pCameraY][s],PlayerInfo[playerid][pCameraZ][s]);
		    SetPlayerCameraLookAt(playerid,PlayerInfo[playerid][pCameraLAX][s],PlayerInfo[playerid][pCameraLAY][s],PlayerInfo[playerid][pCameraLAZ][s]);
			SendFormat(playerid,green," * זווית צילום נטענה מסלוט #%d",s+1);
			SendClientMessage(playerid,grey," (/camera stop :להפסקה)");
			CancelWatchers(playerid);
		}
		else if(equal(cmd,"stop"))
		{
			if(PlayerInfo[playerid][pCameraMode] == camera_fly) return SendClientMessage(playerid,red," /fly :לסיום מצב תעופה השתמש שוב בפקודה");
			SetCameraBehindPlayer(playerid);
			PlayerInfo[playerid][pCameraMode] = camera_none;
		}
		else return SendClientMessage(playerid,red," .אפשרות מצלמה שגויה");
		return 1;
	}
	if(equal(cmd,"/watch"))
	{
		if(!CheckWorld(playerid,false,world_stunts,world_stuntswo)) return 1;
		if(PlayerInfo[playerid][pCameraMode] != camera_none && PlayerInfo[playerid][pCameraMode] != camera_spec) return SendClientMessage(playerid,red," .על מנת להשתמש בפקודה זו עליך לצאת ממצב הצילום הנוכחי שאתה נמצא בו");
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
			SendClientMessage(playerid,white," /watch [option] :צורת השימוש");
			SendClientMessage(playerid,white," /watch player - מעקב אחרי שחקן");
			SendClientMessage(playerid,white," /watch accept - אישור בקשה למעקב");
			SendClientMessage(playerid,white," /watch cancel - ביטול בקשה למעקב");
			SendClientMessage(playerid,white," /watch stop - הפסקת מעקב");
			return 1;
		}
		if(equal(cmd,"player"))
		{
			if(PlayerInfo[playerid][pSpectate] != INVALID_PLAYER_ID) return SendClientMessage(playerid,red," .אתה כבר במעקב, נא לסיים אותו על מנת לעבור לשחקן אחר");
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendClientMessage(playerid,white," /watch player [id/name] :צורת השימוש");
			new id = ReturnUser(cmd,playerid);
			if(!IsPlayerConnected(id)) return SendClientMessage(playerid,red," .איידי שגוי");
			if(id == playerid) return SendClientMessage(playerid,red," .אינך יכול לצפות בעצמך");
			if(PlayerInfo[id][pCameraMode] != camera_none) return SendFormat(playerid,red," .נמצא במצב מצלמה ולכן לא ניתן לצפות בו %s",GetName(id));
	 		if(PlayerInfo[id][pSpecAsk] == playerid) return SendClientMessage(playerid,red," .כבר שלחת בקשה למעקב אחר המשתמש הזה");
			SendFormat(playerid,green," .%s-שלחת בקשה למעקב ל",GetName(id));
			SendFormat(id,green," /watch accept :לאישור ,/watch cancel :שלח לך בקשה למעקב אחריך, לדחייה %s",GetName(playerid));
			PlayerInfo[id][pSpecAsk] = playerid;
		}
		else if(equal(cmd,"accept"))
		{
	 		if(!IsPlayerConnected(PlayerInfo[playerid][pSpecAsk]) || PlayerInfo[playerid][pSpecAsk] == INVALID_PLAYER_ID) return SendClientMessage(playerid,red," .לא קיבלת בקשה למעקב");
	 		new id = PlayerInfo[playerid][pSpecAsk];
			PlayerInfo[id][pSpectate] = playerid;
	 		SetPlayerInterior(id,GetPlayerInterior(playerid));
	 		SetPlayerVirtualWorld(id,GetPlayerVirtualWorld(playerid));
	 		TogglePlayerSpectating(id,1);
	 		if(IsPlayerInAnyVehicle(playerid)) PlayerSpectateVehicle(id,GetPlayerVehicleID(playerid));
	 		else PlayerSpectatePlayer(id,playerid);
			SendFormat(playerid,green," .למעקב, הוא כעת צופה בך %s אישרת את הבקשה של",GetName(id));
			SendFormat(id,green," /watch stop :אישר את הבקשה למעקב, להפסקה %s",GetName(playerid));
			PlayerInfo[playerid][pSpecAsk] = INVALID_PLAYER_ID;
		}
		else if(equal(cmd,"cancel"))
		{
	 		if(!IsPlayerConnected(PlayerInfo[playerid][pSpecAsk]) || PlayerInfo[playerid][pSpecAsk] == INVALID_PLAYER_ID) return SendClientMessage(playerid,red," .לא קיבלת בקשה למעקב");
			SendFormat(playerid,green," .למעקב %s שללת את הבקשה של",GetName(PlayerInfo[playerid][pSpecAsk]));
			SendFormat(PlayerInfo[playerid][pSpecAsk],red," .שלל את הבקשה למעקב %s",GetName(playerid));
			PlayerInfo[playerid][pSpecAsk] = INVALID_PLAYER_ID;
		}
		else if(equal(cmd,"stop"))
		{
			if(PlayerInfo[playerid][pSpectate] == INVALID_PLAYER_ID || PlayerInfo[playerid][pCameraMode] == camera_spec) return SendClientMessage(playerid,red," .אתה לא במעקב על אף שחקן");
			SendFormat(playerid,green," .%s יצאת מהמעקב אחרי השחקן",GetName(PlayerInfo[playerid][pSpectate]));
			PlayerInfo[playerid][pSpectate] = INVALID_PLAYER_ID, PlayerInfo[playerid][pCameraMode] = camera_none;
			TogglePlayerSpectating(playerid,0);
			SpawnPlayer(playerid);
		}
		else return SendClientMessage(playerid,red," .אפשרות מצלמה שגויה");
		return 1;
	}
	if(equal(cmd,"/fly"))
	{
		if(!CheckWorld(playerid,false,world_stunts,world_stuntswo)) return 1;
		if(PlayerInfo[playerid][pCameraMode] != camera_none && PlayerInfo[playerid][pCameraMode] != camera_fly) return SendClientMessage(playerid,red," .לפני שתוכל להשתמש בפקודה זו עליך לצאת ממצב המצלמה שאתה נמצא בו");
		if(!CanUseCommand(playerid,.spc=false)) return 1;
		if(PlayerInfo[playerid][pCameraMode] == camera_fly)
		{
			GameTextForPlayer(playerid,"~b~fly mode stopped",2000,4);
			CancelEdit(playerid);
			TogglePlayerSpectating(playerid,0);
			new Float:p[3];
			GetPlayerObjectPos(playerid,PlayerInfo[playerid][pFlyObject],p[0],p[1],p[2]);
			SetPlayerPos(playerid,p[0],p[1],p[2]);
			DestroyPlayerObject(playerid,PlayerInfo[playerid][pFlyObject]);
			PlayerInfo[playerid][pCameraMode] = camera_none;
		}
		else
		{
			GameTextForPlayer(playerid,"~b~fly mode started",2000,4);
			new Float:p[3];
			GetPlayerPos(playerid,p[0],p[1],p[2]);
			PlayerInfo[playerid][pFlyObject] = CreatePlayerObject(playerid,19300,p[0],p[1],p[2],0.0,0.0,0.0);
			TogglePlayerSpectating(playerid,1);
			AttachCameraToPlayerObject(playerid,PlayerInfo[playerid][pFlyObject]);
			PlayerInfo[playerid][pCameraMode] = camera_fly;
			CancelWatchers(playerid);
			SendClientMessage(playerid,green," /fly :ליציאה השתמש שוב ,Fly Mode-נכנסת ל");
		}
		return 1;
	}
	if(equal(cmd,"/flyspeed"))
	{
		if(!CheckWorld(playerid,false,world_stunts,world_stuntswo)) return 1;
		if(PlayerInfo[playerid][pCameraMode] != camera_fly) return SendClientMessage(playerid,red," .עליך להיות במצב צילום");
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd)) return SendClientMessage(playerid,white," /flyspeed [speed 1.0 - 350.0] :צורת השימוש");
		new Float:s = floatstr(cmd);
		if(s < 1.0 || s > 350.0) return SendClientMessage(playerid,red," .המהירות שהוקלדה שגויה");
		PlayerInfo[playerid][pMoveSpeed] = s;
		SendFormat(playerid,green," .מהירות התזוזה במצב תעופה שונתה ל-%.1f",s);
		return 1;
	}
	if(equal(cmd,"/quest"))
	{
		if(!IsPower(playerid)) return SendClientMessage(playerid,red," .המערכת תחזור בעדכון");
		if(!CheckWorld(playerid,false,world_stunts,world_stuntswo)) return 1;
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
			SendClientMessage(playerid,white," /quest [option] :צורת השימוש");
			SendClientMessage(playerid,white," /quest list :רשימת המשימות");
			SendClientMessage(playerid,white," /quest start :התחלת משימה");
			SendClientMessage(playerid,white," /quest stop :הפסקת משימה");
			return 1;
		}
		if(equal(cmd,"list"))
		{
			const PER_PAGE = 9;
			new pages = sizeof(Quests) / PER_PAGE + (_:(sizeof(Quests) % PER_PAGE > 0)), page = 0;
			cmd = strtok(cmdtext,idx);
			if(pages > 1)
			{
				if(!strlen(cmd) || !IsNumeric(cmd)) return SendFormat(playerid,white," /quest list [1-%d] :צורת השימוש",pages);
				page = strval(cmd);
				if(page < 1 || page > pages) return SendClientMessage(playerid,red," .תפריט נשקים שגוי");
			}
			else page = 1;
			SendFormat(playerid,lightblue," ~~~ :רשימת המשימות - %d/%d ~~~",page,pages);
			for(new i = (page-1)*PER_PAGE; i < (page*PER_PAGE) && i < sizeof(Quests); i++) SendFormat(playerid,i % 2 == 0 ? yellow : green," • %02d) %s [Exp (first time): %d | Exp (second time): %d]",(i + 1),Quests[i][qName],Quests[i][qExp],Quests[i][qExp] / 2);
		}
		else if(equal(cmd,"start"))
		{
			if(PlayerInfo[playerid][pQuest] > -1) return SendClientMessage(playerid,red," /quest stop :אתה כבר במשימה, לסיום השתמש בפקודה");
			if(!CanUseCommand(playerid)) return 1;
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd)) return SendFormat(playerid,white," /quest start [1-%d] :צורת השימוש",sizeof(Quests));
			new q = strval(cmd);
			if(q < 1 || q > sizeof(Quests)) return SendClientMessage(playerid,red," .מספר משימה שגוי");
			PlayerInfo[playerid][pQuestStep] = 1;
			Quest_Start(playerid,PlayerInfo[playerid][pQuest] = q);
			SendFormat(playerid,green," * !נא לעקוב אחרי הצ'קפוינטים. בהצלחה :%s התחלת את המשימה",Quests[PlayerInfo[playerid][pQuest]][qName]);
		}
		else if(equal(cmd,"stop"))
		{
			if(PlayerInfo[playerid][pQuest] == -1) return SendClientMessage(playerid,red," /quest start :אתה לא בשום משימה, כדי להתחיל");
			if(!CanUseCommand(playerid,.qst = false)) return 1;
			DisablePlayerRaceCheckpoint(playerid);
			SendFormat(playerid,red," .%s יצאת מהמשימה",Quests[PlayerInfo[playerid][pQuest]][qName]);
			PlayerInfo[playerid][pQuest] = -1, PlayerInfo[playerid][pQuestStep] = 0;
		}
		else return SendClientMessage(playerid,red," .אפשרות משימה שגויה");
		return 1;
	}
	return 0;
}
public OnPlayerClickTextDraw(playerid,Text:clickedid)
{
	if(PlayerInfo[playerid][pConnectStage] == ct_selectworld)
	{
		if(clickedid == Text:INVALID_TEXT_DRAW) SelectTextDraw(playerid,white);
		else for(new i = 0; i < sizeof(Worlds); i++) if(Worlds[i][wPlayable]) if(clickedid == WorldInfo[i][wTD][2])
		{
			if(i == world_tdm) return SendClientMessage(playerid,red,"Coming Soon!"), 1;
			WorldTextDraw("hide",playerid);
			WorldPlayer(PlayerInfo[playerid][pWorld],false);
			WorldPlayer(i,true);
			PlayerInfo[playerid][pWorld] = i;
			PlayerInfo[playerid][pConnectStage] = ct_selectskin;
			//TogglePlayerSpectating(playerid,0);
			SetPlayerPos(playerid,229.8910,-1870.9111,6.0000);
			SetPlayerFacingAngle(playerid,1.5668);
			InterpolateCameraPos(playerid,198.044738,-1750.411132,20.670663,229.429397,-1849.013549,10.186964,2000,CAMERA_MOVE);
			InterpolateCameraLookAt(playerid,229.387725,-1844.057250,10.845205,229.8910,-1870.9111,6.0000,2000,CAMERA_MOVE);
			SetPlayerVirtualWorld(playerid,vworld_requestclass);
			Streamer_Update(playerid);
			PlayerInfo[playerid][pInterpolating] = GetTickCount();
			return 1;
		}
	}
	return 0;
}
public OnPlayerUpdate(playerid)
{
	PlayerInfo[playerid][pIdleTime] = 0;
	new w = GetPlayerWeapon(playerid);
	if(w > 0 && !PlayerInfo[playerid][pUsingWeapons][w-1] && PlayerInfo[playerid][pConnectStage] == ct_playing) return SetKick(playerid,-1,"Weapons hack 2"), 0;
	if(PlayerInfo[playerid][pCameraMode] != camera_none) switch(PlayerInfo[playerid][pCameraMode])
	{
		case camera_fly:
		{   // based on h02's code
			new keys, ud, lr;
			GetPlayerKeys(playerid,keys,ud,lr);
			if(PlayerInfo[playerid][pFlyKeys] && (GetTickCount() - PlayerInfo[playerid][pLastMove] > 100)) MoveCamera(playerid);
			if(PlayerInfo[playerid][pUD] != ud || PlayerInfo[playerid][pLR] != lr)
			{
				if((PlayerInfo[playerid][pUD] != 0 || PlayerInfo[playerid][pLR] != 0) && ud == 0 && lr == 0)
				{
					StopPlayerObject(playerid,PlayerInfo[playerid][pFlyObject]);
					PlayerInfo[playerid][pFlyKeys] = 0;
					PlayerInfo[playerid][pAccelMul] = 0.0;
				}
				else
				{
					PlayerInfo[playerid][pFlyKeys] = 0;
				    if(lr < 0)
					{
						if(ud < 0) PlayerInfo[playerid][pFlyKeys] = 5;
						else if(ud > 0) PlayerInfo[playerid][pFlyKeys] = 7;
						else PlayerInfo[playerid][pFlyKeys] = 3;
					}
					else if(lr > 0)
					{
						if(ud < 0) PlayerInfo[playerid][pFlyKeys] = 6;
						else if(ud > 0) PlayerInfo[playerid][pFlyKeys] = 8;
						else PlayerInfo[playerid][pFlyKeys] = 4;
					}
					else if(ud < 0) PlayerInfo[playerid][pFlyKeys] = 1;
					else if(ud > 0) PlayerInfo[playerid][pFlyKeys] = 2;
					MoveCamera(playerid);
				}
			}
			PlayerInfo[playerid][pUD] = ud, PlayerInfo[playerid][pLR] = lr;
			return 0;
		}
		case camera_updated: if(PlayerInfo[playerid][pCameraFollow]) CameraUpdate(playerid);
	}
	return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
	Streamer_CallbackHook(STREAMER_OPEC,playerid);
	if(PlayerInfo[playerid][pCheckpoint] > -1)
	{
		switch(GetPlayerCheckpoint(playerid))
		{
			case cp_bank:
			{
				SendClientMessage(playerid,lightblue," ~~~ :ברוכים הבאים לבנק ~~~");
				SendClientMessage(playerid,green," .כאן תוכל להפקיד כסף שישמר גם לאחר שתצא מהשרת");
				SendClientMessage(playerid,green," /help mode 14 - לפירוט מלא");
				SendClientMessage(playerid,yellow," /deposit • /withdraw • /balance • /depositall • /withdrawall");
			}
			case cp_ammu:
			{
				SendClientMessage(playerid,lightblue," ~~~ :ברוכים הבאים לחנות הנשקים ~~~");
				SendClientMessage(playerid,green," .כאן תוכל להפקיד כסף שישמר גם לאחר שתצא מהשרת");
				SendClientMessage(playerid,green," /help mode 15 - לפירוט מלא");
				SendClientMessage(playerid,yellow," /bw • /wl • /rw");
			}
		}
	}
	return 1;
}
public OnPlayerLeaveCheckpoint(playerid)
{
	Streamer_CallbackHook(STREAMER_OPLC,playerid);
	return 1;
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
	Streamer_CallbackHook(STREAMER_OPERC,playerid);
	PlaySound(playerid,1058);
	if(PlayerInfo[playerid][pQuest] > -1 && PlayerInfo[playerid][pQuestStep] > 0 && (PlayerInfo[playerid][pWorld] == world_stunts || PlayerInfo[playerid][pWorld] == world_stuntswo))
	{
		new Float:nextData[2][3];
		PlayerInfo[playerid][pQuestStep]++;
		DisablePlayerRaceCheckpoint(playerid);
		for(new i = 0; i < 2; i++) Quest_GetData(PlayerInfo[playerid][pQuest],PlayerInfo[playerid][pQuestStep] + i,nextData[i]);
		if(nextData[0][0] != 0.0) SetPlayerRaceCheckpoint(playerid,0 + _:(nextData[1][0] == 0.0),nextData[0][0],nextData[0][1],nextData[0][2],nextData[_:(nextData[1][0] == 0.0)][0],nextData[_:(nextData[1][0] == 0.0)][1],nextData[_:(nextData[1][0] == 0.0)][2],7.5 + (2.5 * _:(nextData[1][0] == 0.0)));
		else
		{
			new k[16], time = 0;
			format(k,sizeof(k),"Quest%d",Quests[PlayerInfo[playerid][pQuest]][qUID]);
			new day[2];
			getdate(day[1],day[1],day[0]);
			if(!fkeyexist(uf(playerid),k)) fsetstring(uf(playerid),k,frmt("%d-%d",day[0],time = 1));
			else
			{
				new v[16], _op[2][4];
				format(v,sizeof(v),fgetstring(uf(playerid),k));
				strmid(_op[0],v,0,strfind(v,"-"));
				strmid(_op[1],v,strfind(v,"_")+1,strlen(v));
				time = (strval(_op[0]) == day[0] ? (strval(_op[1]) + 1) : 1);
				fsetstring(uf(playerid),k,frmt("%d-%d",day[0],time));
			}
			fstring = "";
			switch(time)
			{
				case 1:
				{
					frmt(" • !בפעם הראשונה להיום %s השלים את משימת הסטאנטים %s",Quests[PlayerInfo[playerid][pQuest]][qName],Quests[PlayerInfo[playerid][pQuest]][qName]);
					GiveExp(playerid,exp_quest,Quests[PlayerInfo[playerid][pQuest]][qExp]);
				}
				case 2:
				{
					frmt(" • !בפעם השנייה להיום %s השלים את משימת הסטאנטים %s",Quests[PlayerInfo[playerid][pQuest]][qName],Quests[PlayerInfo[playerid][pQuest]][qName]);
					GiveExp(playerid,exp_quest,Quests[PlayerInfo[playerid][pQuest]][qExp] / 2);
				}
				default: SendClientMessage(playerid,grey," (מכיוון שעשית את המשימה הזו כבר פעמיים היום, לא תוכל לקבל עליה עוד נקודות)");
			}
			if(strlen(fstring) > 0) Loop(i) if(PlayerInfo[i][pWorld] == PlayerInfo[playerid][pWorld]) SendClientMessage(i,orange,fstring);
			PlayerInfo[playerid][pQuest] = -1, PlayerInfo[playerid][pQuestStep] = 0;
		}
	}
	return 1;
}
public OnPlayerLeaveRaceCheckpoint(playerid)
{
	Streamer_CallbackHook(STREAMER_OPLRC,playerid);
	return 1;
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
	Streamer_CallbackHook(STREAMER_OPPP,playerid,pickupid);
	if(PlayerInfo[playerid][pPickupID] != -1) return 1;
	PlayerInfo[playerid][pWeaponsCheatWait] = 2;
	if(PickupInfo[pickupid][pkValid])
	{
		switch(PickupInfo[pickupid][pkType])
		{
			case pickup_property:
			{
				new p = PickupInfo[pickupid][pkParam];
				SendFormat(playerid,lightblue," ~~~ :[#%02d] %s ברוכים הבאים לנכס ~~~",p+1,PropertyInfo[p][prName]);
				SendFormat(playerid,green," הנכס עולה: $%d והמשכורת ממנו היא: $%d",PropertyInfo[p][prCost],PropertyInfo[p][prEarning]);
				SendClientMessage(playerid,yellow," /buy :ניתן לקנות אותו על ידי שימוש בפקודה");
				SendFormat(playerid,yellow," (בעל הנכס יקבל בכל 2 דקות את המשכורת, עד מקסימום " #PROP_EARNS " פעמים (רווח כולל: $%d",PROP_EARNS*PropertyInfo[p][prEarning]);
				if(PropertyInfo[p][prOwner] == playerid) SendClientMessage(playerid,grey," (הנכס הזה שייך לך)");
				else if(PropertyInfo[p][prOwner] == INVALID_PLAYER_ID) SendClientMessage(playerid,grey," (הנכס הזה לא שייך לאף אחד)");
				else SendFormat(playerid,grey," (%s-הנכס הזה שייך ל)",GetName(PropertyInfo[p][prOwner]));
			}
		}
	}
	PlayerInfo[playerid][pPickupID] = pickupid;
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	PlayerInfo[playerid][pOldState] = oldstate;
	new vid = GetPlayerVehicleID(playerid);
	//if((oldstate == PLAYER_STATE_PASSENGER || oldstate == PLAYER_STATE_DRIVER) && PlayerInfo[playerid][pALastVehicle] != INVALID_VEHICLE_ID) VehicleInfo[PlayerInfo[playerid][pALastVehicle]][vPlayersIn]--;
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		GameTextForPlayer(playerid,frmt("~g~~h~%s",VehicleName(GetVehicleModel(vid))),2500,1);
		PlayerInfo[playerid][pLastVehicle] = vid, PlayerInfo[playerid][pALastVehicle] = vid, /*VehicleInfo[vid][vPlayersIn]++, */PlayerInfo[playerid][pLastVModelID] = GetVehicleModel(vid);
	}
	if(newstate == PLAYER_STATE_ONFOOT || newstate == PLAYER_STATE_SPAWNED || (newstate == PLAYER_STATE_EXIT_VEHICLE && (oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER))) Loop(i) if(PlayerInfo[i][pSpectate] == playerid) PlayerSpectatePlayer(i,playerid);
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER) Loop(i) if(PlayerInfo[i][pSpectate] == playerid) PlayerSpectateVehicle(i,vid);
	if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER && PlayerInfo[playerid][pChannel] == 6 && PlayerInfo[playerid][pChannelToggle]) PutPlayerInVehicle(playerid,PlayerInfo[playerid][pLastVehicle],0);
	return 1;
}
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	Loop(i) if(PlayerInfo[i][pSpectate] == playerid) SetPlayerInterior(i,newinteriorid);
	return 1;
}
public OnPlayerEnterDynamicArea(playerid,areaid)
{
	switch(AreaInfo[areaid][arType])
	{
		case area_cp:
		{
			DisablePlayerCheckpoint(playerid);
			new cpid = AreaInfo[areaid][arParam];
			if(CheckpointInfo[cpid][cpActive] && PlayerInfo[playerid][pCheckpoint] == -1)
			{
				SetPlayerCheckpoint(playerid,Checkpoints[cpid][cpPos][0],Checkpoints[cpid][cpPos][1],Checkpoints[cpid][cpPos][2],Checkpoints[cpid][cpSize]);
				PlayerInfo[playerid][pCheckpoint] = cpid;
			}
		}
		case area_money: SendFormat(playerid,blue," • .כאן תרוויח $%d בכל שנייה !\"%s\" ברוכים הבאים לאזור הכסף",ServerConfig[cfgMoneyAreaEarn] + (PlayerInfo[playerid][pVIP] ? ServerConfig[cfgVIPMoneyAreaBonus] : 0),MoneyAreas[AreaInfo[areaid][arParam]][maName]);
		case area_tele: if(PlayerInfo[playerid][pWorld] > 0)
		{
			new t = AreaInfo[areaid][arParam], w = PlayerInfo[playerid][pWorld];
			Teleports[t][tlPlayers][w]++;
			if(Teleports[t][tlPlayers][w] >= 3 && GetTickCount()-Teleports[t][tlArea][1] > 60000)
			{
				Teleports[t][tlArea][1] = GetTickCount();
				format(fstring,sizeof(fstring),Teleports[t][tlName]);
				fstring[0] = toupper(fstring[0]);
				frmt(" • !%s בעולם /%s כרגע %d שחקנים נמצאים בשיגור",Worlds[w][wName],fstring,Teleports[t][tlPlayers][w]);
				SendClientMessageToAll(orange,fstring);
			}
		}
	}
	PlayerInfo[playerid][pArea] = areaid;
	return 1;
}
public OnPlayerLeaveDynamicArea(playerid,areaid)
{
	switch(AreaInfo[areaid][arType])
	{
		case area_cp:
		{
			DisablePlayerCheckpoint(playerid);
			PlayerInfo[playerid][pCheckpoint] = -1;
		}
		case area_tele: if(PlayerInfo[playerid][pWorld] > 0)
		{
			new t = AreaInfo[areaid][arParam], w = PlayerInfo[playerid][pWorld];
			if(--Teleports[t][tlPlayers][w] <= 0) Teleports[t][tlPlayers][w] = 0;
		}
	}
	PlayerInfo[playerid][pArea] = -1;
	return 1;
}
public OnPlayerEditObject(playerid,playerobject,objectid,response,Float:fX,Float:fY,Float:fZ,Float:fRotX,Float:fRotY,Float:fRotZ)
{
	if(playerobject) Streamer_CallbackHook(STREAMER_OPEO,playerid,playerobject,objectid,response,fX,fY,fZ,fRotX,fRotY,fRotZ);
	return 1;
}
public OnPlayerSelectObject(playerid,type,objectid,modelid,Float:fX,Float:fY,Float:fZ)
{
	if(type == SELECT_OBJECT_PLAYER_OBJECT) Streamer_CallbackHook(STREAMER_OPSO,playerid,type,objectid,modelid,fX,fY,fZ);
	return 1;
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		new slot = GetWeaponSlot(weaponid);
		if(slot >= 2 && slot <= 9)
		{
			if(PlayerInfo[playerid][pShootTC][weaponid] > 0 && ServerConfig[cfgDisableCBug])
			{
				// Anti c-bug
				new time = -1;
				switch(weaponid) // Based on Mauzen's values
				{
					case 24: time = 675;
					case 25: time = 800;
					case 33: time = 750;
				}
				new a = GetTickCount()-PlayerInfo[playerid][pShootTC][weaponid];
				if(time != -1 && a <= time)
				{
					//SendFormat(playerid,white,"%d / %d",a,time);
					SendClientMessage(playerid,red," • .אסור בשרת זה C-Bug");
					PlayerInfo[playerid][pWeaponWarns][0] += 4;
					if(PlayerInfo[playerid][pWeaponWarns][0] >= 10) SetPlayerAmmo(playerid,weaponid,0);
					SetPlayerChatBubble(playerid,":נחסם\nC-Bug",red,25.0,1500);
					StopPlayer(playerid);
				}
			}
			PlayerInfo[playerid][pShootTC][weaponid] = GetTickCount();
		}
		if(weaponid == 26 && ServerConfig[cfgDisableSawnoff22])
		{
			// Anti sawnoff fast-reload
			new am[2];
			GetPlayerWeaponData(playerid,3,am[1],am[0]);
			if(PlayerInfo[playerid][pSawnoffAmmo] == -1 || PlayerInfo[playerid][pSawnoffAmmo] > am[0]) PlayerInfo[playerid][pSawnoffAmmo] = am[0] - 3;
			if(PlayerInfo[playerid][pSawnoffAmmo] == am[0])
			{
				if(GetPlayerWeaponState(playerid) != 1)
				{
					StopPlayer(playerid);
					SendClientMessage(playerid,red," • .אסור בשרת זה Sawnoff 2-2");
					PlayerInfo[playerid][pWeaponWarns][1] += 4;
					if(PlayerInfo[playerid][pWeaponWarns][1] >= 10) SetPlayerAmmo(playerid,weaponid,0);
					SetPlayerChatBubble(playerid,":נחסם\nSawnoff 2-2",red,25.0,1500);
				}
				PlayerInfo[playerid][pSawnoffAmmo] = -1;
			}
		}
	}
	if(hittype == BULLET_HIT_TYPE_PLAYER_OBJECT) Streamer_CallbackHook(STREAMER_OPWS,playerid,weaponid,hittype,hitid,fX,fY,fZ);
	return 1;
}
public OnPlayerExitVehicle(playerid,vehicleid)
{
	PlayerInfo[playerid][pWeaponsCheatWait] = 2;
	Loop(i) if(PlayerInfo[i][pSpectate] == playerid) PlayerSpectatePlayer(i,playerid);
	if(VehicleInfo[vehicleid][vLocked] && PlayerInfo[playerid][pOldState] == PLAYER_STATE_DRIVER)
	{
		Loop(i) SetVehicleParamsForPlayer(vehicleid,i,0,0);
		VehicleInfo[vehicleid][vLocked] = false;
	}
	if(PlayerInfo[playerid][pQuest] > -1)
	{
		DisablePlayerRaceCheckpoint(playerid);
		SendFormat(playerid,red," !כי יצאת מהרכב %s נפסלת במשימה",Quests[PlayerInfo[playerid][pQuest]][qName]);
		PlayerInfo[playerid][pQuest] = -1, PlayerInfo[playerid][pQuestStep] = 0;
	}
	if(PlayerInfo[playerid][pInActivity]) LeaveActivity(playerid);
	if(PlayerInfo[playerid][pChannel] != -1)
	{
		Channel(playerid,PlayerInfo[playerid][pChannel],'e',vehicleid);
		PlayerInfo[playerid][pChannel] = -1;
	}
	return 1;
}
public OnVehicleDeath(vehicleid, killerid)
{
	VehicleInfo[vehicleid][vLocked] = false;
	return 1;
}
public OnVehicleStreamIn(vehicleid, forplayerid)
{
	if(VehicleInfo[vehicleid][vLocked]) SetVehicleParamsForPlayer(vehicleid,forplayerid,0,1);
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(((newkeys & KEY_FIRE) == KEY_FIRE || (newkeys & 128) == 128) && (GetPlayerCheckpoint(playerid) == cp_bank || GetPlayerCheckpoint(playerid) == cp_ammu) && GetPlayerInterior(playerid) != 0 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && !IsPlayerMAdmin(playerid))
	{
		SetPlayerHealth(playerid,0.0);
		SendClientMessage(playerid,red," !אסור לתקוף או לאיים כאן");
	}
	if(newkeys & KEY_SPRINT && PlayerInfo[playerid][pRaise][1] > 0)
	{
		PlayerInfo[playerid][pRaise][1]--;
		if(!PlayerInfo[playerid][pRaise][1])
		{
			SendFormat(PlayerInfo[playerid][pRaise][2],green," .שחרר את עצמו מהתפיסה בתיק סילון %s",GetName(playerid));
			SendFormat(playerid,green," .%s השתחררת מהתפיסה מהתיק סילון של",GetName(PlayerInfo[playerid][pRaise][2]));
			PlayerInfo[PlayerInfo[playerid][pRaise][2]][pRaise][0] = INVALID_PLAYER_ID, PlayerInfo[playerid][pRaise][2] = INVALID_PLAYER_ID;
		}
	}
	if(newkeys & KEY_JUMP && IsPlayerInActivity(playerid,3) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		new animlib[32], animname[32];
		GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,animname,32);
		if(strfind(animname,"fall",true) == -1 && strfind(animname,"jump",true) == -1)
		{
			new Float:v[3];
			GetPlayerVelocity(playerid,v[0],v[1],v[2]);
			SetPlayerVelocity(playerid,v[0],v[1],2.0);
		}
	}
	if(newkeys & KEY_YES && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && PlayerInfo[playerid][pChannel] != -1) Channel(playerid,PlayerInfo[playerid][pChannel],'y');
	return 1;
}
public Contents()
{
	sUptime++;
	new st, Float:avg, wd[2], ms, mth, v, typ;
	Loop(i)
	{
		v = GetPlayerVehicleID(i), typ = GetVehicleType(v);
		// Time in Server
		PlayerInfo[i][pIdleTime]++, PlayerInfo[i][pConnectionTime][0]++;
		if(PlayerInfo[i][pIdleTime] > 15) SetPlayerChatBubble(i,frmt("AFK: %02d:%02d:%02d",PlayerInfo[i][pIdleTime]/3600,(PlayerInfo[i][pIdleTime]/60)-((PlayerInfo[i][pIdleTime]/3600)*60),PlayerInfo[i][pIdleTime]%60),0xFF6A6AFF,50.0,1200);
		else PlayerInfo[i][pConnectionTime][2]++;
		if(PlayerInfo[i][pLogged])
		{
			if(PlayerInfo[i][pConnectionTime][0] % 180 == 0)
			{
				fsetint(uf(i),"TimeInServer",PlayerInfo[i][pConnectionTime][1] + PlayerInfo[i][pConnectionTime][0]);
				SetPlayerScore(i,PlayerInfo[i][pLevel]);//(PlayerInfo[i][pConnectionTime][1] + PlayerInfo[i][pConnectionTime][0]) % 3600);
			}
			if(PlayerInfo[i][pConnectionTime][2] % 1800 == 0) GiveExp(i,exp_time);
		}
		// Freeze
		if(PlayerInfo[i][pFreezeTime] > 0)
		{
			PlayerInfo[i][pFreezeTime]--;
			if(!PlayerInfo[i][pFreezeTime]) TogglePlayerControllable(i,1);
		}
		// Godmod
		if(PlayerInfo[i][pGodmod])
		{
			SetPlayerHealth(i,100000.0);
			if(IsPlayerInAnyVehicle(i))
			{
				SetVehicleHealth(v,100000.0);
				RepairVehicle(v);
			}
		}
		// Money Areas
		if(PlayerInfo[i][pArea] > -1 && PlayerInfo[i][pWorld] == world_dm && PlayerInfo[i][pIdleTime] < 5) if(AreaInfo[PlayerInfo[i][pArea]][arType] == area_money)
		{
			GiveMoney(i,ServerConfig[cfgMoneyAreaEarn] + (PlayerInfo[i][pVIP] ? ServerConfig[cfgVIPMoneyAreaBonus] : 0));
			PlayerInfo[i][pAreaExp]++;
			if(PlayerInfo[i][pAreaExp] >= 10)
			{
				PlayerInfo[i][pAreaExp] = 0;
				GiveExp(i,exp_area);
			}
			else ExpGameText(i,frmt("~n~~n~~n~~n~~n~~b~~h~~h~money area exp: 0.%d/1",PlayerInfo[i][pAreaExp]));
		}
		// Loading Selection
		if(PlayerInfo[i][pLoadSelection] > 0)
		{
			PlayerInfo[i][pLoadSelection]--;
			if(!PlayerInfo[i][pLoadSelection])
			{
				WorldTextDraw("show",i);
				Streamer_Update(i);
			}
		}
		st = GetPlayerState(i);
		if(st == PLAYER_STATE_DRIVER)
		{
			// Stunt Bonus
			if(!PlayerInfo[i][pCooldownDelay][0] && (PlayerInfo[i][pWorld] == world_stunts || PlayerInfo[i][pWorld] == world_stuntswo) && GetPlayerMoney(i) > 0 && !IsBlockedByChannel(i,0))
			{
				if(GetPlayerMoney(i) <= 300)
				{
					for(new j = 0; j < 5; j++) avg += PlayerInfo[i][pSpeed][j];
					avg /= 5;
					if(avg > 20 && st == PLAYER_STATE_DRIVER)
					{
						GiveExp(i,exp_stunt,mth = (GetPlayerMoney(i) / 20));
						PlayerInfo[i][pPoints][ptStunts] += mth;
						Cooldown_Add(i,0,mth);
					}
				}
				ResetPlayerMoney(i);
			}
			// Speed Bonus
			if(!PlayerInfo[i][pCooldownDelay][2] && PlayerInfo[i][pLastVModelID] > 0 && !IsBlockedByChannel(i,2)) if(PlayerInfo[i][pSpeed][0] >= (ms = GetVehicleMaxSpeed(PlayerInfo[i][pLastVModelID])) && GetPlayerState(i) == PLAYER_STATE_DRIVER && typ <= 2)
			{
				GiveExp(i,exp_speed,mth = min(5,(1 + ((floatround(PlayerInfo[i][pSpeed][0] - ms)) / 12))));
				PlayerInfo[i][pPoints][ptSpeed] += mth;
				Cooldown_Add(i,2,mth);
			}
		}
		// Cooldowns
		Cooldown_Dec(i);
		// Anti Weapon Hack
		if(PlayerInfo[i][pWeaponsCheatWait] > 0)
		{
			PlayerInfo[i][pWeaponsCheatWait]--;
			if(!PlayerInfo[i][pWeaponsCheatWait]) RefreshWeapons(i);
		}
		else
		{
			if(PlayerInfo[i][pConnectStage] == ct_playing) for(new j = 0; j < 13; j++)
			{
				GetPlayerWeaponData(i,j,wd[0],wd[1]);
				if(wd[0] > 0 && wd[0] <= 46) if(!PlayerInfo[i][pUsingWeapons][wd[0]-1]) return SetKick(i,-1,"Weapons hack");
			}
		}
		// Mute
		if(PlayerInfo[i][pMute] > 0)
		{
			PlayerInfo[i][pMute]--;
			if(!PlayerInfo[i][pMute]) SendClientMessage(i,white," .ירד לך המיוט באופן אוטומטי");
			if(PlayerInfo[i][pLogged] && PlayerInfo[i][pMute] % 20 == 0 && PlayerInfo[i][pMute] > 0) fsetint(uf(i),"Mute",PlayerInfo[i][pMute]);
		}
		// Jail
		if(PlayerInfo[i][pJail] > 0)
		{
			PlayerInfo[i][pJail]--;
			if(!PlayerInfo[i][pJail])
			{
				SendClientMessage(i,white," .ירד לך הכלא באופן אוטומטי");
				SpawnPlayer(i);
			}
			else
			{
				SetPlayerPos(i,264.3591,77.5832,1001.0391);
				SetPlayerFacingAngle(i,270.0);
				SetCameraBehindPlayer(i);
				SetPlayerInterior(i,6);
				Freeze(i,true);
				if(PlayerInfo[i][pLogged] && PlayerInfo[i][pJail] % 20 == 0 && PlayerInfo[i][pJail] > 0) fsetint(uf(i),"Jail",PlayerInfo[i][pJail]);
			}
		}
		// Kick Player
		if(PlayerInfo[i][pKickIn] > 0)
		{
			PlayerInfo[i][pKickIn]--;
			if(!PlayerInfo[i][pKickIn]) Kick(i);
		}
		// Hide Drift TD
		if(PlayerInfo[i][pHideDriftTD] > 0)
		{
			PlayerInfo[i][pHideDriftTD]--;
			if(!PlayerInfo[i][pHideDriftTD]) for(new j = 0; j < 2; j++)
			{
				TextDrawHideForPlayer(i,driftlabels[j]);
			    PlayerTextDrawHide(i,PlayerInfo[i][pDriftTD][j]);
		    }
	    }
	    // Command Usage
		for(new j = 0; j < 2; j++) if(PlayerInfo[i][pUsedCommand][j] > 0) PlayerInfo[i][pUsedCommand][j]--;
		// Reset Pickup ID
		if(PlayerInfo[i][pPickupID] != -1) if(!IsPlayerInRangeOfPoint(i,4.0,PickupInfo[PlayerInfo[i][pPickupID]][pkPos][0],PickupInfo[PlayerInfo[i][pPickupID]][pkPos][1],PickupInfo[PlayerInfo[i][pPickupID]][pkPos][2])) PlayerInfo[i][pPickupID] = -1;
		// Countdown
		for(new j = 0; j < sizeof(Worlds); j++)
		{
			if(WorldInfo[j][wCD] > 0 && PlayerInfo[i][pWorld] == j)
			{
				if(WorldInfo[j][wCD] == 1) fstring = "~r~go";
				else frmt("~b~%d",WorldInfo[j][wCD]-1);
				GameTextForPlayer(i,fstring,2000,4);
			}
		}
		// Channel
		if(PlayerInfo[i][pChannel] != -1) Channel(i,PlayerInfo[i][pChannel],'i',v);
		// Channel Rampa
		if(PlayerInfo[i][pChannelRampa][1] > 0)
		{
			PlayerInfo[i][pChannelRampa][1]--;
			if(!PlayerInfo[i][pChannelRampa][1])
			{
				if(IsValidPlayerObject(i,PlayerInfo[i][pChannelRampa][0])) DestroyPlayerObject(i,PlayerInfo[i][pChannelRampa][0]);
				PlayerInfo[i][pChannelRampa][0] = -1;
			}
		}
		// Weapon Warns
		for(new j = 0; j < 2; j++) if(PlayerInfo[i][pWeaponWarns][j] > 0) PlayerInfo[i][pWeaponWarns][j]--;
	}
	// Countdown
	for(new j = 0; j < sizeof(Worlds); j++) if(WorldInfo[j][wCD] > 0) WorldInfo[j][wCD]--;
	// Server Config
	if(ServerConfig[cfgPropertyEarnTime] > 0 && sUptime % ServerConfig[cfgPropertyEarnTime] == 0) PropertiesPay();
	if(ServerConfig[cfgAutoMessageTime] > 0 && sUptime % ServerConfig[cfgAutoMessageTime] == 0) AutoMessage();
	if(ServerConfig[cfgGlobalRulesTime] > 0 && sUptime % ServerConfig[cfgGlobalRulesTime] == 0)
	{
		SendClientMessageToAll(lightblue," ~~~ :פרסום גלובאלי לחוקי השרת ~~~");
		ShowFile(-1,green,file_rules);
	}
	if(ServerConfig[cfgAutoMinigameTime] > 0 && sUptime % ServerConfig[cfgAutoMinigameTime] == 0)
	{
		new array[5] = {0,...}, arrayCount = 0;
		for(new i = 0; i < sizeof(Worlds); i++) if(Worlds[i][wPlayable] && !WorldInfo[i][wActivity][0])
		{
			array[0] = EOS, arrayCount = 0;
			for(new j = 0; j < sizeof(Activities); j++) if(Activities[j][actWorld] == i) array[arrayCount++] = j;
			if(arrayCount > 0) StartActivity(Activities[array[random(arrayCount)]][actUID]);
		}
	}
	return 1;
}
public DriftExit(playerid)
{
	PlayerInfo[playerid][pDrift][2] = 0;
	if(PlayerInfo[playerid][pDrift][1] >= 65 && PlayerInfo[playerid][pDrift][1] <= 500)
	{
		new mth = (PlayerInfo[playerid][pDrift][1] / 65);
		if(mth > 0 && !IsBlockedByChannel(playerid,1) && !PlayerInfo[playerid][pCooldownDelay][1])
		{
			GiveExp(playerid,exp_drift,mth);
			PlayerInfo[playerid][pPoints][ptDrifts] += mth;
			Cooldown_Add(playerid,1,mth);
		}
    }
	PlayerInfo[playerid][pHideDriftTD] = 3;
	PlayerInfo[playerid][pDrift][1] = 0;
}
public Drift()
{	// By Luby
	new Float:Angle1, Float:Angle2, Float:BySpeed, Float:p[3], Float:SpeedX, DPs[16], Cash[32];
	Loop(g)
	{
		GetPlayerPos(g,p[0],p[1],p[2]);
		SpeedX = floatsqroot(floatadd(floatadd(floatpower(floatabs(floatsub(p[0],PlayerInfo[g][pDSPos][0])),2),floatpower(floatabs(floatsub(p[1],PlayerInfo[g][pDSPos][1])),2)),floatpower(floatabs(floatsub(p[2],PlayerInfo[g][pDSPos][2])),2)));
		Angle1 = ReturnPlayerAngle(g);
		Angle2 = GetPlayerTheoreticAngle(g);
		BySpeed = floatmul(SpeedX,12);
		if(IsPlayerInAnyVehicle(g) && GetVType(GetPlayerVehicleID(g)) && floatabs(floatsub(Angle1,Angle2)) > DRIFT_MINKAT && floatabs(floatsub(Angle1,Angle2)) < DRIFT_MAXKAT && BySpeed > DRIFT_SPEED)
		{
			if(PlayerInfo[g][pDrift][2] > 0) KillTimer(PlayerInfo[g][pDrift][2]);
			PlayerInfo[g][pDrift][1] += floatround(floatabs(floatsub(Angle1,Angle2)) * 3 * (BySpeed*0.1))/10;
			PlayerInfo[g][pDrift][2] = SetTimerEx("DriftExit",5000,0,"i",g);
		}
		if(PlayerInfo[g][pDrift][1] > 70 && PlayerInfo[g][pDrift][1] < 10000)
		{
			valstr(DPs,PlayerInfo[g][pDrift][1],false);
			format(Cash,sizeof(Cash),"+%i EXP",PlayerInfo[g][pDrift][1] / 50);
			PlayerTextDrawSetString(g,PlayerInfo[g][pDriftTD][0],DPs);
			PlayerTextDrawSetString(g,PlayerInfo[g][pDriftTD][1],Cash);
		    for(new i = 0; i < 2; i++)
			{
				TextDrawShowForPlayer(g,driftlabels[i]);
			    PlayerTextDrawShow(g,PlayerInfo[g][pDriftTD][i]);
		    }
		}
		for(new j = 0; j < 3; j++) PlayerInfo[g][pDSPos][j] = p[j];
	}
}
public Contents2()
{
	new Float:p[3], bool:stopRaise = false, Float:v[3];
	Loop(i)
	{
		if(IsPlayerInAnyVehicle(i))
		{
			// Last Speed
			for(new j = 0; j < 9; j++) PlayerInfo[i][pSpeed][j + 1] = PlayerInfo[i][pSpeed][j];
			GetVehicleVelocity(GetPlayerVehicleID(i),v[0],v[1],v[2]);
			PlayerInfo[i][pSpeed][0] = ConvertVelocityToKMH(v[0],v[1],v[2]);
			// Speedometer
			if(!PlayerInfo[i][pSpeedoVisible]) PlayerInfo[i][pSpeedoVisible] = true;
			Speedometer(i,'u');
			// Drift Update
			GetVehiclePos(GetPlayerVehicleID(i),PlayerInfo[i][pDPos][0],PlayerInfo[i][pDPos][1],PlayerInfo[i][pDPos][2]);
		}
		else
		{
			if(PlayerInfo[i][pSpeedoVisible])
			{
				Speedometer(i,'h');
				PlayerInfo[i][pSpeedoVisible] = false;
			}
			GetPlayerPos(i,PlayerInfo[i][pDPos][0],PlayerInfo[i][pDPos][1],PlayerInfo[i][pDPos][2]);
		}
		// Jetpack Raise
		if(PlayerInfo[i][pRaise][0] != INVALID_PLAYER_ID)
		{
			stopRaise = false;
			if(GetPlayerSpecialAction(i) != SPECIAL_ACTION_USEJETPACK || GetPlayerInterior(i) != 0 || GetPlayerState(PlayerInfo[i][pRaise][0]) != PLAYER_STATE_ONFOOT || GetPlayerInterior(PlayerInfo[i][pRaise][0]) != 0 || GetPlayerVirtualWorld(PlayerInfo[i][pRaise][0]) != GetPlayerVirtualWorld(i)) stopRaise = true;
			else
			{
				GetPlayerPos(i,p[0],p[1],p[2]);
				if(IsPlayerInRangeOfPoint(PlayerInfo[i][pRaise][0],8.0,p[0],p[1],p[2])) stopRaise = true;
			}
			if(stopRaise) PlayerInfo[PlayerInfo[i][pRaise][0]][pRaise][1] = 0, PlayerInfo[PlayerInfo[i][pRaise][0]][pRaise][2] = INVALID_PLAYER_ID, PlayerInfo[i][pRaise][0] = INVALID_PLAYER_ID;
			else SetPlayerPos(PlayerInfo[i][pRaise][0],p[0],p[1],p[2]-2.5);
		}
	}
}
public CheckPlayerState()
{
	new cs;
	Loop(i)
	{
		cs = GetPlayerState(i);
		if(PlayerInfo[i][pDrift][3] > 0 && cs == PLAYER_STATE_DRIVER && PlayerInfo[i][pDrift][1] > 70)
		{
			PlayerInfo[i][pDrift][3]--;
			if(!PlayerInfo[i][pDrift][3])
			{
				KillTimer(PlayerInfo[i][pDrift][0]);
				DriftExit(i);
			}
		}
		if(cs == PLAYER_STATE_DRIVER && !PlayerInfo[i][pDrift][3])
		{
			if(GetVType(GetPlayerVehicleID(i))) PlayerInfo[i][pDrift][3] = 5, PlayerInfo[i][pDrift][0] = SetTimerEx("Drift",200,1,"i",i);
		}
		if(cs != PLAYER_STATE_DRIVER && PlayerInfo[i][pDrift][3] > 0)
		{
			KillTimer(PlayerInfo[i][pDrift][0]);
			PlayerInfo[i][pDrift][3] = 0;
		}
	}
	return 1;
}
public AutoMessage()
{
	new File:am = fopen(file_automsg,io_read), read[M_S];
	if(am)
	{
		new c = 0;
		while(fread(am,read,sizeof(read),false))
		{
			if(!c) SendClientMessageToAll(lightblue," • •  :הודעה אוטומטית  • •");
			c++;
			SendClientMessageToAll(white,read);
		}
		fclose(am);
		if(c > 0) SendClientMessageToAll(lightblue," • • • • • • • • • • • • • • • •");
	}
	return 1;
}
public PropertiesPay()
{
	new pay = 0, bonus = 0;
	Loop(i) if(PlayerInfo[i][pWorld] == world_dm && IsPlayerInArea(i,-2989.536,-2954.502,2977.858,2977.858) && !GetPlayerInterior(i) && GetPlayerVirtualWorld(i) == (worlds_gameplay + world_dm))
	{
		pay = 0;
		for(new p = 0; p < props_count; p++) if(PropertyInfo[p][prOwner] == i)
		{
			PlayerInfo[i][pEarns][p]--;
			if(!PlayerInfo[i][pEarns][p])
			{
				PropertyInfo[p][prOwner] = INVALID_PLAYER_ID, PlayerInfo[i][pEarns][p] = 0, PlayerInfo[i][pProps]--;
				SendFormat(i,red," .ולכן הוא לא שייך לך יותר %s קיבלת את כל המשכורות מהנכס",PropertyInfo[p][prName]);
			}
			pay += PropertyInfo[p][prEarning];
		}
		if(pay > 0 && PlayerInfo[i][pEarnType] > 0 && PlayerInfo[i][pIdleTime] <= 10)
		{
			SendFormat(i,green," • הרווחת מהנכסים שברשותך: $%d",pay);
			if(PlayerInfo[i][pVIP]) SendFormat(i,green," • (+ $%d :VIP בונוס)",bonus = floatround(floatmul(float(pay),floatdiv(float(ServerConfig[cfgVIPPropertyPercentBonus]),100.0))));
			if(PlayerInfo[i][pEarnType] == 1) GiveMoney(i,pay+bonus);
			else
			{
				PlayerInfo[i][pBank] += pay+bonus;
				if(PlayerInfo[i][pLogged]) fsetint(uf(i),"Bank",PlayerInfo[i][pBank]);
			}
		}
	}
}
public ActivityStart(actuid)
{
	new idx = GetActivityIndex(actuid), pl[MAX_PLAYERS] = {INVALID_PLAYER_ID,...}, pls = 0;
	assert idx != -1;
	Loop(i) if(PlayerInfo[i][pWorld] == Activities[idx][actWorld] && PlayerInfo[i][pInActivity]) pl[pls++] = i;
	if(WorldInfo[Activities[idx][actWorld]][wActivity][0] == actuid)
	{
		WorldInfo[Activities[idx][actWorld]][wActivity][1]--;
		if(WorldInfo[Activities[idx][actWorld]][wActivity][1] > 0)
		{
			if(WorldInfo[Activities[idx][actWorld]][wActivity][1] == Activities[idx][actTime] / 2)
			{
				if(pls > 1) frmt(" • /join :תתחיל בעוד %d שניות! כבר הצטרפו %d משתתפים. להצטרפות %s הפעילות",WorldInfo[Activities[idx][actWorld]][wActivity][1],pls,Activities[idx][actName]);
				else frmt(" • /join :תתחיל בעוד %d שניות! עדיין לא הצטרפו מספיק משתתפים לקיום הפעילות. להצטרפות %s הפעילות",WorldInfo[Activities[idx][actWorld]][wActivity][1],Activities[idx][actName]);
				Loop(i) if(PlayerInfo[i][pWorld] == Activities[idx][actWorld]) SendClientMessage(i,lightblue,fstring);
			}
			SetTimerEx("ActivityStart",1000,0,"i",actuid);
		}
		else
		{
			if(pls <= 2)
			{
				frmt(" .נסגרה מכיוון שלא נרשמו מספיק שחקנים %s הפעילות",Activities[idx][actName]);
				Loop(i) if(PlayerInfo[i][pWorld] == Activities[idx][actWorld]) SendClientMessage(i,red,fstring);
				StopActivity(actuid);
			}
			else
			{
				WorldInfo[Activities[idx][actWorld]][wActivity][2] = 1;
				frmt(" • • !התחילה עם %d משתתפים %s הפעילות • •",pls,Activities[idx][actName]);
				Loop(i) if(PlayerInfo[i][pWorld] == Activities[idx][actWorld]) SendClientMessage(i,lightblue,fstring);
				for(new i = 0; i < pls; i++)
				{
					TogglePlayerControllable(pl[i],0);
					SettingActivity(pl[i],actuid);
					PlayerInfo[pl[i]][pDMZone] = -1;
				}
				SetTimerEx("ActivityCD",1000,0,"ii",actuid,4);
			}
		}
	}
}
public ActivityCD(actuid,cd)
{
	new idx = GetActivityIndex(actuid);
	assert idx != -1;
	if(WorldInfo[Activities[idx][actWorld]][wActivity][0] == actuid)
	{
		new pl[MAX_PLAYERS] = {INVALID_PLAYER_ID,...}, pls = 0;
		Loop(i) if(PlayerInfo[i][pWorld] == Activities[idx][actWorld] && PlayerInfo[i][pInActivity]) pl[pls++] = i;
		cd--;
		for(new i = 0; i < pls; i++)
		{
			if(!cd)
			{
				TogglePlayerControllable(pl[i],1);
				GameTextForPlayer(pl[i],"~g~Go!",1000,5);
			}
			else GameTextForPlayer(pl[i],frmt("~b~%d",cd),1000,5);
		}
		if(cd > 0) SetTimerEx("ActivityCD",1000,0,"ii",actuid,cd);
	}
}
// Functions
stock GetEmptyWorld(startfrom = 0)
{
	for(new i = startfrom, c = 0; i <= max_vworlds; i++)
	{
		c = 0;
		LoopEx(ii,<!c>) if(IsPlayerConnected(ii) && GetPlayerVirtualWorld(ii) == i) c++;
		if(!c) return i;
	}
	return -1;
}
stock GetHighestID()
{
	new h = 0;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && i > h) h = i;
	return h;
}
stock ResetInfo(playerid)
{
	PlayerInfo[playerid][pID] = -1;
	PlayerInfo[playerid][pConnectStage] = ct_connection;
	PlayerInfo[playerid][pFirstSpawn] = false;
	PlayerInfo[playerid][pName] = EOS;
	PlayerInfo[playerid][pIP] = EOS;
	PlayerInfo[playerid][pUserFile] = EOS;
	PlayerInfo[playerid][pUserID] = 0;
	PlayerInfo[playerid][pLogged] = false;
	PlayerInfo[playerid][pFailedLogins] = 0;
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pWorld] = world_class;
	PlayerInfo[playerid][pUsedCommand] = {0,0};
	PlayerInfo[playerid][pLastPM] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pAFK] = false;
	PlayerInfo[playerid][pIdleTime] = 0;
	PlayerInfo[playerid][pConnectionTime] = {0,0,0};
	PlayerInfo[playerid][pBlockPMs] = false;
	PlayerInfo[playerid][pCheckpoint] = -1;
	PlayerInfo[playerid][pArea] = -1;
	PlayerInfo[playerid][pInterpolating] = 0;
	PlayerInfo[playerid][pAdminLogged] = 0;
	PlayerInfo[playerid][pMoney] = 0;
	PlayerInfo[playerid][pBank] = 0;
	PlayerInfo[playerid][pLevel] = 1;
	for(new i = 0; i < max_settings; i++) PlayerInfo[playerid][pSetting][i] = Settings[i][stDefault];
	PlayerInfo[playerid][pRate] = 0;
	PlayerInfo[playerid][pPoints] = 0;
	PlayerInfo[playerid][pActivityWins] = 0;
	PlayerInfo[playerid][pExp] = 0;
	PlayerInfo[playerid][pExpUpdate] = 0;
	PlayerInfo[playerid][pAreaExp] = 0;
	PlayerInfo[playerid][pHeadshots] = false;
	PlayerInfo[playerid][pHeadshoted] = false;
	PlayerInfo[playerid][pRegDate] = EOS;
	PlayerInfo[playerid][pFreezeTime] = 0;
	PlayerInfo[playerid][pChat] = -1;
	PlayerInfo[playerid][pChatAdmin] = false;
	for(new i = 0; i < MAX_ADMIN_VEHICLES; i++) PlayerInfo[playerid][pACreatedVehicle][i] = INVALID_VEHICLE_ID;
	PlayerInfo[playerid][pACreatedVehicles] = 0;
	PlayerInfo[playerid][pALastVehicle] = INVALID_VEHICLE_ID;
	for(new i = 0; i < MAX_PLAYER_VEHICLES; i++) PlayerInfo[playerid][pCreatedVehicle][i] = INVALID_VEHICLE_ID;
	PlayerInfo[playerid][pCreatedVehicles] = 0;
	PlayerInfo[playerid][pLastVehicle] = INVALID_VEHICLE_ID;
	PlayerInfo[playerid][pLastVModelID] = 0;
	PlayerInfo[playerid][pColor] = -1;
	PlayerInfo[playerid][pRGB] = {0,0,0};
	PlayerInfo[playerid][pGodmod] = false;
	PlayerInfo[playerid][pVIP] = 0;
	PlayerInfo[playerid][pDMZone] = -1;
	PlayerInfo[playerid][pGroup] = 0;
	PlayerInfo[playerid][pGroupInvite] = 0;
	PlayerInfo[playerid][pGroupLevel] = 0;
	PlayerInfo[playerid][pToggle][0] = true;
	PlayerInfo[playerid][pToggle][1] = true;
	for(new i = 0; i < 10; i++) PlayerInfo[playerid][pSpeed][i] = 0.0;
	PlayerInfo[playerid][pDPos] = 0.0;
	PlayerInfo[playerid][pDSPos] = 0.0;
	PlayerInfo[playerid][pDrift] = {0,0,0,0};
	PlayerInfo[playerid][pDriftTD] = PlayerText:INVALID_TEXT_DRAW;
	PlayerInfo[playerid][pHideDriftTD] = 0;
	PlayerInfo[playerid][pSaveSkin] = -1;
	PlayerInfo[playerid][pWeapons] = 0;
	PlayerInfo[playerid][pAmmo] = 0;
	PlayerInfo[playerid][pAdminInv] = false;
	PlayerInfo[playerid][pProps] = 0;
	PlayerInfo[playerid][pEarns] = 0;
	PlayerInfo[playerid][pEarnType] = 1;
	PlayerInfo[playerid][pInActivity] = false;
	PlayerInfo[playerid][pActivityParams] = {0,0};
	PlayerInfo[playerid][pSpectate] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pSpamCheck][0] = GetTickCount();
	PlayerInfo[playerid][pSpamCheck][1] = GetTickCount();
	PlayerInfo[playerid][pBanned] = false;
	PlayerInfo[playerid][pFrozen] = false;
	PlayerInfo[playerid][pOldState] = 0;
	PlayerInfo[playerid][pMark] = 0.0;
	PlayerInfo[playerid][pMark2] = -1;
	PlayerInfo[playerid][pNoCMD] = false;
	PlayerInfo[playerid][pNoPM] = false;
	PlayerInfo[playerid][pMute] = 0;
	PlayerInfo[playerid][pCameraMode] = camera_none;
	PlayerInfo[playerid][pFlyObject] = 0;
	PlayerInfo[playerid][pFlyKeys] = 0;
	PlayerInfo[playerid][pLR] = 0;
	PlayerInfo[playerid][pUD] = 0;
	PlayerInfo[playerid][pLastMove] = 0;
	PlayerInfo[playerid][pAccelMul] = 0.0;
	PlayerInfo[playerid][pMoveSpeed] = 100.0;
	for(new i = 0; i < MAX_CAMERA_SAVES; i++) PlayerInfo[playerid][pCameraX][i] = 0.0, PlayerInfo[playerid][pCameraY][i] = 0.0, PlayerInfo[playerid][pCameraZ][i] = 0.0, PlayerInfo[playerid][pCameraLAX][i] = 0.0, PlayerInfo[playerid][pCameraLAY][i] = 0.0, PlayerInfo[playerid][pCameraLAZ][i] = 0.0;
	PlayerInfo[playerid][pCameraDirection] = 0;
	PlayerInfo[playerid][pCameraDistance] = 20.0;
	PlayerInfo[playerid][pCameraFollow] = false;
	PlayerInfo[playerid][pCameraFollowID] = playerid;
	PlayerInfo[playerid][pKickIn] = 0;
	PlayerInfo[playerid][pSpecAsk] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pQuest] = -1;
	PlayerInfo[playerid][pQuestStep] = 0;
	for(new i = 0; i < 46; i++) PlayerInfo[playerid][pUsingWeapons][i] = false, PlayerInfo[playerid][pShootTC][i] = 0;
	PlayerInfo[playerid][pWeaponWarns] = {0,0};
	PlayerInfo[playerid][pSawnoffAmmo] = -1;
	for(new i = 0; i < MAX_CHATS; i++) PlayerInfo[playerid][pChatJoinMessage][i] = 0;
	PlayerInfo[playerid][pPointsCooldown] = {0,0,0};
	PlayerInfo[playerid][pCooldownDelay] = false;
	PlayerInfo[playerid][pPickupID] = -1;
	PlayerInfo[playerid][pRadioSet] = false;
	PlayerInfo[playerid][pWeaponsCheatWait] = 0;
	PlayerInfo[playerid][pTag] = EOS;
	for(new i = 0; i < MAX_DCMDS; i++) PlayerInfo[playerid][pDeath][i] = false;
	PlayerInfo[playerid][pTPAsk] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pInvisible] = false;
	PlayerInfo[playerid][pChannel] = -1;
	PlayerInfo[playerid][pChannelToggle] = false;
	PlayerInfo[playerid][pRaise] = {INVALID_PLAYER_ID,0,INVALID_PLAYER_ID};
	for(new i = 0; i < 3; i++) PlayerInfo[playerid][pSpeedoText][i] = INVALID_PLAYER_TEXT_DRAW;
	PlayerInfo[playerid][pSpeedoVisible] = false;
	PlayerInfo[playerid][pChannelRampa] = {-1,0};
}
stock Register(playerid,pass[])
{
	new id = fgetint(file_users,"#Count") + 1, f[32], d[3];
	PlayerInfo[playerid][pLogged] = true;
	PlayerInfo[playerid][pID] = id;
	format(PlayerInfo[playerid][pUserFile],32,dir_users "%d.ini",id);
	format(f,32,PlayerInfo[playerid][pUserFile]);
	fcreate(f);
	getdate(d[2],d[1],d[0]);
	WorldTextDraw("show",playerid);
	// Password
	fsetstring(f,"Nickname",GetName(playerid));
	fsetstring(f,"Password",pass);
	fsetstring(f,"RegistrationPassword",pass);
	// Admin Mode
	fsetint(f,"TogCMD",0);
	fsetint(f,"TogPM",0);
	fsetint(f,"Jail",0);
	fsetint(f,"Mute",0);
	fsetstring(f,"Tag","None");
	fsetint(f,"TagColor",0);
	// Times & Dates
	fsetstring(f,"RegistrationIP",GetIP(playerid));
	fsetstring(f,"RegistrationDate",GetDateAsString());
	fsetstring(f,"RegistrationTime",GetTimeAsString());
	fsetstring(f,"LastConnectIP",GetIP(playerid));
	fsetstring(f,"LastConnectDate",GetDateAsString());
	fsetstring(f,"LastConnectTime",GetTimeAsString());
	fsetint(f,"TimeInServer",PlayerInfo[playerid][pConnectionTime][1]);
	// Stats
	fsetint(f,"Skin",PlayerInfo[playerid][pSaveSkin]);
	fsetint(f,"Level",PlayerInfo[playerid][pLevel]);
	fsetint(f,"Exp",PlayerInfo[playerid][pExp]);
	fsetint(f,"StuntPoints",PlayerInfo[playerid][pPoints][ptStunts]);
	fsetint(f,"DriftPoints",PlayerInfo[playerid][pPoints][ptDrifts]);
	fsetint(f,"SpeedPoints",PlayerInfo[playerid][pPoints][ptSpeed]);
	fsetint(f,"Kills",PlayerInfo[playerid][pRate][rtKills]);
	fsetint(f,"Assists",PlayerInfo[playerid][pRate][rtAssists]);
	fsetint(f,"Deaths",PlayerInfo[playerid][pRate][rtDeaths]);
	fsetint(f,"Headshots",PlayerInfo[playerid][pRate][rtHeadshots]);
	fsetint(f,"Damage",PlayerInfo[playerid][pRate][rtDamage]);
	fsetint(f,"Damaged",PlayerInfo[playerid][pRate][rtDamaged]);
	fsetint(f,"Bank",PlayerInfo[playerid][pBank]);
	// Account
	fsetint(f,"VIP",PlayerInfo[playerid][pVIP]);
	// Lists
	for(new i = 0; i < 55; i++) fsetint(f,frmt("WeaponKills-%d",i),PlayerInfo[playerid][pRate][rtWeapons][i]);
	for(new i = 0; i < max_settings; i++) fsetint(f,frmt("Setting-%s",Settings[i][stKey]),PlayerInfo[playerid][pSetting][i]);
	for(new i = 0; i < 10; i++) fsetint(f,frmt("Weapon-%d",i),PlayerInfo[playerid][pWeapons][i]);
	for(new i = 0; i < 8; i++) fsetint(f,frmt("Ammo-%d",i),PlayerInfo[playerid][pAmmo][i]);
	// Groups
	for(new i = 0; i < sizeof(GroupTypes); i++) fsetint(f,GroupTypes[i],PlayerInfo[playerid][pGroup][i]);
	for(new i = 0; i < sizeof(GroupTypes); i++) fsetint(f,frmt("%sLevel",GroupTypes[i]),PlayerInfo[playerid][pGroup][i]);
	// User Count
	fsetint(file_users,GetName(playerid),id);
	fsetint(file_users,"#Count",id);
}
stock Login(playerid)
{
	PlayerInfo[playerid][pLogged] = true;
	new f[32], id = GetUserID(playerid);
	PlayerInfo[playerid][pLogged] = true;
	PlayerInfo[playerid][pID] = id;
	format(PlayerInfo[playerid][pUserFile],32,dir_users "%d.ini",id);
	format(f,32,PlayerInfo[playerid][pUserFile]);
	PlayerInfo[playerid][pLoadSelection] = 1;
	// Update
	fsetstring(f,"LastConnectIP",GetIP(playerid));
	fsetstring(f,"LastConnectDate",GetDateAsString());
	fsetstring(f,"LastConnectTime",GetTimeAsString());
	format(PlayerInfo[playerid][pRegDate],16,fgetstring(f,"RegistrationDate"));
	PlayerInfo[playerid][pConnectionTime][1] = fgetint(f,"TimeInServer");
	// Admin Mode
	if(GetAdminLevel(PlayerInfo[playerid][pID]) > 0) PlayerInfo[playerid][pAdminLogged] = 1;
	else SendDeathMessage(INVALID_PLAYER_ID,playerid,200);
	PlayerInfo[playerid][pToggle][0] = bool:fgetint(f,"TogCMD");
	PlayerInfo[playerid][pToggle][1] = bool:fgetint(f,"TogPM");
	PlayerInfo[playerid][pMute] = fgetint(f,"Mute");
	PlayerInfo[playerid][pJail] = fgetint(f,"Jail");
	format(PlayerInfo[playerid][pTag],64,fgetstring(f,"Tag"));
	PlayerInfo[playerid][pTagColor] = fgetint(f,"TagColor");
	// Stats
	PlayerInfo[playerid][pSaveSkin] = fgetint(f,"Skin");
	PlayerInfo[playerid][pLevel] = fgetint(f,"Level");
	PlayerInfo[playerid][pExp] = fgetint(f,"Exp");
	PlayerInfo[playerid][pPoints][ptStunts] = fgetint(f,"StuntPoints");
	PlayerInfo[playerid][pPoints][ptDrifts] = fgetint(f,"DriftPoints");
	PlayerInfo[playerid][pPoints][ptSpeed] = fgetint(f,"SpeedPoints");
	PlayerInfo[playerid][pRate][rtKills] = fgetint(f,"Kills");
	PlayerInfo[playerid][pRate][rtAssists] = fgetint(f,"Assists");
	PlayerInfo[playerid][pRate][rtDeaths] = fgetint(f,"Deaths");
	PlayerInfo[playerid][pRate][rtHeadshots] = fgetint(f,"Headshots");
	PlayerInfo[playerid][pRate][rtDamage] = fgetint(f,"Damage");
	PlayerInfo[playerid][pRate][rtDamaged] = fgetint(f,"Damaged");
	PlayerInfo[playerid][pBank] = fgetint(f,"Bank");
	// Account
	PlayerInfo[playerid][pVIP] = fgetint(f,"VIP");
	// Lists
	for(new i = 0; i < 55; i++) PlayerInfo[playerid][pRate][rtWeapons][i] = fgetint(f,frmt("WeaponKills-%d",i));
	for(new i = 0; i < max_settings; i++) PlayerInfo[playerid][pSetting][i] = fgetint(f,frmt("Setting-%s",Settings[i][stKey]));
	SetPlayerFightingStyle(playerid,PlayerInfo[playerid][pSetting][setting_fs] == 1 ? 15 : (PlayerInfo[playerid][pSetting][setting_fs] + 3));
	for(new i = 0; i < 10; i++)
	{
		PlayerInfo[playerid][pWeapons][i] = fgetint(f,frmt("Weapon-%d",i));
		if(PlayerInfo[playerid][pWeapons][i] > 0) PlayerInfo[playerid][pUsingWeapons][PlayerInfo[playerid][pWeapons][i]-1] = true;
	}
	for(new i = 0; i < 8; i++) PlayerInfo[playerid][pAmmo][i] = fgetint(f,frmt("Ammo-%d",i));
	// Groups
	for(new i = 0; i < group_count; i++) if((PlayerInfo[playerid][pGroup][i] = fgetint(f,GroupTypes[i])) > 0)
	{
		PlayerInfo[playerid][pGroupLevel][i] = fgetint(f,frmt("%sLevel",GroupTypes[i]));
		GroupInfo[PlayerInfo[playerid][pGroup][i]][gMember][GroupInfo[PlayerInfo[playerid][pGroup][i]][gMembers]++] = playerid;
	}
	// Mute / Jail
	if(PlayerInfo[playerid][pMute] > 0) SendFormat(playerid,white," .חזר לך מיוט מהפעם האחרונה שהיית בשרת - %d שניות",PlayerInfo[playerid][pMute]);
	if(PlayerInfo[playerid][pJail] > 0) SendFormat(playerid,white," .חזר לך כלא מהפעם האחרונה שהיית בשרת - %d שניות",PlayerInfo[playerid][pJail]);
}
stock getkey(line[])
{
	new tmp[256];
	tmp[0] = 0;
	if(strfind(line,"=",true) == -1) return tmp;
	SetString(tmp,ret_memcpy(line,0,strfind(line,"=",true)));
	return tmp;
}
stock getvalue(line[])
{
	new tmp[256];
	tmp[0] = 0;
	if(strfind(line,"=",true) == -1) return tmp;
	SetString(tmp,ret_memcpy(line,strfind(line,"=",true)+1,strlen(line)));
	return tmp;
}
stock strlower(txt[])
{
	new tmp[256], i = 0, len = strlen(txt);
	tmp[0] = 0;
	if(txt[0] == 0) return tmp;
	for(i = 0; i < len; i++) tmp[i] = tolower(txt[i]);
	tmp[len] = 0;
	return tmp;
}
stock ret_memcpy(source[],index,numbytes)
{
	new tmp[256], i = 0;
	tmp[0] = 0;
	if(index >= strlen(source)) return tmp;
	if(numbytes+index >= strlen(source)) numbytes = strlen(source)-index;
	if(numbytes <= 0) return tmp;
	for(i=index;i<numbytes+index;i++)
	{
		tmp[i-index] = source[i];
		if(source[i] == 0) return tmp;
	}
	tmp[numbytes] = 0;
	return tmp;
}
stock StripNewLine(string[])
{
	new len = strlen(string);
	if(string[0] == 0) return 0;
	if((string[len-1] == '\n') || (string[len-1] == '\r'))
	{
		string[len-1] = 0;
		if(string[0] == 0) return 0;
		if((string[len-2] == '\n') || (string[len-2] == '\r')) string[len-2] = 0;
	}
	return 1;
}
stock fsetstring(filename[],key[],value[])
{
	new File:fohnd, File:fwhnd, bool:wasset=false, tmpres[256];
	if(key[0] == 0) return 0;
	format(tmpres,sizeof(tmpres),"%s.part",filename);
	fohnd = fopen(filename,io_read);
	if(!fohnd) return printf("fsetstring(%s,%s,%s) - cant open file",filename,key,value);
	if(fexist(tmpres)) fremove(tmpres);
	fwhnd = fopen(tmpres,io_write);
	while(fread(fohnd,tmpres))
	{
		StripNewLine(tmpres);
		if(!wasset && (equal(getkey(tmpres),key)))
		{
			format(tmpres,sizeof(tmpres),"%s=%s",key,value);
			wasset=true;
		}
		fwrite(fwhnd,tmpres);
		fwrite(fwhnd,"\r\n");
	}
	if(!wasset)
	{
		format(tmpres,sizeof(tmpres),"%s=%s",key,value);
		fwrite(fwhnd,tmpres);
		fwrite(fwhnd,"\r\n");
	}
	fclose(fohnd);
	fclose(fwhnd);
	format(tmpres,sizeof(tmpres),"%s.part",filename);
	if(fcopytextfile(tmpres,filename)) return fremove(tmpres);
	return 0;
}
stock fsetint(filename[],key[],value)
{
   new valuestring[256];
   format(valuestring,sizeof(valuestring),"%d",value);
   return fsetstring(filename,key,valuestring);
}
stock fgetint(filename[],key[]) return strval(fgetstring(filename,key));
stock fsetfloat(filename[],key[],Float:value)
{
   new valuestring[256];
   format(valuestring,sizeof(valuestring),"%f",value);
   return fsetstring(filename,key,valuestring);
}
forward Float:fgetfloat(filename[],key[]);
stock Float:fgetfloat(filename[],key[]) return floatstr(fgetstring(filename,key));
stock fremovekey(filename[],key[])
{
	new File:fohnd, File:fwhnd, tmpres[256];
	format(tmpres,sizeof(tmpres),"%s.part",filename);
	fohnd = fopen(filename,io_read);
	if(!fohnd) return 0;
	fremove(tmpres);
	fwhnd = fopen(tmpres,io_write);
	while(fread(fohnd,tmpres))
	{
		StripNewLine(tmpres);
		if(equal(getkey(tmpres),key))
		{
			format(tmpres,sizeof(tmpres),"%s",tmpres);
			fwrite(fwhnd,tmpres);
			fwrite(fwhnd,"\r\n");
		}
	}
	fclose(fohnd);
	fclose(fwhnd);
	format(tmpres,sizeof(tmpres),"%s.part",filename);
	if(fcopytextfile(tmpres,filename)) return fremove(tmpres);
	return 0;
}
stock fgetstring(filename[],key[])
{
	new File:fohnd, tmpres[256], tmpres2[256];
	tmpres[0] = -1;
	fohnd = fopen(filename,io_read);
	//if(!fohnd) return tmpres;
	while(fread(fohnd,tmpres))
	{
		StripNewLine(tmpres);
		if(equal(getkey(tmpres),key))
		{
			tmpres2[0]=0;
			strcat(tmpres2,getvalue(tmpres));
			fclose(fohnd);
			return tmpres2;
		}
	}
	fclose(fohnd);
	return tmpres;
}
stock fkeyexist(filename[],key[])
{
	new File:fohnd, tmpres[256];
	fohnd = fopen(filename,io_read);
	if(!fohnd) return 0;
	while(fread(fohnd,tmpres))
	{
		StripNewLine(tmpres);
		if(equal(getkey(tmpres),key))
		{
			fclose(fohnd);
			return 1;
		}
	}
	fclose(fohnd);
	return 0;
}
stock fcopytextfile(oldname[],newname[])
{
	new File:ohnd, File:nhnd;
	if(!fexist(oldname)) return 0;
	ohnd = fopen(oldname,io_read), nhnd = fopen(newname,io_write);
	new tmpres[256];
	while(fread(ohnd,tmpres))
	{
		StripNewLine(tmpres);
		format(tmpres,sizeof(tmpres),"%s\r\n",tmpres);
		fwrite(nhnd,tmpres);
	}
	fclose(ohnd);
	fclose(nhnd);
	return 1;
}
stock strtok(const string[], &index, somechar = ' ')
{   // by CompuPhase, improved by me
	new length = strlen(string), result[60];
	while((index < length) && (string[index] <= somechar)) index++;
	new offset = index;
	while((index < length) && (string[index] > somechar) && ((index - offset) < (sizeof(result) - 1))) result[index - offset] = string[index], index++;
	result[index - offset] = EOS;
	return result;
}
stock strtok2(const string[], &index, sep1, sep2)
{   // by CompuPhase, improved by me
	new length = strlen(string), result[60];
	while((index < length) && (string[index] <= sep1 && string[index] <= sep2)) index++;
	new offset = index;
	while((index < length) && (string[index] > sep1 || string[index] > sep2) && ((index - offset) < (sizeof(result) - 1))) result[index - offset] = string[index], index++;
	result[index - offset] = EOS;
	return result;
}
stock strrest(const string[], index)
{   // by CompuPhase, improved by me
	new length = strlen(string), offset = index, result[M_S];
	while((index < length) && ((index - offset) < (sizeof(result) - 1)) && (string[index] > '\r')) result[index - offset] = string[index], index++;
	result[index - offset] = EOS;
	if(result[0] == ' ' && string[0] != ' ') strdel(result,0,1);
	return result;
}
stock SetString(dest[],source[])
{   // by DracoBlue, improved by me
	new count = strlen(source), i = 0;
	for(i=0;i<count;i++) dest[i] = source[i];
	dest[count] = 0;
	return 1;
}
stock fcreate(filename[])
{
	if(fexist(filename)) return;
	new File:f = fopen(filename,io_write);
	if(f) fclose(f);
}
stock IsNumeric(const string[])
{
	for(new i = 0, j = strlen(string); i < j; i++) if((string[i] < '0' || string[i] > '9') && string[i] != '-') return 0;
	return 1;
}
stock ReturnUser(text[],playerid)
{	// by Y_Less, improved by me
	new pos = 0, userid = INVALID_PLAYER_ID, count = 0, name[MAX_PLAYER_NAME];
	if((text[0] == '@' || text[0] == '#') && strlen(text) < 32 && playerid != INVALID_PLAYER_ID)
	{
	    new cmd[32];
	    format(cmd,sizeof(cmd),"%s",text[1]);
	    if(equal(cmd,"m") || equal(cmd,"me") || equal(cmd,"i")) return playerid;
	    else if(equal(cmd,"a") || equal(cmd,"admin"))
	    {
	        new ret = INVALID_PLAYER_ID;
	        LoopEx(i,<ret == INVALID_PLAYER_ID>) if(IsPlayerConnected(i) && IsPlayerMAdmin(i) && i != playerid) ret = i;
	        return ret;
	    }
	    else if(equal(cmd,"r") || equal(cmd,"random")) return GetRandomPlayer();
	    else return INVALID_PLAYER_ID;
	}
	else
	{
		while(text[pos] < 0x21)
		{
			if(!text[pos]) return INVALID_PLAYER_ID;
			pos++;
		}
		if(IsNumeric(text[pos]))
		{
			userid = strval(text[pos]);
			if(userid >= 0 && userid < MAX_PLAYERS)
			{
				if(!IsPlayerConnected(userid)) userid = INVALID_PLAYER_ID;
				else return userid;
			}
		}
		new len = strlen(text[pos]);
		Loop(i) if(IsPlayerConnected(i)) if(strcmp(GetName(i),text[pos],true,len) == 0)
		{
			if(len == strlen(name)) return i;
			else count++, userid = i;
		}
		if(count != 1) userid = INVALID_PLAYER_ID;
	}
	return userid;
}
stock IsPlayerMAdmin(playerid) return IsPlayerConnected(playerid) && ((PlayerInfo[playerid][pAdmin] > 0 && PlayerInfo[playerid][pAdmin] <= 10 && PlayerInfo[playerid][pAdminLogged] == 2) || IsPlayerAdmin(playerid));
stock IsValidNick(name[])
{
	if(strlen(name) < 3 || strlen(name) > 20 || equal(name,"None")) return 0;
	for(new i = 0, j = strlen(name); i < j; i++)
	{
		if(!(name[i] >= '0' && name[i] <= '9')
		&& !(name[i] >= 'A' && name[i] <= 'Z')
		&& !(name[i] >= 'a' && name[i] <= 'z')
		&& name[i] != '_' && name[i] != '[' && name[i] != ']'
		&& name[i] != '.' && name[i] != '(' && name[i] != ')'
		&& name[i] != '@' && name[i] != '$') return 0;
	}
	return 1;
}
stock SendPM(playerid,receiverid,text[])
{
	if(PlayerInfo[receiverid][pAFK]) return SendClientMessage(playerid,red," .AFK משתמש זה נמצב כרגע במצב"), 0;
	if(PlayerInfo[receiverid][pBlockPMs] && !IsPlayerMAdmin(receiverid)) return SendClientMessage(playerid,red," .משתמש זה בחר שלא לקבל הודעות פרטיות"), 0;
	PlayerInfo[receiverid][pLastPM] = playerid;
	SendFormat(playerid,yellow,"PM sent to %s(%d): %s",GetName(receiverid),receiverid,text);
	SendFormat(receiverid,yellow,"PM from %s(%d): %s",GetName(playerid),playerid,text);
	frmt("[PM] %s (%03d) to %s (%03d): %s",GetName(playerid),playerid,GetName(receiverid),receiverid,text);
	Loop(i) if(IsPlayerMAdmin(i) && PlayerInfo[i][pAdmin] >= PlayerInfo[playerid][pAdmin] && i != playerid && i != receiverid && PlayerInfo[i][pToggle][1]) SendClientMessage(i,yellow,fstring);
	return 1;
}
stock GetUserID(playerid) return !PlayerInfo[playerid][pUserID] ? (PlayerInfo[playerid][pUserID] = (fkeyexist(file_users,GetName(playerid)) ? fgetint(file_users,GetName(playerid)) : 0)) : PlayerInfo[playerid][pUserID];
stock GetUserIDByName(name[]) return fkeyexist(file_users,name) ? fgetint(file_users,name) : 0;
stock GetRandomPlayer()
{
	new mx = GetMaxPlayers(), rnd = mx;
	while(!IsPlayerConnected(rnd)) rnd = randomEx(0,mx+1);
	return rnd;
}
stock randomEx(min,max) return random(max-min)+min;
stock ShowFile(playerid,color,file[])
{
	new File:fh, read[M_S];
	fh = fopen(file,io_read);
	if(fh)
	{
		while(fread(fh,read,sizeof(read),false)) if(playerid == -1) SendClientMessageToAll(color,read); else SendClientMessage(playerid,color,read);
		fclose(fh);
	}
}
stock GetTimeAsString(bool=false)
{
	new t[3], s[16];
	gettime(t[0],t[1],t[2]);
	if(bool) format(s,sizeof(s),"%02d:%02d:%02d",t[0],t[1],t[2]);
	else format(s,sizeof(s),"%02d:%02d",t[0],t[1]);
	return s;
}
stock GetDateAsString(tav = '/')
{
	new d[3], s[16];
	getdate(d[0],d[1],d[2]);
	format(s,sizeof(s),"%02d%c%02d%c%04d",d[2],tav,d[1],tav,d[0]);
	return s;
}
stock WorldTextDraw(todo[],playerid = INVALID_PLAYER_ID)
{
	if(equal(todo,"create"))
	{
		const color = 0x0000FFCC;
		// stunts
		WorldInfo[world_stunts][wTD][1] = TextDrawCreate(165.000000,244.000000,"(players: 00)");
		TextDrawAlignment(WorldInfo[world_stunts][wTD][1],2);
		TextDrawBackgroundColor(WorldInfo[world_stunts][wTD][1],255);
		TextDrawFont(WorldInfo[world_stunts][wTD][1],2);
		TextDrawLetterSize(WorldInfo[world_stunts][wTD][1],0.189999,1.000000);
		TextDrawColor(WorldInfo[world_stunts][wTD][1],-1);
		TextDrawSetOutline(WorldInfo[world_stunts][wTD][1],1);
		TextDrawSetProportional(WorldInfo[world_stunts][wTD][1],1);
		//TextDrawSetSelectable(WorldInfo[world_stunts][wTD][1],1);
		WorldInfo[world_stunts][wTD][2] = TextDrawCreate(123.000000,170.000000,"           ");
		TextDrawBackgroundColor(WorldInfo[world_stunts][wTD][2],255);
		TextDrawFont(WorldInfo[world_stunts][wTD][2],5);
		TextDrawLetterSize(WorldInfo[world_stunts][wTD][2],0.519999, 1.899999);
		TextDrawColor(WorldInfo[world_stunts][wTD][2],-1);
		TextDrawSetOutline(WorldInfo[world_stunts][wTD][2],0);
		TextDrawSetProportional(WorldInfo[world_stunts][wTD][2],1);
		TextDrawSetShadow(WorldInfo[world_stunts][wTD][2],1);
		TextDrawUseBox(WorldInfo[world_stunts][wTD][2],1);
		TextDrawBoxColor(WorldInfo[world_stunts][wTD][2],color);
		TextDrawTextSize(WorldInfo[world_stunts][wTD][2],83.000000,80.000000);
		TextDrawSetPreviewModel(WorldInfo[world_stunts][wTD][2],522);
		TextDrawSetPreviewRot(WorldInfo[world_stunts][wTD][2],330.000000,10.000000,50.000000,0.800000);
		TextDrawSetSelectable(WorldInfo[world_stunts][wTD][2],1);
		WorldInfo[world_stunts][wTD][0] = TextDrawCreate(165.000000,159.000000,Worlds[world_stunts][wName]);
		TextDrawAlignment(WorldInfo[world_stunts][wTD][0],2);
		TextDrawBackgroundColor(WorldInfo[world_stunts][wTD][0],255);
		TextDrawFont(WorldInfo[world_stunts][wTD][0],1);
		TextDrawLetterSize(WorldInfo[world_stunts][wTD][0],0.349999,2.099999);
		TextDrawColor(WorldInfo[world_stunts][wTD][0],-1);
		TextDrawSetOutline(WorldInfo[world_stunts][wTD][0],1);
		TextDrawSetProportional(WorldInfo[world_stunts][wTD][0],1);
		//TextDrawSetSelectable(WorldInfo[world_stunts][wTD][0],1);
		// stunts wo
		WorldInfo[world_stuntswo][wTD][1] = TextDrawCreate(255.000000,244.000000,"(players: 00)");
		TextDrawAlignment(WorldInfo[world_stuntswo][wTD][1],2);
		TextDrawBackgroundColor(WorldInfo[world_stuntswo][wTD][1],255);
		TextDrawFont(WorldInfo[world_stuntswo][wTD][1],2);
		TextDrawLetterSize(WorldInfo[world_stuntswo][wTD][1],0.189999,1.000000);
		TextDrawColor(WorldInfo[world_stuntswo][wTD][1],-1);
		TextDrawSetOutline(WorldInfo[world_stuntswo][wTD][1],1);
		TextDrawSetProportional(WorldInfo[world_stuntswo][wTD][1],1);
		//TextDrawSetSelectable(WorldInfo[world_stuntswo][wTD][1],1);
		WorldInfo[world_stuntswo][wTD][2] = TextDrawCreate(213.000000,170.000000,"           ");
		TextDrawBackgroundColor(WorldInfo[world_stuntswo][wTD][2],255);
		TextDrawFont(WorldInfo[world_stuntswo][wTD][2],5);
		TextDrawLetterSize(WorldInfo[world_stuntswo][wTD][2],0.519999,1.899999);
		TextDrawColor(WorldInfo[world_stuntswo][wTD][2],-1);
		TextDrawSetOutline(WorldInfo[world_stuntswo][wTD][2],0);
		TextDrawSetProportional(WorldInfo[world_stuntswo][wTD][2],1);
		TextDrawSetShadow(WorldInfo[world_stuntswo][wTD][2],1);
		TextDrawUseBox(WorldInfo[world_stuntswo][wTD][2],1);
		TextDrawBoxColor(WorldInfo[world_stuntswo][wTD][2],color);
		TextDrawTextSize(WorldInfo[world_stuntswo][wTD][2],83.000000,80.000000);
		TextDrawSetPreviewModel(WorldInfo[world_stuntswo][wTD][2],19005);
		TextDrawSetPreviewRot(WorldInfo[world_stuntswo][wTD][2],300.000000,10.000000,90.000000,1.100000);
		TextDrawSetSelectable(WorldInfo[world_stuntswo][wTD][2],1);
		WorldInfo[world_stuntswo][wTD][0] = TextDrawCreate(255.000000,159.000000,Worlds[world_stuntswo][wName]);
		TextDrawAlignment(WorldInfo[world_stuntswo][wTD][0],2);
		TextDrawBackgroundColor(WorldInfo[world_stuntswo][wTD][0],255);
		TextDrawFont(WorldInfo[world_stuntswo][wTD][0],1);
		TextDrawLetterSize(WorldInfo[world_stuntswo][wTD][0],0.349999,2.099999);
		TextDrawColor(WorldInfo[world_stuntswo][wTD][0],-1);
		TextDrawSetOutline(WorldInfo[world_stuntswo][wTD][0],1);
		TextDrawSetProportional(WorldInfo[world_stuntswo][wTD][0],1);
		TextDrawSetPreviewRot(WorldInfo[world_stuntswo][wTD][0],-16.000000,0.000000,-55.000000,0.000000);
		//TextDrawSetSelectable(WorldInfo[world_stuntswo][wTD][0],1);
		// dm
		WorldInfo[world_dm][wTD][1] = TextDrawCreate(345.000000,244.000000,"(players: 00)");
		TextDrawAlignment(WorldInfo[world_dm][wTD][1],2);
		TextDrawBackgroundColor(WorldInfo[world_dm][wTD][1],255);
		TextDrawFont(WorldInfo[world_dm][wTD][1],2);
		TextDrawLetterSize(WorldInfo[world_dm][wTD][1],0.189999,1.000000);
		TextDrawColor(WorldInfo[world_dm][wTD][1],-1);
		TextDrawSetOutline(WorldInfo[world_dm][wTD][1],1);
		TextDrawSetProportional(WorldInfo[world_dm][wTD][1],1);
		//TextDrawSetSelectable(WorldInfo[world_dm][wTD][1],1);
		WorldInfo[world_dm][wTD][2] = TextDrawCreate(303.000000,170.000000,"           ");
		TextDrawBackgroundColor(WorldInfo[world_dm][wTD][2],255);
		TextDrawFont(WorldInfo[world_dm][wTD][2],5);
		TextDrawLetterSize(WorldInfo[world_dm][wTD][2],0.519999,1.899999);
		TextDrawColor(WorldInfo[world_dm][wTD][2],-1);
		TextDrawSetOutline(WorldInfo[world_dm][wTD][2],0);
		TextDrawSetProportional(WorldInfo[world_dm][wTD][2],1);
		TextDrawSetShadow(WorldInfo[world_dm][wTD][2],1);
		TextDrawUseBox(WorldInfo[world_dm][wTD][2],1);
		TextDrawBoxColor(WorldInfo[world_dm][wTD][2],color);
		TextDrawTextSize(WorldInfo[world_dm][wTD][2],83.000000,80.000000);
		TextDrawSetPreviewModel(WorldInfo[world_dm][wTD][2],348);
		TextDrawSetPreviewRot(WorldInfo[world_dm][wTD][2],0.000000,0.000000,180.000000,1.450000);
		TextDrawSetSelectable(WorldInfo[world_dm][wTD][2],1);
		WorldInfo[world_dm][wTD][3] = TextDrawCreate(208.000000,179.000000,"           ");
		TextDrawBackgroundColor(WorldInfo[world_dm][wTD][3],255);
		TextDrawFont(WorldInfo[world_dm][wTD][3],5);
		TextDrawLetterSize(WorldInfo[world_dm][wTD][3],0.519999,1.899999);
		TextDrawColor(WorldInfo[world_dm][wTD][3],-1);
		TextDrawSetOutline(WorldInfo[world_dm][wTD][3],0);
		TextDrawSetProportional(WorldInfo[world_dm][wTD][3],1);
		TextDrawSetShadow(WorldInfo[world_dm][wTD][3],1);
		TextDrawUseBox(WorldInfo[world_dm][wTD][3],1);
		TextDrawBoxColor(WorldInfo[world_dm][wTD][3],color);
		TextDrawTextSize(WorldInfo[world_dm][wTD][3],83.000000,80.000000);
		TextDrawSetPreviewModel(WorldInfo[world_dm][wTD][3],346);
		TextDrawSetPreviewRot(WorldInfo[world_dm][wTD][3],0.000000,0.000000,0.000000,1.399999);
		TextDrawSetSelectable(WorldInfo[world_dm][wTD][3],1);
		WorldInfo[world_dm][wTD][0] = TextDrawCreate(345.000000,159.000000,Worlds[world_dm][wName]);
		TextDrawAlignment(WorldInfo[world_dm][wTD][0],2);
		TextDrawBackgroundColor(WorldInfo[world_dm][wTD][0],255);
		TextDrawFont(WorldInfo[world_dm][wTD][0],1);
		TextDrawLetterSize(WorldInfo[world_dm][wTD][0],0.349999,2.099999);
		TextDrawColor(WorldInfo[world_dm][wTD][0],-1);
		TextDrawSetOutline(WorldInfo[world_dm][wTD][0],1);
		TextDrawSetProportional(WorldInfo[world_dm][wTD][0],1);
		//TextDrawSetSelectable(WorldInfo[world_dm][wTD][0],1);
		// tdm
		WorldInfo[world_tdm][wTD][1] = TextDrawCreate(435.000000,244.000000,"(players: 00)");
		TextDrawAlignment(WorldInfo[world_tdm][wTD][1],2);
		TextDrawBackgroundColor(WorldInfo[world_tdm][wTD][1],255);
		TextDrawFont(WorldInfo[world_tdm][wTD][1],2);
		TextDrawLetterSize(WorldInfo[world_tdm][wTD][1],0.189999,1.000000);
		TextDrawColor(WorldInfo[world_tdm][wTD][1],-1);
		TextDrawSetOutline(WorldInfo[world_tdm][wTD][1],1);
		TextDrawSetProportional(WorldInfo[world_tdm][wTD][1],1);
		//TextDrawSetSelectable(WorldInfo[world_tdm][wTD][1],1);
		WorldInfo[world_tdm][wTD][2] = TextDrawCreate(394.000000,170.000000,"           ");
		TextDrawBackgroundColor(WorldInfo[world_tdm][wTD][2],255);
		TextDrawFont(WorldInfo[world_tdm][wTD][2],5);
		TextDrawLetterSize(WorldInfo[world_tdm][wTD][2],0.519999,1.899999);
		TextDrawColor(WorldInfo[world_tdm][wTD][2],-1);
		TextDrawSetOutline(WorldInfo[world_tdm][wTD][2],0);
		TextDrawSetProportional(WorldInfo[world_tdm][wTD][2],1);
		TextDrawSetShadow(WorldInfo[world_tdm][wTD][2],1);
		TextDrawUseBox(WorldInfo[world_tdm][wTD][2],1);
		TextDrawBoxColor(WorldInfo[world_tdm][wTD][2],color);
		TextDrawTextSize(WorldInfo[world_tdm][wTD][2],83.000000,80.000000);
		TextDrawSetPreviewModel(WorldInfo[world_tdm][wTD][2],280);
		TextDrawSetPreviewRot(WorldInfo[world_tdm][wTD][2],-16.000000,0.000000,-55.000000,1.000000);
		TextDrawSetSelectable(WorldInfo[world_tdm][wTD][2],1);
		WorldInfo[world_tdm][wTD][0] = TextDrawCreate(435.000000,159.000000,"TDM");
		TextDrawAlignment(WorldInfo[world_tdm][wTD][0],2);
		TextDrawBackgroundColor(WorldInfo[world_tdm][wTD][0],255);
		TextDrawFont(WorldInfo[world_tdm][wTD][0],1);
		TextDrawLetterSize(WorldInfo[world_tdm][wTD][0],0.349999,2.099999);
		TextDrawColor(WorldInfo[world_tdm][wTD][0],-1);
		TextDrawSetOutline(WorldInfo[world_tdm][wTD][0],1);
		TextDrawSetProportional(WorldInfo[world_tdm][wTD][0],1);
		//TextDrawSetSelectable(WorldInfo[world_tdm][wTD][0],1);
	}
	else if(equal(todo,"show"))
	{
		for(new i = 0; i < sizeof(Worlds); i++) if(Worlds[i][wPlayable]) for(new j = 0; j < 3; j++) TextDrawShowForPlayer(playerid,WorldInfo[i][wTD][j]);
		PlayerInfo[playerid][pConnectStage] = ct_selectworld;
		SelectTextDraw(playerid,white);
		SetPlayerPos(playerid,229.8910,-1870.9111,6.0000);
		SetPlayerFacingAngle(playerid,1.5668);
		SetPlayerCameraPos(playerid,198.044738,-1750.411132,20.670663);
		SetPlayerCameraLookAt(playerid,229.387725,-1844.057250,10.845205);
	}
	else if(equal(todo,"hide"))
	{
		for(new i = 0; i < sizeof(Worlds); i++) if(Worlds[i][wPlayable]) for(new j = 0; j < 3; j++) TextDrawHideForPlayer(playerid,WorldInfo[i][wTD][j]);
		CancelSelectTextDraw(playerid);
	}
}
stock WorldPlayer(worldid,bool:add)
{
	WorldInfo[worldid][wPlayers] += add ? 1 : (-1);
	if(worldid >= 0 && worldid < sizeof(Worlds) && Worlds[worldid][wPlayable]) TextDrawSetString(WorldInfo[worldid][wTD][1],frmt("(players: %02d)",WorldInfo[worldid][wPlayers]));
}
stock GetPlayerCheckpoint(playerid) return PlayerInfo[playerid][pCheckpoint] == -1 ? cp_none : Checkpoints[PlayerInfo[playerid][pCheckpoint]][cpType];
stock CreateArea(Float:minx,Float:miny,Float:maxx,Float:maxy,type,param=0,interior=0,world=0,Float:minz=0.0,Float:maxz=0.0)
{
	new aid = -1;
	aid = minz == 0.0 ? CreateDynamicRectangle(minx,miny,maxx,maxy,worlds_gameplay + world,interior) : CreateDynamicCube(minx,miny,minz,maxx,maxy,maxz,worlds_gameplay + world,interior);
	if(aid == -1) return -1;
	AreaInfo[aid][arValid] = true;
	AreaInfo[aid][arCoords][0] = minx;
	AreaInfo[aid][arCoords][1] = miny;
	AreaInfo[aid][arCoords][2] = maxx;
	AreaInfo[aid][arCoords][3] = maxy;
	AreaInfo[aid][arHeight][0] = minz;
	AreaInfo[aid][arHeight][1] = maxz;
	AreaInfo[aid][arType] = type;
	AreaInfo[aid][arParam] = param;
	AreaInfo[aid][arWorld] = world;
	AreaInfo[aid][arInterior] = interior;
	return aid;
}
stock DestroyArea(id)
{
	DestroyDynamicArea(id);
	AreaInfo[aid][arValid] = false;
	return 1;
}
stock CheckWorld(playerid,bool:both,...)
{
	new bool:heIsIn = false, str[128];
	for(new i = 2, n = numargs(), t = 0; i < n; i++)
	{
		if(PlayerInfo[playerid][pWorld] == (t = getarg(i))) heIsIn = true;
		format(str,sizeof(str),i == 2 ? ("%s%s") : ("%s / %s"),str,Worlds[t][wName]);
	}
	if(!heIsIn) return SendFormat(playerid,red," • !לא תוכל להשתמש בה ," @c(orange) "%s" @c(red) " מאחר ואתה בעולם ." @c(orange) "%s" @c(red) " לשימוש באפשרות זו אתה מחוייב להיות בעולם",Worlds[PlayerInfo[playerid][pWorld]][wName],str), 0;
	else
	{
		if(both) SendFormat(playerid,green," • !אתה יכול להשתמש בה כרגע ." @c(orange) "%s" @c(green) " לשימוש באפשרות זו אתה מחוייב להיות בעולם",str);
		return 1;
	}
}
stock SetKick(playerid,adminid,reason[])
{
	//if(playerid != -1) return 1;
	if(IsPower(playerid) || PlayerInfo[playerid][pKickIn]) return 1;
	if(adminid == -1) SendFormatToAll(0xFF0000FF," * %s has been kicked by the server (%s)",GetName(playerid),reason);
	else SendFormatToAll(0xFF0000FF," * %s has been kicked by %s (%s)",GetName(playerid),GetName(adminid),reason);
	if(!PlayerInfo[playerid][pKickIn]) PlayerInfo[playerid][pKickIn] = 1;
	return 1;
}
stock SetBan(ip[],adminid,reason[],playerid=INVALID_PLAYER_ID)
{
	if(IsPower(playerid) || PlayerInfo[playerid][pKickIn]) return 1;
	if(playerid != INVALID_PLAYER_ID)
	{
		if(adminid == -1) SendFormatToAll(0xFF0000FF," * %s has been banned by the server (%s)",GetName(playerid),reason);
		else SendFormatToAll(0xFF0000FF," * %s has been banned by %s (%s)",GetName(playerid),GetName(adminid),reason);
	}
	new pl[MAX_PLAYERS] = {INVALID_PLAYER_ID,...}, pls = 0;
	Loop(i) if(equal(GetIP(i),ip)) pl[pls++] = i;
	for(new i = 0; i < pls; i++) if(!PlayerInfo[pl[i]][pKickIn]) PlayerInfo[pl[i]][pKickIn] = 1;
	new f[64];
	format(f,sizeof(f),dir_bans "%s.ini",ip);
	fcreate(f);
	if(playerid != INVALID_PLAYER_ID) fsetstring(f,"PlayerName",GetName(playerid));
	fsetstring(f,"PlayerIP",ip);
	if(adminid == -1) fsetstring(f,"AdminName","#Server");
	else fsetstring(f,"AdminName",GetName(adminid));
	fsetstring(f,"AdminIP",GetIP(adminid));
	fsetstring(f,"Reason",reason);
	fsetstring(f,"Date",GetDateAsString());
	fsetstring(f,"Time",GetTimeAsString(true));
	if(playerid != INVALID_PLAYER_ID) if(!fkeyexist(file_bans,GetName(playerid))) fsetstring(file_bans,GetName(playerid),ip);
	return 1;
}
stock GiveMoney(playerid,amount,bool:snd=true)
{
	if(!amount) return 1;
	if((PlayerInfo[playerid][pMoney]+amount) <= 0 || (GetPlayerMoney(playerid)+amount) <= 0) ResetMoney(playerid);
	else
	{
		PlayerInfo[playerid][pMoney] += amount;
		GivePlayerMoney(playerid,amount);
	}
	if(!PlayerInfo[playerid][pAFK] && snd) PlaySound(playerid,1052);
	return 1;
}
stock ResetMoney(playerid,bool:snd=true)
{
	PlayerInfo[playerid][pMoney] = 0;
	ResetPlayerMoney(playerid);
	if(!PlayerInfo[playerid][pAFK] && snd) PlaySound(playerid,1053);
	return 1;
}
stock GetMoney(playerid) return PlayerInfo[playerid][pMoney];
stock ShowStats(playerid,id)
{
	new Float:h[2];
	SendFormat(playerid,lightblue,id == playerid ? (" ~~~ [%s] :%s - הסטטיסטיקות שלך ~~~") : (" ~~~ [%s] :%s הסטטיסטיקות של ~~~"),GetDateAsString(),GetName(id));
	SendFormat(playerid,green," » Exp: %d/%d • %s :רמה %d • %s :משחק בעולם • UserID: %d",PlayerInfo[id][pExp],Levels[PlayerInfo[id][pLevel] + _:(!(PlayerInfo[id][pLevel] == sizeof(Levels)))][lvlExp],Levels[PlayerInfo[id][pLevel]][lvlName],PlayerInfo[id][pLevel],Worlds[PlayerInfo[id][pWorld]][wName],GetUserID(id));
	GetPlayerHealth(id,h[0]);
	GetPlayerArmour(id,h[1]);
	SendFormat(playerid,grey," יחס: %.2f | פעמי מוות: %d | הריגות: %d | הד-שוטים: %d",ratio(PlayerInfo[id][pRate][rtKills],PlayerInfo[id][pRate][rtDeaths]),PlayerInfo[id][pRate][rtDeaths],PlayerInfo[id][pRate][rtKills],PlayerInfo[id][pRate][rtHeadshots]);
	SendFormat(playerid,grey," יחס: %.2f | הותקף: %d | התקיף: %d | אסיסט: %d",ratio(PlayerInfo[id][pRate][rtDamage],PlayerInfo[id][pRate][rtDamaged]),PlayerInfo[id][pRate][rtDamage],PlayerInfo[id][pRate][rtDamaged],PlayerInfo[id][pRate][rtAssists]);
	SendFormat(playerid,grey," נקודות סטאנטים: %d | נקודות דריפטים: %d | נקודות מהירות: %d",PlayerInfo[id][pPoints][ptStunts],PlayerInfo[id][pPoints][ptDrifts],PlayerInfo[id][pPoints][ptSpeed]);
	SendFormat(playerid,grey," סקין: %d | חיים: %d %% | מגן: %d %% | זמן משחק: %02d:%02d:%02d",GetPlayerSkin(id),PlayerInfo[id][pGodmod] ? 999 : floatround(h[0]),floatround(h[1]),PlayerInfo[id][pConnectionTime][0]/3600,(PlayerInfo[id][pConnectionTime][0]/60)-((PlayerInfo[id][pConnectionTime][0]/3600)*60),PlayerInfo[id][pConnectionTime][0]%60);
	SendFormat(playerid,grey," נרשם לשרת בתאריך: %s | ימים שעברו מאז ההרשמה: %d | כמות שעות ששיחק: %d",PlayerInfo[id][pRegDate],DaysBetweenDates(PlayerInfo[id][pRegDate],GetDateAsString()),(PlayerInfo[id][pConnectionTime][1]+PlayerInfo[id][pConnectionTime][0])/3600);
	SendFormat(playerid,grey," %s :קלאן | %s :קרו",GroupInfo[PlayerInfo[id][pGroup][group_clan]][gName],GroupInfo[PlayerInfo[id][pGroup][group_crew]][gName]);
	return 1;
}
stock mktime(hour,minute,second,day,month,year)
{   // by DracoBlue, improved by me
	new days_of_month[12], timestamp = second + (minute * 60) + (hour * 3600), days_this_year = 0;
	if(((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) days_of_month = {31,29,31,30,31,30,31,31,30,31,30,31};
	else days_of_month = {31,28,31,30,31,30,31,31,30,31,30,31};
	days_this_year = day;
	if(month > 1) for(new i=0; i<month-1;i++) days_this_year += days_of_month[i];
	timestamp += days_this_year * 86400;
	for(new j=1970;j<year;j++) timestamp += ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)? 31536000+86400:31536000;
	return timestamp;
}
stock DaysBetweenDates(DateStart[],DateEnd[])
{	// by SharkyKH, improved by me
	new idx1, idx2;
	new Start_Day = strval(strtok(DateStart,idx1,'/'));
	new Start_Month = strval(strtok(DateStart,idx1,'/'));
	new Start_Year = strval(strtok(DateStart,idx1,'/'));
	new End_Day = strval(strtok(DateEnd,idx2,'/'));
	new End_Month = strval(strtok(DateEnd,idx2,'/'));
	new End_Year = strval(strtok(DateEnd,idx2,'/'));
	new init_date = mktime(12,0,0,Start_Day,Start_Month,Start_Year);
	new dest_date = mktime(12,0,0,End_Day,End_Month,End_Year);
	return floatround((dest_date-init_date)/60/60/24,floatround_floor);
}
stock UpdateTeleports()
{
	new fileList[MAX_TELEPORTS][16], fname[32], File:fh;
	fh = fopen(file_tele,io_read), teleCount = 0;
	if(fh)
	{
		while(fread(fh,fname))
		{
			StripNewLine(fname);
			if(fexist(frmt(dir_tele "%s.ini",fname))) SetString(fileList[teleCount++],fname);
		}
		fclose(fh);
	}
	for(new i = 0, Float:p[4]; i < teleCount; i++)
	{
		format(fname,sizeof(fname),dir_tele "%s.ini",fileList[i]);
		SetString(Teleports[i][tlName],fileList[i]);
		SetString(Teleports[i][tlCommand],fgetstring(fname,"Command"));
		LoadPosFromString(p,fgetstring(fname,"Pos"));
		Teleports[i][tlPos] = p;
		if(fkeyexist(fname,"VPos"))
		{
			LoadPosFromString(p,fgetstring(fname,"VPos"));
			Teleports[i][tlVPos] = p, Teleports[i][tlWithVehicle] = true;
		}
		else Teleports[i][tlWithVehicle] = false;
		Teleports[i][tlInterior] = fgetint(fname,"Interior");
		for(new j = 1; j < MAX_WORLDS; j++) Teleports[i][tlWorld][j] = fkeyexist(fname,frmt("World%d",j)) ? (bool:fgetint(fname,fstring)) : false;
		Teleports[i][tlLevel] = fgetint(fname,"Level");
		Teleports[i][tlVIP] = fgetint(fname,"VIP") == 1;
		Teleports[i][tlFreezeTime] = fgetint(fname,"FreezeTime");
		Teleports[i][tlCreator] = fgetint(fname,"Creator");
		Teleports[i][tlActive] = fgetint(fname,"Active") == 1;
		Teleports[i][tlArea][0] = CreateArea(p[0]-TELE_AREA_SIZE,p[1]-TELE_AREA_SIZE,p[0]+TELE_AREA_SIZE,p[1]+TELE_AREA_SIZE,area_tele,i,Teleports[i][tlInterior],-1);
		Teleports[i][tlArea][1] = 0;
	}
}
stock LoadPosFromString(Float:var[4],string[],sep = ',')
{
	new val[64], idx = 0;
	for(new i = 0; i < 4; i++) val = strtok(string,idx,sep), var[i] = floatstr(val);
}
stock LoadStringFromPos(Float:var[4],sep = ',')
{
	new val[64];
	format(val,sizeof(val),"%.4f%c%.4f%c%.4f%c%.4f",var[0],sep,var[1],sep,var[2],sep,var[3]);
	return val;
}
forward Float:floatrand(Float:min, Float:max);
stock Float:floatrand(Float:min, Float:max)
{
	new imin = floatround(min);
	return float(random((floatround(max) - imin) * 100) + (imin * 100)) / 100.0;
}
stock CreateChat(name[],pass[]="",bool:protected=false)
{
	new cid = -1;
	for(new i = 0; i < MAX_CHATS && cid == -1; i++) if(!ChatInfo[i][chValid]) cid = i;
	if(cid == -1) return cid;
	ChatInfo[cid][chValid] = true;
	ChatInfo[cid][chProtected] = protected;
	ChatInfo[cid][chOnline] = 0;
	SetString(ChatInfo[cid][chName],name);
	SetString(ChatInfo[cid][chPassword],pass);
	return cid;
}
stock JoinChat(playerid,chatid,bool:ignoremsg=false)
{
	new old = PlayerInfo[playerid][pChat], onlineText[64];
	if(old != -1) if(ChatInfo[old][chValid])
	{
		ChatInfo[old][chOnline]--;
		if(!ChatInfo[old][chProtected])
		{
			ChatCheck4Close(old);
			if(!ignoremsg)
			{
				frmt(" [[%s עזב את הצ'אט, עבר לחדר %s]]",ChatInfo[chatid][chName],GetName(playerid));
				Loop(i) if(PlayerInfo[i][pChat] == old && i != playerid) SendClientMessage(i,green,fstring);
			}
		}
	}
	switch(ChatInfo[chatid][chOnline])
	{
		case 0: onlineText = "אין בצ'אט מחוברים נוספים מלבדך";
		case 1: onlineText = "יש בצ'אט עוד מחובר אחד מלבדך";
		default: format(onlineText,sizeof(onlineText),"לצ'אט מחוברים עוד %d משתמשים",ChatInfo[chatid][chOnline]);
	}
	ChatInfo[chatid][chOnline]++;
	if(old != -1)
	{
		SendFormat(playerid,grey," [[בו תוכל לקרוא ולכתוב. %s %s התחברת לצ'אט]]",onlineText,ChatInfo[chatid][chName]);
		if(!ignoremsg && chatid != mainChatID && GetTickCount()-PlayerInfo[playerid][pChatJoinMessage][chatid] > 10000)
		{
			frmt(" [[%s הצטרף לצ'אט %s]]",ChatInfo[chatid][chName],GetName(playerid));
			Loop(i) if(PlayerInfo[i][pChat] == chatid) SendClientMessage(i,grey,fstring);
			PlayerInfo[playerid][pChatJoinMessage][chatid] = GetTickCount();
		}
	}
	PlayerInfo[playerid][pChat] = chatid, PlayerInfo[playerid][pChatAdmin] = false;
}
stock KickFromChat(playerid) JoinChat(playerid,PlayerInfo[playerid][pConnectStage] == ct_playing ? PlayerInfo[playerid][pWorld] : mainChatID,true);
stock ChatCheck4Close(chatid)
{
	if(ChatInfo[chatid][chProtected]) return;
	if(!ChatInfo[chatid][chOnline]) ChatInfo[chatid][chValid] = false, ChatInfo[chatid][chName] = EOS, ChatInfo[chatid][chPassword] = EOS;
}
stock CreateVehicleEx(modelid,Float:x,Float:y,Float:z,Float:a,color1,color2,respawn_delay=respawntime,world=0,interior=0)
{
	new v = INVALID_VEHICLE_ID;
	if(modelid == 449 || modelid == 537 || modelid == 538) v = AddStaticVehicleEx(modelid,x,y,z,a,color1,color2,respawn_delay);
	else v = CreateVehicle(modelid,x,y,z,a,color1,color2,respawn_delay);
	LinkVehicleToInterior(v,interior);
	SetVehicleVirtualWorld(v,worlds_gameplay + world);
	VehicleInfo[v][vValid] = true;
	//VehicleInfo[v][vPlayersIn] = 0;
	VehicleInfo[v][vACreatedBy] = INVALID_PLAYER_ID;
	VehicleInfo[v][vCreatedBy] = INVALID_PLAYER_ID;
	VehicleInfo[v][vLocked] = false;
	VehicleInfo[v][vSpawnPos][0] = x;
	VehicleInfo[v][vSpawnPos][1] = y;
	VehicleInfo[v][vSpawnPos][2] = z;
	VehicleInfo[v][vSpawnPos][3] = a;
	VehicleInfo[v][vNumberPlate][0] = EOS;
	VehicleInfo[v][vColors][0] = color1;
	VehicleInfo[v][vColors][1] = color2;
	VehicleInfo[v][vPaintjob] = -1;
	VehicleInfo[v][vInterior] = interior;
	VehicleInfo[v][vWorld] = world;
	return v;
}
stock DestroyVehicleEx(v)
{
	DestroyVehicle(v);
	VehicleInfo[v][vValid] = false;
	//VehicleInfo[v][vPlayersIn] = 0;
	VehicleInfo[v][vACreatedBy] = INVALID_PLAYER_ID;
	VehicleInfo[v][vCreatedBy] = INVALID_PLAYER_ID;
	VehicleInfo[v][vLocked] = false;
	return v;
}
stock GetVehicleModelIDFromName(vname[])
{
	for(new i=0;i<sizeof(VehicleNames);i++) if(strfind(VehicleNames[i],vname,true) != -1) return i+400;
	return -1;
}
stock GetWeaponIDFromName(wname[])
{
	for(new i = 0; i < sizeof(WeaponNames); i++) if(strfind(WeaponNames[i],wname,true) != -1) return i;
	return -1;
}
stock GetXYInFrontOfPlayer(playerid,&Float:x,&Float:y,Float:distance)
{   // by Y_Less, improved by me
	new Float:a;
	GetPlayerPos(playerid,x,y,a);
	GetPlayerFacingAngle(playerid,a);
	if(GetPlayerVehicleID(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid),a);
	x += (distance * floatsin(-a,degrees)), y += (distance * floatcos(-a,degrees));
	return 1;
}
stock GetXYInFrontOfVehicle(vehicleid,&Float:x,&Float:y,Float:distance)
{
	new Float:a;
	GetVehiclePos(vehicleid,x,y,a);
	GetVehicleZAngle(vehicleid,a);
	x += (distance * floatsin(-a,degrees)), y += (distance * floatcos(-a,degrees));
	return 1;
}
stock GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angle, Float:distance) x += (distance * floatsin(-angle, degrees)), y += (distance * floatcos(-angle, degrees)); // by niCe, improved by me
stock WorldDefineName(worldid)
{
	new n[32];
	switch(worldid)
	{
		case world_class: n = "world_class";
		case world_stunts: n = "world_stunts";
		case world_stuntswo: n = "world_stuntswo";
		case world_dm: n = "world_dm";
		case world_tdm: n = "world_tdm";
	}
	return n;
}
stock RespawnAllVehicles(playerid)
{
	new invalids = 0;
	for(new v = 0; v < MAX_VEHICLES; v++) if(VehicleInfo[v][vValid] && !vehicleinfo[v][playersin])
	{
		SetVehicleToRespawn(v);
		LinkVehicleToInterior(v,vehicleinfo[v][veint]);
		SetVehicleVirtualWorld(v,vehicleinfo[v][veworld]);
		if(invalids > 0) invalids = 0;
	}
	else if(++invalids >= 50) break;
	new string[M_S];
	if(playerid == INVALID_PLAYER_ID) SendClientMessageToAll(green," *** הופעל ריסט אוטומטי לכל הרכבים");
	else SendFormatToAll(green,," *** %s הופעל ריסט לכל הרכבים ע\"י",GetName(playerid));
	return 1;
}
stock setRed(hexColor,red2)
{
	if(red2 > 0xFF) red2 = 0xFF;
	else if(red2 < 0x00) red2 = 0x00;
	return (hexColor & 0x00FFFFFF) | (red2 << 24);
}
stock setGreen(hexColor,green2)
{
	if(green2 > 0xFF) green2 = 0xFF;
	else if(green2 < 0x00) green2	= 0x00;
	return (hexColor & 0xFF00FFFF) | (green2 << 16);
}
stock setBlue(hexColor,blue2)
{
	if(blue2 > 0xFF) blue2 = 0xFF;
	else if(blue2 < 0x00) blue2 = 0x00;
	return (hexColor & 0xFFFF00FF) | (blue2 << 8);
}
stock setAlpha(hexColor,alpha)
{
	if(alpha > 0xFF) alpha = 0xFF;
	else if(alpha < 0x00) alpha = 0x00;
	return (hexColor & 0xFFFFFF00) | alpha;
}
stock stripRed(hexColor) return (hexColor) & 0x00FFFFFF;
stock stripGreen(hexColor) return (hexColor) & 0xFF00FFFF;
stock stripBlue(hexColor) return (hexColor) & 0xFFFF00FF;
stock stripAlpha(hexColor) return (hexColor) & 0xFFFFFF00;
stock fillRed(hexColor) return (hexColor) | 0xFF000000;
stock fillGreen(hexColor) return (hexColor) | 0x00FF0000;
stock fillBlue(hexColor) return (hexColor) | 0x0000FF00;
stock fillAlpha(hexColor) return (hexColor) | 0x000000FF;
stock getRed(hexColor) return (hexColor >> 24) & 0x000000FF;
stock getGreen(hexColor) return (hexColor >> 16) & 0x000000FF;
stock getBlue(hexColor) return (hexColor >> 8) & 0x000000FF;
stock getAlpha(hexColor) return (hexColor) & 0x000000FF;
stock rgba2hex(r,g,b,a) return (r*16777216) + (g*65536) + (b*256) + a;
stock IsValidSkin(skinid) return _:(!(skinid < 0 || skinid > 299 || skinid == 74));
stock GetAdminLevel(uid) return fkeyexist(file_admins,frmt("%d",uid)) ? fgetint(file_admins,fstring) : 0;
stock MapLoad(mapid)
{
	new f[64], File:fh, string[128];
	format(f,sizeof(f),dir_maps "%d.map",mapid+1);
	assert fexist(f);
	fh = fopen(f,io_read);
	if(fh)
	{
		while(fread(fh,string))
		{
			if(strlen(string) < 5) continue;
			StripNewLine(string);
			if(strfind(string,"=") == -1)
			{
				split(string,params,',');
				MapInfo[mapid][mObject][MapInfo[mapid][mObjects]++] = CreateDynamicObject(strval(params[0]),floatstr(params[1]),floatstr(params[2]),floatstr(params[3]),floatstr(params[4]),floatstr(params[5]),floatstr(params[6]),MapInfo[mapid][mWorld] == world_class ? vworld_requestclass : (worlds_gameplay + MapInfo[mapid][mWorld]),0,-1,5000.0);
				fwrite(fop,frmt("CreateDynamicObject(%d,%f,%f,%f,%f,%f,%f);\n",strval(params[0]),floatstr(params[1]),floatstr(params[2]),floatstr(params[3]),floatstr(params[4]),floatstr(params[5]),floatstr(params[6])));
			}
			else
			{
				format(f,sizeof(f),getkey(string));
				if(equal(f,"Name")) format(MapInfo[mapid][mName],32,getvalue(string));
				else if(equal(f,"Author")) format(MapInfo[mapid][mAuthor],32,getvalue(string));
				else if(equal(f,"World")) MapInfo[mapid][mWorld] = strval(getvalue(string));
				else continue;
			}
		}
		fclose(fh);
	}
	MapInfo[mapid][mLoaded] = true;
	printf("Loaded map #%d with %d objects.",mapid,MapInfo[mapid][mObjects]);
}
stock MapUnload(mapid)
{
	for(new i = 0, m = min(MAX_OBJECTS,MAX_MAP_OBJECTS); i < MapInfo[mapid][mObjects] && i < m; i++) if(IsValidObject(MapInfo[mapid][mObject][i]))
	{
		DestroyObject(MapInfo[mapid][mObject][i]);
		MapInfo[mapid][mObject][i] = 0;
	}
	MapInfo[mapid][mName] = EOS, MapInfo[mapid][mAuthor] = EOS, MapInfo[mapid][mWorld] = -1, MapInfo[mapid][mObjects] = 0, MapInfo[mapid][mLoaded] = false;
}
stock MapCount()
{
	new c = 0;
	for(new i = 0; i < MAX_MAPS; i++) if(MapInfo[i][mLoaded]) c++;
	return c;
}
stock MapExist(mapid) return fexist(frmt(dir_maps "%d.map",mapid));
stock split(const strsrc[],strdest[][],delimiter)
{
	new i, li, aNum, len, len2 = strlen(strsrc);
	while(i <= len2)
	{
		if(strsrc[i] == delimiter || i == len2)
		{
			len = strmid(strdest[aNum],strsrc,li,i,128);
			strdest[aNum][len] = 0;
			li = i + 1;
			aNum++;
		}
		i++;
	}
	return 1;
}
stock GiveExp(playerid,type,amount=1)
{
	if(!PlayerInfo[playerid][pLogged]) return 1;
	frmt("~n~~n~~n~~n~~n~~w~%s] ~w~+%d exp %s%s%s",sUptime % 2 ? ("~y~") : ("~y~~h~"),Exp[type][ePoints] * amount,Exp[type][eColor],Exp[type][eName],Exp[type][ePoints] * amount >= 50 ? ("~y~ ]~w~") : (""));
	ExpGameText(playerid,fstring);
	PlayerInfo[playerid][pExp] += Exp[type][ePoints] * amount;
	if(GetTickCount()-PlayerInfo[playerid][pExpUpdate] > 5000)
	{
		fsetint(uf(playerid),"Exp",PlayerInfo[playerid][pExp]);
		PlayerInfo[playerid][pExpUpdate] = GetTickCount();
	}
	if(PlayerInfo[playerid][pLevel] >= 1 && PlayerInfo[playerid][pLevel] < sizeof(Levels)-1) if(Levels[PlayerInfo[playerid][pLevel]+1][lvlExp]-PlayerInfo[playerid][pExp] <= 0)
	{
		PlayerInfo[playerid][pLevel]++;
		SetPlayerScore(playerid,PlayerInfo[playerid][pLevel]);
		fsetint(uf(playerid),"Level",PlayerInfo[playerid][pLevel]);
		Loop(i) SendFormat(i,orange," • !מאחל לך בהצלחה Heavy Stunts שעלה לרמה %d! צוות שרת %s-מזל טוב ל",PlayerInfo[playerid][pLevel],GetName(playerid));
		if(Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit] != 0) SendFormat(playerid,orange," מגבלת בנק חדשה: " @c(yellow) "$%d",Levels[PlayerInfo[playerid][pLevel]][lvlBankLimit]);
		new string[M_S];
		for(new i = 0; i < sizeof(Ammunation); i++) if(Ammunation[i][aLevel] == PlayerInfo[playerid][pLevel]) format(string,sizeof(string),!strlen(string) ? ("%s%s") : ("%s • %s"),string,Ammunation[i][aName]);
		if(strlen(string) > 0) SendFormat(playerid,yellow," %s" @c(orange) " :נשקים חדשים שנפתחו",string);
		string = "";
		for(new i = 0; i < sizeof(Teleports); i++) if(Teleports[i][tlLevel] == PlayerInfo[playerid][pLevel]) format(string,sizeof(string),!strlen(string) ? ("%s%s") : ("%s • %s"),string,Teleports[i][tlCommand]);
		if(strlen(string) > 0) SendFormat(playerid,yellow," %s" @c(orange) " :שיגורים חדשים לרמה שלך",string);
		string = "";
		for(new i = 0; i < sizeof(LCMDs); i++) if(LCMDs[i][lcLevel] == PlayerInfo[playerid][pLevel]) format(string,sizeof(string),!strlen(string) ? ("%s(%s) %s") : ("%s • (%s) %s"),string,LCMDs[i][lcText],LCMDs[i][lcName]);
		if(strlen(string) > 0) SendFormat(playerid,yellow," %s" @c(orange) " :פקודות חדשות לרמה שלך",string);
		string = "";
		for(new i = 0; i < sizeof(Channels); i++) if(Channels[i][chLevel] == PlayerInfo[playerid][pLevel]) format(string,sizeof(string),!strlen(string) ? ("%s%s") : ("%s • %s"),string,Channels[i][chName]);
		if(strlen(string) > 0) SendFormat(playerid,orange," צ'אנלים חדשים שנפתחו: " @c(yellow) "%s",string);
		string = "";
	}
	return 1;
}
stock ExpGameText(playerid,string[]) Loop(i) if((i == playerid || PlayerInfo[i][pSpectate] == playerid) && PlayerInfo[i][pSetting][setting_exp]) GameTextForPlayer(i,string,2500,5);
stock GoToDMZone(playerid,dmzone)
{
	SetPlayerHealth(playerid,DMZones[dmzone][dmStatus][0]);
	SetPlayerArmour(playerid,DMZones[dmzone][dmStatus][1]);
	SetPlayerInterior(playerid,DMZones[dmzone][dmInterior]);
	ResetWeapons(playerid);
	switch(DMZones[dmzone][dmType])
	{
		case 1:
		{
			new Float:HeavySpawnPositions[][4] =
			{
				{-1081.6062,1046.2057,1343.5325,222.5462},
				{-1037.1414,1063.9246,1344.3984,77.1815},
				{-1008.3450,1078.9255,1343.2269,83.4482},
				{-978.9857,1053.2493,1344.9834,80.6283},
				{-1058.4739,1061.0720,1343.9114,291.5036},
				{-1127.6195,1066.2969,1345.7368,268.1484},
				{-975.0240,1055.9875,1345.0078,79.3358},
				{-974.3430,1070.9658,1344.9949,80.4716},
				{-991.4177,1083.7632,1342.6733,127.1979},
				{-994.4700,1064.0679,1342.8243,56.2115},
				{-1001.9753,1042.8842,1342.2197,314.7531},
				{-995.7480,1028.7510,1341.8438,87.8585},
				{-1018.7202,1024.3384,1344.0984,45.0097},
				{-1030.8396,1044.2985,1341.7856,259.6609},
				{-1029.5619,1055.0835,1343.0619,344.7317},
				{-1033.2004,1069.0222,1344.2559,237.6099},
				{-1028.9589,1087.2690,1343.2711,54.0965},
				{-1044.2458,1086.8855,1346.0165,184.8752},
				{-1042.8431,1072.4019,1347.4537,267.6743},
				{-1042.8165,1060.8737,1345.9280,148.2932},
				{-1044.1879,1035.4626,1342.8119,143.4757},
				{-1060.7253,1035.0229,1345.6879,25.1912},
				{-1061.5637,1060.5579,1346.9504,331.1015},
				{-1059.1779,1081.7328,1342.5955,92.2843},
				{-1066.5837,1097.2791,1343.0957,236.0274},
				{-1082.7657,1094.9008,1343.6514,218.0889},
				{-1080.2703,1072.2965,1341.7731,259.7000},
				{-1081.4653,1056.7813,1343.1924,52.5064},
				{-1083.0643,1039.8846,1344.0302,218.7705},
				{-1089.2383,1028.3816,1342.9182,27.1262},
				{-1093.4750,1042.9446,1343.5194,222.9771},
				{-1088.8274,1046.3198,1347.4005,118.5187},
				{-1112.2683,1031.3719,1342.9479,313.5471},
				{-1117.5491,1050.1567,1343.0214,231.4138},
				{-1116.5314,1066.7682,1342.9103,40.2629},
				{-1117.8730,1081.2332,1341.9568,299.6428},
				{-1117.9584,1098.8282,1341.8438,90.7316},
				{-1132.7811,1028.1888,1349.1802,285.6602},
				{-1135.9630,1021.4603,1345.7479,300.1520},
				{-1133.3214,1043.8525,1345.7509,235.3305},
				{-1132.6558,1062.4264,1345.7653,245.2398}
			};
			new rnd = random(sizeof(HeavySpawnPositions));
			SetPlayerPos(playerid,HeavySpawnPositions[rnd][0],HeavySpawnPositions[rnd][1],HeavySpawnPositions[rnd][2]);
			SetPlayerFacingAngle(playerid,HeavySpawnPositions[rnd][3]);
			GiveWeapon(playerid,24,10000);
			GiveWeapon(playerid,!random(2) ? 27 : 25,10000);
			GiveWeapon(playerid,!random(2) ? 30 : 31,10000);
			GiveWeapon(playerid,!random(2) ? 33 : 34,10000);
		}
		case 2:
		{
			new Float:LightSpawnPositions[][4] =
			{
				{1362.2793,789.6408,10.8203,197.4170},
				{1371.6772,792.8549,10.8203,196.7904},
				{1383.3438,794.3125,10.8280,164.5167},
				{1391.2445,786.3582,10.8203,166.0835},
				{1386.4156,768.2435,10.8203,94.6428},
				{1364.5677,769.2725,10.8203,281.0779},
				{1362.7996,751.0942,10.8203,277.0045},
				{1390.5483,747.8094,10.8203,99.8970},
				{1390.1647,731.0406,10.8203,91.1236},
				{1364.7747,721.2797,10.8280,273.5579},
				{1392.4006,696.6141,10.8203,89.3162},
				{1362.0995,687.7517,10.8203,253.5044},
				{1393.8738,671.5933,10.8280,83.3627},
				{1361.3722,666.6530,10.8280,331.8150},
				{1368.9110,667.1098,10.8280,11.9946},
				{1382.3473,666.9106,10.8280,358.5212}
			};
			new rnd = random(sizeof(LightSpawnPositions));
			SetPlayerPos(playerid,LightSpawnPositions[rnd][0],LightSpawnPositions[rnd][1],LightSpawnPositions[rnd][2]);
			SetPlayerFacingAngle(playerid,LightSpawnPositions[rnd][3]);
			GiveWeapon(playerid,4,0);
			GiveWeapon(playerid,22,10000);
			GiveWeapon(playerid,!random(2) ? 28 : 32,10000);
			GiveWeapon(playerid,26,10000);
		}
	}
	SetPlayerArmedWeapon(playerid,0);
}
stock GetEmptyGroupID()
{
	new cid = -1, max_ = fgetint(file_groups,"#Count"), string[16], cName[32];
	for(new i = 1; i <= max_ && cid == -1; i++)
	{
		valstr(string,i);
		format(cName,sizeof(cName),fgetstring(file_groups,string));
		if(equal(cName,"None")) cid = i;
	}
	if(cid == -1 && max_ < MAX_GROUPS) cid = !max_ ? 1 : (max_+1);
	return cid;
}
stock gid(gn[],type)
{
	new string[64];
	format(string,sizeof(string),dir_groups "%s-%s.ini",GroupTypes[type],gn);
	return fexist(string) ? fgetint(string,"ID") : 0;
}
stock groupAdd(gid,playerid)
{
	GroupInfo[gid][gMember][GroupInfo[gid][gMembers]++] = playerid;
	PlayerInfo[playerid][pGroup][GroupInfo[gid][gType]] = gid;
	PlayerInfo[playerid][pGroupInvite][GroupInfo[gid][gType]] = 0;
	PlayerInfo[playerid][pGroupLevel][GroupInfo[gid][gType]] = 1;
	if(PlayerInfo[playerid][pLogged]) fsetint(uf(playerid),GroupTypes[GroupInfo[gid][gType]],gid);
}
stock groupDel(gid,playerid,bool=true)
{
	PlayerInfo[playerid][pGroup][GroupInfo[gid][gType]] = 0;
	PlayerInfo[playerid][pGroupLevel][GroupInfo[gid][gType]] = 0;
	if(PlayerInfo[playerid][pLogged]) fsetint(uf(playerid),GroupTypes[GroupInfo[gid][gType]],0);
	if(bool)
	{
		new pos = -1;
		for(new i = 0; i < GroupInfo[gid][gMembers] && pos == -1; i++) if(GroupInfo[gid][gMember][i] == playerid) pos = i;
		if(pos != -1)
		{
			for(new i = pos; i < GroupInfo[gid][gMembers] - 1; i++) GroupInfo[gid][gMember][i] = GroupInfo[gid][gMember][i+1];
			GroupInfo[gid][gMember][GroupInfo[gid][gMembers]--] = INVALID_PLAYER_ID;
		}
	}
}
stock groupLoad(playerid)
{
	if(!PlayerInfo[playerid][pLogged]) return;
	new gtype = 0;
	switch(PlayerInfo[playerid][pWorld])
	{
		case world_dm, world_tdm: gtype = group_clan;
		case world_stunts, world_stuntswo: gtype = group_crew;
	}
	if(gtype > 0)
	{
		new g = PlayerInfo[playerid][pGroup][gtype];
		if(!g)
		{
			SetPlayerColor2(playerid,rgba2hex(PlayerInfo[playerid][pRGB][0],PlayerInfo[playerid][pRGB][1],PlayerInfo[playerid][pRGB][2],PLAYER_ALPHA));
		}
		else
		{
			SetPlayerColor2(playerid,rgba2hex(GroupInfo[g][gColor][0],GroupInfo[g][gColor][1],GroupInfo[g][gColor][2],PLAYER_ALPHA));
		}
	}
}
stock IsValidName(name[])
{
	for(new i = 0, m = strlen(name); i < m; i++) if(name[i] < '0' && name[i] > '9' && name[i] < 'a' && name[i] > 'z' && name[i] < 'A' && name[i] > 'Z' && name[i] != '_' && name[i] != '[' && name[i] != ']') return 0;
	return 1;
}
stock HasGroupPermission(playerid,lvl,gtype)
{
	if(PlayerInfo[playerid][pGroupLevel][gtype] < lvl)
	{
		SendFormat(playerid,red," .עליך להיות לפחות ברמת גישות %d",lvl);
		return 0;
	}
	return 1;
}
stock hqLoad(clanid)
{
	new f[32], i = 1, string[128], worlds[] = {worlds_gameplay + world_dm,worlds_gameplay + world_tdm}, total = 0;
	format(f,sizeof(f),dir_groups "%s-%s.ini",GroupTypes[group_clan],GroupInfo[clanid][gName]);
	while(fkeyexist(f,frmt("Object%d",i)))
	{
		format(string,sizeof(string),fgetstring(f,fstring));
		split(string,params,',');
		HeadquarterInfo[clanid][hqObject][HeadquarterInfo[clanid][hqObjects]] = CreateDynamicObjectEx(strval(params[0]),floatstr(params[1]),floatstr(params[2]),floatstr(params[3]),floatstr(params[4]),floatstr(params[5]),floatstr(params[6]),200.0,200.0,worlds);
		if(strlen(params[7]) > 0)
		{
			MoveObjectInfo[moveObjectsCount][moHQ] = clanid;
			MoveObjectInfo[moveObjectsCount][moObjectID] = HeadquarterInfo[clanid][hqObject][HeadquarterInfo[clanid][hqObjects]];
			for(new j = 0; j < 3; j++) MoveObjectInfo[moveObjectsCount][moPos][j] = floatstr(params[j+1]), MoveObjectInfo[moveObjectsCount][moMPos][j] = floatstr(params[j+7]);
			MoveObjectInfo[moveObjectsCount][moStatus] = false;
			moveObjectsCount++;
		}
		HeadquarterInfo[clanid][hqObjects]++;
		i++, total++;
	}
	while(fkeyexist(f,frmt("Vehicle%d",i)))
	{
		format(string,sizeof(string),fgetstring(f,fstring));
		split(string,params,',');
		HeadquarterInfo[clanid][hqVehicle][HeadquarterInfo[clanid][hqVehicles]++] = CreateVehicleEx(strval(params[0]),floatstr(params[1]),floatstr(params[2]),floatstr(params[3]),floatstr(params[4]),strval(params[5]),strval(params[6]),respawntime,worlds_gameplay + world_dm);
		i++, total++;
	}
	while(fkeyexist(f,frmt("Pickup%d",i)))
	{
		format(string,sizeof(string),fgetstring(f,fstring));
		split(string,params,',');
		HeadquarterInfo[clanid][hqPickup][HeadquarterInfo[clanid][hqPickups]++] = CreatePickup(strval(params[0]),2,floatstr(params[1]),floatstr(params[2]),floatstr(params[3]),worlds_gameplay + world_dm);
		i++, total++;
	}
	new Float:p[4];
	LoadPosFromString(p,fgetstring(f,"HQPos"));
	HeadquarterInfo[clanid][hqPos] = p;
	LoadPosFromString(p,fgetstring(f,"HQVPos"));
	HeadquarterInfo[clanid][hqVPos] = p;
	format(HeadquarterInfo[clanid][hqCommand],16,fgetstring(f,"HQCMD"));
	return total;
}
stock hqUnload(clanid)
{
	HeadquarterInfo[clanid][hqClan] = 0;
	HeadquarterInfo[clanid][hqCommand] = EOS;
	for(new i = 0; i < HeadquarterInfo[clanid][hqObjects]; i++)
	{
		DestroyDynamicObject(HeadquarterInfo[clanid][hqObject][i]);
		HeadquarterInfo[clanid][hqObject][i] = 0;
	}
	for(new i = 0; i < HeadquarterInfo[clanid][hqVehicles]; i++)
	{
		DestroyVehicleEx(HeadquarterInfo[clanid][hqVehicle][i]);
		HeadquarterInfo[clanid][hqVehicle][i] = 0;
	}
	for(new i = 0; i < HeadquarterInfo[clanid][hqPickups]; i++)
	{
		DestroyPickup(HeadquarterInfo[clanid][hqPickup][i]);
		HeadquarterInfo[clanid][hqPickup][i] = 0;
	}
	HeadquarterInfo[clanid][hqObjects] = 0;
	HeadquarterInfo[clanid][hqVehicles] = 0;
	HeadquarterInfo[clanid][hqPickups] = 0;
}
stock hqGoto(playerid,clanid)
{
	new Float:p[4], v = GetPlayerVehicleID(playerid), bool:avg = false;
	if(HeadquarterInfo[clanid][hqPos][0] == 0.0)
	{
		new Float:o[3];
		for(new i = 0; i < HeadquarterInfo[clanid][hqObjects]; i++) if(IsValidDynamicObject(HeadquarterInfo[clanid][hqObject][i]))
		{
			GetDynamicObjectPos(i,o[0],o[1],o[2]);
			for(new j = 0; j < 3; j++) p[j] += o[j];
		}
		for(new j = 0; j < 3; j++) p[j] /= HeadquarterInfo[clanid][hqObjects];
		avg = true;
	}
	else p = v > 0 ? HeadquarterInfo[clanid][hqVPos] : HeadquarterInfo[clanid][hqPos];
	if(v > 0)
	{
		SetVehiclePos(v,p[0],p[1],p[2]);
		SetVehicleZAngle(v,p[3]);
	}
	else
	{
		if(avg) SetPlayerPosFindZ(playerid,p[0],p[1],p[2]);
		else SetPlayerPos(playerid,p[0],p[1],p[2]);
		SetPlayerFacingAngle(playerid,p[3]);
	}
	SetPlayerInterior(playerid,0);
	SetCameraBehindPlayer(playerid);
	GameTextForPlayer(playerid,frmt("~y~] ~h~%s ~y~]",GroupInfo[clanid][gName]),1500,4);
	PlaySound(playerid,1132);
}
stock FindAnyCloseMoveObject(playerid,clanid)
{
	for(new i = 0; i < moveObjectsCount; i++) if(MoveObjectInfo[i][moHQ] == clanid && IsPlayerInRangeOfPoint(playerid,10.0,MoveObjectInfo[i][moPos][0],MoveObjectInfo[i][moPos][1],MoveObjectInfo[i][moPos][2])) return i;
	return -1;
}
stock CanTeleport(playerid,bool:msg = true)
{
	if(PlayerInfo[playerid][pAFK]) return (msg ? SendClientMessage(playerid,red," .AFK לא ניתן להשתגר כאשר אתה במצב") : 0), 0;
	if(PlayerInfo[playerid][pConnectStage] != ct_playing) return (msg ? SendClientMessage(playerid,red," .עליך להתחיל לשחק כדי להשתגר") : 0), 0;
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return (msg ? SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו כאשר אתה במעקב") : 0), 0;
	if(!CanUseCommand(playerid,msg)) return 0;
	return 1;
}
stock SwitchWorld(playerid)
{
	WorldPlayer(PlayerInfo[playerid][pWorld],false);
	WorldPlayer(PlayerInfo[playerid][pWorld] = world_class,true);
	PlayerInfo[playerid][pConnectStage] = ct_selectworld;
	ForceClassSelection(playerid);
	SetPlayerHealth(playerid,0.0);
	if(PlayerInfo[playerid][pCreatedVehicles] > 0) for(new i = 0; i < MAX_PLAYER_VEHICLES; i++)
	{
		if(PlayerInfo[playerid][pCreatedVehicle][i] != INVALID_VEHICLE_ID) DestroyVehicleEx(PlayerInfo[playerid][pCreatedVehicle][i]);
		PlayerInfo[playerid][pCreatedVehicle][i] = INVALID_VEHICLE_ID;
	}
}
forward Float:GetPlayerTheoreticAngle(i);
stock Float:GetPlayerTheoreticAngle(i)
{	// by Luby
	new Float:sin, Float:dis, Float:angle2, Float:p[3], Float:tmp3, Float:tmp4, Float:MindAngle;
	GetPlayerPos(i,p[0],p[1],p[2]);
	dis = floatsqroot(floatpower(floatabs(floatsub(p[0],PlayerInfo[i][pDPos][0])),2)+floatpower(floatabs(floatsub(p[1],PlayerInfo[i][pDPos][1])),2));
	angle2 = ReturnPlayerAngle(i);
	tmp3 = p[0] > PlayerInfo[i][pDPos][0] ? (p[0]-PlayerInfo[i][pDPos][0]) : (PlayerInfo[i][pDPos][0]-p[0]), tmp4 = p[0] > PlayerInfo[i][pDPos][1] ? (p[1]-PlayerInfo[i][pDPos][1]) : (PlayerInfo[i][pDPos][1]-p[1]);
	if(PlayerInfo[i][pDPos][1] > p[1] && PlayerInfo[i][pDPos][0] > p[0]) sin = asin(tmp3/dis), MindAngle = floatsub(floatsub(floatadd(sin, 90),floatmul(sin,2)),-90.0);
	if(PlayerInfo[i][pDPos][1] < p[1] && PlayerInfo[i][pDPos][0] > p[0]) sin = asin(tmp3/dis), MindAngle = floatsub(floatadd(sin,180),180.0);
	if(PlayerInfo[i][pDPos][1] < p[1] && PlayerInfo[i][pDPos][0] < p[0]) sin = acos(tmp4/dis), MindAngle = floatsub(floatadd(sin,360), floatmul(sin,2));
	if(PlayerInfo[i][pDPos][1] > p[1] && PlayerInfo[i][pDPos][0] < p[0]) sin = asin(tmp3/dis), MindAngle = floatadd(sin, 180);
	return MindAngle == 0.0 ? angle2 : MindAngle;
}
forward Float:ReturnPlayerAngle(playerid);
stock Float:ReturnPlayerAngle(playerid)
{
	new Float:a;
	if(IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid),a);
	else GetPlayerFacingAngle(playerid,a);
	return a;
}
stock LoadTextDraws()
{
	// Drifts
	driftlabels[0] = TextDrawCreate(500,100,"Drift Points");
	TextDrawColor(driftlabels[0],0xFFFFFFFF);
	TextDrawSetShadow(driftlabels[0],0);
	TextDrawSetOutline(driftlabels[0],1);
	TextDrawLetterSize(driftlabels[0],0.5,2);
	TextDrawBackgroundColor(driftlabels[0],0x00000040);
	TextDrawFont(driftlabels[0],1);
	driftlabels[1] = TextDrawCreate(500,100+50,"EXP Earned");
	TextDrawColor(driftlabels[1],0xFFFFFFFF);
	TextDrawSetShadow(driftlabels[1],0);
	TextDrawSetOutline(driftlabels[1],1);
	TextDrawLetterSize(driftlabels[1],0.5,2);
	TextDrawBackgroundColor(driftlabels[1],0x00000040);
	TextDrawFont(driftlabels[1],1);
	// Speedometer
	speedotext[0] = TextDrawCreate(611.000000,377.000000,"_");
	TextDrawUseBox(speedotext[0],1);
	TextDrawBoxColor(speedotext[0],0x00000033);
	TextDrawTextSize(speedotext[0],529.000000,0.000000);
	TextDrawAlignment(speedotext[0],0);
	TextDrawBackgroundColor(speedotext[0],0x000000ff);
	TextDrawFont(speedotext[0],1);
	TextDrawLetterSize(speedotext[0],-3.700000,5.100007);
	TextDrawColor(speedotext[0],0xffffffff);
	TextDrawSetProportional(speedotext[0],1);
	TextDrawSetShadow(speedotext[0],1);
	speedotext[1] = TextDrawCreate(611.000000,375.000000,"_");
	TextDrawUseBox(speedotext[1],1);
	TextDrawBoxColor(speedotext[1],0x000000ff);
	TextDrawTextSize(speedotext[1],530.000000,185.000000);
	TextDrawAlignment(speedotext[1],0);
	TextDrawBackgroundColor(speedotext[1],0x000000ff);
	TextDrawFont(speedotext[1],3);
	TextDrawLetterSize(speedotext[1],2.799999,-0.200000);
	TextDrawColor(speedotext[1],0xffffffff);
	TextDrawSetOutline(speedotext[1],1);
	TextDrawSetProportional(speedotext[1],1);
	TextDrawSetShadow(speedotext[1],1);
	speedotext[2] = TextDrawCreate(532.000000,375.000000,"_");
	TextDrawUseBox(speedotext[2],1);
	TextDrawBoxColor(speedotext[2],0x000000ff);
	TextDrawTextSize(speedotext[2],530.000000,32.000000);
	TextDrawAlignment(speedotext[2],0);
	TextDrawBackgroundColor(speedotext[2],0x000000ff);
	TextDrawFont(speedotext[2],3);
	TextDrawLetterSize(speedotext[2],1.000000,5.299999);
	TextDrawColor(speedotext[2],0xffffffff);
	TextDrawSetOutline(speedotext[2],1);
	TextDrawSetProportional(speedotext[2],1);
	TextDrawSetShadow(speedotext[2],1);
	speedotext[3] = TextDrawCreate(532.000000,426.000000,"_");
	TextDrawUseBox(speedotext[3],1);
	TextDrawBoxColor(speedotext[3],0x000000ff);
	TextDrawTextSize(speedotext[3],609.000000,82.000000);
	TextDrawAlignment(speedotext[3],0);
	TextDrawBackgroundColor(speedotext[3],0x000000ff);
	TextDrawFont(speedotext[3],3);
	TextDrawLetterSize(speedotext[3],1.500000,-0.200000);
	TextDrawColor(speedotext[3],0xffffffff);
	TextDrawSetOutline(speedotext[3],1);
	TextDrawSetProportional(speedotext[3],1);
	TextDrawSetShadow(speedotext[3],1);
	speedotext[4] = TextDrawCreate(613.000000,375.000000,"_");
	TextDrawUseBox(speedotext[4],1);
	TextDrawBoxColor(speedotext[4],0x000000ff);
	TextDrawTextSize(speedotext[4],607.000000,-1.000000);
	TextDrawAlignment(speedotext[4],0);
	TextDrawBackgroundColor(speedotext[4],0x000000ff);
	TextDrawLetterSize(speedotext[4],0.199999,5.399997);
	TextDrawFont(speedotext[4],3);
	TextDrawColor(speedotext[4],0xffffffff);
	TextDrawSetOutline(speedotext[4],1);
	TextDrawSetProportional(speedotext[4],1);
	TextDrawSetShadow(speedotext[4],1);
	speedotext[5] = TextDrawCreate(538.000000,397.000000,"_");
	TextDrawUseBox(speedotext[5],1);
	TextDrawBoxColor(speedotext[5],0x00ff0033);
	TextDrawTextSize(speedotext[5],603.000000,64.000000);
	TextDrawAlignment(speedotext[5],0);
	TextDrawBackgroundColor(speedotext[5],0x000000ff);
	TextDrawFont(speedotext[5],3);
	TextDrawLetterSize(speedotext[5],1.000000,-0.000000);
	TextDrawColor(speedotext[5],0xffffffff);
	TextDrawSetOutline(speedotext[5],1);
	TextDrawSetProportional(speedotext[5],1);
	TextDrawSetShadow(speedotext[5],1);
	speedotext[6] = TextDrawCreate(607.000000,420.000000,"_");
	TextDrawUseBox(speedotext[6],1);
	TextDrawBoxColor(speedotext[6],0xff000033);
	TextDrawTextSize(speedotext[6],534.000000,0.000000);
	TextDrawAlignment(speedotext[6],0);
	TextDrawBackgroundColor(speedotext[6],0x000000ff);
	TextDrawFont(speedotext[6],3);
	TextDrawLetterSize(speedotext[6],1.000000,-0.000000);
	TextDrawColor(speedotext[6],0xffffffff);
	TextDrawSetOutline(speedotext[6],1);
	TextDrawSetProportional(speedotext[6],1);
	TextDrawSetShadow(speedotext[6],1);
	speedotext[7] = TextDrawCreate(556.000000,420.000000,"_");
	TextDrawUseBox(speedotext[7],1);
	TextDrawBoxColor(speedotext[7],0xffffffff);
	TextDrawTextSize(speedotext[7],551.000000,0.000000);
	TextDrawAlignment(speedotext[7],0);
	TextDrawBackgroundColor(speedotext[7],0x000000ff);
	TextDrawFont(speedotext[7],3);
	TextDrawLetterSize(speedotext[7],0.199999,-0.000000);
	TextDrawColor(speedotext[7],0xffffffff);
	TextDrawSetOutline(speedotext[7],1);
	TextDrawSetProportional(speedotext[7],1);
	TextDrawSetShadow(speedotext[7],1);
	return 1;
}
stock GetVType(vid)
{
	new Convertibles[4] = {480, 533, 439, 555};
	new Industrial[26] = {499, 422, 482, 498, 609, 524, 578, 455, 403, 414, 582, 443, 514, 413, 515, 440, 543, 605, 459, 531, 408, 552, 478, 456, 554};
	new LowRider[8] = {536, 575, 534, 567, 535, 566, 576, 412};
	new OffRoad[13] = {568, 424, 573, 579, 400, 500, 444, 556, 557, 470, 489, 505, 595};
	new Service[19] = {416, 433, 431, 438, 437, 523, 427, 490, 528, 407, 544, 596, 596, 597, 598, 599, 432, 601, 420};
	new Saloon[35] = {445, 504, 401, 518, 527, 542, 507, 562, 585, 419, 526, 604, 466, 492, 474, 546, 517, 410, 551, 516, 467, 600, 426, 436, 547, 405, 580, 560, 550, 549, 540, 491, 529, 421};
	new Sports[20] = {602, 429, 496, 402, 541, 415, 589, 587, 565, 494, 502, 503, 411, 559, 603, 475, 506, 451, 558, 477};
	new Wagons[5] = {418, 404, 479, 458, 561};
	new modelid = GetVehicleModel(vid), i;
	for(i = 0; i < 3; i++) if(Convertibles[i] == modelid) return 1;
	for(i = 0; i < 25; i++) if(Industrial[i] == modelid) return 1;
	for(i = 0; i < 7; i++) if(LowRider[i] == modelid) return 1;
	for(i = 0; i < 12; i++) if(OffRoad[i] == modelid) return 1;
	for(i = 0; i < 19; i++) if(Service[i] == modelid) return 1;
	for(i = 0; i < 35; i++) if(Saloon[i] == modelid) return 1;
	for(i = 0; i < 20; i++) if(Sports[i] == modelid) return 1;
	for(i = 0; i < 5; i++) if(Wagons[i] == modelid) return 1;
    return 0;
}
stock GetWeaponSlot(wid)
{
	switch(wid)
	{
		case 0, 1: return 0;
		case 2..9: return 1;
		case 22..24: return 2;
		case 25..27: return 3;
		case 28, 29, 32: return 4;
		case 30, 31: return 5;
		case 33, 34: return 6;
		case 35..38: return 7;
		case 16..19, 39: return 8;
		case 41..43: return 9;
		case 10..15: return 10;
		case 44..46: return 11;
		case 40: return 12;
		default: return -1;
	}
	return -1;
}
stock CreateProperty(name[],Float:x,Float:y,Float:z,cost,earns)
{
	format(PropertyInfo[props_count][prName],32,name);
	PropertyInfo[props_count][prPos][0] = x;
	PropertyInfo[props_count][prPos][1] = y;
	PropertyInfo[props_count][prPos][2] = z;
	PropertyInfo[props_count][prCost] = cost;
	PropertyInfo[props_count][prEarning] = earns;
	PropertyInfo[props_count][prOwner] = INVALID_PLAYER_ID;
	PropertyInfo[props_count][prPickup] = CreatePickupEx(1273,1,x,y,z,world_dm,pickup_property,props_count);
	props_count++;
}
stock CreatePickupEx(model,type,Float:x,Float:y,Float:z,world,ptype=pickup_default,param=0)
{
	new pid = CreatePickup(model,type,x,y,z,worlds_gameplay + world);
	PickupInfo[pid][pkValid] = true;
	PickupInfo[pid][pkModel] = model;
	PickupInfo[pid][pkPos][0] = x;
	PickupInfo[pid][pkPos][1] = y;
	PickupInfo[pid][pkPos][2] = z;
	PickupInfo[pid][pkWorld] = world;
	PickupInfo[pid][pkType] = ptype;
	PickupInfo[pid][pkParam] = param;
	return pid;
}
stock DestroyPickupEx(pid)
{
	DestroyPickup(pid);
	PickupInfo[pid][pkValid] = false;
	PickupInfo[pid][pkModel] = 0;
	pickupinfo[pid][pkType] = pickup_default;
	return 1;
}
stock GetPlayerProperty(playerid)
{
	for(new i = 0; i < props_count; i++) if(IsPlayerInRangeOfPoint(playerid,2.0,PropertyInfo[i][prPos][0],PropertyInfo[i][prPos][1],PropertyInfo[i][prPos][2])) return i;
	return -1;
}
stock IsPlayerInArea(playerid,Float:min_x,Float:min_y,Float:max_x,Float:max_y)
{
	new Float:p[3];
	GetPlayerPos(playerid,p[0],p[1],p[2]);
	return p[0] >= min_x && p[0] <= max_x && p[1] >= min_y && p[1] <= max_y;
}
stock StartActivity(actuid)
{
	new idx = GetActivityIndex(actuid), par = -1, parname[32];
	assert idx != -1 || WorldInfo[Activities[idx][actWorld]][wActivity][0] > 0;
	switch(actuid)
	{
		case 2: format(parname,sizeof(parname),WeaponName(par = warweaps[random(sizeof(warweaps))]));
		case 4: format(parname,sizeof(parname),!(par = random(2)) ? ("Heavy") : ("Light"));
	}
	Loop(i) if(PlayerInfo[i][pWorld] == Activities[idx][actWorld])
	{
		SendClientMessage(i,lightblue," • • • • • [ פעילות אוטומטית ] • • • • •");
		SendFormat(i,yellow," /join :תתחיל בעוד %d שניות! אתם מוזמנים להשתתף %s הפעילות",Activities[idx][actTime],Activities[idx][actName]);
		SendClientMessage(i,yellow," /actplayers :לרשימת השחקנים שהצטרפו • /leave :ליציאה מהפעילות");
		if(par > -1) SendFormat(i,orange," %s :סוג",parname);
		SendClientMessage(i,lightblue," • • • • • [ פעילות אוטומטית ] • • • • •");
		GameTextForPlayer(i,Activities[idx][actName],3000,4);
	}
	WorldInfo[Activities[idx][actWorld]][wActivity][0] = actuid, WorldInfo[Activities[idx][actWorld]][wActivity][1] = Activities[idx][actTime], WorldInfo[Activities[idx][actWorld]][wActivity][2] = 0, WorldInfo[Activities[idx][actWorld]][wActivityParam] = 0, WorldInfo[Activities[idx][actWorld]][wActivityParam] = par;
	SetTimerEx("ActivityStart",1000,0,"i",actuid);
}
stock GetActivityIndex(actuid)
{
	new idx = -1;
	for(new i = 0; i < sizeof(Activities) && idx == -1; i++) if(Activities[i][actUID] == actuid) idx = i;
	return idx;
}
stock StopActivity(actuid)
{
	new idx = GetActivityIndex(actuid);
	assert idx != -1 || !WorldInfo[Activities[idx][actWorld]][wActivity][0];
	Loop(i) if(PlayerInfo[i][pWorld] == Activities[idx][actWorld] && PlayerInfo[i][pInActivity])
	{
		if(PlayerInfo[i][pActivityVehicle] > -1 && IsValidVehicle(PlayerInfo[i][pActivityVehicle])) DestroyVehicleEx(PlayerInfo[i][pActivityVehicle]);
		if(WorldInfo[Activities[idx][actWorld]][wActivity][2]) SpawnPlayer(i);
		PlayerInfo[i][pInActivity] = false, PlayerInfo[i][pActivityParams] = {0,0};
	}
	WorldInfo[Activities[idx][actWorld]][wActivity] = {0,0,0};
}
stock SettingActivity(playerid,actuid)
{
	new idx = GetActivityIndex(actuid);
	assert idx != -1 || WorldInfo[Activities[idx][actWorld]][wActivity][0] != actuid;
	if(PlayerInfo[playerid][pChannel] != -1)
	{
		Channel(playerid,PlayerInfo[playerid][pChannel],'e');
		PlayerInfo[playerid][pChannel] = -1;
	}
	PlayerInfo[playerid][pActivityParams] = {0,0};
	ResetWeapons(playerid);
	ResetSkin(playerid);
	SetPlayerVirtualWorld(playerid,worlds_activities + actuid - 1);
	if(PlayerInfo[playerid][pInvisible]) SetInvisible(playerid,PlayerInfo[playerid][pInvisible] = false);
	if(PlayerInfo[playerid][pRaise][2] != INVALID_PLAYER_ID) PlayerInfo[PlayerInfo[playerid][pRaise][2]][pRaise][0] = INVALID_PLAYER_ID;
	if(PlayerInfo[playerid][pRaise][0] != INVALID_PLAYER_ID) PlayerInfo[PlayerInfo[playerid][pRaise][0]][pRaise][2] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][pRaise] = {INVALID_PLAYER_ID,0,INVALID_PLAYER_ID};
	new Float:WarPositions[][4] = // war
	{
		{-1430.9329,1259.6521,1039.8672,254.7156},
		{-1431.8860,1253.7933,1039.8672,260.4601},
		{-1432.5056,1247.8628,1039.8672,266.7268},
		{-1432.0901,1241.8976,1039.8672,274.0380},
		{-1430.9341,1236.6349,1039.8672,285.5270},
		{-1428.5359,1230.3431,1039.8672,293.3604},
		{-1425.1649,1225.5625,1039.8672,303.8049},
		{-1420.9004,1220.4844,1039.8741,318.4273},
		{-1415.3600,1215.9824,1039.8672,328.3496},
		{-1409.3510,1213.2399,1039.8672,339.8386},
		{-1402.9584,1211.7975,1039.8672,351.3276},
		{-1395.6345,1211.2839,1039.8672,4.3833},
		{-1389.3068,1213.2089,1039.8672,20.0502},
		{-1383.3143,1215.4729,1039.8672,25.2724},
		{-1378.1449,1218.4443,1039.8672,31.5392},
		{-1373.4987,1222.0001,1039.8672,44.0726},
		{-1369.5491,1227.6154,1039.8672,60.2617},
		{-1366.5486,1234.3701,1039.8672,73.3173},
		{-1365.5688,1241.4601,1039.8741,86.3730},
		{-1365.7275,1249.2192,1039.8672,102.5620},
		{-1367.6246,1256.1986,1039.8672,116.1399},
		{-1370.7230,1262.5270,1039.8672,123.4511},
		{-1375.2396,1268.4470,1039.8741,139.6402},
		{-1381.0576,1275.0394,1039.8672,153.2181},
		{-1387.8148,1278.0211,1039.8672,162.6182}
	};
	new Float:WarPositions_9[][4] = // minigun madness
	{
		{2544.5032,2805.8840,19.9922,257.5800},
		{2556.2554,2832.5313,19.9922,1.9000},
		{2561.9175,2848.5532,19.9922,256.6609},
		{2613.9866,2848.4475,19.9922,102.2487},
		{2611.5500,2845.7542,16.7020,87.5428},
		{2545.9243,2839.1824,10.8203,176.2378},
		{2647.6553,2805.0278,10.8203,285.1536},
		{2672.9387,2800.3374,10.8203,60.4288},
		{2672.8306,2792.1057,10.8203,121.8451},
		{2647.7834,2697.5884,19.3222,353.1684},
		{2654.5427,2720.3474,19.3222,303.5359},
		{2653.2063,2738.2432,19.3222,342.1389},
		{2641.1350,2703.2019,25.8222,191.6982},
		{2599.1304,2700.7249,25.8222,76.3487},
		{2606.1384,2721.5237,25.8222,261.2564},
		{2597.3745,2748.0884,23.8222,273.2050},
		{2595.0657,2776.6729,23.8222,254.3630},
		{2601.3640,2777.8101,23.8222,253.4439},
		{2584.3940,2825.1748,27.8203,244.5475},
		{2631.8110,2834.2593,40.3281,213.2975},
		{2632.2852,2834.9390,122.9219,197.6725},
		{2646.1997,2817.7070,36.3222,182.0474},
		{2685.8875,2816.6575,36.3222,129.9525},
		{2691.1233,2787.7883,59.0212,208.0777},
		{2717.8071,2771.3464,74.8281,72.3429},
		{2695.2622,2699.5488,22.9472,66.3686},
		{2688.8206,2689.0039,28.1563,14.8979},
		{2655.0229,2650.6807,36.9154,341.8097},
		{2570.4668,2701.2876,22.9507,204.0154},
		{2498.9915,2704.6204,10.9844,168.9241},
		{2524.1584,2743.3735,10.9917,150.3771},
		{2498.3167,2782.3357,10.8203,251.7015},
		{2504.5142,2805.9763,14.8222,108.6137},
		{2522.2144,2814.7087,24.9536,265.9478},
		{2510.6292,2849.6384,14.8222,191.4991},
		{2618.2646,2720.8005,36.5386,346.6828},
		{2690.9980,2741.9060,19.0722,91.6099}
	};
	new Float:WarPositions_2[][4] = // iraq
	{
		{-1299.7264,2546.5657,87.7422,274.1018},
		{-1303.9529,2555.9031,87.0958,2.0436},
		{-1307.3884,2553.4380,87.4290,83.2395},
		{-1319.5493,2539.9519,87.5587,6.9747},
		{-1314.6217,2541.5100,87.7422,289.0962},
		{-1311.6113,2528.7515,87.6399,32.1510},
		{-1310.1027,2522.9004,87.4097,212.1510},
		{-1315.6029,2508.7024,87.0420,34.4021},
		{-1309.2416,2492.9487,89.8672,181.8151},
		{-1316.5099,2503.3513,89.5703,337.7607},
		{-1321.2992,2503.0444,89.5703,157.7608},
		{-1320.9303,2508.5989,92.5406,195.6216},
		{-1321.3324,2514.3613,92.5406,15.6216},
		{-1325.7001,2526.6069,89.9844,15.6216},
		{-1337.9225,2522.8469,87.0469,127.7751}
	};
	switch(actuid)
	{
		case 1: // Random War
		{
			SetPlayerHealth(playerid,100.0);
			SetPlayerArmour(playerid,0.0);
			new r = random(sizeof(WarPositions));
			SetPlayerPos(playerid,WarPositions[r][0],WarPositions[r][1],WarPositions[r][2]);
			SetPlayerFacingAngle(playerid,WarPositions[r][3]);
			SetPlayerInterior(playerid,16);
			GiveWeapon(playerid,warweaps[random(sizeof(warweaps))],100000);
		}
		case 2: // War Game
		{
			SetPlayerHealth(playerid,100.0);
			SetPlayerArmour(playerid,100.0);
			new r = random(sizeof(WarPositions));
			SetPlayerPos(playerid,WarPositions[r][0],WarPositions[r][1],WarPositions[r][2]);
			SetPlayerFacingAngle(playerid,WarPositions[r][3]);
			GiveWeapon(playerid,warweaps[WorldInfo[Activities[idx][actWorld]][wActivityParam]],100000);
			SetPlayerInterior(playerid,16);
			GameTextForPlayer(playerid,frmt("~r~%s",WeaponName(warweaps[WorldInfo[Activities[idx][actWorld]][wActivityParam]])),2000,4);
		}
		case 3: // Matrix
		{
			SetPlayerSkin(playerid,165 + random(2));
			SetPlayerHealth(playerid,100.0);
			SetPlayerArmour(playerid,100.0);
			new r = random(sizeof(WarPositions_9));
			SetPlayerPos(playerid,WarPositions_9[r][0],WarPositions_9[r][1],WarPositions_9[r][2]);
			SetPlayerFacingAngle(playerid,WarPositions_9[r][3]);
			SetPlayerInterior(playerid,0);
			GiveWeapon(playerid,4,0);
			GiveWeapon(playerid,24,100000);
		}
		case 4: // Gun Game
		{
			SetPlayerHealth(playerid,100.0);
			SetPlayerArmour(playerid,100.0);
			new r = random(sizeof(WarPositions_2));
			SetPlayerPos(playerid,WarPositions_2[r][0],WarPositions_2[r][1],WarPositions_2[r][2]);
			SetPlayerFacingAngle(playerid,WarPositions_2[r][3]);
			GiveWeapon(playerid,ggweapons[WorldInfo[Activities[idx][actWorld]][wActivityParam]][0],100000);
			SetPlayerInterior(playerid,0);
			GameTextForPlayer(playerid,frmt("~y~level 1:~n~~r~%s",WeaponName(ggweapons[WorldInfo[Activities[idx][actWorld]][wActivityParam]][0])),2000,4);
		}
		case 5: // Bike Jump
		{
		}
		case 6: // Bumper
		{
		}
		case 7: // Race War
		{
		}
	}
	/*
	{1,world_dm,30,"Random War"},
	{2,world_dm,30,"War Game"},
	{3,world_dm,60,"Matrix"},
	{4,world_dm,60,"Gun Game"},
	{5,world_stunts,60,"Bike Jump"},
	{6,world_stuntswo,60,"Bumper"},
	{7,world_stuntswo,60,"Race War"}
	*/
}
stock LeaveActivity(playerid,bool:disconnected=false)
{
	new index = GetActivityIndex(WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][0]);
	if(PlayerInfo[playerid][pActivityVehicle] > -1 && IsValidVehicle(PlayerInfo[playerid][pActivityVehicle])) DestroyVehicleEx(PlayerInfo[playerid][pActivityVehicle]);
	PlayerInfo[playerid][pInActivity] = false, PlayerInfo[playerid][pActivityVehicle] = -1, PlayerInfo[playerid][pActivityParams] = {0,0};
	if(!WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][1] && WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][2])
	{
		new pl[MAX_PLAYERS] = {INVALID_PLAYER_ID,...}, pls = 0;
		Loop(i) if(PlayerInfo[i][pWorld] == Activities[index][actWorld] && PlayerInfo[i][pInActivity]) pl[pls++] = i;
		if(pls == 1)
		{
			if(IsPlayerConnected(pl[0]))
			{
				frmt(" • • !%s ניצח בפעילות %s • •",Activities[index][actName],GetName(pl[0]));
				Loop(i) if(PlayerInfo[i][pWorld] == Activities[index][actWorld]) SendClientMessage(i,green,fstring);
				GiveExp(pl[0],exp_activity);
			}
			StopActivity(Activities[index][actUID]);
		}
		if(!disconnected) SpawnPlayer(playerid);
	}
}
stock IsPlayerInActivity(playerid,actuid)
{
	new idx = GetActivityIndex(actuid);
	return WorldInfo[Activities[idx][actWorld]][wActivity][0] == actuid && PlayerInfo[playerid][pWorld] == Activities[idx][actWorld] && PlayerInfo[playerid][pInActivity] && WorldInfo[Activities[idx][actWorld]][wActivity][1] < 3;
}
stock GiveWeapon(playerid,weaponid,ammo)
{
	new wd[2];
	GetPlayerWeaponData(playerid,GetWeaponSlot(weaponid),wd[0],wd[1]);
	if(wd[0] > 0 && wd[0] != weaponid) PlayerInfo[playerid][pUsingWeapons][wd[0]-1] = false;
	PlayerInfo[playerid][pUsingWeapons][max(0,weaponid-1)] = true;
	PlayerInfo[playerid][pShootTC][weaponid] = 0;
	PlayerInfo[playerid][pWeaponsCheatWait] = 2;
	GivePlayerWeapon(playerid,weaponid,ammo);
}
stock ResetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);
	for(new i = 0; i < 46; i++) PlayerInfo[playerid][pUsingWeapons][i] = false, PlayerInfo[playerid][pShootTC][i] = 0;
}
stock RefreshWeapons(playerid)
{
	for(new i = 0; i < 46; i++) PlayerInfo[playerid][pUsingWeapons][i] = false;
	for(new i = 0, w = -1, a = -1; i < 13; i++)
	{
		GetPlayerWeaponData(playerid,i,w,a);
		if(w > 0 && (w <= 15 || (w > 15 && a > 0))) PlayerInfo[playerid][pUsingWeapons][w-1] = true;
	}
}
stock Log(logfile[],playerid,text[])
{
	new date[3], fn[64];
	getdate(date[0],date[1],date[2]);
	format(fn,sizeof(fn),dir_logs "/%s/",logfile);
	if(!fexist(fn)) dcreate(fn);
	format(fn,sizeof(fn),dir_logs "/%s/%s_%d_%d_%d.log",logfile,logfile,date[2],date[1],date[0]);
	new File:flog = fopen(fn,fexist(fn) ? io_append : io_write);
	if(flog)
	{
		new string[256];
		if(playerid == -1) format(string,sizeof(string),"[%s %s %s] %s\r\n",GetDateAsString(),GetTimeAsString(true),logfile,text);
		else format(string,sizeof(string),"[%s %s %s] %s (%d, %s): %s\r\n",GetDateAsString(),GetTimeAsString(true),logfile,GetName(playerid),playerid,GetIP(playerid),text);
		fwrite(flog,string);
		fclose(flog);
	}
	return 1;
}
stock AdminCommands(e_AdminCmdOptions:opt,param[]="")
{
	switch(opt)
	{
		case acInitialize: for(new i = 0; i < sizeof(AdminCommandList); i++) fsetint(file_admincmd,AdminCommandList[i][acName],AdminCommandList[i][acLevel]);
		case acUpdate: for(new i = 0; i < sizeof(AdminCommandList); i++) AdminCommandList[i][acLevel] = fkeyexist(file_admincmd,AdminCommandList[i][acName]) ? fgetint(file_admincmd,AdminCommandList[i][acName]) : (fsetint(file_admincmd,AdminCommandList[i][acName],AdminCommandList[i][acLevel]), AdminCommandList[i][acLevel]);
		case acFind:
		{
			for(new i = 0; i < sizeof(AdminCommandList); i++) if(equal(AdminCommandList[i][acName],param)) return i;
			return -1;
		}
	}
	return 1;
}
stock Freeze(playerid,bool:bool) return TogglePlayerControllable(playerid,!bool);
stock GetVehicleMaxSpeed(modelid) return floatround(GTASAHandling[modelid-400][esh_maxVelocity]);
stock MoveCamera(playerid)
{
	new Float:fv[3], Float:cp[3];
	GetPlayerCameraPos(playerid,cp[0],cp[1],cp[2]);
    GetPlayerCameraFrontVector(playerid,fv[0],fv[1],fv[2]);
	if(PlayerInfo[playerid][pAccelMul] <= 1) PlayerInfo[playerid][pAccelMul] += 0.03;
	new Float:speed = PlayerInfo[playerid][pMoveSpeed] * PlayerInfo[playerid][pAccelMul], Float:p[3];
	switch(PlayerInfo[playerid][pFlyKeys])
	{
		case 1: p[0] = cp[0]+(fv[0]*6000.0), p[1] = cp[1]+(fv[1]*6000.0), p[2] = cp[2]+(fv[2]*6000.0);
		case 2: p[0] = cp[0]-(fv[0]*6000.0), p[1] = cp[1]-(fv[1]*6000.0), p[2] = cp[2]-(fv[2]*6000.0);
		case 3: p[0] = cp[0]-(fv[1]*6000.0), p[1] = cp[1]+(fv[0]*6000.0), p[2] = cp[2];
		case 4: p[0] = cp[0]+(fv[1]*6000.0), p[1] = cp[1]-(fv[0]*6000.0), p[2] = cp[2];
		case 5: p[0] = cp[0]+((fv[0]*6000.0) - (fv[1]*6000.0)), p[1] = cp[1]+((fv[1]*6000.0) + (fv[0]*6000.0)), p[2] = cp[2]+(fv[2]*6000.0);
		case 6: p[0] = cp[0]+((fv[0]*6000.0) + (fv[1]*6000.0)), p[1] = cp[1]+((fv[1]*6000.0) - (fv[0]*6000.0)), p[2] = cp[2]+(fv[2]*6000.0);
		case 7: p[0] = cp[0]+(-(fv[0]*6000.0) - (fv[1]*6000.0)), p[1] = cp[1]+(-(fv[1]*6000.0) + (fv[0]*6000.0)), p[2] = cp[2]-(fv[2]*6000.0);
		case 8: p[0] = cp[0]+(-(fv[0]*6000.0) + (fv[1]*6000.0)), p[1] = cp[1]+(-(fv[1]*6000.0) - (fv[0]*6000.0)), p[2] = cp[2]-(fv[2]*6000.0);
	}
	MovePlayerObject(playerid,PlayerInfo[playerid][pFlyObject],p[0],p[1],p[2],speed);
	PlayerInfo[playerid][pLastMove] = GetTickCount();
	return 1;
}
stock GetPlayerCameraLookAt(playerid,&Float:x,&Float:y,&Float:z)
{
    new Float:p[6];
    GetPlayerCameraPos(playerid,p[0],p[1],p[2]);
    GetPlayerCameraFrontVector(playerid,p[3],p[4],p[5]);
    x = floatadd(p[0],p[3]), y = floatadd(p[1],p[4]), z = floatadd(p[2],p[5]);
    return 1;
}
stock CameraUpdate(playerid)
{
	new Float:p[3], Float:d = PlayerInfo[playerid][pCameraDistance];
	GetPlayerPos(PlayerInfo[playerid][pCameraFollowID],p[0],p[1],p[2]);
	SetPlayerCameraLookAt(playerid,p[0],p[1],p[2]);
	switch(PlayerInfo[playerid][pCameraDirection])
	{
		case 0: /* up */ SetPlayerCameraPos(playerid,p[0],p[1],p[2]+d);
		case 1: /* down */ SetPlayerCameraPos(playerid,p[0],p[1],p[2]-d);
		case 2: /* left */ SetPlayerCameraPos(playerid,p[0]-d,p[1],p[2]+d);
		case 3: /* right */ SetPlayerCameraPos(playerid,p[0]+d,p[1],p[2]+d);
		case 4: /* forward */ SetPlayerCameraPos(playerid,p[0],p[1]+d,p[2]+d);
		case 5: /* backward */ SetPlayerCameraPos(playerid,p[0],p[1]-d,p[2]+d);
	}
	CancelWatchers(playerid);
}
stock CancelWatchers(playerid)
{
	Loop(i) if(PlayerInfo[i][pSpectate] == playerid && PlayerInfo[i][pCameraMode] == camera_spec)
	{
		TogglePlayerSpectating(i,0);
		PlayerInfo[i][pSpectate] = -1, PlayerInfo[i][pCameraMode] = camera_none;
		SendClientMessage(i,red," .שחקן זה נכנס למצב מצלמה ולכן לא ניתן להמשיך לצפות בו");
	}
}
stock CanUseCommand(playerid,bool:afk=true,bool:act=true,bool:dmz=true,bool:cls=true,bool:spc=true,bool:qst=true,bool:msg=true)
{
	if(afk && PlayerInfo[playerid][pAFK]) return (msg ? SendClientMessage(playerid,red," .AFK לא ניתן לבצע פקודה זו במצב") : 0), 0;
	if(act && PlayerInfo[playerid][pInActivity]) if(WorldInfo[PlayerInfo[playerid][pWorld]][wActivity][1] < 4) return (msg ? SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו בפעילות") : 0), 0;
	if(dmz && PlayerInfo[playerid][pDMZone] != -1) return (msg ? SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו באזור דיאם") : 0), 0;
	if(cls && PlayerInfo[playerid][pWorld] == world_class) return (msg ? SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו בבחירת הדמויות") : 0), 0;
	if(spc && GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return (msg ? SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו במעקב") : 0), 0;
	if(qst && PlayerInfo[playerid][pQuest] > -1) return (msg ? SendClientMessage(playerid,red," .לא ניתן לבצע פקודה זו באמצע ביצוע משימה") : 0), 0;
	return 1;
}
stock Quest_GetData(q,s,Float:p[3])
{
	p = Float:{0.0,0.0,0.0};
	switch(Quests[q][qPath])
	{
		case 1:
		{
			switch(s)
			{
				case 1: p = Float:{0.0,0.0,0.0};
			}
		}
	}
}
stock Quest_Start(playerid,q)
{
	new Float:firstsData[2][3];
	for(new i = 0; i < 2; i++) Quest_GetData(q,i+1,firstsData[i]);
	SetPlayerRaceCheckpoint(playerid,0,firstsData[0][0],firstsData[0][1],firstsData[0][2],firstsData[1][0],firstsData[1][1],firstsData[1][2],7.5);
}
forward Float:ratio(n1,n2);
stock Float:ratio(n1,n2)
{
	new Float:d = floatabs(floatdiv(n1,n2));
	return d == FLOAT_NAN || d == FLOAT_INFINITY || d < 0.0 ? 0.0 : d;
}
stock LoadProperties()
{
	CreateProperty("The Four Dragons",1996.7345,1006.2436,994.4688,50000,1900);
	CreateProperty("The Pirate Ship",2000.5307,1579.4707,16.7754,14500,500);
	CreateProperty("Caligula's Casino",2235.7380,1677.9157,1008.3593,40000,1500);
	CreateProperty("Sex Shop",-103.7366,-24.5130,1000.7186,6500,210);
	CreateProperty("Tattoo Parlor",-202.6963,-42.6016,1002.2733,7000,190);
	CreateProperty("Barber",418.3410,-75.6340,1001.8046,7000,220);
	CreateProperty("Emerald Isle",2127.5725,2378.6474,10.8203,20000,650);
	CreateProperty("Las Venturas Gym",765.2996,-77.1738,1000.6562,9000,305);
	CreateProperty("Las Venturas Police Station",2250.9145,2488.6052,10.9908,12000,390);
	CreateProperty("Zip Shop",161.6725,-80.0910,1001.8046,7500,275);
	CreateProperty("Binco Shop",207.8240,-98.1033,1005.2578,7500,275);
	CreateProperty("Bar",489.8944,-77.6156,998.7578,5000,180);
	CreateProperty("Las Venturas Airport",1696.1922,1568.1749,10.7764,30000,950);
	CreateProperty("San Fierro Airport",-1423.3229,-289.0012,14.1484,30000,950);
	CreateProperty("Los Santos Airport",1445.8082,-2287.2690,13.5468,30000,950);
	CreateProperty("CJ's House",2498.4501,-1717.7839,18.5820,4000,150);
	CreateProperty("Los Santos Gym",766.2474,14.7180,1000.6998,9000,305);
	CreateProperty("Air Strip",418.0119,2536.9997,10.0000,26500,850);
	CreateProperty("Los Santos Hospital",1173.3361,-1323.6779,15.3931,18500,630);
	CreateProperty("Golf Club",1457.2172,2773.3142,10.8203,25000,810);
}
stock StopPlayer(playerid)
{
	SetPlayerArmedWeapon(playerid,0);
	TogglePlayerControllable(playerid,0);
	TogglePlayerControllable(playerid,1);
	PlaySound(playerid,1085);
	return 1;
}
stock advertisement(text[],where[],playerid)
{
	new ret = 0;
	if(strfind(text,srvip,true) == -1 && strfind(text,webpage,true) == -1 && strfind(text,tsip,true) == -1 && strfind(text,"...",true) == -1 && !advAccess)
	{
		new ipWarns[2] = {0,0}, len = strlen(text);
		for(new i = 0; i < len; i++) if(text[i] >= '0' && text[i] <= '9') ipWarns[0]++;
		if(ipWarns[0] >= 6 && ipWarns[0] <= 17) for(new i = 0; i < len; i++) if((text[i] >= 34 && text[i] <= 47) || text[i] == 58 || text[i] == 59 || text[i] == 'X' || text[i] == 'x') ipWarns[1]++;
		if(ipWarns[1] >= 3 && ipWarns[1] <= 5) ret = 1;
		if(strfind(text,".co.il",true) != -1 || strfind(text,".com",true) != -1 || strfind(text,".net",true) != -1) ret = 1;
	}
	if(ret)
	{
		SendClientMessage(playerid,red," .המערכת זיהתה פרסום ולכן ההודעה הועברה אל האדמינים לבדיקה");
		new string[M_S];
		format(string,sizeof(string)," (/aadv אישור ההודעה | /b באן מהיר) :%s - זוהה פרסום ב%s מאיידי %d",GetName(playerid),where,playerid);
		lastB = playerid, lastBType = 1;
		format(lastAdvMessage,sizeof(lastAdvMessage),text);
		Loop(i) if(IsPlayerConnected(i) && IsPlayerMAdmin(i))
		{
			SendClientMessage(i,blue,"----------");
			SendClientMessage(i,red,string);
			SendClientMessage(i,red,text);
			SendClientMessage(i,blue,"----------");
		}
	}
	return ret;
}
stock LoadVehicles()
{
	CreateVehicleEx(541,1054.2906,2408.6772,10.4453,180.0242,-1,-1,.world=world_dm); // [Bullet]  Race
	CreateVehicleEx(541,1048.3430,2408.5268,10.4452,179.6023,-1,-1,.world=world_dm); // [Bullet]  Race
	CreateVehicleEx(541,1042.3463,2408.6289,10.4452,179.9458,-1,-1,.world=world_dm); // [Bullet]  Race
	CreateVehicleEx(541,1036.5686,2408.6230,10.4452,180.0815,-1,-1,.world=world_dm); // [Bullet]  Race
	CreateVehicleEx(541,1030.3802,2408.5639,10.4452,179.5812,-1,-1,.world=world_dm); // [Bullet]  Race
	CreateVehicleEx(541,1024.1954,2408.3244,10.4454,179.2016,-1,-1,.world=world_dm); // [Bullet]  Race
	CreateVehicleEx(429,1023.9713,2420.4291,10.4999,90.1561,-1,-1,.world=world_dm); // [Banshee]  Race
	CreateVehicleEx(429,1023.9901,2426.7246,10.4999,91.0525,-1,-1,.world=world_dm); // [Banshee]  Race
	CreateVehicleEx(429,1023.8038,2432.3466,10.5000,92.0571,-1,-1,.world=world_dm); // [Banshee]  Race
	CreateVehicleEx(429,1023.8697,2438.5522,10.4999,88.2853,-1,-1,.world=world_dm); // [Banshee]  Race
	CreateVehicleEx(429,1023.9898,2444.3435,10.4999,90.8252,-1,-1,.world=world_dm); // [Banshee]  Race
	CreateVehicleEx(429,1024.1931,2450.8547,10.4999,90.4138,-1,-1,.world=world_dm); // [Banshee]  Race
	CreateVehicleEx(411,990.5509,2450.4272,10.3608,271.8076,-1,-1,.world=world_dm); // [Infernus]  Race
	CreateVehicleEx(411,990.7402,2444.4301,10.3608,271.8076,-1,-1,.world=world_dm); // [Infernus]  Race
	CreateVehicleEx(411,990.9295,2438.4331,10.5597,271.8076,-1,-1,.world=world_dm); // [Infernus]  Race
	CreateVehicleEx(411,991.1187,2432.4360,10.5630,271.8076,-1,-1,.world=world_dm); // [Infernus]  Race
	CreateVehicleEx(411,991.3048,2426.4428,10.5594,272.0854,-1,-1,.world=world_dm); // [Infernus]  Race
	CreateVehicleEx(411,991.4973,2420.4418,10.5630,271.8076,-1,-1,.world=world_dm); // [Infernus]  Race
	CreateVehicleEx(451,990.8733,2408.5847,10.5470,181.8802,-1,-1,.world=world_dm); // [Turismo]  Race
	CreateVehicleEx(451,984.8765,2408.3879,10.5470,181.8802,-1,-1,.world=world_dm); // [Turismo]  Race
	CreateVehicleEx(451,978.8798,2408.1911,10.5470,181.8802,-1,-1,.world=world_dm); // [Turismo]  Race
	CreateVehicleEx(451,972.8830,2407.9919,10.4703,181.8802,-1,-1,.world=world_dm); // [Turismo]  Race
	CreateVehicleEx(451,966.8862,2407.7951,10.4703,181.8802,-1,-1,.world=world_dm); // [Turismo]  Race
	CreateVehicleEx(451,960.8895,2407.5983,10.4703,181.8802,-1,-1,.world=world_dm); // [Turismo]  Race
	CreateVehicleEx(494,2045.2600,819.3722,7.5683,0.0000,-1,-1,.world=world_dm); // [Hotring]  Race2
	CreateVehicleEx(494,2049.7600,819.3698,7.5659,0.0000,-1,-1,.world=world_dm); // [Hotring]  Race2
	CreateVehicleEx(494,2054.2614,819.3715,7.5603,0.0174,-1,-1,.world=world_dm); // [Hotring]  Race2
	CreateVehicleEx(494,2058.7600,819.3784,7.5078,0.0000,-1,-1,.world=world_dm); // [Hotring]  Race2
	CreateVehicleEx(494,2063.2590,819.3551,7.5996,359.9831,-1,-1,.world=world_dm); // [Hotring]  Race2
	CreateVehicleEx(494,2067.7600,819.3560,7.6015,0.0000,-1,-1,.world=world_dm); // [Hotring]  Race2
	CreateVehicleEx(494,2072.2600,819.3560,7.6015,0.0000,-1,-1,.world=world_dm); // [Hotring]  Race2
	CreateVehicleEx(415,2033.0356,897.8939,7.6427,269.9723,-1,-1,.world=world_dm); // [Cheetah]  Race2
	CreateVehicleEx(415,2033.0354,893.3958,7.4338,269.9757,-1,-1,.world=world_dm); // [Cheetah]  Race2
	CreateVehicleEx(415,2033.0367,888.9436,7.3275,269.1373,-1,-1,.world=world_dm); // [Cheetah]  Race2
	CreateVehicleEx(506,2033.0683,884.7390,7.0766,270.0545,-1,-1,.world=world_dm); // [Super GT]  Race2
	CreateVehicleEx(506,2033.0655,880.2741,7.1826,270.0220,-1,-1,.world=world_dm); // [Super GT]  Race2
	CreateVehicleEx(603,2082.3688,874.8980,6.9572,90.0144,-1,-1,.world=world_dm); // [Phoenix]  Race2
	CreateVehicleEx(603,2082.3715,879.3905,7.0654,89.9985,-1,-1,.world=world_dm); // [Phoenix]  Race2
	CreateVehicleEx(603,2082.3715,883.8833,7.2184,89.9970,-1,-1,.world=world_dm); // [Phoenix]  Race2
	CreateVehicleEx(575,2082.0900,888.1517,7.2112,89.9866,-1,-1,.world=world_dm); // [Broadway]  Race2
	CreateVehicleEx(575,2082.0961,892.6655,7.2738,89.8939,-1,-1,.world=world_dm); // [Broadway]  Race2
	CreateVehicleEx(602,2179.5041,988.0536,10.6268,359.5419,-1,-1,.world=world_dm); // [Alpha]  Carpark near race
	CreateVehicleEx(481,2176.4238,986.6916,10.3284,1.0962,-1,-1,.world=world_dm); // [BMX]  Carpark near race
	CreateVehicleEx(462,2172.1533,1009.7221,10.4164,266.9175,-1,-1,.world=world_dm); // [Faggio]  Carpark near race
	CreateVehicleEx(586,2133.7297,1025.8419,10.3407,92.6245,-1,-1,.world=world_dm); // [Wayfarer]  Carpark near race
	CreateVehicleEx(586,2133.6547,1028.9968,10.3400,93.1130,-1,-1,.world=world_dm); // [Wayfarer]  Carpark near race
	CreateVehicleEx(411,2132.9082,1009.7144,10.5487,91.0003,-1,-1,.world=world_dm); // [Infernus]  carpark near race
	CreateVehicleEx(506,2162.8923,1028.9030,10.5247,271.8912,-1,-1,.world=world_dm); // [Super GT]  carpark near race
	CreateVehicleEx(415,2154.7194,987.3355,10.5931,359.9657,-1,-1,.world=world_dm); // [Cheetah]  carpark near race
	CreateVehicleEx(507,2122.5651,988.0500,10.6440,178.6325,-1,-1,.world=world_dm); // [Elegant]  carpark near race
	CreateVehicleEx(562,2142.1218,1022.4686,10.4798,90.5757,-1,-1,.world=world_dm); // [Elegy]  carpark near race
	CreateVehicleEx(521,2148.7304,1408.0443,10.3942,359.9388,-1,-1,.world=world_dm); // [FCR-900]  Carpark near LV
	CreateVehicleEx(582,2103.8818,1396.9046,10.8758,179.7095,-1,-1,.world=world_dm); // [Newsvan]  Carpark near LV
	CreateVehicleEx(579,2142.4428,1397.8328,10.7501,179.1489,-1,-1,.world=world_dm); // [Huntley]  Carpark near LV
	CreateVehicleEx(567,2126.2846,1408.2427,10.7017,359.7944,-1,-1,.world=world_dm); // [Savanna]  Carpark Casino Royal
	CreateVehicleEx(458,2110.3105,1408.3333,10.7453,180.5337,-1,-1,.world=world_dm); // [Solair]  Carpark Casino Royal
	CreateVehicleEx(467,2120.0026,1398.0900,10.6228,179.3894,-1,-1,.world=world_dm); // [Oceanic]  Carpark Casino Royal
	CreateVehicleEx(477,2177.4416,1856.5212,10.5735,180.8848,-1,-1,.world=world_dm); // [ZR-350]  Clowns pocket
	CreateVehicleEx(480,2191.1203,1878.9981,10.5929,180.8524,-1,-1,.world=world_dm); // [Comet]  Clowns pocket
	CreateVehicleEx(504,2210.3325,1879.1975,10.6300,180.6192,-1,-1,.world=world_dm); // [Bloodring Banger]  Clowns pocket
	CreateVehicleEx(518,2196.2055,1856.2818,10.4927,179.8852,-1,-1,.world=world_dm); // [Buccaneer]  Clowns pocket
	CreateVehicleEx(526,2221.5637,1878.6831,10.5869,1.5046,-1,-1,.world=world_dm); // [Fortune]  Clowns pocket
	CreateVehicleEx(534,2232.6813,1878.7274,10.5440,359.7986,-1,-1,.world=world_dm); // [Remington]  Clowns pocket
	CreateVehicleEx(542,2270.4401,1878.8078,10.5639,182.0033,-1,-1,.world=world_dm); // [Clover]  Clowns pocket
	CreateVehicleEx(549,2148.6970,1812.4787,10.5172,63.3620,-1,-1,.world=world_dm); // [Tampa]  clowns pocket
	CreateVehicleEx(535,2215.9641,1787.8900,10.5816,181.3069,-1,-1,.world=world_dm); // [Slamvan]  clowns pocket
	CreateVehicleEx(576,2241.8640,1788.5535,10.4300,2.0588,-1,-1,.world=world_dm); // [Tornado]  clowns pocket
	CreateVehicleEx(575,2195.0871,1810.2932,10.4228,358.8919,-1,-1,.world=world_dm); // [Broadway]  Clowns Pocket
	CreateVehicleEx(562,2175.7109,1809.7381,10.4587,0.7463,-1,-1,.world=world_dm); // [Elegy]  Clowns Pocket
	CreateVehicleEx(561,2163.5439,1800.1058,10.6341,180.9614,-1,-1,.world=world_dm); // [Stratum]  Clowns Pocket
	CreateVehicleEx(565,2183.4704,1800.6185,10.4450,179.3082,-1,-1,.world=world_dm); // [Flash]  Clowns Pocket
	CreateVehicleEx(521,2194.8391,1786.7623,10.3914,358.8641,-1,-1,.world=world_dm); // [FCR-900]  Clowns Pocket
	CreateVehicleEx(521,2199.2136,1786.9940,10.3912,2.3646,-1,-1,.world=world_dm); // [FCR-900]  Clowns Pocket
	CreateVehicleEx(560,2177.5458,1787.4062,10.5251,358.8370,-1,-1,.world=world_dm); // [Sultan]  Clowns Pocket
	CreateVehicleEx(550,2155.9555,1788.0314,10.6396,357.8988,-1,-1,.world=world_dm); // [Sunrise]  Clowns Pocket
	CreateVehicleEx(545,2163.1303,1822.1608,10.6313,181.4761,-1,-1,.world=world_dm); // [Hustler]  Clowns Pocket
	CreateVehicleEx(541,2185.3415,1822.1009,10.4452,179.0430,-1,-1,.world=world_dm); // [Bullet]  Clowns Pocket
	CreateVehicleEx(602,1893.6223,1989.6555,7.4013,181.3253,-1,-1,.world=world_dm); // [Alpha]  The Visage carpark
	CreateVehicleEx(603,1872.0062,1989.1765,7.4335,0.5492,-1,-1,.world=world_dm); // [Phoenix]  The Visage carpark
	CreateVehicleEx(587,1908.0844,1933.3884,7.3191,181.3408,-1,-1,.world=world_dm); // [Euros]  The Visage carpark
	CreateVehicleEx(555,1883.0100,1933.5966,7.2781,359.7443,-1,-1,.world=world_dm); // [Windsor]  The Visage carpark
	CreateVehicleEx(545,1873.7803,1933.8226,7.4056,178.0636,-1,-1,.world=world_dm); // [Hustler]  The Visage carpark
	CreateVehicleEx(541,1878.5001,1816.5418,12.3693,0.3800,-1,-1,.world=world_dm); // [Bullet]  The Visage carpark
	CreateVehicleEx(429,1903.1127,1816.3110,12.4233,178.6378,-1,-1,.world=world_dm); // [Banshee]  The Visage carpark
	CreateVehicleEx(463,1913.7039,1816.3570,12.2820,213.8972,-1,-1,.world=world_dm); // [Freeway]  The Visage carpark
	CreateVehicleEx(533,1928.0618,1761.1448,12.4234,181.4110,-1,-1,.world=world_dm); // [Feltzer]  The Visage carpark
	CreateVehicleEx(527,1946.1016,1761.8430,12.4298,179.3132,-1,-1,.world=world_dm); // [Cadrona]  The Visage carpark
	CreateVehicleEx(562,1928.1462,1783.5001,12.3745,1.7345,-1,-1,.world=world_dm); // [Elegy]  The Visage carpark
	CreateVehicleEx(517,1901.1356,1784.0068,12.5986,179.2256,-1,-1,.world=world_dm); // [Majestic]  The Visage carpark
	CreateVehicleEx(559,1914.3161,1783.6246,12.3999,0.7179,-1,-1,.world=world_dm); // [Jester]  The Visage carpark
	CreateVehicleEx(551,1963.2989,1728.1892,12.5449,180.5200,-1,-1,.world=world_dm); // [Merit]  The Visage carpark
	CreateVehicleEx(550,1913.1219,1728.5247,12.5320,0.7856,-1,-1,.world=world_dm); // [Sunrise]  The Visage carpark
	CreateVehicleEx(521,1927.5223,1728.1931,12.2849,28.9043,-1,-1,.world=world_dm); // [FCR-900]  The Visage carpark
	CreateVehicleEx(509,1942.7282,1762.1447,18.4190,206.4299,-1,-1,.world=world_dm); // [Bike]  The Visage carpark
	CreateVehicleEx(506,1928.2155,1760.9711,18.6090,180.0969,-1,-1,.world=world_dm); // [Super GT]  The Visage carpark
	CreateVehicleEx(500,1938.7819,1783.8074,19.0084,179.3326,-1,-1,.world=world_dm); // [Mesa]  The Visage carpark
	CreateVehicleEx(424,1958.6853,1799.7741,18.7142,358.8542,-1,-1,.world=world_dm); // [BF Injection]  The Visage carpark
	CreateVehicleEx(496,1942.2945,1800.2667,18.6213,180.1391,-1,-1,.world=world_dm); // [Blista Compact]  The Visage carpark
	CreateVehicleEx(489,1960.1420,1728.4161,19.0775,180.0685,-1,-1,.world=world_dm); // [Rancher]  The Visage carpark
	CreateVehicleEx(475,1976.8284,1751.1522,18.7373,182.8581,-1,-1,.world=world_dm); // [Sabre]  The Visage carpark
	CreateVehicleEx(474,2005.8258,1728.2313,18.6967,3.4934,-1,-1,.world=world_dm); // [Hermes]  The Visage carpark
	CreateVehicleEx(467,2008.5234,1751.1656,18.6739,180.3596,-1,-1,.world=world_dm); // [Oceanic]  The Visage carpark
	CreateVehicleEx(477,1979.8596,1728.8186,18.6886,177.1046,-1,-1,.world=world_dm); // [ZR-350]  The Visage carpark
	CreateVehicleEx(445,1868.5612,1966.6258,13.6605,359.7386,-1,-1,.world=world_dm); // [Admiral]  The Visage Carpark
	CreateVehicleEx(518,1875.7235,1966.5242,13.4556,0.1707,-1,-1,.world=world_dm); // [Buccaneer]  The Visage Carpark
	CreateVehicleEx(576,1897.2866,1967.0064,13.3942,0.5124,-1,-1,.world=world_dm); // [Tornado]  The Visage Carpark
	CreateVehicleEx(527,1893.5740,1989.0482,13.4986,181.3529,-1,-1,.world=world_dm); // [Cadrona]  The Visage Carpark
	CreateVehicleEx(560,1889.9343,1989.0787,13.4896,179.3403,-1,-1,.world=world_dm); // [Sultan]  The Visage Carpark
	CreateVehicleEx(555,1882.7729,1988.8211,13.4682,179.3109,-1,-1,.world=world_dm); // [Windsor]  The Visage Carpark
	CreateVehicleEx(461,1907.9335,1932.2603,13.3714,0.5557,-1,-1,.world=world_dm); // [PCJ-600]  The Visage Carpark
	CreateVehicleEx(466,1861.3144,1933.5681,13.5266,359.6922,-1,-1,.world=world_dm); // [Glendale]  The Visage Carpark
	CreateVehicleEx(474,1870.6232,1933.5786,13.5472,359.8934,-1,-1,.world=world_dm); // [Hermes]  The Visage Carpark
	CreateVehicleEx(546,1889.4899,1933.3870,13.5091,359.2339,-1,-1,.world=world_dm); // [Intruder]  The Visage Carpark
	CreateVehicleEx(546,1949.7935,1783.3061,12.4388,179.0456,-1,-1,.world=world_dm); // [Intruder]  The Visage Carpark
	CreateVehicleEx(551,2011.9152,1750.3702,12.5442,180.3502,-1,-1,.world=world_dm); // [Merit]  The Visage Carpark
	CreateVehicleEx(516,1998.1661,1751.0025,12.5773,181.0839,-1,-1,.world=world_dm); // [Nebula]  The Visage Carpark
	CreateVehicleEx(461,2002.6063,1727.2364,12.3329,358.0770,-1,-1,.world=world_dm); // [PCJ-600]  The Visage Carpark
	CreateVehicleEx(436,1992.8402,1728.3900,12.5177,359.7296,-1,-1,.world=world_dm); // [Previon]  The Visage Carpark
	CreateVehicleEx(540,1979.6308,1728.5864,12.6074,0.6737,-1,-1,.world=world_dm); // [Vincent]  The Visage Carpark
	CreateVehicleEx(529,1958.6243,1800.0605,12.3730,181.7696,-1,-1,.world=world_dm); // [Willard]  The Visage Carpark
	CreateVehicleEx(461,1911.0207,1785.4012,18.5191,179.4103,-1,-1,.world=world_dm); // [PCJ-600]  The Visage Carpark
	CreateVehicleEx(421,1907.5628,1783.9476,18.8172,181.5584,-1,-1,.world=world_dm); // [Washington]  The Visage Carpark
	CreateVehicleEx(540,1924.5982,1783.8288,18.7668,181.1497,-1,-1,.world=world_dm); // [Vincent]  The Visage Carpark
	CreateVehicleEx(550,1921.7493,1728.1411,18.7248,359.7621,-1,-1,.world=world_dm); // [Sunrise]  The Visage Carpark
	CreateVehicleEx(560,1917.2313,1816.9504,18.6391,178.9401,-1,-1,.world=world_dm); // [Sultan]  The Visage Carpark
	CreateVehicleEx(547,1906.6542,1816.7819,18.6693,180.0884,-1,-1,.world=world_dm); // [Primo]  The Visage Carpark
	CreateVehicleEx(586,1885.2882,1817.2294,18.4530,173.3572,-1,-1,.world=world_dm); // [Wayfarer]  The Visage Carpark
	CreateVehicleEx(586,2012.6257,1726.7498,18.4541,358.1687,-1,-1,.world=world_dm); // [Wayfarer]  The Visage Carpark
	CreateVehicleEx(467,2102.6801,2059.3264,10.5601,269.8981,-1,-1,.world=world_dm); // [Oceanic]  Sex Shop Carpark
	CreateVehicleEx(480,2103.7673,2069.2817,10.5943,90.5479,-1,-1,.world=world_dm); // [Comet]  Sex Shop Carpark
	CreateVehicleEx(463,2104.6240,2089.1513,10.3620,89.3002,-1,-1,.world=world_dm); // [Freeway]  Sex Shop Carpark
	CreateVehicleEx(463,2104.7382,2092.2478,10.3206,91.1463,-1,-1,.world=world_dm); // [Freeway]  Sex Shop Carpark
	CreateVehicleEx(421,2103.2062,2049.6760,10.7028,90.5597,-1,-1,.world=world_dm); // [Washington]  Sex Shop Carpark
	CreateVehicleEx(482,2103.3767,2036.5412,10.9425,269.8827,-1,-1,.world=world_dm); // [Burrito]  Sex Shop Carpark FUCK YOU AMIT
	CreateVehicleEx(535,2187.0749,1979.1179,10.5829,88.2669,-1,-1,.world=world_dm); // [Slamvan]  Bank Carpark
	CreateVehicleEx(481,2169.9257,1996.6850,10.3392,270.0320,-1,-1,.world=world_dm); // [BMX]  Bank Carpark
	CreateVehicleEx(467,2186.6020,2000.1992,10.5339,88.6095,-1,-1,.world=world_dm); // [Oceanic]  Bank Carpark
	CreateVehicleEx(549,2186.1853,1978.9356,10.5175,270.0885,-1,-1,.world=world_dm); // [Tampa]  Bank Carpark
	CreateVehicleEx(429,2215.9150,2041.6771,10.4999,270.6263,-1,-1,.world=world_dm); // [Banshee]  Bank Carpark2
	CreateVehicleEx(468,2214.2248,2055.8508,10.4884,271.9240,-1,-1,.world=world_dm); // [Sanchez]  Bank Carpark2
	CreateVehicleEx(547,2237.3813,2064.4016,10.5562,181.1746,-1,-1,.world=world_dm); // [Primo]  Bank Carpark2
	CreateVehicleEx(400,2249.7829,2064.6848,10.9126,179.8756,-1,-1,.world=world_dm); // [Landstalker]  Bank Carpark2
	CreateVehicleEx(521,2245.0122,2004.8876,10.3905,355.5111,-1,-1,.world=world_dm); // [FCR-900]  Bank Carpark2
	CreateVehicleEx(567,2220.9118,2006.9022,10.6942,0.2609,-1,-1,.world=world_dm); // [Savanna]  Bank Carpark2
	CreateVehicleEx(560,2258.2707,2062.9035,10.5244,0.5828,-1,-1,.world=world_dm); // [Sultan]  bank carpark 2
	CreateVehicleEx(567,2283.5180,2063.1796,10.6944,180.0964,-1,-1,.world=world_dm); // [Savanna]  bank carpark 2
	CreateVehicleEx(483,2247.0710,2042.7545,10.8158,88.5761,-1,-1,.world=world_dm); // [Camper]  bank carpark 2
	CreateVehicleEx(605,2234.6354,2046.5607,10.6488,89.2401,-1,-1,.world=world_dm); // [Sadler]  bank carpark 2
	CreateVehicleEx(604,2270.7805,2063.2558,10.5640,181.8196,-1,-1,.world=world_dm); // [Glendale]  bank carpark 2
	CreateVehicleEx(498,2236.8789,2007.5960,10.8878,357.9067,-1,-1,.world=world_dm); // [Boxville]  bank carpark 2
	CreateVehicleEx(580,2284.9643,2046.3032,10.6164,269.2958,-1,-1,.world=world_dm); // [Stafford]  bank carpark 2
	CreateVehicleEx(492,2297.0534,2042.4890,10.6021,269.8889,-1,-1,.world=world_dm); // [Greenwood]  bank carpark 2
	CreateVehicleEx(549,2300.3815,2063.5964,10.5252,179.9515,-1,-1,.world=world_dm); // [Tampa]  bank carpark 2
	CreateVehicleEx(521,2309.4978,2063.5876,10.3939,182.6878,-1,-1,.world=world_dm); // [FCR-900]  bank carpark 2
	CreateVehicleEx(567,1984.0034,2263.9443,26.8341,178.8786,-1,-1,.world=world_dm); // [Savanna]  Carpark near LVPD
	CreateVehicleEx(461,1990.8178,2265.8244,25.7853,182.7065,-1,-1,.world=world_dm); // [PCJ-600]  Carpark near LVPD
	CreateVehicleEx(507,1990.7947,2264.3120,19.4913,180.0996,-1,-1,.world=world_dm); // [Elegant]  Carpark near LVPD
	CreateVehicleEx(562,2015.9520,2255.4404,17.0246,90.2631,-1,-1,.world=world_dm); // [Elegy]  Carpark near LVPD
	CreateVehicleEx(586,2016.9631,2242.1796,16.8820,89.9616,-1,-1,.world=world_dm); // [Wayfarer]  Carpark near LVPD
	CreateVehicleEx(410,1978.7277,2247.3967,26.8471,270.3131,-1,-1,.world=world_dm); // [Manana]  Carpark near LVPD
	CreateVehicleEx(421,2015.4631,2257.9848,23.7965,270.7819,-1,-1,.world=world_dm); // [Washington]  Carpark near LVPD
	CreateVehicleEx(419,2015.8945,2247.2517,23.7114,270.8763,-1,-1,.world=world_dm); // [Esperanto]  Carpark near LVPD
	CreateVehicleEx(422,2015.6202,2242.2089,23.8974,269.6197,-1,-1,.world=world_dm); // [Bobcat]  Carpark near LVPD
	CreateVehicleEx(423,1961.6933,2263.3945,22.1802,1.0931,-1,-1,.world=world_dm); // [Mr Whoopee]  Carpark near LVPD
	CreateVehicleEx(424,1972.3559,2247.4157,20.7469,270.4902,-1,-1,.world=world_dm); // [BF Injection]  Carpark near LVPD
	CreateVehicleEx(429,1972.1822,2239.3320,14.1155,90.9030,-1,-1,.world=world_dm); // [Banshee]  Carpark near LVPD
	CreateVehicleEx(541,1964.4930,2263.6560,14.9145,0.8666,-1,-1,.world=world_dm); // [Bullet]  Carpark near LVPD
	CreateVehicleEx(436,1953.4588,2263.2919,16.2856,180.8914,-1,-1,.world=world_dm); // [Previon]  Carpark near LVPD
	CreateVehicleEx(489,1971.8256,2263.9768,14.6222,358.1333,-1,-1,.world=world_dm); // [Rancher]  Carpark near LVPD
	CreateVehicleEx(442,1993.3084,2264.2929,12.6690,0.4368,-1,-1,.world=world_dm); // [Romero]  Carpark near LVPD
	CreateVehicleEx(458,2005.0064,2263.6420,11.4121,179.8418,-1,-1,.world=world_dm); // [Solair]  Carpark near LVPD
	CreateVehicleEx(498,2062.6577,2238.2016,10.2434,89.9184,-1,-1,.world=world_dm); // [Boxville]  carpark next to lvpd fuck yaniv
	CreateVehicleEx(525,2047.4810,2207.6005,10.7062,0.1489,-1,-1,.world=world_dm); // [Tow Truck]  carpark next to lvpd fuck yaniv
	CreateVehicleEx(498,2063.2429,2251.1630,10.1954,88.7550,-1,-1,.world=world_dm); // [Boxville]  carpark next to lvpd fuck yaniv
	CreateVehicleEx(414,2063.1369,2264.6638,10.2294,87.7324,-1,-1,.world=world_dm); // [Mule]  carpark next to lvpd fuck yaniv
	CreateVehicleEx(443,2001.4624,2226.1491,25.6549,271.2511,-1,-1,.world=world_dm); // [Packer]  carpark next to lvpd fuck yaniv
	CreateVehicleEx(598,2255.9853,2442.2729,10.6361,357.8482,-1,-1,.world=world_dm); // [Police Car (LVPD)]  lvpd
	CreateVehicleEx(598,2273.4064,2459.2070,10.6354,178.9676,-1,-1,.world=world_dm); // [Police Car (LVPD)]  lvpd
	CreateVehicleEx(599,2251.7724,2459.6030,10.9379,0.4599,-1,-1,.world=world_dm); // [Police Ranger]  lvpd
	CreateVehicleEx(599,2278.0180,2477.4528,10.9324,183.4031,-1,-1,.world=world_dm); // [Police Ranger]  lvpd
	CreateVehicleEx(560,2259.5058,2430.8215,2.9619,0.3409,-1,-1,.world=world_dm); // [Sultan]  lvpd
	CreateVehicleEx(598,2240.0061,2461.6318,3.0831,269.1432,-1,-1,.world=world_dm); // [Police Car (LVPD)]  lvpd
	CreateVehicleEx(528,2290.5593,2430.5996,3.3162,359.5761,-1,-1,.world=world_dm); // [FBI Truck]  lvpd
	CreateVehicleEx(523,2282.3376,2441.4677,10.3918,356.9154,-1,-1,.world=world_dm); // [HPV1000]  LVPD
	CreateVehicleEx(523,2277.6711,2441.4287,10.3787,3.9776,-1,-1,.world=world_dm); // [HPV1000]  LVPD
	CreateVehicleEx(427,2315.0747,2475.1901,3.4051,89.9723,-1,-1,.world=world_dm); // [Enforcer]  LVPD
	CreateVehicleEx(427,2285.7416,2431.3544,3.4053,0.1923,-1,-1,.world=world_dm); // [Enforcer]  LVPD
	CreateVehicleEx(598,2297.7656,2460.2519,3.0647,270.1658,-1,-1,.world=world_dm); // [Police Car (LVPD)]  LVPD
	CreateVehicleEx(497,2279.4279,2445.3764,47.1617,87.6777,-1,-1,.world=world_dm); // [Police Maverick]  LVPD
	CreateVehicleEx(598,2256.3122,2477.3737,10.5643,0.3267,-1,-1,.world=world_dm); // [Police Car (LVPD)]  LVPD
	CreateVehicleEx(598,2282.3449,2477.5349,10.5670,1.3427,-1,-1,.world=world_dm); // [Police Car (LVPD)]  LVPD
	CreateVehicleEx(598,2285.7065,2474.4245,3.0192,179.6667,-1,-1,.world=world_dm); // [Police Car (LVPD)]  LVPD
	CreateVehicleEx(598,2239.9174,2476.0285,3.0205,90.3662,-1,-1,.world=world_dm); // [Police Car (LVPD)]  LVPD
	CreateVehicleEx(598,2240.0183,2452.0693,3.0198,90.4178,-1,-1,.world=world_dm); // [Police Car (LVPD)]  LVPD
	CreateVehicleEx(598,2303.5441,2430.7060,3.0194,181.8274,-1,-1,.world=world_dm); // [Police Car (LVPD)]  LVPD
	CreateVehicleEx(601,2272.7756,2431.1015,3.0322,1.4457,-1,-1,.world=world_dm); // [S.W.A.T. Van]  LVPD
	CreateVehicleEx(400,2057.2858,2479.6442,10.9126,179.8907,-1,-1,.world=world_dm); // [Landstalker]  behind LVPD parKINGlOT
	CreateVehicleEx(487,2093.8859,2415.2080,74.7390,270.0999,-1,-1,.world=world_dm); // [Maverick]  behind LVPD parKINGlOT
	CreateVehicleEx(482,2130.7939,2468.8081,10.9380,359.4774,-1,-1,.world=world_dm); // [Burrito]  behind LVPD parKINGlOT
	CreateVehicleEx(549,2153.5295,2505.7204,10.5104,89.6169,-1,-1,.world=world_dm); // [Tampa]  behind LVPD parKINGlOT
	CreateVehicleEx(498,2070.3015,2507.3288,10.8876,358.2591,-1,-1,.world=world_dm); // [Boxville]  behind LVPD parKINGlOT
	CreateVehicleEx(492,2195.5175,2502.9912,10.6054,359.6896,-1,-1,.world=world_dm); // [Greenwood]  behind LVPD parKINGlOT
	CreateVehicleEx(414,2201.0307,2529.1767,10.9103,179.8182,-1,-1,.world=world_dm); // [Mule]  behind LVPD parKINGlOT
	CreateVehicleEx(489,2069.7778,2479.7878,10.9640,359.7296,-1,-1,.world=world_dm); // [Rancher]  emerald isle
	CreateVehicleEx(415,2086.5383,2479.5021,10.5923,180.2941,-1,-1,.world=world_dm); // [Cheetah]  emerald isle
	CreateVehicleEx(467,2153.4916,2494.3327,10.5603,270.0349,-1,-1,.world=world_dm); // [Oceanic]  emerald isle
	CreateVehicleEx(560,2080.3430,2468.7651,10.5260,0.3956,-1,-1,.world=world_dm); // [Sultan]  emerald isle
	CreateVehicleEx(545,2046.4421,2469.0778,10.6313,2.5301,-1,-1,.world=world_dm); // [Hustler]  emerald isle
	CreateVehicleEx(551,2099.0341,2479.8864,10.6210,0.3789,-1,-1,.world=world_dm); // [Merit]  emerald isle
	CreateVehicleEx(517,2096.2231,2413.7443,40.7530,268.8773,-1,-1,.world=world_dm); // [Majestic]  emerald isle
	CreateVehicleEx(559,2068.8054,2395.8500,40.5959,91.3421,-1,-1,.world=world_dm); // [Jester]  emerald isle
	CreateVehicleEx(561,2068.0944,2419.4536,40.7354,269.3780,-1,-1,.world=world_dm); // [Stratum]  emerald isle
	CreateVehicleEx(566,2078.9211,2413.5974,40.7033,270.8692,-1,-1,.world=world_dm); // [Tahoma]  emerald isle
	CreateVehicleEx(562,2153.5688,2483.2080,10.4782,89.9719,-1,-1,.world=world_dm); // [Elegy]  Emerald Isle
	CreateVehicleEx(560,2068.8559,2419.4160,27.7292,269.4196,-1,-1,.world=world_dm); // [Sultan]  Emerald Isle
	CreateVehicleEx(481,2096.6774,2410.6049,27.5380,93.8135,-1,-1,.world=world_dm); // [BMX]  Emerald Isle
	CreateVehicleEx(463,2079.1535,2396.1845,27.5639,90.1782,-1,-1,.world=world_dm); // [Freeway]  Emerald Isle
	CreateVehicleEx(424,2103.7521,2419.4780,32.1013,270.3095,-1,-1,.world=world_dm); // [BF Injection]  Emerald Isle
	CreateVehicleEx(507,2087.5373,2401.8261,32.1446,270.9128,-1,-1,.world=world_dm); // [Elegant]  Emerald Isle
	CreateVehicleEx(549,2069.5639,2416.3564,32.0177,269.8491,-1,-1,.world=world_dm); // [Tampa]  Emerald Isle
	CreateVehicleEx(598,2069.5358,2395.7961,32.0717,270.9657,-1,-1,.world=world_dm); // [Police Car (LVPD)]  Emerald Isle
	CreateVehicleEx(451,2104.7695,2398.7561,36.3244,269.8439,-1,-1,.world=world_dm); // [Turismo]  Emerald Isle
	CreateVehicleEx(567,2095.4194,2416.6027,36.4850,91.9682,-1,-1,.world=world_dm); // [Savanna]  Emerald Isle
	CreateVehicleEx(555,2069.1159,2398.8198,36.3064,270.6672,-1,-1,.world=world_dm); // [Windsor]  Emerald Isle
	CreateVehicleEx(429,2104.9050,2395.9313,40.6015,269.7029,-1,-1,.world=world_dm); // [Banshee]  Emerald Isle
	CreateVehicleEx(404,2104.4997,2416.5314,44.9525,270.7529,-1,-1,.world=world_dm); // [Pereniel]  Emerald Isle
	CreateVehicleEx(405,2095.3195,2401.7209,45.0933,90.7527,-1,-1,.world=world_dm); // [Sentinel]  Emerald Isle
	CreateVehicleEx(576,2079.3789,2396.6489,44.8309,199.1748,-1,-1,.world=world_dm); // [Tornado]  Emerald Isle
	CreateVehicleEx(410,2104.5095,2398.8637,49.1344,269.4577,-1,-1,.world=world_dm); // [Manana]  Emerald Isle
	CreateVehicleEx(463,2096.5830,2411.0339,49.0497,92.2548,-1,-1,.world=world_dm); // [Freeway]  Emerald Isle
	CreateVehicleEx(401,2078.3879,2393.0080,49.2774,88.8533,-1,-1,.world=world_dm); // [Bravura]  Emerald Isle
	CreateVehicleEx(541,2069.2866,2413.6220,49.1490,268.4275,-1,-1,.world=world_dm); // [Bullet]  Emerald Isle
	CreateVehicleEx(559,2141.8505,2795.9191,10.4766,269.4914,-1,-1,.world=world_dm); // [Jester]  hotdog
	CreateVehicleEx(434,2168.1518,2787.3564,10.7935,180.2973,-1,-1,.world=world_dm); // [Hotknife]  hotdog
	CreateVehicleEx(588,2143.0217,2814.3015,10.7226,270.0627,-1,-1,.world=world_dm); // [Hotdog]  hotdog
	CreateVehicleEx(463,2168.2580,2720.8876,10.3588,90.3213,-1,-1,.world=world_dm); // [Freeway]  Hotdog
	CreateVehicleEx(410,2167.3195,2751.0366,10.4709,89.6621,-1,-1,.world=world_dm); // [Manana]  Hotdog
	CreateVehicleEx(498,2167.9218,2737.5764,10.8892,90.0546,-1,-1,.world=world_dm); // [Boxville]  hotuz
	CreateVehicleEx(400,2167.4501,2747.5261,10.9126,270.1825,-1,-1,.world=world_dm); // [Landstalker]  hotuz
	CreateVehicleEx(482,2102.0625,2742.5986,10.9382,269.5254,-1,-1,.world=world_dm); // [Burrito]  hotuz
	CreateVehicleEx(402,2404.4724,2556.8598,21.7068,270.8772,-1,-1,.world=world_dm); // [Buffalo]  Carpark near LVPD
	CreateVehicleEx(400,2421.5075,2546.5576,21.9436,358.3150,-1,-1,.world=world_dm); // [Landstalker]  Carpark near LVPD
	CreateVehicleEx(401,2449.7194,2530.6032,21.6850,180.6823,-1,-1,.world=world_dm); // [Bravura]  Carpark near LVPD
	CreateVehicleEx(404,2434.3859,2565.8591,21.5605,344.4503,-1,-1,.world=world_dm); // [Pereniel]  Carpark near LVPD
	CreateVehicleEx(405,2465.5629,2557.9143,21.6593,166.1863,-1,-1,.world=world_dm); // [Sentinel]  Carpark near LVPD
	CreateVehicleEx(410,2477.0156,2530.4919,21.4883,0.2587,-1,-1,.world=world_dm); // [Manana]  Carpark near LVPD
	CreateVehicleEx(411,2437.2851,2547.4724,21.5648,2.2535,-1,-1,.world=world_dm); // [Infernus]  Carpark near LVPD
	CreateVehicleEx(419,2506.8339,2536.2009,21.5720,90.0301,-1,-1,.world=world_dm); // [Esperanto]  Carpark near LVPD
	CreateVehicleEx(421,2530.2141,2520.8454,21.7487,269.4756,-1,-1,.world=world_dm); // [Washington]  Carpark near LVPD
	CreateVehicleEx(422,2485.3457,2509.6687,21.7876,91.3191,-1,-1,.world=world_dm); // [Bobcat]  Carpark near LVPD
	CreateVehicleEx(429,2529.9135,2491.5798,21.5726,270.7320,-1,-1,.world=world_dm); // [Banshee]  Carpark near LVPD
	CreateVehicleEx(436,2470.7338,2495.6655,21.6514,180.4238,-1,-1,.world=world_dm); // [Previon]  Carpark near LVPD
	CreateVehicleEx(434,2506.6042,2504.7204,21.8350,270.0747,-1,-1,.world=world_dm); // [Hotknife]  Carpark near LVPD
	CreateVehicleEx(440,2531.1030,2536.4069,10.9360,271.8427,-1,-1,.world=world_dm); // [Rumpo]  Carpark near LVPD
	CreateVehicleEx(439,2510.2041,2516.8549,10.7164,90.6848,-1,-1,.world=world_dm); // [Stallion]  Carpark near LVPD
	CreateVehicleEx(451,2530.4919,2521.1464,10.5266,90.9268,-1,-1,.world=world_dm); // [Turismo]  Carpark near LVPD
	CreateVehicleEx(458,2530.2438,2476.1975,10.6988,90.0534,-1,-1,.world=world_dm); // [Solair]  Carpark near LVPD
	CreateVehicleEx(478,2530.0478,2505.9216,10.8134,90.7081,-1,-1,.world=world_dm); // [Walton]  Carpark near LVPD
	CreateVehicleEx(405,2481.9760,2529.3117,10.7050,0.7692,-1,-1,.world=world_dm); // [Sentinel]  Carpark near LVPD
	CreateVehicleEx(404,2487.3603,2551.7009,10.5262,165.1698,-1,-1,.world=world_dm); // [Pereniel]  Carpark near LVPD
	CreateVehicleEx(410,2455.3969,2528.4072,10.4864,0.0927,-1,-1,.world=world_dm); // [Manana]  Carpark near LVPD
	CreateVehicleEx(462,2440.1381,2546.9658,10.4196,358.7679,-1,-1,.world=world_dm); // [Faggio]  Carpark near LVPD
	CreateVehicleEx(466,2444.8579,2548.3645,10.5408,359.3542,-1,-1,.world=world_dm); // [Glendale]  Carpark near LVPD
	CreateVehicleEx(477,2444.6896,2529.1523,10.5176,359.9013,-1,-1,.world=world_dm); // [ZR-350]  Carpark near LVPD
	CreateVehicleEx(479,2422.9243,2547.3781,10.5287,0.2783,-1,-1,.world=world_dm); // [Regina]  Carpark near LVPD
	CreateVehicleEx(480,2434.4816,2566.7299,10.5100,165.5014,-1,-1,.world=world_dm); // [Comet]  Carpark near LVPD
	CreateVehicleEx(480,2466.1232,2528.7749,10.5202,0.1227,-1,-1,.world=world_dm); // [Comet]  Carpark near LVPD
	CreateVehicleEx(496,2469.8691,2556.9758,10.5684,166.0059,-1,-1,.world=world_dm); // [Blista Compact]  Carpark near LVPD
	CreateVehicleEx(507,2461.1860,2559.7658,10.6463,165.9161,-1,-1,.world=world_dm); // [Elegant]  Carpark near LVPD
	CreateVehicleEx(517,2407.1298,2528.5900,10.6752,359.2808,-1,-1,.world=world_dm); // [Majestic]  Carpark near LVPD
	CreateVehicleEx(529,2402.8298,2556.6313,10.4529,270.5014,-1,-1,.world=world_dm); // [Willard]  Carpark near LVPD
	CreateVehicleEx(533,2402.7148,2547.2509,10.5293,269.5153,-1,-1,.world=world_dm); // [Feltzer]  Carpark near LVPD
	CreateVehicleEx(518,2417.7421,2528.4667,10.4910,359.3559,-1,-1,.world=world_dm); // [Buccaneer]  Carpark near LVPD
	CreateVehicleEx(463,2471.0209,2499.1445,10.3602,177.8071,-1,-1,.world=world_dm); // [Freeway]  Carpark near LVPD
	CreateVehicleEx(535,2509.6079,2493.7937,10.5844,270.7186,-1,-1,.world=world_dm); // [Slamvan]  Carpark near LVPD
	CreateVehicleEx(543,2530.5563,2496.5058,10.6401,90.0771,-1,-1,.world=world_dm); // [Sadler]  Carpark near LVPD
	CreateVehicleEx(463,2465.7971,2499.0361,10.3610,178.0864,-1,-1,.world=world_dm); // [Freeway]  Carpark near LVPD
	CreateVehicleEx(463,2421.4013,2571.8344,21.4164,161.0376,-1,-1,.world=world_dm); // [Freeway]  Carpark near LVPD
	CreateVehicleEx(463,2417.5891,2572.8750,21.4158,162.9795,-1,-1,.world=world_dm); // [Freeway]  Carpark near LVPD
	CreateVehicleEx(600,2403.9113,2566.3730,21.5826,270.4353,-1,-1,.world=world_dm); // [Picador]  Carpark near LVPD
	CreateVehicleEx(491,2370.7243,2577.8164,10.5765,180.3737,-1,-1,.world=world_dm); // [Virgo]  the well stacked pizza co
	CreateVehicleEx(492,2314.5468,2575.6940,10.6047,182.8724,-1,-1,.world=world_dm); // [Greenwood]  the well stacked pizza co
	CreateVehicleEx(496,2323.1582,2576.3879,10.5370,3.4250,-1,-1,.world=world_dm); // [Blista Compact]  the well stacked pizza co
	CreateVehicleEx(481,2366.1738,2579.5117,10.3312,180.9091,-1,-1,.world=world_dm); // [BMX]  The well stacked pizza co
	CreateVehicleEx(424,2348.7663,2578.6992,10.5927,180.9249,-1,-1,.world=world_dm); // [BF Injection]  the well stacked pizza co
	CreateVehicleEx(567,2336.1149,2577.9570,10.6811,184.4848,-1,-1,.world=world_dm); // [Savanna]  the well stacked pizza co
	CreateVehicleEx(498,2260.3666,2754.4938,10.8910,90.0562,-1,-1,.world=world_dm); // [Boxville]  carpark near mm
	CreateVehicleEx(524,2261.1921,2770.9062,11.7476,89.8178,-1,-1,.world=world_dm); // [Cement Truck]  carpark near mm
	CreateVehicleEx(530,2314.4211,2759.3510,10.5856,89.9882,-1,-1,.world=world_dm); // [Forklift]  carpark near mm
	CreateVehicleEx(530,2294.2619,2742.9792,10.5826,269.7041,-1,-1,.world=world_dm); // [Forklift]  carpark near mm
	CreateVehicleEx(530,2312.8806,2775.2678,10.5836,91.6764,-1,-1,.world=world_dm); // [Forklift]  carpark near mm
	CreateVehicleEx(403,2295.7031,2770.5075,11.4263,270.5855,-1,-1,.world=world_dm); // [Linerunner]  carpark near mm
	CreateVehicleEx(413,2311.4919,2754.4797,10.9054,90.0470,-1,-1,.world=world_dm); // [Pony]  carpark near mm
	CreateVehicleEx(582,2346.5004,2747.6757,10.8742,269.8399,-1,-1,.world=world_dm); // [Newsvan]  Carpark near MM
	CreateVehicleEx(582,2346.8557,2754.5261,10.8767,270.5261,-1,-1,.world=world_dm); // [Newsvan]  Carpark near MM
	CreateVehicleEx(582,2346.7131,2770.5183,10.8770,270.4762,-1,-1,.world=world_dm); // [Newsvan]  Carpark near MM
	CreateVehicleEx(525,2399.8425,2799.9570,10.6937,0.1600,-1,-1,.world=world_dm); // [Tow Truck]  Carpark near MM
	CreateVehicleEx(525,2400.0839,2756.0229,10.6969,180.9721,-1,-1,.world=world_dm); // [Tow Truck]  Carpark near MM
	CreateVehicleEx(575,1928.0606,2655.8562,10.4226,180.0139,-1,-1,.world=world_dm); // [Broadway]
	CreateVehicleEx(412,2063.2924,2655.1455,10.6607,179.4912,-1,-1,.world=world_dm); // [Voodoo]
	CreateVehicleEx(418,1926.9506,2731.0280,10.9103,358.1035,-1,-1,.world=world_dm); // [Moonbeam]
	CreateVehicleEx(400,2060.9599,2730.5732,10.9176,1.6794,-1,-1,.world=world_dm); // [Landstalker]
	CreateVehicleEx(500,1989.8830,2729.9550,10.9196,0.7976,-1,-1,.world=world_dm); // [Mesa]
	CreateVehicleEx(481,2050.2580,2759.9985,10.3325,180.1047,-1,-1,.world=world_dm); // [BMX]
	CreateVehicleEx(401,2029.7373,2755.9284,10.5975,178.7045,-1,-1,.world=world_dm); // [Bravura]
	CreateVehicleEx(402,1919.0826,2760.8649,10.6574,88.8041,-1,-1,.world=world_dm); // [Buffalo]
	CreateVehicleEx(575,1928.0606,2655.8562,10.4226,180.0139,-1,-1,.world=world_dm); // [Broadway]  lvstreet
	CreateVehicleEx(412,2063.2924,2655.1455,10.6607,179.4912,-1,-1,.world=world_dm); // [Voodoo]  lvstreet
	CreateVehicleEx(418,1926.9506,2731.0280,10.9103,358.1035,-1,-1,.world=world_dm); // [Moonbeam]  lvstreet
	CreateVehicleEx(400,2060.9599,2730.5732,10.9176,1.6794,-1,-1,.world=world_dm); // [Landstalker]  lvstreet
	CreateVehicleEx(500,1989.8830,2729.9550,10.9196,0.7976,-1,-1,.world=world_dm); // [Mesa]  lvstreet
	CreateVehicleEx(481,2050.2580,2759.9985,10.3325,180.1047,-1,-1,.world=world_dm); // [BMX]  lvstreet
	CreateVehicleEx(401,2029.7373,2755.9284,10.5975,178.7045,-1,-1,.world=world_dm); // [Bravura]  lvstreet
	CreateVehicleEx(402,1919.0826,2760.8649,10.6574,88.8041,-1,-1,.world=world_dm); // [Buffalo]  lvstreet
	CreateVehicleEx(401,1949.8239,2582.6291,10.6003,13.1484,-1,-1,.world=world_dm); // [Bravura]  Prickle Pine
	CreateVehicleEx(405,1935.8522,2579.6066,10.6952,11.8910,-1,-1,.world=world_dm); // [Sentinel]  Prickle Pine
	CreateVehicleEx(410,1944.6857,2599.3662,10.4735,177.0014,-1,-1,.world=world_dm); // [Manana]  Prickle Pine
	CreateVehicleEx(419,1884.0643,2592.5341,10.5411,359.5785,-1,-1,.world=world_dm); // [Esperanto]  Prickle Pine
	CreateVehicleEx(421,1928.3344,2599.7150,10.6873,180.5101,-1,-1,.world=world_dm); // [Washington]  Prickle Pine
	CreateVehicleEx(426,1863.9549,2593.4128,10.5537,359.5061,-1,-1,.world=world_dm); // [Premier]  Prickle Pine
	CreateVehicleEx(436,1856.3811,2627.3122,10.5851,358.3737,-1,-1,.world=world_dm); // [Previon]  Prickle Pine
	CreateVehicleEx(445,1830.0141,2638.6801,10.6954,178.9779,-1,-1,.world=world_dm); // [Admiral]  Prickle Pine
	CreateVehicleEx(461,1834.7756,2597.4963,10.4053,354.3881,-1,-1,.world=world_dm); // [PCJ-600]  Prickle Pine
	CreateVehicleEx(463,1840.1247,2607.0231,10.3616,176.2043,-1,-1,.world=world_dm); // [Freeway]  Prickle Pine
	CreateVehicleEx(466,1816.3398,2598.1718,10.5621,0.5243,-1,-1,.world=world_dm); // [Glendale]  Prickle Pine
	CreateVehicleEx(467,1845.6867,2641.2009,10.5603,178.5732,-1,-1,.world=world_dm); // [Oceanic]  Prickle Pine
	CreateVehicleEx(474,1815.0100,2640.0778,10.5784,179.2558,-1,-1,.world=world_dm); // [Hermes]  Prickle Pine
	CreateVehicleEx(547,1809.7469,2598.3913,10.5563,357.4411,-1,-1,.world=world_dm); // [Primo]  Prickle Pine
	CreateVehicleEx(463,1966.8096,2586.8054,10.3542,9.7745,-1,-1,.world=world_dm); // [Freeway]  Prickle Pine
	CreateVehicleEx(538,1464.0891,2632.2500,12.1256,270.0000,-1,-1,.world=world_dm); // [Streak]  Carpark near Train
	CreateVehicleEx(410,1291.3736,2644.3254,10.4801,359.5347,-1,-1,.world=world_dm); // [Manana]  Carpark near Train
	CreateVehicleEx(567,1319.3500,2644.4990,10.7007,0.6622,-1,-1,.world=world_dm); // [Savanna]  Carpark near Train
	CreateVehicleEx(541,1269.9338,2643.8898,10.4455,357.5324,-1,-1,.world=world_dm); // [Bullet]  Carpark near Train
	CreateVehicleEx(521,1264.7575,2698.6157,10.3901,180.0559,-1,-1,.world=world_dm); // [FCR-900]  Carpark near Train
	CreateVehicleEx(547,1285.8441,2697.5375,10.5555,179.5469,-1,-1,.world=world_dm); // [Primo]  Carpark near Train
	CreateVehicleEx(534,1330.2658,2644.2929,10.5425,359.9272,-1,-1,.world=world_dm); // [Remington]  Carpark near Train
	CreateVehicleEx(518,1302.2169,2697.1660,10.4901,180.5849,-1,-1,.world=world_dm); // [Buccaneer]  Carpark near Train
	CreateVehicleEx(480,1318.9139,2697.7163,10.5931,179.7701,-1,-1,.world=world_dm); // [Comet]  Carpark near Train
	CreateVehicleEx(533,1330.2153,2697.8408,10.5293,181.0237,-1,-1,.world=world_dm); // [Feltzer]  Carpark near Train
	CreateVehicleEx(439,1374.5455,2697.2192,10.7164,180.6730,-1,-1,.world=world_dm); // [Stallion]  Carpark near Train
	CreateVehicleEx(555,1341.2457,2698.2736,10.5041,180.6833,-1,-1,.world=world_dm); // [Windsor]  Carpark near Train
	CreateVehicleEx(412,1352.5473,2644.3796,10.6584,359.4198,-1,-1,.world=world_dm); // [Voodoo]  Carpark near Train
	CreateVehicleEx(535,1346.9290,2698.0830,10.5844,180.1582,-1,-1,.world=world_dm); // [Slamvan]  Carpark near Train
	CreateVehicleEx(536,1308.0869,2644.5996,10.5577,359.4321,-1,-1,.world=world_dm); // [Blade]  Carpark near Train
	CreateVehicleEx(560,1369.4755,2644.8325,10.5263,1.1535,-1,-1,.world=world_dm); // [Sultan]  Carpark near Train
	CreateVehicleEx(424,1339.4831,2760.6887,9.3342,35.1894,-1,-1,.world=world_dm); // [BF Injection]  Golf
	CreateVehicleEx(531,1215.9376,2752.4953,10.8416,95.5528,-1,-1,.world=world_dm); // [Tractor]  Golf
	CreateVehicleEx(457,1160.6917,2784.7341,10.4469,194.1252,-1,-1,.world=world_dm); // [Caddy]  Golf
	CreateVehicleEx(457,1218.0445,2823.0029,10.4579,296.4960,-1,-1,.world=world_dm); // [Caddy]  Golf
	CreateVehicleEx(457,1274.4257,2836.8813,10.4467,298.0598,-1,-1,.world=world_dm); // [Caddy]  Golf
	CreateVehicleEx(457,1333.1562,2852.2106,10.4202,273.4784,-1,-1,.world=world_dm); // [Caddy]  Golf
	CreateVehicleEx(457,1409.4770,2812.4758,10.4414,184.0368,-1,-1,.world=world_dm); // [Caddy]  Golf
	CreateVehicleEx(424,1382.1354,2754.4050,10.2759,226.9263,-1,-1,.world=world_dm); // [BF Injection]  Golf
	CreateVehicleEx(531,1417.5671,2746.2023,10.7874,87.0075,-1,-1,.world=world_dm); // [Tractor]  Golf
	CreateVehicleEx(589,1513.2833,2879.0969,10.4784,179.9259,-1,-1,.world=world_dm); // [Club]  Golf
	CreateVehicleEx(400,1529.1014,2840.7272,10.9127,89.4498,-1,-1,.world=world_dm); // [Landstalker]  Golf
	CreateVehicleEx(479,1489.3270,2837.9738,10.6154,181.1250,-1,-1,.world=world_dm); // [Regina]  Golf
	CreateVehicleEx(463,1529.5450,2822.8388,10.3629,91.6795,-1,-1,.world=world_dm); // [Freeway]  Golf
	CreateVehicleEx(461,1487.2076,2878.9980,10.4023,181.8337,-1,-1,.world=world_dm); // [PCJ-600]  Golf
	CreateVehicleEx(483,1460.4433,2878.6076,10.8129,179.3225,-1,-1,.world=world_dm); // [Camper]  Golf
	CreateVehicleEx(534,1460.4293,2848.8615,10.5462,179.1276,-1,-1,.world=world_dm); // [Remington]  Golf
	CreateVehicleEx(496,1442.2669,2878.8598,10.5339,179.9004,-1,-1,.world=world_dm); // [Blista Compact]  Golf
	CreateVehicleEx(410,1422.5312,2872.8168,10.4715,268.1997,-1,-1,.world=world_dm); // [Manana]  Golf
	CreateVehicleEx(491,1423.2111,2847.3925,10.5763,268.6159,-1,-1,.world=world_dm); // [Virgo]  Golf
	CreateVehicleEx(586,1423.0036,2825.9743,10.3423,267.2376,-1,-1,.world=world_dm); // [Wayfarer]  Golf
	CreateVehicleEx(413,1479.9754,2849.0822,10.9069,0.6486,-1,-1,.world=world_dm); // [Pony]  Golf
	CreateVehicleEx(409,1462.9321,2774.4775,10.5423,180.1808,-1,-1,.world=world_dm); // [Stretch]  Golf
	CreateVehicleEx(409,1502.6346,-1737.1835,13.2600,91.2580,-1,-1,.world=world_dm); // [Stretch]  Los Santos
	CreateVehicleEx(560,1524.6507,-1701.7958,13.1671,0.9215,-1,-1,.world=world_dm); // [Sultan]  Los Santos
	CreateVehicleEx(522,1470.1246,-1751.8594,15.0171,331.4252,-1,-1,.world=world_dm); // [NRG-500]  Los Santos
	CreateVehicleEx(522,1475.5068,-1751.9615,15.0179,327.7894,-1,-1,.world=world_dm); // [NRG-500]  Los Santos
	CreateVehicleEx(522,1481.5026,-1751.2657,15.0064,321.8547,-1,-1,.world=world_dm); // [NRG-500]  Los Santos
	CreateVehicleEx(522,1486.4663,-1751.2437,15.0175,334.8615,-1,-1,.world=world_dm); // [NRG-500]  Los Santos
	CreateVehicleEx(522,1492.3450,-1750.8043,15.0158,325.3218,-1,-1,.world=world_dm); // [NRG-500]  Los Santos
	CreateVehicleEx(429,1670.2901,-1715.9652,15.2890,359.7401,-1,-1,.world=world_dm); // [Banshee]  Some expensive shit near LS
	CreateVehicleEx(541,1666.5209,-1716.1174,15.2343,1.5143,-1,-1,.world=world_dm); // [Bullet]  Some expensive shit near LS
	CreateVehicleEx(480,1668.5712,-1694.1074,20.2431,268.8369,-1,-1,.world=world_dm); // [Comet]  Some expensive shit near LS
	CreateVehicleEx(415,1658.6499,-1719.0059,15.3799,90.7248,-1,-1,.world=world_dm); // [Cheetah]  Some expensive shit near LS
	CreateVehicleEx(409,1652.6762,-1693.9417,20.2496,268.2202,-1,-1,.world=world_dm); // [Stretch]  Some expensive shit near LS
	CreateVehicleEx(567,2506.8120,-1676.4316,13.3240,147.9375,-1,-1,.world=world_dm); // [Savanna] Los Santos
	CreateVehicleEx(567,2482.3269,-1684.2244,13.2844,267.9341,-1,-1,.world=world_dm); // [Savanna] Los Santos
	CreateVehicleEx(567,2482.6638,-1653.1589,13.2580,90.5576,-1,-1,.world=world_dm); // [Savanna] Los Santos
	CreateVehicleEx(412,1063.1511,-1752.0017,13.2847,269.8548,-1,-1,.world=world_dm); // [Voodoo] Los Santos
	CreateVehicleEx(412,1588.5369,-1405.1475,13.7020,271.7003,-1,-1,.world=world_dm); // [Voodoo] Los Santos
	CreateVehicleEx(402,1687.1752,-1797.7355,13.2145,0.2588,-1,-1,.world=world_dm); // [Buffalo] Los Santos
	CreateVehicleEx(402,1993.5871,-1275.1833,23.6518,179.3535,-1,-1,.world=world_dm); // [Buffalo] Los Santos
	CreateVehicleEx(405,1066.3450,-1196.2781,19.3320,1.5929,-1,-1,.world=world_dm); // [Sentinel] Los Santos
	CreateVehicleEx(405,1763.2784,-1860.1138,13.3654,90.5276,-1,-1,.world=world_dm); // [Sentinel] Los Santos
	CreateVehicleEx(426,1891.1905,-1937.4086,13.2021,267.0976,-1,-1,.world=world_dm); // [Premier] Los Santos
	CreateVehicleEx(426,1098.5692,-1763.8245,13.0931,90.2041,-1,-1,.world=world_dm); // [Premier] Los Santos
	CreateVehicleEx(473,963.8510,-1943.2963,-0.3065,205.7895,-1,-1,.world=world_dm); // [Dinghy] Los Santos
	CreateVehicleEx(473,962.4470,-1957.9884,-0.3769,123.5024,-1,-1,.world=world_dm); // [Dinghy] Los Santos
	CreateVehicleEx(473,961.0462,-1946.1010,-0.2929,112.4124,-1,-1,.world=world_dm); // [Dinghy] Los Santos
}
stock Cooldown_Add(playerid,idx,add)
{
	PlayerInfo[playerid][pPointsCooldown][idx] += add;
	new mx = -1, n[16];
	switch(idx)
	{
		case 0: mx = 35, n = "~p~stunt";
		case 1: mx = 30, n = "~g~drift";
		case 2: mx = 30, n = "~r~speed";
	}
	if(PlayerInfo[playerid][pPointsCooldown][idx] >= mx)
	{
		if(!PlayerInfo[playerid][pCooldownDelay][idx])
		{
			PlayerInfo[playerid][pCooldownDelay][idx] = true;
			SendClientMessage(playerid,red,frmt(" .שים לב: הגעת למגבלה של נקודות מסוג זה, עליך להמתין כ-%d שניות סה\"כ",PlayerInfo[playerid][pPointsCooldown][idx]));
		}
		ExpGameText(playerid,frmt("%s points cooldown: ~h~%d",n,PlayerInfo[playerid][pPointsCooldown][idx]));
	}
}
stock Cooldown_Dec(playerid)
{
	new cd = -1;
	for(new i = 0; i < 3; i++) if(PlayerInfo[playerid][pPointsCooldown][i] > 0)
	{
		PlayerInfo[playerid][pPointsCooldown][i]--;
		if(!PlayerInfo[playerid][pPointsCooldown][i]) cd = i;
	}
	if(cd != -1) if(PlayerInfo[playerid][pCooldownDelay][cd])
	{
		new n[16];
		switch(cd)
		{
			case 0: n = "~p~stunt";
			case 1: n = "~g~drift";
			case 2: n = "~r~speed";
		}
		ExpGameText(playerid,frmt("%s points cooldown finished",n));
		PlayerInfo[playerid][pCooldownDelay][cd] = false;
	}
}
stock SetInvisible(playerid,bool:invisible)
{
	new c = setAlpha(PlayerInfo[playerid][pColor],invisible ? 0 : PLAYER_ALPHA);
	Loop(i)
	{
		ShowPlayerNameTagForPlayer(i,playerid,_:(!invisible));
		SetPlayerMarkerForPlayer(i,playerid,c);
	}
}
stock IsPower(playerid) return ((equal(GetName(playerid),"(gmR)Yaniv") || equal(GetName(playerid),"(gmR)Amit")) && PlayerInfo[playerid][pLogged]);
stock Speedometer(playerid,func)
{
	if(func == 'c')
	{
		PlayerInfo[playerid][pSpeedoText][0] = CreatePlayerTextDraw(playerid,535.000000,376.000000, " ");
		PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][pSpeedoText][0],0);
	 	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][pSpeedoText][0],0x000000ff);
	  	PlayerTextDrawFont(playerid,PlayerInfo[playerid][pSpeedoText][0],1);
		PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][pSpeedoText][0],0.199999,0.899999);
		PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][pSpeedoText][0],1);
		PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][pSpeedoText][0],1);
	 	PlayerTextDrawColor(playerid,PlayerInfo[playerid][pSpeedoText][0],0xffff00ff);
		PlayerInfo[playerid][pSpeedoText][1] = CreatePlayerTextDraw(playerid,538.000000,397.000000,"_");
		PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][pSpeedoText][1],1);
		PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][pSpeedoText][1],0x00ff0066);
		PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][pSpeedoText][1],0);
		PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][pSpeedoText][1],0x000000ff);
		PlayerTextDrawFont(playerid,PlayerInfo[playerid][pSpeedoText][1],3);
		PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][pSpeedoText][1],9.100000,-0.000000);
		PlayerTextDrawColor(playerid,PlayerInfo[playerid][pSpeedoText][1],0xffffffff);
		PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][pSpeedoText][1],1);
		PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][pSpeedoText][1],1);
		PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][pSpeedoText][1],1);
		PlayerInfo[playerid][pSpeedoText][2] = CreatePlayerTextDraw(playerid,538.000000,420.000000,"_");
		PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][pSpeedoText][2],1);
		PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][pSpeedoText][2],0xff000066);
		PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][pSpeedoText][2],0);
		PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][pSpeedoText][2],0x000000ff);
		PlayerTextDrawFont(playerid,PlayerInfo[playerid][pSpeedoText][2],3);
		PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][pSpeedoText][2],1.000000,-0.000000);
		PlayerTextDrawColor(playerid,PlayerInfo[playerid][pSpeedoText][2],0xffffffff);
		PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][pSpeedoText][2],1);
		PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][pSpeedoText][2],1);
		PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][pSpeedoText][2],1);
	}
	else if(func == 'd')
	{
		for(new i = 0; i < sizeof(speedotext); i++)
		{
			TextDrawHideForPlayer(playerid,speedotext[i]);
			if(i < 3) PlayerTextDrawDestroy(playerid,PlayerInfo[playerid][pSpeedoText][i]);
		}
	}
	else if(func == 'h')
	{
		for(new i = 0; i < sizeof(speedotext); i++)
		{
			TextDrawHideForPlayer(playerid,speedotext[i]);
			if(i < 3) PlayerTextDrawHide(playerid,PlayerInfo[playerid][pSpeedoText][i]);
		}
	}
	else if(func == 'u')
	{
		new txt[128], Float:hp, v = GetPlayerVehicleID(playerid), Float:p[3];
		GetVehicleHealth(v,hp);
		GetPlayerPos(playerid,p[0],p[1],p[2]);
		//KMH = floatsqroot(floatpower(floatabs(floatsub(Xa,Xb[i])),2)+floatpower(floatabs(floatsub(Ya,Yb[i])),2)+floatpower(floatabs(floatsub(Za,Zb[i])),2));
		//KMH *= 14.2;
		format(txt,sizeof(txt),"~b~~h~~h~Name: ~w~%s~n~~g~~h~Speed: ~w~%0.0f km/h~n~~n~~y~~h~Height: ~w~%.1f m~n~~r~~h~Health: ~w~%03d%c",VehicleName(GetVehicleModel(v)),PlayerInfo[playerid][pSpeed][0],p[2],floatround(hp) / 10,'%');
		PlayerTextDrawSetString(playerid,PlayerInfo[playerid][pSpeedoText][0],txt);
		PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][pSpeedoText][1],PlayerInfo[playerid][pSpeed][0] > 250.0 ? 603.0 : floatadd(534.0,floatdiv(PlayerInfo[playerid][pSpeed][0],3.9)),0.0);
		if(hp < 0.0) PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][pSpeedoText][2],538.000000,0.000000);
		else if(hp >= 1000.0) PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][pSpeedoText][2],603.000000,0.000000);
		else PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][pSpeedoText][2],floatadd(534.0,floatdiv(hp,14.600000)),0.000000);
		for(new i = 0; i < sizeof(speedotext); i++)
		{
			TextDrawShowForPlayer(playerid,speedotext[i]);
			if(i < 3) PlayerTextDrawShow(playerid,PlayerInfo[playerid][pSpeedoText][i]);
		}
	}
}
stock GetDefaultLevel(exp)
{
	new lvl = -1;
	for(new i = 0; i < sizeof(Levels); i++) if(exp >= Levels[i][lvlExp]) lvl = i;
	return lvl;
}
stock IntToHex(num)
{
	new ret[4];
	switch(num)
	{
		case 0: ret = "00";
		case 1: ret = "01";
		case 2: ret = "02";
		case 3: ret = "03";
		case 4: ret = "04";
		case 5: ret = "05";
		case 6: ret = "06";
		case 7: ret = "07";
		case 8: ret = "08";
		case 9: ret = "09";
		case 10: ret = "0A";
		case 11: ret = "0B";
		case 12: ret = "0C";
		case 13: ret = "0D";
		case 14: ret = "0E";
		case 15: ret = "0F";
		case 16: ret = "10";
		case 17: ret = "11";
		case 18: ret = "12";
		case 19: ret = "13";
		case 20: ret = "14";
		case 21: ret = "15";
		case 22: ret = "16";
		case 23: ret = "17";
		case 24: ret = "18";
		case 25: ret = "19";
		case 26: ret = "1A";
		case 27: ret = "1B";
		case 28: ret = "1C";
		case 29: ret = "1D";
		case 30: ret = "1E";
		case 31: ret = "1F";
		case 32: ret = "20";
		case 33: ret = "21";
		case 34: ret = "22";
		case 35: ret = "23";
		case 36: ret = "24";
		case 37: ret = "25";
		case 38: ret = "26";
		case 39: ret = "27";
		case 40: ret = "28";
		case 41: ret = "29";
		case 42: ret = "2A";
		case 43: ret = "2B";
		case 44: ret = "2C";
		case 45: ret = "2D";
		case 46: ret = "2E";
		case 47: ret = "2F";
		case 48: ret = "30";
		case 49: ret = "31";
		case 50: ret = "32";
		case 51: ret = "33";
		case 52: ret = "34";
		case 53: ret = "35";
		case 54: ret = "36";
		case 55: ret = "37";
		case 56: ret = "38";
		case 57: ret = "39";
		case 58: ret = "3A";
		case 59: ret = "3B";
		case 60: ret = "3C";
		case 61: ret = "3D";
		case 62: ret = "3E";
		case 63: ret = "3F";
		case 64: ret = "40";
		case 65: ret = "41";
		case 66: ret = "42";
		case 67: ret = "43";
		case 68: ret = "44";
		case 69: ret = "45";
		case 70: ret = "46";
		case 71: ret = "47";
		case 72: ret = "48";
		case 73: ret = "49";
		case 74: ret = "4A";
		case 75: ret = "4B";
		case 76: ret = "4C";
		case 77: ret = "4D";
		case 78: ret = "4E";
		case 79: ret = "4F";
		case 80: ret = "50";
		case 81: ret = "51";
		case 82: ret = "52";
		case 83: ret = "53";
		case 84: ret = "54";
		case 85: ret = "55";
		case 86: ret = "56";
		case 87: ret = "57";
		case 88: ret = "58";
		case 89: ret = "59";
		case 90: ret = "5A";
		case 91: ret = "5B";
		case 92: ret = "5C";
		case 93: ret = "5D";
		case 94: ret = "5E";
		case 95: ret = "5F";
		case 96: ret = "60";
		case 97: ret = "61";
		case 98: ret = "62";
		case 99: ret = "63";
		case 100: ret = "64";
		case 101: ret = "65";
		case 102: ret = "66";
		case 103: ret = "67";
		case 104: ret = "68";
		case 105: ret = "69";
		case 106: ret = "6A";
		case 107: ret = "6B";
		case 108: ret = "6C";
		case 109: ret = "6D";
		case 110: ret = "6E";
		case 111: ret = "6F";
		case 112: ret = "70";
		case 113: ret = "71";
		case 114: ret = "72";
		case 115: ret = "73";
		case 116: ret = "74";
		case 117: ret = "75";
		case 118: ret = "76";
		case 119: ret = "77";
		case 120: ret = "78";
		case 121: ret = "79";
		case 122: ret = "7A";
		case 123: ret = "7B";
		case 124: ret = "7C";
		case 125: ret = "7D";
		case 126: ret = "7E";
		case 127: ret = "7F";
		case 128: ret = "80";
		case 129: ret = "81";
		case 130: ret = "82";
		case 131: ret = "83";
		case 132: ret = "84";
		case 133: ret = "85";
		case 134: ret = "86";
		case 135: ret = "87";
		case 136: ret = "88";
		case 137: ret = "89";
		case 138: ret = "8A";
		case 139: ret = "8B";
		case 140: ret = "8C";
		case 141: ret = "8D";
		case 142: ret = "8E";
		case 143: ret = "8F";
		case 144: ret = "90";
		case 145: ret = "91";
		case 146: ret = "92";
		case 147: ret = "93";
		case 148: ret = "94";
		case 149: ret = "95";
		case 150: ret = "96";
		case 151: ret = "97";
		case 152: ret = "98";
		case 153: ret = "99";
		case 154: ret = "9A";
		case 155: ret = "9B";
		case 156: ret = "9C";
		case 157: ret = "9D";
		case 158: ret = "9E";
		case 159: ret = "9F";
		case 160: ret = "A0";
		case 161: ret = "A1";
		case 162: ret = "A2";
		case 163: ret = "A3";
		case 164: ret = "A4";
		case 165: ret = "A5";
		case 166: ret = "A6";
		case 167: ret = "A7";
		case 168: ret = "A8";
		case 169: ret = "A9";
		case 170: ret = "AA";
		case 171: ret = "AB";
		case 172: ret = "AC";
		case 173: ret = "AD";
		case 174: ret = "AE";
		case 175: ret = "AF";
		case 176: ret = "B0";
		case 177: ret = "B1";
		case 178: ret = "B2";
		case 179: ret = "B3";
		case 180: ret = "B4";
		case 181: ret = "B5";
		case 182: ret = "B6";
		case 183: ret = "B7";
		case 184: ret = "B8";
		case 185: ret = "B9";
		case 186: ret = "BA";
		case 187: ret = "BB";
		case 188: ret = "BC";
		case 189: ret = "BD";
		case 190: ret = "BE";
		case 191: ret = "BF";
		case 192: ret = "C0";
		case 193: ret = "C1";
		case 194: ret = "C2";
		case 195: ret = "C3";
		case 196: ret = "C4";
		case 197: ret = "C5";
		case 198: ret = "C6";
		case 199: ret = "C7";
		case 200: ret = "C8";
		case 201: ret = "C9";
		case 202: ret = "CA";
		case 203: ret = "CB";
		case 204: ret = "CC";
		case 205: ret = "CD";
		case 206: ret = "CE";
		case 207: ret = "CF";
		case 208: ret = "D0";
		case 209: ret = "D1";
		case 210: ret = "D2";
		case 211: ret = "D3";
		case 212: ret = "D4";
		case 213: ret = "D5";
		case 214: ret = "D6";
		case 215: ret = "D7";
		case 216: ret = "D8";
		case 217: ret = "D9";
		case 218: ret = "DA";
		case 219: ret = "DB";
		case 220: ret = "DC";
		case 221: ret = "DD";
		case 222: ret = "DE";
		case 223: ret = "DF";
		case 224: ret = "E0";
		case 225: ret = "E1";
		case 226: ret = "E2";
		case 227: ret = "E3";
		case 228: ret = "E4";
		case 229: ret = "E5";
		case 230: ret = "E6";
		case 231: ret = "E7";
		case 232: ret = "E8";
		case 233: ret = "E9";
		case 234: ret = "EA";
		case 235: ret = "EB";
		case 236: ret = "EC";
		case 237: ret = "ED";
		case 238: ret = "EE";
		case 239: ret = "EF";
		case 240: ret = "F0";
		case 241: ret = "F1";
		case 242: ret = "F2";
		case 243: ret = "F3";
		case 244: ret = "F4";
		case 245: ret = "F5";
		case 246: ret = "F6";
		case 247: ret = "F7";
		case 248: ret = "F8";
		case 249: ret = "F9";
		case 250: ret = "FA";
		case 251: ret = "FB";
		case 252: ret = "FC";
		case 253: ret = "FD";
		case 254: ret = "FE";
		case 255: ret = "FF";
	}
	return ret;
}
stock HexStringOfColor(c)
{
	new hexcolor[8];
	format(hexcolor,sizeof(hexcolor),"%s%s%s",IntToHex(getRed(c)),IntToHex(getGreen(c)),IntToHex(getBlue(c)));
	return hexcolor;
}
stock Channel(playerid,channel,opt,v=INVALID_VEHICLE_ID)
{
	if(!IsPlayerInAnyVehicle(playerid)) return;
	if(v == INVALID_VEHICLE_ID) v = GetPlayerVehicleID(playerid);
	new bool:toggleOption = false;
	switch(channel)
	{
		case 0: // צבע מתחלף
		{
			switch(opt)
			{
				case 'i': if(PlayerInfo[playerid][pChannelToggle]) ChangeVehicleColor(v,random(127),random(127));
				case 'y': toggleOption = true;
			}
		}
		case 1: // היפוך בלחיצה
		{
			switch(opt)
			{
				case 'y': FlipCar(v);
			}
		}
		case 2: // קפיצה לגובה
		{
			switch(opt)
			{
				case 'y':
				{
					new Float:vel[3];
					GetVehicleVelocity(v,vel[0],vel[1],vel[2]);
					SetVehicleVelocity(v,vel[0],vel[1],vel[2]+2.0);
				}
			}
		}
		case 3: // קפיצה לרוחק
		{
			switch(opt)
			{
				case 'y': SetVehicleForwardVelocity(v,1.2,1.2);
			}
		}
		case 4: // ניטרו אינסופי
		{
			switch(opt)
			{
				case 's': UpdateNitro(v);
				case 'e':
				{
					new got = GetVehicleComponentInSlot(v,5);
					if(got >= 1008 && got <= 1010) RemoveVehicleComponent(v,got);
				}
				case 'y':
				{
					UpdateNitro(v);
					PlaySound(playerid,1133);
				}
			}
		}
		case 5: // היפוך אוטומטי
		{
			switch(opt)
			{
				case 'i': if(PlayerInfo[playerid][pChannelToggle]) if(IsVehicleUpsideDown(v)) FlipCar(v);
				case 'y': toggleOption = true;
			}
		}
		case 6: // אי נפילה מאופנוע
		{
			switch(opt)
			{
				case 'y': toggleOption = true;
			}
		}
		case 7: // רמפה בלחיצה
		{
			switch(opt)
			{
				case 'y': if(PlayerInfo[playerid][pChannelRampa][0] == -1 && !PlayerInfo[playerid][pChannelRampa][1])
				{
					new Float:p[4], ramp[] = {1655,1632,1631};
					GetVehiclePos(v,p[0],p[1],p[2]);
					GetVehicleZAngle(v,p[3]);
					GetXYInFrontOfVehicle(v,p[0],p[1],16.0);
					PlayerInfo[playerid][pChannelRampa][0] = CreatePlayerObject(playerid,ramp[random(sizeof(ramp))],p[0],p[1],p[2],0.0,0.0,p[3],100.0);
					PlayerInfo[playerid][pChannelRampa][1] = 3;
				}
			}
		}
		case 8: // מהירות רכב
		{
			switch(opt)
			{
				case 'y': if(GetVehicleType(v) <= 1)
				{
					new Float:p[3];
					const Float:speedMul = 1.35, Float:speedMax = 2.5;
					GetVehicleVelocity(v,p[0],p[1],p[2]);
					if(p[0] * speedMul >= -speedMax && p[0] * speedMul <= speedMax && p[1] * speedMul >= -speedMax && p[1] * speedMul <= speedMax) AddPlayerVelocity(playerid,speedMul,speedMul,1.0);
				}
			}
		}
		case 9: // רכב משוריין
		{
			switch(opt)
			{
				case 's': SetVehicleHealth(v,10000.0);
				case 'e':
				{
					new Float:hp;
					GetVehicleHealth(v,hp);
					if(hp > 1000.0) SetVehicleHealth(v,1000.0);
				}
			}
		}
		case 10: // גודמוד לרכב
		{
			switch(opt)
			{
				case 's':
				{
					SetVehicleHealth(v,10000.0);
					RepairVehicle(v);
				}
				case 'e':
				{
					new Float:hp;
					GetVehicleHealth(v,hp);
					if(hp > 1000.0) SetVehicleHealth(v,1000.0);
				}
				case 'i':
				{
					if(PlayerInfo[playerid][pChannelToggle])
					{
						SetVehicleHealth(v,10000.0);
						RepairVehicle(v);
					}
					else
					{
						new Float:hp;
						GetVehicleHealth(v,hp);
						if(hp > 1000.0) SetVehicleHealth(v,1000.0);
					}
				}
				case 'y': toggleOption = true;
			}
		}
	}
	if(toggleOption)
	{
		PlayerInfo[playerid][pChannelToggle] = !PlayerInfo[playerid][pChannelToggle];
		SendFormat(playerid,PlayerInfo[playerid][pChannelToggle] ? green : red," * \"%s את השימוש במצב הרכב \"%s",PlayerInfo[playerid][pChannelToggle] ? ("הפעלת") : ("ביטלת"),Channels[channel][chName]);
	}
	if(opt == 's')
	{
		new string[128];
		for(new i = 0; i < 3; i++) if(Channels[channel][chPointsBlock][i]) switch(i)
		{
			case 0: format(string,sizeof(string),"%s%sStunt Points",!strlen(string) ? ("") : (", "),string);
			case 1: format(string,sizeof(string),"%s%sDrift Points",!strlen(string) ? ("") : (", "),string);
			case 2: format(string,sizeof(string),"%s%sSpeed Points",!strlen(string) ? ("") : (", "),string);
		}
		if(strlen(string) > 0) SendFormat(playerid,red," %s :מ EXP שים לב, שימוש במצב זה לא יאפשר לך לקבל",string);
	}
}
stock FlipCar(v)
{
	new Float:ang;
	GetVehicleZAngle(v,ang);
	SetVehicleZAngle(v,ang);
}
stock GetVehicleType(vid,mod=0)
{   // by yellowblood, improved by me
	switch(mod ? vid : GetVehicleModel(vid))
	{
		case
		596,   //copcarla,   //car
		599,   //copcarru,   //car
		597,   //copcarsf,   //car
		416,   //ambulan  -  car
		445,   //admiral  -  car
		602,   //alpha  -  car
		485,   //baggage  -  car
		568,   //bandito  -  car
		429,   //banshee  -  car
		499,   //benson  -  car
		424,   //bfinject,   //car
		536,   //blade  -  car
		496,   //blistac  -  car
		504,   //bloodra  -  car
		422,   //bobcat  -  car
		609,   //boxburg  -  car
		498,   //boxville,   //car
		401,   //bravura  -  car
		575,   //broadway,   //car
		518,   //buccanee,   //car
		402,   //buffalo  -  car
		541,   //bullet  -  car
		482,   //burrito  -  car
		431,   //bus  -  car
		438,   //cabbie  -  car
		457,   //caddy  -  car
		527,   //cadrona  -  car
		483,   //camper  -  car
		524,   //cement  -  car
		415,   //cheetah  -  car
		542,   //clover  -  car
		589,   //club  -  car
		480,   //comet  -  car
		578,   //dft30  -  car
		486,   //dozer  -  car
		507,   //elegant  -  car
		562,   //elegy  -  car
		585,   //emperor  -  car
		427,   //enforcer,   //car
		419,   //esperant,   //car
		587,   //euros  -  car
		490,   //fbiranch,   //car
		528,   //fbitruck,   //car
		533,   //feltzer  -  car
		544,   //firela  -  car
		407,   //firetruk,   //car
		565,   //flash  -  car
		455,   //flatbed  -  car
		530,   //forklift,   //car
		526,   //fortune  -  car
		466,   //glendale,   //car
		604,   //glenshit,   //car
		492,   //greenwoo,   //car
		474,   //hermes  -  car
		434,   //hotknife,   //car
		502,   //hotrina  -  car
		503,   //hotrinb  -  car
		494,   //hotring  -  car
		579,   //huntley  -  car
		545,   //hustler  -  car
		411,   //infernus,   //car
		546,   //intruder,   //car
		559,   //jester  -  car
		508,   //journey  -  car
		571,   //kart  -  car
		400,   //landstal,   //car
		403,   //linerun  -  car
		517,   //majestic,   //car
		410,   //manana  -  car
		551,   //merit  -  car
		500,   //mesa  -  car
		418,   //moonbeam,   //car
		572,   //mower  -  car
		423,   //mrwhoop  -  car
		516,   //nebula  -  car
		582,   //newsvan  -  car
		467,   //oceanic  -  car
		404,   //peren  -  car
		514,   //petro  -  car
		603,   //phoenix  -  car
		600,   //picador  -  car
		413,   //pony  -  car
		426,   //premier  -  car
		436,   //previon  -  car
		547,   //primo  -  car
		489,   //rancher  -  car
		441,   //rcbandit,   //car
		594,   //rccam  -  car
		564,   //rctiger  -  car
		515,   //rdtrain  -  car
		479,   //regina  -  car
		534,   //remingtn,   //car
		505,   //rnchlure,   //car
		442,   //romero  -  car
		440,   //rumpo  -  car
		475,   //sabre  -  car
		543,   //sadler  -  car
		605,   //sadlshit,   //car
		495,   //sandking,   //car
		567,   //savanna  -  car
		428,   //securica,   //car
		405,   //sentinel,   //car
		535,   //slamvan  -  car
		458,   //solair  -  car
		580,   //stafford,   //car
		439,   //stallion,   //car
		561,   //stratum  -  car
		409,   //stretch  -  car
		560,   //sultan  -  car
		550,   //sunrise  -  car
		506,   //supergt  -  car
		574,   //sweeper  -  car
		566,   //tahoma  -  car
		549,   //tampa  -  car
		420,   //taxi  -  car
		459,   //topfun  -  car
		576,   //tornado  -  car
		583,   //tug  -  car
		451,   //turismo  -  car
		558,   //uranus  -  car
		552,   //utility  -  car
		540,   //vincent  -  car
		491,   //virgo  -  car
		412,   //voodoo  -  car
		478,   //walton  -  car
		421,   //washing  -  car
		529,   //willard  -  car
		555,   //windsor  -  car
		456,   //yankee  -  car
		554,   //yosemite,   //car
		477,   //zr3	50  -  car
		588,   //hotdog  -  car
		437,   //coach  -  car
		532,   //combine  -  car
		433,   //barracks,   //car
		414,   //mule  -  car
		443,   //packer  -  car
		470,   //patriot  -  car
		432,   //rhino  -  car
		525,   //towtruck,   //car
		531,   //tractor  -  car
		408,   //trash  -  car
		406,   //dumper  -  mtruck
		573,   //duneride,   //mtruck
		444,   //monster  -  mtruck
		556,   //monstera,   //mtruck
		557	//monsterb,   //mtruck
		: return 0;
		case
		581,   //bf400  -  bike
		523,   //copbike  -  bike
		462,   //faggio  -  bike
		521,   //fcr900  -  bike
		463,   //freeway  -  bike
		522,   //nrg500  -  bike
		461,   //pcj600  -  bike
		448,   //pizzaboy,   //bike
		468,   //sanchez  -  bike
		586,   //wayfarer,   //bike
		509,   //bike  -  bmx
		481,   //bmx  -  bmx
		510,   //mtbike  -  bmx
		471   //quad  -  quad
		: return 1;
		case
		472,   //coastg  -  boat
		473,   //dinghy  -  boat
		493,   //jetmax  -  boat
		595,   //launch  -  boat
		484,   //marquis  -  boat
		430,   //predator,   //boat
		453,   //reefer  -  boat
		452,   //speeder  -  boat
		446,   //squalo  -  boat
		454   //tropic  -  boat
		: return 2;
		case
		548,   //cargobob,   //heli
		425,   //hunter  -  heli
		417,   //leviathn,   //heli
		487,   //maverick,   //heli
		497,   //polmav  -  heli
		563,   //raindanc,   //heli
		501,   //rcgoblin,   //heli
		465,   //rcraider,   //heli
		447,   //seaspar  -  heli
		469,   //sparrow  -  heli
		488	   //vcnmav  -  heli
		: return 3;
		case
		592,   //androm  -  plane
		577,   //at	400  -  plane
		511,   //beagle  -  plane
		512,   //cropdust,   //plane
		593,   //dodo  -  plane
		520,   //hydra  -  plane
		553,   //nevada  -  plane
		464,   //rcbaron  -  plane
		476,   //rustler  -  plane
		519,   //shamal  -  plane
		460,   //skimmer  -  plane
		513,   //stunt  -  plane
		539   //vortex  -  plane
		: return 4;
		case
		435,   //artict1  -  trailer
		450,   //artict2  -  trailer
		591,   //artict3  -  trailer
		606,   //bagboxa  -  trailer
		607,   //bagboxb  -  trailer
		610,   //farmtr1  -  trailer
		584,   //petrotr  -  trailer
		608,   //tugstair,   //trailer
		611,   //utiltr1  -  trailer
		590,   //freibox  -  train
		569,   //freiflat,   //train
		537,   //freight  -  train
		538,   //streak  -  train
		570,   //streakc  -  train
		449   //tram  -  train
		: return 5;
	}
	return -1;
}
stock SetVehicleForwardVelocity(vehicleid,Float:Velocity,Float:Z)
{
	new Float:Angle, Float:SpeedX, Float:SpeedY;
	GetVehicleZAngle(vehicleid, Angle);
	SpeedX = floatsin(-Angle,degrees);
	SpeedY = floatcos(-Angle,degrees);
	SetVehicleVelocity(vehicleid,floatmul(Velocity, SpeedX),floatmul(Velocity,SpeedY),Z);
}
stock UpdateNitro(v)
{
	new got = GetVehicleComponentInSlot(v,5);
	if(got >= 1008 && got <= 1010) RemoveVehicleComponent(v,got);
	AddVehicleComponent(v,1010);
	return 1;
}
stock IsVehicleUpsideDown(vehicleid)
{
	new Float:quat_w,Float:quat_x,Float:quat_y,Float:quat_z;
	GetVehicleRotationQuat(vehicleid,quat_w,quat_x,quat_y,quat_z);
	new Float:y = atan2(2*((quat_y*quat_z)+(quat_w*quat_x)),(quat_w*quat_w)-(quat_x*quat_x)-(quat_y*quat_y)+(quat_z*quat_z));
	return (y > 90 || y < -90);
}
stock AddPlayerVelocity(playerid, Float:addx, Float:addy, Float:addz)
{
	new Float:p[3];
	if(IsPlayerInAnyVehicle(playerid))
	{
		new v = GetPlayerVehicleID(playerid);
		GetVehicleVelocity(v,p[0],p[1],p[2]);
		SetVehicleVelocity(v,p[0] * addx,p[1] * addy,p[2] * addz);
	}
	else
	{
		GetPlayerVelocity(playerid,p[0],p[1],p[2]);
		SetPlayerVelocity(playerid,p[0] * addx,p[1] * addy,p[2] * addz);
	}
	return 1;
}
stock IsBlockedByChannel(playerid,pointtype)
{
	if(PlayerInfo[playerid][pChannel] != -1) return Channels[PlayerInfo[playerid][pChannel]][chPointsBlock][pointtype];
	return 0;
}
stock ResetSkin(playerid)
{
	new removed = 0;
	for(new j = aoslot_skin; j <= aoslot_skin+4; j++) if(IsPlayerAttachedObjectSlotUsed(playerid,j))
	{
		RemovePlayerAttachedObject(playerid,j);
		removed++;
	}
	return removed;
}
/*
  _     _
/  \   / \
|   \/    |
\        /
 \  DAN /
  \    /
   \  /
	\/
H r H o CCCCC
H   H   C
HHHHH   C
H t H e C m
H   H   CCCCC
*/
#define Yaniv 	\
 ___     ___	\
/   \   /   \	\
|    \ /    |	\
\          /	\
 \  Yaniv /		\
  \      /		\
   \    /		\
    \  /		\
	 \/
/*
donators/vip

activities

refer a friend

add:
psarray fucked up
/trade

Updates:
save last money
lv vehicles
old dm hqs
tips
*/
